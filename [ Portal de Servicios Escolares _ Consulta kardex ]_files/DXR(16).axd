/* CheckBox */
.dxICBFocused
{
    outline: 1px dotted #ffcc00;
}
.dxICheckBox 
{
}
/* -- ASPxCloudControl -- */
.dxccControl
{
	font: 12px Tahoma, Geneva, sans-serif;
	text-decoration: none;
	color: #1E3695;
	background-color: #FFFFFF;
}
.dxccControl a
{
	text-decoration: none!important;
	color: #1E3695;
}
.dxccControl a:hover
{
	text-decoration: underline!important;
}
/* Disabled */
.dxccDisabled,
.dxccDisabled span.dxccValue,
.dxccDisabled span.dxccBEText
{
	color: #acacac;
	cursor: default;
}

/* -- ASPxDataView -- */
.dxdvControl 
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: #787878;
}
.dxdvControl td.dxdvCtrl
{
	padding: 12px 40px;
}
.dxdvContent
{
}
.dxdvItem,
.dxdvFlowItem
{
	border: 1px solid #A8A8A8;
	background-color: #F0F0F0;
	padding: 12px;
	height: 180px;
	height: expression("154px");
}
.dxdvFlowItem
{
	float: left;
	overflow: hidden;
}
.dxdvFlowItemsContainer 
{
}
.dxdvEmptyItem
{
	text-align: left;
	vertical-align: top;
	padding: 12px 12px 12px 14px;
	height: 180px;
	height: expression("154px");
}
.dxdvPagerPanel
{
}
.dxdvEmptyData
{
	color: Gray;
}
.dxdvControl .dxdvPagerShowMoreItemsContainer
{
    height: 47px;
	text-align: center;
}
.dxdvControl .dxdvPagerShowMoreItemsContainer a
{
	display: block;
	padding-top: 14px;
	color: #0d45b7;
}
.dxdvControl .dxdvPagerShowMoreItemsContainer a:hover
{
	color: #5494ea;
}
/* Disabled */
.dxdvDisabled
{
	color: #808080;
	cursor: default;
}
/* -- ASPxHeadline -- */
.dxhlControl 
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: black;
}
.dxhlControl a
{
	color: #1E3695;
}
.dxhlContent
{
	font-size: 0.91em;
} 
.dxhlDate
{
    font-size: 0.91em;
	color: Gray;
	white-space: nowrap;
}
.dxhlHeader
{
	font-size: 1.08em;
    font-weight: bold;
	color: #464646;
	line-height: 133%;
}
.dxhlDateHeader
{
	font-weight: normal;
	color: Gray;
}
.dxhlLeftPanel,
.dxhlRightPanel
{
    padding: 1px 0;
}
.dxhlDateLeftPanel,
.dxhlDateRightPanel
{
	color: Gray;
	white-space: nowrap;
}
.dxhlTailDiv
{
}
/* Disabled */
.dxhlDisabled
{
	color: #acacac;
	cursor: default;
}

/* -- ASPxLoadingPanel -- */
.dxlpLoadingPanel,
.dxlpLoadingPanelWithContent
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: #303030;
	background-color: white;
	border: 1px solid #9F9F9F;
}
.dxlpLoadingPanel td.dx,
.dxlpLoadingPanelWithContent td.dx
{
	white-space: nowrap;
	text-align: center;
	padding: 12px;
}
.dxlpLoadingPanel .dxlp-loadingImage,
.dxlpLoadingPanelWithContent .dxlp-loadingImage {
	background: url('/DXR.axd?r=1_97-K2F8m');
	height: 16px;
	width: 16px;
}
.dxlpControl.dxlpLoadingDiv
{
	background-color: white;
	opacity: 0.7;
	filter: progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=70);
}
/* -- ASPxMenu Lite -- */
.dxmLite
{
	font: 12px Tahoma, Geneva, sans-serif;
}
.dxmLite .dxm-main
{
	border: 1px solid #A8A8A8;
	background-color: #F0F0F0;
	padding: 2px;
}

.dxmLite .dxm-vertical 
{
	width: 150px;
}

.dxmLite .dxm-popup 
{
	border: 1px solid #666666;
	background-color: white;
	padding: 1px;
}

.dxmBrdCor 
{
	background-color: white;
}

.dxmLite .dxm-popup .dxm-gutter 
{
	background-image: url('/DXR.axd?r=1_98-K2F8m');
}

.dxmLite .dxm-item 
{
	cursor: default;
    text-align: left;
}
.dxmLite.dxm-rtl .dxm-item 
{
    text-align: right;
}
.dxmLite .dxm-image-t .dxm-item,
.dxmLite .dxm-image-b .dxm-item
{
	text-align: center;
}

.dxmLite .dxm-content
{
    display: block;
	white-space: nowrap;
}

.dxmLite,
.dxmLite .dxm-item a.dx 
{
	color: Black;
}
.dxmLite .dxm-disabled,
.dxmLite .dxm-disabled a.dx 
{
	color: #acacac;
}
.dxmLite .dxm-item a.dx 
{
	text-decoration: none;
}

.dxmLite .dxm-item 
{
	border-width: 1px;
}
.dxmLite.dxm-ltr .dxm-popOut,
.dxmLite.dxm-rtl .dxm-image-l .dxm-popOut
{
	border-width: 0 0 0 1px;
}
.dxmLite.dxm-ltr .dxm-image-r .dxm-popOut,
.dxmLite.dxm-rtl .dxm-popOut
{
	border-width: 0 1px 0 0;
}
.dxmLite .dxm-item,
.dxmLite .dxm-popOut 
{
	border-color: transparent;
	border-style: solid;
}

/* Checked, Selected, Hovered */
.dxmLite .dxm-main .dxm-checked,
.dxmLite .dxm-selected,
.dxmLite .dxm-hovered,
.dxmLite .dxm-main .dxm-dropDownMode.dxm-checked .dxm-popOut,
.dxmLite .dxm-dropDownMode.dxm-selected .dxm-popOut,
.dxmLite .dxm-dropDownMode.dxm-hovered .dxm-popOut 
{
	border-color: #888888;
}
.dxmLite .dxm-main .dxm-checked,
.dxmLite .dxm-main .dxm-selected 
{
	background-color: white;
}
.dxmLite .dxm-main .dxm-hovered 
{
	background-color: #CBCBCB;
}
.dxmLite .dxm-popup .dxm-selected 
{
	background-color: #D8D8D8;
}
.dxmLite .dxm-popup .dxm-hovered 
{
	background-color: #F2F2F2;
}
.dxmLite .dxm-popup .dxm-checked .dxm-image
{	
    border: 1px solid white;
    outline: 1px solid #888888;
    background-color: white;
}
.dxmLite .dxm-popup .dxm-checked .dxm-image.dxWeb_mSubMenuItemChecked
{	
    border: none;
    outline: none;
    background-color: transparent;    
}

/* Content */
.dxmLite .dxm-horizontal .dxm-image-l .dxm-content,
.dxmLite .dxm-horizontal .dxm-image-r .dxm-content 
{
	padding: 3px 7px 4px;
}
.dxmLite .dxm-horizontal .dxm-image-t .dxm-content,
.dxmLite .dxm-horizontal .dxm-image-b .dxm-content 
{
	padding: 3px 11px 4px 10px;
}
.dxmLite .dxm-horizontal .dxm-image-t.dxm-noImages .dxm-item .dxm-content,
.dxmLite .dxm-horizontal .dxm-image-b.dxm-noImages .dxm-item .dxm-content,
.dxmLite .dxm-horizontal .dxm-image-t .dxm-noImage .dxm-content,
.dxmLite .dxm-horizontal .dxm-image-b .dxm-noImage .dxm-content {
	padding: 4px 11px 5px 10px;
}
.dxmLite .dxm-horizontal .dxm-image-l .dxm-subMenu .dxm-content,
.dxmLite .dxm-horizontal .dxm-image-t .dxm-subMenu .dxm-content,
.dxmLite .dxm-horizontal .dxm-image-b .dxm-subMenu .dxm-content 
{
	padding-right: 3px;
}
.dxmLite .dxm-horizontal .dxm-image-l .dxm-dropDownMode .dxm-content 
{
	padding-right: 4px;
}
.dxmLite .dxm-horizontal .dxm-image-r .dxm-subMenu .dxm-content 
{
	padding-left: 3px;
	padding-right: 5px;
}
.dxmLite .dxm-horizontal .dxm-image-r .dxm-dropDownMode .dxm-content 
{
	padding-left: 4px;
	padding-right: 5px;
}
.dxmLite .dxm-horizontal .dxm-image-t .dxm-dropDownMode .dxm-content,
.dxmLite .dxm-horizontal .dxm-image-b .dxm-dropDownMode .dxm-content 
{
	padding-right: 8px;
}

.dxmLite .dxm-vertical .dxm-image-l .dxm-content,
.dxmLite .dxm-vertical .dxm-image-r .dxm-content
{
	padding: 3px 18px 3px 2px;
}
.dxmLite.dxm-rtl .dxm-vertical .dxm-image-l .dxm-content,
.dxmLite.dxm-rtl .dxm-vertical .dxm-image-r .dxm-content
{
	padding: 3px 2px 3px 18px;
}
.dxmLite .dxm-popup .dxm-content 
{
	padding: 3px 18px 3px 3px;
}
.dxmLite.dxm-rtl .dxm-popup .dxm-content 
{
	padding: 3px 3px 3px 18px;
}

.dxmLite .dxm-vertical .dxm-image-r .dxm-noSubMenu .dxm-content,
.dxmLite .dxm-vertical .dxm-image-r .dxm-subMenu .dxm-content,
.dxmLite .dxm-vertical .dxm-image-r .dxm-dropDownMode .dxm-content 
{
	padding-right: 5px;
	padding-left: 14px;
}
.dxmLite .dxm-vertical .dxm-image-t .dxm-content,
.dxmLite .dxm-vertical .dxm-image-b .dxm-content 
{
	padding: 5px 10px 6px;
}

/* Image */
.dxmLite .dxm-horizontal .dxm-image-l .dxm-hasText .dxm-image
{
	margin-right: 5px;
}
.dxmLite .dxm-horizontal .dxm-image-r .dxm-hasText .dxm-image
{
	margin-left: 5px;
}
.dxmLite .dxm-horizontal .dxm-image-t .dxm-hasText .dxm-image 
{
	margin-bottom: 4px;
}
.dxmLite .dxm-horizontal .dxm-image-b .dxm-hasText .dxm-image 
{
	margin-top: 4px;
}
.dxmLite .dxm-vertical .dxm-image-l .dxm-image 
{
	margin-right: 7px;
}
.dxmLite .dxm-vertical .dxm-image-r .dxm-image 
{
	margin-left: 7px;
}
.dxmLite.dxm-ltr .dxm-popup .dxm-image 
{
	margin-right: 12px;
}
.dxmLite.dxm-rtl .dxm-popup .dxm-image 
{
	margin-left: 12px;
}
.dxmLite.dxm-ltr .dxm-popup .dxm-checked .dxm-image 
{
    margin: -1px 11px -1px -1px;
}
.dxmLite.dxm-rtl .dxm-popup .dxm-checked .dxm-image 
{
    margin: -1px -1px -1px 11px;
}
.dxmLite.dxm-ltr .dxm-popup .dxm-content .dxm-image.dxWeb_mSubMenuItem 
{
    margin: 0px 13px 0px 1px;
}
.dxmLite.dxm-rtl .dxm-popup .dxm-content .dxm-image.dxWeb_mSubMenuItem
{
    margin: 0px 1px 0px 13px;
}

/* Image replacement */
.dxmLite.dxm-ltr .dxm-vertical .dxm-image-l.dxm-noImages .dxm-content,
.dxmLite.dxm-ltr .dxm-vertical .dxm-image-r.dxm-noImages .dxm-content  
{
	padding-left: 7px;
}
.dxmLite.dxm-rtl .dxm-vertical .dxm-image-l.dxm-noImages .dxm-content,
.dxmLite.dxm-rtl .dxm-vertical .dxm-image-r.dxm-noImages .dxm-content  
{
	padding-right: 7px;
}
.dxmLite .dxm-vertical .dxm-image-l .dxm-noImage 
{
	padding-left: 23px;
}
.dxmLite .dxm-vertical .dxm-image-r .dxm-noImage 
{
	padding-right: 23px;
}
.dxmLite.dxm-ltr .dxm-popup .dxm-gutter.dxm-noImages .dxm-item,
.dxmLite.dxm-ltr .dxm-popup .dxm-noImage 
{
	padding-left: 29px;
}
.dxmLite.dxm-rtl .dxm-popup .dxm-gutter.dxm-noImages .dxm-item,
.dxmLite.dxm-rtl .dxm-popup .dxm-noImage 
{
	padding-right: 29px;
}

/* PopOut */
.dxmLite .dxm-horizontal .dxm-image-l .dxm-popOut,
.dxmLite .dxm-horizontal .dxm-image-r .dxm-popOut,
.dxmLite .dxm-horizontal .dxm-image-t.dxm-noImages .dxm-popOut,
.dxmLite .dxm-horizontal .dxm-image-t .dxm-noImage .dxm-popOut,
.dxmLite .dxm-horizontal .dxm-image-b.dxm-noImages .dxm-popOut,
.dxmLite .dxm-horizontal .dxm-image-b .dxm-noImage .dxm-popOut 
{
	padding-top: 9px;
	padding-bottom: 9px;
}
.dxmLite .dxm-horizontal .dxm-image-t .dxm-popOut,
.dxmLite .dxm-horizontal .dxm-image-b .dxm-popOut 
{
	padding-top: 27px;
	padding-bottom: 27px;
}
.dxmLite .dxm-horizontal .dxm-image-l .dxm-popOut,
.dxmLite .dxm-horizontal .dxm-image-t .dxm-popOut,
.dxmLite .dxm-horizontal .dxm-image-b .dxm-popOut 
{
	padding-right: 5px;
}
.dxmLite .dxm-horizontal .dxm-image-r .dxm-popOut 
{
	padding-left: 7px;
}
.dxmLite .dxm-horizontal .dxm-dropDownMode .dxm-popOut 
{
	padding-left: 4px;
	padding-right: 4px;
}

.dxmLite .dxm-vertical .dxm-image-l .dxm-popOut,
.dxmLite .dxm-vertical .dxm-image-r .dxm-popOut,
.dxmLite .dxm-popup .dxm-popOut 
{
	padding-top: 7px;
	padding-bottom: 7px;
}
.dxmLite .dxm-vertical .dxm-image-t.dxm-noImages .dxm-popOut,
.dxmLite .dxm-vertical .dxm-image-t .dxm-noImage .dxm-popOut,
.dxmLite .dxm-vertical .dxm-image-b.dxm-noImages .dxm-popOut,
.dxmLite .dxm-vertical .dxm-image-b .dxm-noImage .dxm-popOut 
{
	padding-top: 8px;
	padding-bottom: 9px;
}
.dxmLite .dxm-vertical .dxm-image-t .dxm-popOut,
.dxmLite .dxm-vertical .dxm-image-b .dxm-popOut 
{
	padding-top: 26px;
	padding-bottom: 27px;
}
.dxmLite .dxm-vertical .dxm-image-l .dxm-popOut,
.dxmLite .dxm-vertical .dxm-image-r .dxm-popOut,
.dxmLite .dxm-vertical .dxm-image-t .dxm-popOut,
.dxmLite .dxm-vertical .dxm-image-b .dxm-popOut,
.dxmLite .dxm-popup .dxm-popOut 
{
	padding-left: 4px;
	padding-right: 4px;
}

/* PopOut replacement */
.dxmLite.dxm-ltr .dxm-popup .dxm-noSubMenu 
{
	padding-right: 13px;
}
.dxmLite.dxm-rtl .dxm-popup .dxm-noSubMenu 
{
	padding-left: 13px;
}

