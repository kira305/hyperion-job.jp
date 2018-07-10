<?php

/*
 * This file is part of EC-CUBE
 *
 * Copyright(c) 2000-2012 LOCKON CO.,LTD. All Rights Reserved.
 *
 * http://www.lockon.co.jp/
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

// {{{ requires
require_once CLASS_EX_REALDIR . 'page_extends/LC_Page_Ex.php';

/**
 * お届け先の指定 のページクラス.
 *
 * @package Page
 * @author LOCKON CO.,LTD.
 * @version $Id: LC_Page_Shopping_Deliv.php 21951 2012-07-02 12:04:24Z pineray $
 */
class LC_Page_Shopping_Deliv extends LC_Page_Ex {
    // }}}
    // {{{ functions

    /**
     * Page を初期化する.
     *
     * @return void
     */
    function init() {
        parent::init();
        $masterData = new SC_DB_MasterData_Ex();
        $this->arrPref = $masterData->getMasterData('mtb_pref');
        $this->tpl_title = 'お届け先の指定';
        $this->httpCacheControl('nocache');
    }

    /**
     * Page のプロセス.
     *
     * @return void
     */
    function process() {
        parent::process();
        $this->action();
        $this->sendResponse();
    }

    /**
     * Page のプロセス.
     *
     * @return void
     */
    function action() {

        $objSiteSess = new SC_SiteSession_Ex();
        $objCartSess = new SC_CartSession_Ex();
        $objCustomer = new SC_Customer_Ex();
        $objPurchase = new SC_Helper_Purchase_Ex();
        $objFormParam = new SC_FormParam_Ex();

        $this->tpl_uniqid = $objSiteSess->getUniqId();
        $objPurchase->verifyChangeCart($this->tpl_uniqid, $objCartSess);

        $this->cartKey = $objCartSess->getKey();

        // ログインチェック
        if (!$objCustomer->isLoginSuccess(true)) {
            SC_Utils_Ex::sfDispSiteError(CUSTOMER_ERROR);
        }

        // ダウンロード商品の場合は、支払方法画面に転送
        if ($this->cartKey == PRODUCT_TYPE_DOWNLOAD) {
            $objPurchase->copyFromCustomer($sqlval, $objCustomer, 'shipping');
            $objPurchase->saveShippingTemp($sqlval);
            $objPurchase->saveOrderTemp($this->tpl_uniqid, $sqlval, $objCustomer);
            $objSiteSess->setRegistFlag();

            SC_Response_Ex::sendRedirect('payment.php');
            SC_Response_Ex::actionExit();
        }

        $this->lfInitParam($objFormParam);
        $objFormParam->setParam($_POST);
        $objFormParam->convParam();
        $arrErr = $objFormParam->checkError();
        if (!SC_Utils_Ex::isBlank($arrErr)) {
            SC_Utils_Ex::sfDispSiteError(PAGE_ERROR, '', true);
            SC_Response_Ex::actionExit();
        }

        $arrForm = $objFormParam->getHashArray();

        if (!$this->doCheck($arrForm, $objCustomer)) {
            SC_Utils_Ex::sfDispSiteError(PAGE_ERROR, '', true);
        }

        switch ($this->getMode()) {
            // 削除
            case 'delete':
                $this->doDelete($arrForm['other_deliv_id']);
                break;

            // 会員登録住所に送る
            case 'customer_addr':
                $objPurchase->unsetShippingTemp();

                $shipping_id = $arrForm['deliv_check'] == -1 ? 0 : $arrForm['deliv_check'];
                $success = $this->registerDeliv($shipping_id, $this->tpl_uniqid, $objPurchase, $objCustomer);
                if (!$success) {
                    SC_Utils_Ex::sfDispSiteError(PAGE_ERROR, '', true);
                }

                $objPurchase->setShipmentItemTempForSole($objCartSess, $shipping_id);
                $objSiteSess->setRegistFlag();


                SC_Response_Ex::sendRedirect(SHOPPING_PAYMENT_URLPATH);
                SC_Response_Ex::actionExit();
                break;

            // 前のページに戻る
            case 'return':

                // 確認ページへ移動
                SC_Response_Ex::sendRedirect(CART_URLPATH);
                SC_Response_Ex::actionExit();
                break;

            // お届け先複数指定
            case 'multiple':
                // 複数配送先指定が無効な場合はエラー
                if (USE_MULTIPLE_SHIPPING === false) {
                    SC_Utils_Ex::sfDispSiteError(PAGE_ERROR, '', true);
                    SC_Response_Ex::actionExit();
                }

                SC_Response_Ex::sendRedirect('multiple.php');
                SC_Response_Ex::actionExit();
                break;

            default:
                // 配送IDの取得
                $shippingData = $objPurchase->getShippingTemp();
                $arrShippingId = array_keys($shippingData);
                if (isset($arrShippingId[0])) {
                    $this->arrForm['deliv_check']['value'] = $arrShippingId[0] == 0 ? -1 : $arrShippingId[0];
                }
                break;
        }

        // 登録済み住所を取得
        $this->arrAddr = $objCustomer->getCustomerAddress($objCustomer->getValue('customer_id'));
        $this->tpl_addrmax = count($this->arrAddr);
    }

