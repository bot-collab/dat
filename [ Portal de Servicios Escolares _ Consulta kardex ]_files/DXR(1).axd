img
{
	border-width: 0;
}

img[class^="dx"] /*Bootstrap correction*/
{
    max-width: none;
}

.dx-ft
{
	background-color: white;
	opacity: 0.01;
	filter: progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=1);
}
.dx-clear
{
	display: block;
	clear: both;
	height: 0;
	width: 0;
	font-size: 0;
	line-height: 0;
	overflow: hidden;
	visibility: hidden;
}
.dx-borderBox {
	-moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
}
.dx-contentBox {
	-moz-box-sizing: content-box;
	-webkit-box-sizing: content-box;
	box-sizing: content-box;
}
.dxKBSW
{
	font-size:0;
}
.dx-wbv {
    -webkit-backface-visibility: hidden;
}
.dxIE .dxMSTouchDraggable,
.dxIE .dxAC
{
	-ms-touch-action: pinch-zoom;
}
.dxEdge .dxMSTouchDraggable,
.dxEdge .dxAC
{
	touch-action: pinch-zoom;
}
.dx-justification,
.dx-dialogEditRoot > tbody > tr > td:first-child 
{
    width: 100% !important;
}

.dx-al { text-align: left; }
.dx-al > * { }
.dx-ar { text-align: right; }
.dx-ar > * { float: right; }
.dx-ac { text-align: center; }
.dx-ac > * { margin: 0 auto; }
.dx-vam, .dx-vat, .dx-vab { display: inline-block!important; }
span.dx-vam, span.dx-vat, span.dx-vab, a.dx-vam, a.dx-vat, a.dx-vab 
{ 
    line-height: 100%; 
    padding: 2px 0;
    text-decoration: inherit;
}
a > .dx-vam, a > .dx-vat, a > .dx-vab 
{ 
    /* Q556373 */
    line-height: 135%\9!important;
    display: inline\9!important;
    padding: 0\9!important;
    
}

.dx-vam, .dx-valm { vertical-align: middle; }
.dx-vat, .dx-valt { vertical-align: top; }
.dx-vab, .dx-valb { vertical-align: bottom; }
.dx-noPadding { padding: 0!important; }
.dx-wrap, span.dx-wrap
{ 
    white-space: normal!important; 
    line-height: normal;
    padding: 0;
}
.dx-nowrap, span.dx-nowrap
{ 
    white-space: nowrap!important; 
}

.dx-wrap > .dxgv 
{
    white-space: normal!important;
}
.dx-nowrap > .dxgv 
{
    white-space: nowrap!important;
}

/* Prevent LinkStyle for disabled elements */
*[class*='dxnbLiteDisabled'] a:hover, 
*[class*='dxnbLiteDisabled'] a:hover *, 
*[class*='dxnbLiteDisabled'] a:visited *,
*[class*='dxnbLiteDisabled'] a:visited *,
*[class*='dxm-disabled'] a:hover, 
*[class*='dxm-disabled'] a:hover *, 
*[class*='dxm-disabled'] a:visited *,
*[class*='dxm-disabled'] a:visited *,
*[class*='dxtcLiteDisabled'] a:hover, 
*[class*='dxtcLiteDisabled'] a:hover *, 
*[class*='dxtcLiteDisabled'] a:visited *,
*[class*='dxtcLiteDisabled'] a:visited *
{
    color: inherit!important;
    text-decoration: inherit!important;
}

