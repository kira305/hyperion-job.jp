<!--{*
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
*}-->

<form name="form1" id="form1" method="post" action="?">
    <input type="hidden" name="<!--{$smarty.const.TRANSACTION_ID_NAME}-->" value="<!--{$transactionid}-->" />
    <input type="hidden" name="mode" value="edit" />
    <input type="hidden" name="kiyaku_id" value="<!--{$tpl_kiyaku_id}-->" />
    <div id="basis" class="contents-main">
        <table class="form">
            <tr>
                <th>契約書<span class="attention"> *</span></th>
                <td>
                    <span class="attention"><!--{$arrErr.kiyaku_type}--></span>
                    <select name="kiyaku_type" style="<!--{$arrErr.kiyaku_type|sfGetErrorColor}-->">
                        <option value="">選択してください</option>
                        <!--{html_options options=$arrKIYAKUTYPE selected=$arrForm.kiyaku_type}-->
                    </select>
                </td>
            </tr>
            <tr>
                <th>規約タイトル<span class="attention"> *</span></th>
                <td>
                    <span class="attention"><!--{$arrErr.kiyaku_title}--></span>
                    <span class="attention"><!--{$arrErr.name}--></span>
                    <input type="text" name="kiyaku_title" value="<!--{$arrForm.kiyaku_title|h}-->" maxlength="<!--{$smarty.const.SMTEXT_LEN}-->" style="<!--{if $arrErr.kiyaku_title != "" || $arrErr.name != ""}-->background-color: <!--{$smarty.const.ERR_COLOR}-->;<!--{/if}-->" size="60" class="box60"/>
                    <span class="attention"> (上限<!--{$smarty.const.SMTEXT_LEN}-->文字)</span>
                </td>
            </tr>
            <tr>
                <th>規約内容<span class="attention"> *</span></th>
                <td>
                    <span class="attention"><!--{$arrErr.kiyaku_text}--></span>
                    <textarea name="kiyaku_text" maxlength="<!--{$smarty.const.MLTEXT_LEN}-->" cols="60" rows="8" class="area60" style="<!--{if $arrErr.kiyaku_text != ""}-->background-color: <!--{$smarty.const.ERR_COLOR}-->;<!--{/if}-->" ><!--{$arrForm.kiyaku_text|h}--></textarea>
                    <span class="attention"> (上限<!--{$smarty.const.MLTEXT_LEN}-->文字)</span>
                </td>
            </tr>
        </table>
        <div class="btn-area">
            <ul>
                <li><a class="btn-action" href="javascript:;" onclick="fnFormModeSubmit('form1', 'confirm', '', '');
                        return false;"><span class="btn-next">この内容で登録する</span></a></li>
            </ul>
        </div>

        <!--{section name=cnt loop=$arrKiyaku}-->
        <!--{assign var=type value=`$arrKiyaku[cnt].kiyaku_type`}-->

        <!--{if $arrKiyaku[cnt].kiyaku_id|in_array:$arrKiyakuTypeFirst}-->
        <table class="list">
            <col width="65%" />
            <col width="10%" />
            <col width="10%" />
            <col width="15%" />
            <tr>
                <th><!--{$arrKIYAKUTYPE[$type]}--></th>
                <th>編集</th>
                <th>削除</th>
                <th>移動</th>
            </tr>
            <!--{/if}-->

            <tr style="background:<!--{if $tpl_kiyaku_id != $arrKiyaku[cnt].kiyaku_id}-->#ffffff<!--{else}--><!--{$smarty.const.SELECT_RGB}--><!--{/if}-->;">
                <!--{assign var=kiyaku_id value=$arrKiyaku[cnt].kiyaku_id}-->
                <td><!--{* 規格名 *}--><!--{$arrKiyaku[cnt].kiyaku_title|h}--></td>
                <td align="center">
                    <!--{if $tpl_kiyaku_id != $arrKiyaku[cnt].kiyaku_id}-->
                    <a href="?" onclick="fnSetFormSubmit('form1', 'kiyaku_id', <!--{$arrKiyaku[cnt].kiyaku_id}--> ); return false;">編集</a>
                    <!--{else}-->
                    編集中
                    <!--{/if}-->
                </td>
                <td align="center">
                    <!--{if $arrClassCatCount[$class_id] > 0}-->
                    -
                    <!--{else}-->
                    <a href="?" onclick="fnModeSubmit('delete', 'kiyaku_id', <!--{$arrKiyaku[cnt].kiyaku_id}--> ); return false;">削除</a>
                    <!--{/if}-->
                </td>
                <td align="center">
                    <!--{if !$arrKiyaku[cnt].kiyaku_id|in_array:$arrKiyakuTypeFirst}-->
                    <a href="?" onclick="fnModeSubmit('up', 'kiyaku_id', <!--{$arrKiyaku[cnt].kiyaku_id}--> ); return false;">上へ</a>
                    <!--{/if}-->
                    <!--{if !$arrKiyaku[cnt].kiyaku_id|in_array:$arrKiyakuTypeLast}-->
                    <a href="?" onclick="fnModeSubmit('down', 'kiyaku_id', <!--{$arrKiyaku[cnt].kiyaku_id}--> ); return false;">下へ</a>
                    <!--{/if}-->
                </td>
            </tr>

            <!--{if $arrKiyaku[cnt].kiyaku_id|in_array:$arrKiyakuTypeLast}-->
        </table>
        <!--{/if}-->
        <!--{/section}-->
    </div>
</form>