/* Spacings, Separator */
.dxmLite .dxm-horizontal .dxm-spacing 
{
	width: 2px;
    min-width: 2px;
	height: 1px;
}
.dxmLite .dxm-vertical .dxm-image-l .dxm-spacing,
.dxmLite .dxm-vertical .dxm-image-r .dxm-spacing,
.dxmLite .dxm-popup .dxm-spacing 
{
	height: 1px;
}
.dxmLite .dxm-vertical .dxm-image-t .dxm-spacing,
.dxmLite .dxm-vertical .dxm-image-b .dxm-spacing 
{
	height: 2px;
}
.dxmLite .dxm-horizontal .dxm-separator 
{
	padding: 6px 2px;
}
.dxmLite .dxm-vertical .dxm-image-l .dxm-separator,
.dxmLite .dxm-vertical .dxm-image-r .dxm-separator,
.dxmLite .dxm-popup .dxm-separator 
{
	padding: 1px 0px;
}
.dxmLite .dxm-vertical .dxm-image-t .dxm-separator,
.dxmLite .dxm-vertical .dxm-image-b .dxm-separator 
{
	padding: 2px 0px;
}
.dxmLite .dxm-separator b 
{
	background-color: #A8A8A8;
}
.dxmLite .dxm-horizontal .dxm-separator b 
{
	height: 100%;
	width: 1px;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
.dxmLite .dxm-vertical .dxm-separator b,
.dxmLite .dxm-popup .dxm-separator b 
{
	height: 1px;
}
.dxmLite.dxm-ltr .dxm-popup .dxm-gutter .dxm-separator 
{
	padding-left: 29px;
}
.dxmLite.dxm-rtl .dxm-popup .dxm-gutter .dxm-separator 
{
	padding-right: 29px;
}

/* Scroll elements */
.dxmLite .dxm-scrollUpBtn, 
.dxmLite .dxm-scrollDownBtn
{
	border: 1px solid #888888;
	background-color: #E0E0E0;
	padding: 1px;
	text-align: center;
}
.dxmLite .dxm-scrollUpBtn
{
	margin-bottom: 1px;
}
.dxmLite .dxm-scrollDownBtn
{
	margin-top: 1px;
}
.dxmLite .dxm-scrollBtnHovered
{
	background-color: #F2F2F2;
}
.dxmLite .dxm-scrollBtnPressed
{
	background-color: #D8D8D8;
}
.dxmLite .dxm-scrollBtnDisabled
{
	cursor: default;
}
.dxmLite .dxm-scrollArea
{
	overflow: hidden;
	position: relative;
}

/* -- ASPxMenu Lite Toolbar mode -- */
.dxmLite .dxm-main.dxmtb 
{
	padding: 2px;
}
/* has image */
.dxmLite .dxm-horizontal.dxmtb .dxm-image-l .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-r .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-l .dxm-subMenu .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-r .dxm-subMenu .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-t .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-b .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-t .dxm-subMenu .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-b .dxm-subMenu .dxm-content
{
	padding: 4px;
}
/* no image */
.dxmLite .dxm-horizontal.dxmtb .dxm-image-l .dxm-subMenu.dxm-noImage .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-r .dxm-subMenu.dxm-noImage .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-l.dxm-noImages .dxm-item .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-r.dxm-noImages .dxm-item .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-l .dxm-noImage .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-r .dxm-noImage .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-t .dxm-subMenu.dxm-noImage .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-b .dxm-subMenu.dxm-noImage .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-t.dxm-noImages .dxm-item .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-b.dxm-noImages .dxm-item .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-t .dxm-noImage .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-b .dxm-noImage .dxm-content
{
	padding: 4px;
}
/* dd has image */
.dxmLite .dxm-horizontal.dxmtb .dxm-image-l .dxm-dropDownMode .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-r .dxm-dropDownMode .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-t .dxm-dropDownMode .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-b .dxm-dropDownMode .dxm-content 
{
	padding: 4px 5px 4px 4px;
}
/* dd no image */
.dxmLite .dxm-horizontal.dxmtb .dxm-image-l .dxm-dropDownMode.dxm-noImage .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-r .dxm-dropDownMode.dxm-noImage .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-t .dxm-dropDownMode.dxm-noImage .dxm-content,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-b .dxm-dropDownMode.dxm-noImage .dxm-content 
{
	padding: 4px;
}

.dxmLite .dxm-popup.dxmtb .dxm-image 
{
	margin-right: 10px;
}
.dxmLite.dxm-rtl .dxm-popup.dxmtb .dxm-image 
{
	margin-right: 0px;
}

.dxmLite .dxm-horizontal.dxmtb .dxm-image-l .dxm-popOut,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-r .dxm-popOut
{
	padding: 10px 3px;
}
.dxmLite .dxm-horizontal.dxmtb .dxm-image-t .dxm-popOut,
.dxmLite .dxm-horizontal.dxmtb .dxm-image-b .dxm-popOut
{
	padding: 18px 4px;
}

.dxmLite .dxmtb.dxm-horizontal .dxm-spacing 
{
	width: 4px;
    min-width: 4px;
	height: 23px;
}
.dxmLite .dxmtb.dxm-horizontal .dxm-separator 
{
	*height: 17px;
}
.dxmLite .dxmtb.dxm-horizontal .dxm-image-t .dxm-separator b,
.dxmLite .dxmtb.dxm-horizontal .dxm-image-b .dxm-separator b 
{
	*height: 30px;
}
.dxmLite .dxm-horizontal.dxmtb .dxtb-comboBoxMenuItem 
{
	padding-top: 1px;
}
.dxmLite .dxm-horizontal.dxmtb .dxtb-labelMenuItem 
{
	padding-top: 6px;
}
   

/* -- ASPxNavBar Lite -- */
.dxnbLite 
{
	color: Black;
	background-color: white;
	font: 12px Tahoma, Geneva, sans-serif;
	list-style: none none outside;
	margin: 0;
	padding: 11px;
	float: left;
	width: 200px;
}
.dxnbLite a
{
	color: black;
	text-decoration: none;
}
.dxnbLite .dxnb-gr 
{
	margin-bottom: 13px;
}
.dxnbLite .dxnb-header,
.dxnbLite .dxnb-headerCollapsed 
{
	background-color: #E0E0E0;
	border: 1px solid #A8A8A8;
	font-weight: bold;
	padding: 4px 10px;
    white-space: nowrap;
}
.dxnbLite .dxnb-header a,
.dxnbLite .dxnb-headerCollapsed a
{
	color: #1E3695;
	text-decoration: underline;
}
.dxnbLite .dxnb-content 
{
	list-style: none none outside;
	margin: 0;
	padding: 5px;
	overflow: hidden;
	border-top: 0 solid #A8A8A8;
	border-right: 1px solid #A8A8A8;
	border-bottom: 1px solid #A8A8A8;
	border-left: 1px solid #A8A8A8;
}
.dxnbLite.dxnb-noHeads .dxnb-content
{
	border-top-width: 1px;
}
.dxnbLite .dxnb-item,
.dxnbLite .dxnb-large,
.dxnbLite .dxnb-bullet 
{
    border: 1px solid Transparent;
	clear: both;
	overflow: hidden;
	cursor: default;
}
.dxnbLite .dxnb-item,
.dxnbLite .dxnb-large,
.dxnbLite .dxnb-tmpl
{
	margin-bottom: 1px;
}
.dxnbLite .dxnb-item.dxnb-link,
.dxnbLite .dxnb-item .dxnb-link
{
	padding: 3px 4px 4px;
    white-space: nowrap;
}
.dxnbLite .dxnb-large.dxnb-link,
.dxnbLite .dxnb-large .dxnb-link
{
	padding: 5px 11px 6px;
    white-space: nowrap;
}
.dxnbLite .dxnb-bullet,
.dxnbLite .dxnb-bulletHover,
.dxnbLite .dxnb-bulletSelected 
{
	padding: 0 5px;
	overflow: visible;
	margin-bottom: 6px;
}
.dxnbLite .dxnb-itemSelected,
.dxnbLite .dxnb-largeSelected
{
	background-color: #D8D8D8;
	border: 1px solid #888888;
}
.dxnbLite .dxnb-itemHover,
.dxnbLite .dxnb-largeHover
{
	background-color: #F2F2F2;
	border: 1px solid #888888;
}
.dxnbLite .dxnb-header,
.dxnbLite .dxnb-headerCollapsed, 
.dxnbLite .dxnb-item,
.dxnbLite .dxnb-itemHover,
.dxnbLite .dxnb-itemSelected,
.dxnbLite .dxnb-bullet,
.dxnbLite .dxnb-bulletHover,
.dxnbLite .dxnb-bulletSelected
{
	text-align: left;
}
.dxnbLite .dxnb-large,
.dxnbLite .dxnb-largeHover,
.dxnbLite .dxnb-largeSelected
{
	text-align: center;
}
.dxnbLite .dxnb-headerHover
{
}
.dxnbLite .dxnb-headerCollapsedHover
{
}
.dxnbLite .dxnb-last
{
	margin-bottom: 0;
}
.dxnbLite .dxnb-btn,
.dxnbLite .dxnb-btnLeft,
.dxnbLite .dxnb-img
{
	border-width: 0;
}

.dxnbLite .dxnb-btn
{
	float: right;
	margin: 0 0 0 4px;
}
.dxnbLite .dxnb-btnLeft,
.dxnbLite .dxnb-rtlHeader .dxnb-btn 
{
	float: left;
	margin: 0 4px 0 0;
}
.dxnbLite .dxnb-img
{
	margin: 0 4px 0 0;
}
.dxnbLite .dxnb-right .dxnb-item .dxnb-img,
.dxnbLite .dxnb-rtlHeader .dxnb-img
{
	margin: 0 0 0 4px;
}
.dxnbLite .dxnb-header.dxnb-header-left,
.dxnbLite .dxnb-headerCollapsed.dxnb-header-left,
.dxnbLite .dxnb-rtlHeader
{
	text-align: right;
}
.dxnbLite .dxnb-top .dxnb-large .dxnb-img
{
	margin-bottom: 3px;
}
.dxnbLite .dxnb-bottom .dxnb-large .dxnb-img
{
	margin-top: 3px;
}
.dxnbLite .dxnb-large .dxnb-img
{
	display: block;
	margin-left: auto;
	margin-right: auto;
}
.dxnbLiteDisabled,
.dxnbLite .dxnbLiteDisabled,
.dxnbLiteDisabled a,
.dxnbLiteDisabled .dxnb-item,
.dxnbLiteDisabled .dxnb-large,
.dxnbLiteDisabled .dxnb-bullet,
.dxnbLiteDisabled .dxnb-header,
.dxnbLiteDisabled .dxnb-headerCollapsed 
{
	color: #acacac;
	cursor: default;
}
   

/* -- ASPxNewsControl -- */
.dxncControl
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: black;
	background-color: White;
}
.dxncControl a
{
	color: #1E3695;
}
.dxncControl td.dxncCtrl
{
	padding: 18px;
}
.dxncContent
{
}
.dxncPagerPanel
{
	padding: 0px 3px;
}
.dxncItem
{
	vertical-align: top;
	border-bottom: 1px solid #A8A8A8;
	padding: 12px 8px;
}
.dxncEmptyItem
{
	vertical-align: top;
	padding: 12px 12px 12px 14px;
}
.dxncBackToTop
{
	color: #404040;
}
.dxncControl .dxncPagerShowMoreItemsContainer
{
    height: 47px;
	text-align: center;
}
.dxncControl .dxncPagerShowMoreItemsContainer a
{
	display: block;
	padding-top: 14px;
	color: #0d45b7;
}
.dxncControl .dxncPagerShowMoreItemsContainer a:hover
{
	color: #5494ea;
}
.dxncEmptyData
{
	color: Gray;
}
/* Disabled */
.dxncDisabled
{
	color: #acacac;
	cursor: default;
}

/* -- ASPxPager Lite -- */
.dxpLite
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: black;
	padding: 5px 2px;
	float: left;

    box-sizing: border-box;
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
}

.dxpLite .dxp-summary,
.dxpLite .dxp-sep,
.dxpLite .dxp-button,
.dxpLite .dxp-pageSizeItem,
.dxpLite .dxp-num,
.dxpLite .dxp-current,
.dxpLite .dxp-ellip
{
	margin-left: 4px;
	font-weight: normal;
}
.dxpLite .dxp-lead
{
	margin-left: 0!important;
}

.dxpLite a
{
	color: #394EA2;
	text-decoration: underline;
}

.dxpLite .dxp-button
{
	color: #394EA2;
	white-space: nowrap;
	text-align: center;
	text-decoration: underline;
    padding: 3px 5px 2px;
}
.dxpLite .dxp-button span
{
    margin-top: 1px;
	text-decoration: underline;
}
.dxpLite .dxp-button img
{
	border: none;
	text-decoration: none;
}
.dxpLite .dxp-button.dxp-bi 
{
    padding: 0;
}
.dxpLite .dxp-button.dxp-bti 
{
    padding: 0 5px;
}
.dxpLite .dxp-disabledButton, 
.dxpLite .dxp-disabledButton span
{
	text-decoration: none;
	color: #acacac;
}
.dxpLite .dxp-pageSizeItem
{
    padding: 1px 4px;
    white-space: nowrap;
}
.dxpLite .dxp-pageSizeItem .dx
{
    display: block;
    float: left;
    margin-top: 1px;
    white-space: nowrap;
}
*[dir="rtl"].dxpLite .dxp-pageSizeItem .dx 
{
    float: right;
}
.dxpLite .dxp-comboBox
{
    display: block;
    float: left;
    background-color: White;
    border: 1px solid #9F9F9F;
    padding: 1px;
    margin: -2px 0px;
}
.dxpLite .dxp-comboBox input
{
    margin: 1px 2px 0px;
}
*[dir="rtl"].dxpLite .dxp-comboBox input
{
    float: right;
}
.dxpLite .dxp-hoverComboBox
{
}
.dxpLite .dxp-pressedComboBox
{
}
.dxpLite .dxp-dropDownButton
{
    padding: 1px 3px 0px;
    border: 1px solid #7F7F7F;
    background: #e6e6e6 url('/DXR.axd?r=1_108-K2F8m') repeat-x top;
    
}
.dxpLite .dxp-hoverDropDownButton
{
    border: 1px solid #606060;
    background: #f2f2f2 url('/DXR.axd?r=1_109-K2F8m') repeat-x top;
}
.dxpLite .dxp-pressedDropDownButton
{
    border: 1px solid #7f7f7f;
    background: #d5d5d5 none repeat 0 0;
}
.dxpLite .dxp-num
{
	color: #394EA2;
	text-decoration: underline;
	padding: 3px 5px 2px;
}

.dxpLite .dxp-current
{
	color: Black;
	text-decoration: none;
	font-weight: bold;
	padding: 3px 3px 2px;
}

.dxSafari .dxpLite .dxp-current {
	margin-top: 0;
}

.dxpLite .dxp-summary,
.dxpLite .dxp-ellip
{
	white-space: nowrap;
	padding: 3px 4px 2px;
}

.dxpLite .dxp-sep
{
	background-color: #cccccc;
	width: 1px;
	height: 12px;
	margin-top: 4px;
}

.dxpLiteDisabled,
.dxpLiteDisabled a,
.dxpLiteDisabled .dxp-summary,
.dxpLiteDisabled .dxp-sep, 
.dxpLiteDisabled .dxp-button,
.dxpLiteDisabled .dxp-num,
.dxpLiteDisabled .dxp-current,
.dxpLiteDisabled .dxp-ellip
{
	color: #acacac;
	border-color: #808080;
	cursor: default;
}

.dxpLite .dxp-disabledComboBox
{
    border: 1px solid #9F9F9F;
}

.dxpLite .dxp-disabledComboBox input
{
    color: #acacac;
}

.dxpLite .dxp-disabledDropDownButton
{
    border-color: #C3C3C3;
    cursor: default;
}

/* -- ASPxPopupControl Lite -- */
.dxpcLite,
.dxdpLite
{
	width: 200px;
	left: 0;
	top: 0;
	position: absolute;
	border-spacing: 0;
	font: 12px Tahoma, Geneva, sans-serif;
	color: black;
}
.dxdpLite {
	display: none;
	visibility: hidden;
}

.dxpcLite .dxpc-mainDiv,
.dxpcLite.dxpc-mainDiv,
.dxdpLite .dxpc-mainDiv,
.dxdpLite.dxpc-mainDiv  
{
	top: 0;
	left: 0;
	background-color: white;
	border: 1px solid #8B8B8B;
}

.dxpcLite a.dxpc-link,
.dxdpLite a.dxpc-link  
{
	color: #1E3695;
}
.dxpcLite a.dxpc-link *,
.dxdpLite a.dxpc-link * 
{
	cursor: pointer;
    text-decoration: underline;
}

.dxpcLite .dxpc-closeBtn,
.dxpcLite .dxpc-pinBtn,
.dxpcLite .dxpc-refreshBtn,
.dxpcLite .dxpc-collapseBtn,
.dxpcLite .dxpc-maximizeBtn,
.dxdpLite .dxpc-closeBtn,
.dxdpLite .dxpc-pinBtn,
.dxdpLite .dxpc-refreshBtn,
.dxdpLite .dxpc-collapseBtn,
.dxdpLite .dxpc-maximizeBtn
{
	padding: 1px 1px 1px 2px;
	float: right;
}

.dxpcLite.dxRtl  .dxpc-closeBtn,
.dxpcLite.dxRtl  .dxpc-pinBtn,
.dxpcLite.dxRtl  .dxpc-refreshBtn,
.dxpcLite.dxRtl  .dxpc-collapseBtn,
.dxpcLite.dxRtl  .dxpc-maximizeBtn,
.dxdpLite.dxRtl  .dxpc-closeBtn,
.dxdpLite.dxRtl  .dxpc-pinBtn,
.dxdpLite.dxRtl  .dxpc-refreshBtn,
.dxdpLite.dxRtl  .dxpc-collapseBtn,
.dxdpLite.dxRtl  .dxpc-maximizeBtn
{
	float: left;
}

.dxpcLite .dxpc-closeBtnHover,
.dxpcLite .dxpc-pinBtnHover,
.dxpcLite .dxpc-refreshBtnHover,
.dxpcLite .dxpc-collapseBtnHover,
.dxpcLite .dxpc-maximizeBtnHover,
.dxdpLite .dxpc-closeBtnHover,
.dxdpLite .dxpc-pinBtnHover,
.dxdpLite .dxpc-refreshBtnHover,
.dxdpLite .dxpc-collapseBtnHover,
.dxdpLite .dxpc-maximizeBtnHover
{
}

.dxpcLite .dxpc-header,
.dxdpLite .dxpc-header 
{
	color: #404040;
	background-color: #DCDCDC;
	border-bottom: 1px solid #C9C9C9;
	padding: 2px 2px 2px 12px;
}

.dxpcLite.dxRtl .dxpc-header,
.dxdpLite.dxRtl .dxpc-header  
{
	padding: 2px 12px 2px 2px;
}

.dxpcLite .dxpc-headerText,
.dxdpLite .dxpc-headerText
{
	white-space: nowrap;
}

.dxpcLite .dxpc-headerImg,
.dxdpLite .dxpc-headerImg
{
	margin: 0 4px 0 0;
}

.dxpcLite.dxRtl .dxpc-headerImg,
.dxdpLite.dxRtl .dxpc-headerImg
{
	margin: 0 0 0 4px;
}