.dx-ellipsis
{
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.dxFirefox .dx-ellipsis
{
    -moz-text-overflow: ellipsis;
}

/* Section 508, WCAG */
.dxAIFE,
.dxAITC caption
{
     clip: rect(1px, 1px, 1px, 1px);
    -webkit-clip-path: polygon(0 0);  /* clip-path: polygon(0 0); */
    height: 1px;
    overflow: hidden;
    position: absolute !important;
}
.dxAIR
{
    font-size: 0!important;
    border-width: 0!important;
    height: 0!important;
}
.dxAIR th
{
    border-width: 0!important;
    line-height: 0!important;
    padding: 0!important;
}
.dxDefaultCursor
{
    cursor: default;
}

/* ASPxButton */
.dxb-hb,
.dxb-hbc
{
    padding: 0!important;
    margin: 0!important;
    border: 0!important;
    height: 0!important;
    width: 0!important;
    font-size: 0!important;
    opacity: 0!important;
}
.dxb-hbc .dxb-hb
{
    position: relative;
}
.dxSafari .dxb-hbc .dxb-hb
{
    height: 1px!important;
    width: 1px!important;
}
.dxb-hbc
{
    overflow: hidden;
}

/* ASPxInternalCheckBox */
.dxicbInput
{
	border: 0;
	width: 0;
	height: 0;
	padding: 0;
	background-color: transparent;
}
.dxichCellSys
{
    padding: 3px 3px 1px;
}
span.dxichCellSys
{
    display: inline-block;
}
span.dxichCellSys.dxeTAR,
*[dir='rtl'] span.dxichCellSys.dxeTAL
{
    padding: 2px 0 2px 3px;
}
span.dxichCellSys.dxeTAL,
*[dir='rtl'] span.dxichCellSys.dxeTAR
{
    padding: 2px 3px 2px 0;
}
span.dxichCellSys label
{
    display: inline-block;
    vertical-align: middle;
}
span.dxichCellSys.dxeTAR label,
span[dir='rtl'].dxichCellSys.dxeTAL label
{
    padding: 1px 0 2px 3px;
}
span.dxichCellSys.dxeTAL label,
span[dir='rtl'].dxichCellSys.dxeTAR label
{
    padding: 1px 3px 2px 0;
}
.dxichSys
{
    margin: 1px;
    cursor: default;
	display: inline-block;
	vertical-align: middle;
}
.dxichTextCellSys
{
    padding: 2px 0 1px;
}
.dxe .dxeTAR .dxichTextCellSys label,
.dxe span.dxichCellSys.dxeTAR label,
*[dir='rtl'] .dxe .dxeTAL .dxichTextCellSys label,
*[dir='rtl'] .dxe span.dxichCellSys.dxeTAL label
{
    margin-left: 0;
	margin-right: 6px;
}
.dxe .dxeTAL .dxichTextCellSys label,
.dxe span.dxichCellSys.dxeTAL label,
*[dir='rtl'] .dxe .dxeTAR .dxichTextCellSys label,
*[dir='rtl'] .dxe span.dxichCellSys.dxeTAR label
{
	margin-right: 0;
	margin-left: 6px;
}
.dxe .dxichTextCellSys img,
.dxe .dxichTextCellSys img
{
	margin-bottom: -4px;
    padding-right: 5px;
}

/* ASPxPanel */
.dxpnl-edge
{
    position: fixed;
}
.dxpnl-bar
{
    display: none;
    border-spacing: 0;

    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
.dxpnl-edge.t
{
    border-bottom-width: 1px;
    left: 0;
    right: 0;
    top: 0;
    width: auto!important;
    z-index: 1003;
}
.dxpnl-edge.t.dxpnl-bar
{
    z-index: 1002;
}
.dxpnl-edge.b
{
    border-top-width: 1px;
    left: 0;
    right: 0;
    bottom: 0;
    width: auto!important;
    z-index: 1003;
}
.dxpnl-edge.b.dxpnl-bar
{
    z-index: 1002;
}
.dxpnl-edge.l
{
    border-right-width: 1px;
    left: 0;
    bottom: 0;
    top: 0;
    height: auto!important;
    z-index: 1001;
}
.dxpnl-edge.l.dxpnl-bar
{
    z-index: 1000;
}
.dxpnl-edge.l.dxpnl-bar.dxpnl-expanded
{
    border-right-color: transparent;
}
.dxpnl-edge.r
{
    border-left-width: 1px;
    right: 0;
    bottom: 0;
    top: 0;
    height: auto!important;
    z-index: 1001;
}
.dxpnl-edge.r.dxpnl-bar
{
    z-index: 1000;
}
.dxpnl-edge.r.dxpnl-bar.dxpnl-expanded
{
    border-left-color: transparent;
}
.dxpnl-np 
{ 
    float: left; 
}
.dxpnl-fp 
{ 
    float: right; 
}
.dxpnl-cp 
{ 
    float: left; 
    margin: 0 auto; 
}
.dxpnl-btn
{
    cursor: pointer;
    display: block;

    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
.dxpnl-btn img
{
    display: block;
}
.dxpnl-expanded
{
    background-color: white;
    z-index: 1000;
}
.dxpnl-collapsible,
.dxpnl-expanded-tmpl,
.dxpnl-expanded .dxpnl-cc
{
    display: none;
}
.dxpnl-collapsible.dxpnl-expanded,
.dxpnl-expanded .dxpnl-expanded-tmpl
{
    display: block;
}
.dxpnl-collapsible.dxpnl-bar
{
    display: table;
}
.dxpnl-collapsible.dxpnl-edge.dxpnl-bar
{
    display: block;
}
.dxpnl-collapsible.dxpnl-bar.dxpnl-expanded.h,
.dxpnl-collapsible.dxpnl-edge.dxpnl-bar.dxpnl-expanded.h
{
    display: none;
}
.dxpnl-scc
{
    box-sizing: border-box;
    width: 100%;
    height: 100%;
}
.dxpnl-cbtw,
.dxpnl-expanded .dxpnl-cbtwc > * 
{
    display: none;
}
.dxpnl-expanded .dxpnl-cbtwc > .dxpnl-cbtw
{
    display: inline-block;    
}

/* ASPxPager */
.dxp-spacer
{
    float: left;
    display: block;
    overflow: hidden;
}
.dxp-right
{
    float: right!important;
}
.dxp-summary,
.dxp-sep,
.dxp-button,
.dxp-pageSizeItem,
.dxp-num,
.dxp-current,
.dxp-ellip
{
	display: block;
	float: left;
    line-height: 100%;
}
.dxp-summary,
.dxp-sep,
.dxp-button,
.dxp-pageSizeItem,
.dxp-num,
.dxp-current,
.dxp-ellip /*Bootstrap correction*/
{
    -moz-box-sizing: content-box;
    -webkit-box-sizing: content-box;
    box-sizing: content-box;
}
.dxp-button,
.dxp-dropDownButton,
.dxp-num
{
    cursor: pointer;
}
.dxp-current,
.dxp-disabledButton, 
.dxp-disabledButton span
{
    cursor: default;
}
.dxp-dropDownButton
{
    font-size: 0;
    display: block;
    float: left;
}
.dxp-dropDownButton img
{
    border: none;
	text-decoration: none;
	vertical-align: middle;
}
.dxFirefox .dxp-pageSizeItem
{
	margin-top: -1px;
}
span.dxp-comboBox input /*Bootstrap correction*/
{
    font: inherit;
    *font: 12px Tahoma, Geneva, sans-serif;

    display: block;
    float: left;
    background-color: transparent;
    border-width: 0px;
    padding: 0px;
    width: 25px;
}
span.dxp-comboBox input /*Bootstrap correction*/
{
    height: auto;
    color: black;
    -webkit-box-shadow: none;
    -moz-box-shadow: none;
    box-shadow: none;
    -webkit-transition: none;
    -moz-transition: none;
    -o-transition: none;
    transition: none;
	-webkit-border-radius: 0px;
    -moz-border-radius: 0px;
    border-radius: 0px;
}
.dxp-pageSizeItem label /*Bootstrap correction*/
{
    font: inherit;
    line-height: normal;    
    display: inline;
    margin-bottom: 0px;
}
.dxp-comboBox,
.dxp-dropDownButton /*Bootstrap correction*/
{
    -moz-box-sizing: content-box;
    -webkit-box-sizing: content-box;
    box-sizing: content-box;
}

/* ASPxUploadControl */
.dxucEditAreaSys
{
    margin: 0px;
}
.dxucButtonSys
{
    color: #394EA2;
    cursor: pointer;
    white-space: nowrap;
}
.dxucButtonSys a[unselectable="on"]
{
    cursor: default;
    user-select: none;
	-moz-user-select: -moz-none;
	-khtml-user-select: none;
	-webkit-user-select: none;
}
.dxCB img
{
    vertical-align:middle;
}
.dxucFFIHolder,
.dxucFFIHolder .dxucFFI
{
	position: relative;
    width: 0;
    height: 0;
    border-width: 0;
}
.dxucFFIHolder
{
    line-height: 0;
    font-size: 0;
}
.dxucFFIHolder .dxucFFI
{
    top: 0;
    padding: 0;
    margin: 0;
	background-color: transparent;
}
input[type="text"][class^="dxucEditArea"] /*Bootstrap correction*/
{
    display: block;
    height: auto;
    line-height: normal;
    -webkit-border-radius: 0px;
    -moz-border-radius: 0px;
    border-radius: 0px;
}
.dxucInlineDropZoneSys {
    text-align: center;
    vertical-align: middle;
    position: fixed;
    box-sizing: border-box;
    background-color: rgba(92, 197, 41, 0.5);
    border: 2px solid #65A644;
    border-radius: 5px;
    z-index: 19999;
}
.dxucInlineDropZoneSys span {
    color: #318806;
    padding: 10px;
    font-weight: bold !important;
    font-size: 16px;
}
.dxucIZBorder {
    height: 100%;
    width: 100%;
    box-sizing: border-box;
    text-align:center;
    display: table;
}
.dxucIZBackground {
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    margin: auto;
    display: table-cell;
    vertical-align: middle;
}
.dxucIZ-hidden {
    left: -9999px;
    top: -9999px;
}

.dxucFileList {
    list-style-type: none;
    display: inline-block;
    padding-left: 0;
    margin: 22px 0 0 0;
    width: 100%
}

*[dir='rtl'] .dxucFileList {
    padding-right: 0px;
}

.dxucFL-Progress {
    margin: 5px 0 0 0;
}

.dxucBarCell, .dxRB {
    float: right;
}

*[dir='rtl'] .dxucBarCell, *[dir='rtl'] .dxRB {
    float: left;
}

.dxRB {
    padding: 0 !important;
}

.dxucFileList li {
    min-height: 22px;
}

.dxucFileList li > div {
    display: inline-block;
}

.dxucNameCell span {
    padding-right: 8px;
    vertical-align: top;
    text-overflow: ellipsis;
    overflow: hidden;
    display: inline-block;
    white-space: nowrap;
}

*[dir='rtl'] .dxucNameCell span {
    padding-left: 8px;
    padding-right: 0;
}

.dxTBHidden {
    border: 0px !important;
    padding: 0px !important;
    width: 0px !important;
}
.dxucHidden {
    position: absolute;
    left: -9999px;
}

/* ASPxPopupControl lite */
.dxpc-mainDiv
{
    position: relative;
}
.dxpc-headerContent,
.dxpc-footerContent
{
    line-height: 100%;
    padding: 1px 0;
    white-space: nowrap;
}
.dxpc-closeBtn,
.dxpc-pinBtn,
.dxpc-refreshBtn,
.dxpc-collapseBtn,
.dxpc-maximizeBtn
{
    cursor: pointer;
}
.dxpc-animationWrapper
{
    width: inherit;
    height: inherit;
}
.dxpcHBCellSys
{
	-webkit-tap-highlight-color: rgba(0,0,0,0);
    -webkit-touch-callout: none;
}
.dxpc-contentWrapper 
{
	display: table;
    width: 100%;
    border-spacing: 0;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
.dxpc-shadow 
{
	-moz-box-shadow: 0 2px 12px rgba(0, 0, 0, 0.34375);
    -webkit-box-shadow: 0 2px 12px rgba(0, 0, 0, 0.34375);
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.34375);
    border-collapse: separate;
}

.dxpc-ie:after
{
	content: "";
}

.dxpc-iFrame
{
	vertical-align: text-bottom;
    overflow: auto;
    border: 0;
}

.dxpc-content /* Bootstrap correction */
{
    -moz-box-sizing: content-box;
    -webkit-box-sizing: content-box;
    box-sizing: content-box;
	height: 100%;
}
.dxIE.dxBrowserVersion-8 .dxpc-content {
    box-sizing: border-box;
}
.dxMSTouchUI.dxIE .dxpc-content
{
    -ms-touch-action: none;
}
.dxMSTouchUI.dxEdge .dxpc-content
{
    touch-action: none;
}

/* DropDownPopupControl */
.dxpc-ddSys
{
    position: absolute;
	border-spacing: 0px;
}
.dxpc-ddSys .dxpc-mainDiv,
.dxpc-ddSys.dxpc-mainDiv
{
	border: none!important;
}
.dxpc-ddSys > .dxpc-mainDiv > .dxpc-contentWrapper > .dxpc-content,
.dxpc-ddSys > .dxpc-contentWrapper > .dxpc-content
{
	padding: 0!important;
}
.dxpc-hierarchycal, .dxpc-hierarchycal .dxpc-contentWrapper
{
	width: auto!important;
}

/* ASPxNavBar lite */
.dxnbSys
{
    display: table;
    border-spacing: 0;
    box-sizing: border-box;
}
.dxnbSys .dxnb-gr .dxnb-item,
.dxnbSys .dxnb-gr.dxnb-t .dxnb-item span,
.dxnbSys .dxnb-gr.dxnb-ti .dxnb-item span,
.dxnbSys .dxnb-gr.dxnb-ti .dxnb-item img
{
    cursor: pointer;
}
.dxnbSys .dxnb-gr.dxnb-t .dxnb-link,
.dxnbSys .dxnb-gr.dxnb-ti .dxnb-link,
.dxnbSys .dxnb-gr .dxnb-itemDisabled,
.dxnbSys .dxnb-gr .dxnb-itemSelected,
.dxnbSys .dxnb-gr.dxnb-t .dxnb-itemDisabled span,
.dxnbSys .dxnb-gr.dxnb-ti .dxnb-itemDisabled span,
.dxnbSys .dxnb-gr.dxnb-ti .dxnb-itemDisabled img
{
    cursor: default;
}
.dxnb-item,
.dxnb-link,
.dxnb-header,
.dxnb-headerCollapsed
{
    line-height: 100%;
}
.dxnb-link
{
    display: block;
}
.dxnb-bullet.dxnb-link
{
    display: list-item;
}
.dxnb-header,
.dxnb-headerCollapsed 
{
	overflow: hidden;
	cursor: pointer;
	clear: both;
}

/* ASPxMenu lite */
.dxm-rtl
{
	direction: ltr;
}
.dxm-rtl .dxm-content
{
	direction: rtl;
}
.dxm-main
{
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}
.dxm-ltr .dxm-main,
.dxm-ltr .dxm-horizontal ul.dx 
{
	float: left;
}
.dxm-rtl .dxm-main,
.dxm-rtl .dxm-horizontal ul.dx 
{
	float: right;
}
.dxm-popup 
{
	position: relative;
}
ul.dx 
{
	list-style: none none outside;
	margin: 0;
	padding: 0;
	background-repeat: repeat-y;
	background-position: left top;
}
.dxm-rtl ul.dx 
{
	background-position: right top;
}
.dxm-vertical
{
    display: table;
    border-spacing: 0;
}
.dxm-main ul.dx .dxm-item,
.dxm-popup ul.dx .dxm-item,
.dxm-main ul.dxm-t .dxm-item span,
.dxm-popup ul.dxm-t .dxm-item span,
.dxm-main ul.dxm-ti .dxm-item span,
.dxm-popup ul.dxm-ti .dxm-item span,
.dxm-main ul.dxm-ti .dxm-item img,
.dxm-popup ul.dxm-ti .dxm-item img,
.dxm-main ul.dxm-t .dxm-item.dxm-subMenu,
.dxm-popup ul.dxm-t .dxm-item.dxm-subMenu,
.dxm-main ul.dxm-ti .dxm-item.dxm-subMenu,
.dxm-popup ul.dxm-ti .dxm-item.dxm-subMenu
{
    cursor: pointer;
}
.dxm-main ul.dxm-t .dxm-item,
.dxm-popup ul.dxm-t .dxm-item,
.dxm-main ul.dxm-ti .dxm-item,
.dxm-popup ul.dxm-ti .dxm-item,
.dxm-main ul.dx .dxm-item.dxm-disabled,
.dxm-popup ul.dx .dxm-item.dxm-disabled,
.dxm-main ul.dx .dxm-item.dxm-selected,
.dxm-popup ul.dx .dxm-item.dxm-selected,
.dxm-main ul.dxm-t .dxm-item.dxm-disabled span,
.dxm-popup ul.dxm-t .dxm-item.dxm-disabled span,
.dxm-main ul.dxm-ti .dxm-item.dxm-disabled span,
.dxm-popup ul.dxm-ti .dxm-item.dxm-disabled span,
.dxm-main ul.dxm-ti .dxm-item.dxm-disabled img,
.dxm-popup ul.dxm-ti .dxm-item.dxm-disabled img
{
    cursor: default;
}
.dxm-image,
.dxm-pImage 
{
	border-width: 0px;
}

.dxm-popOut,
.dxm-spacing,
.dxm-separator,
.dxm-separator b 
{
	font-size: 0;
	line-height: 0;
	display: block;
}
.dxm-popOut /*Bootstrap correction*/
{
    -webkit-box-sizing: content-box;
    -moz-box-sizing: content-box;
    box-sizing: content-box;
}

.dxm-content
{
	line-height: 0;
}
.dxm-content.dxm-hasText
{
	line-height: 100%;
}
.dxm-ltr .dxm-horizontal .dxm-item,
.dxm-ltr .dxm-horizontal .dxm-spacing,
.dxm-ltr .dxm-horizontal .dxm-separator,
.dxm-ltr .dxm-content
{
	float: left;
}
.dxm-rtl .dxm-horizontal .dxm-item,
.dxm-rtl .dxm-horizontal .dxm-spacing,
.dxm-rtl .dxm-horizontal .dxm-separator,
.dxm-rtl .dxm-content
{
	float: right;
}

.dxm-ltr .dxm-horizontal .dxm-popOut,
.dxm-rtl .dxm-horizontal .dxm-image-l .dxm-popOut
{
	float: right;
}
.dxm-ltr .dxm-horizontal .dxm-image-r .dxm-popOut,
.dxm-rtl .dxm-horizontal .dxm-image-r .dxm-popOut,
.dxm-rtl .dxm-horizontal .dxm-image-b .dxm-popOut,
.dxm-rtl .dxm-horizontal .dxm-image-t .dxm-popOut
{
	float: left;
}
.dxm-ltr .dxm-vertical .dxm-image-t .dxm-popOut,
.dxm-ltr .dxm-vertical .dxm-image-b .dxm-popOut,
.dxm-ltr .dxm-popup .dxm-popOut 
{
	float: right;
}
.dxm-rtl .dxm-vertical .dxm-image-t .dxm-popOut,
.dxm-rtl .dxm-vertical .dxm-image-b .dxm-popOut,
.dxm-rtl .dxm-popup .dxm-popOut 
{
	float: left;
}
.dxm-vertical .dxm-image-r .dxm-popOut
{
	float: left;
}
.dxm-vertical .dxm-image-l .dxm-popOut
{
	float: right;
}

.dxm-scrollUpBtn, 
.dxm-scrollDownBtn
{
	cursor: pointer;
	font-size: 0;
}

.dxm-vertical .dxm-separator b,
.dxm-popup .dxm-separator b 
{
	margin: 0px auto;
}

.dxm-shadow 
{
	-moz-box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.199219);
    -webkit-box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.199219);
    box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.199219);
}
.dxm-horizontal.dxm-autoWidth > ul,
.dxm-horizontal.dxm-noWrap > ul
{
    display: table;
    border-spacing: 0;
    border-collapse: separate;
}
.dxm-horizontal.dxm-autoWidth > ul
{
    width: 100%;
}
.dxm-horizontal.dxm-autoWidth > ul > li,
.dxm-horizontal.dxm-noWrap > ul > li
{
    display: table-cell;
    vertical-align: top;
}
.dxm-horizontal.dxm-autoWidth > ul,
.dxm-horizontal.dxm-autoWidth > ul > li,
.dxm-horizontal.dxm-noWrap > ul > li 
{
    float: none!important;
}
.dxm-horizontal.dxm-autoWidth > ul > li .dxm-popOut,
.dxm-horizontal.dxm-noWrap > ul > li .dxm-popOut
{
   display: none;
}
.dxm-rtl .dxm-horizontal.dxm-autoWidth > ul,
.dxm-rtl .dxm-horizontal.dxm-noWrap > ul
{
    direction: rtl;
}
.dxm-ltr .dxm-horizontal.dxm-autoWidth .dxm-item,
.dxm-rtl .dxm-horizontal.dxm-autoWidth .dxm-item 
{
    text-align: center;
}
li.dxm-item /*Bootstrap correction*/
{
    line-height: normal;
}
.dxm-horizontal.dxmtb .dxtb-labelMenuItem > label
{
    line-height: 100%;
    display: block;
}
.dxm-ltr .dxm-horizontal .dxm-ami
{
    float: right!important;
}
.dxm-rtl .dxm-horizontal .dxm-ami
{
    float: left!important;
}
.dxm-horizontal .dxm-ami .dxm-content
{
    overflow: hidden!important;
    padding-left: 0!important;
    padding-right: 0!important;
    width: 0px!important;
}
.dxm-horizontal .dxm-ami .dxm-popOut
{
    border-top: 0!important;
    border-right: 0!important;
    border-bottom: 0!important;
    border-left: 0!important;
}
.dxm-horizontal .dxm-amhe,
.dxm-popup.dxm-am .dxm-amhe
{
    display: none!important;
}
.dxm-ait, a > .dxm-ait,
.dxm-am .dxm-airt, .dxm-am a > .dxm-airt
{
    display: none!important;
}
.dxm-am .dxm-ait
{
    display: inline-block!important;
}

