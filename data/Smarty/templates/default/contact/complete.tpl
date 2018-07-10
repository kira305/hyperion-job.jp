<!--{*
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
 *}-->

<div id="undercolumn">
        
    <h2 class="contact">お問い合わせ <span>完了</span></h2>

    <div id="undercolumn_contact">
        
        <div class="caption_text">
        
        <p><em>万一、ご回答メールが届かない場合は、トラブルの可能性もありますので<br />
        大変お手数ではございますがもう一度お問い合わせいただくか、お電話にてお問い合わせください。<br />
        今後ともご愛顧賜りますようよろしくお願い申し上げます。</em></p>
        <p class="name"><!--{$arrSiteInfo.company_name|h}-->            </p>
        <p>TEL：<!--{$arrSiteInfo.tel01}-->-<!--{$arrSiteInfo.tel02}-->-<!--{$arrSiteInfo.tel03}-->
                <!--{if $arrSiteInfo.business_hour != ""}-->
                (受付時間/<!--{$arrSiteInfo.business_hour}-->)
                <!--{/if}--><br />
            E-mail：<a href="mailto:<!--{$arrSiteInfo.email02|escape:'hex'}-->"><!--{$arrSiteInfo.email02|escape:'hexentity'}--></a></p>
        </div>

        <div class="clearfix em3"></div>
    
             <button class="icon-btn icon-btn-mail-back" type="submit" onclick="location.href='<!--{$smarty.const.TOP_URLPATH}-->'">
                <span class="icon-btn-text">トップページへ戻る</span>
             </button>
    </div>
</div>

<!-- リマーケティング タグの Google コード -->
<!--------------------------------------------------
リマーケティング タグは、個人を特定できる情報と関連付けることも、デリケートなカテゴリに属するページに設置することも許可されません。タグの設定方法については、こちらのページをご覧ください。
http://google.com/ads/remarketingsetup
--------------------------------------------------->
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 997306763;
var google_custom_params = window.google_tag_params;
var google_remarketing_only = true;
/* ]]> */
</script>
<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/997306763/?value=0&amp;guid=ON&amp;script=0"/>
</div>
</noscript>
