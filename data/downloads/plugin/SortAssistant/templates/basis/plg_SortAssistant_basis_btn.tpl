<!--{*
 * SortAssistant
 * 
 * Copyright (c) 2014 doishun
 * http://www.salon.ne.jp
 * 
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option) any later
 * version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
 * Place, Suite 330, Boston, MA 02111-1307 USA
 * 
 *}-->

<div class="btn addnew" id="btn_addnew">

<!--{* 並び替え前 *}-->
<!--{if $mode == "" || $mode != "sortable"}-->
    <!--{if $sortCount > 1}-->
    <a class="btn-normal" href="javascript:;" onclick="fnFormModeSubmit('form1','sortable','',''); return false;">
        <span>並び替え開始</span>
    </a>
    <!--{/if}-->


<!--{* 並び替え中 *}-->
<!--{else}-->
    <a class="btn-normal" href="javascript:;" onclick="fnFormModeSubmit('form1','sort_excu','',''); return false;">
        <span>並び替え完了</span>
    </a>

    <a class="btn-normal" id="sort_stop" href="javascript:;" onclick="">
        <span>並び替え中止</span>
    </a>

<!--{/if}-->
</div>