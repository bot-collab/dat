/* TrackBar */
.dxeTrackBar
{
    font: 12px Tahoma, Geneva, sans-serif;
	user-select: none;
	-moz-user-select: -moz-none;
	-khtml-user-select: none;
	-webkit-user-select: none;
	visibility: hidden;
}

.dxeDisabled .dxeTBHSys a,
.dxeDisabled .dxeTBVSys a
{
    cursor: default;
}

.dxeTBBarHighlight
{
	font-size: 0;
}

.dxeTBScale, .dxeTBTrack, .dxeTBBarHighlight
{
	cursor: pointer;
}

.dxeTBScale 
{
	z-index: 1;
	font-size: 0.91em;
}
.dxeTBSecondaryDH, .dxeTBMainDH
{
	z-index: 4;
}

.dxeTrackBar.dxeTBHSys
{
	width: 170px;
	height: 41px;
}
.dxeTrackBar.dxeTBVSys
{
	height: 170px;
	width: 41px;
}
.dxeTrackBar.dxeTBBScaleSys.dxeTBVSys
{
	width: 59px;
}
.dxeTrackBar.dxeTBBScaleSys.dxeTBHSys
{	
	height: 59px;
}

.dxeTBTrack 
{
	z-index: 2;
	position: absolute;
}

.dxeTBHSys .dxeTBTrack
{
	background-image:  url('/DXR.axd?r=1_69-K2F8m');
}
.dxeTBVSys .dxeTBTrack
{
	background-image:  url('/DXR.axd?r=1_70-K2F8m');
}

.dxeTBHSys .dxeTBTrack, .dxeTBHSys .dxeTBBarHighlight
{
	height: 9px;
}
.dxeTBVSys .dxeTBTrack, .dxeTBVSys .dxeTBBarHighlight
{
	width: 9px;
}

.dxeTBHSys .dxeTBMainDH, .dxeTBHSys .dxeTBSecondaryDH
{	
	top: -5px;
	width:13px;
	height:19px;
}
.dxeTBVSys .dxeTBMainDH, .dxeTBVSys .dxeTBSecondaryDH
{
	left: -5px;
	width:19px;
	height:13px;
}