.dxpcLite .dxpc-expandableDiv,
.dxdpLite .dxpc-expandableDiv 
{
	float: left;
	overflow: hidden;
}

.dxpcLite.dxRtl .dxpc-expandableDiv,
.dxdpLite.dxRtl .dxpc-expandableDiv 
{
	float: right;
}

.dxpcLite .dxpc-content,
.dxdpLite .dxpc-content
{
	white-space: normal;
	padding: 9px 12px;
}

.dxpcLite.dxpc-hierarchycal .dxpc-content {
	padding-right: 30px;
}

.dxpcLite .dxpc-footer,
.dxdpLite .dxpc-footer
{
	color: #858585;
	background-color: #F3F3F3;
	border-top: 1px solid #E0E0E0;
}

.dxpcLite .dxpc-footerContent,
.dxdpLite .dxpc-footerContent
{
	padding: 6px 20px 8px 12px;
	min-height: 8px;
}

.dxpcLite.dxRtl .dxpc-footerContent,
.dxdpLite.dxRtl .dxpc-footerContent
{
	padding: 6px 12px 8px 20px;
}

.dxpcLite .dxpc-footerText,
.dxdpLite .dxpc-footerText
{
	white-space: nowrap;
}

.dxpcLite .dxpc-footerImg,
.dxdpLite .dxpc-footerImg
{
	margin: 0 4px 0 0;
}

.dxpcLite.dxRtl .dxpc-footerImg,
.dxdpLite.dxRtl .dxpc-footerImg
{
	margin: 0 0 0 4px;
}

.dxpcLite .dxpc-sizeGrip,
.dxdpLite .dxpc-sizeGrip
{
	float: right;
}

.dxpcLite.dxRtl .dxpc-sizeGrip,
.dxdpLite.dxRtl .dxpc-sizeGrip
{
	float: left;
}

.dxpcModalBackLite,
.dxdpModalBackLite
{
	background-color: #777777;
	opacity: 0.7;
	filter: progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=70);
	position: fixed;
	left: 0;
	top: 0;
	visibility: hidden;
}
.dxpcLiteDisabled,
.dxdpLiteDisabled
{
	color: #808080;
	cursor: default;
}

/* -- ASPxPanel -- */
.dxpnlControl
{
    font: 12px Tahoma, Geneva, sans-serif;
    border: 0px solid #8b8b8b;
}
.dxpnlControl.dxpnl-edge,
.dxpnlControl.dxpnl-edge.dxpnl-bar
{
    background-color: #f7f7f7;
}
.dxpnlControl.dxpnl-edge,
.dxpnlControl.dxpnl-edge .dxpnl-scc,
.dxpnlControl.dxpnl-bar
{
    padding: 8px;
}
.dxpnlControl .dxpnl-btn
{
}
.dxpnlControl .dxpnl-btnHover
{
    background-color: #cfcfcf;
}
.dxpnlControl .dxpnl-btnPressed
{
    background-color: #a0a0a0;
}
.dxpnlControl .dxpnl-btnSelected
{

}
.dxpnlDisabled
{
	color: #acacac;
	cursor: default;
}
/* -- ASPxRoundPanel -- */
.dxrpControl,
.dxrpControlGB
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: #000000;
}
.dxrpControl .dxrpCI
{
	display:block;
}
/*Corner Radius*/
.dxrpControlGB:not(.dxrp-hasDefaultImages),
.dxrpControlGB:not(.dxrp-hasDefaultImages) > tbody > tr.dxrpCR > .dxrpcontent,
.dxrpControl:not(.dxrp-hasDefaultImages)
{
	border-radius: 5px;
}
.dxrpControl:not(.dxrp-hasDefaultImages) .dxrpHeader
{
	border-radius:5px 5px 0px 0px;
}
.dxrpControl:not(.dxrp-hasDefaultImages) > tbody > tr.dxrpCR > .dxrpcontent
{
	border-radius:0px 0px 5px 5px;
}
.dxrpWithoutHeader:not(.dxrp-hasDefaultImages) > tbody > tr.dxrpCR > .dxrpcontent{
	border-radius:5px;
}
/* Header */
.dxrpControl td.dxrpHeader,
.dxrpControl td.dxrpHeader span.dxrpHT,
.dxrpControlGB span.dxrpHeader
{
	color: #313131;
}
.dxrpControl td.dxrpHeader > a,
.dxrpControl td.dxrpHeader > a > span.dxrpHT,
.dxrpControlGB span.dxrpHeader a
{
    color: #1E3695;
}
.dxrpControl td.dxrpHeader
{
	background-color: #DEDEDE;
}
.dxrpControl .dxrpHI,
.dxrpControl td.dxrpHeader,
.dxrpControl td.dxrpHeader span.dxrpHT
{
	white-space: nowrap;
}
/* Header image */
.dxrpControl .dxrpHI
{
	margin-right: 4px;
}
.dxrpControl .dxrpHIR
{
	margin-left: 4px;
}
/* Content */
.dxrpControl > tbody > tr > .dxrpcontent,
.dxrpControlGB > tbody > tr.dxrpCR > .dxrpcontent
{
	vertical-align: top;
}
.dxrpControl > tbody > tr > .dxrpcontent
{
    background-image: none;
    background-color: #F7F7F7;
}
/* Borders */

.dxrpControl td.dxrpHeader,
.dxrpControl > tbody > tr:first-child > .dxrpcontent
{
	border-top: 1px solid #8B8B8B;
}
.dxrpControl td.dxrpHeader,
.dxrpControl > tbody > tr > .dxrpcontent{
	border-left: 1px solid #8B8B8B;
	border-right: 1px solid #8B8B8B;
	border-bottom: 1px solid #8B8B8B;
}
.dxrpControl td.dxrpHeader {
	border-bottom: 1px solid #C6C6C6;
}
.dxrpControlGB > tbody > tr.dxrpCR > .dxrpcontent {
	border: 1px solid #8B8B8B;
}
.dxrpControlGB > tbody > tr.dxrpCR > .dxrpcontent,
.dxrpControlGB span.dxrpHeader
{
    background-image: none;
	background-color: White;
}
.dxrp-hasDefaultImages > tbody > tr > .dxrpHeader {
	border-left:0px none;
	border-right:0px none;
	border-top:0px none;
}
.dxrpControlGB.dxrp-hasDefaultImages > tbody > tr.dxrpCR > .dxrpcontent,
.dxrpControl.dxrp-hasDefaultImages > tbody > tr.dxrpCR > .dxrpcontent {
	border-bottom:0px none;
	border-left:0px none;
	border-right:0px none;
	border-top:0px none;
}
/* Paddings */
.dxrpControl td.dxrpHeader 
{
	padding: 5px 8px 5px 10px;
}
.dxrpControlGB span.dxrpHeader 
{
	padding: 0px 3px 0px 3px;
}
.dxrpControl.dxrp-noCollapsing > tbody > tr.dxrpCR > .dxrpcontent:first-child,
.dxrpControl > tbody > tr.dxrpCR > .dxrpcontent > .dxrpAW > .dxrpCW, .dxrpControl > tbody > tr.dxrpCR > .dxrpcontent >  .dxrpCW
{
	padding: 9px 10px 10px 10px;
}
.dxrpControlGB > tbody > tr.dxrpCR > .dxrpcontent
{
	padding: 6px 10px 10px 10px;
}
/* GroupboxCaptionOffset */
.dxrpControlGB > tbody > tr.dxrpCR > .dxrpcontent > div:first-child
{
	top: -14px;
	left: -2px;
	margin-bottom: -8px;
}
.dxrpControlGB 
{
	margin-top: 7px;
}
/* Disabled */
.dxrpDisabled,
.dxrpDisabled td.dxrp
{
	color: #acacac;
	cursor: default;
}
.dxrpDisabled.dxrpCollapsed > tbody > tr > td.dxrpHeader
{
    border-radius: 5px;
    border: 1px solid #8b8b8b;
}
/* -- ASPxSiteMapControl -- */
.dxsmControl 
{
	color: #1E3695;
	background-color: white;
	font: 12px Tahoma, Geneva, sans-serif;
	border: 1px Solid #A8A8A8;
}
.dxsmControl a:hover
{
	text-decoration: none!important;
}
.dxsmControl a:visited
{
	color: #996085!important;
}
/* - Category Level - */
.dxsmCategoryLevel,
.dxsmCategoryLevel a
{
	color: #1E3695;
	font-weight: bold;
	text-decoration: none;
}
.dxsmCategoryLevel
{
	font-size: 1.5em;
	white-space: nowrap;
	padding: 0px 0px 5px;
	border-bottom: 1px solid #B8B8B8;
}
 /*flow layout*/
.dxsmLevelCategoryFlow,
.dxsmLevelCategoryFlow a
{
	color: #1E3695;
    font-weight: bold;
	text-decoration: underline;
}
.dxsmLevelCategoryFlow
{
	font-size: 1.5em;
}
/* - Level 0 - */
.dxsmLevel0,
.dxsmLevel0 a,
.dxsmLevel0Categorized a,
.dxsmLevel0Categorized
{
	color: #1E3695;
	font-weight: bold;
	text-decoration: none;
}
.dxsmLevel0,
.dxsmLevel0Categorized
{
	white-space: nowrap;
	padding: 0px 0px 2px;
}
.dxsmLevel0
{
	border-bottom: 1px solid #B8B8B8;
	padding: 0px 0px 5px;
}
 /*flow layout*/
.dxsmLevel0Flow,
.dxsmLevel0Flow a,
.dxsmLevel0CategorizedFlow a,
.dxsmLevel0CategorizedFlow
{
	color: #1E3695;
    font-weight: bold;
	text-decoration: underline;
}
.dxsmLevel0Flow
{
	padding: 0px;
}
.dxsmLevel0Flow
{
	text-decoration: none;
}

/* - Level 1 - */
.dxsmLevel1,
.dxsmLevel1 a,
.dxsmLevel1Categorized a,
.dxsmLevel1Categorized
{
	color: #3C55B9;
	text-decoration: none;
}
.dxsmLevel1,
.dxsmLevel1Categorized
{
	white-space: nowrap;
	padding: 0px;
}

/*flow layout*/
.dxsmLevel1Flow,
.dxsmLevel1Flow a,
.dxsmLevel1CategorizedFlow,
.dxsmLevel1CategorizedFlow a
{
	color: #3C55B9;
	text-decoration: underline;
}
.dxsmLevel1Flow
{
	text-decoration: none;
	padding: 0px;
}

/* - Level 2 - */
.dxsmLevel2,
.dxsmLevel2 a,
.dxsmLevel2Categorized a,
.dxsmLevel2Categorized
{
	color: #5078DC;
	text-decoration: none;
}
.dxsmLevel2,
.dxsmLevel2Categorized
{
	font-size: 0.91em;
	white-space: nowrap;
	padding: 0px;
}
/*flow layout*/
.dxsmLevel2Flow,
.dxsmLevel2Flow a
{
	color: #5078DC;
	text-decoration: underline;
}
.dxsmLevel2Flow
{
	font-size: 0.91em;
	padding: 0px;
}
/* - Level 3 - */
.dxsmLevel3,
.dxsmLevel3 a
{
	color: #999999;
	text-decoration: none;
}
.dxsmLevel3
{
	font-size: 0.75em;
	white-space: nowrap;
	padding: 0px;
}
/*flow layout*/
.dxsmLevel3Flow,
.dxsmLevel3Flow a
{
	color: #999999;
	text-decoration: underline;
}
.dxsmLevel3Flow
{
	font-size: 0.75em;
}
/* - Level 4 - */
.dxsmLevel4,
.dxsmLevel4 a
{
	color: #A8A8A8;
	text-decoration: none;
}
.dxsmLevel4
{
	font-size: 0.66em;
	white-space: nowrap;
	padding: 0px;
}
/*flow layout*/
.dxsmLevel4Flow,
.dxsmLevel4Flow a
{
	color: #A8A8A8;
	text-decoration: underline;
}
.dxsmLevel4Flow
{
    font-size: 0.66em;
	padding: 0px;
}
/* - Other Levels - */
.dxsmLevelOther,
.dxsmLevelOther a
{
	color: #A8A8A8;
	text-decoration: none;
}
.dxsmLevelOther
{
    font-size: 0.75em;
	white-space: nowrap;
	padding: 0px;
}
/*flow layout*/
.dxsmLevelOtherFlow,
.dxsmLevelOtherFlow a
{
	color: #A8A8A8;
	text-decoration: underline;
}
/* Disabled */
.dxsmDisabled
{
	color: #acacac;
	cursor: default;
}