/* ASPxTabControl, ASPxPageControl */
.dxtc-tab
{
    cursor: pointer;
}
.dxtc-activeTab
{
    cursor: default;
}
.dxtc-sb 
{
	cursor: pointer;
	font-size: 0;
}
.dxtc-sbDisabled
{
	cursor: default;
}
div.dxtcSys,
div.dxtcSys > .dxtc-content > div
{
    display: table;
    border-spacing: 0;
    border-collapse: separate;
}
.dxtcSys {
    overflow: auto!important;
}
.dxtcSys > .dxtc-content {
    float: none!important;
}
div.dxtcSys > .dxtc-content > div,
div.dxtcSys > .dxtc-content > div > div
{
    width: 100%;
    height: 100%;
}
.dxtcSys > .dxtc-stripContainer {
    float: none!important;
    overflow: hidden;
}
div.dxtcSys > .dxtc-content > div > div,
div.dxtcSys.dxtc-left > .dxtc-stripContainer,
div.dxtcSys.dxtc-left > .dxtc-content,
div.dxtcSys.dxtc-right > .dxtc-stripContainer,
div.dxtcSys.dxtc-right > .dxtc-content
{
    display: table-cell;
    vertical-align: top;
}
.dxtc-left > .dxtc-stripContainer,
.dxtc-right > .dxtc-stripContainer {
    width: 1px;
}
.dxtcSys.dxtc-top > .dxtc-stripContainer .dxtc-leftIndent.dxtc-it,
.dxtcSys.dxtc-top > .dxtc-stripContainer .dxtc-rightIndent.dxtc-it,
.dxtcSys.dxtc-bottom > .dxtc-stripContainer .dxtc-leftIndent.dxtc-it,
.dxtcSys.dxtc-bottom > .dxtc-stripContainer .dxtc-rightIndent.dxtc-it {
    width: auto;
}
.dxtcSys.dxtc-left > .dxtc-stripContainer .dxtc-leftIndent.dxtc-it,
.dxtcSys.dxtc-left > .dxtc-stripContainer .dxtc-rightIndent.dxtc-it,
.dxtcSys.dxtc-right > .dxtc-stripContainer .dxtc-leftIndent.dxtc-it,
.dxtcSys.dxtc-right > .dxtc-stripContainer .dxtc-rightIndent.dxtc-it {
    height: auto;
}
.dxtc-link {
    line-height: 100%!important;
}
/* Bootstrap correction */
.dxtc-content,
.dxtc-stripContainer,
.dxtc-stripContainer > * {
    -webkit-box-sizing: content-box;
    -moz-box-sizing: content-box;
    box-sizing: content-box;
}
.dxtcSys.dxtc-multiRow .dxtc-stripContainer > .dxtc-lineBreak {
    visibility: hidden!important;
}
/* initialization */
.dxtcSys.dxtc-init > .dxtc-stripContainer {
    visibility: hidden;
}
.dxtcSys.dxtc-init > .dxtc-content {
    border-color: transparent!important;
}

