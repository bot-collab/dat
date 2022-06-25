/* -- ValidationSummary -- */
.dxvsValidationSummary_Glass
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: Red;
}
.dxvsValidationSummary_Glass td.dxvsRC_Glass
{
	vertical-align: top;
	padding: 2px 5px 4px 6px;
}
.dxvsValidationSummary_Glass .dxvsE_Glass
{
}
.dxvsValidationSummary_Glass table.dxvsHT_Glass
{
	width: 100%;
}
.dxvsValidationSummary_Glass td.dxvsH_Glass
{
	padding: 2px 0;
}
.dxvsValidationSummary_Glass a.dxvsHL_Glass,
.dxvsValidationSummary_Glass a.dxvsHL_Glass:visited
{
	color: red;
}
.dxvsValidationSummary_Glass a.dxvsHL_Glass
{
	text-decoration: none;
	border-bottom: 1px dashed #f70;
}
.dxvsValidationSummary_Glass a.dxvsHL_Glass:hover
{
	color: #f70;
}
.dxvsValidationSummary_Glass table.dxvsT_Glass
{
}
.dxvsValidationSummary_Glass tr.dxvsE_Glass
{
}
.dxvsValidationSummary_Glass td.dxvsETC_Glass
{
	padding: 2px 0;
}
.dxvsValidationSummary_Glass ul.dxvsL_Glass
{
}
.dxvsValidationSummary_Glass ol.dxvsL_Glass
{
}
.dxvsValidationSummary_Glass li.dxvsE_Glass
{
	padding: 2px 0;
}

/* TrackBar */
.dxeTrackBar_Glass
{
    font: 12px Tahoma, Geneva, sans-serif;
	user-select: none;
	-moz-user-select: -moz-none;
	-khtml-user-select: none;
	-webkit-user-select: none;
	visibility:hidden;
}

.dxeDisabled_Glass .dxeTBHSys a,
.dxeDisabled_Glass .dxeTBVSys a
{
    cursor: default;
}

.dxeTBBarHighlight_Glass
{
	font-size: 0;
}

.dxeTBScale_Glass,
.dxeTBTrack_Glass,
.dxeTBBarHighlight_Glass
{
	cursor: pointer;
}

.dxeTBScale_Glass
{
	z-index: 1;
}
.dxeTBSecondaryDH_Glass,
.dxeTBMainDH_Glass
{
	z-index: 4;
}

.dxeTrackBar_Glass.dxeTBHSys
{
	width: 170px;
	height: 49px;
}
.dxeTrackBar_Glass.dxeTBVSys
{
	height: 170px;
	width: 49px;
}
.dxeTrackBar_Glass.dxeTBBScaleSys.dxeTBVSys
{
	width: 70px;
}
.dxeTrackBar_Glass.dxeTBBScaleSys.dxeTBHSys
{	
	height: 70px;
}

.dxeTBTrack_Glass
{
	z-index: 2;
	position: absolute;
}

.dxeTBTrack_Glass, .dxeTBBarHighlight_Glass 
{
	border-style: solid;
	border-color: #A3C0E8;
}

.dxeTBHSys .dxeTBTrack_Glass, .dxeTBHSys .dxeTBBarHighlight_Glass 
{
	border-width: 0px 1px 0px 1px;
}
.dxeTBVSys .dxeTBTrack_Glass, .dxeTBVSys .dxeTBBarHighlight_Glass 
{
	border-width: 1px 0px 1px 0px;
}

.dxeTBHSys .dxeTBTrack_Glass
{
	background-image:  url('/DXR.axd?r=0_1064-K2F8m');
}
.dxeTBVSys .dxeTBTrack_Glass
{
	background-image:  url('/DXR.axd?r=0_1065-K2F8m');
}

.dxeTBHSys .dxeTBTrack_Glass, 
.dxeTBHSys .dxeTBBarHighlight_Glass
{
	height: 4px;
}
.dxeTBVSys .dxeTBTrack_Glass, 
.dxeTBVSys .dxeTBBarHighlight_Glass
{
	width: 4px;
}

.dxeTBHSys .dxeTBMainDH_Glass,
.dxeTBHSys .dxeTBSecondaryDH_Glass
{	
	top: -11px;
	width: 13px;
	height: 26px;
}
.dxeTBVSys .dxeTBMainDH_Glass,
.dxeTBVSys .dxeTBSecondaryDH_Glass
{
	left: -11px;
	width: 26px;
	height: 13px;
}