/* -- ASPxTabControl Lite -- */
.dxtcLite 
{
	overflow: hidden;
	color: #333333;
	float: left;
    font: 12px Tahoma, Geneva, sans-serif;
}
.dxtcLite > .dxtc-stripContainer,
.dxtcLite > .dxtc-stripContainer .dxtc-strip
{
	list-style: none outside none;
	float: left;
	padding: 0;
	margin: 0;
}
.dxtcLite.dxtc-top > .dxtc-stripContainer
{
	padding-top: 3px;
}
.dxtcLite > .dxtc-stripContainer .dxtc-tab,
.dxtcLite > .dxtc-stripContainer .dxtc-activeTab,
.dxtcLite > .dxtc-stripContainer .dxtc-leftIndent,
.dxtcLite > .dxtc-stripContainer .dxtc-spacer,
.dxtcLite > .dxtc-stripContainer .dxtc-rightIndent,
.dxtcLite > .dxtc-stripContainer .dxtc-sbWrapper,
.dxtcLite > .dxtc-stripContainer .dxtc-sbIndent,
.dxtcLite > .dxtc-stripContainer .dxtc-sbSpacer
{
	display: block;
	margin: 0;
}
.dxtcLite > .dxtc-stripContainer .dxtc-lineBreak
{
	float: none;
	display: block;
	clear: both;
	height: 0;
	width: 0;
	font-size: 0;
	line-height: 0;
	overflow: hidden;
	visibility: hidden;
}
.dxtcLite > .dxtc-stripContainer .dxtc-tab,
.dxtcLite > .dxtc-stripContainer .dxtc-activeTab
{
	border: 1px solid #A8A8A8;
}
.dxtcLite.dxtc-noSpacing > .dxtc-stripContainer .dxtc-tab.dxtc-lead,
.dxtcLite.dxtc-noSpacing > .dxtc-stripContainer .dxtc-activeTab.dxtc-lead,
.dxtcLite.dxtc-noSpacing > .dxtc-stripContainer .dxtc-tab.dxtc-n,
.dxtcLite.dxtc-noSpacing > .dxtc-stripContainer .dxtc-activeTab.dxtc-n
{
	border-left: 1px solid #A8A8A8;
}
.dxtcLite.dxtc-noSpacing > .dxtc-stripContainer .dxtc-tab,
.dxtcLite.dxtc-noSpacing > .dxtc-stripContainer .dxtc-activeTab
{
	border-left-style: none;
}
.dxtcLite > .dxtc-stripContainer .dxtc-tab,
.dxtcLite > .dxtc-stripContainer .dxtc-activeTab
{
	background-color: #E0E0E0;
	float: left;
	overflow: hidden;
	text-align: center;
	white-space: nowrap;
}
.dxtcLite > .dxtc-stripContainer .dxtc-activeTab
{
	background-color: white;
}
.dxtcLite.dxtc-top > .dxtc-stripContainer .dxtc-activeTab
{
	border-bottom-width: 0;
    padding-bottom: 1px;
}
.dxtcLite > .dxtc-stripContainer .dxtc-tabHover
{
	background-color: #F2F2F2;
}
.dxtcLite > .dxtc-stripContainer .dxtc-leftIndent,
.dxtcLite > .dxtc-stripContainer .dxtc-spacer,
.dxtcLite > .dxtc-stripContainer .dxtc-rightIndent,
.dxtcLite > .dxtc-stripContainer .dxtc-sbWrapper,
.dxtcLite > .dxtc-stripContainer .dxtc-sbIndent,
.dxtcLite > .dxtc-stripContainer .dxtc-sbSpacer
{
	float: left;
	border-right-width: 0;
	border-left-width: 0;
	border-top: 1px solid transparent;
	border-bottom: 1px solid #A8A8A8;
	overflow: hidden;
}
.dxtcLite > .dxtc-stripContainer .dxtc-spacer
{
	width: 1px;
}
.dxtcLite > .dxtc-stripContainer .dxtc-leftIndent,
.dxtcLite > .dxtc-stripContainer .dxtc-rightIndent
{
	width: 5px;
}
.dxtcLite > .dxtc-stripContainer .dxtc-link
{
	padding: 3px 12px 4px;
	display: block;
	height: 100%;
    color: #333333;
}
.dxtcLite > .dxtc-stripContainer .dxtc-link,
.dxtcLite > .dxtc-stripContainer .dxtc-leftIndent,
.dxtcLite > .dxtc-stripContainer .dxtc-rightIndent
{
	text-decoration: none;
	white-space: nowrap;
}
.dxtcLite > .dxtc-stripContainer .dxtc-img
{
	border-style: none;
	margin: 0 3px 0 0;
} 
.dxtcLite.dxtc-rtl > .dxtc-stripContainer .dxtc-img
{
	margin: 0 0 0 3px;
}
.dxtcLite > .dxtc-content 
{
	background-color: #FFFFFF;
	float: left;
	clear: left;
	border: 1px solid #A8A8A8;
	overflow: hidden;
	padding: 11px;
}
.dxtcLite.dxtc-top > .dxtc-content 
{
	border-top-style: none!important;
}
/* Rtl */
.dxtcLite.dxtc-rtl,
.dxtcLite.dxtc-rtl > .dxtc-content,
.dxtcLite.dxtc-rtl > .dxtc-stripContainer,
.dxtcLite.dxtc-rtl > .dxtc-stripContainer .dxtc-strip,
.dxtcLite.dxtc-rtl > .dxtc-stripContainer .dxtc-leftIndent,
.dxtcLite.dxtc-rtl > .dxtc-stripContainer .dxtc-spacer,
.dxtcLite.dxtc-rtl > .dxtc-stripContainer .dxtc-rightIndent,
.dxtcLite.dxtc-rtl > .dxtc-stripContainer .dxtc-sbWrapper,
.dxtcLite.dxtc-rtl > .dxtc-stripContainer .dxtc-sbIndent,
.dxtcLite.dxtc-rtl > .dxtc-stripContainer .dxtc-sbSpacer,
.dxtcLite.dxtc-rtl > .dxtc-stripContainer .dxtc-tab,
.dxtcLite.dxtc-rtl > .dxtc-stripContainer .dxtc-activeTab
{
	float: right;
}
.dxtcLite.dxtc-top.dxtc-rtl > .dxtc-content,
.dxtcLite.dxtc-bottom.dxtc-rtl > .dxtc-stripContainer,
.dxtcLite.dxtc-bottom.dxtc-rtl > .dxtc-stripContainer .dxtc-strip
{
	clear: right!important;
}
.dxtcLite.dxtc-left.dxtc-rtl > .dxtc-strip,
.dxtcLite.dxtc-left.dxtc-rtl > .dxtc-stripContainer .dxtc-strip
{
	float: left;
}
.dxtcLite.dxtc-noSpacing.dxtc-rtl > .dxtc-stripContainer .dxtc-tab,
.dxtcLite.dxtc-noSpacing.dxtc-rtl > .dxtc-stripContainer .dxtc-activeTab
{
	border-left: 1px solid #A8A8A8;
	border-right: 1px none #A8A8A8;
}
.dxtcLite.dxtc-noSpacing.dxtc-rtl > .dxtc-stripContainer .dxtc-lead.dxtc-tab,
.dxtcLite.dxtc-noSpacing.dxtc-rtl > .dxtc-stripContainer .dxtc-lead.dxtc-activeTab,
.dxtcLite.dxtc-noSpacing.dxtc-rtl > .dxtc-stripContainer .dxtc-n.dxtc-tab,
.dxtcLite.dxtc-noSpacing.dxtc-rtl > .dxtc-stripContainer .dxtc-n.dxtc-activeTab
{
	border-right: 1px solid #A8A8A8;
}
.dxtcLite.dxtc-noSpacing.dxtc-rtl.dxtc-right > .dxtc-stripContainer .dxtc-tab,
.dxtcLite.dxtc-noSpacing.dxtc-rtl.dxtc-right > .dxtc-stripContainer .dxtc-activeTab
{
	border-right: 1px solid #A8A8A8;
}
.dxtcLite.dxtc-rtl.dxtc-left.dxtc-noSpacing > .dxtc-stripContainer .dxtc-activeTab
{
	border-right-width: 0;
    padding-right: 1px;
}
.dxtcLite.dxtc-noSpacing.dxtc-rtl.dxtc-left > .dxtc-stripContainer .dxtc-tab
{
	border-right: 1px solid #A8A8A8;
}
/* Scrolling */
.dxtcLite > .dxtc-stripContainer .dxtc-sb 
{
	background: #E8E7E8 url('/DXR.axd?r=1_122-K2F8m') repeat-x;
	border: 1px solid #7F7F7F;
	padding: 5px;
}
.dxtcLite.dxtc-bottom > .dxtc-stripContainer .dxtc-sb          
{
	margin-top: 2px;
}
.dxtcLite > .dxtc-stripContainer .dxtc-sbHover
{
	background: #F4F4F4 url('/DXR.axd?r=1_124-K2F8m') repeat-x;
}
.dxtcLite > .dxtc-stripContainer .dxtc-sbPressed
{
	background-color: #8D8D8D;
}
.dxtcLite > .dxtc-stripContainer .dxtc-sbDisabled
{
	cursor: default;
	border-color: #C3C3C3;
	background: #E6E7E8 url('/DXR.axd?r=1_123-K2F8m') repeat-x;
}
.dxtcLite > .dxtc-stripContainer .dxtc-sb img 
{
	border: none;
	border-style: none;
}
.dxtcLite > .dxtc-stripContainer .dxtc-sbIndent
{
	width: 5px;
}
.dxtcLite > .dxtc-stripContainer .dxtc-sbSpacer
{
	width: 1px;
}
/* Multi-row */
.dxtcLiteDisabled,
.dxtcLiteDisabled > .dxtc-stripContainer .dxtc-link,
.dxtcLiteDisabled > .dxtc-stripContainer .dxtc-activeTab .dxtc-link,
.dxtcLiteDisabled > .dxtc-content,
.dxtcLite > .dxtc-stripContainer .dxtcLiteDisabled .dxtc-link
{
	color: #acacac;
	cursor: default;
}
.dxtcLite.dxtc-multiRow.dxtc-top.dxtc-noSpacing > .dxtc-stripContainer .dxtc-tab 
{
	border-bottom-width: 0!important;
	padding-bottom: 1px;
}
.dxtcLite.dxtc-multiRow.dxtc-top > .dxtc-stripContainer .dxtc-tab.dxtc-activeRowItem 
{
	border-bottom-width: 1px!important;
	padding-bottom: 0px;
}
.dxtcLite.dxtc-multiRow.dxtc-bottom.dxtc-noSpacing > .dxtc-stripContainer .dxtc-tab 
{
	border-top-width: 0!important;
	padding-bottom: 1px;
}
.dxtcLite.dxtc-multiRow.dxtc-bottom > .dxtc-stripContainer .dxtc-tab.dxtc-activeRowItem 
{
	border-top-width: 1px!important;
	padding-bottom: 0px;
}
/* bottom  */
.dxtcLite.dxtc-bottom > .dxtc-stripContainer
{
	padding-bottom: 3px;
}
.dxtcLite.dxtc-bottom > .dxtc-stripContainer,
.dxtcLite.dxtc-bottom > .dxtc-stripContainer .dxtc-strip
{
	clear: left;
	*float: none;
}
.dxtcLite.dxtc-bottom > .dxtc-stripContainer .dxtc-leftIndent,
.dxtcLite.dxtc-bottom > .dxtc-stripContainer .dxtc-spacer,
.dxtcLite.dxtc-bottom > .dxtc-stripContainer .dxtc-rightIndent,
.dxtcLite.dxtc-bottom > .dxtc-stripContainer .dxtc-sbWrapper,
.dxtcLite.dxtc-bottom > .dxtc-stripContainer .dxtc-sbIndent,
.dxtcLite.dxtc-bottom > .dxtc-stripContainer .dxtc-sbSpacer
{
	border-top: 1px solid #A8A8A8;
	border-bottom: 1px solid transparent;
}
.dxtcLite.dxtc-bottom > .dxtc-stripContainer .dxtc-activeTab
{
    border-top-width: 0;
    padding-top: 1px;
	background-color: white;
}
.dxtcLite.dxtc-bottom > .dxtc-content
{
	border-top: 1px solid #A8A8A8;
	border-right: 1px solid #A8A8A8;
	border-bottom-color: #A8A8A8;
	border-left: 1px solid #A8A8A8;
	border-bottom-width: 1px;
	border-bottom-style: none!important;
}
/* left */
.dxtcLite.dxtc-left > .dxtc-stripContainer
{
	padding-left: 3px;
}
.dxtcLite.dxtc-left > .dxtc-stripContainer .dxtc-tab,
.dxtcLite.dxtc-left > .dxtc-stripContainer .dxtc-activeTab,
.dxtcLite.dxtc-left > .dxtc-stripContainer .dxtc-leftIndent,
.dxtcLite.dxtc-left > .dxtc-stripContainer .dxtc-spacer,
.dxtcLite.dxtc-left > .dxtc-stripContainer .dxtc-rightIndent
{
	float: none;
	clear: none;
	width: auto;
	height: auto;
}

.dxtcLite.dxtc-left > .dxtc-stripContainer .dxtc-activeTab,
.dxtc-left.dxtc-noSpacing > .dxtc-stripContainer .dxtc-tab,
.dxtc-left.dxtc-noSpacing > .dxtc-stripContainer .dxtc-activeTab
{
	border: 1px solid #A8A8A8;
}
.dxtcLite.dxtc-left.dxtc-noSpacing > .dxtc-stripContainer .dxtc-tab.dxtc-lead,
.dxtcLite.dxtc-left.dxtc-noSpacing > .dxtc-stripContainer .dxtc-activeTab.dxtc-lead
{
	border-top: 1px solid #A8A8A8;
}
.dxtcLite.dxtc-left.dxtc-noSpacing > .dxtc-stripContainer .dxtc-tab,
.dxtcLite.dxtc-left.dxtc-noSpacing > .dxtc-stripContainer .dxtc-activeTab
{
	border-top-style: none;
}
.dxtcLite.dxtc-left > .dxtc-stripContainer .dxtc-activeTab
{
	border-right-width: 0;
    padding-right: 1px;
	background-color: white;
}
.dxtcLite.dxtc-left > .dxtc-stripContainer .dxtc-link
{
    padding: 3px 13px 4px 12px;
}
.dxtcLite.dxtc-left > .dxtc-stripContainer .dxtc-leftIndent,
.dxtcLite.dxtc-left > .dxtc-stripContainer .dxtc-spacer,
.dxtcLite.dxtc-left > .dxtc-stripContainer .dxtc-rightIndent
{
	border: none;
	border-right: 1px solid #A8A8A8;
	border-left: 1px solid transparent;
	width: auto;
}
.dxtcLite.dxtc-left > .dxtc-stripContainer .dxtc-leftIndent,
.dxtcLite.dxtc-left > .dxtc-stripContainer .dxtc-rightIndent
{
	height: 5px;
}
.dxtcLite.dxtc-left > .dxtc-stripContainer .dxtc-spacer
{
	height: 1px;
}
.dxtcLite.dxtc-left > .dxtc-content
{
	border-top: 1px solid #A8A8A8;
	border-right: 1px solid #A8A8A8;
	border-bottom: 1px solid #A8A8A8;
	border-left-color: #A8A8A8;
	border-left-width: 1px;
	border-left-style: none!important;
	float: left;
	clear: none;
}
/* right */
.dxtcLite.dxtc-right > .dxtc-stripContainer
{
	padding-right: 3px;
}
.dxtcLite.dxtc-right > .dxtc-stripContainer .dxtc-tab,
.dxtcLite.dxtc-right > .dxtc-stripContainer .dxtc-activeTab,
.dxtcLite.dxtc-right > .dxtc-stripContainer .dxtc-leftIndent,
.dxtcLite.dxtc-right > .dxtc-stripContainer .dxtc-spacer,
.dxtcLite.dxtc-right > .dxtc-stripContainer .dxtc-rightIndent
{
	float: none;
	clear: none;
	width: auto;
	height: auto;
}
.dxtcLite.dxtc-right > .dxtc-stripContainer .dxtc-activeTab,
.dxtc-right.dxtc-noSpacing > .dxtc-stripContainer .dxtc-tab
{
	border: 1px solid #A8A8A8;
}
.dxtcLite.dxtc-right.dxtc-noSpacing > .dxtc-stripContainer .dxtc-tab.dxtc-lead,
.dxtcLite.dxtc-right.dxtc-noSpacing > .dxtc-stripContainer .dxtc-activeTab.dxtc-lead
{
	border-top: 1px solid #A8A8A8;
}
.dxtcLite.dxtc-right.dxtc-noSpacing > .dxtc-stripContainer .dxtc-tab,
.dxtcLite.dxtc-right.dxtc-noSpacing > .dxtc-stripContainer .dxtc-activeTab
{
	border-top-style: none;
}
.dxtcLite.dxtc-right > .dxtc-stripContainer .dxtc-activeTab,
.dxtcLite.dxtc-right.dxtc-noSpacing > .dxtc-stripContainer .dxtc-activeTab
{
	border-left-width: 0;
    padding-left: 1px;
	background-color: white;
}
.dxtcLite.dxtc-right > .dxtc-stripContainer .dxtc-link
{
    padding: 3px 13px 4px 12px;
}
.dxtcLite.dxtc-right > .dxtc-stripContainer .dxtc-leftIndent,
.dxtcLite.dxtc-right > .dxtc-stripContainer .dxtc-spacer,
.dxtcLite.dxtc-right > .dxtc-stripContainer .dxtc-rightIndent
{
	border: none;
	border-left: 1px solid #A8A8A8;
	border-right: 1px solid transparent;
}
.dxtcLite.dxtc-right > .dxtc-stripContainer .dxtc-leftIndent,
.dxtcLite.dxtc-right > .dxtc-stripContainer .dxtc-rightIndent
{
	height: 5px;
}
.dxtcLite.dxtc-right > .dxtc-stripContainer .dxtc-spacer
{
	height: 1px;
}
.dxtcLite.dxtc-right > .dxtc-content
{
	border-top: 1px solid #A8A8A8;
	border-right-color: #A8A8A8;
	border-bottom: 1px solid #A8A8A8;
	border-left: 1px solid #A8A8A8;
	border-right-width: 1px;
	border-right-style: none!important;
	float: left;
	clear: none;
}
/* Services rules */
.dxtcLite.dxtc-noTabs > .dxtc-content
{
	border: 1px solid #A8A8A8!important;
}
/* -- ASPxTitleIndex -- */
.dxtiControl 
{
	color: #1E3695;
	background-color: white;
	font: 12px Tahoma, Geneva, sans-serif;
	border: 1px Solid #A8A8A8;
}
.dxtiControl a
{
	color: #1E3695;
}
.dxtiItem
{
	white-space: nowrap;
}
.dxtiGroupHeader,
.dxtiGroupHeaderCategorized
{
    font-size: 1.5em;
	text-decoration: none;
}
.dxtiGroupHeader,
.dxtiGroupHeaderCategorized
{
	white-space: nowrap;
	padding: 0px 0px 3px;
}
.dxtiGroupHeaderCategorized
{
	border-bottom: 1px Solid #C0C0C0;
	padding-bottom: 2px;
}
/* - GroupHeaderText - */
.dxtiGroupHeaderText
{
	background-color: #B4B4B4;
	color: #FFFFFF;
}
.dxtiGroupHeaderText
{
	padding: 2px 7px;
}
.dxtiGroupHeaderTextCategorized
{
	color: #666666;
}
.dxtiGroupHeaderTextCategorized
{
	padding-left: 7px;
	padding-right: 7px;
	padding-top: 2px;
}
/* - FilterBox - */
.dxtiFilterBoxInfoText
{
    font-size: 0.83em;
    font-weight: normal;
	color: #999999;
	padding-top: 0px;
	padding-bottom: 4px;
}
.dxtiFilterBoxEdit
{
	border: 1px Solid #9F9F9F;
}
.dxtiFilterBox,
.dxtiFilterBox table
{
	color: #898989;
	font-weight: bold;
}
.dxtiFilterBox
{
	background-color: #E8E8E8;
	padding: 15px;
}
/* - IndexPanel - */
.dxtiIndexPanel
{
    font-size: 1.33em;
	padding-bottom: 10px;
	text-decoration: none;
}
.dxtiIndexPanelItem,
.dxtiCurrentIndexPanelItem
{
	padding: 2px 6px;
}
.dxtiCurrentIndexPanelItem
{
	color: #000000;
	background-color: #E0E0E0;
}
/* - BackToTop - */
.dxtiBackToTop
{
	font-size: 0.75em;
	padding: 0px 0px 12px 0px;
}
.dxtiBackToTopRtl
{
	padding: 0px 0px 12px 0px;
}
/* Disabled */
.dxtiDisabled,
.dxtiDisabled a
{
	color: #acacac;
	cursor: default!important;
}
/* -- ASPxUploadControl -- */
.dxucControl,
.dxucEditArea,
input[type="text"].dxucEditArea /*Bootstrap correction*/
{
	font: 12px Tahoma, Geneva, sans-serif;
}
body input.dxucEditArea /*Bootstrap correction*/
{
    color: black;
}
.dxucEditArea,
input[type="text"].dxucEditArea /*Bootstrap correction*/
{
    padding: 1px;
}
.dxucControl .dxucInputs
{
}
.dxucTextBox
{
	background-color: white;
	border: 1px solid #9f9f9f;
	padding: 1px 2px;
}
.dxucTextBox .dxucEditArea
{
	margin: 0px;
	background-color: white;
}
.dxucNullText .dxucEditArea
{
    color: #818181;
}
.dxucErrorCell
{
	color: Red;
	text-align: left;
}
.dxucButton,
.dxucButton a
{
	color: #0D45B7;
	white-space: nowrap;
}
.dxucBrowseButton,
.dxucBrowseButton a
{
	color: #000000;
	cursor: pointer;
	white-space: nowrap;
	text-decoration: none;
}
.dxucControl .dxucBrowseButton a
{
	color: #000000;
}
.dxucControl a[unselectable="on"]
{
    user-select: none;
	-moz-user-select: -moz-none;
	-khtml-user-select: none;
	-webkit-user-select: none;
}
.dxucBrowseButton
{
	padding: 4px 8px 3px;
	border: 1px solid #7F7F7F;
	background: #E0DFDF url('/DXR.axd?r=1_129-K2F8m') repeat-x top;
}
.dxWebKitFamily .dxucBrowseButton
{
	padding: 3px 8px 4px;
}
noindex:-o-prefocus, body:first-of-type .dxucBrowseButton
{
    padding: 3px 8px 4px;
}
.dxucBrowseButton.dxbf
{
    padding: 3px 7px 4px;
}
.dxucBrowseButton.dxbf a
{
    border: 1px dotted black;
}
.dxucBrowseButtonHover
{
	border: 1px solid #606060;
	background: #F2F2F2 url('/DXR.axd?r=1_130-K2F8m') repeat-x top;
}
.dxucBrowseButtonPressed
{
	background: #D5D5D5 none;
}
/* ProgressBar */
.dxucProgressBar
{
	border: 1px Solid #696969;
	background-color: #FFFFFF;

    height: 21px;
}
.dxucProgressBar,
.dxucProgressBar td.dx
{
	color: Black;
}
.dxucProgressBar .dxPBMainCell,
.dxucProgressBar td.dx
{
	padding: 0;
}
.dxucProgressBarIndicator 
{
	background-color: #E0DFDF;
}
/* Silverlight Plugin Link */
.dxucSilverlightPluginLinkPanel {
    font-size: 0.83em;
	color: #7d7d7d;
	text-align: left;
}
.dxucSilverlightPluginLinkPanel td {
	padding: 0px 3px;
	vertical-align: middle;
}
.dxucSilverlightPluginLinkPanel a {
	color: #0D45B7;
}
/* Disabled */
.dxucDisabled,
.dxucDisabled a
{
	color: #ACACAC;
	cursor: default;
}
.dxucTextBoxDisabled
{
	border-color: #C3C3C3;
}
.dxucButtonDisabled,
.dxucButtonDisabled a
{
	text-decoration: none;
}
.dxucBrowseButtonDisabled
{
	border-color: #C3C3C3;
}
.dxucControl .dxucBrowseButtonDisabled a
{
    color: #808080;
}