.dxtcSys .dxtc-tab,
.dxtcSys .dxtc-activeTab
{
    -ms-touch-action: manipulation;
    touch-action: manipulation;
}

/* ie7 */
.dxtcSys > .dxtc-content > table {
    width: 100%;
    height: 100%;
}
.dxtcSys > .dxtc-content > table > tbody > tr > td {
    height: 100%;
}
td.dxtcSys,
td.dxtcSys > .dxtc-content > table > tbody > tr > td
{
    vertical-align: top;
    float: none!important;
}
td.dxtcSys.dxtc-left > .dxtc-stripContainer,
td.dxtcSys.dxtc-right > .dxtc-stripContainer
{
    width: auto;
}
td.dxtc-stripHolder
{
    width: 1px;
}
td.dxtcSys.dxtc-left > .dxtc-stripContainer .dxtc-leftIndent,
td.dxtcSys.dxtc-left > .dxtc-stripContainer .dxtc-rightIndent,
td.dxtcSys.dxtc-left > .dxtc-stripContainer .dxtc-spacer,
td.dxtcSys.dxtc-left > .dxtc-stripContainer .dxtc-tab,
td.dxtcSys.dxtc-left > .dxtc-stripContainer .dxtc-activeTab,
td.dxtcSys.dxtc-right > .dxtc-stripContainer .dxtc-leftIndent,
td.dxtcSys.dxtc-right > .dxtc-stripContainer .dxtc-rightIndent,
td.dxtcSys.dxtc-right > .dxtc-stripContainer .dxtc-spacer,
td.dxtcSys.dxtc-right > .dxtc-stripContainer .dxtc-tab,
td.dxtcSys.dxtc-right > .dxtc-stripContainer .dxtc-activeTab
{
    float: none!important;
}
td.dxtcSys.dxtc-left > .dxtc-stripContainer .dxtc-leftIndent,
td.dxtcSys.dxtc-left > .dxtc-stripContainer .dxtc-rightIndent,
td.dxtcSys.dxtc-left > .dxtc-stripContainer .dxtc-spacer,
td.dxtcSys.dxtc-right > .dxtc-stripContainer .dxtc-leftIndent,
td.dxtcSys.dxtc-right > .dxtc-stripContainer .dxtc-rightIndent,
td.dxtcSys.dxtc-right > .dxtc-stripContainer .dxtc-spacer
{
    clear: both;
    overflow: hidden;
    line-height: 0;
    font-size: 0;
}

/* ASPxTreeView */
.dxtv-nd
{
    line-height: 100%;
    cursor: pointer;
}
.dxtv-btn 
{
    cursor: pointer;
}
.dxtv-ndTxt,
.dxtv-ndImg
{
    cursor: inherit!important;
}
.dxtv-ndChk
{
    padding: 0!important;
    cursor: default!important;
}
a > .dxtv-ndChk
{
	display: inline-block!important;
}
.dxtv-ndSel
{
	cursor: default;
}
.dxtv-clr
{
	clear: both;
	font-size: 0;
	height: 0;
	visibility: hidden;
	width: 0;
	display: block;

	line-height: 0;
}

/* ASPxTitleIndex */
.dxtiControlSys > tbody > tr > td
{
    padding: 16px;
}
.dxtiIndexPanelSys
{
    line-height: 160%;
}
.dxtiFilterBoxEditSys
{
	font: inherit;
    font-weight: normal;
	width: 158px;
	padding: 2px;
}
.dxti-link,
.dxtiIndexPanelSys span[onclick]
{
    cursor: pointer;
}
.dxFirefox .dxtiFilterBoxEditSys
{
    padding-top: 1px;
    padding-bottom: 1px;
}
/* ASPxCloudControl */
.dxccControlSys > tbody > tr > td
{
    padding: 16px;
    vertical-align: top;
}
.dxccLink
{
    cursor: pointer;
}
.dxccValue
{
    color: darkgray;
    margin-left: 2px;
}
.dxccBEText
{
    color: #777aab;
}
/* ASPxDocking - Dock zone */
.dxdzControlVert 
{
    width: 200px;
    height: 400px;
}

.dxdzControlHor
{
    width: 400px;
    height: 200px;
}

.dxdzControlFill
{
    width: 400px;
    height: 400px;
}

.dxdzDisabled
{
}

.dxdzControlVert .dxdz-pnlPlcHolder, 
.dxdzControlHor .dxdz-pnlPlcHolder,
.dxdzControlFill .dxdz-pnlPlcHolder
{
    width: 0;
    height: 0;
    border: 2px solid #A3B5DA;
    background-color: #D1DAEC;
}

.dxdzControlHor .dxdz-pnlPlcHolder
{
    float: left;
}

/* Splitter */
.dxsplIF {
	display: block;
}
.dxsplS
{
	font-size: 0;
	line-height: 0;
    display: inline-block;
}
.dxsplLCC,
.dxsplCC,
.dxsplS
{
	overflow: hidden;
}
.dxsplCC,
.dxsplP
{
	width: 100%;
	height: 100%;
}
.dxsplLCC *[class^="col-xs-"], /*Bootstrap correction*/
.dxsplLCC *[class^="col-sm-"],
.dxsplLCC *[class^="col-md-"],
.dxsplLCC *[class^="col-lg-"]
{
    position: static;
}

/* Mobile */
.dxTouchVScrollHandle, .dxTouchHScrollHandle
{
    background-color: Black;
    position: absolute;
    opacity: 0;
    border-radius: 5px;
	transition-property: opacity;
    transition-duration: 0.3s;
    transition-timing-function: ease-out;
    -webkit-transition-property: opacity;
    -webkit-transition-duration: 0.3s;
    -webkit-transition-timing-function: ease-out;
}
.dxTouchVScrollHandle
{
    width: 5px;
    height: 50%;
    margin-bottom: 3px;
}
.dxTouchHScrollHandle
{
    width: 50%;
    height: 5px;
    margin-right: 3px;
}
.dxTouchScrollHandleVisible
{
	transition-duration: 0s;
    -webkit-transition-duration: 0s;
	opacity: 0.4!important;
}
.dxTouchNativeScrollHandle::-webkit-scrollbar {
	width: 5px;
	height: 5px;
}
.dxTouchNativeScrollHandle::-webkit-scrollbar-thumb {
    background-color: rgba(0, 0, 0, 0.3);
}
.dxTouchNativeScrollHandle::-webkit-scrollbar-corner {
    background: transparent;
}

