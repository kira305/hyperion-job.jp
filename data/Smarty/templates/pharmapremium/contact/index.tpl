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

<script>
    $(function() {
        $('#contents')
                .css('font-size', '100%')
                .autoResizeTextAreaQ({
            'max_rows': 50,
            'extra_rows': 0
        });
    });
</script>
<section id="undercolumn">
    <h2 class="contact">お問い合わせ <span>入力フォーム</span></h2>
    <div id="undercolumn_contact">
        <div class="caption_text">　<p> <font size="2">
            <ul>
                <li>必要項目をご入力後、確認画面が表示されます。 内容に間違いがなければ、送信ボタンを押して下さい。</li>
                <li>内容によっては回答をさしあげるのにお時間をいただくこともございます。</li>
                <li>休業日は翌営業日以降の対応となりますのでご了承ください。</li> 
            </ul> </p>
   
            <p><em>※求人情報サイト「ハイペリオンあっとジョブ」運営会社へのお問い合わせ窓口となっております。<br>
                    掲載されている求人の内容、面接等に関するお問い合わせについては、直接企業様へお問い合わせ下さい。</em></p>
        </div>


        <form name="form1" method="post" action="?">
            <input type="hidden" name="<!--{$smarty.const.TRANSACTION_ID_NAME}-->" value="<!--{$transactionid}-->" />
            <input type="hidden" name="mode" value="confirm" />



            <div id="entry_form">

                <form id="form_check">                    

                    <dl id="contact_form">
                        <dt><span>必須</span> お名前(漢字)</dt>
                        <dd>
                            <input type="text" class="half1" name="name01" value="<!--{$arrForm.name01.value|h|default:$arrData.name01|h}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr.name01|sfGetErrorColor}-->; ime-mode: active;"  placeholder="姓" />
                            <input type="text" class="half2" name="name02" value="<!--{$arrForm.name02.value|h|default:$arrData.name02|h}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr.name02|sfGetErrorColor}-->; ime-mode: active;"  placeholder="名"　/>
                            <p><span class="attention"><!--{$arrErr.name01}--><!--{$arrErr.name02}--></span></p></dd>

                        <dt><span>必須</span> お名前(フリガナ)</dt>
                        <dd>
                            <input type="text" class="half1" name="kana01" value="<!--{$arrForm.kana01.value|h|default:$arrData.kana01|h}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr.kana01|sfGetErrorColor}-->; ime-mode: active;" placeholder="セイ" />　
                            <input type="text" class="half2" name="kana02" value="<!--{$arrForm.kana02.value|h|default:$arrData.kana02|h}-->" maxlength="<!--{$smarty.const.STEXT_LEN}-->" style="<!--{$arrErr.kana02|sfGetErrorColor}-->; ime-mode: active;" placeholder="メイ"　/>
                            <p><span class="attention"><!--{$arrErr.kana01}--><!--{$arrErr.kana02}--></span></p></dd>

                        <dt><span>必須</span> メールアドレス</dt>
                        <dd>
                            <input type="text" name="email" value="<!--{$arrForm.email.value|h|default:$arrData.email|h}-->" style="<!--{$arrErr.email|sfGetErrorColor}-->; ime-mode: disabled;" placeholder="[例] abc123@mail.com" />
                            <!--{* ログインしていれば入力済みにする *}-->
                            <!--{if $smarty.server.REQUEST_METHOD != 'POST' && $smarty.session.customer}-->
                            <!--{assign var=email02 value=$arrData.email}-->
                            <!--{/if}-->
                            <p><span class="attention"><!--{$arrErr.email}--></span></p>
                        </dd>

                        <dt class="sml">※確認の為2度入力してください</dt>
                        <dd>
                            <input type="text" name="email02" value="<!--{$arrForm.email02.value|default:$email02|h}-->" style="<!--{$arrErr.email02|sfGetErrorColor}-->; ime-mode: disabled;" placeholder="※もう一度入力してください" />
                            <p><span class="attention"><!--{$arrErr.email02}--></span></p>
                        </dd>

                        <dt class="hidden">電話番号</dt>
                        <dd class="hidden">
                            <p>
                                <input type="text" class="num4" name="tel01" value="<!--{$arrForm.tel01.value|h|default:$arrData.tel01|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" style="<!--{$arrErr.tel01|sfGetErrorColor}-->; ime-mode: disabled;" />&nbsp;-&nbsp;
                                <input type="text" class="num4" name="tel02" value="<!--{$arrForm.tel02.value|h|default:$arrData.tel02|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" style="<!--{$arrErr.tel02|sfGetErrorColor}-->; ime-mode: disabled;" />&nbsp;-&nbsp;
                                <input type="text" class="num4" name="tel03" value="<!--{$arrForm.tel03.value|h|default:$arrData.tel03|h}-->" maxlength="<!--{$smarty.const.TEL_ITEM_LEN}-->" style="<!--{$arrErr.tel03|sfGetErrorColor}-->; ime-mode: disabled;" /></p>
                            <p><span class="attention"><!--{$arrErr.tel01}--><!--{$arrErr.tel02}--><!--{$arrErr.tel03}--></span></p></dd>

                        <dt class="hidden">郵便番号</dt>
                        <dd class="hidden">
                            <p><span class="caption">〒</span>
                                <input type="text" name="zip01" class="num3" value="<!--{$arrForm.zip01.value|h|default:$arrData.zip01|h}-->" maxlength="<!--{$smarty.const.ZIP01_LEN}-->" style="<!--{$arrErr.zip01|sfGetErrorColor}-->; ime-mode: disabled;" /><span class="caption">-</span>
                                <input type="text" name="zip02" class="num4" value="<!--{$arrForm.zip02.value|h|default:$arrData.zip02|h}-->" maxlength="<!--{$smarty.const.ZIP02_LEN}-->" style="<!--{$arrErr.zip02|sfGetErrorColor}-->; ime-mode: disabled;" /> <a href="http://search.post.japanpost.jp/zipcode/" target="_blank"><span class="mini">郵便番号検索</span></a>
                            </p>
                            <p>
                                <a href="javascript:fnCallAddress('<!--{$smarty.const.INPUT_ZIP_URLPATH}-->', 'zip01', 'zip02', 'pref', 'addr01');">
                                    住所自動入力</a>
                                <span class="mini">&nbsp;郵便番号を入力後、クリックしてください。</span>
                            </p>
                            <p><span class="attention"><!--{$arrErr.zip01}--><!--{$arrErr.zip02}--></span></p></dd>

                        <dt class="hidden">都道府県</dt>
                        <dd class="hidden">
                            <p>
                                <select name="pref" style="<!--{$arrErr.pref|sfGetErrorColor}-->">
                                    <option value="">都道府県を選択</option><!--{html_options options=$arrPref selected=$arrForm.pref.value|h|default:$arrData.pref|h}--></select></p></dd>
                        <dt class="hidden">市区町村</dt>
                        <dd class="hidden">
                            <p>
                                <input type="text" name="addr01" value="<!--{$arrForm.addr01.value|h|default:$arrData.addr01|h}-->" style="<!--{$arrErr.addr01|sfGetErrorColor}-->; ime-mode: active;" /></p></dd>

                        <dt class="hidden">番地・ビル名</dt>
                        <dd class="hidden">
                            <p>
                                <input type="text" name="addr02" value="<!--{$arrForm.addr02.value|h|default:$arrData.addr02|h}-->" style="<!--{$arrErr.addr02|sfGetErrorColor}-->; ime-mode: active;" /></p>
                            <p><span class="attention"><!--{$arrErr.pref}--><!--{$arrErr.addr01}--><!--{$arrErr.addr02}--></span></p></dd>
                    </dl>

                    <dl id="contact_form_text">
                        <dt>お問い合わせ内容 <span class="mini">（全角<!--{$smarty.const.MLTEXT_LEN}-->字以下）</span></dt>
                        <dd>
                            <textarea name="contents" class="box380" cols="60" rows="20" style="<!--{$arrErr.contents.value|h|sfGetErrorColor}-->; ime-mode: active;"　><!--{$arrForm.contents.value|h}--></textarea>
                            <p><span class="attention"><!--{$arrErr.contents}--></span></p>
                            <p>※求人に関するお問い合わせには、必ず「求人番号」をご記入くださいますようお願いいたします。</p></dd> 
                    </dl>     
            </div>

            <div class="clearfix"></div>
            <button class="icon-btn icon-btn-mail" type="submit" alt="確認ページへ" value="確認ページへ" name="confirm">
                <span class="icon-btn-text">上記の内容で送信する</span>
            </button>

        </form>
    </div>
</section>