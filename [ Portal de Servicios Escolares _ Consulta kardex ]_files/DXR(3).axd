/* Button */
.dxbButtonSys
{
	cursor: pointer;
	display: inline-block;
	text-align: center;
	white-space: nowrap;
}
.dxbButtonSys.dxbTSys
{
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;

	display: inline-table;
    border-spacing: 0;
    border-collapse: separate;
}
div.dxbButtonSys
{
	vertical-align: middle;
}
a.dxbButtonSys
{
    border: 0;
    background: none;
    padding: 0;
}
a.dxbButtonSys > span
{
    text-decoration: inherit;
}
.dxbButtonSys /*Bootstrap correction*/
{
    -webkit-box-sizing: content-box;
    -moz-box-sizing: content-box;
    box-sizing: content-box;
}
.dxbButtonSys > div
{
    line-height: 100%; 
    text-decoration: inherit;
}
.dxbButtonSys.dxbTSys > div
{
    display: table-cell;
    vertical-align: middle;
}
/* ListBox */
.dxlbd { /*Bootstrap correction*/
    -webkit-box-sizing: content-box;
    -moz-box-sizing: content-box;
    box-sizing: content-box;
}
/* CheckBox, CheckBoxList */
*[class^="dxeBase"] label /*Bootstrap correction*/
{
    font: inherit;
    line-height: normal;
    margin-bottom: 0px;
    display: inline;
}
/* FilterControl */
td.dxfc 
{
    line-height: 21px;
    vertical-align: middle;
}
td.dxfc > img,
td.dxfc > a 
{
    display: inline-block;
    vertical-align: middle;
}
/* TextEdit */
.dxeMemoEditAreaSys 
{
    padding: 3px 3px 0px 3px;
    margin: 0px;
    border-width: 0px;
	display: block;
	resize: none;
}
.dxic .dxeEditAreaSys
{
	padding: 0px 1px 0px 0px;
}
.dxeEditAreaSys 
{
    border: 0px!important;
    background-position: 0 0; /* iOS Safari */
    -webkit-box-sizing: content-box; /*Bootstrap correction*/
    -moz-box-sizing: content-box; /*Bootstrap correction*/
    box-sizing: content-box; /*Bootstrap correction*/
}
.dxeEditAreaSys,
input[type="text"].dxeEditAreaSys, /*Bootstrap correction*/
input[type="password"].dxeEditAreaSys /*Bootstrap correction*/
{
    padding: 0px 1px 0px 0px; /* B146658 */
}
input[type="text"].dxeEditAreaSys, /*Bootstrap correction*/
input[type="password"].dxeEditAreaSys /*Bootstrap correction*/
{
    margin-top: 0;
    margin-bottom: 0;
}
.dxeEditAreaSys,
.dxeMemoEditAreaSys, /*Bootstrap correction*/
input[type="text"].dxeEditAreaSys, /*Bootstrap correction*/
input[type="password"].dxeEditAreaSys /*Bootstrap correction*/
{
    font: inherit;
    line-height: normal;
    outline: 0;
}