/* Layout Control */
.dxflHALSys { text-align: left; }
.dxflHALSys > table,
.dxflHALSys > div {
    margin-left: 0px;
    margin-right: auto;
}
.dxflHARSys { text-align: right; }
.dxflHARSys > table,
.dxflHARSys > div {
    margin-left: auto;
    margin-right: 0px;
}
.dxflHACSys { text-align: center; }
.dxflHACSys > table,
.dxflHACSys > div {
    margin-left: auto;
    margin-right: auto;
}
.dxflHALSys > .dxflButtonItemSys,
.dxflHACSys > .dxflButtonItemSys,
.dxflHARSys > .dxflButtonItemSys,
.dxflCommandItemSys {
    white-space: nowrap;
}
.dxflHALSys > .dxflItemSys,
.dxflHACSys > .dxflItemSys,
.dxflHARSys > .dxflItemSys,
.dxflHALSys > .dxflGroupSys,
.dxflHACSys > .dxflGroupSys,
.dxflHARSys > .dxflGroupSys,
.dxflHALSys > .dxflGroupBoxSys,
.dxflHACSys > .dxflGroupBoxSys,
.dxflHARSys > .dxflGroupBoxSys,
div.dxflGroupSys > div > div.dxflHALSys > .dxflPCContainerSys,
div.dxflGroupSys > div > div.dxflHACSys > .dxflPCContainerSys,
div.dxflGroupSys > div > div.dxflHARSys > .dxflPCContainerSys {
	display: table;
    width: auto;
}
.dxflVATSys { vertical-align: top; }
.dxflVAMSys { vertical-align: middle; }
.dxflVABSys { vertical-align: bottom; }

.dxflItemSys,
.dxflGroupBoxSys
{
    text-align: left;
}
.dxflGroupBoxSys.dxflEmptyGroupBoxSys 
{
    padding: 7px 4px 12px 4px; 
}
.dxflGroupBoxSys
{
    box-sizing: border-box;
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
}


*[dir="rtl"] .dxflItemSys,
*[dir="rtl"] .dxflGroupBoxSys
{
    text-align: right;
}

.dxflItemSys.dxflCheckBoxItemSys .dxichCellSys
{
    padding-left: 0;
}
.dxflItemSys.dxflCheckBoxItemSys .dxichCellSys > .dxichSys
{
    margin-left: -1px;
}
*[dir="rtl"] .dxflItemSys.dxflCheckBoxItemSys .dxichCellSys
{
    padding-right: 0;
}
*[dir="rtl"] .dxflItemSys.dxflCheckBoxItemSys .dxichCellSys > .dxichSys
{
    margin-right: -1px;
}
.dxflCaptionCellSys { /* Bootstrap correction */
    -webkit-box-sizing: content-box;
    -moz-box-sizing: content-box;
    box-sizing: content-box;
}
.dxflItemSys.dxflLastRowItemSys {
    padding-bottom: 0;
}
.dxflElConSys {
    display: table;
}
.dxflElConSys > div {
    display: table-cell;
}
div.dxflGroupSys,
div.dxflGroupSys > div {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
div.dxflGroupSys > div {
    display: table;
}
div.dxflGroupSys > div > div {
    display: table-cell;
}
.dxflNotFloatedElSys {
    clear: both;
}
.dxflFloatedElConSys > div {
    float: left;
    width: 100%;
}
*[dir="rtl"] .dxflFloatedElConSys > div {
    float: right;
}
.dxflPCContainerSys {
    display: table;
}
div.dxflGroupSys > div > div > .dxflPCContainerSys {
    width: 100%;
}
.dxflElInAdaptiveView {
    width: 100%!important;
    float: left;
}
div.dxflCLTSys .dxflCaptionCellSys, 
div.dxflCLBSys .dxflCaptionCellSys {
    height: auto !important;
}
div.dxflItemSys,
div.dxflGroupSys {
    border-collapse: separate;
}
.dxflCommandItemSys a {
    margin: 0 3px 0 0;
}
.dxflGroupSys.dxflNoDefaultPaddings {
    padding: 0;
}
.dxflLTR .dxflNoDefaultPaddings > tbody > tr > td:first-child,
.dxflLTR .dxflNoDefaultPaddings > div:first-child > div,
.dxflLTR .dxflNoDefaultPaddings > .dxflNotFloatedElSys > div,
.dxflLTR .dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflLC {
    padding-left: 0;
}
.dxflLTR .dxflNoDefaultPaddings > tbody > tr > td:first-child > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflLHelpTextSys,
.dxflLTR .dxflNoDefaultPaddings > div:first-child > div > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflLHelpTextSys,
.dxflLTR .dxflNoDefaultPaddings > .dxflNotFloatedElSys > div > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflLHelpTextSys,
.dxflLTR .dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflLC > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflLHelpTextSys {
    padding-left: 0!important;
}
.dxflRTL .dxflNoDefaultPaddings > tbody > tr > td:last-child,
.dxflRTL .dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflRC {
    padding-left: 0;
}
.dxflRTL .dxflNoDefaultPaddings > .dxflLastChildInRowSys > div {
    padding-left: 0;
}
.dxflRTL .dxflNoDefaultPaddings > tbody > tr > td:last-child > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflRHelpTextSys,
.dxflRTL .dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflRC > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflRHelpTextSys {
    padding-left: 0!important;
}
.dxflRTL .dxflNoDefaultPaddings > .dxflLastChildInRowSys > div > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflRHelpTextSys {
    padding-left: 0!important;
}
.dxflNoDefaultPaddings > tbody > tr:first-child > td,
.dxflNoDefaultPaddings > .dxflChildInFirstRowSys > div,
.dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflTC {
    padding-top: 0;
}
.dxflNoDefaultPaddings > tbody > tr:first-child > td > .dxflItemSys,
.dxflNoDefaultPaddings > .dxflChildInFirstRowSys > div > .dxflItemSys,
.dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflTC > .dxflItemSys {
    padding-top: 0;
}
.dxflNoDefaultPaddings > tbody > tr:first-child > td > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflTHelpTextSys,
.dxflNoDefaultPaddings > .dxflChildInFirstRowSys > div > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflTHelpTextSys,
.dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflTC > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflTHelpTextSys {
    padding-top: 0!important;
}
.dxflNoDefaultPaddings > tbody > tr:first-child > td > .dxflCLTSys .dxflCaptionCellSys,
.dxflNoDefaultPaddings > .dxflChildInFirstRowSys > div > .dxflCLTSys .dxflCaptionCellSys,
.dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflTC > .dxflCLTSys .dxflCaptionCellSys {
    padding-top: 0;
}
.dxflLTR .dxflNoDefaultPaddings > tbody > tr > td:last-child,
.dxflLTR .dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflRC {
    padding-right: 0;
}
.dxflLTR .dxflNoDefaultPaddings > .dxflLastChildInRowSys > div {
    padding-right: 0;
}
.dxflLTR .dxflNoDefaultPaddings > tbody > tr > td:last-child > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflRHelpTextSys,
.dxflLTR .dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflRC > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflRHelpTextSys {
    padding-right: 0!important;
}
.dxflLTR .dxflNoDefaultPaddings > .dxflLastChildInRowSys > div > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflRHelpTextSys {
    padding-right: 0!important;
}
.dxflRTL .dxflNoDefaultPaddings > tbody > tr > td:first-child,
.dxflRTL .dxflNoDefaultPaddings > div:first-child > div,
.dxflRTL .dxflNoDefaultPaddings > .dxflNotFloatedElSys > div,
.dxflRTL .dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflLC {
    padding-right: 0;
}
.dxflRTL .dxflNoDefaultPaddings > tbody > tr > td:first-child > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflLHelpTextSys,
.dxflRTL .dxflNoDefaultPaddings > div:first-child > div > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflLHelpTextSys,
.dxflRTL .dxflNoDefaultPaddings > .dxflNotFloatedElSys > div > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflLHelpTextSys,
.dxflRTL .dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflLC > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflLHelpTextSys {
    padding-right: 0!important;
}
.dxflNoDefaultPaddings > tbody > tr:last-child > td,
.dxflNoDefaultPaddings > .dxflChildInLastRowSys > div,
.dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflBC {
    padding-bottom: 0;
}
.dxflNoDefaultPaddings > tbody > tr:last-child > td > .dxflItemSys,
.dxflNoDefaultPaddings > .dxflChildInLastRowSys > div > .dxflItemSys,
.dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflBC > .dxflItemSys {
    padding-bottom: 0;
}
.dxflNoDefaultPaddings > tbody > tr:last-child > td > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflBHelpTextSys,
.dxflNoDefaultPaddings > .dxflChildInLastRowSys > div > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflBHelpTextSys,
.dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflBC > .dxflItemSys.dxflItemWithEdgeHelpTextSys .dxflBHelpTextSys {
    padding-bottom: 0!important;
}
.dxflNoDefaultPaddings > tbody > tr:last-child > td > .dxflCLBSys .dxflCaptionCellSys,
.dxflNoDefaultPaddings > .dxflChildInLastRowSys > div > .dxflCLBSys .dxflCaptionCellSys,
.dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflBC > .dxflCLBSys .dxflCaptionCellSys {
    padding-bottom: 0;
}
.dxflNoDefaultPaddings > tbody > tr:first-child > td > .dxflGroupBoxSys,
.dxflNoDefaultPaddings > .dxflChildInFirstRowSys > div > .dxflGroupBoxSys,
.dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflTC > .dxflGroupBoxSys {
    margin-top: 0!important;
}
.dxflNoDefaultPaddings > tbody > tr:last-child > td > .dxflGroupBoxSys,
.dxflNoDefaultPaddings > .dxflChildInLastRowSys > div > .dxflGroupBoxSys,
.dxflNoDefaultPaddingsWithRowSpan > tbody > tr > td.dxflBC > .dxflGroupBoxSys {
    margin-bottom: 0!important;
}

/* ASPxFileManager */
.dxfm-file .dxgv,
.dxfm-file .dxgv .dxfm-fileName
{
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}
.dxfm-file .dxgv.dxfm-fileThumb
{
	text-overflow: clip;
}
.dxTouchUI.dxIE .dxfm-filePane
{
	-ms-touch-action: manipulation;
}
.dxTouchUI.dxEdge .dxfm-filePane
{
	touch-action: manipulation;
}
.dxfm-fileContainer .dxfm-file > .dxichSys
{
    display: none;
    position: absolute;
    top: 1px;
    right: 1px;
}
.dxfm-rtl .dxfm-fileContainer .dxfm-file > .dxichSys
{
	right: initial;
	left: 1px;
}
.dxTouchUI .dxfm-fileContainer .dxfm-file > .dxichSys,
.dxfm-fileContainer .dxfm-file.dxfm-fileH > .dxichSys,
.dxfm-fileContainer.dxfm-faShowCheckBoxes .dxfm-file > .dxichSys
{
	display: inline;
}
.dxfm-fileContainer .dxfm-file.dxfm-fileH > .dxichSys,
.dxfm-fileContainer .dxfm-file.dxfm-fileSA > .dxichSys,
.dxfm-fileContainer .dxfm-file.dxfm-fileSI > .dxichSys,
.dxfm-fileContainer .dxfm-file.dxfm-fileF > .dxichSys
{
    top: 0;
    right: 0;
}
.dxfm-rtl .dxfm-fileContainer .dxfm-file.dxfm-fileH > .dxichSys,
.dxfm-rtl .dxfm-fileContainer .dxfm-file.dxfm-fileSA > .dxichSys,
.dxfm-rtl .dxfm-fileContainer .dxfm-file.dxfm-fileSI > .dxichSys,
.dxfm-rtl .dxfm-fileContainer .dxfm-file.dxfm-fileF > .dxichSys
{
	right: initial;
	left: 0;
}
.dxfm-path
{
    white-space: nowrap;
}
.dxfm-filter > label, /*Bootstrap correction*/
.dxfm-path > label /*Bootstrap correction*/
{
    font: inherit;
    line-height: normal;
    display: inline;
    margin-bottom: 0px;
}
input[type="text"].dxfm-cInput, /*Bootstrap correction*/
input[type="text"].dxfm-rInput, /*Bootstrap correction*/
.dxfm-filter input[type="text"], /*Bootstrap correction*/
.dxfm-path input[type="text"] /*Bootstrap correction*/
{
    display: inline-block;
    height: auto;

    -webkit-box-shadow: none;
    -moz-box-shadow: none;
    box-shadow: none;
    -webkit-transition: none;
    -moz-transition: none;
    -o-transition: none;
    transition: none;
	-webkit-border-radius: 0px;
    -moz-border-radius: 0px;
    border-radius: 0px;
}
li.dxfm-filter /*Bootstrap correction*/
{
    line-height: normal;
}
.dxfm-toolbar *, /*Bootstrap correction*/
.dxfm-rInput,
.dxfm-uploadPanel *
{
    -webkit-box-sizing: content-box;
    -moz-box-sizing: content-box;
    box-sizing: content-box;
}
input[type="text"].dxfm-cInput, /*Bootstrap correction*/
input[type="text"].dxfm-rInput /*Bootstrap correction*/
{
	font: inherit;
	padding: 2px;
	outline-width: 0px;
	margin: 0px;
	color: black;
}
.dxfm-filter input[type="text"], /*Bootstrap correction*/
.dxfm-path input[type="text"] /*Bootstrap correction*/
{
  	font: inherit;
    padding: 2px;
}
.dxfm-filter input[type="text"] /*Bootstrap correction*/
{
	margin: 5px 4px 0px 3px;
	width: 130px;
}
.dxfm-path input
{
	width: 230px;
    margin: 2px 8px 0px 4px;
}
.dxfm-rtl .dxfm-path input
{
    margin: 2px 4px 0px 8px;
}
.dxFirefox input[type="text"].dxfm-cInput, 
.dxFirefox input[type="text"].dxfm-rInput, 
.dxFirefox .dxfm-path input[type="text"],
.dxFirefox .dxfm-filter input[type="text"]
{
    padding-top: 1px;
    padding-bottom: 1px;
}
.dxIE.dxBrowserVersion-11 input[type='text'].dxfm-rInput,
.dxIE.dxBrowserVersion-11 input[type='text'].dxfm-cInput {
    padding-top: 0;
    padding-bottom: 0;    
}
.dxfm-content
{
	overflow: hidden;
}
.dxfm-content .dxfm-itemNameContainer
{
	overflow: hidden;
	width: 100%;
	white-space: nowrap;
	text-overflow: ellipsis;
	-o-text-overflow: ellipsis;
}
.dxfm-rInput
{
	font: inherit;
}
.dxfm-folder .dxfm-rInput
{
	vertical-align: middle;
}
.dxfm-itemMask
{
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
    opacity: 0.75;
    filter: progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=75);
}
.dxfm-epe {
	width: 100%;
	float: left;
}