/* -- ASPxSplitter -- */
.dxsplControl
{
    font: 12px Tahoma, Geneva, sans-serif;
}
.dxsplControl,
.dxsplVSeparator,
.dxsplHSeparator
{
	background-color: White;
}
.dxsplVSeparator,
.dxsplHSeparator
{
	font-size: 0;
}
.dxsplControl,
.dxsplVSeparator,
.dxsplHSeparator,
.dxsplPane,
.dxsplPaneCollapsed,
.dxsplVSeparator,
.dxsplHSeparator,
.dxsplVSeparatorCollapsed,
.dxsplHSeparatorCollapsed
{
	border: 0px solid #8C8C8C;
}
.dxsplPane,
.dxsplPaneCollapsed
{
	border-width: 1px;
}
.dxsplPaneCollapsed
{
	border-right-width: 0px;
	border-bottom-width: 0px;
}
.dxsplVSeparatorHover
{
	cursor: w-resize;
}
.dxsplHSeparatorHover
{
	cursor: n-resize;
}
.dxsplVSeparatorCollapsed
{
	border-top-width: 1px;
	border-bottom-width: 1px;
}
.dxsplHSeparatorCollapsed
{
	border-left-width: 1px;
	border-right-width: 1px;
}
.dxsplVSeparatorCollapsed,
.dxsplHSeparatorCollapsed
{
	cursor: default!important;
}
.dxsplVSeparatorButton
{
	cursor: pointer;
	padding: 5px 0px;
}
.dxsplHSeparatorButton
{
	cursor: pointer;
	padding: 0px 5px;
}
.dxsplDisabled .dxsplVSeparatorButton,
.dxsplDisabled .dxsplHSeparatorButton
{
	cursor: default;
}
.dxsplVSeparatorHover,
.dxsplHSeparatorHover,
.dxsplVSeparatorButtonHover,
.dxsplHSeparatorButtonHover
{
	background-color: #DCDCDC;
}
.dxsplResizingPointer
{
	background: url('/DXR.axd?r=1_117-K2F8m') repeat;
	font-size: 0;
	line-height: 0px;
}
.dxsplControl .dxsplLCC
{
	padding: 8px;
}

/* -- ASPxTreeView -- */
.dxtvControl
{
	color: Black;
	font: 12px Tahoma, Geneva, sans-serif;
	float: left;
}
.dxtvControl li 
{
	overflow-y: hidden;
}
.dxtvControl ul 
{
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow-y: hidden;
}

.dxtvControl a 
{
	color: black;
	text-decoration: none;
}

.dxtvControl .dxtv-ln
{
	background: url('/DXR.axd?r=1_127-K2F8m') repeat-y;
	vertical-align: top;
}

.dxtvControl .dxtv-nd
{
	margin-top: 1px;
	float: left;
	padding: 3px 5px 4px;
	display: block;
	text-decoration: none;
	outline: 0 none;
}

.dxtvControl .dxtv-elbNoLn,
.dxtvControl .dxtv-elb
{
	width: 26px;
	height: 21px;
	vertical-align: top;
	float: left;
}

.dxtvControl .dxtv-elb
{
	background: url('/DXR.axd?r=1_125-K2F8m') no-repeat;
}

.dxtvControl .dxtv-elbHide 
{
	display: none;
}

.dxtvControl .dxtv-btn 
{
	margin-left: 10px;
	margin-top: 5px;
}

.dxtvControl .dxtv-subnd 
{
	margin-left: 22px;
}

.dxtvControl .dxtv-ndImg 
{
	margin:  0 4px 0 2px;
}

.dxtvControl .dxtv-ndTxt 
{
	white-space: nowrap;
}

.dxtvControl .dxtv-ndChk
{
	margin:  1px 6px 0 2px;
}
  
.dxtvControl .dxtv-ndTmpl
{
	float: left;
	white-space: nowrap;
}

.dxtvControl .dxtv-ndSel,
.dxtvControl .dxtv-ndHov 
{
	border: 1px solid #888888;
	padding: 2px 4px 3px;
}

.dxtvControl .dxtv-ndSel
{
	background-color: #D8D8D8;
}

.dxtvControl .dxtv-ndHov 
{
	background-color: #F2F2F2;
}

.dxtvControl.dxtvRtl,
.dxtvControl.dxtvRtl .dxtv-nd, 
.dxtvControl.dxtvRtl .dxtv-elbNoLn,
.dxtvControl.dxtvRtl .dxtv-elb,
.dxtvControl.dxtvRtl .dxtv-ndTmpl
{
	float: right;
}

.dxtvControl.dxtvRtl .dxtv-elb,
.dxtvControl.dxtvRtl .dxtv-ln 
{
	background-position: right top;
}

.dxtvControl.dxtvRtl .dxtv-elb
{
	background-image: url('/DXR.axd?r=1_126-K2F8m');
}

.dxtvControl.dxtvRtl .dxtv-btn 
{
	margin: 5px 10px 0 0;
}

.dxtvControl.dxtvRtl .dxtv-subnd 
{
	margin: 0 22px 0 0;
}

.dxtvControl.dxtvRtl .dxtv-ndImg 
{
    margin: 0 2px 0 4px;
}

.dxtvControl.dxtvRtl.OperaRtlFix .dxtv-btn
{
	margin: 5px 10px 0 0;
}

.dxtvControl.dxtvRtl .dxtv-ndChk
{
	margin: 1px 2px 0 6px;
}

.dxtvControl.dxtvRtl.OperaRtlFix .dxtv-subnd 
{
	overflow-x: hidden;
}

.dxtvDisabled,
.dxtvControl .dxtvDisabled,
.dxtvDisabled a,
.dxtvDisabled .dxtv-btn,
.dxtvDisabled .dxtv-nd
{
	color: #acacac;
	cursor: default;
} 

/* ASPxFileManager */
.dxfmControl,
.dxfmControl .dxfm-rInput
{
	font: 12px Tahoma, Geneva, sans-serif;
	outline: 0px;
}
.dxfmDisabled
{
	color: #ACACAC;
}

/* FileManager - Splitter */
.dxfmControl .dxsplControl
{
	border-width: 1px;
	border-color: #7F7F7F;
}
.dxfmControl .dxsplPane
{
	border-width: 0px;
	background-color: White;
}
.dxfmControl .dxsplLCC {
	outline-width: 0px;
	padding: 4px;
}
.dxfmControl.dxfm-dst .dxsplVSeparator
{
	width: 3px;
	background: url('/DXR.axd?r=1_85-K2F8m') repeat-y right;
	border-width: 0px;
}
.dxfmControl.dxfm-dst.dxfm-rtl .dxsplVSeparator
{
	background-position-x: left;
}
.dxfmControl.dxfm-tch .dxsplVSeparator
{
	border-width: 0 1px;
	border-color: #E0E0E0;
}
.dxfmControl .dxsplHSeparator
{
	border-width: 0px;
	background-color: #E0E0E0;
}
.dxfmControl .dxfm-filePane .dxsplLCC
{
    padding: 0;
}

/* FileManager - TreeView */
.dxfmControl .dxtvControl 
{
	margin-left: -5px;
}
.dxfmControl .dxtvControl .dxfm-folderSI
{
	border: 1px dotted #888888;
	padding: 2px 4px 3px;
}

/* FileManager - File */
.dxfmControl .dxfm-file
{
    cursor: pointer;
    white-space: nowrap;
}
.dxfmDisabled .dxfm-file
{
	cursor: default;
}

.dxfmControl div.dxfm-file 
{
	float: left;
	text-align: center;
	padding: 6px;
	margin: 4px;
}
.dxfmControl.dxfm-rtl div.dxfm-file 
{
	float: right;
}
.dxfmControl div.dxfm-fileSI
{
	border: 1px dotted #888888;
}
.dxfmControl div.dxfm-fileSA
{
	background-color: #D8D8D8;
	border: 1px solid #888888;
}
.dxfmControl div.dxfm-fileH,
.dxfmControl div.dxfm-fileF
{
	background-color: #F2F2F2;
	border: 1px solid #888888;
}

.dxfmControl tr.dxfm-fileSA
{
    background-color: #A0A0A0;
    color: white;
}
.dxfmControl tr.dxfm-fileF
{
    background-color: #8E8E8E;
    color: White;
}
.dxfmControl .dxgvFocusedRow
{
    background-color: White;
    color: Black;
}
.dxfmControl tr.dxfm-fileSI
{
    background-color: #ECECEC;
    color: Black;
}
.dxfmControl td.dxgv .dxfm-fileName
{
    padding: 2px 0 2px 0;
}

.dxfmControl .dxfm-file .dxfm-highlight
{
	background-color: #CFCFCF;
	background-repeat: repeat;
	color: #333333;
	font-weight: bold;
}
.dxfmControl .fileContainer
{
    margin: 4px;
}

/* FileManager - GridView */
.dxfmControl .dxgvControl
{
    outline: none;
}
.dxgvHeader.dxfmGridHeader
{
    background-color: white;
    border-color: #CFCFCF;
}
.dxfmControl .dxgvTable td.dxgv
{
    border-bottom-width: 0px;
}
.dxfmControl .dxgvControl
{
    background-color: White; 
}   
.dxfmControl .dxgvTable tr.dxfm-fileH
{
    background-color: #CFCFCF;
    color: Black;
}
.dxfm-file .dxgv.dxgvCommandColumn
{
	text-overflow: clip;
}

/* FileManager - Toolbar */
.dxfmControl .dxfm-toolbar
{
	background-color: #F3F3F3;
}
.dxfmControl .dxfm-toolbar.dxsplPane table.dxfm
{
	width: 100%;
}
.dxfmControl .dxfm-toolbar.dxsplPane .dxfm-filter
{
	text-align: right;
	vertical-align: top;
	white-space: nowrap;
}
.dxfmControl.dxfm-rtl .dxfm-toolbar.dxsplPane .dxfm-filter 
{
	text-align: left;
}
.dxfmControl .dxfm-toolbar.dxsplPane .dxfm-filter input,
.dxfmControl .dxfm-toolbar.dxsplPane .dxfm-path input
{
	border: 1px solid #9F9F9F;
}

/* FileManager - Toolbar - Light */
.dxfmControl .dxfm-toolbar .dxsplLCC 
{
	padding: 5px;
}
.dxfmControl .dxfm-toolbar .dxmLite .dxm-main
{
	margin-top: 0px;
	border-width: 0px;
	background: transparent none;
}
.dxfmControl .dxfm-toolbar .dxmLite .dxm-horizontal.dxmtb .dxm-separator 
{
	padding: 0px 11px;
}
.dxfmControl .dxfm-toolbar .dxmLite .dxfm-path 
{
	padding-left: 1px;
}
.dxfmControl .dxfm-toolbar .dxmLite .dxm-item .dxm-content 
{
	padding-top: 4px;
}

/* FileManager - BreadCrumbs */
.dxfmControl .dxfm-breadCrumbs .dxfm-bcItem.dxfm-bcItemH,
.dxfmControl .dxfm-bcPopup .dxfm-bcItem.dxfm-bcItemH
{
    border-color: #888888;
    background-color: #F2F2F2;
}
.dxfmControl .dxfm-breadCrumbs .dxfm-bcLineSeparator
{
    border-color: #A8A8A8;
    padding: 5px 0;
    margin: 0 6px;
}

/* FileManager - Upload Progress Popup*/
.dxfmControl .dxfm-upPopup.dxpc-mainDiv .dxeProgressBarIndicator
{
    background: #6EC3FE;
}

/* FileManager - UploadPanel */
.dxfmControl .dxfm-uploadPanel
{
	background-color: #F3F3F3;
	text-align: right;
}
.dxfmControl.dxfm-rtl .dxfm-uploadPanel
{
	text-align: left;
}
.dxfmControl .dxfm-uploadPanel.dxsplPane table.dxfm-uploadPanelTable
{
	display: inline-block;
	margin-right: 5px;
	margin-top: 1px;
}
.dxfmControl .dxfm-uploadPanel.dxsplPane table.dxfm-uploadPanelTable .dxucControl 
{
	margin-top: 3px;
	margin-right: 10px;
}
.dxfmControl.dxfm-rtl .dxfm-uploadPanel.dxsplPane table.dxfm-uploadPanelTable .dxucControl 
{
	margin-right: 0px;
	margin-left: 10px;
}
.dxfmControl .dxfm-uploadPanel.dxsplPane table.dxfm-uploadPanelTable td.dxfm-uploadPanelTableBCell
{
    padding: 6px 0 0;
    vertical-align: top;
}
.dxfmControl .dxfm-uploadPanel.dxsplPane table.dxfm-uploadPanelTable td.dxfm-uploadPanelTableBCell a 
{
	color: #0D45B7;
	text-decoration: underline;
}
.dxfmControl .dxfm-uploadPanel.dxsplPane table.dxfm-uploadPanelTable td.dxfm-uploadPanelTableBCell a.dxfm-uploadDisable
{
	color: #777777;
	text-decoration: none;
	cursor: default;
}

.dxfmControl .dxfm-uploadPanel.dxsplPane .dxucTextBox {
	padding: 0px 2px;
}
.dxfmControl .dxfm-uploadPanel.dxsplPane .dxucBrowseButton {
	padding: 2px 8px 3px;
}
.dxfmControl .dxfm-uploadPanel.dxsplPane .dxucBrowseButton.dxbf {
    padding: 2px 7px 3px;
}
.dxfmControl .dxfm-uploadPanel.dxsplPane .dxucSilverlightPluginLinkPanel {
	margin-top: -8px;
}

/* FileManager - Create, Rename input */
.dxfmControl .dxfm-cInput,
.dxfmControl .dxfm-rInput
{
	border: 1px solid #9f9f9f;
}

/* FileManager - item mask */
.dxfmControl .dxfm-itemMask
{
	background-color: #D8D8D8;
}

/* FileManager - Move PopupControl */
.dxfmControl .dxpc-content
{
	padding: 5px 0px 0px;
	background-color: White;
}
.dxfmControl .dxpc-content .dxfm-mpFoldersC 
{
	overflow: auto;
	padding: 0px 0px 20px 5px;
}
.dxfmControl .dxpc-content .dxfm-mpButtonC
{
	margin-top: 5px;
	background-color: #F3F3F3;
	border-top: 1px solid #E0E0E0;
	text-align: right;
	padding: 10px 15px 10px 10px;
}
.dxfmControl .dxpc-content .dxfm-mpButtonC a 
{
	margin-left: 12px;
	color: #1B3F91;
}