.dxeMemoEditAreaSys, /*Bootstrap correction*/
input[type="text"].dxeEditAreaSys, /*Bootstrap correction*/
input[type="password"].dxeEditAreaSys /*Bootstrap correction*/
{
    display: block;
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
.dxeMemoEditAreaSys /*Bootstrap correction*/
{
    height: auto;
    color: black;
}
table.dxeTextBoxSys.form-control /*Bootstrap correction*/
{
    display: table;
}
table.dxeMemoSys.form-control /*Bootstrap correction*/
{
    display: table;
    padding: 0;
}
.dxeMemoSys textarea /*Bootstrap correction*/
{
    -webkit-box-sizing: content-box;
    -moz-box-sizing: content-box;
    box-sizing: content-box;
}
.dxeMemoSys td 
{
    padding: 0px 6px 0px 0px;
}
*[dir="rtl"].dxeMemoSys td 
{
    padding: 0px 0px 0px 6px;
}
.dxeTextBoxSys, 
.dxeMemoSys 
{
    border-collapse:separate!important;
}

.dxeTextBoxDefaultWidthSys,
.dxeButtonEditSys 
{
    width: 170px;
}

.dxeButtonEditSys .dxeButton,
.dxeButtonEditSys .dxeButtonLeft
{
    line-height: 100%;
}

.dxeButtonEditSys .dxeEditAreaSys,
.dxeButtonEditSys td.dxic,
.dxeTextBoxSys td.dxic,
.dxeMemoSys td,
.dxeEditAreaSys
{
	width: 100%;
}

.dxeTextBoxSys td.dxic
{
    padding: 3px 3px 2px 3px;
    overflow: hidden;
}
.dxeButtonEditSys td.dxic 
{
    padding: 2px 2px 1px 2px;
    overflow: hidden;
}
.dxeButtonEditSys[style*="border-collapse:collapse"] td.dxic,
.dxeButtonEditSys[cellspacing="0"] td.dxic 
{
    padding: 3px 3px 2px 3px;
}
.dxHideContent *
{
    visibility: hidden;
}

/* Safari */
.dxeTextBoxSys.dxeSafariSys td.dxic
{
    padding-left: 2px;
}
.dxeButtonEditSys.dxeSafariSys td.dxic  
{
    padding-left: 1px;
}
.dxeButtonEditSys[style*="border-collapse:collapse"].dxeSafariSys td.dxic,
.dxeButtonEditSys[cellspacing="0"].dxeSafariSys td.dxic 
{
    padding-left: 2px;
}
*[dir="rtl"].dxeTextBoxSys.dxeSafariSys td.dxic
{
    padding-right: 2px;
}
*[dir="rtl"].dxeButtonEditSys.dxeSafariSys td.dxic 
{
    padding-right: 1px;
}
*[dir="rtl"].dxeButtonEditSys[style*="border-collapse:collapse"].dxeSafariSys td.dxic,
*[dir="rtl"].dxeButtonEditSys[cellspacing="0"].dxeSafariSys td.dxic 
{
    padding-right: 2px;
}

*[dir="rtl"].dxeSafariSys .dxeMemoEditAreaSys 
{
    padding-right: 4px;
    padding-left: 3px;
}
*[dir="rtl"].dxeSafariSys td.dxic 
{
    padding-left: 7px;
    padding-right: 0px;
}

.dxIE.dxBrowserVersion-8 .dxeMemoEditAreaSys
{
    padding-right: 4px;
}
.dxIE.dxBrowserVersion-8 .dxeMemoSys td
{
    padding-right: 7px;
}
.dxIE.dxBrowserVersion-8 *[cols="20"].dxeMemoEditAreaSys
{
    width: 100%;
}
.dxIE.dxBrowserVersion-8 *[dir="rtl"].dxeMemoSys td
{
    padding-left: 7px;
}
.dxIE.dxBrowserVersion-8 *[dir="rtl"] .dxeEditAreaSys
{
    padding-right: 1px;
}

/* IE9 */
:root *[cols="20"].dxeMemoEditAreaSys 
{
    width: 100%;
}

/* IE10 */
.dxeHideDefaultIEClearBtnSys::-ms-clear
{
	display: none;
}

/* WebKit */
.dxWebKitFamily *[dir="rtl"] .dxeEditAreaSys 
{
    padding-right: 1px;
}
.dxWebKitFamily *[dir="rtl"].dxeMemoSys td 
{
    padding-left: 7px;
}
.dxWebKitFamily *[dir="rtl"].dxeMemoSys .dxeMemoEditAreaSys 
{
    padding-right: 4px;
}

/* iPad */
.dxeIPadSys .dxeMemoEditAreaSys 
{
    padding-left: 1px;
    padding-right: 0px;
}
.dxeIPadSys.dxeMemoSys td 
{
    padding-left: 0px;
    padding-right: 1px;
}
*[dir="rtl"].dxeMemoSys.dxeIPadSys td 
{
    padding-left: 5px;
    padding-right: 0px;
}

/* Opera */
noindex:-o-prefocus, *[dir="rtl"].dxeMemoSys textarea 
{
    padding-right: 3px;
}
noindex:-o-prefocus, *[dir="rtl"].dxeTextBoxSys td.dxic 
{
    padding-right: 3px;
}
noindex:-o-prefocus, *[dir="rtl"].dxeButtonEditSys td.dxic 
{
    padding-right: 2px;
}
noindex:-o-prefocus, 
*[dir="rtl"].dxeButtonEditSys[style*="border-collapse:collapse"] td.dxic,
*[dir="rtl"].dxeButtonEditSys[cellspacing="0"] td.dxic 
{
    padding-right: 3px;
}

noindex:-o-prefocus, *[dir="rtl"] .dxeEditAreaSys 
{
    padding-right: 1px;
}

/* FireFox*/
.dxFirefox .dxeMemoEditAreaSys 
{
    padding-top: 2px;
    padding-right: 0px;
    padding-left: 2px;
}
.dxFirefox .dxeMemoSys td 
{
    padding-right: 2px;   
}
.dxFirefox .dxeTextBoxSys td.dxic
{
    padding-left: 2px;
    padding-right: 2px;
}
.dxFirefox .dxeButtonEditSys td.dxic 
{
    padding-left: 1px;
    padding-right: 1px;
}
.dxFirefox .dxeButtonEditSys[style*="border-collapse:collapse"] td.dxic,
.dxFirefox .dxeButtonEditSys[cellspacing="0"] td.dxic 
{
    padding-left: 2px;
    padding-right: 2px;
}

.dxFirefox *[dir="rtl"].dxeTextBoxSys td.dxic
{
    padding-right: 2px;
}
.dxFirefox *[dir="rtl"].dxeButtonEditSys td.dxic 
{
    padding-right: 1px;
}
.dxFirefox *[dir="rtl"].dxeButtonEditSys[style*="border-collapse:collapse"] td.dxic,
.dxFirefox *[dir="rtl"].dxeButtonEditSys[cellspacing="0"] td.dxic 
{
    padding-right: 2px;
}

.dxFirefox *[dir="rtl"].dxeMemoSys .dxeMemoEditAreaSys 
{
    padding-left: 0px;
    padding-right: 3px;
}
.dxFirefox *[dir="rtl"].dxeMemoSys td 
{
    padding-left: 3px;
}  

/* TrackBar */
.dxeTBLargeTickSys, 
.dxeTBSmallTickSys, 
.dxeTBItemSys
{
	position:absolute;
	background-repeat: no-repeat;
    background-color: transparent;
}

.dxeTBLargeTickSys, .dxeTBSmallTickSys
{
	white-space: nowrap;
}

.dxeTBContentContainerSys
{
	position: relative;
}

.dxeTBVSys a, .dxeTBHSys a
{
	text-indent: -5000px;
    text-align: left;
	overflow: hidden;
	display: block;
	position: absolute;
}

*[dir="rtl"] .dxeTBVSys a,
*[dir="rtl"] .dxeTBHSys a
{
    text-align: right;
}

.dxeTBVSys a:focus,
.dxeTBVSys a:active,
.dxeTBHSys a:focus, 
.dxeTBHSys a:active {
	outline-width: 0px;
}

.dxeTBHSys .dxeTBLTScaleSys .dxeTBSmallTickSys,
.dxeTBHSys .dxeTBLTScaleSys .dxeTBLargeTickSys
{
	background-position: bottom;
}
.dxeTBVSys .dxeTBLTScaleSys .dxeTBSmallTickSys, 
.dxeTBVSys .dxeTBLTScaleSys .dxeTBLargeTickSys
{
	background-position: right;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBSmallTickSys, 
.dxeTBHSys .dxeTBRBScaleSys .dxeTBLargeTickSys
{
	background-position: top;
}
.dxeTBVSys .dxeTBRBScaleSys .dxeTBSmallTickSys, 
.dxeTBVSys .dxeTBRBScaleSys .dxeTBLargeTickSys
{
	background-position: left;
}
.dxeTBBScaleSys .dxeTBSmallTickSys,
.dxeTBBScaleSys .dxeTBLargeTickSys
{
	background-position: center;
}

.dxeFItemSys
{
	background-image: none!important;
}

.dxeTBHSys .dxeTBBScaleSys .dxeTBItemSys
{
	background-position: left;
}
.dxeReversedDirectionSys .dxeTBHSys .dxeTBBScaleSys .dxeTBItemSys
{
	background-position: right;
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBItemSys
{
	background-position: top;
}
.dxeReversedDirectionSys .dxeTBVSys .dxeTBBScaleSys .dxeTBItemSys
{
	background-position: bottom;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBItemSys,
.dxeReversedDirectionSys .dxeTBVSys .dxeTBRBScaleSys .dxeTBItemSys
{
	background-position: bottom left;
}
.dxeReversedDirectionSys .dxeTBHSys .dxeTBLTScaleSys .dxeTBItemSys,
.dxeReversedDirectionSys .dxeTBVSys .dxeTBLTScaleSys .dxeTBItemSys
{
	background-position: bottom right;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBItemSys,
.dxeTBVSys .dxeTBRBScaleSys .dxeTBItemSys 
{
	background-position: top left;
}
.dxeReversedDirectionSys .dxeTBHSys .dxeTBRBScaleSys .dxeTBItemSys,
.dxeTBVSys .dxeTBLTScaleSys .dxeTBItemSys
{
	background-position: top right;
}

.dxeTBScaleSys
{
	position: absolute;
	list-style-type: none!important;
	margin: 0px;
	padding: 0px;
}

.dxeTBVSys .dxeTBRBScaleSys .dxeTBScaleSys
{
	right: 0px;
}
.dxeTBVSys .dxeTBLTScaleSys .dxeTBScaleSys
{
	left: 0px;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBScaleSys
{
	bottom: 0px;
} 
.dxeTBHSys .dxeTBLTScaleSys .dxeTBScaleSys
{
	top: 0px;
}

.dxeFocusedDHSys 
{
	z-index: 6!important;
}

.dxeReversedDirectionSys,
.dxeFocusedMDHSys,
.dxeFocusedSDHSys
{
}

/* Color edit */
.dxcpColorAreaSys {
	background-image: url('/DXR.axd?r=1_42-K2F8m');
	position: relative;
	width: 290px;
	height: 240px;
	overflow: hidden;
	cursor: crosshair;
}
.dxcpHueAreaSys {
	position: relative;
	margin-left: 3px;
	width: 35px;
	height: 242px;
}
.dxcpHueAreaImageSys {
	background-image: url('/DXR.axd?r=1_44-K2F8m');
	position: absolute;
	left: 6px;
	width: 21px;
    height: 240px;
}
.dxcpColorAreaSys,
.dxcpHueAreaSys {
	-webkit-touch-callout: none;
	-webkit-user-select: none;
	-khtml-user-select: none;
	-ms-user-select: none;
	user-select: none;
}
.dxcpColorPointerSys {
	background-image: url('/DXR.axd?r=1_43-K2F8m');
	position: absolute;
	width: 11px;
	height: 11px;
}
.dxcpHuePointerSys {
	background-image: url('/DXR.axd?r=1_45-K2F8m');
	position: absolute;
	width: 35px;
	height: 9px;
}
.dxcpParametersCellSys {
	vertical-align: top;
}
.dxcpParametersCellSys table div {
    min-height: 21px;
}
.dxcpParametersCellSys label /*Bootstrap correction*/
{
    font: inherit;
    line-height: normal;
    display: inline;
    margin-bottom: 0px;
}
.dxcpParametersCellSys input {
	font: inherit;
	margin: 0px 0px 0px 4px;
	padding: 1px 0px 2px 5px;
    line-height: 16px;
    height: 16px;
	width: 60px;
}
.dxeButtonsPanelDivSys input
{
    font: inherit;
}
.dxeAutomaticColorItemSys {
    cursor: pointer;
    overflow: hidden;
}
.dxeAutomaticColorItemSys > div {
    float: left;
}

/* Token box */
.dxeTokenBox
{
    border-spacing: 0px;
    padding: 1px 0 1px 1px;
}
.dxeButtonEditSys td.dxictb {
    margin: 0px -1px -1px 0px;
	display: block;
	float: left;
    cursor: text;
}
.dxeButtonEditSys td.dxictb > span {
    cursor: default;
}
.dxeButtonEditSys td.dxictb,
.dxFirefox .dxeButtonEditSys td.dxictb {
	padding: 0;
}
.dxeButtonEditSys[style*="border-collapse:collapse"] td.dxictb,
.dxeButtonEditSys[cellspacing="0"] td.dxictb 
{
	margin: 0;
}

/* ASPxBinaryImage*/
.dxeTopSys
{
    position: absolute;
    top: 0;
}
.dxeBottomSys
{
    bottom: 0;
    position: absolute;
}
.dxeFillParentSys
{
    height: 100%;
    left: 0;
    position: absolute;
    top: 0;
    width: 100%;
}
.dxeTblSys
{
    display: table;
}
.dxeInlineTblSys
{
    border-spacing: 0;
    display: inline-table;
}
.dxeRowSys
{
    display: table-row;
}
.dxeCellSys
{
    display: table-cell;
    vertical-align: middle;
}
.dxeBinImgSys
{
    border: dashed 1px gray;
    font-family: Tahoma, Geneva, sans-serif;
    height: 150px;
    width: 150px;
}
.dxeBinImgSys > .dxeCellSys
{
    height: 100%;
    position: relative;
    vertical-align: middle;
}
.dxeBinImgBtnSys
{    
    opacity: 0.5;
}
.dxeBinImgBtnHoverSys
{
    opacity: 1 !important;
}
.dxeBinImgBtnSys img
{
    vertical-align: middle;
}
.dxeBinImgBtnShaderSys
{
    background-color: rgba(0, 0, 0, 0.75);
}
.dxeBinImgCPnlSys
{    
    width: 100%;
}
.dxeBinImgCPnlSys.dxeContentCenterSys
{
    text-align: center;
}
.dxeBinImgCPnlSys.dxeContentLeftSys
{
    text-align: left;
}
.dxeBinImgCPnlSys.dxeContentRightSys
{
    text-align: right;
}
.dxeBinImgPreviewContainerSys
{
    font-size: 0px;
    text-align: center;
    top: 0;
}
.dxeBinImgEmptySys img,
.dxeBinImgPreviewContainerSys img
{
    vertical-align: middle;
    max-width: 100%;
    max-height: 100%;
}
.dxeBinImgDisablCoverSys
{
    background-color: rgba(0, 0, 0, 0.3);
}
.dxeBinImgDropZoneSys
{
    background-color: gray;
}
.dxeBinImgEmptySys
{
    color: gray;
}
.dxeBinImgTxtPnlSys
{
    height: 100%;
    position: absolute;
    top: 0;
    width: 100%;
}
.dxeBinImgTxtPnlSys .dxeTblSys,
.dxeBinImgProgressPnlSys  .dxeTblSys
{
    height: 100%;
    width: 100%;
}
.dxeBinImgTxtPnlSys .dxeCellSys
{
    font-size: 200%;
    text-align: center;
    vertical-align: middle;
}
.dxeErrorFrameSys > .dxeBinImgSys
{
    vertical-align: middle;
}
.dxeBinImgProgressPnlSys
{
    background-color: rgba(0, 0, 0, 0.5);
    font: 12px Tahoma, Geneva, sans-serif;
    position: absolute;
}
.dxeBinImgProgressBarContainerSys
{
    margin: 0 auto;
    max-width: 180px;
    text-align: justify;
    width: 70%;
}
.dxeBinImgProgressBarContainerSys a
{
    border-bottom: 1px dashed white;
    color: white !important;
    float: right;
    line-height: 1;
    text-decoration: none;    
}
.dxeBinImgProgressBarContainerSys span
{
    color: #F0F0F0;
    margin-left: -2px;
}
.dxeBinImgProgressBarContainerSys table
{
    margin: 4px 0 5px;
} 
.dxeBinImgContentContainer 
{
    position: relative;
    height: 100%;
    width: 100%;
}
/* Calendar */
.dxeCHS
{
    min-width: 10px;
}
.dxeCFS
{
    min-width: 12px;
}
.dxeCFNFS
{
    min-width: 11px;
}

/*Editor Caption*/
.dxeCaptionHALSys {
    text-align: left;
}
.dxeCaptionHACSys {
    text-align: center;
}
.dxeCaptionHARSys {
    text-align: right;
}
.dxeCaptionVATSys {
    vertical-align: top;
}
.dxeCaptionVAMSys {
    vertical-align: middle;
}
.dxeCaptionVABSys {
    vertical-align: bottom;
}
.dxeCLTSys,
.dxeCLBSys {
    padding: 3px 0;
}

.dxeCLLSys,
*[dir="rtl"] .dxeCLRSys {
    padding-left: 0px;
    padding-right: 6px;
}
.dxeCLRSys,
*[dir="rtl"] .dxeCLLSys {
    padding-right: 0px;
    padding-left: 6px;
}
.tableWithEmptyCaption .dxeCaptionRelatedCell {
    display: none;
}
/* Error frame */
td.dxeNoBorderLeft {
    border-left: 0;
}
td.dxeNoBorderTop {
    border-top: 0;
}
td.dxeNoBorderRight {
    border-right: 0;
}
td.dxeNoBorderBottom {
    border-bottom: 0;
}

.dxeValidStEditorTable .dxeErrorFrameSys {
    border-color: transparent!important;
    background-color: transparent!important;
}

.dxeValidDynEditorTable .dxeFakeEmptyCell {
    display: none;
}

.dxeErrorCellSys img
{
    margin-right: 4px;
}
*[dir='rtl'] .dxeErrorCellSys img
{
    margin-right: 0;
    margin-left: 4px;
}
.tableWithSeparateBorders {
    border-collapse: separate!important;
}
.dxe-backgroundSys {
    background-repeat: repeat;
    background-position: left center;
}
.dxe-loadingImage
{
	background-repeat: no-repeat !important;
    background-position: center center !important;
}

