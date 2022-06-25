/* -- ValidationSummary -- */
.dxvsValidationSummary_DevEx
{
	font: 11px Verdana, Geneva, sans-serif;
	color: Red;
}
.dxvsValidationSummary_DevEx td.dxvsRC_DevEx
{
	vertical-align: top;
	padding: 2px 5px 4px 6px;
}
.dxvsValidationSummary_DevEx .dxvsE_DevEx
{
}
.dxvsValidationSummary_DevEx table.dxvsHT_DevEx
{
	width: 100%;
}
.dxvsValidationSummary_DevEx td.dxvsH_DevEx
{
	padding: 2px 0;
}
.dxvsValidationSummary_DevEx a.dxvsHL_DevEx,
.dxvsValidationSummary_DevEx a.dxvsHL_DevEx:visited
{
	color: red;
}
.dxvsValidationSummary_DevEx a.dxvsHL_DevEx
{
	text-decoration: none;
	border-bottom: 1px dashed #f70;
}
.dxvsValidationSummary_DevEx a.dxvsHL_DevEx:hover
{
	color: #f70;
}
.dxvsValidationSummary_DevEx table.dxvsT_DevEx
{
}
.dxvsValidationSummary_DevEx tr.dxvsE_DevEx
{
}
.dxvsValidationSummary_DevEx td.dxvsETC_DevEx
{
	padding: 2px 0;
}
.dxvsValidationSummary_DevEx ul.dxvsL_DevEx
{
}
.dxvsValidationSummary_DevEx ol.dxvsL_DevEx
{
}
.dxvsValidationSummary_DevEx li.dxvsE_DevEx
{
	padding: 2px 0;
}

/* TrackBar */
.dxeTrackBar_DevEx
{
    font: 11px Verdana, Geneva, sans-serif;
	user-select: none;
	-moz-user-select: -moz-none;
	-khtml-user-select: none;
	-webkit-user-select: none;
	visibility: hidden;
}

.dxeDisabled_DevEx .dxeTBHSys a,
.dxeDisabled_DevEx .dxeTBVSys a
{
    cursor: default;
}

.dxeTBBarHighlight_DevEx
{
	font-size: 0;
}

.dxeTBScale_DevEx,
.dxeTBTrack_DevEx,
.dxeTBBarHighlight_DevEx
{
	cursor: pointer;
}

.dxeTBScale_DevEx
{
	z-index: 1;
	font-size: 0.91em;
}
.dxeTBSecondaryDH_DevEx,
.dxeTBMainDH_DevEx
{
	z-index: 4;
}

.dxeTrackBar_DevEx.dxeTBHSys
{
	width: 170px;
	height: 47px;
}
.dxeTrackBar_DevEx.dxeTBVSys
{
	height: 170px;
	width: 47px;
}
.dxeTrackBar_DevEx.dxeTBBScaleSys.dxeTBVSys
{
	width: 70px;
}
.dxeTrackBar_DevEx.dxeTBBScaleSys.dxeTBHSys
{	
	height: 70px;
}

.dxeTBTrack_DevEx
{
	z-index: 2;
	position: absolute;
}

.dxeTBHSys .dxeTBTrack_DevEx
{
	background-image:  url('/DXR.axd?r=0_749-K2F8m');
}
.dxeTBVSys .dxeTBTrack_DevEx
{
	background-image:  url('/DXR.axd?r=0_750-K2F8m');
}

.dxeTBHSys .dxeTBTrack_DevEx, 
.dxeTBHSys .dxeTBBarHighlight_DevEx
{
	height: 9px;
}
.dxeTBVSys .dxeTBTrack_DevEx, 
.dxeTBVSys .dxeTBBarHighlight_DevEx
{
	width: 9px;
}

.dxeTBHSys .dxeTBMainDH_DevEx,
.dxeTBHSys .dxeTBSecondaryDH_DevEx
{	
	top: -5px;
	width:13px;
	height:19px;
}
.dxeTBVSys .dxeTBMainDH_DevEx,
.dxeTBVSys .dxeTBSecondaryDH_DevEx
{
	left: -5px;
	width:19px;
	height:13px;
}