/* ASPxImageSlider */
.dxisControl
{
    width: 660px;
    height: 505px;
    outline: 0;
    user-select: none;
	-moz-user-select: -moz-none;
	-khtml-user-select: none;
	-webkit-user-select: none;

    font: 12px Tahoma, Geneva, sans-serif;
}
.dxisControl > .dxis-passePartout
{
    position: relative;
    background-color: #000000;
    width: 100%;
    height:100%;
}
.dxisControl .dxis-imageArea
{
    margin: 0 auto;
    position: relative;
    overflow: hidden;
}
.dxisControl .dxis-playPauseBtnWrapper
{
    top: 0;
    right: 0;
    padding: 6px 12px 6px 14px;
    position: absolute;
    background-color: #333333;
    background-color: rgba(0, 0, 0, 0.75);
    cursor: pointer;
}
*[dir="rtl"].dxisControl .dxis-playPauseBtnWrapper {
    right: auto;
    left: 0;
}
.dxisControl .dxis-slidePanel,
.dxisControl .dxis-nbSlidePanel,
.dxisControl .dxis-nbSlidePanelWrapper
{
    position: absolute;
}
.dxisControl .dxis-nbSlidePanelWrapper
{
    overflow: hidden;
}
.dxisControl .dxis-nbTop,
.dxisControl .dxis-nbBottom,
.dxisControl .dxis-nbLeft,
.dxisControl .dxis-nbRight,
.dxisControl .dxis-nbDotsBottom,
.dxisControl .dxis-nbDotsTop,
.dxisControl .dxis-nbDotsLeft,
.dxisControl .dxis-nbDotsRight
{
    position: relative;
}
.dxisControl .dxis-nbTop
{
    padding-bottom: 5px;
}
.dxisControl .dxis-nbBottom
{
    padding-top: 5px;
}
.dxisControl .dxis-nbLeft
{
    padding-right: 5px;
}
.dxisControl .dxis-nbRight
{
    padding-left: 5px;
}
.dxisControl .dxis-nbDotsBottom,
.dxisControl .dxis-nbDotsTop
{
    padding: 20px 0;
}
.dxisControl .dxis-nbDotsLeft
{
    padding-right: 20px;
}
.dxisControl .dxis-nbDotsRight
{
    padding-left: 20px;
}
.dxisControl .dxis-nbLeft,
.dxisControl .dxis-nbRight,
.dxisControl .dxis-nbDotsLeft,
.dxisControl .dxis-nbDotsRight
{
    float: left;
}
.dxisControl .dxis-item,
.dxisControl .dxis-nbItem
{
    background-image: url('/DXR.axd?r=1_96-K2F8m');
    background-repeat: no-repeat;
    background-position:center center;
}
.dxisControl .dxis-nbItem .dxis-nbHoverItem
{
    display: none;
    position: absolute;
    border: 2px solid #9f9f9f;
}
.dxisControl .dxis-nbItem .dxis-nbHoverItem > div
{
    border: 2px solid #ffffff;
}
.dxisControl .dxis-nbItem.dxis-hover .dxis-nbHoverItem
{
    display: block;
}
.dxisControl .dxis-item,
.dxisControl .dxis-nbItem,
.dxisControl .dxis-nbDotItem
{
    position: absolute;
    overflow: hidden;
}
.dxisControl .dxis-nbItem,
.dxisControl .dxis-nbDotItem
{
    cursor: pointer;
}
.dxisControl .dxis-nbDotItemSelected,
.dxisControl .dxis-nbDotItemDisabled
{
    cursor: default;
}
.dxisControl .dxis-nbItem
{
    width: 90px;
    height: 60px;
    background-color: black;
}
.dxisControl .dxis-itemTextArea
{
    left: 0;
    bottom: 0;
    width: 100%;
    position: absolute;
    cursor: default;
    padding: 22px;
    color: white;
    background-color: #333333;
    background-color: rgba(0, 0, 0, 0.75);
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
}
.dxisControl .dxis-nbSelectedItem
{
    z-index: 1;
    cursor: default;
    position: absolute;
    border: 2px solid black;
    background-color: rgba(255, 255, 255, 0.00);
}
.dxisControl .dxis-nbSelectedItem > div
{
    border: 2px solid White;
}
.dxisControl .dxis-prevBtnVertWrapper,
.dxisControl .dxis-prevBtnVertOutsideWrapper,
.dxisControl .dxis-nextBtnVertWrapper,
.dxisControl .dxis-nextBtnVertOutsideWrapper,
.dxisControl .dxis-prevBtnHorWrapper,
.dxisControl .dxis-prevBtnHorOutsideWrapper,
.dxisControl .dxis-nextBtnHorWrapper,
.dxisControl .dxis-nextBtnHorOutsideWrapper
{
    cursor: pointer;
    z-index: 1;
    position: absolute;
    background-color: #333333;
    background-color: rgba(0, 0, 0, 0.75);
}
.dxisControl .dxis-prevBtnHorWrapperDisabled,
.dxisControl .dxis-prevBtnHorOutsideWrapperDisabled,
.dxisControl .dxis-nextBtnHorWrapperDisabled,
.dxisControl .dxis-nextBtnHorOutsideWrapperDisabled,
.dxisControl .dxis-prevBtnVertWrapperDisabled,
.dxisControl .dxis-prevBtnVertOutsideWrapperDisabled,
.dxisControl .dxis-nextBtnVertWrapperDisabled,
.dxisControl .dxis-nextBtnVertOutsideWrapperDisabled
{
    cursor: default;
}
.dxisControl .dxis-prevBtnHorWrapper,
.dxisControl .dxis-prevBtnHorOutsideWrapper
{
    left: 0px;
}
.dxisControl .dxis-nextBtnHorWrapper,
.dxisControl .dxis-nextBtnHorOutsideWrapper
{
    right: 0px;
}
.dxisControl .dxis-prevBtnVertWrapper,
.dxisControl .dxis-prevBtnVertOutsideWrapper
{
    top: 0px;
}
.dxisControl .dxis-nextBtnVertWrapper,
.dxisControl .dxis-nextBtnVertOutsideWrapper
{
    bottom: 0px;
}
.dxisControl > .dxis-passePartout > .dxis-prevBtnHorWrapper,
.dxisControl > .dxis-passePartout > .dxis-prevBtnHorOutsideWrapper,
.dxisControl > .dxis-passePartout > .dxis-nextBtnHorWrapper,
.dxisControl > .dxis-passePartout > .dxis-nextBtnHorOutsideWrapper
{
    top: 50%;
    margin-top: -32px;
}
.dxisControl > .dxis-passePartout > .dxis-prevBtnVertWrapper,
.dxisControl > .dxis-passePartout > .dxis-prevBtnVertOutsideWrapper,
.dxisControl > .dxis-passePartout > .dxis-nextBtnVertWrapper,
.dxisControl > .dxis-passePartout > .dxis-nextBtnVertOutsideWrapper
{
    left: 50%;
    margin-left: -30px;
}
.dxisControl .dxis-prevBtnHor
{
    margin: 16px 12px 16px 8px;
}
.dxisControl .dxis-nextBtnHor
{
    margin: 16px 8px 16px 12px;
}
.dxisControl .dxis-prevBtnVert
{
    margin: 8px 16px 12px 16px;
}
.dxisControl .dxis-nextBtnVert
{
    margin: 12px 16px 8px 16px;
}
.dxisControl > .dxis-nbBottom > .dxis-prevBtnHorWrapper,
.dxisControl > .dxis-nbBottom > .dxis-prevBtnHorOutsideWrapper,
.dxisControl > .dxis-nbBottom > .dxis-nextBtnHorWrapper,
.dxisControl > .dxis-nbBottom > .dxis-nextBtnHorOutsideWrapper,
.dxisControl > .dxis-nbTop > .dxis-prevBtnHorWrapper,
.dxisControl > .dxis-nbTop > .dxis-prevBtnHorOutsideWrapper,
.dxisControl > .dxis-nbTop > .dxis-nextBtnHorWrapper,
.dxisControl > .dxis-nbTop > .dxis-nextBtnHorOutsideWrapper
{
    height: inherit;
}
.dxisControl > .dxis-nbLeft > .dxis-prevBtnVertWrapper,
.dxisControl > .dxis-nbLeft > .dxis-prevBtnVertOutsideWrapper,
.dxisControl > .dxis-nbLeft > .dxis-nextBtnVertWrapper,
.dxisControl > .dxis-nbLeft > .dxis-nextBtnVertOutsideWrapper,
.dxisControl > .dxis-nbRight > .dxis-prevBtnVertWrapper,
.dxisControl > .dxis-nbRight > .dxis-prevBtnVertOutsideWrapper,
.dxisControl > .dxis-nbRight > .dxis-nextBtnVertWrapper,
.dxisControl > .dxis-nbRight > .dxis-nextBtnVertOutsideWrapper
{
    width: inherit;
}
.dxisControl .dxis-prevPageBtnHor,
.dxisControl .dxis-prevPageBtnHorOutside,
.dxisControl .dxis-nextPageBtnHor,
.dxisControl .dxis-nextPageBtnHorOutside
{
    top: 50%;
    position: relative;
    margin: -11px 7px 0 7px;
}
.dxisControl .dxis-prevPageBtnVert,
.dxisControl .dxis-prevPageBtnVertOutside,
.dxisControl .dxis-nextPageBtnVert,
.dxisControl .dxis-nextPageBtnVertOutside
{
    margin: 7px auto 6px;
}
.dxisControl .dxis-prevBtnHorWrapperPressed > .dxis-prevBtnHor,
.dxisControl .dxis-prevBtnHorOutsideWrapperPressed > .dxis-prevBtnHor,
.dxisControl .dxis-nextBtnHorWrapperPressed > .dxis-nextBtnHor,
.dxisControl .dxis-nextBtnHorOutsideWrapperPressed > .dxis-nextBtnHor,
.dxisControl .dxis-prevBtnHorWrapperPressed > .dxis-prevPageBtnHor,
.dxisControl .dxis-prevBtnHorWrapperPressed > .dxis-prevPageBtnHorOutside,
.dxisControl .dxis-prevBtnHorOutsideWrapperPressed > .dxis-prevPageBtnHor,
.dxisControl .dxis-prevBtnHorOutsideWrapperPressed > .dxis-prevPageBtnHorOutside,
.dxisControl .dxis-nextBtnHorWrapperPressed > .dxis-nextPageBtnHor,
.dxisControl .dxis-nextBtnHorWrapperPressed > .dxis-nextPageBtnHorOutside,
.dxisControl .dxis-nextBtnHorOutsideWrapperPressed > .dxis-nextPageBtnHor,
.dxisControl .dxis-nextBtnHorOutsideWrapperPressed > .dxis-nextPageBtnHorOutside,
.dxisControl .dxis-prevBtnVertWrapperPressed > .dxis-prevBtnVert,
.dxisControl .dxis-prevBtnVertOutsideWrapperPressed > .dxis-prevBtnVert,
.dxisControl .dxis-nextBtnVertWrapperPressed > .dxis-nextBtnVert,
.dxisControl .dxis-nextBtnVertOutsideWrapperPressed > .dxis-nextBtnVert,
.dxisControl .dxis-prevBtnVertWrapperPressed > .dxis-prevPageBtnVert,
.dxisControl .dxis-prevBtnVertWrapperPressed > .dxis-prevPageBtnVertOutside,
.dxisControl .dxis-prevBtnVertOutsideWrapperPressed > .dxis-prevPageBtnVert,
.dxisControl .dxis-prevBtnVertOutsideWrapperPressed > .dxis-prevPageBtnVertOutside,
.dxisControl .dxis-nextBtnVertWrapperPressed > .dxis-nextPageBtnVert,
.dxisControl .dxis-nextBtnVertWrapperPressed > .dxis-nextPageBtnVertOutside,
.dxisControl .dxis-nextBtnVertOutsideWrapperPressed > .dxis-nextPageBtnVert,
.dxisControl .dxis-nextBtnVertOutsideWrapperPressed > .dxis-nextPageBtnVertOutside,
.dxisControl .dxis-prevBtnVertPressed,
.dxisControl .dxis-nextBtnVertPressed,
.dxisControl .dxis-nextBtnHorPressed,
.dxisControl .dxis-prevBtnHorPressed,
.dxisControl .dxis-prevPageBtnVertPressed,
.dxisControl .dxis-prevPageBtnVertOutsidePressed,
.dxisControl .dxis-nextPageBtnVertPressed,
.dxisControl .dxis-nextPageBtnVertOutsidePressed,
.dxisControl .dxis-prevPageBtnHorPressed,
.dxisControl .dxis-prevPageBtnHorOutsidePressed,
.dxisControl .dxis-nextPageBtnHorPressed,
.dxisControl .dxis-nextPageBtnHorOutsidePressed,
.dxisControl .dxis-prevBtnVertDisabled,
.dxisControl .dxis-nextBtnVertDisabled,
.dxisControl .dxis-nextBtnHorDisabled,
.dxisControl .dxis-prevBtnHorDisabled,
.dxisControl .dxis-prevPageBtnVertDisabled,
.dxisControl .dxis-prevPageBtnVertOutsideDisabled,
.dxisControl .dxis-nextPageBtnVertDisabled,
.dxisControl .dxis-nextPageBtnVertOutsideDisabled,
.dxisControl .dxis-prevPageBtnHorDisabled,
.dxisControl .dxis-prevPageBtnHorOutsideDisabled,
.dxisControl .dxis-nextPageBtnHorDisabled,
.dxisControl .dxis-nextPageBtnHorOutsideDisabled
{
    opacity: 0.25;
    filter: progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=25);
}

.dxisControl .dxis-nextBtnHorOutsideWrapper,
.dxisControl .dxis-prevBtnHorOutsideWrapper,
.dxisControl .dxis-nextBtnVertOutsideWrapper,
.dxisControl .dxis-prevBtnVertOutsideWrapper {
	background-color: transparent;
}
.dxisControl .dxis-nextPageBtnHorOutside,
.dxisControl .dxis-prevPageBtnHorOutside {
	margin-top: -14px;
}
/* ASPxImageGallery */
.dxigControl
{
    font: 12px Tahoma, Geneva, sans-serif;
	color: #787878;
}
.dxigControl td.dxigCtrl
{
	padding: 12px 40px;
}
.dxigEmptyItem
{
	text-align: left;
	vertical-align: top;
}
.dxigEmptyData
{
	color: Gray;
}
.dxigFlowItem
{
    float: left;
}
.dxigItem
{
    background-repeat: no-repeat;
    background-position:center center;
    background-image: url('/DXR.axd?r=1_93-K2F8m');
}
.dxigItem a
{
    outline: 0;
}
.dxigItem a > img
{
    display: block;
}
.dxigItem .dxig-thumbnailBorder
{
    top: 0;
    display: none;
    position: absolute;
    border: 1px solid gray;
    border: 1px solid rgba(0, 0, 0, 0.20);
}
.dxigItem .dxig-thumbnailWrapper,
.dxigFlowItem
{
    width: 0;
    height: 0;
    overflow: hidden;
    position: relative;
}
.dxigControl .dxig-thumbnailTextArea
{
    left: 0;
    bottom: 0;
    width: 100%;
    position: absolute;
    padding: 10px;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    color: white;
    background-color: #333333;
    background-color: rgba(0, 0, 0, 0.75);
    box-sizing: border-box;
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    display: none;
}
.dxigControl .dxpcLite .dxpc-mainDiv,
.dxigControl .dxpcLite .dxpc-contentWrapper
{
    border: 0;
    background-color: #000;
    background-color: rgba(0, 0, 0, 0.9);
}
.dxigControl .dxpcLite .dxpc-content
{
    padding: 0;
    background-color: transparent;
}
.dxigControl .dxig-imageSliderWrapper
{
    overflow: hidden;
    padding: 50px 65px;
}
.dxTouchUI .dxigControl .dxig-imageSliderWrapper
{
    padding: 0;
}
.dxigControl .dxig-imageSliderWrapper .dxisControl .dxis-item > img
{
    box-shadow: 0 0 50px rgb(0,0,0);
    -moz-box-shadow: 0 0 50px rgb(0,0,0);
    -webkit-box-shadow: 0 0 50px rgb(0,0,0);
}
.dxigControl .dxig-bottomPanel
{
    left: 0;
    bottom: 0;
    width: 100%;
    position: absolute;
}
.dxigControl .dxig-bottomPanel > .dxig-overflowPanel
{
    overflow: hidden;
}
.dxigControl .dxig-overflowPanel .dxig-navigationBarMarker
{
    left: 50%;
    bottom: 0;
    margin-left: -10px;
    position: absolute;
    opacity: 0.7;
    filter: progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=70);
}
.dxigControl .dxig-bottomPanel .dxisControl
{
    position: relative;
}
.dxigControl .dxisControl > .dxis-passePartout
{
    background-color: transparent;
}
.dxigControl .dxisControl .dxis-nbBottom
{
    padding: 4px 4px 0 4px;
}
.dxigControl .dxisControl .dxis-nbSelectedItem
{
    border: 2px solid #fff;
}
.dxigControl .dxisControl .dxis-nbHoverItem
{
    border: 2px solid #9F9F9F
}
.dxigControl .dxisControl .dxis-nbSelectedItem > div,
.dxigControl .dxisControl .dxis-nbHoverItem > div
{
    border: 2px solid #000;
}
.dxigControl .dxig-bottomPanel .dxis-nbBottom > .dxis-prevBtnHorWrapper,
.dxigControl .dxig-bottomPanel .dxis-nbBottom > .dxis-nextBtnHorWrapper
{
    width: 43px;
    background: url('/DXR.axd?r=1_94-K2F8m') repeat-y;
}
.dxigControl .dxig-bottomPanel .dxis-nbBottom > .dxis-prevBtnHorWrapper
{
    background-position: 0 0;
}
.dxigControl .dxig-bottomPanel .dxis-nbBottom > .dxis-nextBtnHorWrapper
{
    background-position: -39px 0;
}
.dxigControl .dxig-bottomPanel .dxis-nbBottom > .dxis-prevBtnHorWrapperDisabled,
.dxigControl .dxig-bottomPanel .dxis-nbBottom > .dxis-nextBtnHorWrapperDisabled
{
    display: none;
}
.dxigControl .dxig-bottomPanel .dxis-nbBottom > .dxis-prevBtnHorWrapper .dxis-prevPageBtnHor,
.dxigControl .dxig-bottomPanel .dxis-nbBottom > .dxis-nextBtnHorWrapper .dxis-nextPageBtnHor
{
    position: absolute;
}
.dxigControl .dxig-bottomPanel .dxis-nbBottom > .dxis-prevBtnHorWrapper .dxis-prevPageBtnHor
{
}
.dxigControl .dxig-bottomPanel .dxis-nbBottom > .dxis-nextBtnHorWrapper .dxis-nextPageBtnHor
{
    right: 0;
}
.dxigControl .dxig-fullscreenViewerTextArea
{
    z-index: 1;
    padding: 10px;
    text-align: center;
    color: white;
}
.dxigControl .dxisControl .dxis-nbBottom,
.dxigControl .dxig-fullscreenViewerTextArea
{
    background-color: #000;
    background-color: rgba(0, 0, 0, 0.8);
}
.dxigControl .dxig-prevButtonArea,
.dxigControl .dxig-nextButtonArea
{
    top: 0;
    position: absolute;
}
.dxigControl .dxig-prevButtonArea
{
    left: 0;
}
.dxigControl .dxig-nextButtonArea
{
    right: 0;
}
.dxigControl .dxig-prevButton,
.dxigControl .dxig-nextButton
{
    top: 50%;
    cursor: pointer;
    position: relative;
    margin: -32px 11px 0;
}
.dxigControl .dxig-nextButton
{
    right: 0;
}
.dxigControl .dxig-prevButtonDisabled,
.dxigControl .dxig-nextButtonDisabled
{
    cursor: auto;
    opacity: 0.5;
    filter: progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=50);
}
.dxigControl .dxig-closeButtonWrapper,
.dxigControl .dxig-playPauseButtonWrapper
{
    padding: 15px;
    cursor: pointer;
    position: absolute;
}
.dxigControl .dxig-closeButtonWrapper
{
    top: 4px;
    right: 7px;
}
.dxigControl .dxig-closeButtonWrapper > .dxig-closeButton
{
    z-index: 1;
}
.dxigControl .dxig-playPauseButtonWrapper
{
    top: 2px;
    right: 48px;
}
*[dir="rtl"].dxigControl .dxig-closeButtonWrapper {
    left: 7px;
    right: auto;
}
*[dir="rtl"].dxigControl .dxig-playPauseButtonWrapper {
    left: 48px;
    right: auto;
}
.dxigControl .dxigPagerShowMoreItemsContainer
{
    height: 47px;
	text-align: center;
}
.dxigControl .dxigPagerShowMoreItemsContainer a
{
	display: block;
	padding-top: 14px;
	color: #0d45b7;
}
.dxigControl .dxigPagerShowMoreItemsContainer a:hover
{
	color: #5494ea;
}