.dxfm-bcContainer
{
    padding: 9px 2px;
    white-space: nowrap;
}
.dxfm-breadCrumbs .dxfm-bcLineSeparator
{
    border-right: 1px solid;
}
.dxfm-breadCrumbs .dxfm-bcItem,
.dxfm-bcPopup .dxfm-bcItem
{
    border: 1px solid transparent;
    padding: 3px 4px;
    margin: 0 6px;
}
.dxfm-bcPopup .dxfm-bcItem
{
    display: block;
}
.dxfm-bcItem.dxfm-bcLastItem {
    color: #808080;
}
.dxfm-breadCrumbs .dxfm-bcItem.dxfm-bcButton
{
	padding-left: 2px;
	padding-right: 2px;
}
.dxfm-breadCrumbs .dxfm-bcItem img
{
    margin-bottom: -3px;
}
.dxfm-breadCrumbs .dxfm-bcItemH,
.dxfm-bcPopup .dxfm-bcItemH
{
    cursor: pointer;
}
.dxfm-bcContainer span img
{
	margin-bottom: 1px;
}
.dxfm-breadCrumbs .dxfm-bcLineSeparator
{
    padding: 5px 0;
    margin: 0 6px;
}
.dxpc-mainDiv.dxfm-bcPopup .dxpc-content
{
	padding: 5px 0;
}

div.dxfm-upPopup.dxpc-mainDiv
{
    border-width: 0;
}
div.dxfm-upPopup.dxpc-mainDiv,
div.dxfm-upPopup.dxpc-mainDiv .dxpc-contentWrapper,
div.dxfm-upPopup.dxpc-mainDiv .dxpc-contentWrapper .dxpc-content
{
    background-color: rgba(0, 0, 0, 0.36);
    border-radius: 3px;
}
.dxIE.dxBrowserVersion-8 div.dxfm-upPopup.dxpc-mainDiv,
.dxIE.dxBrowserVersion-8 div.dxfm-upPopup.dxpc-mainDiv .dxpc-contentWrapper,
.dxIE.dxBrowserVersion-8 div.dxfm-upPopup.dxpc-mainDiv .dxpc-contentWrapper .dxpc-content
{
    background-color: #414141;
}
div.dxfm-upPopup.dxpc-mainDiv .dxpc-content
{
    padding: 11px 20px 10px 19px;
}
div.dxfm-upPopup.dxpc-mainDiv div table
{
    margin: 4px 0 5px;
	border: none;
}
div.dxfm-upPopup.dxpc-mainDiv table td
{
    background: #616161;
}
div.dxfm-upPopup.dxpc-mainDiv span
{
    color: #9D9D9D;
    margin-left: -2px;
}
div.dxfm-upPopup.dxpc-mainDiv a
{
    color: white;
    float: right;
    border-bottom: 1px dashed white;
    cursor: pointer;
    line-height: 1;
}
/* ASPxCardView */
table.dxcvFT 
{
    padding-top: 0!important;
    padding-left: 0!important;
}
div.dxcvECCW
{
    display: table;
    border-collapse: collapse;
    height: 100%;
    width: 100%;
}
div.dxcvECCW > div
{
    display: table-row;
    vertical-align: top;
}
div.dxcvECCW > div > div
{
    display: table-cell;
}
div.dxcvECEC
{
    height: 100%;
    padding: 0;
    overflow: hidden;
}
div.dxcvECEC > div
{
    height: 100%;
}
div.dxcvFLECW
{
    display: table;
    height: 100%;
    width: 100%;
}
div.dxcvFLECW > div
{
    display: table-cell;
    vertical-align: middle;
}
div.dxcvEMBC > div[id$='DXEPLPC']
{
    height: auto;
}