    /**
     * デストラクタ.
     *
     * @return void
     */
    function destroy() {
        parent::destroy();
    }

    /**
     * パラメーター情報の初期化を行う.
     *
     * @param SC_FormParam $objFormParam SC_FormParam インスタンス
     * @return void
     */
    function lfInitParam(&$objFormParam) {
        $objFormParam->addParam('その他のお届け先ID', 'other_deliv_id', INT_LEN, 'n', array('NUM_CHECK', 'MAX_LENGTH_CHECK'));
        $objFormParam->addParam('お届け先チェック', 'deliv_check', INT_LEN, 'n', array('MAX_LENGTH_CHECK'));
    }

    /**
     * その他のお届け先情報を削除する.
     *
     * @param integer $other_deliv_id その他のお届け先ID
     * @return void
     */
    function doDelete($other_deliv_id) {
        $objQuery = & SC_Query_Ex::getSingletonInstance();
        $where = 'other_deliv_id = ?';
        $objQuery->delete('dtb_other_deliv', $where, array($other_deliv_id));
    }

    /**
     * お届け先チェックの値に応じて, お届け先情報を保存する.
     *
     * 会員住所がチェックされている場合は, 会員情報からお届け先を取得する.
     * その他のお届け先がチェックされている場合は, その他のお届け先からお届け先を取得する.
     * お届け先チェックの値が不正な場合は false を返す.
     *
     * @param integer $other_deliv_id
     * @param string $uniqid 受注一時テーブルのユニークID
     * @param SC_Helper_Purchase $objPurchase SC_Helper_Purchase インスタンス
     * @param SC_Customer $objCustomer SC_Customer インスタンス
     * @return boolean お届け先チェックの値が妥当な場合 true
     */
    function registerDeliv($other_deliv_id, $uniqid, &$objPurchase, &$objCustomer) {
        GC_Utils_Ex::gfDebugLog('register deliv. deliv_check=' . $deliv_check);
        $arrValues = array();
        // 会員登録住所がチェックされている場合
        if ($other_deliv_id == 0) {
            $objPurchase->copyFromCustomer($arrValues, $objCustomer, 'shipping');
        }
        // 別のお届け先がチェックされている場合
        else {
            $objQuery = & SC_Query_Ex::getSingletonInstance();
            $arrOtherDeliv = $objQuery->getRow('*', 'dtb_other_deliv', 'customer_id = ? AND other_deliv_id = ?', array($objCustomer->getValue('customer_id'), $other_deliv_id));
            if (empty($arrOtherDeliv)) {
                return false;
            }

            $objPurchase->copyFromOrder($arrValues, $arrOtherDeliv, 'shipping', '');
        }
        $objPurchase->saveShippingTemp($arrValues, $other_deliv_id);
        $objPurchase->saveOrderTemp($uniqid, $arrValues, $objCustomer);
        return true;
    }

    function doCheck($arrForm, &$objCustomer) {
        $objQuery = & SC_Query_Ex::getSingletonInstance();
        if (empty($arrForm['other_deliv_id'])) {
            $result = 1;
        } else {
            $where = 'other_deliv_id = ? AND customer_id = ?';
            $result = $objQuery->count('dtb_other_deliv', $where, array($arrForm['other_deliv_id'], $objCustomer->getValue('customer_id')));
        }

        return $result;
    }

}