/* ASPxImageZoom */
.dxizControl {
    border: 1px solid #d8d8d8;
}
.dxizControl .dxiz-hint {
    padding: 3px;
    top: 0;
    position: absolute;
}
.dxizControl .dxiz-hint > span {
    margin-left: 3px;
    color: gray;
	vertical-align: top;
    font: 12px Tahoma, Geneva, sans-serif;
}
.dxizControl .dxiz-EWCloseButton {
	top: 0;
	right: 1px;
	cursor: pointer;
	position: absolute;
}
.dxizControl .dxiz-expandWindow .dxpc-content {
    height: inherit;
}
.dxizControl .dxiz-wrapper {
    position: relative;
}
.dxizControl .dxiz-wrapper > img,
.dxizControl .dxiz-clipPanel > img,
.dxizControl .dxiz-expandWindow .dxpc-content > img {
    display: block;
}
.dxizControl .dxiz-clipPanel > img {
    position: absolute;
}
.dxizControl .dxiz-clipPanel {
    overflow: hidden;
    position: relative;
}
.dxizControl .dxiz-clipPanel.dxiz-inside {
    top: 0;
    position: absolute;
    opacity: 0;
    filter: progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=0);
}
.dxizControl .dxpcLite .dxpc-content {
    padding: 0;
}
.dxizControl .dxiz-lens {
    overflow: hidden;
    top: 0;
    position: absolute;
}
.dxizControl .dxiz-lens > .dxiz-pc {
    opacity: 0;
    filter: progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=0);
	z-index: 1;
    position: absolute;
}
.dxizControl .dxiz-lens .dxiz-llp,
.dxizControl .dxiz-lens .dxiz-lrp,
.dxizControl .dxiz-lens .dxiz-ltp,
.dxizControl .dxiz-lens .dxiz-lbp,
.dxizControl .dxiz-lens .dxiz-lcp {
    position: absolute;
}
.dxizControl .dxiz-lens .dxiz-lcp {
	background: white;
	outline: 1px solid #969292;
    outline: 1px solid rgba(128,128,128,0.5);
	filter: progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=50);
	background: rgba(255,255,255,0.5);
}
.dxizControl .dxiz-lens.outside .dxiz-lcp {
    background: transparent;
	outline: 1px solid black;
    outline: 1px solid rgba(0,0,0,0.5);
}
.dxizControl .dxiz-lens.outside .dxiz-llp,
.dxizControl .dxiz-lens.outside .dxiz-lrp,
.dxizControl .dxiz-lens.outside .dxiz-ltp,
.dxizControl .dxiz-lens.outside .dxiz-lbp {
    opacity: 0.25;
    filter: progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=25);
    background-color: #000;
}
.dxizControl .dxizLoadingPanel {
    position: absolute;
}

.dxisControl.dxis-zoomNavigator .dxis-nbItem {
	width: 75px;
    height: 75px;
}

/* Removes flicking in iOS Safari*/
.dxfmControl,
.dxnbGroupHeader,
.dxnbGroupHeaderCollapsed,
.dxnbGroupContent > TABLE > TBODY > TR,
.dxtcTab,
.dxtcActiveTab,
.dxtv-nd
{
	-webkit-tap-highlight-color: rgba(0,0,0,0);
}

/* Form Layout */
.dxflFormLayout {
    display: table;
    font: 12px Tahoma, Geneva, sans-serif;
    font-weight: inherit;
}

.dxflButtonItemSys .dxflVATSys.dxflCaptionCell { padding-top: 4px; }
.dxflButtonItemSys .dxflVAMSys.dxflCaptionCell { padding-bottom: 1px; }
.dxflTextItemSys .dxflVATSys.dxflCaptionCell { padding-top: 0px; }
.dxflTextEditItemSys .dxflVATSys.dxflCaptionCell,
.dxflViewFormLayoutSys .dxflItemSys .dxflVATSys.dxflCaptionCell,
.dxflViewFormLayoutSys .dxflItemSys .dxflNestedControlCell {
     padding-top: 3px;
}
.dxflViewFormLayoutSys .dxflItemSys.dxflEditFormItemSys .dxflNestedControlCell {
     padding-top: 0;
}
.dxflCheckBoxItemSys .dxflVATSys.dxflCaptionCell { padding-top: 3px; }
.dxflRadioButtonItemSys .dxflVATSys.dxflCaptionCell { padding-top: 3px; }
.dxflCheckBoxListItemSys .dxflVATSys.dxflCaptionCell { padding-top: 10px; }
.dxflRadioButtonListItemSys .dxflVATSys.dxflCaptionCell { padding-top: 11px; }
.dxflListBoxItemSys .dxflVATSys.dxflCaptionCell { padding-top: 4px; }
.dxflTrackBarItemSys .dxflVATSys.dxflCaptionCell { padding-top: 2px; }
.dxflProgressBarItemSys .dxflVATSys.dxflCaptionCell { padding-top: 2px; }
.dxflMemoItemSys .dxflVATSys.dxflCaptionCell { padding-top: 3px; }
.dxflCustomItemSys .dxflVATSys.dxflCaptionCell { padding-top: 3px; }

.dxflCLTSys .dxflCaptionCell,
.dxflCLBSys .dxflCaptionCell {
    padding: 3px 0;
}

.dxflCLLSys .dxflCaptionCell,
*[dir="rtl"].dxflFormLayout .dxflCLRSys .dxflCaptionCell {
    padding-left: 0px;
    padding-right: 6px;
}
.dxflCLRSys .dxflCaptionCell,
*[dir="rtl"].dxflFormLayout .dxflCLLSys .dxflCaptionCell {
    padding-right: 0px;
    padding-left: 6px;
}
.dxflCaptionCell {
    white-space: nowrap;
    line-height: 16px;
    height: 100%;
}
div.dxflTextItemSys .dxflNestedControlCell {
    line-height: 16px;
}
.dxflCaptionCell {
    width: 1%;
}
td.dxflNestedControlCell {
    height: 0;
}

.dxflEmptyItem {
    height: 21px;
}

.dxflItem { width: 100%; }
.dxflItem,
.dxflViewFormLayoutSys .dxflEditFormItemSys.dxflItem {
     padding: 2px 0;
}
.dxflViewFormLayoutSys .dxflItem {
     padding-bottom: 4px;
}
.dxflItem > table.dxflItemTable { width: 100%; }
.dxflGroup { padding: 6px 5px; width: 100%;}
.dxflGroup > table.dxflGroupTable { width: 100%; }
.dxflGroupCell { padding: 0 8px; }

.dxflGroupBox {
    display: table;
    border-collapse: separate;
    width: 100%;
    border: 1px Solid #9F9F9F;
    border-radius: 3px;
    padding: 0 0 12px;
    margin: 10px 0; 
}
.dxflGroupBox.dxflHeadingLineGroupBoxSys {
    border-width: 1px 0 0;
    border-radius: 0px;
}
.dxflGroupBox.dxflHeadingLineGroupBoxSys.dxflWithCaptionSys {
    margin-top: 22px!important;
}

.dxflHeadingLineGroupBoxSys > .dxflGroupSys {
    margin-top: -6px;
}

.dxflGroupCell > .dxtcControl { margin: 0px; }

.dxflGroupBox > .dxflGroup { margin-top: -9px; padding: 0 4px; }

.dxflGroupBox > .dxflGroup tr:first-child > .dxflGroupCell > .dxflItem,
.dxflGroupBox > .dxflGroup > .dxflChildInFirstRowSys > .dxflGroupCell > .dxflItem { 
    padding-top: 9px;
}

.dxflGroupBox > .dxflGroup tr:first-child > .dxflGroupCell > .dxtcControl,
.dxflGroupBox > .dxflGroup > .dxflChildInFirstRowSys > .dxflGroupCell > .dxtcControl {
     margin-top: 10px;
}

.dxflGroupBox > .dxflGroup tr:first-child > .dxflGroupCell > .dxflGroupBox,
.dxflGroupBox > .dxflGroup > .dxflChildInFirstRowSys > .dxflGroupCell > .dxflGroupBox {
}

.dxflGroupBox > .dxflGroup tr:first-child > .dxflGroupCell > .dxflGroup,
.dxflGroupBox > .dxflGroup > .dxflChildInFirstRowSys > .dxflGroupCell > .dxflGroup {
}

.dxflGroupBox > .dxflGroup tr:last-child > .dxflGroupCell > .dxflItem,
.dxflGroupBox > .dxflGroup > .dxflChildInLastRowSys > .dxflGroupCell > .dxflItem {
    padding-bottom: 0px;
}

.dxflGroupBox > .dxflGroup tr:last-child > .dxflGroupCell > .dxtcControl,
.dxflGroupBox > .dxflGroup > .dxflChildInLastRowSys > .dxflGroupCell > .dxtcControl {
}

.dxflGroupBox > .dxflGroup tr:last-child > .dxflGroupCell > .dxflGroupBox,
.dxflGroupBox > .dxflGroup > .dxflChildInLastRowSys > .dxflGroupCell > .dxflGroupBox {
}

.dxflGroupBox > .dxflGroup tr:last-child > .dxflGroupCell > .dxflGroup,
.dxflGroupBox > .dxflGroup > .dxflChildInLastRowSys > .dxflGroupCell > .dxflGroup {
}

.dxflGroup tr:first-child > .dxflGroupCell > .dxflGroupBox,
.dxflGroup > .dxflChildInFirstRowSys > .dxflGroupCell > .dxflGroupBox {
    margin-top: 13px;
}

.dxflGroup tr:first-child > .dxflGroupCell > .dxflItem,
.dxflGroup > .dxflChildInFirstRowSys > .dxflGroupCell > .dxflItem {
}

.dxflGroup tr:first-child > .dxflGroupCell > .dxtcControl,
.dxflGroup > .dxflChildInFirstRowSys > .dxflGroupCell > .dxtcControl {
}

.dxflGroup tr:first-child > .dxflGroupCell > .dxflGroup,
.dxflGroup > .dxflChildInFirstRowSys > .dxflGroupCell > .dxflGroup {
}

.dxflGroup tr:last-child > .dxflGroupCell > .dxflGroupBox,
.dxflGroup > .dxflChildInLastRowSys > .dxflGroupCell > .dxflGroupBox {
    margin-bottom: 0px;
}

.dxflGroup tr:last-child > .dxflGroupCell > .dxflItem,
.dxflGroup > .dxflChildInLastRowSys > .dxflGroupCell > .dxflItem {
}

.dxflGroup tr:last-child > .dxflGroupCell > .dxtcControl,
.dxflGroup > .dxflChildInLastRowSys > .dxflGroupCell > .dxtcControl {
}

.dxflGroup tr:last-child > .dxflGroupCell > .dxflGroup,
.dxflGroup > .dxflChildInLastRowSys > .dxflGroupCell > .dxflGroup {
}

.dxtcPageContent > div > .dxflGroup { padding-top: 0px; padding-bottom: 0px; }

.dxtcPageContent > div > .dxflGroup tr:first-child > .dxflGroupCell > .dxflGroupBox,
.dxtcPageContent > div > .dxflGroup > .dxflChildInFirstRowSys > .dxflGroupCell > .dxflGroupBox {
}

.dxtcPageContent > div > .dxflGroup tr:first-child > .dxflGroupCell > .dxflItem,
.dxtcPageContent > div > .dxflGroup > .dxflChildInFirstRowSys > .dxflGroupCell > .dxflItem {
    padding-top: 12px;
}

.dxtcPageContent > div > .dxflGroup tr:first-child > .dxflGroupCell > .dxtcControl,
.dxtcPageContent > div > .dxflGroup > .dxflChildInFirstRowSys > .dxflGroupCell > .dxtcControl {
}

.dxtcPageContent > div > .dxflGroup tr:first-child > .dxflGroupCell > .dxflGroup,
.dxtcPageContent > div > .dxflGroup > .dxflChildInFirstRowSys > .dxflGroupCell > .dxflGroup {
}

.dxtcPageContent > div > .dxflGroup tr:last-child > .dxflGroupCell > .dxflGroupBox,
.dxtcPageContent > div > .dxflGroup > .dxflChildInLastRowSys > .dxflGroupCell > .dxflGroupBox {
}

.dxtcPageContent > div > .dxflGroup tr:last-child > .dxflGroupCell > .dxflItem,
.dxtcPageContent > div > .dxflGroup > .dxflChildInLastRowSys > .dxflGroupCell > .dxflItem { 
    padding-bottom: 12px;
}

.dxtcPageContent > div > .dxflGroup tr:last-child > .dxflGroupCell > .dxtcControl,
.dxtcPageContent > div > .dxflGroup > .dxflChildInLastRowSys > .dxflGroupCell > .dxtcControl {
}

.dxtcPageContent > div > .dxflGroup tr:last-child > .dxflGroupCell > .dxflGroup,
.dxtcPageContent > div > .dxflGroup > .dxflChildInLastRowSys > .dxflGroupCell > .dxflGroup {
}

.dxflGroupBoxCaption {
    background-color: White;
    color: #818181;
    display: inline-block;  
    left: 9px;
    margin-right: 18px;
    line-height: 16px;
    padding: 0px 3px 0px 3px;  
    position: relative;
    top: -9px;
}

*[dir="rtl"].dxflFormLayout .dxflGroupBoxCaption {
    padding: 0px 3px 0px 7px;
    left: 0px;
    right: 9px;
    margin-left: 18px;
    margin-right: 0;
}

.dxflGroupBox > div.dxflGroup:first-child,
.dxflGroupBox > table.dxflGroup:first-child {
    margin-top: 0px;
    padding-top: 7px;
}

.dxflHeadingLineGroupBoxSys > .dxflGroupBoxCaption {
    top: -19px;
}

.dxflOptional {
	color: gray;
	font-style: normal;
}
.dxflRequired {
	color: green;
	font-style: normal;
}
.dxflInternalEditorTable {
    width: 100%;
}
.dxflHelpText {
    color: #9F9F9F;
    font-size: 0.91em;
}
.dxflHelpText.dxflLHelpTextSys,
.dxflHelpText.dxflRHelpTextSys {
    padding: 0 6px;
}
.dxflHelpText.dxflTHelpTextSys {
    padding: 6px 0 2px;
}
.dxflHelpText.dxflBHelpTextSys {
    padding: 2px 0 6px;
}

/* Ribbon */
.dxrControl {
    font: 12px Tahoma, Geneva, sans-serif;
}
.dxrControl .dxr-tabContent {
    border: 1px solid #a7a7a7;
    border-top-width: 0px;
    height: 95px;
    background: #FFFFFF;
}
.dxrControl.dxr-oneLineMode .dxr-tabContent,
.dxrControl.dxr-grLabelsHidden.dxr-oneLineMode .dxr-tabContent {
    height: 30px;
}
.dxrControl.dxr-grLabelsHidden .dxr-tabContent {
    height: 81px;
}
.dxrControl.dxr-tabsHidden .dxr-tabContent {
    border-top-width: 1px;
}
.dxrControl, 
.dxrControl a {
    color: #000000;
}
.dxrControl .dxr-itemDisabled.dxr-item,
.dxrControl .dxr-groupLabelDisabled.dxr-groupLabel,
.dxrControl .dxr-grExpBtn.dxr-grExpBtnDisabled,
.dxrControl .dxr-grExpBtn.dxr-grExpBtnDisabled .dxr-img32,
.dxrControl .dxr-minBtn.dxr-minBtnDisabled,
.dxrControl .dxr-itemDisabled a,
.dxrControl .dxr-olmGrExpBtn.dxr-olmGrExpBtnDisabled {
    cursor: default;
    color: #A6A6A6;
}
.dxrControl .dxtc-rightIndent {
    text-align: right;
}

/* Ribbon Popup */
.dxrControl .dxr-minPopupWindow {
    padding: 0;
}
.dxrControl .dxr-minPopup.dxpc-mainDiv {
    border: 0;
}
.dxrControl .dxr-groupPopup .dxpc-mainDiv {
    border: 1px solid #a7a7a7;
}