/* ASPxGridView */
.dxgv *[class^="col-xs-"], /*Bootstrap correction*/
.dxgv *[class^="col-sm-"],
.dxgv *[class^="col-md-"],
.dxgv *[class^="col-lg-"]
{
    position: static;
}
.dxgvADSB, .dxgvADHB
{
    vertical-align: middle;
}
.dxgvADHB > img, .dxgvADSB > img
{
    opacity: 0.5;
}
.dxgvADHB:hover > img, .dxgvADSB:hover > img
{
    opacity: 1;
}
.dxgvAH, 
.dxgvAIC, 
.dxgvAIC .dxgvADHB,
.dxgvAIC .dxgvADHB.dxbButtonSys.dxbTSys,
.dxgvHFC
{
    display: none;
}
.dxgvAE .dxgvAIC,
.dxgvALE .dxgvAIC
{
    display: table-cell;
}
.dxgvALE .dxgvArm > td:not([class*="dxgv"])
{
    width: auto!important;
}
.dxgvADR .dxgvAIC, .dxgvDIC
{
    background-color: inherit!important;
}
.dxgvAIC:last-child
{
    border-right: 0;
}
.dxgvADR > td td.dxgv
{
    border-top-width: 0px;
    border-bottom-width: 0px;
    border-left-width: 0px;
    border-right-width: 0px;
}
.dxgvADR .dxgvAIC
{
    vertical-align: top;
}
.dxgvADR .dxgvADCC
{
    white-space: nowrap;
}
.dxgvADR .dxgvADDC
{
    min-width: 80px;
}
.dxgvADR .dxgvADT .dxgvADCC,
.dxgvADR .dxgvADT .dxgvADDC
{
    vertical-align: top;
}
.dxgvADR .dxgvADDC > .dx-ac
{
    text-align: left;
}

.dxgvADCMDC > *:first-child
{
    margin-left: 0!important;
    margin-bottom: 6px!important;
}
.dxgvADSC
{
    padding: 0!important;
    min-width: 8px;
}
.dxgvADH
{
    display: inline-block;
    margin-bottom: 6px;
    margin-right: 10px;
}
.dxgvADHTR > td
{
    border-width: 1px!important;
}
.dxgvADFSD
{
    display: inline-block;
    margin-bottom: 6px;
    margin-right: 5px;
}

.dxgvHFDRP .dxeButtonEditSys,
.dxgvHFDRP td[id$="HFFDE_CC"],
.dxgvHFDRP td[id$="HFTDE_CC"],
.dxcvHFDRP .dxeButtonEditSys,
.dxcvHFDRP td[id$="HFFDE_CC"],
.dxcvHFDRP td[id$="HFTDE_CC"]
{
    width: 100%;
}

.dxgvHCEC
{
    table-layout: fixed;
    width: 100%;
}
.dxgvADHTR .dxgvHCEC
{
    table-layout: inherit;
    width: inherit;
}

/* Conditional formating*/
.dxFCRule
{
    position: relative;
}
.dxFCRule:before
{
    content: "";
    position: absolute;
    top: 50%;
    bottom: 50%;
    width: 16px;
    height: 16px;
    margin-top: -8px;
}
td.dxFCRule:before,
td.dx-al.dxFCRule:before,
td[align='left'].dxFCRule:before
{
    right: 2px;
    left: auto;
}
td.dx-ar.dxFCRule:before,
td[align='right'].dxFCRule:before
{
    left: 2px;
    right: auto;
}

/* ASPxImageGallery */
.dxigExpandedText
{
    overflow: visible !important;
    white-space: normal !important;
}
.dxigFVIT
{
    display: none;
}
.dxigOPWM
{
    position: relative;
    background-color: #000;
    background-color: rgba(0, 0, 0, 0);
}
.dxig-img 
{
	visibility:hidden;
}
/* ASPxImageSlider */
.dxis-zoomNavigator .dxis-nbTop,
.dxis-zoomNavigator .dxis-nbBottom,
.dxis-zoomNavigator .dxis-nbLeft,
.dxis-zoomNavigator .dxis-nbRight
{
    padding: 0 !important;
}
.dxis-nbHoverItem
{
    top: 0;
    left: 0;
}
.dxisRtl .dxis-nbSelectedItem,
.dxisRtl .dxis-slidePanel,
.dxisRtl .dxis-nbSlidePanel
{
    left: 0;
}
img.dxis-overlayElement,
.dxis-overlayElement > img {
	position: absolute;
	top: 0;
    left: 0;
    display: block;
    width: 100%;
    height: 100%;
    z-index: 1;
    opacity: 0.01;
	filter: progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=1);
}
/* ASPxImageZoom */
.dxiz-wrapper {
    height: 100%;
}
.dxiz-wrapper > img {
	position: absolute;
}
.dxiz-hint,
.dxiz-clipPanel.dxiz-inside {
	z-index: 1;
}
/* ASPxDocumentViewer */
.dxr-oneLineMode .dxr-groupPopupWindow .dxr-block.dxxrdvPageNumbersContainer {
    display: inline-block;
}
.dxr-oneLineMode .dxr-groupPopupWindow .dxxrdvPageNumbersTemplate {
    width: auto;
}
/* ASPxRibbon */
.dxr-tabContent {
    display: none;
    overflow: hidden;
}
.dxr-tabContent .dxr-tabWrapper {
    width: 10000px;
    height: 100%;
}
.dxr-inactiveTab {
    border-left: none!important;
    border-right: none!important;
    width: 0px!important;
    visibility: hidden;
    padding: 0!important;
    margin: 0!important;
}
.dxr-groupList .dxr-group {
    float: left;
    list-style: none;
}
.dxr-group .dxr-grExpBtn,
.dxr-group.dxr-grCollapsed .dxr-groupLabel,
.dxr-group.dxr-grCollapsed .dxr-groupContent,
.dxr-oneLineMode .dxr-group .dxr-groupLabel {
    display: none;
}
.dxr-group.dxr-grCollapsed .dxr-grExpBtn,
.dxr-group.dxr-grCollapsed .dxr-grExpBtn .dxr-img32 {
    display: inline-block;
}
 .dxr-group .dxr-olmGrExpBtn{
    display: none;
    float: left;
}
.dxr-group .dxr-olmGrExpBtn.dxr-olmGrExpBtnVisible{
    display: block;
}
 /*.dxr-group.dxr-grCollapsed .dxr-olmGrExpBtn{
    display: none!important;
}*/
.dxr-oneLineMode .dxr-group.dxr-grCollapsed .dxr-block {
    display: none!important;
}
.dxr-blLrgItems .dxr-img16 {
    display: none!important;
}
.dxr-blLrgItems .dxr-img32 {
    display: inline-block!important;
}
.dxr-blRegItems .dxr-img32,
.dxr-blHorItems .dxr-img32 {
    display: none;
}
.dxr-blLrgItems .dx-clear {
    display: none;
}
.dxr-blHorItems br {
    display: none;
}
.dxr-block {
    display: block;
    float: left;
    overflow: hidden;
}
.dxr-oneLineMode .dxr-groupPopupWindow .dxr-block {
    float: none;
    display: inherit;
}
.dxr-blRegItems .dxr-item,
.dxr-blLrgItems .dxr-item,
.dxr-blHorItems .dxr-item {
    display: block;
    float: left;
    overflow: hidden;
}
.dxr-blHorItems .dxr-item {
    text-align: left;
}
.dxr-blHorItems.dxr-blReduced .dxr-item .dxr-label .dxr-lblText {
    display: none!important;
}
.dxr-blLrgItems .dxr-item .dxr-label {
    display: inline-block;
}
.dxr-blHorItems .dxr-item .dxr-label .dxr-lblText {
    display: inline-block;
}
.dxr-blHorItems.dxr-blHide {
    display: none!important;
}
.dxr-lblContent {
    display: inline-block;
}
.dxr-lblContent,
.dxr-lblText {
	text-decoration: inherit;
}
.dxr-item .dxr-label .dxr-popOut {
    line-height: 0;
}
.dxr-item .dxr-label.dx-vam,
.dxr-item .dxr-label.dx-vat,
.dxr-item .dxr-label.dx-vab {
    line-height: 100%!important;
    padding: 2px 0;
}
.dxr-item .dxr-label.dx-vam span,
.dxr-item .dxr-label.dx-vat span,
.dxr-item .dxr-label.dx-vab span {
    line-height: 100%!important;
}
.dxr-ddImageContainer.dx-vam,
.dxr-ddImageContainer.dx-vat,
.dxr-ddImageContainer.dx-vab
{
    padding: 0;
}
.dxr-blRegItems .dxr-itemSep,
.dxr-blLrgItems .dxr-itemSep {
    float: left;
}
.dxr-groupList {
    float: left;
}
.dxr-groupList .dxr-groupSep {
    float: left;
}
.dxr-blRegItems .dxr-regClear-0 {
    display: block;
}
.dxr-blRegItems .dxr-regClear-1 {
    display: none;
}
.dxr-blRegItems.dxr-blReduced .dxr-regClear-0 {
    display: none;
}
.dxr-blRegItems.dxr-blReduced .dxr-regClear-1 {
    display: block;
}
.dxr-item .dxr-label .dxr-popOut {
    -moz-user-select: -moz-none;
    -khtml-user-select: none;
    -webkit-user-select: none;
    -o-user-select: none;
    -ms-user-select: none;
    user-select: none;
}
.dxr-groupContent .dxr-block .dxr-item.dxr-hasWidth {
    max-height: none;
    max-width: none;
}
.dxr-group .dxr-grExpBtn.dxr-hasWidth {
    max-height: none;
    max-width: none;
}