.dxeTBVSys .dxeTBRBScaleSys .dxeTBTrack_Glass,
.dxeTBVSys .dxeTBTrack_Glass
{
	left: 13px;
}
.dxeTBVSys .dxeTBLTScaleSys .dxeTBTrack_Glass
{
	right: 13px;
	left: auto;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBTrack_Glass
{
	bottom: 13px;
	top: auto;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBTrack_Glass,
.dxeTBHSys .dxeTBTrack_Glass
{
	top: 13px;
}

.dxeTBBarHighlight_Glass
{
	left: 0px;
	top: 0px;
	position:absolute;
	z-index: 3;
}

.dxeTBHSys .dxeTBBarHighlight_Glass
{
	background-image:  url('/DXR.axd?r=0_1054-K2F8m');
}
.dxeTBVSys .dxeTBBarHighlight_Glass
{
	background-image:  url('/DXR.axd?r=0_1055-K2F8m');
}

.dxeTBRBLabel_Glass,
.dxeTBLTLabel_Glass
{
	font-size: 0.91em;
	text-align: center;
	cursor: default;
}
.dxeTBSmallTickSys .dxeTBRBLabel_Glass,
.dxeTBSmallTickSys .dxeTBLTLabel_Glass,
.dxeTBLargeTickSys .dxeTBRBLabel_Glass,
.dxeTBLargeTickSys .dxeTBLTLabel_Glass
{	
	position: absolute;
}

.dxeTBHSys .dxeTBRBLabel_Glass,
.dxeTBHSys .dxeTBLTLabel_Glass
{
	width: 100%;
}

.dxeTBIncBtn_Glass,
.dxeTBDecBtn_Glass
{
}

.dxeTBVSys .dxeTBRBLabel_Glass,
.dxeTBVSys .dxeTBLTLabel_Glass
{
	padding-top: 2px;
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBRBLabel_Glass
{
	margin-left: -4px;
}
.dxeTBVSys .dxeTBRBScaleSys .dxeTBRBLabel_Glass,
.dxeTBVSys .dxeTBBScaleSys .dxeTBLTLabel_Glass
{
	right: 0px;
}
.dxeTBVSys .dxeTBLTScaleSys .dxeTBLTLabel_Glass,
.dxeTBVSys .dxeTBBScaleSys .dxeTBRBLabel_Glass
{
	left: 0px;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBRBLabel_Glass,
.dxeTBHSys .dxeTBBScaleSys .dxeTBLTLabel_Glass
{
	bottom: 0px;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBLTLabel_Glass,
.dxeTBHSys .dxeTBBScaleSys .dxeTBRBLabel_Glass
{
	top: 0px;
}

.dxeTBHSys .dxeTBItem_Glass .dxeTBRBLabel_Glass,
.dxeTBHSys .dxeTBItem_Glass .dxeTBLTLabel_Glass
{
	display: inline-block;
	margin-left: 0px!important;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBItem_Glass .dxeTBRBLabel_Glass
{
	padding-top: 12px;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBItem_Glass .dxeTBLTLabel_Glass
{
	margin-top: 8px;
}
.dxeTBVSys .dxeTBRBScaleSys .dxeTBItem_Glass .dxeTBRBLabel_Glass 
{
	margin-left: 5px;
}

.dxeTBSelectedItem_Glass .dxeTBRBLabel_Glass,
.dxeTBSelectedItem_Glass .dxeTBLTLabel_Glass,
.dxeTBSelectedTick_Glass .dxeTBRBLabel_Glass,
.dxeTBSelectedTick_Glass .dxeTBLTLabel_Glass
{
	color: #2A769D;
}
.dxeDisabled_Glass .dxeTBSelectedItem_Glass .dxeTBRBLabel_Glass,
.dxeDisabled_Glass .dxeTBSelectedItem_Glass .dxeTBLTLabel_Glass,
.dxeDisabled_Glass .dxeTBSelectedTick_Glass .dxeTBRBLabel_Glass,
.dxeDisabled_Glass .dxeTBSelectedTick_Glass .dxeTBLTLabel_Glass 
{
	color: #E4E4E4;
}

.dxeTBRBLabel_Glass,
.dxeTBLTLabel_Glass,
.dxeTBItem_Glass
{
	color: #93C3D3;
}

.dxeDisabled_Glass .dxeTBRBLabel_Glass,
.dxeDisabled_Glass .dxeTBLTLabel_Glass,
.dxeDisabled_Glass .dxeTBItem_Glass
{
	color: #E4E4E4;
}

.dxeTBVSys .dxeTBLTScaleSys .dxeTBItem_Glass
{
	text-align: left;
}

.dxeTBVSys .dxeTBRBScaleSys .dxeTBItem_Glass
{
	text-align: right;
}

.dxeTBVSys .dxeTBBScaleSys .dxeTBItem_Glass
{
	text-align: center;
}

.dxeTBHSys .dxeTBItem_Glass
{
	background-image:  url('/DXR.axd?r=0_1060-K2F8m');
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBItem_Glass
{
	background-image:  url('/DXR.axd?r=0_1058-K2F8m');
}
.dxeTBVSys .dxeTBItem_Glass 
{
	background-image:  url('/DXR.axd?r=0_1061-K2F8m');
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBItem_Glass
{
	background-image:  url('/DXR.axd?r=0_1059-K2F8m');
}

.dxeTBHSys .dxeTBLargeTick_Glass
{
	background-image:  url('/DXR.axd?r=0_1060-K2F8m');
}
.dxeTBVSys .dxeTBLargeTick_Glass
{
	background-image: url('/DXR.axd?r=0_1061-K2F8m');
}
.dxeTBHSys .dxeTBSmallTick_Glass
{
	background-image: url('/DXR.axd?r=0_1062-K2F8m');
}
.dxeTBVSys .dxeTBSmallTick_Glass
{
	background-image: url('/DXR.axd?r=0_1063-K2F8m');
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBLargeTick_Glass
{
	background-image: url('/DXR.axd?r=0_1056-K2F8m');
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBLargeTick_Glass
{
	background-image: url('/DXR.axd?r=0_1057-K2F8m');
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBSmallTick_Glass
{
	background-image: url('/DXR.axd?r=0_1058-K2F8m');
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBSmallTick_Glass
{
	background-image: url('/DXR.axd?r=0_1059-K2F8m');
}

.dxeTBVSys .dxeTBIncBtn_Glass,
.dxeTBVSys .dxeReversedDirectionSys .dxeTBDecBtn_Glass
{
	bottom: 0px;
	top: auto;
}
.dxeTBVSys .dxeTBDecBtn_Glass,
.dxeTBVSys .dxeReversedDirectionSys .dxeTBIncBtn_Glass
{
	top: 0px;
	bottom: auto;
}
.dxeTBHSys .dxeTBDecBtn_Glass, 
.dxeTBHSys .dxeReversedDirectionSys .dxeTBIncBtn_Glass
{
	left: 0px;
	right: auto;
}
.dxeTBHSys .dxeTBIncBtn_Glass,
.dxeTBHSys .dxeReversedDirectionSys .dxeTBDecBtn_Glass
{
	right: 0px;
	left: auto;
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBDecBtn_Glass,
.dxeTBVSys .dxeTBBScaleSys .dxeTBIncBtn_Glass
{
	margin-left: -10px;
	left: 50%;
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBDecBtn_Glass,
.dxeTBHSys .dxeTBBScaleSys .dxeTBIncBtn_Glass
{
	margin-top: -10px;
	top: 50%;
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBTrack_Glass
{ 
	margin-left: -2px;
	left: 50%;
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBTrack_Glass
{ 
	margin-top: -2px;
	top: 50%;
}

.dxeTBVSys .dxeTBLTScaleSys .dxeTBDecBtn_Glass,
.dxeTBVSys .dxeTBLTScaleSys .dxeTBIncBtn_Glass
{
	right: 5px;
	left: auto;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBDecBtn_Glass,
.dxeTBHSys .dxeTBLTScaleSys .dxeTBIncBtn_Glass
{
	bottom: 5px;
	top: auto;
}
.dxeTBVSys .dxeTBRBScaleSys .dxeTBDecBtn_Glass,
.dxeTBVSys .dxeTBRBScaleSys .dxeTBIncBtn_Glass,
.dxeTBVSys .dxeTBDecBtn_Glass,
.dxeTBVSys .dxeTBIncBtn_Glass
{
	left: 5px;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBDecBtn_Glass,
.dxeTBHSys .dxeTBRBScaleSys .dxeTBIncBtn_Glass,
.dxeTBHSys .dxeTBDecBtn_Glass,
.dxeTBHSys .dxeTBIncBtn_Glass
{
	top: 5px;
}

.dxeHelpText_Glass,
.dxeTBValueToolTip_Glass
{
    font: 12px Tahoma, Geneva, sans-serif;
}
div.dxeHelpText_Glass,
.dxeTBValueToolTip_Glass
{
	padding: 3px 8px 4px 8px;
    display: inline;
    position:absolute;
    border-radius: 3px;
    z-index: 41998;
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
    -o-border-radius: 3px;
    -khtml-border-radius: 3px;
    -webkit-box-shadow: rgba(0, 0, 0, 0.1) 0 1px 3px;
    -moz-box-shadow: rgba(0, 0, 0, 0.1) 0 1px 3px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    border: 1px solid #B2BCBE;
    background: #F7F8F8;
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#F7F8F8', endColorstr='#ECF1F1');
	background: -webkit-gradient(linear, left top, left bottom, from(#F7F8F8), to(#ECF1F1));
	background: -moz-linear-gradient(top,  #F7F8F8,  #ECF1F1);
}
td.dxeHelpText_Glass {
    visibility: visible;
    color: #9F9F9F;
}
td.dxeHelpText_Glass span {
    font-size: 0.91em;
}
td.dxeHelpText_Glass.dxeHHelpTextSys {
    padding: 0 6px;
}
td.dxeHelpText_Glass.dxeVHelpTextSys {
    padding: 2px 0;
}

/* InternalCheckBox */
.dxeIRBFocused_Glass
{
    outline: 1px dotted #68a4c0;
}
.dxeIRadioButton_Glass
{
}
.dxlpLoadingPanel_Glass,
.dxlpLoadingPanelWithContent_Glass
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: #303030;
	border: 1px solid #7EACB1;
	background-color: White;
}
.dxlpLoadingPanel_Glass td.dx,
.dxlpLoadingPanelWithContent_Glass td.dx
{
	white-space: nowrap;
	text-align: center;
	padding: 12px;
}
.dxcaLoadingPanel_Glass .dxlp-loadingImage,
.dxlpLoadingPanel_Glass .dxlp-loadingImage,
.dxlpLoadingPanelWithContent_Glass .dxlp-loadingImage,
.dxeImage_Glass.dxe-loadingImage
{
	background-image: url('/DXR.axd?r=0_1217-K2F8m');
	height: 27px;
	width: 27px;
}

.dxeButtonEditSys .dxic .dxeLoadingDiv_Glass
{
	opacity: 1!important;
	filter: alpha(opacity=100)!important;
}

.dxeButtonEditSys .dxic .dxeLoadingPanel_Glass
{
    background-color: transparent!important;
}

.dxeButtonEditSys .dxic .dxeLoadingPanel_Glass td.dx
{
	padding: 0px!important;
}

.dxeButtonEditSys .dxic .dxeLoadingPanel_Glass td.dx>span
{
	display: none;
}

.dxeButtonEditSys .dxic .dxeLoadingPanel_Glass td.dx>img
{
	height: 15px;
    width: auto;
    vertical-align: middle;
}

.dxeBase_Glass
{
	font: 12px Tahoma, Geneva, sans-serif;
}
/* -- ErrorFrame -- */
.dxeErrorCell_Glass
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: red;
    border-color: black;
	padding-left: 4px;
    padding-right: 4px;
}
.dxeErrorFrame_Glass
{
}
.dxeErrorFrameWithoutError_Glass
{
	border: 1px solid Red;
}
.dxeErrorFrameWithoutError_Glass .dxeControlsCell_Glass,
.dxeErrorFrameWithoutError_Glass.dxeControlsCell_Glass
{
	padding: 2px;
}
.dxeEditArea_Glass
{
	border: 1px solid #A0A0A0;
}
body input.dxeEditArea_Glass /*Bootstrap correction*/
{
    color: black;
}

/* -- Binary Image -- */
.dxeBinaryImageButtonPanel_Glass
{
    height: 36px;
}
.dxeBinaryImageButton_Glass
{
    margin: 0 6px;
}

/* -- Buttons -- */
.dxeButtonEdit_Glass
{
	background-color: white;
}
.dxeButtonEdit_Glass .dxeEditArea_Glass
{
	background-color: white;
}

.dxeButtonEditButton_Glass,
.dxeCalendarButton_Glass,
.dxeSpinIncButton_Glass,
.dxeSpinDecButton_Glass,
.dxeSpinLargeIncButton_Glass,
.dxeSpinLargeDecButton_Glass,
.dxeColorEditButton_Glass
{
	background-color: #5F94B2;
    border: 1px solid #4986a2;
	vertical-align: middle;
	cursor: pointer;
	color: white;
	text-align: center;
	white-space: nowrap;
} 
.dxeButtonEditButton_Glass
{
	background: #45829F url('/DXR.axd?r=0_1037-K2F8m') repeat-x top;
	padding: 0px 1px;
}
.dxeSpinLargeIncButton_Glass,
.dxeSpinLargeDecButton_Glass
{
	padding: 0px 4px;
}
.dxeSpinIncButton_Glass,
.dxeSpinDecButton_Glass
{
	padding: 1px 3px;
}
.dxeSpinIncButton_Glass
{
	background: #45829F url('/DXR.axd?r=0_1047-K2F8m') repeat-x left top;
	margin-bottom: 1px;
}
.dxeSpinDecButton_Glass
{
	background: #45829F url('/DXR.axd?r=0_1046-K2F8m') repeat-x left top;
}
.dxeSpinLargeIncButton_Glass,
.dxeSpinLargeDecButton_Glass
{
	background: #45829F url('/DXR.axd?r=0_1050-K2F8m') repeat-x left top;
}

.dxeCalendarButton_Glass,
.dxeColorEditButton_Glass
{
    color: Black;
	background: #DADFE0 url('/DXR.axd?r=0_1035-K2F8m') repeat-x top;
	border: 1px solid #B2BCBE;
	padding: 5px 10px;
	min-width: 37px;
}

/* -- Hover -- */
.dxeButtonHover_Glass         /* inherits dxeButton */
{
	background-color: #E6E3D6;
}
.dxeCalendarButtonHover_Glass,
.dxeColorEditButton_Glass:hover
{
	background: #B5D7DB url('/DXR.axd?r=0_1039-K2F8m') repeat-x top;
	border: 1px solid #71ACB4;
}
.dxeButtonEditButtonHover_Glass
{
	background: #35acd2 url('/DXR.axd?r=0_1041-K2F8m') repeat-x top;
	border: 1px Solid #4986a2;
}

/* SpinButtons */
.dxeSpinIncButtonHover_Glass
{
	background: #35acd2 url('/DXR.axd?r=0_1048-K2F8m') repeat-x left top;
}
.dxeSpinDecButtonHover_Glass
{
	background: #35acd2 none;
}
.dxeSpinLargeIncButtonHover_Glass,
.dxeSpinLargeDecButtonHover_Glass
{
	background: #35acd2 url('/DXR.axd?r=0_1051-K2F8m') repeat-x left top;
}

.dxeButtonEditButton_Glass.dxeButtonEditClearButton_Glass,
.dxeButtonEditButton_Glass.dxeButtonEditClearButton_Glass:hover
{
    background: none;
    border-width: 0;
    padding-bottom: 1px;
    padding-top: 2px;
}

.dxeButtonEditClearButton_Glass img
{
    vertical-align: baseline;
}

/* -- Pressed -- */
.dxeButtonPressed_Glass       /* inherits dxeButton */
{
	background-color: #D4D1C3;
}
.dxeCalendarButtonPressed_Glass,
.dxeColorEditButton_Glass:active
{
	background: #9ABDC1 url('/DXR.axd?r=0_1040-K2F8m') repeat-x top;
	border: 1px solid #71ACB4;
}
.dxeButtonEditButtonPressed_Glass
{
	background: #35657b url('/DXR.axd?r=0_1042-K2F8m') repeat-x top;
	border: 1px Solid #3b6d84;
}
/* SpinButtons */
.dxeSpinIncButtonPressed_Glass
{
	background: #35657b url('/DXR.axd?r=0_1049-K2F8m') repeat-x left top;
}
.dxeSpinDecButtonPressed_Glass
{
	background: #35657b none;
}
.dxeSpinLargeIncButtonPressed_Glass,
.dxeSpinLargeDecButtonPressed_Glass
{
	background: #35657b url('/DXR.axd?r=0_1052-K2F8m') repeat-x left top;
}

.dxeButtonEdit_Glass
{
	border: 1px solid #7EACB1;
	font: 12px Tahoma, Geneva, sans-serif;
}
.dxeButtonEdit_Glass .dxeIIC img
{
	padding-left: 3px;
}
.dxeTextBox_Glass
{
	background-color: white;
	border: 1px Solid #7eacb1;
	font: 12px Tahoma, Geneva, sans-serif;
}
.dxeTextBox_Glass .dxeEditArea_Glass
{
	background-color: white;
}
.dxeRadioButtonList_Glass,
.dxeCheckBoxList_Glass
{
	font: 12px Tahoma, Geneva, sans-serif;
}

.dxeCheckBoxList_Glass .dxe > table,
.dxeRadioButtonList_Glass .dxe > table 
{
    width: 100%;
}

.dxeRadioButtonList_Glass,
.dxeCheckBoxList_Glass
{
	border: 1px Solid #7EACB1;
}
.dxeRadioButtonList_Glass td.dxe,
.dxeCheckBoxList_Glass td.dxe
{
	padding: 6px 5px 6px 11px;
}
.dxeRadioButtonList_Glass[dir='rtl'] td.dxe,
.dxeCheckBoxList_Glass[dir='rtl'] td.dxe
{
	padding: 6px 11px 6px 5px;
}

/* -- Memo -- */
.dxeMemo_Glass
{
	background-color: white;
	border: 1px Solid #7eacb1;
	font: 12px Tahoma, Geneva, sans-serif;
}
.dxeMemoEditArea_Glass
{
	background-color: white;
	outline: none;
}

/* -- Hyperlink -- */
.dxeHyperlink_Glass
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: #2a769d;
}
a.dxeHyperlink_Glass
{
	color: #2a769d;
}
a:hover.dxeHyperlink_Glass
{
	color: #f15e34;
}
a:visited.dxeHyperlink_Glass
{
	color: #a1a1a1;
}

/* -- ListBox -- */
.dxeListBox_Glass
{
	background-color: white;
	border: 1px solid #7EACB1;
	color: Black;
	font: 12px Tahoma, Geneva, sans-serif;
	height: 102px;
	width: 70px;
}

.dxeListBox_Glass div.dxlbd
{
	height: 102px;
}
.dxeListBoxItemRow_Glass
{
	cursor: default;
}
.dxeListBoxItem_Glass
{
	border: 1px solid white;
	padding: 2px 2px 2px 3px;
	white-space: nowrap;
	text-align: left;
}
.dxeListBoxItem_Glass em
{
	background: #d9eced none repeat 0 0;
	color: #333333;
	font-weight: bold;
	font-style: normal;
}
.dxeListBoxItemSelected_Glass     
{
	background-color: #E9F6F8;
}
.dxeListBoxItemHover_Glass        
{
	background-color: #d9eced;
}
.dxeListBoxItemHover_Glass em,
.dxeListBoxItemSelected_Glass em
{
	background-image: none;
}
.dxeListBox_Glass td.dxeI,
.dxeListBox_Glass td.dxeIM,
.dxeListBox_Glass .dxeHIC,
.dxeListBox_Glass td.dxeFTM,
.dxeListBox_Glass td.dxeTM,
.dxeListBox_Glass td.dxeC,
.dxeListBox_Glass td.dxeCM,
.dxeListBox_Glass td.dxeHCC,
.dxeListBox_Glass td.dxeMI,
.dxeListBox_Glass td.dxeMIM
{
	border-right-width: 0!important;
}
.dxeListBox_Glass td.dxeIR,
.dxeListBox_Glass td.dxeIMR,
.dxeListBox_Glass .dxeHICR,
.dxeListBox_Glass td.dxeFTMR,
.dxeListBox_Glass td.dxeTMR,
.dxeListBox_Glass td.dxeCR,
.dxeListBox_Glass td.dxeCMR,
.dxeListBox_Glass td.dxeHCCR,
.dxeListBox_Glass td.dxeMIR,
.dxeListBox_Glass td.dxeMIMR
{
	border-left-width: 0!important;
}
.dxeListBox_Glass td.dxeCM,
.dxeListBox_Glass td.dxeHCC,
.dxeListBox_Glass td.dxeCMR,
.dxeListBox_Glass td.dxeHCCR
{
	width: 29px;
    box-sizing: border-box;
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
}
.dxeListBox_Glass td.dxeIM,
.dxeListBox_Glass td.dxeIMR
{
	width: 0;
}
.dxeListBox_Glass td.dxeC
{
	padding-right: 3px!important;
}
.dxeListBox_Glass td.dxeCR
{
	padding-left: 3px!important;
}
.dxeListBox_Glass td.dxeC > span,
.dxeListBox_Glass td.dxeCM > span
{
    margin: 2px 2px 2px 3px;
}
.dxeListBox_Glass td.dxeCR > span,
.dxeListBox_Glass td.dxeCMR > span
{
    margin: 2px 3px 2px 2px;
}
.dxeListBox_Glass td.dxeT
{
	width: 100%;
	padding-left: 0!important;
}
.dxeListBox_Glass td.dxeTR
{
	width: 100%;
	padding-right: 0!important;
}
.dxeListBox_Glass td.dxeT,
.dxeListBox_Glass td.dxeMI
{
	border-left-width: 0!important;
}
.dxeListBox_Glass td.dxeTR,
.dxeListBox_Glass td.dxeMIR
{
	border-right-width: 0!important;
}
.dxeListBox_Glass td.dxeFTM,
.dxeListBox_Glass td.dxeTM,
.dxeListBox_Glass td.dxeLTM,
.dxeListBox_Glass .dxeHFC,
.dxeListBox_Glass .dxeHC,
.dxeListBox_Glass .dxeHLC,
.dxeListBox_Glass td.dxeFTMR,
.dxeListBox_Glass td.dxeTMR,
.dxeListBox_Glass td.dxeLTMR,
.dxeListBox_Glass .dxeHFCR,
.dxeListBox_Glass .dxeHCR,
.dxeListBox_Glass .dxeHLCR
{
	overflow: hidden;
	border-top-width: 0;
}
.dxeListBox_Glass .dxeCM,
.dxeListBox_Glass .dxeIM,
.dxeListBox_Glass .dxeMIM,
.dxeListBox_Glass .dxeCMR,
.dxeListBox_Glass .dxeIMR,
.dxeListBox_Glass .dxeMIMR
{
	border-top-width: 0;
}
.dxeListBox_Glass td.dxeFTM,
.dxeListBox_Glass td.dxeTM, 
.dxeListBox_Glass .dxeHFC,
.dxeListBox_Glass .dxeHC
{
	padding-right: 6px!important;
}
.dxeListBox_Glass td.dxeFTMR,
.dxeListBox_Glass td.dxeTMR,
.dxeListBox_Glass .dxeHFCR,
.dxeListBox_Glass .dxeHCR
{
	padding-left: 6px!important;
}
.dxeListBox_Glass td.dxeLTM,
.dxeListBox_Glass td.dxeTM,
.dxeListBox_Glass .dxeHC,
.dxeListBox_Glass .dxeHLC
{
	padding-left: 6px!important;
}
.dxeListBox_Glass td.dxeLTMR,
.dxeListBox_Glass td.dxeTMR,
.dxeListBox_Glass .dxeHCR,
.dxeListBox_Glass .dxeHLCR
{
	padding-right: 6px!important;
}
/*Grid lines*/
.dxeListBox_Glass td.dxeLTM,
.dxeListBox_Glass td.dxeTM,
.dxeListBox_Glass td.dxeMIM
{
	border-left: 1px solid #C2D4DA!important;
}
.dxeListBox_Glass td.dxeLTMR,
.dxeListBox_Glass td.dxeTMR,
.dxeListBox_Glass td.dxeMIMR
{
	border-right: 1px solid #C2D4DA!important;
}
.dxeListBox_Glass td.dxeIM,
.dxeListBox_Glass td.dxeFTM,
.dxeListBox_Glass td.dxeTM,
.dxeListBox_Glass td.dxeLTM,
.dxeListBox_Glass td.dxeCM,
.dxeListBox_Glass td.dxeMIM,
.dxeListBox_Glass td.dxeIMR,
.dxeListBox_Glass td.dxeFTMR,
.dxeListBox_Glass td.dxeTMR,
.dxeListBox_Glass td.dxeLTMR,
.dxeListBox_Glass td.dxeCMR,
.dxeListBox_Glass td.dxeMIMR
{
	border-bottom: 1px solid #C2D4DA;
}
/*Header*/
.dxeListBox_Glass .dxeHD
{
	background: #C0DDE0 url('/DXR.axd?r=0_1068-K2F8m') repeat-x top center;
	border-bottom: 1px solid #7EACB1;
}
.dxeListBox_Glass .dxeHFC,
.dxeListBox_Glass .dxeHIC,
.dxeListBox_Glass .dxeHC,
.dxeListBox_Glass .dxeHLC,
.dxeListBox_Glass td.dxeHCC,
.dxeListBox_Glass td.dxeHMIC,
.dxeListBox_Glass .dxeHFCR,
.dxeListBox_Glass .dxeHICR,
.dxeListBox_Glass .dxeHCR,
.dxeListBox_Glass .dxeHLCR,
.dxeListBox_Glass td.dxeHCCR,
.dxeListBox_Glass td.dxeHMICR
{
	padding-top: 4px;
	padding-bottom: 5px;
	border-bottom-width: 0;
	border-top-width: 0;
}
.dxeListBox_Glass .dxeHC,
.dxeListBox_Glass .dxeHLC,
.dxeListBox_Glass td.dxeHMIC
{
	border-left: 1px solid #7EACB1;
}
.dxeListBox_Glass .dxeHCR,
.dxeListBox_Glass .dxeHLCR,
.dxeListBox_Glass td.dxeHMICR
{
	border-right: 1px solid #7EACB1;
	text-align: right;
}
.dxeListBox_Glass .dxeHIC,
.dxeListBox_Glass .dxeHFC,
.dxeListBox_Glass .dxeHCC
{
	border-left: 1px solid #C0DDE0;
}
.dxeListBox_Glass .dxeHICR,
.dxeListBox_Glass .dxeHFCR,
.dxeListBox_Glass .dxeHCCR
{
	border-right: 1px solid #C0DDE0;
	text-align: right;
}
.dxeListBox_Glass .dxeHFC,
.dxeListBox_Glass .dxeHC,
.dxeListBox_Glass .dxeHMIC
{
	border-right-width: 0;
}
.dxeListBox_Glass .dxeHFCR,
.dxeListBox_Glass .dxeHCR,
.dxeListBox_Glass .dxeHMICR
{
	border-left-width: 0;
	text-align: right;
}
.dxeListBox_Glass .dxeHLC
{
	border-right: 1px solid #7EACB1;
}
.dxeListBox_Glass .dxeHLCR
{
	border-left: 1px solid #7EACB1;
	text-align: right;
}

/* -- Calendar -- */
.dxeCalendar_Glass
{
	color: black;
    font: 12px Tahoma, Geneva, sans-serif;
	font-weight: normal;
	border: 1px solid #7eacb1;
	background-color: White;
}
.dxeCalendar_Glass td.dxMonthGrid,
.dxeCalendar_Glass td.dxMonthGridWithWeekNumbers
{
	padding: 8px 20px 8px 8px;
	cursor: default;
}
.dxeCalendar_Glass td.dxMonthGrid
{
	padding-left: 20px;
}
.dxeCalendar_Glass td.dxMonthGridWithWeekNumbersRtl
{
	padding: 8px 8px 8px 20px;
	cursor: default;
}
.dxeCalendarDayHeader_Glass
{
	padding: 4px;
	color: Black;
	border-bottom: 1px solid #bcbcff;
}
.dxeCalendarWeekNumber_Glass
{
	font-size: 0.91em;
	text-align: right;
	color: #a0a0ff;
	padding: 6px 8px 2px 4px;
}
.dxeCalendarDay_Glass
{
	padding: 3px;
	color: Black;
	background-color: White;
	text-align: center;
}
.dxeCalendarWeekend_Glass       	
{
	color: #fe3c00;
}
.dxeCalendarOtherMonth_Glass    	 
{
	color: #acacac;
}
.dxeCalendarOutOfRange_Glass        
{
	color: #d0d0d0;
}
.dxeCalendarDayDisabled_Glass {
	background-color: #fafdfe;
	color: #eaedee!important;
}
.dxeCalendarToday_Glass       	        
{
	border: 1px solid #ff5c20;
	padding: 2px;
}
.dxeCalendarSelected_Glass       	
{
	background-color: #9eced6;
	color: #FFFFFF;
}
.dxeDayInRange.dxeCalendarSelected_Glass
{
    background-color: #e2f0f3;
    color: black;
}
.dxeCalendarHeader_Glass
{
	color: #000000;
	background-color: #bcdbeb;
	border-top: 1px solid #7eacb1;
	border-right: 0 solid #7eacb1;
	border-bottom: 1px solid #7eacb1;
	border-left: 0 solid #7eacb1;
	text-align: center;
	padding: 1px;
	height: 18px;
}
.dxeCalendarHeader_Glass td.dxe
{
	text-align: center;
	cursor: pointer;
}
.dxeCalendarHeader_Glass .dxeCHS
{
    min-width: 1px;
}
.dxeCalendarFooter_Glass
{
	background-color: #e3f0f7;
	padding: 6px 0px;
	border-top: 1px solid #7eacb1;
}
.dxeCalendarFooter_Glass .dxeCFS
{
    min-width: 4px;
}
.dxeCalendarFastNav_Glass
{
	background: white none;
	border-top: 1px solid #7eacb1;
	border-right: 1px solid #7eacb1;
	border-bottom: 0px solid #7eacb1;
	border-left: 1px solid #7eacb1;
	padding: 8px;
}
.dxeCalendarFastNavYearArea_Glass
{
    padding-top: 4px;
}
.dxeCalendarFastNavFooter_Glass
{
	background-color: #e3f0f7;
	padding: 6px 0px;
	border: 1px solid #7eacb1;
}
.dxeCalendarFastNavFooter_Glass .dxeCFNFS
{
    min-width: 4px;
}
.dxeCalendarFastNavMonth_Glass,
.dxeCalendarFastNavYear_Glass
{
	color: Black;
	padding: 4px 6px;
	text-align: center;
	cursor: pointer;
}
.dxeCalendarFastNavMonthSelected_Glass,
.dxeCalendarFastNavYearSelected_Glass
{
	background: #9eced6 none;
}
.dxeCalendarFastNavMonthHover_Glass,
.dxeCalendarFastNavYearHover_Glass
{
	background: #e4edef none;
}
.dxeDateEditTimeEditCell_Glass
{
    padding: 4px 25px 12px;
    width: 100px;
}
.dxeDateEditClockCell_Glass
{
    padding: 8px 14px 0;
}
.dxeCalendarFooter_Glass.dxeDETSF
{
    padding-left: 6px;
    padding-right: 6px;
}
/* Disabled */
.dxeDisabled_Glass,
.dxeDisabled_Glass td.dxe
{
	color: #93a1a4;
	cursor: default;
}
.dxeEditArea_Glass.dxeDisabled_Glass /*Bootstrap correction*/
{
    color: #93a1a4;
}
a.dxeDisabled_Glass, a.dxeDisabled_Glass:hover
{
	color: #93a1a4;
}
.dxeButtonDisabled_Glass
{
	color: #93a1a4;
	background: #cdd7db url('/DXR.axd?r=0_1038-K2F8m') repeat-x left top;
	border-color: #c2c3c4;
	cursor: default;
}
/* -- Button -- */
.dxbButton_Glass
{
	color: #000000;
	font: 12px Tahoma, Geneva, sans-serif;
	border: 1px solid #B2BCBE;
	background: #DADFE0 url('/DXR.axd?r=0_1035-K2F8m') repeat-x top;
	padding: 1px;
}
.dxbButtonHover_Glass
{
	background: #B5D7DB url('/DXR.axd?r=0_1039-K2F8m') repeat-x top;
	border: 1px solid #71ACB4;
}
.dxbButtonChecked_Glass
{
	background: #d3d3d3 url('/DXR.axd?r=0_1036-K2F8m') repeat-x top;
	border: 1px solid #929292;
}
.dxbButtonPressed_Glass
{
	background: #9ABDC1 url('/DXR.axd?r=0_1040-K2F8m') repeat-x top;
	border: 1px solid #71ACB4;
}

.dxbButton_Glass div.dxb
{
	padding: 2px 12px 3px;
	border: 1px dotted transparent;
}
.dxbButton_Glass div.dxbf
{
	border: 1px dotted #9C99CA;
}
/* Button Link */
a.dxbButton_Glass
{
    color: #2a769d;
    text-decoration: underline;
}
a.dxbButton_Glass:hover
{
	color: #f15e34;
}
a.dxbButton_Glass:visited
{
	color: #a1a1a1;
}
/* Disabled */
.dxbDisabled_Glass,
a.dxbButton_Glass.dxbDisabled_Glass
{
    color: #93a1a4;
	cursor: default;
    text-decoration: none;
}

/* -- FilterControl -- */
.dxfcControl_Glass
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: Black;
	padding: 0 1em;
}
.dxfcTable_Glass
{
	border-collapse: separate!important;
}
.dxfcTable_Glass td.dxfc
{
	padding: 0px 0px 0px 3px;
}
a.dxfcPropertyName_Glass
{
	white-space: nowrap!important;
	color: Blue!important;
}
a.dxfcGroupType_Glass
{
	white-space: nowrap!important;
	padding: 0px 3px!important;
	color: Red!important;
}
a.dxfcOperation_Glass
{
	white-space: nowrap!important;
	color: Green!important;
}
a.dxfcValue_Glass
{
	white-space: nowrap!important;
	color: Gray!important;
}
.dxfcImageButton_Glass
{
	cursor: pointer;
}

.dxeMaskHint_Glass
{
	background: #ffffe1 none;
	border: 1px solid black;
	padding: 2px 5px 3px;
	color: Black;
	font: 12px Tahoma, Geneva, sans-serif;
}

.dxfcControl_Glass ul.dxfc-tree,
.dxfcControl_Glass .dxfc-tree ul
{
    list-style-type: none;
    margin: 0;
    overflow-y: hidden;
    padding: 0;
}

.dxfcControl_Glass .dxfc-tree
{
    width: 100%;
}

.dxfcControl_Glass .dxfc-subnd
{
    margin-left: 22px;
}

.dxfcControl_Glass .dxfc > li > table
{
    border-spacing: 0;
    border-collapse: collapse;
}

.dxfcControl_Glass .dxfc-elb
{
    background: url('/DXR.axd?r=0_1066-K2F8m') no-repeat;
    float: left;
    height: 21px;
    vertical-align: top;
    width: 26px;
    margin-right: 0.3em;
}

.dxfcControl_Glass .dxfc-clr
{
    clear: both;
    display: block;
    font-size: 0;
    height: 0;
    visibility: hidden;
    width: 0;
}

.dxfcControl_Glass .dxfc-nd
{
    cursor: pointer;
    display: block;
    float: left;
    height: 24px;
    outline: 0 none;
    text-decoration: none;
    vertical-align: middle;
    white-space: nowrap;
}

.dxfcControl_Glass .dxfc-nd > tbody > tr > td > a,
.dxfcControl_Glass .dxfc-nd > tbody > tr > td > span,
.dxfcControl_Glass .dxfc-nd > tbody > tr > td > img,
.dxfcControl_Glass .dxfc-editor
{
    vertical-align: middle;
}

.dxfcControl_Glass .dxfc-nd > tbody > tr > td > a,
.dxfcControl_Glass .dxfc-nd > tbody > tr > td > td,
.dxfcControl_Glass .dxfc-nd > tbody > tr > td > span
{
    padding: 0 0.1ex;
}

.dxfcControl_Glass .dxfc-nd > tbody > tr > td > a
{
    line-height: 24px;
}

.dxfcControl_Glass .dxfc-ln
{
    background: url('/DXR.axd?r=0_1067-K2F8m') repeat-y;
    vertical-align: top;
}

.dxfcControl_Glass .dxfc-memo textarea 
{
	height: 80px;
	overflow: auto;
}

.dxfcControl_Glass .dxfc-validationSummary
{
	padding: 2px 5px 4px 6px !important;
	list-style-type: none;
	margin: 0;
}

.dxfcControl_Glass .dxfc-validationSummary li
{
	padding: 2px 0;
}

.dxfcControl_Glass .dxfc-validationSummary li a
{
	color: red;
	text-decoration: none;
	border-bottom: 1px dashed #f70;
}

.dxfcControl_Glass .dxfc-validationSummary li a:hover
{
	color: #f70;
}

/* -- ProgressBar -- */
.dxeProgressBar_Glass
{
	border: 1px Solid #4986a2;
	background: #C6E0E4 url('/DXR.axd?r=0_1043-K2F8m') repeat-x;
	font: 12px Tahoma, Geneva, sans-serif;
	color: Black;
    height: 25px;
}
.dxeProgressBar_Glass .dxePBMainCell,
.dxeProgressBar_Glass td.dxe
{
	padding: 0;
}
.dxeProgressBar_Glass td
{
	background: url('/DXR.axd?r=0_1045-K2F8m') no-repeat 50% center;
}
.dxeProgressBarIndicator_Glass
{
	background: #4986a2 url('/DXR.axd?r=0_1044-K2F8m') repeat-x;
}

/* -- DropDownWindow -- */
.dxpcDropDown_Glass,
.dxeDropDownWindow_Glass
{
    font: 12px Tahoma, Geneva, sans-serif;
}
.dxeDropDownWindow_Glass
{
	background-color: white;
	border: 1px solid #7EACB1;
}

/*----------------- ColorTable -----------------*/
.dxeColorIndicator_Glass
{
	border: 1px solid #7EACB1;
	width: 15px;
	height: 15px;
	cursor: pointer;
}
.dxeItemPicker_Glass
{
	background-color: #EDF3F4;
	border: 1px solid #7EACB1;
}
.dxeColorTable_Glass td.dx,
.dxeItemPicker_Glass td.dx
{
	padding: 4px;
}
.dxeColorTableCell_Glass,
.dxeItemPickerCell_Glass,
.dxeACICell_Glass
{
	padding: 3px;
	cursor: pointer;
}
.dxeColorTableCellDiv_Glass,
.dxeACICellDiv_Glass
{
	border: 1px solid #808080;
	width: 12px;
	height: 12px;
	font-size: 0;
}
.dxeColorTableCellSelected_Glass,
.dxeACICellSelected_Glass
{
	padding: 2px!important;
	background-color: #CBCBCB;
	border: 1px solid #888888;
}
.dxeColorTableCellHover_Glass,
.dxeItemPickerCellHover_Glass,
.dxeAutomaticColorItemCellHover_Glass,
.dxeAutomaticColorItem_Glass:hover > div
{
	padding: 2px!important;
}  
.dxeColorTableCellHover_Glass,
.dxeAutomaticColorItemCellHover_Glass,
.dxeAutomaticColorItem_Glass:hover > div
{
	background-color: #F2F2F2;
	border: 1px solid #888888;
}
.dxeItemPickerCellHover_Glass
{
	background-color: #D9ECED;
	border: 1px solid #C0DDE0;
}

/* -- Invalid Style -- */
.dxeInvalid_Glass
{
}
.dxeInvalid_Glass .dxeEditArea_Glass,
.dxeInvalid_Glass .dxeMemoEditArea_Glass
{
}

/* -- Focused Style -- */
.dxeFocused_Glass
{
	border: 1px solid #39555d;
}

.dxeFocused_Glass.dxeTrackBar_Glass
{	
	border: 0px;
}

/* -- Null Text Style -- */
.dxeNullText_Glass .dxeEditArea_Glass,
.dxeNullText_Glass .dxeMemoEditArea_Glass
{
	color: #93a1a4;
}

/* -- Captcha -- */
.dxcaControl_Glass 
{
    font: 12px Tahoma, Geneva, sans-serif;
}

.dxcaRefreshButton_Glass
{
	text-decoration: none;
	color: #2a769d;
}

.dxcaDisabledRefreshButton_Glass
{
	color: #93a1a4;
}

.dxcaRefreshButtonCell_Glass
{
	padding-left: 4px;
	padding-right: 4px;
}

.dxcaRefreshButtonText_Glass
{
	text-decoration: underline;
}

.dxcaDisabledRefreshButtonText_Glass
{
	text-decoration: none;
}

.dxcaTextBoxCell_Glass,
.dxcaTextBoxCellNoIndent_Glass
{
}

.dxcaTextBoxCellNoIndent_Glass .dxeErrorCell_Glass
{
	padding-left: 0px;
	padding-top: 4px;
	color: #a91123;
}

.dxcaTextBoxLabel_Glass
{
	padding-bottom: 4px;
	display: block;
}

.dxcaLoadingPanel_Glass
{
	border: 1px solid #7EACB1;
	background-color: #FFFFFF;
	font: 12px Tahoma, Geneva, sans-serif;
	color: #303030;
}

.dxcaLoadingPanel_Glass td.dx
{
	white-space: nowrap;
	text-align: center;
	padding: 12px;
}
.dxcaLoadingPanel_Glass .dxlp-loadingImage 
{
	margin:0px;
}

.dxpcLite_Glass .dxHFBPS
{
    width: 6px;
}

.dxeTextBox_Glass,
.dxeButtonEdit_Glass,
.dxeIRadioButton_Glass,
.dxeRadioButtonList_Glass,
.dxeCheckBoxList_Glass
{
    cursor: default;
}

/* Removes flicking in iOS Safari*/
.dxeTrackBar_Glass, 
.dxeIRadioButton_Glass, 
.dxeButtonEdit_Glass, 
.dxeTextBox_Glass, 
.dxeRadioButtonList_Glass, 
.dxeCheckBoxList_Glass, 
.dxeMemo_Glass, 
.dxeListBox_Glass, 
.dxeCalendar_Glass, 
.dxeColorTable_Glass
{
	-webkit-tap-highlight-color: rgba(0,0,0,0);
}

/* ASPxCololrEdit */
.dxcpParametersCellSys .dxcpWebColorInput_Glass 
{
	float: right;
	margin-top: 40px;
	*margin-top: 35px;
}
.dxcpColorParameterMainDiv_Glass 
{
	padding: 0px 0 4px 9px;
	width: 90px;
	text-align: right;
}
.dxeCustomColorButton_Glass 
{
    padding-top: 2px;
    padding-bottom: 2px;
	margin: 3px 7px;
	cursor: pointer;
}
.dxeAutomaticColorItem_Glass
{
	padding: 4px 4px 0px 4px;
}
.dxeAutomaticColorItem_Glass > span
{
    margin: 0px 5px;
    line-height: 20px;
}
.dxcpCurrentColor_Glass, 
.dxcpSavedColor_Glass 
{
	height: 35px;
}
.dxcpCurrentAndSaved_Glass 
{
	width: 65px;
	margin: 34px 0px 0px auto;
	cursor: pointer;
}
.dxeColorTablesMainDiv_Glass,
.dxeColorSelectorMainDiv_Glass 
{
	background-color: #FFFFFF;
}
.dxeColorSelectorMainDiv_Glass 
{
	padding: 7px;
}
.dxcpColorArea_Glass,
.dxcpHueAreaImage_Glass,
.dxcpCurrentAndSaved_Glass,
.dxeColorTablesMainDiv_Glass,
.dxeColorSelectorMainDiv_Glass,
.dxcpParametersCell_Glass input
{
	border: 1px solid #7EACB1;
}
.dxeButtonsPanelDiv_Glass 
{
	margin-top: 15px;
	text-align: right;
}
.dxeButtonsPanelDiv_Glass input 
{
	min-width: 58px;
	margin-left: 10px;
}

/* -- ASPxTokenBox -- */
input.dxeTokenBoxInput_Glass[type="text"] {
	display: inline-block;
	float: left;
	width: 30px;
	outline: none;
	margin: 1px;
	padding: 1px;
}
.dxeToken_Glass {
    border: 1px solid #6f9fb5;
	border-radius: 2px;
    display: inline-block;
	float: left;
	min-width: 30px;
	margin-right: 1px;
	margin-bottom: 1px;
}
.dxeTokenText_Glass, .dxeTokenRemoveButton_Glass {
	display: block;
	float: left;
}
.dxeTokenText_Glass {
	overflow: hidden;
	text-overflow: ellipsis;
	margin-left: 4px;
}
.dxeTokenRemoveButton_Glass {
	cursor: pointer;
}
.dxeToken_Glass {
	background: #bfd6df url('/DXR.axd?r=0_1053-K2F8m') repeat-x top;
}
.dxFirefox input.dxeTokenBoxInput_Glass[type="text"] {
	padding: 0;
	margin: 1px;
}
.dxFirefox .dxeTokenText_Glass {
	margin-top: -1px;
	margin-bottom: -1px;
}

/* ASPxPictureEdit */
.dxpePreviewContainer_Glass
{
    position: relative;
}
.dxpeCommandPanel_Glass
{
    background-color: #333333;
    background-color: rgba(0, 0, 0, 0.75);
    color: white;
    height: 32px;
    position: absolute;
}
.dxpeBottomCommandPanel_Glass
{
    width: 100%;
    bottom: 0;
}

.dxpeTopCommandPanel_Glass
{
    width: 100%;      
    top: 0;    
}
.dxpeCommandPanelDeleteButton_Glass, 
.dxpeCommandPanelOpenDialogButton_Glass
{    
    cursor: pointer;
    display: inline-block;
}
.dxpeCommandPanelButtonsWrapper_Glass
{
    position: absolute;
}
.dxpeCommandPanelButtonsWrapperLeft_Glass
{
    left: 0;
}
.dxpeCommandPanelButtonsWrapperCenter_Glass
{
    left: 50%;
    margin-left: -32px;
}
.dxpeCommandPanelButtonsWrapperRight_Glass
{
    right: 0;
}
.dxpeCommandPanelDeleteButtonHover_Glass,
.dxpeCommandPanelDeleteButtonPressed_Glass,
.dxpeCommandPanelOpenDialogButtonHover_Glass,
.dxpeCommandPanelOpenDialogButtonPressed_Glass
{
}
.dxpeCommandPanelDeleteButtonDisabled_Glass,
.dxpeCommandPanelOpenDialogButtonDisabled_Glass
{
}
.dxpeDropZone_Glass
{
    background-color: gray;
}
.dxpePlaceHolder_Glass
{
    background-color: lightgray;
    z-index: -1;
}
.dxpeTextPanelContainer_Glass
{
    height: 100%;
    font-size: 200%;
    text-align: center;
    width: 100%;
}
.dxpeTextPanel_Glass
{
    height: 100%;
    position: absolute;
    top: 0;
    width: 100%;
}

/* Editor caption */
.dxeCaptionCell_Glass
{
    font: 12px Tahoma, Geneva, sans-serif;
    color: #303030;
    white-space: nowrap;
    line-height: 16px;
    height: 100%;
}
.dxeRoot_Glass
{
}
.dxeCaption_Glass
{
}
.dxeCaptionCell_Glass.dxeCaptionVATSys.dxeTextEditCTypeSys
{
    padding-top: 3px;
}
.dxeCaptionCell_Glass.dxeCaptionVATSys.dxeCheckBoxCTypeSys
{
    padding-top: 3px;
}
.dxeCaptionCell_Glass.dxeCaptionVATSys.dxeRadioButtonCTypeSys
{
    padding-top: 4px;
}
.dxeCaptionCell_Glass.dxeCaptionVATSys.dxeCheckBoxListCTypeSys
{
    padding-top: 10px;
}
.dxeCaptionCell_Glass.dxeCaptionVATSys.dxeRadioButtonListCTypeSys
{
    padding-top: 10px;
}
.dxeCaptionCell_Glass.dxeCaptionVATSys.dxeListBoxCTypeSys
{
    padding-top: 3px;
}
.dxeCaptionCell_Glass.dxeCaptionVATSys.dxeTrackBarCTypeSys
{
    padding-top: 6px;
}
.dxeCaptionCell_Glass.dxeCaptionVATSys.dxeProgressBarCTypeSys
{
    padding-top: 4px;
}
.dxeCaptionCell_Glass.dxeCaptionVATSys.dxeMemoCTypeSys
{
    padding-top: 3px;
}
.dxeCaptionCell_Glass.dxeCaptionVATSys.dxeCustomCTypeSys
{
    padding-top: 5px;
    padding-bottom: 5px;
}

.dxFirefox .dxeCaptionCell_Glass.dxeCaptionVATSys.dxeListBoxCTypeSys
{
    padding-top: 4px;
}
.dxFirefox .dxeCaptionCell_Glass.dxeCaptionVATSys.dxeProgressBarCTypeSys
{
    padding-top: 5px;
}

.dxWebKitFamily .dxeCaptionCell_Glass.dxeCaptionVATSys.dxeListBoxCTypeSys
{
    padding-top: 4px;
}

/* Safari */
.dxeCaptionCellSafariSys.dxeCaptionCell_Glass.dxeCaptionVATSys.dxeListBoxCTypeSys
{
    padding-top: 3px;
}

.dxeRequiredMark_Glass {
    color: green;
    font-style: normal;
}

.dxeOptionalMark_Glass {
    color: gray;
    font-style: normal;
}

/* Out of range warning*/
.dxeOutOfRWarn_Glass {
    font: 12px Tahoma, Geneva, sans-serif;
    padding: 3px 8px 4px 8px;
    display: none;
    position: absolute;
    background-color: white;
    color: red;
    border-radius: 3px;
    z-index: 41998;
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
    -o-border-radius: 3px;
    -khtml-border-radius: 3px;
    -webkit-box-shadow: rgba(0, 0, 0, 0.1) 0 1px 3px;
    -moz-box-shadow: rgba(0, 0, 0, 0.1) 0 1px 3px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    border: 1px solid #A8A8A8;
}
.dxeOutOfRWarnRight_Glass {
    margin-left: 10px;
}
.dxeOutOfRWarnBottom_Glass {
    margin-top: 10px;
}