/* Ribbon Group List */
.dxrControl .dxr-groupList {
    padding: 0;
    margin: 0;
    height: 100%;
}

.dxrControl .dxr-groupList .dxr-groupSep {
    height: 100%;
    list-style: none;
}

.dxrControl .dxr-groupList .dxr-groupSep b {
    display: block;
    height: 100%;
    width: 1px;
    background: #a8a8a8;
}

/* Ribbon Groups */
.dxrControl .dxr-groupList .dxr-group {
    margin: 3px 3px 0 3px;
    text-align: center;
}
.dxrControl .dxr-groupContent {
    height: 75px;
}
.dxrControl.dxr-oneLineMode .dxr-groupContent {
    height: 30px;
}
.dxrControl .dxr-groupLabel {
    text-align: center;
    color: #666666;
    padding: 0px 5px 0 5px;
    overflow: hidden;
    white-space: nowrap;
    -ms-text-overflow: ellipsis;
    -o-text-overflow: ellipsis;
    text-overflow: ellipsis;
}
.dxrControl .dxr-grDialogBoxLauncher {
	float: right;
	margin: 2px -4px 0 5px;
	cursor: pointer;
}
.dxrControl .dxr-grExpBtn,
.dxrControl .dxr-grExpBtn .dxr-img32 {
    cursor: pointer;
}
.dxrControl .dxr-grExpBtn {
    height: 87px;
    border: 1px solid transparent;
    text-align: center;
}
.dxrControl .dxr-groupPopupWindow {
    padding: 2px 3px;
}
.dxrControl .dxr-olmGrExpBtn {
    cursor: pointer;
    border: 1px solid transparent;
    margin: 0 3px;
    height: 23px;
    white-space: nowrap;
}
.dxrControl .dxr-groupContent .dxr-olmGrExpBtn .dxr-label {
    padding-left: 3px;
    padding-right: 3px;
}
.dxrControl .dxr-olmGrExpBtn .dxr-popOut {
    padding: 10px 3px 10px 3px;
    font-size: 0;
}

/* Ribbon Item Separator */
.dxrControl .dxr-blRegItems .dxr-itemSep,
.dxrControl .dxr-blLrgItems .dxr-itemSep {
    width: 3px;
}
.dxrControl .dxr-blRegItems .dxr-itemSep b,
.dxrControl .dxr-blLrgItems .dxr-itemSep b {
    display: block;
    background: #a8a8a8;
    width: 1px;
}
.dxrControl .dxr-blRegItems .dxr-itemSep b {
    margin: 3px auto;
    height: 19px;
}
.dxrControl .dxr-blLrgItems .dxr-itemSep b {
    margin: 4px auto;
    height: 67px;
}

/* Ribbon Item */
.dxrControl .dxr-item {
    border: 1px solid transparent;
}
.dxrControl .dxr-blLrgItems .dxr-item,
.dxrControl .dxr-blSepItems .dxr-item,
.dxrControl.dxr-grLabelsHidden .dxr-grExpBtn {
    text-align: center;
    height: 73px;
}
.dxrControl .dxr-blRegItems .dxr-item,
.dxrControl .dxr-blHorItems .dxr-item {
    height: 23px;
    white-space: nowrap;
}
.dxrControl .dxr-blRegItems .dxr-item {
    margin-left: 2px;
    margin-right: 2px;
}
.dxrControl .dxr-blHorItems .dxr-item {
    margin: 0 3px;
}
.dxrControl .dxr-blHorItems .dxr-item .dxr-lblText {
    padding-left: 2px;
    padding-right: 3px;
}
.dxrControl .dxr-blHorItems .dxr-item .dxr-popOut {
    height: 100%;
    margin-left: 1px;
}

/* Ribbon Item Label */
.dxrControl .dxr-blLrgItems .dxr-item .dxr-label,
.dxrControl .dxr-blSepItems .dxr-item .dxr-label {
    border-top: 1px solid transparent;
    width: 100%;
}
.dxrControl .dxr-blLrgItems .dxr-item .dxr-label .dxr-lblContent,
.dxrControl .dxr-blSepItems .dxr-item .dxr-label .dxr-lblContent,
.dxrControl .dxr-grExpBtn .dxr-lblContent {
    margin-left: 3px;
    margin-right: 3px;
    margin-bottom: 2px;
    text-align: center;
    vertical-align: middle;
}
.dxrControl .dxr-blLrgItems .dxr-item.dxr-itemHover.dxr-ddMode .dxr-label,
.dxrControl .dxr-blLrgItems .dxr-item.dxr-itemPressed.dxr-ddMode .dxr-label,
.dxrControl .dxr-blSepItems .dxr-item.dxr-itemPressed.dxr-ddMode .dxr-label {
    border-top: 1px solid #888888;
}
.dxrControl .dxr-blHorItems .dxr-item .dxr-label,
.dxrControl .dxr-olmGrExpBtn .dxr-label {
    margin: 3px 0;
    line-height: 100% !important;
    padding: 2px 0;
    line-height: 100%;    
    text-decoration: inherit;
    vertical-align: middle;
    display: inline-block !important;
}

/* Ribbon Item Label PopOut */
.dxrControl .dxr-blLrgItems .dxr-item .dxr-label .dxr-popOut,
.dxrControl .dxr-grExpBtn .dxr-popOut {
    margin: -1px 3px 1px;
}
.dxrControl .dxr-blRegItems .dxr-item .dxr-popOut,
.dxrControl .dxr-blHorItems .dxr-item .dxr-popOut {
    padding: 10px 3px 10px 3px;
    margin: -8px 0 -6px;
    border-left: 1px solid transparent;
    font-size: 0;
}
.dxWebKitFamily .dxrControl .dxr-blRegItems .dxr-item .dxr-popOut {
	margin: -9px 0 -6px;
}
noindex:-o-prefocus, 
.dxrControl .dxr-blRegItems .dxr-item .dxr-popOut,
.dxrControl .dxr-blHorItems .dxr-item .dxr-popOut    
{
    margin: -8px 0 -7px;
}
.dxrControl .dxr-blRegItems .dxr-item.dxr-itemHover.dxr-ddMode .dxr-label .dxr-popOut,
.dxrControl .dxr-blHorItems .dxr-item.dxr-itemHover.dxr-ddMode .dxr-label .dxr-popOut,
.dxrControl .dxr-blRegItems .dxr-item.dxr-itemPressed.dxr-ddMode .dxr-label .dxr-popOut,
.dxrControl .dxr-blHorItems .dxr-item.dxr-itemPressed.dxr-ddMode .dxr-label .dxr-popOut {
    border-left: 1px solid #888888;
}

/* Ribbon Editors Item */
.dxrControl .dxr-item.dxr-edtItem {
    border: 0;
    padding: 1px 0;
    height: 23px;
}
.dxrControl .dxr-item.dxr-edtItem .dxr-label {
    padding-right: 3px;
}

/* Ribbon Item Types */
.dxrControl .dxr-buttonItem {
    cursor: pointer;
}
.dxrControl .dxr-blLrgItems .dxr-buttonItem,
.dxrControl .dxr-grExpBtn {
    min-width: 42px;
}
.dxrControl .dxr-buttonItem.dxr-itemHover,
.dxrControl .dxr-grExpBtn.dxr-grExpBtnHover,
.dxrControl .dxr-olmGrExpBtn.dxr-itemHover {
    background: #CBCBCB;
    border-color: #888888;
}
.dxrControl .dxr-buttonItem.dxr-itemChecked {
    background: #FFFFFF;
    border-color: #888888;
}
.dxrControl .dxr-buttonItem.dxr-itemPressed,
.dxrControl .dxr-olmGrExpBtn.dxr-itemPressed {
    background: #d5d5d5;
    border-color: #888888;
}
.dxrControl .dxr-img32,
.dxrControl .dxr-blLrgItems .dxr-colorBtn .dxr-colorBtnNoImg32 {
    width: 32px;
    height: 32px;
    margin: 2px auto 1px auto;
}
.dxrControl .dxr-img16,
.dxrControl .dxr-blRegItems .dxr-colorBtn .dxr-colorBtnNoImg16,
.dxrControl .dxr-blHorItems .dxr-colorBtn .dxr-colorBtnNoImg16 {
    width: 16px;
    height: 16px;
    margin: 3px;
}
.dxrControl .dxr-ddImageContainer {
    display: inline-block;
}
.dxrControl .dxr-blLrgItems .dxr-ddImageContainer {
    width: 100%;
}

/* Ribbon Color Button */
.dxrControl .dxr-colorBtn .dxr-colorDiv {
    height: 4px;
    width: 16px;
    display: block;
    margin: -6px 0 2px 3px;
    position: relative;
}

.dxrControl .dxr-blLrgItems .dxr-colorBtn .dxr-colorDiv {
    width: 32px;
    margin: -5px auto 1px;
}

.dxrControl .dxr-blLrgItems .dxr-colorBtn .dxr-colorBtnNoImg32 {
    display: block;
    margin-bottom: 6px;
}

.dxrControl .dxr-blLrgItems .dxr-colorBtn .dxr-colorBtnNoImg32 .dxr-colorDiv,
.dxrControl .dxr-blRegItems .dxr-colorBtn .dxr-colorBtnNoImg16 .dxr-colorDiv,
.dxrControl .dxr-blHorItems .dxr-colorBtn .dxr-colorBtnNoImg16 .dxr-colorDiv {
    height: 100%;
    width: 100%;
    margin: 0px;
}

.dxrControl .dxpc-content.dxr-itemDDPopup {
    padding: 0;
}

.dxrControl .dxeColorTable {
    border: none;
}

.dxrControl .dxr-minBtn {
    cursor: pointer;
    display: inline-block;
    width: 14px;
    height: 14px;
    font-size: 0;
    text-align:center;
    vertical-align: middle;
    line-height: 14px;
    padding-right: 4px;
}
.dxrControl .dxr-minBtn img {
    vertical-align: middle;
}


/* Ribbon TabControl */
.dxrControl .dxtcLite.dxtc-top .dxtc-leftIndent, 
.dxrControl .dxtcLite.dxtc-top .dxtc-spacer, 
.dxrControl .dxtcLite.dxtc-top .dxtc-rightIndent, 
.dxrControl .dxtcLite.dxtc-top .dxtc-sbWrapper, 
.dxrControl .dxtcLite.dxtc-top .dxtc-sbIndent, 
.dxrControl .dxtcLite.dxtc-top .dxtc-sbSpacer
.dxrControl .dxtcLite.dxtc-top .dxtc-spacer.dxr-fileTabSpacing {
    border-bottom-color: #a8a8a8;
}

.dxrControl .dxtcLite.dxtc-top .dxtcLiteDisabled .dxtc-link {
    color: #acacac;
}

.dxrControl .dxtcLite.dxtc-top .dxtc-tab {
    background: transparent;
    border-top-color: transparent;
    border-left-width: 0;
    border-right-width: 0;
}
.dxrControl .dxtcLite.dxtc-top .dxtc-tab.dxtc-tabHover
{
	background: #f2f2f2;
    border-color: #a8a8a8;
    border-left-width: 1px;
    border-right-width: 1px;
}
.dxrControl .dxtcLite.dxtc-top .dxtc-activeTab {
    border-color: #a8a8a8;
    border-top-width: 1px;
}
.dxrControl .dxtcLite.dxtc-top .dxtc-tab .dxtc-link {
    padding-left: 13px;
    padding-right: 13px;
}
.dxrControl .dxtcLite.dxtc-top .dxtc-activeTab .dxtc-link {
    padding-left: 12px;
    padding-right: 12px;
}

.dxrControl .dxtcLite.dxtc-top .dxtc-tab.dxtc-tabHover .dxtc-link {
    padding-left: 12px;
    padding-right: 12px;
}

.dxrControl .dxtcLite.dxtc-top .dxr-fileTab .dxtc-link,
.dxrControl .dxtcLite.dxtc-top .dxr-fileTab.dxtc-tabHover .dxtc-link {
    padding-left: 19px;
    padding-right: 19px;
}
.dxrControl .dxtcLite.dxtc-top .dxr-fileTab {
    background: #e5e5e5 url('/DXR.axd?r=1_115-K2F8m') repeat-x;
    border-color: #a8a8a8;
    border-left-width: 1px;
    border-right-width: 1px;
}
.dxrControl .dxtcLite.dxtc-top .dxtc-tabHover.dxr-fileTab {
    background: #E8E7E8 url('/DXR.axd?r=1_116-K2F8m') repeat-x;
    border-color: #a8a8a8;
}
.dxrControl .dxtcLite.dxtc-top .dxr-fileTabPressed.dxr-fileTab {
    background: #8d8d8d;
    border-color: #a8a8a8;
}

.dxrControl .dxtcLite.dxtc-top .dxtc-tab .dxtc-link,
.dxrControl .dxtcLite.dxtc-top .dxtc-activeTab .dxtc-link {
    padding-top: 3px;
    padding-bottom: 3px;
}
.dxrControl .dxtcLite.dxtc-top .dxtc-leftIndent {
    width: 0px;
}
.dxrControl .dxtcLite .dxr-contextTabColor {

}

/*Ribbon Gallery Control*/
.dxrControl .dxr-item.dxr-glrBarItem
{
    border: 1px solid #a7a7a7;
    background-color: white;
}

.dxrControl .dxr-glrBarContainer
{
    margin-right: 16px;
    height: 71px;
}

.dxrControl .dxr-glrItem.dxr-itemDisabled
{
    cursor: default;
}

.dxrControl .dxr-glrItem.dxr-itemHover
{
    background-color: #F2F2F2;
    border: 1px solid #888888;
}

.dxrControl .dxr-glrItem.dxr-itemChecked
{
    background-color: #D8D8D8;
    border: 1px solid #888888;
}

.dxrControl .dxr-glrItem.dxr-itemPressed,
.dxrControl .dxr-glrBtnPressed {
    background: #d5d5d5;
    border-color: #888888;
}

.dxrControl .dxr-glrItemContent
{
    margin: 0 auto;
    padding: 2px;
}

.dxrControl .dxr-glrImgBottom .dxr-glrItemContent,
.dxrControl .dxr-glrImgTop .dxr-glrItemContent
{
    text-align: center;
}

.dxrControl .dxr-glrImgRight .dxr-glrItemContent img
{
    vertical-align: middle;
}

.dxrControl .dxr-glrImgLeft .dxr-glrItemContent img
{
    vertical-align: middle;
}

.dxrControl .dxr-glrNoText .dxr-glrItemContent img
{
    display: block;
}

.dxrControl .dxr-glrItemText
{
    text-overflow: ellipsis;
    overflow: hidden;
    margin: 5px;
}

.dxrControl .dxr-glrImgLeft .dxr-glrItemText,
.dxrControl .dxr-glrImgRight .dxr-glrItemText
{
    display: inline-block;
    vertical-align: middle;
}

.dxrControl .dxr-glrGroup
{
    background-color: #F3F3F3;
    font-weight: bold;
    color: #777777;
    padding: 3px;
}

.dxrControl .dxr-glrMainDiv
{
    text-align: left;
    font-size: 0px;
}

.dxrControl .dxr-glrMainDiv > div
{
    font-size: 12px;
}

.dxrControl .dxr-glrBarItem .dxr-glrButtons
{
    float: right;
    height: 100%;
}

.dxrControl .dxr-glrBarItem .dxr-glrButtons div
{
    cursor: pointer;
    height: 24px;
    border-left: 1px solid #a7a7a7;
    border-bottom: 1px solid #a7a7a7;
    padding-left: 3px;
    padding-right: 3px;
    font-size: 0px;
}

.dxrControl .dxr-glrBarItem .dxr-glrButtons img
{
    position: relative;
    top: 50%;
    margin-top: -3px;
    margin-bottom: 3px;
}

.dxrControl .dxr-glrBarItem .dxr-glrButtons .dxr-itemDisabled
{
    cursor: default;
}

.dxrControl .dxr-glrBtnHover
{
    background: #CBCBCB;
    border-color: #888888;
}

/* Ribbon ASPxDocumentViewer*/
.dxrControl .dxr-tmplItem .dxxrdvrCurrentPageLabel {
    padding: 0 0 2px 0;
    display: block;
}
.dxrControl .dxr-tmplItem .dxxrdvrPageCountLabel {
    padding: 1px 0 0 0;
    display: block;
}
.dxrControl .dxr-tmplItem .dxxrdvrPageNumberComboBox {
    width: 100px;
}
.dxrControl.dxr-oneLineMode .dxr-tmplItem .dxxrdvrPageNumberComboBox {
    float: left;
    width: 65px;
    padding: 0;
}
.dxrControl.dxr-oneLineMode .dxr-tmplItem .dxxrdvrCurrentPageLabel {
    float: left;
    padding: 4px 4px 2px 2px;
}
.dxrControl.dxr-oneLineMode .dxr-tmplItem .dxxrdvrPageCountLabel {
    float: left;
    padding: 4px 2px 2px 4px;
}

/* OfficeControls */
.dxitcControl
{
    background-color: #F5F5F5;
    padding-bottom: 2px;
    border: 1px solid #7F7F7F;
}
.dxitcControl > div:first-child
{
    padding: 1px;
}
.dxitcControl .dxitcItem
{
    width: 12px;
    height: 12px;
    margin: 1px;
    border: 1px solid #CCC;
    background-color: white;
}
.dxitcControl .dxitcItemHover
{
    margin: 0px;
    border: 2px solid #A7A7A7;
}
.dxitcCaption
{
    background-color: #EEE;
    padding: 2px;
    border: 1px solid #CCC;
    margin: 2px 2px 0px 2px;
}