.dxr-blHorItems .dxr-itemSep {
    display: none;
}
.dxr-blHorItems .dxr-item {
    vertical-align: middle;
}

.dxr-glrItem
{
    display: inline-block;
    white-space: nowrap;
    cursor: pointer;
    padding: 1px;
    border: 1px solid transparent;
    vertical-align: top;
}

.dxr-glrBarContainer
{
    padding-left: 1px;
    margin-top: 1px;
    margin-bottom: 1px;
    padding-right: 1px;
    overflow: hidden;
}

.dxrSys * {
    -webkit-box-sizing: content-box;
    -moz-box-sizing: content-box;
    box-sizing: content-box;
}

.dxrSys.dxr-hasContextTabs .dxr-minBtn {
    line-height: 24px;
}

.dxrSys.dxr-hasContextTabs .dxtc-top .dxtc-stripContainer .dxtc-strip .dxtc-tab,
.dxrSys.dxr-hasContextTabs .dxtc-top .dxtc-stripContainer .dxtc-strip .dxtc-activeTab,
.dxrSys.dxr-hasContextTabs .dxtc-top .dxtc-stripContainer .dxtc-strip .dxtc-tab.dxr-contextTab,
.dxrSys.dxr-hasContextTabs .dxtc-top .dxtc-stripContainer .dxtc-strip .dxtc-activeTab.dxr-contextTab {
    margin-top: 8px;
}

.dxrSys.dxr-hasContextTabs .dxtc-top > .dxtc-stripContainer {
    padding-top: 0px;
}

.dxtcSys .dxtc-stripContainer .dxtc-tab.dxr-contextTab {
    overflow: visible;
}

.dxtcSys .dxtc-stripContainer .dxtc-tab.dxr-contextTab .dxtc-link {
    height: auto;
}

.dxtcSys .dxtc-stripContainer .dxtc-activeTab.dxr-contextTab {
    overflow: visible;
}

.dxr-contextTabColor, .dxtc-tab.dxtc-tabHover .dxr-contextTabColor {
    width: 100%;
    height: 9px;
    margin-left: -1px;
    margin-top: -9px;
    padding-right: 2px;
    
}

.dxtc-tab.dxtc-tabHover.dxr-contextTab .dxr-contextTabColor,
.dxtc-activeTab.dxr-contextTab .dxr-contextTabColor {
    margin-bottom: 1px;
    padding-top: 0px;
    height: 8px;
    opacity: 0.35;
    filter: progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=35);
}

.dxr-contextTabBodyColor {
    height: 100%;
    width: 100%;
    left: 0;
    top: 0;
    position: absolute;
    opacity: 0.35;
    filter: progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=35);
}

.dxtc-activeTab.dxr-contextTab .dxr-contextTabBodyColor,
.dxr-contextTab.dxtc-tabHover .dxr-contextTabBodyColor {
    opacity: 0;
    filter: progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=100);
}

.dxr-contextTab .dxtc-link,
.dxr-contextTab .dxtc-link .dx-vam {
    position: relative;
}

.dxtc-tab .dxr-contextTabColor {
    margin-left: 0px;
    padding-right: 0px;
    opacity: 0.35;
    filter: progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=35);
}

/*ASPxRoundPanel*/
.dxrpcontent, .dxrpCW, .dxrpAW {
    height: 100%;
    width: 100%;
}
.dxrpCollapsed .dxrpcontent > .dxrpAW > .dxrpCW {
	height: auto;
}
.dxrpCollapsed .dxrpcontent > .dxrpCW, 
.dxrpAW {
    overflow-y: hidden;
}
.dxrpCollapsed > tbody > .dxrpCR > .dxrpcontent {
	border-top: none !important;
	border-bottom: none !important;
}
.dxrpCollapsed,
.dxrpCollapsed > tbody > .dxrpCR > .dxrpcontent,
.dxrpCollapsed > tbody > .dxrpCR > .dxrpcontent > .dxrpCW,
.dxrpCollapsed > tbody > .dxrpCR > .dxrpcontent > .dxrpAW {
    height: 0px !important;
	min-height:0px !important;
}
.dxrpCollapsed > tbody > .dxrpCR > .dxrpcontent > .dxrpCW {
	display: block !important;
}
.dxrpHS {
	height:0px;
}
.dxrpCollapsed .dxrpHS{
    display: none;
}
.dxrpCollapsed > tbody > .dxrpCR > .dxrpcontent > .dxrpCW,
.dxrpCollapsed > tbody > .dxrpCR > .dxrpcontent > .dxrpAW > .dxrpCW {
	padding-top: 0 !important;
	padding-bottom: 0 !important;
}
.dxrpCollapseButton > img,
.dxrpCollapseButtonRtl > img {
	display:block;
}
.dxrpCollapseButtonRtl {
	margin-right:4px;
}
.dxrpCollapseButton {
	margin-left:4px;
}
.dxrp-headerClickable,
.dxrpCollapseButton,
.dxrpCollapseButtonRtl {
	cursor:pointer;
}
.dxrpCollapseButton {
	float:right;
}
.dxrpCollapseButtonRtl {
	float:left;
}
.dxrp-collapseBtnDisabled{
    cursor: default;
}
/* ASPxLoadingPanel */
.dxlp-loadingImage.dxlp-imgPosRight {
	margin-left:8px;
}
.dxlp-loadingImage.dxlp-imgPosLeft {
	margin-right:8px;
}
.dxlp-loadingImage.dxlp-imgPosTop {
	margin-bottom:8px;
}
.dxlp-loadingImage.dxlp-imgPosBottom {
	margin-top:8px;
}
.dxlp-withoutBorders,
.dxlp-withoutBorders * 
{
	background-color:transparent !important;
	border-style:none !important;
	box-shadow: 0px 0px 0px 0px rgba(0,0,0,0.1) !important;
	-webkit-box-shadow: 0px 0px 0px 0px rgba(0,0,0,0.1) !important;
}

/* ASPxSelectContentControl */
.dxic-control 
{
    height: 420px;
    width: 420px;
    overflow: hidden;
    position: relative;
}
.dxic-control > div 
{
    position: absolute;
}
.dxic-control .dxtc-content > div > div 
{
    vertical-align: middle !important;
}
.dxic-control .dxtcSys,
.dxic-fileManager,
.dxic-previewPanel,
.dxic-previewPanel .dxrpcontent 
{
    width: 100%;
}
table.dxic-previewPanel.dxrp-noCollapsing, 
table.dxic-previewPanel.dxrp-noCollapsing > tbody > tr.dxrpCR > td.dxrpcontent.dxrp
{
    border-radius: 0px;
}
.dxic-previewPanel 
{
    background-color: #EDEDED;
    height: 270px !important;
}
.dxic-previewPanel .dxrpcontent.dxrp 
{
    text-align: center;
    vertical-align: middle !important;
    padding: 0px !important;
    color: #B4B4B4 !important;
}
.dxic-control .dxic-formLayout 
{
    height: auto !important;
}
.dxic-previewPanel .dxrpcontent.dxrp > * 
{
    display: block;
}
.dxic-previewPanel .dxic-previewText,
.dxic-previewPanel .dxic-previewUploadTip 
{
    margin-bottom: 10px;
}
.dxic-control .dxic-formLayout > table 
{
    margin: 0 auto;
    max-height: 300px;
    max-width: 600px;
}
table.dxic-previewPanel span.dxic-validationTip
{
    font-size: 0.9em;
}
.dxic-previewUploadTip 
{
    font-size: 1.1em;
}
.dxic-previewPanel .dxic-previewText 
{
    font-size: 1.8em;
}
.dxic-uploadCancelButton 
{
    padding: 0 10px 0 20px;
}

/* OfficeControls */
.dxitcControlSys
{
    display: inline-block;
    text-align: center;
    cursor: default;
}
.dxreControlSys .dxm-item.dxm-tmpl
{
    padding-left: 0px !important;
    border-width: 0px !important;
}
.dxm-item .dxitcControlSys
{
    border-width: 0px;
}
.dxitcControlSys table,
.dxitcControlSys tr,
.dxitcControlSys td
{
    border-spacing: 0px;
}
.dxitcControlSys td {
    padding: 1px;
}
.dxitcControlSys table
{
    cursor: pointer;
}