.dxeTBVSys .dxeTBRBScaleSys .dxeTBTrack, .dxeTBVSys .dxeTBTrack
{
	left: 6px;
}
.dxeTBVSys .dxeTBLTScaleSys .dxeTBTrack
{
	right: 6px;
	left: auto;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBTrack
{
	bottom: 6px;
	top: auto;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBTrack, .dxeTBHSys .dxeTBTrack
{
	top: 6px;
}

.dxeTBBarHighlight
{
	left: 0px;
	top: 0px;
	position:absolute;
	z-index: 3;
}

.dxeTBHSys .dxeTBBarHighlight
{
	background-image:  url('/DXR.axd?r=1_59-K2F8m');
}
.dxeTBVSys .dxeTBBarHighlight
{
	background-image:  url('/DXR.axd?r=1_60-K2F8m');
}

.dxeTBRBLabel, .dxeTBLTLabel
{
	text-align: center;
	color: #A8A8A8;
	cursor: default;
}
.dxeTBSmallTickSys .dxeTBRBLabel, .dxeTBSmallTickSys .dxeTBLTLabel,
.dxeTBLargeTickSys .dxeTBRBLabel, .dxeTBLargeTickSys .dxeTBLTLabel 
{	
	position: absolute;
}

.dxeTBHSys .dxeTBRBLabel,.dxeTBHSys .dxeTBLTLabel
{
	width: 100%;
}

.dxeTBIncBtn, .dxeTBDecBtn
{
}

.dxeTBVSys .dxeTBRBLabel, 
.dxeTBVSys .dxeTBLTLabel
{
	padding-top: 2px;
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBRBLabel
{
	margin-left: -4px;
}
.dxeTBVSys .dxeTBRBScaleSys .dxeTBRBLabel, 
.dxeTBVSys .dxeTBBScaleSys .dxeTBLTLabel
{
	right: 0px;
}
.dxeTBVSys .dxeTBLTScaleSys .dxeTBLTLabel, 
.dxeTBVSys .dxeTBBScaleSys .dxeTBRBLabel
{
	left: 0px;
}
.dxeTBHSys .dxeTBRBScaleSys .dxeTBRBLabel, 
.dxeTBHSys .dxeTBBScaleSys .dxeTBLTLabel
{
	bottom: 0px;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBLTLabel, 
.dxeTBHSys .dxeTBBScaleSys .dxeTBRBLabel
{
	top: 0px;
}
.dxeTBItem
{
	color: #A8A8A8;
}

.dxeTBHSys .dxeTBItem .dxeTBRBLabel, 
.dxeTBHSys .dxeTBItem .dxeTBLTLabel 
{
	display: inline-block;
	margin-left: 0px!important;
}
.dxeTBHSys .dxeTBRBScaleSys 
.dxeTBItem .dxeTBRBLabel 
{
	padding-top: 12px;
}
.dxeTBHSys .dxeTBLTScaleSys 
.dxeTBItem .dxeTBLTLabel 
{
	margin-top: 8px;
}
.dxeTBVSys .dxeTBRBScaleSys .dxeTBItem .dxeTBRBLabel 
{
	margin-left: 5px;
}

.dxeTBSelectedItem .dxeTBRBLabel,
.dxeTBSelectedItem .dxeTBLTLabel,
.dxeTBSelectedTick .dxeTBRBLabel, 
.dxeTBSelectedTick .dxeTBLTLabel
{
	color: #C3C3C3;
}

.dxeTBVSys .dxeTBLTScaleSys .dxeTBItem
{
	text-align: left;
}

.dxeTBVSys .dxeTBRBScaleSys .dxeTBItem
{
	text-align: right;
}

.dxeTBVSys .dxeTBBScaleSys .dxeTBItem
{
	text-align: center;
}

.dxeTBHSys .dxeTBItem
{
	background-image:  url('/DXR.axd?r=1_65-K2F8m');
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBItem
{
	background-image:  url('/DXR.axd?r=1_63-K2F8m');
}
.dxeTBVSys .dxeTBItem 
{
	background-image:  url('/DXR.axd?r=1_66-K2F8m');
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBItem
{
	background-image:  url('/DXR.axd?r=1_64-K2F8m');
}

.dxeTBHSys .dxeTBLargeTick
{
	background-image:  url('/DXR.axd?r=1_65-K2F8m');
}
.dxeTBVSys .dxeTBLargeTick
{
	background-image: url('/DXR.axd?r=1_66-K2F8m');
}
.dxeTBHSys .dxeTBSmallTick
{
	background-image: url('/DXR.axd?r=1_67-K2F8m');
}
.dxeTBVSys .dxeTBSmallTick
{
	background-image: url('/DXR.axd?r=1_68-K2F8m');
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBLargeTick
{
	background-image: url('/DXR.axd?r=1_61-K2F8m');
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBLargeTick
{
	background-image: url('/DXR.axd?r=1_62-K2F8m');
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBSmallTick
{
	background-image: url('/DXR.axd?r=1_63-K2F8m');
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBSmallTick
{
	background-image: url('/DXR.axd?r=1_64-K2F8m');
}

.dxeTBVSys .dxeTBIncBtn, .dxeTBVSys .dxeReversedDirectionSys .dxeTBDecBtn
{
	bottom: 0px;
	top: auto;
}
.dxeTBVSys .dxeTBDecBtn, .dxeTBVSys .dxeReversedDirectionSys .dxeTBIncBtn
{
	top: 0px;
	bottom: auto;
}
.dxeTBHSys .dxeTBDecBtn, .dxeTBHSys .dxeReversedDirectionSys .dxeTBIncBtn
{
	left: 0px;
	right: auto;
}
.dxeTBHSys .dxeTBIncBtn, .dxeTBHSys .dxeReversedDirectionSys .dxeTBDecBtn
{
	right: 0px;
	left: auto;
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBDecBtn, 
.dxeTBVSys .dxeTBBScaleSys .dxeTBIncBtn
{
	margin-left: -10px;
	left: 50%;
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBDecBtn,
.dxeTBHSys .dxeTBBScaleSys .dxeTBIncBtn
{
	margin-top: -10px;
	top: 50%;
}
.dxeTBVSys .dxeTBBScaleSys .dxeTBTrack
{ 
	margin-left: -4px;
	left: 50%;
}
.dxeTBHSys .dxeTBBScaleSys .dxeTBTrack
{ 
	margin-top: -4px;
	top: 50%;
}

.dxeTBVSys .dxeTBLTScaleSys .dxeTBDecBtn, 
.dxeTBVSys .dxeTBLTScaleSys .dxeTBIncBtn
{
	right: 0px;
}
.dxeTBHSys .dxeTBLTScaleSys .dxeTBDecBtn, 
.dxeTBHSys .dxeTBLTScaleSys .dxeTBIncBtn
{
	bottom: 0px;
}

.dxeTBValueToolTip,
.dxeHelpText
{
    font: 12px Tahoma, Geneva, sans-serif;
}
.dxeTBValueToolTip,
div.dxeHelpText
{
	padding: 3px 8px 4px 8px;
    display: inline;
    position: absolute;
    background: white;
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
td.dxeHelpText {
    visibility: visible;
    color: #9F9F9F;
}
td.dxeHelpText span {
    font-size: 0.91em;
}
td.dxeHelpText.dxeHHelpTextSys {
    padding: 0 6px;
}
td.dxeHelpText.dxeVHelpTextSys {
    padding: 2px 0;
}

.dxeButtonEditSys .dxic .dxeLoadingDiv
{
	opacity: 1!important;
	filter: alpha(opacity=100)!important;
}

.dxeButtonEditSys .dxic .dxeLoadingPanel
{
    background-color: transparent!important;
    font-size: 0;
}

.dxeButtonEditSys .dxic .dxeLoadingPanel td.dx
{
	padding: 0px!important;
}

.dxeButtonEditSys .dxic .dxeLoadingPanel td.dx > span
{
	display: none;
}

.dxeButtonEditSys .dxic .dxeLoadingPanel td.dx > img
{
	height: 15px;
    width: auto;
    vertical-align: middle;
}

.dxeReadOnly
{
}
.dxeBase
{
	font: 12px Tahoma, Geneva, sans-serif;
}
/* InternalCheckBox */
.dxeIRBFocused
{
    outline: 1px dotted #ffb100;

	*border: 1px dotted #ffb100;
	*margin: 0;
}
.dxeIRadioButton 
{
}
/* -- ErrorFrame -- */
.dxeErrorCell
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: Red;
    border-color: black;
    padding-left: 4px;
	padding-right: 4px;
}
.dxeErrorFrameWithoutError
{
	border: 1px solid Red;
}
.dxeErrorFrameWithoutError .dxeControlsCell,
.dxeErrorFrameWithoutError.dxeControlsCell
{
	padding: 2px;
}

.dxeEditArea
{
	border: 1px solid #A0A0A0;
}
body input.dxeEditArea /*Bootstrap correction*/
{
    color: black;
}
/* -- ValidationSummary -- */
.dxvsValidationSummary
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: Red;
}
.dxvsValidationSummary td.dxvsRC
{
	vertical-align: top;
	padding: 2px 5px 4px 6px;
}
.dxvsValidationSummary .dxvsE
{
}

/* ValidationSummary - Header */

.dxvsValidationSummary table.dxvsHT
{
	width: 100%;
}
.dxvsValidationSummary td.dxvsH
{
	padding: 2px 0;
}

/* ValidationSummary - Hyperlink */

.dxvsValidationSummary a.dxvsHL,
.dxvsValidationSummary a.dxvsHL:visited
{
	color: red;
}
.dxvsValidationSummary a.dxvsHL
{
	text-decoration: none;
	border-bottom: 1px dashed #f70;
}
.dxvsValidationSummary a.dxvsHL:hover
{
	color: #f70;
}

/* ValidationSummary - Table Layout */

.dxvsValidationSummary table.dxvsT
{
}
.dxvsValidationSummary tr.dxvsE
{
}
.dxvsValidationSummary td.dxvsETC
{
	padding: 2px 0;
}

/* ValidationSummary - List Layout */
.dxvsValidationSummary ul.dxvsL
{
}
.dxvsValidationSummary ol.dxvsL
{
}
.dxvsValidationSummary li.dxvsE
{
	padding: 2px 0;
}

/* -- Binary Image -- */
.dxeBinaryImageButtonPanel
{
    height: 36px;
}
.dxeBinaryImageButton
{
    margin: 0 6px;
}

/* -- Buttons -- */
.dxeButtonEditButton,
.dxeCalendarButton,
.dxeSpinIncButton,
.dxeSpinDecButton,
.dxeSpinLargeIncButton,
.dxeSpinLargeDecButton,
.dxeColorEditButton
{
	vertical-align: middle;
	border: 1px solid #7f7f7f;
	cursor: pointer;
	text-align: center;
	white-space: nowrap;
} 
.dxeButtonEditButton
{
    padding: 0px 2px 1px 3px;    
}
.dxeSpinIncButton
{
    padding: 1px 2px 1px 3px;
    border-bottom: 0;    
}
.dxeSpinDecButton
{
    padding: 1px 2px 1px 3px;    
}
.dxeSpinLargeIncButton,
.dxeSpinLargeDecButton
{
	padding: 2px 5px 2px 5px;
}
.dxeButtonEditButton,
.dxeSpinLargeIncButton,
.dxeSpinLargeDecButton
{
	background: #e6e6e6 url('/DXR.axd?r=1_54-K2F8m') repeat-x top;
}
.dxeSpinIncButton
{
	background: #F0F0F0 url('/DXR.axd?r=1_57-K2F8m') repeat-x top;
}
.dxeSpinDecButton
{
	background: #E6E6E6 url('/DXR.axd?r=1_56-K2F8m') repeat-x top;
}
.dxeCalendarButton,
.dxeColorEditButton
{
	background: #e5e5e5 url('/DXR.axd?r=1_52-K2F8m') repeat-x top;
	padding: 3px 11px 4px;
	min-width: 37px;
}

.dxeButtonEditButton.dxeButtonEditClearButton,
.dxeButtonEditButton.dxeButtonEditClearButton:hover
{
    background: none;
    border-width: 0;
    padding-top: 2px;
}

.dxeButtonEditButton img
{
    vertical-align: baseline;
}

/* -- Pressed -- */
.dxeCalendarButtonPressed,
.dxeButtonEditButtonPressed,
.dxeSpinIncButtonPressed,
.dxeSpinDecButtonPressed,
.dxeSpinLargeIncButtonPressed, 
.dxeSpinLargeDecButtonPressed,
.dxeColorEditButton:active
{
	background: #D5D5D5 none;
	border: 1px Solid #7F7F7F;
}
.dxeSpinIncButtonPressed
{
    border-bottom: 0;
}
/* -- Hover -- */
.dxeButtonEditButtonHover,
.dxeSpinIncButtonHover,
.dxeSpinDecButtonHover,
.dxeSpinLargeIncButtonHover,
.dxeSpinLargeDecButtonHover
{
	background: #F2F2F2 url('/DXR.axd?r=1_55-K2F8m') repeat-x top;
	border: 1px Solid #606060;
}
.dxeSpinIncButtonHover
{
    border-bottom: 0;
}
.dxeCalendarButtonHover,
.dxeColorEditButton:hover
{
	background: #F2F2F2 url('/DXR.axd?r=1_53-K2F8m') repeat-x top;
}
.dxeCalendarButtonHover,
.dxeColorEditButton:hover
{
	border: 1px Solid #606060;
}

.dxeButtonEdit
{
	background-color: white;
	border: 1px solid #9F9F9F;
    font: 12px Tahoma, Geneva, sans-serif;
}

.dxeButtonEdit td.dxic 
{
    *padding-left: 2px;
}
*[dir="rtl"].dxeTextBox td.dxic 
{
    *padding-right: 2px;
}

.dxeButtonEdit .dxeEditArea
{
	background-color: white;
}
.dxeButtonEdit .dxeIIC img
{
	padding-left: 3px;
}
.dxeTextBox
{
	background-color: white;
	border: 1px solid #9f9f9f;
    font: 12px Tahoma, Geneva, sans-serif;
}

.dxeTextBox .dxeEditArea
{
	background-color: white;
}
.dxeRadioButtonList, .dxeCheckBoxList
{
	border: 1px Solid #9F9F9F;
}

.dxeCheckBoxList .dxe > table,
.dxeRadioButtonList .dxe > table 
{
    width: 100%;
}

.dxeRadioButtonList,
.dxeCheckBoxList
{
	font: 12px Tahoma, Geneva, sans-serif;
}
.dxeRadioButtonList td.dxe,
.dxeCheckBoxList td.dxe
{
	padding: 7px 5px 6px 11px;
}
.dxeRadioButtonList[dir='rtl'] td.dxe,
.dxeCheckBoxList[dir='rtl'] td.dxe
{
	padding: 7px 11px 6px 5px;
}

/* -- Memo -- */
.dxeMemo
{
	background-color: white;
	border: 1px solid #9f9f9f;
    font: 12px Tahoma, Geneva, sans-serif;
}
.dxeMemoEditArea
{
	background-color: White;
	outline: none;
}


/* -- Hyperlink -- */
.dxeHyperlink
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: #0d45b7;
}
a.dxeHyperlink:hover
{
	color: #5494ea;
}
a.dxeHyperlink:visited
{
	color: #ab59a6;
}

/* -- ListBox -- */
.dxeListBox
{
	background-color: white;
	border: 1px solid #A0A0A0;
	color: Black;
	font: 12px Tahoma, Geneva, sans-serif;
	width: 70px;
	height: 109px;
}
.dxeListBox div.dxlbd
{
	padding-top: 1px;
	padding-bottom: 1px;
	height: 107px;
}
.dxeListBoxItemRow
{
	cursor: default;
}
.dxeListBoxItem
{
	border-left: 1px solid white;
	border-right: 1px solid white;
	padding: 3px 2px 4px 3px;
	white-space: nowrap;
	text-align: left;
}
.dxeListBoxItem em
{
	background: #CFCFCF none repeat 0 0;
	color: #333333;
	font-weight: bold;
	font-style: normal;
}

.dxeListBox td.dxeI,
.dxeListBox td.dxeIM,
.dxeListBox .dxeHIC, 
.dxeListBox td.dxeFTM,
.dxeListBox td.dxeTM,
.dxeListBox td.dxeC,
.dxeListBox td.dxeCM,
.dxeListBox td.dxeHCC,
.dxeListBox td.dxeMI,
.dxeListBox td.dxeMIM
{
	border-right-width: 0!important;
}

.dxeListBox td.dxeIR,
.dxeListBox td.dxeIMR,
.dxeListBox .dxeHICR, 
.dxeListBox td.dxeFTMR,
.dxeListBox td.dxeTMR,
.dxeListBox td.dxeCR,
.dxeListBox td.dxeCMR,
.dxeListBox td.dxeHCCR,
.dxeListBox td.dxeMIR,
.dxeListBox td.dxeMIMR
{
	border-left-width: 0!important;
}

.dxeListBox td.dxeCM,
.dxeListBox td.dxeHCC,
.dxeListBox td.dxeCMR,
.dxeListBox td.dxeHCCR
{
	width: 29px;
    *width: 23px;
    box-sizing: border-box;
    -moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
}

.dxeListBox td.dxeIM,
.dxeListBox td.dxeIMR
{
	width: 0;
}
.dxeListBox td.dxeC > span,
.dxeListBox td.dxeCM > span
{
    margin: 2px 2px 2px 3px;
}
.dxeListBox td.dxeCR > span,
.dxeListBox td.dxeCMR > span
{
    margin: 2px 3px 2px 2px;
}
.dxeListBox td.dxeC
{
	padding-right: 3px!important;
}
.dxeListBox td.dxeCR
{
	padding-left: 3px!important;
}

.dxeListBox td.dxeT
{
	width: 100%;
	padding-left: 0!important;
}

.dxeListBox td.dxeTR
{
	width: 100%;
	padding-right: 0!important;
}


.dxeListBox td.dxeT,
.dxeListBox td.dxeMI
{
	border-left-width: 0!important;
}

.dxeListBox td.dxeTR,
.dxeListBox td.dxeMIR
{
	border-right-width: 0!important;
}


.dxeListBox td.dxeFTM,
.dxeListBox td.dxeTM,
.dxeListBox td.dxeLTM, 
.dxeListBox .dxeHFC,
.dxeListBox .dxeHC,
.dxeListBox .dxeHLC,
.dxeListBox td.dxeFTMR,
.dxeListBox td.dxeTMR,
.dxeListBox td.dxeLTMR, 
.dxeListBox .dxeHFCR,
.dxeListBox .dxeHCR,
.dxeListBox .dxeHLCR
{
	overflow: hidden;
}

.dxeListBox td.dxeFTM,
.dxeListBox td.dxeTM, 
.dxeListBox .dxeHFC,
.dxeListBox .dxeHC
{
	padding-right: 6px!important;
}

.dxeListBox td.dxeFTMR,
.dxeListBox td.dxeTMR, 
.dxeListBox .dxeHFCR,
.dxeListBox .dxeHCR
{
	padding-left: 6px!important;
}


.dxeListBox td.dxeLTM,
.dxeListBox td.dxeTM, 
.dxeListBox .dxeHC,
.dxeListBox .dxeHLC
{
	padding-left: 6px!important;
}

.dxeListBox td.dxeLTMR,
.dxeListBox td.dxeTMR, 
.dxeListBox .dxeHCR,
.dxeListBox .dxeHLCR
{
	padding-right: 6px!important;
}

/*Grid lines*/

.dxeListBox td.dxeLTM,
.dxeListBox td.dxeTM,
.dxeListBox td.dxeMIM
{
	border-left: 1px solid #cfcfcf!important;
}

.dxeListBox td.dxeLTMR,
.dxeListBox td.dxeTMR,
.dxeListBox td.dxeMIMR
{
	border-right: 1px solid #cfcfcf!important;
}

.dxeListBox td.dxeIM,
.dxeListBox td.dxeFTM,
.dxeListBox td.dxeTM,
.dxeListBox td.dxeLTM,
.dxeListBox td.dxeCM,
.dxeListBox td.dxeMIM,
.dxeListBox td.dxeIMR,
.dxeListBox td.dxeFTMR,
.dxeListBox td.dxeTMR,
.dxeListBox td.dxeLTMR,
.dxeListBox td.dxeCMR,
.dxeListBox td.dxeMIMR
{
	border-bottom: 1px solid #cfcfcf;
}

.dxeListBoxItemSelected     
{
	color: White;
	background-color: #A0A0A0;
}
.dxeListBoxItemHover        
{
	background-color: #cfcfcf;
	color: black;
}
.dxeListBoxItemHover em,
.dxeListBoxItemSelected em
{
	background-image: none;
}

/*Header*/

.dxeListBox .dxeHD
{
	background-color: #dcdcdc;
	border-bottom: 1px solid #A0A0A0;
}

.dxeListBox .dxeHC,
.dxeListBox .dxeHLC,
.dxeListBox td.dxeHMIC
{
	border-left: 1px solid #A0A0A0;
}

.dxeListBox .dxeHCR,
.dxeListBox .dxeHLCR,
.dxeListBox td.dxeHMICR
{
	border-right: 1px solid #A0A0A0;
	text-align: right;
}

.dxeListBox .dxeHIC,
.dxeListBox .dxeHFC,
.dxeListBox .dxeHCC
{
	border-left: 1px solid #dcdcdc;
}

.dxeListBox .dxeHICR,
.dxeListBox .dxeHFCR,
.dxeListBox .dxeHCCR
{
	border-right: 1px solid #dcdcdc;
	text-align: right;
}

.dxeListBox .dxeHFC,
.dxeListBox .dxeHC,
.dxeListBox .dxeHMIC
{
	border-right-width: 0;
}

.dxeListBox .dxeHFCR,
.dxeListBox .dxeHCR,
.dxeListBox .dxeHMICR
{
	border-left-width: 0;
	text-align: right;
}

.dxeListBox .dxeHLC
{
	border-right: 1px solid #dcdcdc;
}

.dxeListBox .dxeHLCR
{
	border-left: 1px solid #dcdcdc;
	text-align: right;
}

/* -- Calendar -- */
.dxeCalendar
{
	border: 1px solid #9f9f9f;
	background-color: White;
	color: Black;
    font: 12px Tahoma, Geneva, sans-serif;
	cursor: default;
}
.dxeCalendar td.dxMonthGrid
{
	padding: 8px 20px;
}
.dxeCalendar td.dxMonthGridWithWeekNumbers
{
	padding: 5px 20px 8px 8px;
}
.dxeCalendar td.dxMonthGridWithWeekNumbersRtl
{
	padding: 5px 8px 8px 20px;
}
.dxeCalendarDayHeader
{
	padding: 2px 4px 5px;
	border-bottom: 1px solid #cfcfcf;
}
.dxeCalendarWeekNumber
{
	font-size: 0.75em;
	text-align: right;
	padding: 6px 8px 6px 4px;
	color: #bfbfbf;
}
.dxeCalendarDay
{
	padding: 4px 6px;
	text-align: center;
}
.dxeCalendarWeekend        
{
	color: #c00000;
}
.dxeCalendarOtherMonth     
{
	color: #888;
}
.dxeCalendarOutOfRange
{
	color: #d0d0d0;
}
.dxeCalendarDayDisabled {
	color: #ececec;
	background-color: #fcfcfc;
}
.dxeCalendarSelected       
{
	color: White;
	background-color: #8d8d8d;
}
.dxeDayInRange.dxeCalendarSelected
{
    background-color: #dddddd;
}
.dxeCalendarToday         
{
	padding: 3px 3px 2px;
	border: 1px solid #c00000;
}
.dxeCalendarHeader
{
	background-color: #dcdcdc;
	border-top: 1px solid #c9c9c9;
	border-right: 0 solid #c9c9c9;
	border-bottom: 1px solid #c9c9c9;
	border-left: 0 solid #c9c9c9;
	padding: 4px 7px;
}
.dxeCalendarHeader td.dxe
{
	text-align: center;
	cursor: pointer;
}
.dxeCalendarHeader .dxeCHS
{
    min-width: 10px;
    *width: 10px;
}
.dxeCalendarFooter
{
	background-color: #ededed;
	padding: 8px 0px;
	border-top: 1px solid #d6d6d6;
}
.dxeCalendarFooter .dxeCFS
{
    min-width: 12px;
    *width: 12px;
}
.dxeCalendarFastNav
{
	color: Black;
	background: White none;
	border-top: 1px solid #9f9f9f;
	border-right: 1px solid #9f9f9f;
	border-bottom: 0px solid #9f9f9f;
	border-left: 1px solid #9f9f9f;
	padding: 12px 8px;
}
.dxeCalendarFastNavMonthArea
{
	padding: 0px 9px;
}
.dxeCalendarFastNavYearArea
{
    padding-top: 8px;
}
.dxeCalendarFastNavFooter
{
	color: Black;
	background-color: #ededed;
	padding: 8px 0px;
	border-right: 1px solid #9f9f9f;
	border-bottom: 1px solid #9f9f9f;
	border-left: 1px solid #9f9f9f;
	border-top: 1px solid #d6d6d6;
}
.dxeCalendarFastNavFooter .dxeCFNFS
{
    min-width: 11px;
    *width: 11px;
}
.dxeCalendarFastNavMonth,
.dxeCalendarFastNavYear
{
	color: Black;
	padding: 3px 5px;
	text-align: center;
	cursor: pointer;
}
.dxeCalendarFastNavMonth
{
	padding: 6px;
}
.dxeCalendarFastNavMonthSelected,
.dxeCalendarFastNavYearSelected
{
	color: White;
	background: #8d8d8d none;
}
.dxeCalendarFastNavMonthHover,
.dxeCalendarFastNavYearHover
{
	color: Black;
	background: #e5e5e5 none;
	padding: 2px 4px;
	border: 1px solid #d6d6d6;
}
.dxeCalendarFastNavMonthHover
{
	padding: 5px;
}
.dxeDateEditTimeEditCell
{
    padding: 11px 22px 16px;
    width: 100px;
}
.dxeDateEditClockCell
{
    padding: 16px 17px 0;
}
.dxeCalendarFooter.dxeDETSF
{
    padding-left: 8px;
    padding-right: 8px;
}
/* Disabled */
.dxeDisabled,
.dxeDisabled td.dxe
{
	color: #acacac;
	cursor: default;
}
.dxeEditArea.dxeDisabled, /*Bootstrap correction*/
.dxeDisabled .dxeMemoEditArea /*Bootstrap correction*/
{
    color: #acacac;
}
a.dxeDisabled:hover
{
	color: #acacac;
}
.dxeButtonDisabled
{
	border-color: #c3c3c3;
	color: #808080;
	cursor: default;
}
/* -- Button -- */
.dxbButton
{
	color: #000000;
	font: 12px Tahoma, Geneva, sans-serif;
	border: 1px solid #7F7F7F;
	background: #E0DFDF url('/DXR.axd?r=1_50-K2F8m') repeat-x top;
	padding: 1px;
}
.dxbButtonHover
{
	color: #000000;
	background: #F2F2F2 url('/DXR.axd?r=1_51-K2F8m') repeat-x top;
	border: 1px solid #606060;
}
.dxbButtonChecked
{
	color: #FFFFFF;
	background: #8D8D8D none;
}
.dxbButtonPressed
{
	color: #000000;
	background: #D5D5D5 none;
}
.dxbButton div.dxb
{
    padding: 2px 7px 3px;
	border: 1px dotted transparent;
}
.dxbButton div.dxbf
{
	border: 1px dotted black;
}
/* Link Button */
a.dxbButton
{
    color: #0d45b7;
    text-decoration: underline;
}
a.dxbButton:hover
{
	color: #5494ea;
}
a.dxbButton:visited
{
	color: #ab59a6;
}
/* Disabled */
.dxbDisabled
{
	border-color: #c3c3c3;
}
.dxbDisabled,
a.dxbButton.dxbDisabled
{
	color: #808080;
	cursor: default;
    text-decoration: none;
}
/* -- FilterControl -- */
.dxfcControl
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: Black;
    padding: 0 1em;
}
.dxfcTable
{
	border-collapse: separate!important;
}
.dxfcTable td.dxfc
{
	padding: 0 0 0 3px;
}
a.dxfcPropertyName
{
	white-space: nowrap!important;
	color: Blue!important;
}
a.dxfcGroupType
{
	white-space: nowrap!important;
	padding: 0 3px!important;
	color: Red!important;
}
a.dxfcOperation
{
	white-space: nowrap!important;
	color: Green!important;
}
a.dxfcValue
{
	white-space: nowrap!important;
	color: Gray!important;
}
.dxeMaskHint
{
	background: #ffffe1 none;
	border: 1px solid black;
	padding: 2px 5px 3px;
	color: Black;
	font: 12px Tahoma, Geneva, sans-serif;
}
.dxfcControl ul.dxfc-tree,
.dxfcControl .dxfc-tree ul
{
    list-style-type: none;
    margin: 0;
    overflow-y: hidden;
    padding: 0;
}

.dxfcControl .dxfc-tree
{
    width: 100%;
}

.dxfcControl .dxfc-subnd
{
    margin-left: 22px;
}

.dxfcControl .dxfc > li > table
{
    border-spacing: 0;
    border-collapse: collapse;
}

.dxfcControl .dxfc-elb
{
    background: url('/DXR.axd?r=1_71-K2F8m') no-repeat;
    float: left;
    height: 21px;
    vertical-align: top;
    width: 26px;
    margin-right: 0.3em;
}

.dxfcControl .dxfc-clr
{
    clear: both;
    display: block;
    font-size: 0;
    height: 0;
    visibility: hidden;
    width: 0;
}

.dxfcControl .dxfc-nd
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

.dxfcControl .dxfc-nd > tbody > tr > td > a,
.dxfcControl .dxfc-nd > tbody > tr > td > span,
.dxfcControl .dxfc-nd > tbody > tr > td > img,
.dxfcControl .dxfc-editor
{
    vertical-align: middle;
}

.dxfcControl .dxfc-nd > tbody > tr > td > a,
.dxfcControl .dxfc-nd > tbody > tr > td > td,
.dxfcControl .dxfc-nd > tbody > tr > td > span
{
    padding: 0 0.1ex;
}

.dxfcControl .dxfc-nd > tbody > tr > td > a
{
    line-height: 24px;
}

.dxfcControl .dxfc-ln
{
    background: url('/DXR.axd?r=1_72-K2F8m') repeat-y;
    vertical-align: top;
}

.dxfcControl .dxfc-memo textarea 
{
	height: 80px;
	overflow: auto;
}

.dxfcControl .dxfc-validationSummary
{
	padding: 2px 5px 4px 6px !important;
	list-style-type: none;
	margin: 0;
}

.dxfcControl .dxfc-validationSummary li
{
	padding: 2px 0;
}

.dxfcControl .dxfc-validationSummary li a
{
	color: red;
	text-decoration: none;
	border-bottom: 1px dashed #f70;
}

.dxfcControl .dxfc-validationSummary li a:hover
{
	color: #f70;
}

/* -- ProgressBar -- */
.dxeProgressBar
{
	border: 1px Solid #696969;
	background-color: #FFFFFF;
	font: 12px Tahoma, Geneva, sans-serif;
	color: Black;
    height: 21px;
}
.dxeProgressBar .dxePBMainCell,
.dxeProgressBar td.dxe
{
	padding: 0;
}
.dxeProgressBarIndicator
{
	background-color: #E0DFDF;
}

/* -- DropDownWindow -- */
.dxpcDropDown,
.dxeDropDownWindow
{
    font: 12px Tahoma, Geneva, sans-serif;
}
.dxeDropDownWindow
{
	background-color: white;
	border: 1px solid #9F9F9F;
}

/*----------------- ColorTable -----------------*/
.dxeColorIndicator
{
	border: 1px solid #9F9F9F;
	width: 15px;
	height: 15px;
	cursor: pointer;
}
.dxeItemPicker
{
	background-color: #ffffff;
	border: 1px solid #9F9F9F;
}
.dxeColorTable td.dx,
.dxeItemPicker td.dx
{
	padding: 4px;
}
.dxeColorTableCell,
.dxeItemPickerCell,
.dxeACICell
{
	padding: 3px;
	cursor: pointer;
}
.dxeColorTableCellDiv,
.dxeACICellDiv
{
	border: 1px solid #808080;
	width: 12px;
	height: 12px;
	font-size: 0;
}
.dxeColorTableCellSelected,
.dxeACICellSelected
{
	padding: 2px!important;
	background-color: #CBCBCB;
	border: 1px solid #888888;
}
.dxeColorTableCellHover,
.dxeItemPickerCellHover,
.dxeAutomaticColorItemCellHover,
.dxeAutomaticColorItem:hover > div
{
	padding: 2px!important;
	background-color: #F2F2F2;
	border: 1px solid #888888;
}

/* -- Invalid Style -- */
.dxeInvalid
{
}
.dxeInvalid .dxeEditArea,
.dxeInvalid .dxeMemoEditArea
{
}

/* -- Focused Style -- */
.dxeFocused
{
	border: 1px solid #3d3d3d;
}
.dxeFocused.dxeTrackBar
{
	border: 0px;
}

/* -- Null Text Style -- */
.dxeNullText .dxeEditArea,
.dxeNullText .dxeMemoEditArea
{
	color: #818181;
}

/* -- Captcha -- */
.dxcaControl 
{
	font: 12px Tahoma, Geneva, sans-serif;
}

.dxcaRefreshButton
{
	text-decoration: none;
	color: #1e3695;
}

.dxcaDisabledRefreshButton
{
	color: #acacac;
}

.dxcaRefreshButtonCell
{
	padding-left: 4px;
}

.dxcaRefreshButtonText
{
}

.dxcaDisabledRefreshButtonText
{
}

.dxcaTextBoxCell,
.dxcaTextBoxCellNoIndent
{
}

.dxcaTextBoxCell .dxeErrorCell
{
}

.dxcaTextBoxCellNoIndent .dxeErrorCell
{
	padding-left: 0px;
	padding-top: 4px;
	color: Red;
}

.dxcaTextBoxLabel
{
	padding-bottom: 4px;
	display: block;
}

.dxcaLoadingPanel
{
	font: 12px Tahoma, Geneva, sans-serif;
	color: #303030;
}

.dxcaLoadingPanel td.dx
{
	white-space: nowrap;
	text-align: center;
	padding: 12px;
}
.dxeBinImgContentContainer .dxe-loadingImage,
.dxeImage.dxe-loadingImage,
.dxcaLoadingPanel .dxlp-loadingImage
{
	background-image: url('/DXR.axd?r=1_97-K2F8m');
	height: 16px;
	width: 16px;
}
.dxpcLite .dxHFBPS
{
    width: 6px;
}

.dxeTextBox,
.dxeButtonEdit,
.dxeIRadioButton,
.dxeRadioButtonList,
.dxeCheckBoxList
{
    cursor: default;
}

/* Removes flicking in iOS Safari*/
.dxeTrackBar, 
.dxeIRadioButton, 
.dxeButtonEdit, 
.dxeTextBox, 
.dxeRadioButtonList, 
.dxeCheckBoxList, 
.dxeMemo, 
.dxeListBox, 
.dxeCalendar, 
.dxeColorTable
{
	-webkit-tap-highlight-color: rgba(0,0,0,0);
}

/* -- ASPxTokenBox -- */
input.dxeTokenBoxInput[type="text"] {
	display: inline-block;
	float: left;
	width: 10px;
	outline: none;
	margin: 1px;
	padding: 1px;
}
.dxeToken {
    border: 1px solid #b9b9b9;
    display: inline-block;
	float: left;
	min-width: 30px;
	margin-right: 1px;
	margin-bottom: 1px;
}
.dxeTokenText, .dxeTokenRemoveButton {
	display: block;
	float: left;
}
.dxeTokenText {
	overflow: hidden;
	text-overflow: ellipsis;
	margin-left: 4px;
}
.dxeTokenRemoveButton {
	cursor: pointer;
}
.dxeToken {
	background: #ececec url('/DXR.axd?r=1_58-K2F8m') repeat-x top;
}
.dxFirefox input.dxeTokenBoxInput[type="text"]
{
	padding: 0;
	margin: 1px;
}
.dxFirefox .dxeTokenText {
	margin-top: -1px;
	margin-bottom: -1px;
}

/* ASPxCololrEdit */
.dxcpParametersCellSys .dxcpWebColorInput
{
	float: right;
	margin-top: 40px;
}
.dxcpColorParameterMainDiv
{
	padding: 0px 0 4px 9px;
	width: 90px;
	text-align: right;
}
.dxeCustomColorButton
{
    padding-top: 2px;
    padding-bottom: 2px;
	margin: 3px 7px;
	cursor: pointer;
}
.dxeAutomaticColorItem
{
	padding: 4px 4px 0px 4px;
}
.dxeAutomaticColorItem > span
{
    margin: 0px 5px;
    line-height: 20px;
}
.dxcpCurrentColor, .dxcpSavedColor
{
	height: 35px;
}
.dxcpCurrentAndSaved
{
	width: 65px;
	margin: 34px 0px 0px auto;
	cursor: pointer;
}
.dxeColorTablesMainDiv,
.dxeColorSelectorMainDiv
{
	background-color: #FFFFFF;
}
.dxeColorSelectorMainDiv
{
	padding: 7px;
}
.dxcpColorArea,
.dxcpHueAreaImage,
.dxcpCurrentAndSaved,
.dxeColorTablesMainDiv,
.dxeColorSelectorMainDiv,
.dxcpParametersCell input
{
	border: 1px solid #9F9F9F;
}
.dxeButtonsPanelDiv
{
	margin-top: 15px;
	text-align: right;
}
.dxeButtonsPanelDiv input
{
    min-width: 60px;
	margin-left: 10px;
}

/*Editor Caption*/
.dxeCaptionCell
{
    font: 12px Tahoma, Geneva, sans-serif;
    white-space: nowrap;
    line-height: 16px;
    height: 100%;
}
.dxeRoot
{
}
.dxeCaption
{
}

.dxeCaptionCell.dxeCaptionVATSys.dxeTextEditCTypeSys
{
     padding-top: 3px;
}
.dxeCaptionCell.dxeCaptionVATSys.dxeCheckBoxCTypeSys
{ 
    padding-top: 3px;
}
.dxeCaptionCell.dxeCaptionVATSys.dxeRadioButtonCTypeSys
{ 
    padding-top: 4px;
}
.dxeCaptionCell.dxeCaptionVATSys.dxeCheckBoxListCTypeSys
{
    padding-top: 11px;
}
.dxeCaptionCell.dxeCaptionVATSys.dxeRadioButtonListCTypeSys
{
    padding-top: 11px;
}
.dxeCaptionCell.dxeCaptionVATSys.dxeListBoxCTypeSys
{
    padding-top: 4px;
}
.dxeCaptionCell.dxeCaptionVATSys.dxeTrackBarCTypeSys
{
    padding-top: 2px;
}
.dxeCaptionCell.dxeCaptionVATSys.dxeProgressBarCTypeSys
{
    padding-top: 2px;
}
.dxeCaptionCell.dxeCaptionVATSys.dxeMemoCTypeSys
{
    padding-top: 3px;
}
.dxeCaptionCell.dxeCaptionVATSys.dxeCustomCTypeSys
{
    padding-top: 5px;
    padding-bottom: 5px;
}

/* IE 7 */
.dxeCaptionCell.dxeCaptionVATSys.dxeProgressBarCTypeSys
{
    *padding-top: 7px;
}
.dxeCaptionCell.dxeCaptionVATSys.dxeMemoCTypeSys
{
    *padding-top: 2px;
}

/*Firefox*/
.dxFirefox .dxeCaptionCell.dxeCaptionVATSys.dxeListBoxCTypeSys
{
    padding-top: 5px;
}
.dxFirefox .dxeCaptionCell.dxeCaptionVATSys.dxeProgressBarCTypeSys
{
    padding-top: 3px;
}

/*Chrome*/
.dxWebKitFamily .dxeCaptionCell.dxeCaptionVATSys.dxeListBoxCTypeSys
{
    padding-top: 5px;
}

/* Safari */
.dxeCaptionCellSafariSys.dxeCaptionCell.dxeCaptionVATSys.dxeListBoxCTypeSys
{
    padding-top: 4px;
}

.dxeRequiredMark {
    color: green;
    font-style: normal;
}

.dxeOptionalMark {
    color: gray;
    font-style: normal;
}
/* LoadingPanel */
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

/* Out of range warning*/
.dxeOutOfRWarn {
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
.dxeOutOfRWarnRight {
    margin-left: 10px;
}
.dxeOutOfRWarnBottom {
    margin-top: 10px;
}