.dxeTBVSys .dxeTBRBScaleSys .dxeTBTrack_DevEx,
.dxeTBVSys .dxeTBTrack_DevEx
{
	left: 6px;
}
.dxeTBVSys .dxeTBLTScaleSys .dxeTBTrack_DevEx
{
	right: 6px;
	left: auto;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBTrack_DevEx
{
	bottom: 6px;
	top: auto;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBTrack_DevEx,
.dxeTBHSys .dxeTBTrack_DevEx
{
	top: 6px;
}

.dxeTBBarHighlight_DevEx
{
	left: 0px;
	top: 0px;
	position:absolute;
	z-index: 3;
}

.dxeTBHSys .dxeTBBarHighlight_DevEx
{
	background-image:  url('/DXR.axd?r=0_739-K2F8m');
}
.dxeTBVSys .dxeTBBarHighlight_DevEx
{
	background-image:  url('/DXR.axd?r=0_740-K2F8m');
}

.dxeTBRBLabel_DevEx,
.dxeTBLTLabel_DevEx
{
	text-align: center;
	cursor: default;
}
.dxeTBSmallTickSys .dxeTBRBLabel_DevEx,
.dxeTBSmallTickSys .dxeTBLTLabel_DevEx,
.dxeTBLargeTickSys .dxeTBRBLabel_DevEx,
.dxeTBLargeTickSys .dxeTBLTLabel_DevEx
{	
	position: absolute;
}

.dxeTBHSys .dxeTBRBLabel_DevEx,
.dxeTBHSys .dxeTBLTLabel_DevEx
{
	width: 100%;
}

.dxeTBIncBtn_DevEx,
.dxeTBDecBtn_DevEx
{
}

.dxeTBVSys .dxeTBRBLabel_DevEx,
.dxeTBVSys .dxeTBLTLabel_DevEx
{
	padding-top: 2px;
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBRBLabel_DevEx
{
	margin-left: -4px;
}
.dxeTBVSys .dxeTBRBScaleSys .dxeTBRBLabel_DevEx,
.dxeTBVSys .dxeTBBScaleSys .dxeTBLTLabel_DevEx
{
	right: 0px;
}
.dxeTBVSys .dxeTBLTScaleSys .dxeTBLTLabel_DevEx,
.dxeTBVSys .dxeTBBScaleSys .dxeTBRBLabel_DevEx
{
	left: 0px;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBRBLabel_DevEx,
.dxeTBHSys .dxeTBBScaleSys .dxeTBLTLabel_DevEx
{
	bottom: 0px;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBLTLabel_DevEx,
.dxeTBHSys .dxeTBBScaleSys .dxeTBRBLabel_DevEx
{
	top: 0px;
}

.dxeTBHSys .dxeTBItem_DevEx .dxeTBRBLabel_DevEx,
.dxeTBHSys .dxeTBItem_DevEx .dxeTBLTLabel_DevEx
{
	display: inline-block;
	margin-left: 0px!important;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBItem_DevEx .dxeTBRBLabel_DevEx
{
	padding-top: 12px;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBItem_DevEx .dxeTBLTLabel_DevEx
{
	margin-top: 8px;
}
.dxeTBVSys .dxeTBRBScaleSys .dxeTBItem_DevEx .dxeTBRBLabel_DevEx 
{
	margin-left: 5px;
}

.dxeTBSelectedItem_DevEx .dxeTBRBLabel_DevEx,
.dxeTBSelectedItem_DevEx .dxeTBLTLabel_DevEx,
.dxeTBSelectedTick_DevEx .dxeTBRBLabel_DevEx,
.dxeTBSelectedTick_DevEx .dxeTBLTLabel_DevEx
{
	color: #898D98;
}

.dxeDisabled_DevEx .dxeTBSelectedItem_DevEx .dxeTBRBLabel_DevEx,
.dxeDisabled_DevEx .dxeTBSelectedItem_DevEx .dxeTBLTLabel_DevEx,
.dxeDisabled_DevEx .dxeTBSelectedTick_DevEx .dxeTBRBLabel_DevEx,
.dxeDisabled_DevEx .dxeTBSelectedTick_DevEx .dxeTBLTLabel_DevEx
{
	color: #C4C6CB;
}

.dxeTBRBLabel_DevEx,
.dxeTBLTLabel_DevEx,
.dxeTBItem_DevEx
{
	color: #C4C6CC;
}

.dxeDisabled_DevEx .dxeTBRBLabel_DevEx,
.dxeDisabled_DevEx .dxeTBLTLabel_DevEx,
.dxeDisabled_DevEx .dxeTBItem_DevEx
{
	color: #E1E2E5;
}

.dxeTBVSys .dxeTBLTScaleSys .dxeTBItem_DevEx
{
	text-align: left;
}

.dxeTBVSys .dxeTBRBScaleSys .dxeTBItem_DevEx
{
	text-align: right;
}

.dxeTBVSys .dxeTBBScaleSys .dxeTBItem_DevEx
{
	text-align: center;
}

.dxeTBHSys .dxeTBItem_DevEx
{
	background-image:  url('/DXR.axd?r=0_745-K2F8m');
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBItem_DevEx
{
	background-image:  url('/DXR.axd?r=0_743-K2F8m');
}
.dxeTBVSys .dxeTBItem_DevEx 
{
	background-image:  url('/DXR.axd?r=0_746-K2F8m');
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBItem_DevEx
{
	background-image:  url('/DXR.axd?r=0_744-K2F8m');
}

.dxeTBHSys .dxeTBLargeTick_DevEx
{
	background-image:  url('/DXR.axd?r=0_745-K2F8m');
}
.dxeTBVSys .dxeTBLargeTick_DevEx
{
	background-image: url('/DXR.axd?r=0_746-K2F8m');
}
.dxeTBHSys .dxeTBSmallTick_DevEx
{
	background-image: url('/DXR.axd?r=0_747-K2F8m');
}
.dxeTBVSys .dxeTBSmallTick_DevEx
{
	background-image: url('/DXR.axd?r=0_748-K2F8m');
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBLargeTick_DevEx
{
	background-image: url('/DXR.axd?r=0_741-K2F8m');
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBLargeTick_DevEx
{
	background-image: url('/DXR.axd?r=0_742-K2F8m');
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBSmallTick_DevEx
{
	background-image: url('/DXR.axd?r=0_743-K2F8m');
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBSmallTick_DevEx
{
	background-image: url('/DXR.axd?r=0_744-K2F8m');
}

.dxeTBVSys .dxeTBIncBtn_DevEx,
.dxeTBVSys .dxeReversedDirectionSys .dxeTBDecBtn_DevEx
{
	bottom: 0px;
	top: auto;
}
.dxeTBVSys .dxeTBDecBtn_DevEx,
.dxeTBVSys .dxeReversedDirectionSys .dxeTBIncBtn_DevEx
{
	top: 0px;
	bottom: auto;
}
.dxeTBHSys .dxeTBDecBtn_DevEx, 
.dxeTBHSys .dxeReversedDirectionSys .dxeTBIncBtn_DevEx
{
	left: 0px;
	right: auto;
}
.dxeTBHSys .dxeTBIncBtn_DevEx,
.dxeTBHSys .dxeReversedDirectionSys .dxeTBDecBtn_DevEx
{
	right: 0px;
	left: auto;
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBDecBtn_DevEx,
.dxeTBVSys .dxeTBBScaleSys .dxeTBIncBtn_DevEx
{
	margin-left: -9px;
	left: 50%;
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBDecBtn_DevEx,
.dxeTBHSys .dxeTBBScaleSys .dxeTBIncBtn_DevEx
{
	margin-top: -9px;
	top: 50%;
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBTrack_DevEx
{ 
	margin-left: -4px;
	left: 50%;
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBTrack_DevEx
{ 
	margin-top: -4px;
	top: 50%;
}

.dxeTBVSys .dxeTBLTScaleSys .dxeTBDecBtn_DevEx,
.dxeTBVSys .dxeTBLTScaleSys .dxeTBIncBtn_DevEx
{
	right: 2px;
	left: auto;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBDecBtn_DevEx,
.dxeTBHSys .dxeTBLTScaleSys .dxeTBIncBtn_DevEx
{
	bottom: 2px;
	top: auto;
}
.dxeTBVSys .dxeTBRBScaleSys .dxeTBDecBtn_DevEx,
.dxeTBVSys .dxeTBRBScaleSys .dxeTBIncBtn_DevEx,
.dxeTBVSys .dxeTBDecBtn_DevEx,
.dxeTBVSys .dxeTBIncBtn_DevEx
{
	left: 2px;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBDecBtn_DevEx,
.dxeTBHSys .dxeTBRBScaleSys .dxeTBIncBtn_DevEx,
.dxeTBHSys .dxeTBDecBtn_DevEx,
.dxeTBHSys .dxeTBIncBtn_DevEx
{
	top: 2px;
}

.dxeHelpText_DevEx,
.dxeTBValueToolTip_DevEx
{
    font: 11px Verdana, Geneva, sans-serif;
}
div.dxeHelpText_DevEx,
.dxeTBValueToolTip_DevEx
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
    border: 1px solid #A8A8A8;
    background: #FDFEFE;
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FDFEFE', endColorstr='#EEEFF2');
	background: -webkit-gradient(linear, left top, left bottom, from(#FDFEFE), to(#EEEFF2));
	background: -moz-linear-gradient(top,  #FDFEFE,  #EEEFF2);
}
td.dxeHelpText_DevEx {
    visibility: visible;
    color: #9F9F9F;
}
td.dxeHelpText_DevEx span {
    font-size: 0.91em;
}
td.dxeHelpText_DevEx.dxeHHelpTextSys {
    padding: 0 6px;
}
td.dxeHelpText_DevEx.dxeVHelpTextSys {
    padding: 2px 0;
}

/* InternalCheckBox */
.dxeIRBFocused_DevEx
{
	border: 1px dotted #a390ec;
	margin: 0px!important;
}
.dxeIRadioButton_DevEx
{
}

.dxeButtonEditSys .dxic .dxeLoadingDiv_DevEx
{
	opacity: 1!important;
	filter: alpha(opacity=100)!important;
}

.dxeButtonEditSys .dxic .dxeLoadingPanel_DevEx
{
    background-color: transparent!important;
}

.dxeButtonEditSys .dxic .dxeLoadingPanel_DevEx td.dx
{
	padding: 0px!important;
}

.dxeButtonEditSys .dxic .dxeLoadingPanel_DevEx td.dx > span
{
	display: none;
}

.dxeButtonEditSys .dxic .dxeLoadingPanel_DevEx td.dx > img
{
	height: 15px;
    width: auto;
    vertical-align: middle;
}

.dxeReadOnly_DevEx
{
}
.dxeBase_DevEx
{
	font: 11px Verdana, Geneva, sans-serif;
}
/* -- ErrorFrame -- */
.dxeErrorCell_DevEx
{
	font: 11px Verdana, Geneva, sans-serif;
	color: Red;
    border-color: black;
	padding-left: 4px;
	padding-right: 4px;
}
.dxeErrorFrameWithoutError_DevEx
{
	border: 1px solid Red;
}
.dxeErrorFrameWithoutError_DevEx .dxeControlsCell_DevEx,
.dxeErrorFrameWithoutError_DevEx.dxeControlsCell_DevEx
{
	padding: 2px;
}

.dxeEditArea_DevEx
{
	border-top: 1px solid #9da0aa;
	border-right: 1px solid #c2c4cb;
	border-bottom: 1px solid #d9dae0;
	border-left: 1px solid #c2c4cb;
}
body input.dxeEditArea_DevEx /*Bootstrap correction*/
{
    color: black;
}
input[type="text"].dxeEditArea_DevEx, /*Bootstrap correction*/
input[type="password"].dxeEditArea_DevEx /*Bootstrap correction*/
{
    margin-top: 0;
    margin-bottom: 1px;
}

.dxFirefox input[type="text"].dxeEditArea_DevEx,
.dxFirefox input[type="password"].dxeEditArea_DevEx
{
	margin-top: -1px;
    margin-bottom: 0;
}

/* -- Binary Image -- */
.dxeBinaryImageButtonPanel_DevEx
{
    height: 36px;
}
.dxeBinaryImageButton_DevEx
{
    margin: 0 6px;
}

/* -- Buttons -- */
.dxeButtonEditButton_DevEx,
.dxeCalendarButton_DevEx,
.dxeSpinIncButton_DevEx,
.dxeSpinDecButton_DevEx,
.dxeSpinLargeIncButton_DevEx,
.dxeSpinLargeDecButton_DevEx,
.dxeColorEditButton_DevEx
{
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	cursor: pointer;
}
.dxeCalendarButton_DevEx,
.dxeColorEditButton_DevEx
{
	border-style: solid;
	border-color: #a9acb5;
}
.dxeButtonEditButton_DevEx
{
	border-style: solid;
	border-color: Transparent;
	-border-color: White;
}
.dxeButtonEditButton_DevEx.dxeButtonEditButtonHover_DevEx
{
	border-color: #c0c9e3;
}
.dxeButtonEditButton_DevEx.dxeButtonEditButtonPressed_DevEx
{
	border-color: #c2c4cb;
}
.dxeButtonEditButton_DevEx.dxeDisabled_DevEx
{
	border-color: Transparent;
	-border-color: White;
}

.dxeCalendarButton_DevEx,
.dxeColorEditButton_DevEx
{
	border-width: 1px;
}
.dxeButtonEditButton_DevEx
{
	border-top-width: 0;
	border-right-width: 0;
	border-bottom-width: 0;
	border-left-width: 1px;
}
.dxeButtonEdit_DevEx .dxeButtonLeft
{
	border-top-width: 0;
	border-right-width: 1px;
	border-bottom-width: 0;
	border-left-width: 0;
}
.dxeSpinIncButton_DevEx,
.dxeSpinDecButton_DevEx,
.dxeSpinLargeIncButton_DevEx,
.dxeSpinLargeDecButton_DevEx
{
	border-width: 0;
}

.dxeButtonEditButton_DevEx,
.dxeSpinLargeIncButton_DevEx,
.dxeSpinLargeDecButton_DevEx,
.dxeSpinIncButton_DevEx,
.dxeSpinDecButton_DevEx
{
	background: White none;
}

.dxeButtonEditButton_DevEx 
{
	padding: 3px 2px 3px 3px;
}
.dxeSpinIncButton_DevEx
{
	padding: 2px 5px 2px 5px;
}
.dxeSpinDecButton_DevEx
{
	padding: 3px 5px 2px 5px;
}
.dxeSpinLargeIncButton_DevEx,
.dxeSpinLargeDecButton_DevEx
{
	padding: 6px 4px 6px 4px;
}

.dxeCalendarButton_DevEx,
.dxeColorEditButton_DevEx
{
	background: #ebedf2 url('/DXR.axd?r=0_730-K2F8m') repeat-x left top;
	padding: 3px 11px 4px;
	min-width: 37px;
}


.dxeButtonEditButton_DevEx.dxeButtonEditClearButton_DevEx,
.dxeButtonEditButton_DevEx.dxeButtonEditClearButton_DevEx:hover
{
    background: none;
    border-width: 0;
    padding-bottom: 1px;
    padding-top: 2px;
}

.dxeButtonEditClearButton_DevEx img
{
    vertical-align: baseline;
}

/* -- Pressed -- */
.dxeCalendarButtonPressed_DevEx,
.dxeColorEditButton_DevEx:active
{
	color: #3c3c3c;
	border-color: #9da0aa;
	background: #dbdde2 url('/DXR.axd?r=0_733-K2F8m') repeat-x left top;
}
.dxeButtonEditButtonPressed_DevEx,
.dxeSpinIncButtonPressed_DevEx,
.dxeSpinDecButtonPressed_DevEx,
.dxeSpinLargeIncButtonPressed_DevEx, 
.dxeSpinLargeDecButtonPressed_DevEx
{
	background: #e3e5e8 url('/DXR.axd?r=0_735-K2F8m') repeat-x left top;
}

/* -- Hover -- */
.dxeCalendarButtonHover_DevEx,
.dxeColorEditButton_DevEx:hover
{
	border-color: #a9acb5;
}
.dxeCalendarButtonHover_DevEx,
.dxeColorEditButton_DevEx:hover
{
	background: #dde6fe url('/DXR.axd?r=0_732-K2F8m') repeat-x left top;
}
.dxeButtonEditButtonHover_DevEx,
.dxeSpinIncButtonHover_DevEx,
.dxeSpinDecButtonHover_DevEx,
.dxeSpinLargeIncButtonHover_DevEx,
.dxeSpinLargeDecButtonHover_DevEx
{
	background: #e6edfe url('/DXR.axd?r=0_734-K2F8m') repeat-x left top;
}

.dxeButtonEdit_DevEx
{
	background-color: white;
	border-top: 1px solid #9da0aa;
	border-right: 1px solid #c2c4cb;
	border-bottom: 1px solid #d9dae0;
	border-left: 1px solid #c2c4cb;

    border-collapse: separate;
    border-spacing: 0;

    font: 11px Verdana, Geneva, sans-serif;
}
.dxeButtonEdit_DevEx td.dxic,
.dxFirefox .dxeButtonEdit_DevEx td.dxic
{
    padding: 3px 3px 2px 3px;
}
.dxeButtonEdit_DevEx .dxeEditArea_DevEx
{
	background-color: white;
}
.dxeButtonEdit_DevEx .dxeIIC,
.dxeButtonEdit_DevEx .dxeIICR
{
	padding: 1px;
}
.dxeButtonEdit_DevEx .dxeIIC img
{
	padding-left: 3px;
}
.dxeButtonEdit_DevEx .dxeIICR img
{
	padding-right: 3px;
}

.dxeTextBox_DevEx
{
	background-color: white;
	border-top: 1px solid #9da0aa;
	border-right: 1px solid #c2c4cb;
	border-bottom: 1px solid #d9dae0;
	border-left: 1px solid #c2c4cb;

    font: 11px Verdana, Geneva, sans-serif;
}
.dxeTextBox_DevEx .dxeEditArea_DevEx
{
	background-color: white;
}
.dxeRadioButtonList_DevEx,
.dxeCheckBoxList_DevEx
{
	border-top: 1px solid #9da0aa;
	border-right: 1px solid #c2c4cb;
	border-bottom: 1px solid #d9dae0;
	border-left: 1px solid #c2c4cb;
}

.dxeCheckBoxList_DevEx .dxe > table,
.dxeRadioButtonList_DevEx .dxe > table 
{
    width: 100%;
}

.dxeRadioButtonList_DevEx,
.dxeCheckBoxList_DevEx
{
	font: 11px Verdana, Geneva, sans-serif;
}
.dxeRadioButtonList_DevEx td.dxe,
.dxeCheckBoxList_DevEx td.dxe
{
	padding: 7px 5px 6px 11px;
}
.dxeRadioButtonList_DevEx[dir='rtl'] td.dxe,
.dxeCheckBoxList_DevEx[dir='rtl'] td.dxe
{
	padding: 7px 11px 6px 5px;
}

/* Disabled */
.dxeDisabled_DevEx .dxeButtonEditButton_DevEx,
.dxeDisabled_DevEx .dxeSpinIncButton_DevEx,
.dxeDisabled_DevEx .dxeSpinDecButton_DevEx,
.dxeDisabled_DevEx .dxeSpinLargeIncButton_DevEx,
.dxeDisabled_DevEx .dxeSpinLargeDecButton_DevEx
{
	background: White none;
}

/* -- Memo -- */
.dxeMemo_DevEx
{
	background-color: white;
	border-top: 1px solid #9da0aa;
	border-right: 1px solid #c2c4cb;
	border-bottom: 1px solid #d9dae0;
	border-left: 1px solid #c2c4cb;

    font: 11px Verdana, Geneva, sans-serif;
}
.dxeMemoEditArea_DevEx
{
    outline: none;
	background-color: white;
}

/* -- Hyperlink -- */
.dxeHyperlink_DevEx
{
	font: 11px Verdana, Geneva, sans-serif;
	color: #1b3f91;
	text-decoration: none;
}
a.dxeHyperlink_DevEx:hover
{
	text-decoration: underline;
}
a.dxeHyperlink_DevEx:visited
{
	color: #8684ed;
}

/* -- ListBox -- */
.dxeListBox_DevEx
{
	color: #201f35;
	font: 11px Verdana, Geneva, sans-serif;
	background-color: white;
	border-top: 1px solid #9da0aa;
	border-right: 1px solid #c2c4cb;
	border-bottom: 1px solid #d9dae0;
	border-left: 1px solid #c2c4cb;
	width: 70px;
	height: 109px;
}
.dxeListBox_DevEx div.dxlbd
{
	height: 108px;
}
.dxeListBoxItemRow_DevEx
{
	cursor: default;
}
.dxeListBoxItem_DevEx
{
	padding: 2px 5px;
	white-space: nowrap;
	text-align: left;
	border-width: 0;
}
.dxeListBoxItem_DevEx em
{
	background: #e2eafd none repeat 0 0;
	color: #201f35;
	font-weight: bold;
	font-style: normal;
}

.dxeListBox_DevEx td.dxeI,
.dxeListBox_DevEx td.dxeIM,
.dxeListBox_DevEx .dxeHIC, 
.dxeListBox_DevEx td.dxeFTM,
.dxeListBox_DevEx td.dxeTM,
.dxeListBox_DevEx td.dxeC,
.dxeListBox_DevEx td.dxeCM,
.dxeListBox_DevEx td.dxeHCC,
.dxeListBox_DevEx td.dxeMI,
.dxeListBox_DevEx td.dxeMIM
{
	border-right-width: 0!important;
}

.dxeListBox_DevEx td.dxeIR,
.dxeListBox_DevEx td.dxeIMR,
.dxeListBox_DevEx .dxeHICR, 
.dxeListBox_DevEx td.dxeFTMR,
.dxeListBox_DevEx td.dxeTMR,
.dxeListBox_DevEx td.dxeCR,
.dxeListBox_DevEx td.dxeCMR,
.dxeListBox_DevEx td.dxeHCCR,
.dxeListBox_DevEx td.dxeMIR,
.dxeListBox_DevEx td.dxeMIMR
{
	border-left-width: 0!important;
}

.dxeListBox_DevEx td.dxeCM,
.dxeListBox_DevEx td.dxeHCC,
.dxeListBox_DevEx td.dxeCMR,
.dxeListBox_DevEx td.dxeHCCR
{
	width: 31px;
	box-sizing: border-box;
	-moz-box-sizing: border-box;
	-webkit-box-sizing: border-box;
}
.dxeListBox_DevEx td.dxeIM,
.dxeListBox_DevEx td.dxeIMR
{
	width: 0;
}
.dxeListBox_DevEx td.dxeC
{
	padding-right: 3px!important;
}
.dxeListBox_DevEx td.dxeCR
{
	padding-left: 3px!important;
}
.dxeListBox_DevEx td.dxeC > span,
.dxeListBox_DevEx td.dxeCM > span
{
    margin: 2px 2px 2px 3px;
}
.dxeListBox_DevEx td.dxeCR > span,
.dxeListBox_DevEx td.dxeCMR > span
{
    margin: 2px 3px 2px 2px;
}
.dxeListBox_DevEx td.dxeT
{
	width: 100%;
	padding-left: 0!important;
}

.dxeListBox_DevEx td.dxeTR
{
	width: 100%;
	padding-right: 0!important;
}

.dxeListBox_DevEx td.dxeT,
.dxeListBox_DevEx td.dxeMI
{
	border-left-width: 0!important;
}

.dxeListBox_DevEx td.dxeTR,
.dxeListBox_DevEx td.dxeMIR
{
	border-right-width: 0!important;
}

.dxeListBox_DevEx td.dxeFTM,
.dxeListBox_DevEx td.dxeTM,
.dxeListBox_DevEx td.dxeLTM,
.dxeListBox_DevEx .dxeHFC,
.dxeListBox_DevEx .dxeHC,
.dxeListBox_DevEx .dxeHLC,
.dxeListBox_DevEx td.dxeFTMR,
.dxeListBox_DevEx td.dxeTMR,
.dxeListBox_DevEx td.dxeLTMR,
.dxeListBox_DevEx .dxeHFCR,
.dxeListBox_DevEx .dxeHCR,
.dxeListBox_DevEx .dxeHLCR
{
	overflow: hidden;
}

.dxeListBox_DevEx td.dxeFTM,
.dxeListBox_DevEx td.dxeTM,
.dxeListBox_DevEx .dxeHFC,
.dxeListBox_DevEx .dxeHC
{
	padding-right: 6px!important;
}

.dxeListBox_DevEx td.dxeFTMR,
.dxeListBox_DevEx td.dxeTMR,
.dxeListBox_DevEx .dxeHFCR,
.dxeListBox_DevEx .dxeHCR
{
	padding-left: 6px!important;
}

.dxeListBox_DevEx td.dxeLTM,
.dxeListBox_DevEx td.dxeTM,
.dxeListBox_DevEx .dxeHC,
.dxeListBox_DevEx .dxeHLC
{
	padding-left: 6px!important;
}

.dxeListBox_DevEx td.dxeLTMR,
.dxeListBox_DevEx td.dxeTMR,
.dxeListBox_DevEx .dxeHCR,
.dxeListBox_DevEx .dxeHLCR
{
	padding-right: 6px!important;
}

.dxeListBox_DevEx .dxeFTM,
.dxeListBox_DevEx .dxeTM,
.dxeListBox_DevEx .dxeHFC,
.dxeListBox_DevEx .dxeHC,
.dxeListBox_DevEx .dxeLTM,
.dxeListBox_DevEx .dxeTM,
.dxeListBox_DevEx .dxeHC,
.dxeListBox_DevEx .dxeHLC,
.dxeListBox_DevEx td.dxeIM,
.dxeListBox_DevEx td.dxeFTM,
.dxeListBox_DevEx td.dxeTM,
.dxeListBox_DevEx td.dxeCM,
.dxeListBox_DevEx td.dxeMIM,
.dxeListBox_DevEx .dxeFTMR,
.dxeListBox_DevEx .dxeTMR,
.dxeListBox_DevEx .dxeHFCR,
.dxeListBox_DevEx .dxeHCR,
.dxeListBox_DevEx .dxeLTMR,
.dxeListBox_DevEx .dxeTMR,
.dxeListBox_DevEx .dxeHCR,
.dxeListBox_DevEx .dxeHLCR,
.dxeListBox_DevEx td.dxeIMR,
.dxeListBox_DevEx td.dxeFTMR,
.dxeListBox_DevEx td.dxeTMR,
.dxeListBox_DevEx td.dxeCMR,
.dxeListBox_DevEx td.dxeMIMR
{
	border-top-width: 0;
	border-bottom-width: 0;
}

/*Grid lines*/

.dxeListBox_DevEx td.dxeLTM,
.dxeListBox_DevEx td.dxeTM,
.dxeListBox_DevEx td.dxeMIM
{
	border-left: 1px solid #d9dae0!important;
}
.dxeListBox_DevEx td.dxeLTM 
{
	border-right: 1px solid Transparent!important;
}
.dxeListBox_DevEx td.dxeLTMR,
.dxeListBox_DevEx td.dxeTMR,
.dxeListBox_DevEx td.dxeMIMR
{
	border-right: 1px solid #d9dae0!important;
}

.dxeListBox_DevEx td.dxeIM,
.dxeListBox_DevEx td.dxeFTM,
.dxeListBox_DevEx td.dxeTM,
.dxeListBox_DevEx td.dxeLTM,
.dxeListBox_DevEx td.dxeCM,
.dxeListBox_DevEx td.dxeMIM,
.dxeListBox_DevEx td.dxeIMR,
.dxeListBox_DevEx td.dxeFTMR,
.dxeListBox_DevEx td.dxeTMR,
.dxeListBox_DevEx td.dxeLTMR,
.dxeListBox_DevEx td.dxeCMR,
.dxeListBox_DevEx td.dxeMIMR
{
	border-bottom: 1px solid #d9dae0;
}

.dxeListBoxItemSelected_DevEx     
{
	color: #201f35;
	background: #eff0f2 none;
}
.dxeListBoxItemHover_DevEx        
{
	color: #201f35;
	background: #e2eafd none;
}
.dxeListBoxItemHover_DevEx em,
.dxeListBoxItemSelected_DevEx em
{
	background-image: none;
}

/*Header*/

.dxeListBox_DevEx .dxeHD
{
	background: #f3f3f4 url('/DXR.axd?r=0_751-K2F8m') repeat-x left top;
	border-bottom: 1px solid #abacb9;
}
.dxeHD .dxeListBoxItem_DevEx
{
	color: #201f35;
	border-top-width: 0;
	border-right-width: 1px;
	border-bottom-width: 0;
	border-left-width: 1px;
	padding-top: 3px;
	padding-bottom: 3px;
}

.dxeListBox_DevEx .dxeHC,
.dxeListBox_DevEx .dxeHLC,
.dxeListBox_DevEx td.dxeHMIC
{
	border-left: 1px solid #cacbd3;
}

.dxeListBox_DevEx .dxeHCR,
.dxeListBox_DevEx .dxeHLCR,
.dxeListBox_DevEx td.dxeHMICR
{
	border-right: 1px solid #cacbd3;
	text-align: right;
}

.dxeListBox_DevEx .dxeHIC,
.dxeListBox_DevEx .dxeHFC,
.dxeListBox_DevEx .dxeHCC
{
}

.dxeListBox_DevEx .dxeHICR,
.dxeListBox_DevEx .dxeHFCR,
.dxeListBox_DevEx .dxeHCCR
{
}

.dxeListBox_DevEx .dxeHFC,
.dxeListBox_DevEx .dxeHC,
.dxeListBox_DevEx .dxeHMIC
{
	border-right-width: 0;
}

.dxeListBox_DevEx .dxeHFCR,
.dxeListBox_DevEx .dxeHCR,
.dxeListBox_DevEx .dxeHMICR
{
	border-left-width: 0;
	text-align: right;
}

.dxeListBox_DevEx .dxeHLC
{
	border-right: 1px solid #cacbd3;
}

.dxeListBox_DevEx .dxeHLCR
{
	border-left: 1px solid #cacbd3;
	text-align: right;
}

/* -- Calendar -- */
.dxeCalendar_DevEx
{
    font: 11px Verdana, Geneva, sans-serif;
	font-weight: normal;
	color: #201f35;
	border: 1px solid #9da0aa;
	background-color: White;
	cursor: default;
}
.dxeCalendar_DevEx td.dxMonthGrid
{
	padding: 1px 8px;
}
.dxeCalendar_DevEx td.dxMonthGridWithWeekNumbers
{
	padding: 1px 20px 6px 8px;
}
.dxeCalendar_DevEx td.dxMonthGridWithWeekNumbersRtl
{
	padding: 1px 8px 1px 20px;
}
.dxeCalendarDayHeader_DevEx
{
	padding: 2px 4px 6px;
	border-bottom: 1px solid #d7d8dd;
}
.dxeCalendarWeekNumber_DevEx
{
	font-size: 0.82em;
	text-align: right;
	padding: 3px 8px 2px 4px;
	color: #cccccc;
}
.dxeCalendarDay_DevEx
{
	padding: 2px 5px 3px;
	text-align: center;
}
.dxeCalendarWeekend_DevEx        
{
	color: #c00000;
}
.dxeCalendarOtherMonth_DevEx     
{
	color: #cccccc;
}
.dxeCalendarOutOfRange_DevEx     
{
	color: #cccccc;
}
.dxeCalendarDayDisabled_DevEx {
	background-color: #fcfdfe;
	color: #ecedee!important;
}
.dxeCalendarToday_DevEx         
{
	border: 1px solid #c95c05;
    padding: 1px 4px 2px;
}
.dxeCalendarSelected_DevEx       
{
	color: #201f35;
	background-color: #e2eafd;
}
.dxeDayInRange.dxeCalendarSelected_DevEx
{
    background-color: #f6f9fe;
}
.dxeCalendarHeader_DevEx
{
	border-style: none;
	padding: 4px 4px 12px;
}
.dxeCalendarHeader_DevEx td.dxe
{
	text-align: center;
	cursor: pointer;
}
.dxeCalendarHeader_DevEx .dxeCHS
{
    min-width: 1px;
}
.dxeCalendarFooter_DevEx
{
	background-color: White;
	padding: 11px 0;
}
.dxeCalendarFooter_DevEx .dxeCFS
{
    min-width: 12px;
    *width: 12px;
}
.dxeCalendarFastNav_DevEx
{
	color: #201f35;
	background: White none;
	border-top: 1px solid #9da0aa;
	border-right: 1px solid #9da0aa;
	border-bottom: 0 solid #9da0aa;
	border-left: 1px solid #9da0aa;
	padding: 5px 8px;
	cursor: default;
}
.dxeCalendarFastNavMonthArea_DevEx
{
	padding: 0px 9px;
}
.dxeCalendarFastNavYearArea_DevEx
{
    padding-top: 8px;
}
.dxeCalendarFastNavFooter_DevEx
{
	color: #201f35;
	background: White none;
	padding: 8px 0 17px;
	border-top: 0 solid #d7d8dd;
	border-right: 1px solid #9da0aa;
	border-bottom: 1px solid #9da0aa;
	border-left: 1px solid #9da0aa;
}
.dxeCalendarFastNavFooter_DevEx .dxeCFNFS
{
    min-width: 11px;
    *width: 11px;
}
.dxeCalendarFastNavMonth_DevEx,
.dxeCalendarFastNavYear_DevEx
{
	color: #201f35;
	padding: 3px 5px;
	text-align: center;
	cursor: pointer;
}
.dxeCalendarFastNavYear_DevEx
{
	padding: 3px 5px;
}
.dxeCalendarFastNavMonth_DevEx
{
	padding: 6px;
}

.dxeCalendarFastNavMonthHover_DevEx,
.dxeCalendarFastNavYearHover_DevEx
{
	color: #201f35;
	background: #f3ebfe none;
	border-width: 0;
}
.dxeCalendarFastNavYearHover_DevEx,
.dxeCalendarFastNavYearSelected_DevEx
{
	padding: 3px 5px;
}
.dxeCalendarFastNavMonthHover_DevEx,
.dxeCalendarFastNavMonthSelected_DevEx
{
	padding: 6px;
}
.dxeCalendarFastNavMonthSelected_DevEx,
.dxeCalendarFastNavYearSelected_DevEx
{
	color: #201f35;
	background-color: #e2eafd;
}
.dxeDateEditTimeEditCell_DevEx
{
    padding: 7px 34px 9px;
    width: 100px;
}
.dxeDateEditClockCell_DevEx
{
    padding: 14px 24px 0;
}
.dxeCalendarFooter_DevEx.dxeDETSF
{
    padding-left: 11px;
    padding-right: 11px;
}
.dxeCalendarHeader_DevEx.dxeDETSH
{
    display: none;
}

/* Disabled */
.dxeDisabled_DevEx,
.dxeDisabled_DevEx td.dxe
{
	color: #b1b1b8;
	cursor: default;
}
.dxeEditArea_DevEx.dxeDisabled_DevEx /*Bootstrap correction*/
{
    color: #b1b1b8;
}
a.dxeDisabled_DevEx:hover
{
	color: #b1b1b8;
}
.dxeButtonDisabled_DevEx
{
	color: #b1b1b8;
	cursor: default;
}
/* -- Button -- */
.dxbButton_DevEx
{
	color: #201f35;
	font: 11px Verdana, Geneva, sans-serif;
	border: 1px solid #a9acb5;
	background: #ebedf2 url('/DXR.axd?r=0_730-K2F8m') repeat-x left top;
	padding: 1px;
}
.dxbButtonHover_DevEx
{
	color: #201f35;
	background: #dde6fe url('/DXR.axd?r=0_732-K2F8m') repeat-x left top;
	border: 1px solid #a9acb5;
}
.dxbButtonChecked_DevEx
{
	color: #3c3c3c;
	background: #dbdde2 url('/DXR.axd?r=0_733-K2F8m') repeat-x left top;
	border: 1px solid #9da0aa;
}
.dxbButtonPressed_DevEx
{
	color: #3c3c3c;
	background: #dbdde2 url('/DXR.axd?r=0_733-K2F8m') repeat-x left top;
	border: 1px solid #9da0aa;
}
.dxbButton_DevEx div.dxb
{
	padding: 2px 14px;
	border: 1px dotted transparent;
}
.dxbButton_DevEx div.dxbf
{
	border: 1px dotted black;
}
/* Button Link */
a.dxbButton_DevEx
{
	color: #1b3f91;
	text-decoration: none;
}
a.dxbButton_DevEx:hover
{
	text-decoration: underline;
}
a.dxbButton_DevEx:visited
{
	color: #8684ed;
}
/* Disabled */
.dxbDisabled_DevEx
{
	border-color: #e1e2e5;
	background: #f8f9fa url('/DXR.axd?r=0_731-K2F8m') repeat-x left top;
}
.dxbDisabled_DevEx,
a.dxbButton_DevEx.dxbDisabled_DevEx
{
	color: #babac1;
	cursor: default;
    text-decoration: none;
}
/* -- FilterControl -- */
.dxfcControl_DevEx
{
	font: 11px Verdana, Geneva, sans-serif;
	color: #201f35;
	padding: 0 1em;
}
.dxfcTable_DevEx
{
	border-collapse: separate!important;
}
.dxfcTable_DevEx td.dxfc
{
	padding: 0px 0px 0px 3px;
}
a.dxfcPropertyName_DevEx
{
	white-space: nowrap!important;
	color: Blue!important;
}
a.dxfcGroupType_DevEx
{
	white-space: nowrap!important;
	padding: 0px 3px!important;
	color: Red!important;
}
a.dxfcOperation_DevEx
{
	white-space: nowrap!important;
	color: Green!important;
}
a.dxfcValue_DevEx
{
	white-space: nowrap!important;
	color: Gray!important;
}

.dxeMaskHint_DevEx
{
	font: 11px Verdana, Geneva, sans-serif;
	color: Black;
	background: #ffffe1 none;
	padding: 2px 5px 3px;
	border: 1px solid Black;
}

.dxfcControl_DevEx ul.dxfc-tree,
.dxfcControl_DevEx .dxfc-tree ul
{
    list-style-type: none;
    margin: 0;
    overflow-y: hidden;
    padding: 0;
}

.dxfcControl_DevEx .dxfc-tree
{
    width: 100%;
}

.dxfcControl_DevEx .dxfc-subnd
{
    margin-left: 22px;
}

.dxfcControl_DevEx .dxfc > li > table
{
    border-spacing: 0;
    border-collapse: collapse;
}

.dxfcControl_DevEx .dxfc-elb
{
    float: left;
    height: 21px;
    vertical-align: top;
    width: 26px;
}

.dxfcControl_DevEx .dxfc-clr
{
    clear: both;
    display: block;
    font-size: 0;
    height: 0;
    visibility: hidden;
    width: 0;
}

.dxfcControl_DevEx .dxfc-nd
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

.dxfcControl_DevEx .dxfc-nd > tbody > tr > td > a,
.dxfcControl_DevEx .dxfc-nd > tbody > tr > td > span,
.dxfcControl_DevEx .dxfc-nd > tbody > tr > td > img,
.dxfcControl_DevEx .dxfc-editor
{
    vertical-align: middle;
}

.dxfcControl_DevEx .dxfc-nd > tbody > tr > td > a,
.dxfcControl_DevEx .dxfc-nd > tbody > tr > td > td,
.dxfcControl_DevEx .dxfc-nd > tbody > tr > td > span
{
    padding: 0 0.1ex;
}

.dxfcControl_DevEx .dxfc-nd > tbody > tr > td > a
{
    line-height: 24px;
}

.dxfcControl_DevEx .dxfc-ln
{
    vertical-align: top;
}

.dxfcControl_DevEx .dxfc-memo textarea 
{
	height: 80px;
	overflow: auto;
}

.dxfcControl_DevEx .dxfc-validationSummary
{
	padding: 2px 5px 4px 6px !important;
	list-style-type: none;
	margin: 0;
}

.dxfcControl_DevEx .dxfc-validationSummary li
{
	padding: 2px 0;
}

.dxfcControl_DevEx .dxfc-validationSummary li a
{
	color: red;
	text-decoration: none;
	border-bottom: 1px dashed #f70;
}

.dxfcControl_DevEx .dxfc-validationSummary li a:hover
{
	color: #f70;
}
/* -- ProgressBar -- */
.dxeProgressBar_DevEx
{
	background: #f3f4f5 url('/DXR.axd?r=0_736-K2F8m') repeat-x left top;
	border: 1px solid #b9bac3;
	font: 11px Verdana, Geneva, sans-serif;
	color: #201f35;
    height: 21px;
}
.dxeProgressBar_DevEx .dxePBMainCell,
.dxeProgressBar_DevEx td.dxe
{
	padding: 0;
}
.dxeProgressBarIndicator_DevEx
{
	background: #edd0f4 url('/DXR.axd?r=0_737-K2F8m') repeat-x left top;
}

/* -- DropDownWindow -- */
.dxpcDropDown_DevEx,
.dxeDropDownWindow_DevEx
{
    font: 11px Verdana, Geneva, sans-serif;
}
.dxeDropDownWindow_DevEx
{
	background-color: white;
	border: 1px solid #9da0aa;
}

/*----------------- ColorTable -----------------*/
.dxeColorIndicator_DevEx
{
	border: 1px solid #9da0aa;
	width: 15px;
	height: 15px;
	cursor: pointer;
}
.dxeItemPicker_DevEx
{
	background-color: White;
	border: 1px solid #9da0aa;
}
.dxeColorTable_DevEx td.dx,
.dxeItemPicker_DevEx td.dx
{
	padding: 4px;
}
.dxeColorTableCell_DevEx,
.dxeItemPickerCell_DevEx,
.dxeACICell_DevEx
{
	padding: 3px;
	cursor: pointer;
}
.dxeColorTableCellDiv_DevEx,
.dxeACICellDiv_DevEx
{
	border: 1px solid #808080;
	width: 12px;
	height: 12px;
	font-size: 0;
}
.dxeColorTableCellSelected_DevEx,
.dxeACICellSelected_DevEx
{
	padding: 2px!important;
	background: #e9eaee url('/DXR.axd?r=0_903-K2F8m') repeat-x left top;
	border: 1px solid #9da0aa;
}
.dxeColorTableCellHover_DevEx,
.dxeItemPickerCellHover_DevEx,
.dxeAutomaticColorItemCellHover_DevEx,
.dxeAutomaticColorItem_DevEx:hover > div
{
	padding: 2px!important;
	background: #e3ebff url('/DXR.axd?r=0_906-K2F8m') repeat-x left top;
	border: 1px solid #a6a9b2;
}

/* -- Invalid Style -- */
.dxeInvalid_DevEx
{
}
.dxeInvalid_DevEx .dxeEditArea_DevEx,
.dxeInvalid_DevEx .dxeMemoEditArea_DevEx
{
}

/* -- Focused Style -- */
.dxeFocused_DevEx
{
	border-top: 1px solid #434756;
	border-right: 1px solid #7d808d;
	border-bottom: 1px solid #aaacb9;
	border-left: 1px solid #7d808d;
}

.dxeFocused_DevEx.dxeTrackBar_DevEx
{	
	border: 0px;
}

/* -- Null Text Style -- */
.dxeNullText_DevEx .dxeEditArea_DevEx,
.dxeNullText_DevEx .dxeMemoEditArea_DevEx
{
	color: #b1b1b8;
}

/* -- Captcha -- */
.dxcaControl_DevEx 
{
    font: 11px Verdana, Geneva, sans-serif;
}

.dxcaRefreshButton_DevEx
{
	color: #1b3f91;
	text-decoration: none;
}

.dxcaDisabledRefreshButton_DevEx
{
	color: #b1b1b8;
}

.dxcaRefreshButtonCell_DevEx
{
	padding-left: 2px;
}

.dxcaRefreshButtonText_DevEx
{
}

.dxcaDisabledRefreshButtonText_DevEx
{
}

.dxcaTextBoxCell_DevEx,
.dxcaTextBoxCellNoIndent_DevEx
{
}

.dxcaTextBoxCell_DevEx .dxeErrorCell_DevEx
{
}

.dxcaTextBoxCellNoIndent_DevEx .dxeErrorCell_DevEx
{
	padding-left: 0px;
	padding-top: 4px;
	color: Red;
}

.dxcaTextBoxLabel_DevEx
{
	padding-bottom: 4px;
	display: block;
}

.dxcaLoadingPanel_DevEx
{
	font: 11px Verdana, Geneva, sans-serif;
	color: #201f35;
	background: White none;
	border: 1px solid #9da0aa;
}

.dxcaLoadingPanel_DevEx td.dx
{
	white-space: nowrap;
	text-align: center;
	padding: 7px 10px;
}
.dxcaLoadingPanel_DevEx .dxlp-loadingImage 
{
	margin:0px;
}

.dxpcLite_DevEx .dxHFBPS
{
    width: 6px;
}

.dxeTextBox_DevEx,
.dxeButtonEdit_DevEx,
.dxeIRadioButton_DevEx,
.dxeRadioButtonList_DevEx,
.dxeCheckBoxList_DevEx
{
    cursor: default;
}

/* Removes flicking in iOS Safari*/
.dxeTrackBar_DevEx, 
.dxeIRadioButton_DevEx, 
.dxeButtonEdit_DevEx, 
.dxeTextBox_DevEx, 
.dxeRadioButtonList_DevEx, 
.dxeCheckBoxList_DevEx, 
.dxeMemo_DevEx, 
.dxeListBox_DevEx, 
.dxeCalendar_DevEx, 
.dxeColorTable_DevEx
{
	-webkit-tap-highlight-color: rgba(0,0,0,0);
}

/*B232817*/
.dxIE.dxBrowserVersion-9 .dxeEditArea_DevEx,
.dxIE.dxBrowserVersion-10 .dxeEditArea_DevEx
{
	padding-bottom: 1px;
    margin-bottom: 0px;
}
.dxMacOSMobilePlatform .dxeEditArea_DevEx
{
    padding-bottom: 2px!important;
    margin-bottom: -1px!important;
}

/* ASPxCololrEdit */
.dxcpParametersCellSys .dxcpWebColorInput_DevEx
{
	float: right;
	margin-top: 40px;
}
.dxcpColorParameterMainDiv_DevEx
{
	padding: 0px 0 4px 9px;
	width: 90px;
	text-align: right;
}
.dxeCustomColorButton_DevEx
{
    padding-top: 3px;
    padding-bottom: 3px;
	margin: 3px 7px;
	cursor: pointer;
}
.dxeAutomaticColorItem_DevEx
{
    padding: 4px 4px 0px 4px;
}
.dxeAutomaticColorItem_DevEx > span
{
    margin: 0px 5px;
    line-height: 20px;
}
.dxcpCurrentColor_DevEx, 
.dxcpSavedColor_DevEx
{
	height: 35px;
}
.dxcpCurrentAndSaved_DevEx
{
	width: 65px;
	margin: 34px 0px 0px auto;
	cursor: pointer;
}
.dxeColorTablesMainDiv_DevEx,
.dxeColorSelectorMainDiv_DevEx
{
	background-color: #FFFFFF;
}
.dxeColorSelectorMainDiv_DevEx
{
	padding: 7px;
}
.dxcpColorArea_DevEx,
.dxcpHueAreaImage_DevEx,
.dxcpCurrentAndSaved_DevEx,
.dxeColorTablesMainDiv_DevEx,
.dxeColorSelectorMainDiv_DevEx,
.dxcpParametersCell_DevEx input
{
	border: 1px solid #9da0aa;
}
.dxeButtonsPanelDiv_DevEx
{
	margin-top: 15px;
	text-align: right;
}
.dxeButtonsPanelDiv_DevEx input
{
	min-width: 61px;
	margin-left: 10px;
}

/* -- ASPxTokenBox -- */
input.dxeTokenBoxInput_DevEx[type="text"] {
	display: inline-block;
	float: left;
	outline: none;
	width: 30px;
	padding: 2px 0px 2px 0px;
	margin: 0px 1px 1px 3px;
}
.dxeToken_DevEx {
    display: inline-block;
	float: left;
	min-width: 30px;
	margin: 0px 1px 1px 0px;
}
.dxeTokenText_DevEx, .dxeTokenRemoveButton_DevEx {
	display: block;
	float: left;
}
.dxeTokenText_DevEx {
	overflow: hidden;
	text-overflow: ellipsis;
	margin: 0px 2px 0px 4px;
	padding: 2px 0px 2px 0px;
}
.dxeTokenRemoveButton_DevEx {
	cursor: pointer;
	margin-top: 1px;
}
.dxeToken_DevEx {
	background: #f4f4f4 url('/DXR.axd?r=0_738-K2F8m') repeat-x top;
}
.dxFirefox .dxeButtonEdit_DevEx td.dxictb,
.dxeButtonEdit_DevEx td.dxictb {
    padding: 0;
}
.dxFirefox input.dxeTokenBoxInput_DevEx[type="text"] {
	padding: 1px 0px 1px 0px;
	margin: 0px 1px 1px 1px;
}
.dxFirefox .dxeTokenText_DevEx {
	padding: 1px 0px 1px 0px;
}

/* ASPxPictureEdit */
.dxpePreviewContainer_DevEx
{
    position: relative;
}
.dxpeCommandPanel_DevEx
{
    background-color: #333333;
    background-color: rgba(0, 0, 0, 0.75);
    color: white;
    height: 32px;
    position: absolute;
}
.dxpeBottomCommandPanel_DevEx
{
    width: 100%;
    bottom: 0;
}

.dxpeTopCommandPanel_DevEx
{
    width: 100%;      
    top: 0;    
}
.dxpeCommandPanelDeleteButton_DevEx, 
.dxpeCommandPanelOpenDialogButton_DevEx
{    
    cursor: pointer;
    display: inline-block;
}
.dxpeCommandPanelButtonsWrapper_DevEx
{
    position: absolute;
}
.dxpeCommandPanelButtonsWrapperLeft_DevEx
{
    left: 0;
}
.dxpeCommandPanelButtonsWrapperCenter_DevEx
{
    left: 50%;
    margin-left: -32px;
}
.dxpeCommandPanelButtonsWrapperRight_DevEx
{
    right: 0;
}
.dxpeCommandPanelDeleteButtonHover_DevEx,
.dxpeCommandPanelDeleteButtonPressed_DevEx,
.dxpeCommandPanelOpenDialogButtonHover_DevEx,
.dxpeCommandPanelOpenDialogButtonPressed_DevEx
{
}
.dxpeCommandPanelDeleteButtonDisabled_DevEx,
.dxpeCommandPanelOpenDialogButtonDisabled_DevEx
{
}
.dxpeDropZone_DevEx
{
    background-color: gray;
}
.dxpePlaceHolder_DevEx
{
    background-color: lightgray;
    z-index: -1;
}
.dxpeTextPanelContainer_DevEx
{
    height: 100%;
    font-size: 200%;
    text-align: center;
    width: 100%;
}
.dxpeTextPanel_DevEx
{
    height: 100%;
    position: absolute;
    top: 0;
    width: 100%;
}

/* Editor caption */
.dxeCaptionCell_DevEx
{
    font: 11px Verdana, Geneva, sans-serif;
    color: #201f35;
    white-space: nowrap;
    line-height: 16px;
    height: 100%;
}
.dxeRoot_DevEx
{
}
.dxeCaption_DevEx
{
}
.dxeCaptionCell_DevEx.dxeCaptionVATSys.dxeTextEditCTypeSys
{
    padding-top: 3px;
}
.dxeCaptionCell_DevEx.dxeCaptionVATSys.dxeCheckBoxCTypeSys
{
    padding-top: 3px;
}
.dxeCaptionCell_DevEx.dxeCaptionVATSys.dxeRadioButtonCTypeSys
{
    padding-top: 4px;
}
.dxeCaptionCell_DevEx.dxeCaptionVATSys.dxeCheckBoxListCTypeSys
{
    padding-top: 11px;
}
.dxeCaptionCell_DevEx.dxeCaptionVATSys.dxeRadioButtonListCTypeSys
{
    padding-top: 11px;
}
.dxeCaptionCell_DevEx.dxeCaptionVATSys.dxeListBoxCTypeSys
{
    padding-top: 2px;
}
.dxeCaptionCell_DevEx.dxeCaptionVATSys.dxeTrackBarCTypeSys
{
    padding-top: 2px;
}
.dxeCaptionCell_DevEx.dxeCaptionVATSys.dxeProgressBarCTypeSys
{
    padding-top: 3px;
}
.dxeCaptionCell_DevEx.dxeCaptionVATSys.dxeMemoCTypeSys
{
    padding-top: 3px;
}
.dxeCaptionCell_DevEx.dxeCaptionVATSys.dxeCustomCTypeSys
{
    padding-top: 5px;
    padding-bottom: 5px;
}

.dxFirefox .dxeCaptionCell_DevEx.dxeCaptionVATSys.dxeTextEditCTypeSys,
.dxFirefox .dxeCaptionCell_DevEx.dxeCaptionVATSys.dxeMemoCTypeSys,
.dxFirefox .dxeCaptionCell_DevEx.dxeCaptionVATSys.dxeProgressBarCTypeSys
{
    padding-top: 2px;
}

.dxeRequiredMark_DevEx {
    color: green;
    font-style: normal;
}

.dxeOptionalMark_DevEx {
    color: gray;
    font-style: normal;
}
/*Loading Panel*/
.dxlpLoadingPanel_DevEx,
.dxlpLoadingPanelWithContent_DevEx
{
	font: 11px Verdana, Geneva, sans-serif;
	color: #201f35;
	background-color: White;
	border: 1px solid #9da0aa;
}
.dxlpLoadingPanel_DevEx td.dx,
.dxlpLoadingPanelWithContent_DevEx td.dx
{
	white-space: nowrap;
	text-align: center;
	padding: 7px 10px;
}
.dxlpLoadingPanel_DevEx .dxlp-loadingImage,
.dxcaLoadingPanel_DevEx .dxlp-loadingImage,
.dxlpLoadingPanelWithContent_DevEx .dxlp-loadingImage,
.dxeImage_DevEx.dxe-loadingImage
{
	background-image: url('/DXR.axd?r=0_898-K2F8m');
	height: 32px;
	width: 32px;
}

/* Out of range warning*/
.dxeOutOfRWarn_DevEx {
    font: 11px Verdana, Geneva, sans-serif;
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
.dxeOutOfRWarnRight_DevEx {
    margin-left: 10px;
}
.dxeOutOfRWarnBottom_DevEx {
    margin-top: 10px;
}
