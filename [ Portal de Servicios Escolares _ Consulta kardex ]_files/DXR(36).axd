(function() {
var ASPxClientGridBase = ASPx.CreateClass(ASPxClientControl, {
 MainTableID: "DXMainTable",
 FooterTableID: "DXFooterTable",
 CustomizationWindowSuffix: "_custwindow",
 EditingRowID: "_DXEditingRow",
 EditingErrorItemID: "DXEditingErrorItem",
 BatchEditCellErrorTableID: "DXCErrorTable",
 EmptyHeaderSuffix: "_emptyheader", 
 PagerBottomID: "DXPagerBottom",
 PagerTopID: "DXPagerTop",
 SearchEditorID: "DXSE",
 EllipsisClassName: "dx-ellipsis",
 HeaderFilterButtonClassName: "dxgv__hfb",
 CommandColumnItemClassName: "dxgv__cci",
 ContextMenuItemImageMask: "dxGridView_gvCM",
 DetailGridSuffix: "dxdt",
 ContextMenuItems: {
  FullExpand: "FullExpand",
  FullCollapse: "FullCollapse",
  SortAscending: "SortAscending",
  SortDescending: "SortDescending",
  ClearSorting: "ClearSorting",
  ShowFilterBuilder: "ShowFilterEditor",
  ShowFilterRow: "ShowFilterRow",
  ClearFilter: "ClearFilter",
  ShowFilterRowMenu: "ShowFilterRowMenu",
  GroupByColumn: "GroupByColumn",
  UngroupColumn: "UngroupColumn",
  ClearGrouping: "ClearGrouping",
  ShowGroupPanel: "ShowGroupPanel",
  ShowSearchPanel: "ShowSearchPanel",
  ShowColumn: "ShowColumn",
  HideColumn: "HideColumn",
  ShowCustomizationWindow: "ShowCustomizationWindow",
  ShowFooter: "ShowFooter",
  ExpandRow: "ExpandRow",
  CollapseRow: "CollapseRow",
  ExpandDetailRow: "ExpandDetailRow",
  CollapseDetailRow: "CollapseDetailRow",
  NewRow: "NewRow",
  EditRow: "EditRow",
  DeleteRow: "DeleteRow",
  Refresh: "Refresh",
  SummarySum: "SummarySum",
  SummaryMin: "SummaryMin",
  SummaryMax: "SummaryMax",
  SummaryAverage: "SummaryAverage",
  SummaryCount: "SummaryCount",
  SummaryNone: "SummaryNone",
  CustomItem: "CustomItem"
 },
 constructor: function(name){
  this.constructor.prototype.constructor.call(this, name);
  this.callBacksEnabled = true;
  this.custwindowLeft = null;
  this.custwindowTop = null;
  this.custwindowVisible = null;
  this.activeElement = null;
  this.filterKeyPressInputValue = "";
  this.userChangedSelection = false;
  this.lockFilter = true;
  this.confirmDelete = "";
  this.filterKeyPressTimerId = -1;
  this.filterRowMenuColumnIndex = -1;
  this.editorIDList = [ ];
  this.keys = [ ];
  this.lastMultiSelectIndex = -1;
  this.hasFooterRowTemplate = false;
  this.mainTableClickData = {
   processing: false,
   focusChanged: false,
   selectionChanged: false
  };
  this.afterCallbackRequired = false;
  this.headerFilterPopupDimensions = { };
  this.enableHeaderFilterCaching = true;
  this.postbackRequestCount = 0;
  this.supportGestures = true;
  this.checkBoxImageProperties = null;
  this.internalCheckBoxCollection = null;
  this.sizingConfig.adjustControl = true;
  this.lookupBehavior = false;
  this.clickedMenuItem = null;
  this.EmptyElementIndex = -1;
  this.batchEditApi = this.CreateBatchEditApi();
  this.CustomButtonClick = new ASPxClientEvent();
  this.SelectionChanged = new ASPxClientEvent();
  this.ColumnSorting = new ASPxClientEvent();
  this.CustomizationWindowCloseUp = new ASPxClientEvent();
  this.InternalCheckBoxClick = new ASPxClientEvent();
  this.BatchEditStartEditing = new ASPxClientEvent();
  this.BatchEditEndEditing = new ASPxClientEvent();
  this.BatchEditConfirmShowing = new ASPxClientEvent();
  this.BatchEditTemplateCellFocused = new ASPxClientEvent();
  this.funcCallbacks = [ ];
  this.pendingCommands = [ ];
  this.pageRowCount = 0;
  this.pageRowSize = 0;
  this.pageIndex = 0;
  this.pageCount = 1;
  this.allowFocusedRow = false;
  this.allowSelectByItemClick = false;
  this.allowSelectSingleRowOnly = false;
  this.allowMultiColumnAutoFilter = false,
  this.focusedRowIndex = -1;
  this.selectedWithoutPageRowCount = 0;
  this.selectAllSettings = [ ];
  this.selectAllBtnStateWithoutPage = null;
  this.visibleStartIndex = 0;
  this.columns = [ ];
  this.columnResizeMode = ASPx.ColumnResizeMode.None;
  this.fixedColumnCount = 0;
  this.horzScroll = ASPx.ScrollBarMode.Hidden;
  this.vertScroll = ASPx.ScrollBarMode.Hidden;
  this.scrollToRowIndex = -1;
  this.useEndlessPaging = false;
  this.allowBatchEditing = false;
  this.batchEditClientState = { };
  this.resetScrollTop = false;
  this.callbackOnFocusedRowChanged = false;
  this.callbackOnSelectionChanged = false;
  this.autoFilterDelay = 1200;
  this.searchFilterDelay = 1200;
  this.allowSearchFilterTimer = true;
  this.editState = 0;
  this.kbdHelper = null;
  this.enableKeyboard = false;
  this.keyboardLock = false;
  this.accessKey = null;
  this.customKbdHelperName = null;
  this.endlessPagingHelper = null;
  this.icbFocusedStyle = null;
  this.pendingEvents = [ ];
  this.customSearchPanelEditorID = null;
  this.searchPanelFilter = null;
  this.isDetailGrid = null;
  this.rowHotTrackStyle = null;
  this.filterEditorState = [];
  this.sourceContextMenuRow = null;
  this.activeContextMenu = null;
  this.contextMenuActivating = false;
 },
 HasHorzScroll: function() { return this.horzScroll != ASPx.ScrollBarMode.Hidden; },
 HasVertScroll: function() { return this.vertScroll != ASPx.ScrollBarMode.Hidden; },
 HasScrolling: function() { return this.HasHorzScroll() || this.HasVertScroll(); },
 AllowResizing: function() { return this.columnResizeMode != ASPx.ColumnResizeMode.None; },
 GetRootTable: function() { return ASPx.GetElementById(this.name); },
 GetGridTD: function() { 
  var table = this.GetRootTable();
  if(!table) return null;
  return table.rows[0].cells[0];
 },
 GetArrowDragDownImage: function() { return this.GetChildElement("IADD"); },
 GetArrowDragUpImage: function() { return this.GetChildElement("IADU"); },
 GetArrowDragFieldImage: function() { return this.GetChildElement("IDHF"); },
 GetEndlessPagingUpdatableContainer: function() { return this.GetChildElement("DXEPUC"); },
 GetEndlessPagingLPContainer: function() { return this.GetChildElement("DXEPLPC"); },
 GetBatchEditorsContainer: function() { return this.GetChildElement("DXBEsC"); },
 GetBatchEditorContainer: function(columnIndex) { return this.GetChildElement("DXBEC" + columnIndex); },
 GetBatchEditCellErrorTable: function() { return this.GetChildElement(this.BatchEditCellErrorTableID); },
 GetLoadingPanelDiv: function() {  return this.GetChildElement("LPD"); },
 GetFixedColumnsDiv: function() {  return this.GetChildElement(this.FixedColumnsDivID); },
 GettItem: function(visibleIndex) { return null; },
 GetDataItemIDPrefix: function() { },
 GetEmptyDataItemIDPostfix: function() { },
 GetEmptyDataItem: function() { return this.GetChildElement(this.GetEmptyDataItemIDPostfix()); },
 GetDataRowSelBtn: function(index) { return this.GetChildElement("DXSelBtn" + index); },
 GetSelectAllBtn: function(index) { return this.GetChildElement("DXSelAllBtn" + index); },
 GetMainTable: function() { return this.GetChildElement(this.MainTableID); },
 GetLoadingPanelContainer: function() { return this.GetChildElement("DXLPContainer"); },
 GetGroupPanel: function() { return this.GetChildElement("grouppanel"); },
 GetHeader: function(columnIndex, inGroupPanel) { 
  var id = "col" + columnIndex;
  if(inGroupPanel)
   id = "group" + id;
  return this.GetChildElement(id); 
 },
 GetHeaderRow: function(index) {
  return ASPx.GetElementById(this.name + this.HeaderRowID + index);
 },
 GetEditingRow: function(obj) { return ASPx.GetElementById((obj ? obj.name : this.name) + this.EditingRowID); },
 GetEditingErrorItem: function(obj) { return ASPx.GetElementById((obj ? obj.name : this.name) + "_" + this.EditingErrorItemID); },
 GetEditFormTable: function() { return ASPx.GetElementById(this.name + "_DXEFT"); },
 GetEditFormTableCell: function() { return ASPx.GetElementById(this.name + "_DXEFC"); },
 GetCustomizationWindow: function() { return ASPx.GetControlCollection().Get(this.name + this.CustomizationWindowSuffix); },
 GetParentRowsWindow: function() { return ASPx.GetControlCollection().Get(this.name + "_DXparentrowswindow"); },
 GetEditorPrefix: function() { return "DXEditor"; },
 GetPopupEditForm: function() { return ASPx.GetControlCollection().Get(this.name  + "_DXPEForm"); },
 GetFilterRowMenu: function() { return ASPx.GetControlCollection().Get(this.name + "_DXFilterRowMenu"); },
 GetFilterControlPopup: function() { return ASPx.GetControlCollection().Get(this.name + "_DXPFCForm"); },
 GetFilterControl: function() { return ASPx.GetControlCollection().Get(this.name +  "_DXPFCForm_DXPFC"); }, 
 GetHeaderFilterPopup: function() { return ASPx.GetControlCollection().Get(this.name + "_DXHFP"); },
 GetHeaderFilterHelper:function(){
  if(!this.headerFilterHelper)
   this.headerFilterHelper = new ASPxClientGridHeaderFilterHelper(this);
  return this.headerFilterHelper;
 },
 IsEmptyHeaderID: function(id) { return false; },
 IsDataItem: function(visibleIndex) { return !!this.GetItem(visibleIndex); },
 GetGroupPanelContextMenu: function() { return ASPx.GetControlCollection().Get(this.name + "_DXContextMenu_GroupPanel"); },
 GetColumnContextMenu: function() { return ASPx.GetControlCollection().Get(this.name + "_DXContextMenu_Columns"); },
 GetRowContextMenu: function() { return ASPx.GetControlCollection().Get(this.name + "_DXContextMenu_Rows"); },
 GetFooterContextMenu: function() { return ASPx.GetControlCollection().Get(this.name + "_DXContextMenu_Footer"); },
 GetSearchEditor: function() { 
  var editor = this.GetCustomSearchPanelEditor() || this.GetGridSearchEditor();
  if(editor && editor.GetMainElement())
   return editor;
  return null;
 },
 GetGridSearchEditor: function() { return ASPx.GetControlCollection().Get(this.name + "_" + this.SearchEditorID); },
 GetCustomSearchPanelEditor: function() { return ASPx.GetControlCollection().Get(this.customSearchPanelEditorID); },
 GetEditorByColumnIndex: function(colIndex) {
  var list = this._getEditors();
  for(var i = 0; i < list.length; i++) {
   if(this.tryGetNumberFromEndOfString(list[i].name).value === colIndex)
    return list[i];
  }
  return null;
 },
 CreateBatchEditApi: function() { },
 Initialize: function() {
  this.constructor.prototype.Initialize.call(this);
  this.EnsureRowKeys();
  this._setFocusedItemInputValue();
  this.AddSelectStartHandler();
  this.EnsureRowHotTrackItems();
  if(this.checkBoxImageProperties){
   this.CreateInternalCheckBoxCollection();
   this.UpdateSelectAllCheckboxesState();
  }
  this.CheckPendingEvents();
  this.InitializeHeaderFilterPopup();
  this.CheckEndlessPagingLoadNextPage();
  var batchEditHelper = this.GetBatchEditHelper();
  if(batchEditHelper)
   batchEditHelper.Init();
  this.PrepareCommandButtons();
  this.EnsureSearchEditor();
  window.setTimeout(function() { 
   this.SaveAutoFilterColumnEditorState(); 
   this.lockFilter = false;
  }.aspxBind(this), 0);
  window.setTimeout(function() { this.EnsureVisibleRowFromServer(); }.aspxBind(this), 0);
  this.AssignEllipsisToolTips();
 },
 AttachEventToEditor: function(columnIndex, eventName, handler) {
  var editor = this.GetEditorByColumnIndex(columnIndex);
  if(!ASPx.Ident.IsASPxClientEdit(editor))
   return;
  var attachKeyDownToInput = eventName === "KeyDown" && this.IsCheckEditor(editor);
  if(!editor[eventName] && !attachKeyDownToInput)
   return;
  var duplicateAttachLocker = "dxgv" + eventName + "Assigned";
  if(editor[duplicateAttachLocker]) 
   return;
  if(attachKeyDownToInput)
   ASPx.Evt.AttachEventToElement(editor.GetFocusableInputElement(), "keydown", function(e) { handler(editor, { htmlEvent: e }); });
  else
   editor[eventName].AddHandler(handler);
  editor.dxgvColumnIndex = columnIndex;
  editor[duplicateAttachLocker] = true;
 },
 IsCheckEditor: function(editor) {
  return ASPx.Ident.IsASPxClientCheckEdit && ASPx.Ident.IsASPxClientCheckEdit(editor);
 },
 IsStaticBinaryImageEditor: function(editor) {
  return ASPx.Ident.IsStaticASPxClientBinaryImage && ASPx.Ident.IsStaticASPxClientBinaryImage(editor);
 },
 IsDetailGrid: function() { 
  if(this.isDetailGrid !== null)
   return this.isDetailGrid;
  var regTest = new RegExp(this.DetailGridSuffix + "[0-9]");
  this.isDetailGrid = regTest.test(this.name);
  if(this.isDetailGrid)
   return true;
  var mainElement = this.GetMainElement();
  var parent = mainElement.parentNode;
  while(parent && parent.tagName !== "BODY") {
   this.isDetailGrid = regTest.test(parent.id);
   if(this.isDetailGrid) return true;
   parent = parent.parentNode;
  }
  return false;
 },
 PrepareCommandButtons: function(){
  if(!this.cButtonIDs || this.cButtonIDs.length == 0) return;
  for(var i = 0; i < this.cButtonIDs.length; i++){
   var name = this.cButtonIDs[i];
   if(!ASPx.GetElementById(name)) continue;
   var button = new ASPxClientButton(name);
   button.cpGVName = this.name;
   button.useSubmitBehavior = false;
   button.causesValidation = false;
   button.isNative = !!eval(ASPx.Attr.GetAttribute(button.GetMainElement(), "data-isNative"));
   button.encodeHtml = !!eval(ASPx.Attr.GetAttribute(button.GetMainElement(), "data-encodeHtml"));
   button.enabled = !ASPx.ElementContainsCssClass(button.GetMainElement(), "dxbDisabled");
   button.Click.AddHandler(this.OnCommandButtonClick.aspxBind(this));
   button.InlineInitialize();
  }
  delete this.cButtonIDs;
 },
 OnCommandButtonClick: function(s, e){
  var mainElement = s.GetMainElement();
  if(!s.gvClickArgs)
   s.gvClickArgs = eval(ASPx.Attr.GetAttribute(mainElement, "data-args"));
  if(s.gvClickArgs && s.gvClickArgs.length > 1)
   this.ScheduleUserCommand(s.gvClickArgs[0], s.gvClickArgs[1], mainElement);
 },
 CheckEndlessPagingLoadNextPage: function() {
  window.setTimeout(function() {
   var scrollHelper = this.GetScrollHelper();
   if(this.useEndlessPaging && scrollHelper)
    scrollHelper.CheckEndlessPagingLoadNextPage();
  }.aspxBind(this), 0);
 },
 EnsureRowKeys: function() {
  if(ASPx.IsExists(this.stateObject.keys))
   this.keys = this.stateObject.keys;
  if(!this.keys)
   this.keys = [ ];
 }, 
 InitializeHeaderFilterPopup: function() {
  window.setTimeout(function() { this.InitializeHeaderFilterPopupCore(); }.aspxBind(this), 0);
 },
 InitializeHeaderFilterPopupCore: function() {
  var popup = this.GetHeaderFilterPopup();
  if(!popup)
   return;
  popup.PopUp.AddHandler(function() { this.OnPopUpHeaderFilterWindow(); }.aspxBind(this));
  popup.CloseUp.AddHandler(function(s) { 
   if(!this.UseHFContentCaching())
    window.setTimeout(function() { s.SetContentHtml(""); }, 0);
  }.aspxBind(this));
  popup.Resize.AddHandler(function(s) { 
   var colIndex = this.FindColumnIndexByHeaderChild(s.GetCurrentPopupElement());
   var column = this._getColumn(colIndex);
   if(!column) return;
   this.SetHeaderFilterPopupSize(colIndex, s.GetWidth(), s.GetHeight());
  }.aspxBind(this));
  var buttons = this.GetHeaderFilterButtons();
  for(var i = 0; i < buttons.length; i++)
   popup.AddPopupElement(buttons[i]);
 },
 GetHeaderFilterButtons: function() {
  var buttons = [ ];
  for(var i = 0; i < this.GetColumnsCount(); i++) {
   if(!this.GetColumn(i).visible)
    continue;
   this.PopulateHeaderFilterButtons(this.GetHeader(i, false), buttons);
   this.PopulateHeaderFilterButtons(this.GetHeader(i, true), buttons);
  }
  var custWindow = this.GetCustomizationWindow();
  if(custWindow)
   this.PopulateHeaderFilterButtons(custWindow.GetWindowClientTable(-1), buttons);
  return buttons;
 },
 PopulateHeaderFilterButtons: function(container, buttons) {
  if(!container) return;
  var images = container.getElementsByTagName("IMG");
  for(var i = 0; i < images.length; i++) {
   var image = images[i];
   if(ASPx.ElementContainsCssClass(image, this.HeaderFilterButtonClassName))
    buttons.push(image);
  }
 },
 UseHFContentCaching: function() {
  var helper = this.GetHeaderFilterHelper();
  var listBox = helper.GetListBox();
  return this.enableHeaderFilterCaching && (!helper.RenderExistsOnPage(listBox) || listBox.GetItemCount() < 1000);
 },
 OnPopUpHeaderFilterWindow: function() {
  var popup = this.GetHeaderFilterPopup();
  var colIndex = this.FindColumnIndexByHeaderChild(popup.GetCurrentPopupElement());
  var column = this._getColumn(colIndex);
  if(!column) return;
  var shiftKey = popup.GetPopUpReasonMouseEvent().shiftKey;
  var headerFilterHelper = this.GetHeaderFilterHelper();
  if(headerFilterHelper.column && headerFilterHelper.column.index == colIndex && this.UseHFContentCaching() && popup.savedShiftKey === shiftKey) {
   headerFilterHelper.RestoreState();
   return;
  }
  popup.savedShiftKey = shiftKey;
  this.gridFuncCallBack([ASPxClientGridViewCallbackCommand.FilterPopup, this.name, colIndex, shiftKey ? "T" : ""], headerFilterHelper.OnFilterPopupCallback);
  popup.SetContentHtml("");
  var buttonPanel = document.getElementById(popup.cpButtonPanelID);
  if(buttonPanel) {
   buttonPanel.style.display = column.HFCheckedList ? "" : "none";
   this.SetHFOkButtonEnabled(false);
  }
  var size = this.GetHeaderFilterPopupSize(colIndex);
  if(size) {
   popup.SetSize(size[0], size[1]);
   if(ASPx.Browser.Firefox)
    popup.Shown.AddHandler(function(s) { 
     window.setTimeout(function() { s.SetSize(size[0], size[1]); }, 0); 
    });
  }
  this.CreateLoadingPanelWithoutBordersInsideContainer(popup.GetContentContainer(-1));
 },
 SetHFOkButtonEnabled: function(enabled) {
  var popup = this.GetHeaderFilterPopup();
  if(!popup) return;
  var button = ASPx.GetControlCollection().Get(popup.cpOkButtonID);
  if(!button) return;
  button.SetEnabled(enabled);
 },
 GetHeaderFilterPopupSize: function(key) {
  var size = this.headerFilterPopupDimensions[key];
  if(size) return size;
  if(!this.headerFilterPopupDimensions["Default"]) {
   var popup = this.GetHeaderFilterPopup();
   this.SetHeaderFilterPopupSize("Default", popup.GetWidth(), popup.GetHeight());
  }
  return this.headerFilterPopupDimensions["Default"];
 },
 SetHeaderFilterPopupSize: function(key, width, height) {
  this.headerFilterPopupDimensions[key] = [ width, height ];
 },
 FindColumnIndexByHeaderChild: function(element) {
  if(!element) 
   return -1;
  var level = 0;
  while(level < 6) {
   var index = this.getColumnIndex(element.id);
   if(index > -1)
    return index;
   element = element.parentNode;
   level++;
  }
  return -1;
 },
 InitializeHeaderFilter: function(columnIndex){
  var helper = this.GetHeaderFilterHelper();
  helper.Initialize(columnIndex);
 },
 CheckPendingEvents: function() {
  if(this.pendingEvents.length < 1)
   return;
  for(var i = 0; i < this.pendingEvents.length; i++)
   this.ScheduleRaisingEvent(this.pendingEvents[i]);
  this.pendingEvents.length = 0;
 },
 ScheduleRaisingEvent: function(eventName) {
  window.setTimeout(function() { this[eventName](); }.aspxBind(this), 0);
 },
 CreateInternalCheckBoxCollection: function() {
  if(!this.internalCheckBoxCollection)
   this.internalCheckBoxCollection = new ASPx.CheckBoxInternalCollection(this.checkBoxImageProperties, true, undefined, undefined, undefined, this.accessibilityCompliant);
  else
   this.internalCheckBoxCollection.SetImageProperties(this.checkBoxImageProperties);
  this.CompleteInternalCheckBoxCollection();
 },
 CompleteInternalCheckBoxCollection: function() {
  if(!this.IsLastCallbackProcessedAsEndless()){
   this.internalCheckBoxCollection.Clear();
   for(var i = 0; i < this.selectAllSettings.length; i++){
    var selectAllSettings = this.selectAllSettings[i];
    var icbSelectAllElement = this.GetSelectAllBtn(selectAllSettings.index);
    if(ASPx.IsExistsElement(icbSelectAllElement))
     this.AddInternalCheckBoxToCollection(icbSelectAllElement, -(selectAllSettings.index + 1), !this.IsCheckBoxDisabled(icbSelectAllElement));
   }
  }
  for(var i = 0; i < this.pageRowCount; i ++) {
   var index = i + this.visibleStartIndex;
   var icbInputElement = this.GetDataRowSelBtn(index);
   if(icbInputElement) {
    var enabled = !this.IsCheckBoxDisabled(icbInputElement);
    this.AddInternalCheckBoxToCollection(icbInputElement, index, enabled);
   }
  }
 },
 IsCheckBoxDisabled: function(icbInputElement) {
  var icbMainElement = ASPx.CheckableElementHelper.Instance.GetICBMainElementByInput(icbInputElement);
  return icbMainElement.className.indexOf(this.GetDisabledCheckboxClassName()) != -1;
 },
 GetCssClassNamePrefix: function() { return ""; },
 GetDisabledCheckboxClassName: function() { return this.GetCssClassNamePrefix() + "_cd"; },
 AddInternalCheckBoxToCollection: function (icbInputElement, visibleIndex, enabled) {
  var internalCheckBox = null;
  if(this.IsLastCallbackProcessedAsEndless())
   internalCheckBox = this.internalCheckBoxCollection.Get(icbInputElement.id);
  if(internalCheckBox && internalCheckBox.inputElement != icbInputElement){
   this.internalCheckBoxCollection.Remove(icbInputElement.id);
   internalCheckBox = null;
  }
  if(!internalCheckBox)
   internalCheckBox = this.internalCheckBoxCollection.Add(icbInputElement.id, icbInputElement);
  internalCheckBox.CreateFocusDecoration(this.icbFocusedStyle);
  internalCheckBox.SetEnabled(enabled && this.GetEnabled());
  internalCheckBox.readOnly = this.readOnly;
  internalCheckBox.autoSwitchEnabled = !this.allowSelectSingleRowOnly;
  var grid = this;
  function OnCheckedChanged(s, e){
   if(!s.autoSwitchEnabled && s.GetValue() == ASPx.CheckBoxInputKey.Unchecked){
    var value = s.stateController.GetNextCheckBoxValue(s.GetValue(), s.allowGrayedByClick && s.allowGrayed);
    s.SetValue(value);
   }
   var rowCheckBox = grid.GetDataRowSelBtn(visibleIndex);
   if(grid.allowSelectSingleRowOnly)
    grid._selectAllSelBtn(false, rowCheckBox.id);
   if(!grid.RaiseInternalCheckBoxClick(visibleIndex)){
    grid.ScheduleCommand(function() { grid.SelectItem(visibleIndex, s.GetChecked()); }, true);
    grid.mainTableClickCore(e, true);
   }
  }
  function OnSelectAllCheckedChanged(s, e){
   grid.ScheduleCommand(function() {
    var index = grid.tryGetNumberFromEndOfString(s.inputElement.id).value;
    var columnSelectAllSettings = grid.GetColumnSelectAllSettings(index);
    if(!columnSelectAllSettings)
     return;
    switch(columnSelectAllSettings.mode){
     case 1:
      s.GetChecked() ? grid.SelectAllRowsOnPage() : grid.UnselectAllRowsOnPage();
      break;
     case 2:
      s.GetChecked() ? grid.SelectItemsCore(null, true, true) : grid.UnselectFilteredItemsCore(true);
      break;
    }
    grid.UpdateSelectAllCheckboxesState();
   }, true);
   grid.mainTableClickCore(e, true);
  }
  var checkedChangedHandler = visibleIndex < 0 ? OnSelectAllCheckedChanged : OnCheckedChanged;
  internalCheckBox.CheckedChanged.AddHandler(checkedChangedHandler);
 },
 GetColumnSelectAllSettings: function(index){
  for(var i = 0; i < this.selectAllSettings.length; i++){
   if(this.selectAllSettings[i].index == index)
    return this.selectAllSettings[i];
  }
 },
 SelectItemsCore: function(visibleIndices, selected, changedBySelectAll){
  if(!ASPx.IsExists(selected)) selected = true;
  if(!ASPx.IsExists(visibleIndices)) {
   selected = selected ? "all" : "unall";
   changedBySelectAll = ASPx.IsExists(changedBySelectAll) ? changedBySelectAll : false;
   visibleIndices = [ ];
  } else {
   changedBySelectAll = false;
   if(visibleIndices.constructor != Array)
    visibleIndices = [visibleIndices];
  }
  this.gridCallBack([ASPxClientGridViewCallbackCommand.SelectRows, selected, changedBySelectAll].concat(visibleIndices));
 },
 UnselectFilteredItemsCore: function(changedBySelectAll){
  if(!ASPx.IsExists(changedBySelectAll))
   changedBySelectAll = false;
  this.gridCallBack([ASPxClientGridViewCallbackCommand.SelectRows, "unallf", changedBySelectAll]);
 },
 AdjustControlCore: function() {
  ASPxClientControl.prototype.AdjustControlCore.call(this);
  this.UpdateScrollableControls();
  this.ApplyPostBackSyncData();
  this.AdjustPagerControls();
 },
 NeedCollapseControlCore: function() {
  return this.HasScrolling();
 },
 SerializeCallbackArgs: function(array) {
  if(!ASPx.IsExists(array) || array.constructor != Array || array.length == 0)
   return "";
  var sb = [ ];
  for(var i = 0; i < array.length; i++) {
   var item = array[i].toString();
   sb.push(item.length);
   sb.push('|');
   sb.push(item);
  }
  return sb.join("");
 }, 
 gridCallBack: function (args) {
  this.OnBeforeCallbackOrPostBack();
  if(!this.callBack || !this.callBacksEnabled) {
   this.gridPostBack(args);
  } else {
   var serializedArgs = this.SerializeCallbackArgs(args); 
   var command = this.GetCorrectedCommand(args);
   this.OnBeforeCallback(command);
   var preparedArgs = this.prepareCallbackArgs(serializedArgs, this.GetGridTD());
   this.lockFilter = true;
   this.userChangedSelection = false;
   this.CreateCallback(preparedArgs, command);
  }
 },
 gridPostBack: function(args) { 
  var serializedArgs = this.SerializeCallbackArgs(args); 
  this.postbackRequestCount++;
  this.SendPostBack(serializedArgs);
 },
 GetContextMenuInfo: function() {
  if(!this.clickedMenuItem)
   return "";
  var menu = this.clickedMenuItem.menu;
  var elementInfo = menu.elementInfo;
  return menu.cpType + "," + this.clickedMenuItem.indexPath + "," + elementInfo.index;
 },
 GetCorrectedCommand: function(args) {
  if(args.length == 0)
   return "";
  var command = args[0];
  if(args.length > 1 && command == ASPxClientGridViewCallbackCommand.ColumnMove) {
   if(args[args.length - 1])
    command = ASPxClientGridViewCallbackCommand.UnGroup;
   if(args[args.length - 2])
    command = ASPxClientGridViewCallbackCommand.Group;
  }
  return command;
 },
 GetFuncCallBackIndex: function(onCallBack) {
  var item = { date: new Date(), callback: onCallBack };
  for(var i = 0; i < this.funcCallbacks.length; i ++) {
   if(this.funcCallbacks[i] == null) {
    this.funcCallbacks[i] = item;
    return i;
   }
  }
  this.funcCallbacks.push(item);
  return this.funcCallbacks.length - 1;
 },
 GetFuncCallBack: function(index) {
  if(index < 0 || index >= this.funcCallbacks.length) return null;
  var result = this.funcCallbacks[index];
  this.funcCallbacks[index] = null;
  return result;
 },
 GetWaitedFuncCallbackCount: function() {
  var count = 0;
  for(var i = 0; i < this.funcCallbacks.length; i++)
   if(this.funcCallbacks[i] !== null) count++;
  return count;
 },
 gridFuncCallBack: function(args, onCallBack) {
  var serializedArgs = this.SerializeCallbackArgs(args); 
  var callbackArgs = this.formatCallbackArg("FB", this.GetFuncCallBackIndex(onCallBack).toString()) +
   this.prepareCallbackArgs(serializedArgs, null);
  this.CreateCallback(callbackArgs, "FUNCTION");
 }, 
 prepareCallbackArgs: function(serializedArgs, rootTD) {
  var preparedArgs =
   this.formatCallbackArg("EV", this.GetEditorValues(rootTD)) +
   this.formatCallbackArg("SR", this.GetSelectedState()) +
   this.formatCallbackArg("KV", this.GetKeyValues()) + 
   this.formatCallbackArg("FR", this.stateObject.focusedRow) +
   this.formatCallbackArg("CR", this.stateObject.resizingState) +
   this.formatCallbackArg("CM", this.GetContextMenuInfo()) +
   this.formatCallbackArg("GB", serializedArgs);
  return preparedArgs;
 },
 formatCallbackArg: function(prefix, arg) {
  if(!ASPx.IsExists(arg) || arg === "") return "";
  var s = arg.toString();
  return prefix + "|" + s.length + ';' + s + ';';
 },
 OnCallback: function (result) {
  var html = result.html;
  this.HideFilterControlPopup();
  var isFuncCallback = html.indexOf("FB|") == 0;
  this.afterCallbackRequired = !isFuncCallback; 
  if(isFuncCallback)
   this.OnFunctionalCallback(html);
  else {
   this.UpdateStateObjectWithObject(result.stateObject);
   var helper = this.GetEndlessPagingHelper();
   if(html.indexOf("EP|") == 0 && helper){
    helper.OnCallback(html);
   } else{
    var rootTD = this.GetGridTD();
    if(rootTD)
     ASPx.SetInnerHtml(rootTD, html);
   }
  }
 },
 OnFunctionalCallback: function(result){
  this.PreventCallbackAnimation();
  var result = this.ParseFuncCallbackResult(result.substr(3));
  if(!result) return;
  if(this.IsHeaderFilterFuncCallback(result.callback))
   this.OnFuncCallback(result);
  else 
   window.setTimeout(function() { this.OnFuncCallback(result); }.aspxBind(this), 0);
 },
 OnCallbackFinalized: function() {
  if(this.afterCallbackRequired)
   this.OnAfterCallback();
 },
 IsHeaderFilterFuncCallback: function(callback) {
  return callback === this.GetHeaderFilterHelper().OnFilterPopupCallback;
 },
 ParseFuncCallbackResult: function(result) {
  var pos = result.indexOf("|");
  if(pos < 0) return;
  var index = parseInt(result.substr(0, pos), 10);
  var callbackItem = this.GetFuncCallBack(index);
  if(!callbackItem || !callbackItem.callback) return;
  result = result.substr(pos + 1);
  return { callback: callbackItem.callback, params: result };
 },
 OnFuncCallback: function(result) {
  if(result && result.callback)
   result.callback(eval(result.params));
 },
 OnCallbackError: function(result, data){
  this.showingError = result;
  this.errorData = data;
  if(this.GetGridTD())
   this.afterCallbackRequired = true;
 },
 ShowCallbackError: function(errorText, errorData) {
  var batchEditHelper = this.GetBatchEditHelper();
  if(batchEditHelper && batchEditHelper.ShowCallbackError(errorText, errorData))
   return;
  var displayIn = this;
  var popupForm = this.GetPopupEditForm();
  if(popupForm) {
   displayIn = popupForm;
   if(!popupForm.IsVisible()) {
    popupForm.Show();
   }
  }
  var errorTextContainer = this.GetErrorTextContainer(displayIn);
  if(errorTextContainer)
   errorTextContainer.innerHTML = errorText;
  else
   alert(errorText);
 },
 GetErrorTextContainer: function(displayIn) { },
 CreateEditingErrorItem: function() { },
 CancelCallbackCore: function() {
  this.RestoreCallbackSettings();
  this.AddSelectStartHandler();
  this.lockFilter = false;
  this.keyboardLock = false;
 },
 OnBeforeCallbackOrPostBack: function() {
  this.HidePopupEditForm();
  ASPxClientGridBase.SaveActiveElementSettings(this);
 },
 OnBeforeCallback: function(command) {
  this.keyboardLock = true;
  var endlessPagingHelper = this.GetEndlessPagingHelper();
  if(endlessPagingHelper)
   endlessPagingHelper.OnBeforeCallback(command);
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper)
   scrollHelper.OnBeforeCallback(command);
  this.ShowLoadingElements();
  this.SaveCallbackSettings();
  this.RemoveSelectStartHandler();
  var popup = this.GetHeaderFilterPopup();
  if(popup)
   popup.RemoveAllPopupElements();
 },
 OnAfterCallback: function() {
  this.clickedMenuItem = null;
  var checkBoxCollectionReinitializeRequired = true; 
  if(this.showingError) {
   checkBoxCollectionReinitializeRequired = false;
   this.ShowCallbackError(this.showingError, this.errorData);
      this.showingError = null;
   this.errorData = null;
    }
  this.pendingCommands = [ ];
  this.lockFilter = true;
  try {
   this._setFocusedItemInputValue();
   this.EnsureRowKeys();
   if(!this.IsLastCallbackProcessedAsEndless() && this.headerMatrix)
    this.headerMatrix.Invalidate();
   this.SetHeadersClientEvents();
   this.RestoreCallbackSettings();
   this.AddSelectStartHandler();
   this.EnsureRowHotTrackItems();
   if(this.kbdHelper && !this.useEndlessPaging)
    this.kbdHelper.EnsureFocusedRowVisible();
  }
  finally {
   window.setTimeout(function() { this.lockFilter = false; }.aspxBind(this), 0); 
   this.keyboardLock = false;
  }
  if(this.checkBoxImageProperties && checkBoxCollectionReinitializeRequired){
   this.CreateInternalCheckBoxCollection();
   this.UpdateSelectAllCheckboxesState();
  }
  this.CheckPendingEvents();
  this.InitializeHeaderFilterPopup();
  var endlessPagingHelper = this.GetEndlessPagingHelper();
  if(endlessPagingHelper)
   endlessPagingHelper.OnAfterCallback();
  var batchEditHelper = this.GetBatchEditHelper();
  if(batchEditHelper)
   batchEditHelper.OnAfterCallback();
  this.CheckEndlessPagingLoadNextPage();
  this.PrepareCommandButtons();
  this.EnsureSearchEditor();
  window.setTimeout(function() { this.SaveAutoFilterColumnEditorState(); }.aspxBind(this), 0);
  window.setTimeout(function() { this.EnsureVisibleRowFromServer(); }.aspxBind(this), 0);
  this.AssignEllipsisToolTips();
 },
 SaveAutoFilterColumnEditorState: function() {
  for(var i = 0; i < this.columns.length; i++) {
   var columnIndex = this.columns[i].index;
   this.filterEditorState[columnIndex] = this.GetAutoFilterEditorValue(columnIndex);
  }
 },
 GetAutoFilterEditorValue: function(columnIndex) {
  var editor = this.GetAutoFilterEditor(columnIndex);
  var editorValue = "";
  if(editor && editor.GetMainElement())
   editorValue = editor.GetValueString();
  return {
   value: editorValue,
   filterCondition: this.filterRowConditions ? this.filterRowConditions[columnIndex] : ""
  };
 },
 ClearAutoFilterState: function() {
  this.filterEditorState = [];
 },
 SaveCallbackSettings: function() {
  var custWindow = this.GetCustomizationWindow();
  if(custWindow != null) {
   var custWindowElement = custWindow.GetWindowElement(-1);
   if(custWindowElement) {
    this.custwindowLeft = ASPx.GetAbsoluteX(custWindowElement);
    this.custwindowTop = ASPx.GetAbsoluteY(custWindowElement);
    this.custwindowVisible = custWindow.IsVisible();
    var scroller = ASPx.GetElementById(custWindow.name + "_Scroller");
    this.custwindowScrollPosition = scroller.scrollTop;
   }
  } else {
   this.custwindowVisible = null;
  }
 },
 RestoreCallbackSettings: function() {
  var custWindow = this.GetCustomizationWindow();
  if(custWindow != null && this.custwindowVisible != null) {
   if(this.custwindowVisible){
    custWindow.LockAnimation();
    custWindow.ShowAtPos(this.custwindowLeft, this.custwindowTop);
    custWindow.UnlockAnimation();
    var scroller = ASPx.GetElementById(custWindow.name + "_Scroller");
    scroller.scrollTop = this.custwindowScrollPosition;
   }
  }
  this.ApplyPostBackSyncData();
  this.ResetControlAdjustment(); 
  ASPxClientGridBase.RestoreActiveElementSettings(this); 
 },
 HidePopupEditForm: function() {
  var popup = this.GetPopupEditForm();
  if(popup)
   popup.Hide();
 },
 OnPopupEditFormInit: function(popup) {
  if(this.HasHorzScroll() && this.GetVisibleItemsOnPage() > 0) {
   var popupHorzOffset = popup.GetPopupHorizontalOffset();
   popup.SetPopupHorizontalOffset(popupHorzOffset - this.GetPopupEditFormHorzOffsetCorrection(popup));
  }
  popup.Show();
 },
 GetPopupEditFormHorzOffsetCorrection: function(popup) {
  return 0;
 },
 _isRowSelected: function(visibleIndex) {
  if(!ASPx.IsExists(this.stateObject.selection)) return false;
  var index = this._getItemIndexOnPage(visibleIndex);
  return this._isTrueInCheckList(this.stateObject.selection, index);
 },
 _isTrueInCheckList: function(checkList, index) {
  if(index < 0 ||  index >= checkList.length) return false;
  return checkList.charAt(index) == "T";
 },
 _getSelectedRowCount: function() {
  return this.selectedWithoutPageRowCount + this._getSelectedRowCountOnPage();
 },
 _getSelectedRowCountOnPage: function(){
  if(!ASPx.IsExists(this.stateObject.selection))
   return 0;
  var checkList = this.stateObject.selection;
  var selCount = 0;
  for(var i = 0; i < checkList.length; i++) {
   if(checkList.charAt(i) == "T") selCount ++;
  }
  return selCount;
 },
 _selectAllRowsOnPage: function(checked) {
  if(checked && this.allowSelectSingleRowOnly) {
   this.SelectItem(0, true);
   return;
  }
  if(!ASPx.IsExists(this.stateObject.selection)) return;
  this._selectAllSelBtn(checked);
  var prevSelectedRowCount = 0;
  var isTrueInCheckList = false;
  for(var i = 0; i < this.pageRowCount; i ++) {
   isTrueInCheckList = this._isTrueInCheckList(this.stateObject.selection, i);
   if(isTrueInCheckList) prevSelectedRowCount++; 
   if(isTrueInCheckList != checked)
    this.ChangeItemStyle(i + this.visibleStartIndex, checked ? ASPxClientGridItemStyle.Selected : ASPxClientGridItemStyle.Item);
  }
  if (prevSelectedRowCount == 0 && !checked) return;
  var selValue = "";
  if(checked) {
   for(var i = 0; i < this.pageRowCount; i ++)
    selValue += this.IsDataItem(this.visibleStartIndex + i ) ? "T" : "F";
  }
  if(selValue != this.stateObject.selection) {
   this.userChangedSelection = true;
   if(selValue == "") selValue = "U";
   this.stateObject.selection = selValue;
  }
  this.DoSelectionChanged(-1, checked, true);
  this.UpdateSelectAllCheckboxesState();
 },
 DeleteGridItem: function(visibleIndex) {
  if(this.confirmDelete != "" && !confirm(this.confirmDelete)) return;
  this.DeleteItem(visibleIndex);
 },
 _selectAllSelBtn: function(checked, exceptName) {
  if(!this.checkBoxImageProperties) return;
  for(var name in this.internalCheckBoxCollection.elements) { 
   var checkBox = this.internalCheckBoxCollection.elements[name];
   if(name !== exceptName && checkBox.SetValue)
    checkBox.SetValue(checked ? ASPx.CheckBoxInputKey.Checked : ASPx.CheckBoxInputKey.Unchecked);
  }
 },
 doRowMultiSelect: function(row, rowIndex, evt) {
  var ctrlKey = evt.ctrlKey || evt.metaKey,
   shiftKey = evt.shiftKey;
  if((ctrlKey || shiftKey) && (!ASPx.Browser.IE || ASPx.Browser.Version > 8))
   ASPx.Selection.Clear();
  if(this.allowSelectSingleRowOnly)
   shiftKey = false;
  if(!ctrlKey && !shiftKey) {
   if(this._getSelectedRowCountOnPage() === 1 && this._isRowSelected(rowIndex))
    return;
   this._selectAllRowsOnPage(false);
   this.SelectItem(rowIndex, true);
   this.lastMultiSelectIndex = rowIndex;
  } else {
   if(ctrlKey) {
    this.SelectItem(rowIndex, !this._isRowSelected(rowIndex));
    this.lastMultiSelectIndex = rowIndex;
   } else {
    var startIndex = rowIndex > this.lastMultiSelectIndex ? this.lastMultiSelectIndex + 1 : rowIndex;
    var endIndex = rowIndex > this.lastMultiSelectIndex ? rowIndex : this.lastMultiSelectIndex - 1;
    for(var i = this.visibleStartIndex; i < this.pageRowCount + this.visibleStartIndex; i ++) {
     if(i == this.lastMultiSelectIndex) 
      continue;
     this.SelectItem(i, i >= startIndex && i <= endIndex);
    }
   }
  }
  this.UpdatePostBackSyncInput();
 },
 AddSelectStartHandler: function() {   
  if(!this.allowSelectByItemClick || !ASPx.Browser.IE || ASPx.Browser.Version > 8 )
   return;
  ASPx.Evt.AttachEventToElement(this.GetMainTable(), "selectstart", ASPxClientGridBase.SelectStartHandler);
 },
 RemoveSelectStartHandler: function() {
  if(!this.allowSelectByItemClick || !ASPx.Browser.IE)
   return; 
  ASPx.Evt.DetachEventFromElement(this.GetMainTable(), "selectstart", ASPxClientGridBase.SelectStartHandler);
 },
 SelectItemsByKey: function(keys, selected){
  if(!ASPx.IsExists(selected)) selected = true;
  if(!ASPx.IsExists(keys)) return;
  if(keys.constructor != Array)
   keys = [keys];
  this.gridCallBack([ASPxClientGridViewCallbackCommand.SelectRowsKey, selected].concat(keys));
 },
 SelectItem: function(visibleIndex, checked, fromCheckBox) {
  if(!this.IsPossibleSelectItem(visibleIndex, checked)) return;
  if(ASPx.IsExists(fromCheckBox)) fromCheckBox = false;
  var index = this._getItemIndexOnPage(visibleIndex);
  if(index < 0) return;
  if(checked && this.allowSelectSingleRowOnly)
   this._selectAllRowsOnPage(false);
  if(ASPx.IsExists(this.stateObject.selection)) {
   this.userChangedSelection = true;
   var checkList = this.stateObject.selection;
   if(index >= checkList.length) {
    if(!checked) return;
    for(var i = checkList.length; i <= index; i ++)
     checkList += "F";
   }
   checkList = checkList.substr(0, index) + (checked ? "T" : "F") + checkList.substr(index + 1, checkList.length - index - 1);
   if(checkList.indexOf("T") < 0) checkList = "U";
   this.stateObject.selection = checkList;
  }
  var checkBox = this.GetDataRowSelBtn(visibleIndex);
  if(checkBox) {
   var internalCheckBox = this.internalCheckBoxCollection.Get(checkBox.id);
   internalCheckBox.SetValue(checked ? ASPx.CheckBoxInputKey.Checked : ASPx.CheckBoxInputKey.Unchecked);
  }
  this.UpdateSelectAllCheckboxesState();
  this.ChangeItemStyle(visibleIndex, checked ? ASPxClientGridItemStyle.Selected : ASPxClientGridItemStyle.Item);
  this.DoSelectionChanged(visibleIndex, checked, false);
 },
 IsPossibleSelectItem: function(visibleIndex, newSelectedValue){
  return visibleIndex > -1 && this._isRowSelected(visibleIndex) != newSelectedValue;
 },
 UpdateSelectAllCheckboxesState: function(){
  if(!this.selectAllSettings)
   return;
  for(var i = 0; i < this.selectAllSettings.length; i++){
   var columnSelectAllSettings = this.selectAllSettings[i];
   var selectAllButtonInput = this.GetSelectAllBtn(columnSelectAllSettings.index);
   if(selectAllButtonInput && !this.IsCheckBoxDisabled(selectAllButtonInput))
    this.UpdateSelectAllCheckboxStateCore(selectAllButtonInput, columnSelectAllSettings.mode, columnSelectAllSettings.selectText, columnSelectAllSettings.unselectText);
  }
 },
 UpdateSelectAllCheckboxStateCore: function(selectAllButtonInput, selectMode, selectTooltip, unselectTooltip){
  var value = ASPx.CheckBoxInputKey.Indeterminate;
  var selectedRowCountOnPage = this.GetSelectedKeysOnPage().length;
  var considerSelectionOnPages = selectMode == 2 && this.selectAllBtnStateWithoutPage !== null;
  if(this.GetDataItemCountOnPage() == selectedRowCountOnPage && (!considerSelectionOnPages || this.selectAllBtnStateWithoutPage == ASPx.CheckBoxInputKey.Checked))
   value = ASPx.CheckBoxInputKey.Checked;
  else if(selectedRowCountOnPage == 0 && (!considerSelectionOnPages || this.selectAllBtnStateWithoutPage == ASPx.CheckBoxInputKey.Unchecked))
   value = ASPx.CheckBoxInputKey.Unchecked;
  var selectAllCheckBoxInst = this.internalCheckBoxCollection.Get(selectAllButtonInput.id);
  selectAllCheckBoxInst.SetValue(value);
  var selectAllMainElement = ASPx.CheckableElementHelper.Instance.GetICBMainElementByInput(selectAllButtonInput);
  setTimeout(function() {
   selectAllMainElement.title = value === ASPx.CheckBoxInputKey.Checked ? unselectTooltip : selectTooltip;
  }, this.accessibilityCompliant ? 50 : 0);
 },
 SetSelectAllButtonToolTip: function(tooltip){
  var selectAllBtnInput = this.GetSelectAllBtn();
  if(ASPx.IsExists(selectAllBtnInput)){
   var mainElement = ASPx.CheckableElementHelper.Instance.GetICBMainElementByInput(selectAllBtnInput);
   mainElement.title = tooltip;
  }
 },
 GetDataItemCountOnPage: function(){
  return this.pageRowCount;
 },
 ScheduleUserCommand: function(args, postponed, eventSource) {
  if(!args || args.length == 0) 
   return;
  var commandName = args[0];
  var rowCommands = this.GetUserCommandNamesForRow();
  if((this.useEndlessPaging || this.allowBatchEditing) && ASPx.Data.ArrayIndexOf(rowCommands, commandName) > -1)
   args[args.length - 1] = this.FindParentRowVisibleIndex(eventSource, true);
  postponed &= this.IsMainTableChildElement(eventSource);
  this.ScheduleCommand(args, postponed);
 },
 GetUserCommandNamesForRow: function() { return [ "CustomButton", "Select", "StartEdit", "Delete" ]; },
 IsMainTableChildElement: function(src) { return true; },
 FindParentRowVisibleIndex: function(element, dataAndGroupOnly) {
  var regEx = this.GetItemVisibleIndexRegExp(dataAndGroupOnly);
  while(element) {
   if(element.tagName === "BODY" || element.id == this.name)
    return -1;
   var matches = regEx.exec(element.id);
   if(matches && matches.length == 3)
    return parseInt(matches[2]);
   element = element.parentNode;
  }
  return -1;
 },
 GetItemVisibleIndexRegExp: function(dataAndGroupOnly) {
  return this.GetItemVisibleIndexRegExpByIdParts();
 },
 GetItemVisibleIndexRegExpByIdParts: function(idParts){
  if(!idParts) idParts = [ ];
  return new RegExp("^(" + this.name + "_(?:" + idParts.join("|") + "))(-?\\d+)$");
 },
 ScheduleCommand: function(args, postponed) {
  if(postponed)
   this.pendingCommands.push(args);
  else 
   this.PerformScheduledCommand(args);
 },
 PerformScheduledCommand: function(args) {
  if(ASPx.IsFunction(args)) {
   args(); 
   return;
  }
  if(args && args.length > 0) {
   var commandName = "UA_" + args[0];
   if(this[commandName])
    this[commandName].apply(this, args.slice(1));
  }
 },
 PerformPendingCommands: function() {
  var commandCount = this.pendingCommands.length;
  for(var i = 0; i < commandCount; i++)
   this.PerformScheduledCommand(this.pendingCommands.pop());
 },
 getItemByHtmlEvent: function(evt) {
  return null;
 },
 getItemByHtmlEventCore: function(evt, partialID) {
  var row = ASPx.GetParentByPartialId(ASPx.Evt.GetEventSource(evt), partialID);
  if(row && row.id.indexOf(this.name) > -1)
   return row;
  return null;
 },
 NeedProcessTableClick: function(evt) {
  var mainTable = ASPx.GetParentByPartialId(ASPx.Evt.GetEventSource(evt), this.MainTableID);
  if(mainTable) {
   var mainTableID = mainTable.id;
   var gridID = mainTableID.substr(0, mainTableID.length - this.MainTableID.length - 1);
   return this.name == gridID;
  }
  return false;
 },
 mainTableClick: function(evt) { this.mainTableClickCore(evt); },
 mainTableDblClick: function(evt) { 
  var row = this.getItemByHtmlEvent(evt);
  if(!row) return;
  var forceRowDblClickEvent = true;
  var rowIndex = this.getItemIndex(row.id);
  var batchEditHelper = this.GetBatchEditHelper();
  if(batchEditHelper){
   batchEditHelper.ProcessTableClick(row, evt, true);
   forceRowDblClickEvent = batchEditHelper.editRowVisibleIndex != rowIndex;
  }
  if(forceRowDblClickEvent)
   this.RaiseItemDblClick(rowIndex, evt);
 },
 mainTableClickCore: function(evt, fromCheckBox) {
  if(this.kbdHelper)
   this.kbdHelper.HandleClick(evt);
  var sendNotificationCallack = true;
  this.mainTableClickData.processing = true;
  try {
   this.ProcessTableClick(evt, fromCheckBox);
   var savedRequestCount = this.requestCount + this.postbackRequestCount;
   this.PerformPendingCommands();
   var currentRequestCount = this.requestCount + this.postbackRequestCount;
   sendNotificationCallack = currentRequestCount == savedRequestCount;
  } finally {
   if(sendNotificationCallack)
    if(this.mainTableClickData.focusChanged && !this.mainTableClickData.selectionChanged) {
     this.gridCallBack([ASPxClientGridViewCallbackCommand.FocusedRow]);
    } else if(this.mainTableClickData.selectionChanged) {
     this.gridCallBack([ASPxClientGridViewCallbackCommand.Selection]);
    }
   this.mainTableClickData.processing = false;
   this.mainTableClickData.focusChanged = false;
   this.mainTableClickData.selectionChanged = false;
  }
 },
 ProcessTableClick: function(evt, fromCheckBox) {
  var source = ASPx.Evt.GetEventSource(evt);
  var row = this.getItemByHtmlEvent(evt);
  if(row) {
   var itemIndex = this.getItemIndex(row.id);
   var isCommandColumnItem = this.IsCommandColumnItem(source);
   if(!isCommandColumnItem && !fromCheckBox) {
    var batchEditHelper = this.GetBatchEditHelper();
    if(batchEditHelper && batchEditHelper.ProcessTableClick(row, evt))
     return;
    if(this.RaiseItemClick(itemIndex, evt)) 
     return;
   }
   var prevFocusedItemIndex = this._getFocusedItemIndex();
   if(this.allowFocusedRow)
    this._setFocusedItemIndex(itemIndex);
   if(this.allowSelectByItemClick) {
    if(!this.testActionElement(source) && !isCommandColumnItem && !fromCheckBox) {
     if(this.lookupBehavior){
      var checked = this.allowSelectSingleRowOnly || !this._isRowSelected(itemIndex);
      this.SelectItem(itemIndex, checked);
     } else {
      if(this.lastMultiSelectIndex < 0 && prevFocusedItemIndex > -1) {
       this.SelectItem(prevFocusedItemIndex, true);
       this.lastMultiSelectIndex = prevFocusedItemIndex;
      }
      this.doRowMultiSelect(row, itemIndex, evt);
     }
    }
   } else {
    this.lastMultiSelectIndex = itemIndex;
   }
  }
 },
 testActionElement: function(element) {
  return element && element.tagName.match(/input|select|textarea|^a$/i);
 },
 IsCommandColumnItem: function(element) {
  if(!element)
   return false;
  if(ASPx.ElementHasCssClass(element, this.CommandColumnItemClassName))
   return true;
  var elementId = element.parentNode.id;
  return ASPx.IsExists(elementId) && elementId.indexOf("DXCBtn") > -1 && elementId.indexOf(this.name) > -1;
 },
 _setFocusedItemIndex: function(visibleIndex) {
  if(visibleIndex < 0) 
   visibleIndex = -1;
  if(!this.allowFocusedRow || visibleIndex == this.focusedRowIndex) 
   return;
  var oldIndex = this.focusedRowIndex;
  this.focusedRowIndex = visibleIndex;
  this.ChangeFocusedItemStyle(oldIndex, false);
  this.ChangeFocusedItemStyle(this.focusedRowIndex, true);
  this._setFocusedItemInputValue();
  if(this.callbackOnFocusedRowChanged) {
   this.UpdatePostBackSyncInput(true);
   if(!this.mainTableClickData.processing) {
    this.gridCallBack([ASPxClientGridViewCallbackCommand.FocusedRow]);
   } else {
    this.mainTableClickData.focusChanged = true;
   }
   return;
  }
  this.RaiseFocusedItemChanged();
 },
 ChangeFocusedItemStyle: function(visibleIndex, focused) {
  if(visibleIndex < 0) return;
  var itemStyle = this.GetFocusedItemStyle(visibleIndex, focused);
  this.ChangeItemStyle(visibleIndex, itemStyle);
 },
 GetFocusedItemStyle: function(visibleIndex, focused){
  if(focused)
   return ASPxClientGridItemStyle.FocusedItem;
  return this._isRowSelected(visibleIndex) ? ASPxClientGridItemStyle.Selected : ASPxClientGridItemStyle.Item;
 },
 _setFocusedItemInputValue: function() {
  if(ASPx.IsExists(this.stateObject.focusedRow)) 
   this.stateObject.focusedRow = this.focusedRowIndex;
 },
 _getFocusedItemIndex: function() {
  if(!this.allowFocusedRow) return -1;
  return this.focusedRowIndex;
 },
 getItemIndex: function(rowId) {   
  return this.tryGetNumberFromEndOfString(rowId).value;
 },
 tryGetNumberFromEndOfString: function(str) {
  var value = -1;
  var success = false;
  var n = str.length - 1;
  while(!isNaN(parseInt(str.substr(n), 10))) {
   value = parseInt(str.substr(n), 10);
   success = true;
   n--;
  }
  return { success: success, value: value };
 },
 GetSelectedState: function() {
  if(!this.userChangedSelection) return null;
  if(!ASPx.IsExists(this.stateObject.selection)) return null;
  return this.stateObject.selection;
 },
 GetKeyValues: function() {
  return ASPx.Json.ToJson(this.stateObject.keys);
 },
 UpdateItemsStyle: function() {
  var start = this.GetTopVisibleIndex();
  var end = start + this.GetVisibleItemsOnPage();
  for(var i = start; i < end; i++) 
   this.UpdateItemStyle(i, this.GetItemStyle(i));
 },
 UpdateItemStyle: function(visibleIndex) {
  this.ChangeItemStyle(visibleIndex, this.GetItemStyle(visibleIndex));
 },
 GetItemStyle: function(visibleIndex){
  var style = ASPxClientGridItemStyle.Item;
  if(this._getFocusedItemIndex() == visibleIndex)
   style = ASPxClientGridItemStyle.FocusedItem;
  else if(this._isRowSelected(visibleIndex))
   style = ASPxClientGridItemStyle.Selected;
  return style;
 },
 ChangeItemStyle: function(visibleIndex, rowStyle) {
  if(!this.RequireChangeItemStyle(visibleIndex, rowStyle))
   return;
  var styleInfo = this.getItemStyleInfo(rowStyle);
  this.ApplyItemStyle(visibleIndex, styleInfo);
  var batchEditHelper = this.GetBatchEditHelper();
  if(batchEditHelper)
   batchEditHelper.OnItemStyleChanged(visibleIndex);
 },
 ApplyItemStyle: function(visibleIndex, styleInfo) {
  var item = this.GetItem(visibleIndex);
  this.ApplyElementStyle(item, styleInfo);
 },
 ApplyElementStyle: function(element, styleInfo){
  if(!ASPx.IsExists(element.initialClassName))
   element.initialClassName = element.className;
  if(!ASPx.IsExists(element.initialCssText))
   element.initialCssText = element.style.cssText;
  element.className = element.initialClassName;
  element.style.cssText = element.initialCssText;
  if(styleInfo) {
   element.className += " " + styleInfo.css;
   element.style.cssText += " " + styleInfo.style;
  }
 },
 RequireChangeItemStyle: function(visibleIndex, itemStyle){
  if(this._getFocusedItemIndex() == visibleIndex && itemStyle != ASPxClientGridItemStyle.FocusedItem && itemStyle != ASPxClientGridItemStyle.FocusedGroupItem)
   return false;
  return !!this.GetItem(visibleIndex);
 },
 _getItemIndexOnPage: function(visibleIndex) { 
  return visibleIndex - this.visibleStartIndex; 
 },
 getColumnIndex: function(colId) {
  if(this.IsEmptyHeaderID(colId))
   return -1;
  var index = this.tryGetNumberFromEndOfString(colId).value;
  var postfix = "col" + index;
  if(colId.lastIndexOf(postfix) == colId.length - postfix.length)
   return index;
  return -1;
 },
 getColumnObject: function(colId) {
  var index = this.getColumnIndex(colId);
  return index > -1 ? this._getColumn(index) : null;
 },
 _getColumnIndexByColumnArgs: function(column) {
  column = this._getColumnObjectByArg(column);
  if(!column) return null;
  return column.index;
 },
 _getColumnObjectByArg: function(arg) {
  if(!ASPx.IsExists(arg)) return null;
  if(typeof(arg) == "number") return this._getColumn(arg);
  if(ASPx.IsExists(arg.index)) return arg;
  var column = this._getColumnById(arg);
  if(column) return column;
  return this._getColumnByField(arg);  
 },
 _getColumnCount: function() { return this.columns.length; },
 _getColumn: function(index) { 
  if(index < 0 || index >= this.columns.length) return null;
  return this.columns[index];
 },
 _getColumnById: function(id) {
  if(!ASPx.IsExists(id)) return null;
  for(var i = 0; i < this.columns.length; i++) {
   if(this.columns[i].id == id) return this.columns[i];
  }
  return null;
 },
 _getColumnByField: function(fieldName) {
  if(!ASPx.IsExists(fieldName)) return null;
  for(var i = 0; i < this.columns.length; i++) {
   if(this.columns[i].fieldName == fieldName) return this.columns[i];
  }
  return null;
 },
 getItemStyleInfo: function(itemStyleType){
  return this.styleInfo && this.styleInfo[itemStyleType];
 },
 DoSelectionChanged: function(index, isSelected, isSelectAllOnPage){
  if(this.callbackOnSelectionChanged) {
   this.UpdatePostBackSyncInput(true);
   if(!this.mainTableClickData.processing) {
    this.gridCallBack([ASPxClientGridViewCallbackCommand.Selection]);
   } else {
    this.mainTableClickData.selectionChanged = true;
   }
   return;
  }
  this.RaiseSelectionChanged(index, isSelected, isSelectAllOnPage, false);
 },
 CommandCustomButton:function(id, index) {
  var processOnServer = true;
  if(!this.CustomButtonClick.IsEmpty()) {
   var e = this.CreateCommandCustomButtonEventArgs(index, id);
   this.CustomButtonClick.FireEvent(this, e);
   processOnServer = e.processOnServer;
  }
  if(processOnServer)
   this.gridCallBack([ASPxClientGridViewCallbackCommand.CustomButton, id, index]);
 },
 CreateCommandCustomButtonEventArgs: function(index, id){
  return null;
 },
 HeaderMouseDown: function(element, e){
  if(!ASPx.Evt.IsLeftButtonPressed(e)) 
   return;
  var source = ASPx.Evt.GetEventSource(e);
  if(ASPx.ElementContainsCssClass(source, this.HeaderFilterButtonClassName))
   return;
  if(this.TryStartColumnResizing(e, element))
   return;
  var canDrag = this.canDragColumn(element) && source.tagName != "IMG";
  var dragHelper = this.GetDragHelper();
  var drag = dragHelper.CreateDrag(e, element, canDrag);
  if(!canDrag && (e.shiftKey || e.ctrlKey))
   drag.clearSelectionOnce = true;
  dragHelper.CreateTargets(drag, e);
 },
 TryStartColumnResizing: function(e, headerCell) {
  return false;
 }, 
 OnParentRowMouseEnter: function(element) {
  if(this.GetParentRowsWindow() == null) return;
  if(this.GetParentRowsWindow().IsWindowVisible()) return;
  this.ParentRowsTimerId = window.setTimeout(function() {
   var gv = ASPx.GetControlCollection().Get(this.name);
   if(gv)
    gv.OnParentRowsTimer(element.id);
  }.aspxBind(this), 500);
 },
 OnParentRowsTimer: function(rowId) {
  var element = ASPx.GetElementById(rowId);
  if(element)
   this.ShowParentRows(element);
 },
 OnParentRowMouseLeave: function(evt) {
  ASPx.Timer.ClearTimer(this.ParentRowsTimerId);
  if(this.GetParentRowsWindow() == null) return;
  if(evt && evt.toElement) {
   if(ASPx.GetParentByPartialId(evt.toElement, this.GetParentRowsWindow().name) != null)
    return;
  }
  this.HideParentRows();
 },
 ShowParentRows: function(element) {
  this.ParentRowsTimerId = null;
  if(this.GetParentRowsWindow() != null) {
   this.GetParentRowsWindow().ShowAtElement(element);
  }
 },
 HideParentRows: function() {
  this.ParentRowsTimerId = null;
  if(this.GetParentRowsWindow() != null) {
   this.GetParentRowsWindow().Hide();
  }
 }, 
 canSortByColumn: function(headerElement) {
  return this.getColumnObject(headerElement.id).allowSort;
 },
 canGroupByColumn: function(headerElement) {
  return false;
 },
 canDragColumn: function(headerElement) {
  return false;
 },
 doPagerOnClick: function(id) {
  if(!ASPx.IsExists(id)) return;
  this.gridCallBack([ASPxClientGridViewCallbackCommand.PagerOnClick, id]);
 },
 CanHandleGesture: function(evt) {
  var source = ASPx.Evt.GetEventSource(evt);
  var table = this.GetMainTable();
  if(!table) return false;
  if(ASPx.GetIsParent(table, source))
   return !this.NeedPreventGestures(source, table);
  if(table.parentNode.tagName == "DIV" && ASPx.GetIsParent(table.parentNode, source))
   return ASPx.Browser.TouchUI || evt.offsetX < table.parentNode.clientWidth;
  return false;
 },
 AllowStartGesture: function() {
  return ASPxClientControl.prototype.AllowStartGesture.call(this) && 
   (this.AllowExecutePagerGesture(this.pageIndex, this.pageCount, 1) || this.AllowExecutePagerGesture(this.pageIndex, this.pageCount, -1));
 },
 AllowExecuteGesture: function(value) {
  return this.AllowExecutePagerGesture(this.pageIndex, this.pageCount, value);
 },
 ExecuteGesture: function(value, count) {
  this.ExecutePagerGesture(this.pageIndex, this.pageCount, value, count, function(arg) { this.doPagerOnClick(arg); }.aspxBind(this));
 },
 OnColumnFilterInputChanged: function(editor) {
  this.ApplyColumnAutoFilterCore(editor);
 },
 OnColumnFilterInputSpecKeyPress: function(editor, e) {
  if(e.htmlEvent) 
   e = e.htmlEvent;
  if(e.keyCode == ASPx.Key.Tab) 
   return true;
  if(e.keyCode == ASPx.Key.Enter) {
   ASPx.Evt.PreventEventAndBubble(e);
   window.setTimeout(function() {
     editor.Validate();
     if(this.allowMultiColumnAutoFilter)
      this.ApplyMultiColumnAutoFilter(editor);
     else
      this.ApplyColumnAutoFilterCore(editor);
    }.aspxBind(this), 0);
   return true;
  }
  if(e.keyCode == ASPx.Key.Delete && e.ctrlKey) {
   ASPx.Evt.PreventEventAndBubble(e);
   window.setTimeout(function() {
     editor.SetValue(null);
     if(!this.allowMultiColumnAutoFilter)
      this.ApplyColumnAutoFilterCore(editor);
    }.aspxBind(this), 0);
   return true;
  }
  return false;
 },
 OnColumnFilterInputKeyPress: function(editor, e) {
  if(this.OnColumnFilterInputSpecKeyPress(editor, e))
   return;
  this.ClearAutoFilterInputTimer();
  if(editor != this.FilterKeyPressEditor)
   this.filterKeyPressInputValue = editor.GetValueString();
  this.FilterKeyPressEditor = editor;
  this.filterKeyPressTimerId = window.setTimeout(function() {
   var gv = ASPx.GetControlCollection().Get(this.name);
   if(gv != null)
    gv.OnFilterKeyPressTick();
  }.aspxBind(this), this.autoFilterDelay);
 },
 ClearAutoFilterInputTimer: function() {
  this.filterKeyPressTimerId = ASPx.Timer.ClearTimer(this.filterKeyPressTimerId);
 },
 OnFilterKeyPressTick: function() {
  if(this.FilterKeyPressEditor) {
   this.ApplyColumnAutoFilterCore(this.FilterKeyPressEditor);
  }
 },
 ApplyColumnAutoFilterCore: function(editor) {
  if(this.lockFilter) return;
  this.ClearAutoFilterInputTimer();
  if(this.FilterKeyPressEditor && editor == this.FilterKeyPressEditor) {
   if(this.FilterKeyPressEditor.GetValueString() == this.filterKeyPressInputValue) return;
  }
  var column = this.getColumnIndex(editor.name);
  if(column < 0) return;
  this.SaveFilterEditorActiveElement(editor);
  this.AutoFilterByColumn(column, editor.GetValueString());
 },
 ApplyMultiColumnAutoFilter: function(editor) {
  if(this.lockFilter) return;
  this.SaveFilterEditorActiveElement(editor);
  var args = [];
  var modifiedValues = this.GetModifiedAutoFilterValues();
  for(var columnIndex in modifiedValues) {
   args.push(columnIndex);
   args.push(modifiedValues[columnIndex].value);
   args.push(modifiedValues[columnIndex].filterCondition);
  }
  if(args.length > 0)
   this.gridCallBack([ASPxClientGridViewCallbackCommand.ApplyMultiColumnFilter].concat(args));
 },
 SaveFilterEditorActiveElement: function(editor) {
  if(!editor) return;
  var columnIndex = this.getColumnIndex(editor.name);
  if(columnIndex < 0 && editor !== this.GetSearchEditor())
   return;
  this.activeElement = this.GetFilterEditorInputElement(editor);
 },
 GetFilterEditorInputElement: function(editor) {
  if(document.activeElement && !ASPx.Browser.VirtualKeyboardSupported) return document.activeElement;
  if(editor.GetInputElement) return editor.GetInputElement();
  return null;
 },
 GetModifiedAutoFilterValues: function() {
  var result = {};
  for(var i = 0; i < this.columns.length; ++i) {
   var columnIndex = this.columns[i].index;
   var editorState = this.GetAutoFilterEditorValue(columnIndex);
   var chachedEditorState = this.filterEditorState[columnIndex];
   if(chachedEditorState.value !== editorState.value || chachedEditorState.filterCondition !== editorState.filterCondition) {
    result[columnIndex] = {
     value: editorState.value != null ? editorState.value : "",
     filterCondition: editorState.filterCondition
    }
   }
  }
  return result;
 },
 EnsureSearchEditor: function() {
  var edit = this.GetSearchEditor();
  if(!edit) return;
  if(edit === this.GetCustomSearchPanelEditor())
   window.setTimeout(function() { edit.SetValue(this.searchPanelFilter) }.aspxBind(this), 0);
  if(edit.dxgvSearchGrid !== this) {
   edit.KeyDown && edit.KeyDown.AddHandler(function(s, e) {
     if(!this.IsValidInstance()) return;
     this.OnSearchEditorKeyDown(s, e);
    }.aspxBind(this));
   edit.ValueChanged && edit.ValueChanged.AddHandler(function(s, e) {
     if(!this.IsValidInstance()) return;
     this.OnSearchEditorValueChanged(s, e);
    }.aspxBind(this));
   edit.dxgvSearchGrid = this;
  }
  var isCustomEditorInsideTemplate = edit === this.GetCustomSearchPanelEditor() && ASPx.GetIsParent(this.GetMainElement(), edit.GetMainElement());
  this.searchEditorInitialValue = isCustomEditorInsideTemplate ? this.searchPanelFilter : edit.GetValueString(); 
 },
 OnSearchEditorKeyDown: function(s, e) {
  if(!e.htmlEvent) return;
  e = e.htmlEvent;
  var clearEditor = e.keyCode == ASPx.Key.Delete && e.ctrlKey;
  if(e.keyCode == ASPx.Key.Enter || clearEditor) {
   if(clearEditor)
    s.SetValue(null);
   this.ApplySearchFilterFromEditor(s);
   ASPx.Evt.PreventEventAndBubble(e);
   return;
  }
  this.CreateSearchFilterTimer(s);
 },
 OnSearchEditorValueChanged: function(s, e) {
  window.setTimeout(function() { this.ApplySearchFilterFromEditor(s);  }.aspxBind(this), 0)
 },
 CreateSearchFilterTimer: function(editor) {
  if(!this.allowSearchFilterTimer) return;
  this.ClearSearchFilterTimer();
  this.searchFilterTimer = window.setTimeout(function() { this.ApplySearchFilterFromEditor(editor);  }.aspxBind(this), this.searchFilterDelay);
 },
 ClearSearchFilterTimer: function() {
  this.searchFilterTimer = ASPx.Timer.ClearTimer(this.searchFilterTimer);
 },
 ApplySearchFilterFromEditor: function(edit) {
  this.ClearSearchFilterTimer();
  if(this.lockFilter) return;
  if(!this.GetMainTable() || !edit) 
   return;
  edit.Validate();
  if(!edit.GetIsValid()) 
   return;
  var value = edit.GetValueString();
  if(value === this.searchEditorInitialValue)
   return;
  this.SaveFilterEditorActiveElement(edit)
  this.ApplySearchPanelFilter(value);
 },
 ApplySearchPanelFilter: function(value) {
  if(!ASPx.IsExists(value))
   value = "";
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ApplySearchPanelFilter, value]);
 },
 FilterRowMenuButtonClick: function(columnIndex, element) {
  var menu = this.GetFilterRowMenu();
  if(!menu) return;
  var column = this._getColumn(columnIndex);
  if(!column) return;
  for(var i = menu.GetItemCount() - 1; i >= 0; i--) {
   var item = menu.GetItem(i);
   item.SetChecked(item.name.substr(0, item.name.indexOf("|")) == this.filterRowConditions[columnIndex]);
   item.SetVisible(this.GetFilterRowMenuItemVisible(item, column));
  }
  menu.ShowAtElement(element);
  this.filterRowMenuColumnIndex = columnIndex;
 },
 GetFilterRowMenuItemVisible: function(item, column) {
  if(column.filterRowTypeKind) {
   var visible = item.name.indexOf(column.filterRowTypeKind) > -1;
   if(!visible && column.showFilterMenuLikeItem)
    return item.name.indexOf("L") > -1;
   return visible;
  }
  return false;
 },
 FilterRowMenuItemClick: function(item) {
  var itemName = item.name.substr(0, item.name.indexOf("|"));
  if(this.allowMultiColumnAutoFilter) {
   this.filterRowConditions[this.filterRowMenuColumnIndex] = parseInt(itemName);
  } else {
   var args = [this.filterRowMenuColumnIndex, itemName];
   this.gridCallBack([ASPxClientGridViewCallbackCommand.FilterRowMenu].concat(args));
  }
 },
 NeedShowLoadingPanelInsideEndlessPagingContainer: function() {
  var endlessPagingHelper = this.GetEndlessPagingHelper();
  return endlessPagingHelper && endlessPagingHelper.NeedShowLoadingPanelAtBottom();
 },
 ShowLoadingPanel: function() {
  var gridMainCell = this.GetGridTD();
  if(!gridMainCell)
   return;
  if(this.NeedShowLoadingPanelInsideEndlessPagingContainer()) {
   var container = this.GetEndlessPagingLPContainer();
   ASPx.SetElementDisplay(container, true);
   this.CreateLoadingPanelWithoutBordersInsideContainer(container);
   return;
  }
  var lpContainer = this.GetLoadingPanelContainer();
  if(lpContainer)
   this.CreateLoadingPanelInline(lpContainer);
  else
   this.CreateLoadingPanelWithAbsolutePosition(gridMainCell, this.GetLoadingPanelOffsetElement(gridMainCell));
 },
 ShowLoadingDiv: function () {
  if(!this.NeedShowLoadingPanelInsideEndlessPagingContainer())
   this.CreateLoadingDiv(this.GetGridTD());
 },
 GetCallbackAnimationElement: function() {
  var table = this.GetMainTable();
  if(table && table.parentNode && table.parentNode.tagName == "DIV")
   return table.parentNode;
  return table;
 },
 NeedPreventTouchUIMouseScrolling: function(element) {
  return this.NeedPreventGestures(element);
 },
 NeedPreventGestures: function(element, mainElement) {
  if(!ASPx.IsExists(mainElement)) {
   mainElement = this.GetMainElement();
   if(!ASPx.IsExists(mainElement) || !ASPx.GetIsParent(mainElement, element))
    return false;
  }
  var preventElement = this.IsHeaderChild(element) || this.IsActionElement(mainElement, element);
  if(preventElement)
   return true;
  return this.pageCount <= 1 ? !ASPx.Browser.MSTouchUI : false;
 },
 IsHeaderChild: function(source) {
  return false;
 },
 IsActionElement: function(mainElement, source) {
  return false;
 },
 _updateEdit: function() {
  var batchEditHelper = this.GetBatchEditHelper();
  if(batchEditHelper && !batchEditHelper.CanUpdate())
   return;
  if(!batchEditHelper && !this._validateEditors())
   return;
  if(batchEditHelper)
   batchEditHelper.OnUpdate();
  this.gridCallBack([ASPxClientGridViewCallbackCommand.UpdateEdit]);
 },
 _validateEditors: function() {
  var editors = this._getEditors();
  var isValid = true;
  if(editors.length > 0)
   isValid &= this._validate(editors);
  if(window.ASPxClientEdit)
   isValid &= ASPxClientEdit.ValidateEditorsInContainer(this.GetEditFormTable(), this.name);
  return isValid;
 },
 _validate: function(list) {
  var isValid = true;
  var firstInvalid = null;
  var edit;
  for(var i = 0; i < list.length; i ++) {
   edit = list[i];
   edit.Validate();
   isValid = edit.GetIsValid() && isValid;
   if(firstInvalid == null && edit.setFocusOnError && !edit.GetIsValid())
    firstInvalid = edit;
  }
  if (firstInvalid != null)
   firstInvalid.Focus();
  return isValid;
 },
 _getEditors: function() {
  var list = [ ];
  for(var i = 0; i < this.editorIDList.length; i++) {
   var editor = ASPx.GetControlCollection().Get(this.editorIDList[i]);
   if(editor && editor.enabled && editor.GetMainElement && ASPx.IsExistsElement(editor.GetMainElement())) {
    if(!editor.Validate || this.IsStaticBinaryImageEditor(editor)) 
     continue; 
    list.push(editor);
   }
  }
  return list;
 },
 GetEditorValues: function() {
  if(this.allowBatchEditing) return null;
  var list = this._getEditors();
  if(list.length == 0) return null;
  var res = list.length + ";";
  for(var i = 0; i < list.length; i ++) {
   res += this.GetEditorValue(list[i]);
  }
  return res;
 },
 GetEditorValue: function(editor) {
  var value = editor.GetValueString();
  var valueLength = -1;
  if(!ASPx.IsExists(value)) {
   value = "";
  } else {
   value = value.toString();
   valueLength = value.length;
  }
  return this.GetEditorIndex(editor.name) + "," + valueLength + "," + value + ";";
 },
 GetEditorIndex: function(editorId) {
  var i = editorId.lastIndexOf(this.GetEditorPrefix());
  if(i < 0) return -1;
  var result = editorId.substr(i + this.GetEditorPrefix().length);
  i = result.indexOf('_'); 
  return i > 0
   ? result.substr(0, i)
   : result;
 },
 GetBatchEditHelper: function() {
  if(!this.allowBatchEditing) return null;
  if(!this.batchEditHelper)
   this.batchEditHelper = this.CreateBatchEditHelper();
  return this.batchEditHelper;
 },
 CreateBatchEditHelper: function() { },
 GetScrollHelper: function() { return null; },
 GetDragHelper: function() {
  if(!this.dragHelper)
   this.dragHelper = new GridViewDragHelper(this);
  return this.dragHelper;
 },
 GetEndlessPagingHelper: function() {
  if(!this.useEndlessPaging) return null;
  if(!this.endlessPagingHelper)
   this.endlessPagingHelper = this.CreateEndlessPagingHelper();
  return this.endlessPagingHelper;
 },
 CreateEndlessPagingHelper: function(){
  return null;
 },
 IsLastCallbackProcessedAsEndless: function() {
  var helper = this.GetEndlessPagingHelper();
  return helper && helper.endlessCallbackComplete;
 },
 UpdateScrollableControls: function() {
  var helper = this.GetScrollHelper();
  if(helper)
   helper.Update();
 },
 SetHeight: function(height) {
  var mainElemnt = this.GetMainElement();
  if(!ASPx.IsExistsElement(mainElemnt)) return;
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper)
   scrollHelper.SetHeight(height);
 },
 SetHeadersClientEvents: function() { },
 UpdatePostBackSyncInput: function(isChangedNotification) {
  if(!ASPx.IsExists(this.stateObject.lastMultiSelectIndex)) return;
  var selectedIndex = isChangedNotification ? -1 : this.lastMultiSelectIndex; 
  this.stateObject.lastMultiSelectIndex = selectedIndex;
 },
 ApplyPostBackSyncData: function() {
  if(!ASPx.IsExists(this.stateObject.lastMultiSelectIndex)) return;
  this.lastMultiSelectIndex = this.stateObject.lastMultiSelectIndex;
 },
 EnsureVisibleRowFromServer: function() {
  if(this.scrollToRowIndex < 0) return;
  this.MakeRowVisible(this.scrollToRowIndex);
  this.scrollToRowIndex = -1;
 },
 EnsureRowHotTrackItems: function() {
  if(this.rowHotTrackStyle == null) 
   return;
  var list = [ ];
  var start = this.visibleStartIndex;
  var end = start + this.pageRowCount;
  for(var i = start; i < end; i++)
   list.push(this.GetDataItemIDPrefix() + i);
  if(list.length > 0)
   ASPx.AddHoverItems(this.name, [ [ [this.rowHotTrackStyle[0]], [this.rowHotTrackStyle[1]],  list ] ]);
 },
 OnContextMenuClick: function(e) {
  var showDefaultMenu = ASPx.EventStorage.getInstance().Load(e);
  if(showDefaultMenu)
   return showDefaultMenu;
  if(this.IsDetailGrid())
   ASPx.EventStorage.getInstance().Save(e, true);
  var args = this.GetContextMenuArgs(e);
  if(!args.objectType && !this.HasAnyContextMenu())
   return true;
  var menu = this.GetPreparedContextMenu(args);
  var showBrowserMenu = !menu && this.ContextMenu.IsEmpty();
  showBrowserMenu = this.RaiseContextMenu(args.objectType, args.index, e, menu, showBrowserMenu);
  if(menu && !showBrowserMenu) {
   this.ShowContextMenu(e, menu);
   return false;
  }
  return showBrowserMenu;
 },
 ShowContextMenu: function(mouseEvent, menu) {
  this.contextMenuActivating = true;
  this.HandleContextMenuHover(menu, mouseEvent);
  menu.ShowInternal(mouseEvent);
 },
 HandleContextMenuHover: function(menu, mouseEvent) {
  if(this.rowHotTrackStyle == null)
   return;
  this.activeContextMenu = menu;
  this.sourceContextMenuRow = this.getItemByHtmlEvent(mouseEvent);
  menu.CloseUp.AddHandler(function(s) { this.OnContextMenuCloseUp(s); }.aspxBind(this));
  ASPx.AddAfterClearHoverState( function(source, args) { this.OnClearHoverState(args.item, args.element, args.toElement); }.aspxBind(this));
 },
 OnClearHoverState: function(hoverItem, hoverElement, newHoverElement) {
  if(!this.activeContextMenu || !this.activeContextMenu.GetVisible() || !this.sourceContextMenuRow) {
   ASPx.RemoveClassNameFromElement(hoverElement, this.rowHotTrackStyle[0]);
   return;
  }
  if(this.sourceContextMenuRow.id === hoverElement.id) {
   var newHoverItem = hoverItem.Clone();
   newHoverItem.Apply(hoverElement);
  }
 },
 OnContextMenuCloseUp: function(e) {
  if(!this.sourceContextMenuRow || this.activeContextMenu.GetVisible()) return;
  var stateController = ASPx.GetStateController();
  if(!stateController) return;
  if(stateController.currentHoverElement !== this.sourceContextMenuRow)
   stateController.DoClearHoverState(this.sourceContextMenuRow, null);
  this.sourceContextMenuRow = null;
  this.activeContextMenu = null;
 },
 HasAnyContextMenu: function() {
  return this.GetGroupPanelContextMenu() || this.GetColumnContextMenu() || this.GetRowContextMenu() || this.GetFooterContextMenu();
 },
 GetPreparedContextMenu: function(args) { 
  var menuName = this.name + "_DXContextMenu_";
  var menu = null;
  switch(args.objectType) {
   case "grouppanel":
    menu = this.GetGroupPanelContextMenu();
    break;
   case "header":
   case "emptyheader":
    menu = this.GetColumnContextMenu();
    break;
   case "row":
   case "grouprow":
   case "emptyrow":
    menu = this.GetRowContextMenu();
    break;
   case "footer":
    menu = this.GetFooterContextMenu();
    break;
  }
  if(menu)
   this.ActivateContextMenuItems(menu, args);
  return menu;
 },
 GetContextMenuArgs: function(e) {
  var objectTypes = this.GetContextMenuObjectTypes();
  var src = ASPx.Evt.GetEventSource(e);
  var element = src;
  while(element && element.tagName !== "BODY") {
   var id = element.id;
   element = element.parentNode;
   if(!id) continue;
   var indexInfo = this.tryGetNumberFromEndOfString(id);
   var index = indexInfo.success ? indexInfo.value : "";
   for(var partialID in objectTypes) {
    if(id == partialID + index) {
     var type = objectTypes[partialID];
     if(type == "footer") {
      index = this.GetFooterCellIndex(src);
      if(!ASPx.IsExists(index))
       return { objectType: null, index: -1 };
     } else if(type == "emptyheader" || type == "grouppanel" || type == "emptyrow") {
      index = this.EmptyElementIndex;
     }
     return { objectType: type, index: index };
    }
   }
  }
  return { objectType: null, index: -1 };
 },
 GetContextMenuObjectTypes: function(){
  return { };
 },
 GetFooterCellIndex: function(element) {
  var footerRowName = this.name + "_" + this.FooterRowID;
  while(element.parentNode.id !== footerRowName) {
   if(element.tagName == "BODY")
    return -1;
   element = element.parentElement;
  }
  var matrix = this.GetHeaderMatrix();
  var leafIndex = element.cellIndex - this.GetFooterIndentCount(element.parentNode); 
  return matrix.GetLeafIndices()[leafIndex];
 },
 GetFooterIndentCount: function(footerElement) {
  return ASPx.GetChildNodesByClassName(footerElement, "dxgvIndentCell").length;
 },
 ActivateContextMenuItems: function(menu, args) {
  menu.elementInfo = args;
  this.SyncMenuItemsInfoSettings(menu, args.index, menu.cpItemsInfo);
 },
 SyncMenuItemsInfoSettings: function(menu, groupElementIndex, itemsInfo) {
  for(var i = 0; i < menu.GetItemCount() ; ++i) {
   var item = menu.GetItem(i);
   var itemInfo = itemsInfo[item.indexPath];
   var visible = false, enabled = false, checked = false;
   visible = this.GetItemServerState(itemInfo[0], groupElementIndex);
   enabled = this.GetItemServerState(itemInfo[1], groupElementIndex);
   checked = this.GetItemServerState(itemInfo[2], groupElementIndex);
   if(item.name === this.ContextMenuItems.ShowCustomizationWindow)
    checked = this.IsCustomizationWindowVisible();
   item.SetVisible(visible);
   this.SetContextMenuItemEnabled(item, enabled);
   item.SetChecked(checked);
   if(visible && enabled && !checked)
    this.SyncMenuItemsInfoSettings(item, groupElementIndex, itemsInfo);
  }
 },
 SetContextMenuItemEnabled: function(item, enabled) {
  item.SetEnabled(enabled);
  var imageElement = item.GetImage();
  if(!ASPx.IsExists(imageElement))
   return;
  var itemImageClassName = this.FindContextMenuItemImageClass(imageElement);
  if(!itemImageClassName)
   return;
  var imageEnabled = itemImageClassName.indexOf("Disabled") == -1;
  if(enabled) {
   if(!imageEnabled)
    this.UpdateContextMenuImageClass(imageElement, itemImageClassName, itemImageClassName.replace("Disabled", ""));
  } else if(imageEnabled) {
   this.DisableContextMenuImage(item, imageElement, itemImageClassName);
  }
 },
 DisableContextMenuImage: function(item, imageElement, itemImageClassName) {
  var oldClass = itemImageClassName;
  var postfix = "";
  var newClass = "";
  if(oldClass) {
   var portions = oldClass.split("_");
   var length = portions.length;
   if(length > 2) postfix = portions[--length];
   portions[length - 1] = portions[length - 1] + "Disabled";
   newClass = portions.join("_");
  } else {
   newClass = this.ContextMenuItemImageMask + item.name + "Disabled" + postfix;
  }
  this.UpdateContextMenuImageClass(imageElement, itemImageClassName, newClass);
 },
 UpdateContextMenuImageClass: function(imageElement, remove, add) {
  ASPx.RemoveClassNameFromElement(imageElement, remove);
  ASPx.AddClassNameToElement(imageElement, add);
 },
 FindContextMenuItemImageClass: function(imageElement) {
  var regExp = new RegExp(this.ContextMenuItemImageMask + "\\w+\\b");
  var itemImageClassName = imageElement.className.match(regExp);
  if(!itemImageClassName || !itemImageClassName.length)
   return null;
  return itemImageClassName[0];
 },
 GetContextMenuItemChecked: function(item) {
  var itemInfo = item.menu.cpItemsInfo[item.indexPath];
  var elementIndex = item.menu.elementInfo.index;
  return this.GetItemServerState(itemInfo[2], elementIndex);
 },
 GetItemServerState: function(itemInfo,
  groupElementIndex) {
  var saveVisible = !!itemInfo[0];
  var indices = itemInfo.length === 1 ? [ ] : itemInfo[1];
  return ASPx.Data.ArrayIndexOf(indices, groupElementIndex) > -1 ? saveVisible : !saveVisible;
 },
 OnContextMenuItemClick: function(e) {
  var elementInfo = e.item.menu.elementInfo;
  this.clickedMenuItem = e.item;
  if(this.RaiseContextMenuItemClick(e, elementInfo))
   return true;
  this.ProcessContextMenuItemClick(e);
 },
 ProcessContextMenuItemClick: function(e){
  var item = e.item;
  var elementInfo = item.menu.elementInfo;
  switch(item.name) {
   case this.ContextMenuItems.FullExpand:
    this.ExpandAll();
    break;
   case this.ContextMenuItems.FullCollapse:
    this.CollapseAll();
    break;
   case this.ContextMenuItems.SortAscending:
    this.SortBy(elementInfo.index, "ASC", false);
    break;
   case this.ContextMenuItems.SortDescending:
    this.SortBy(elementInfo.index, "DSC", false);
    break;
   case this.ContextMenuItems.ClearSorting:
    this.SortBy(elementInfo.index, "NONE", false);
    break;
   case this.ContextMenuItems.ShowFilterBuilder:
    this.ShowFilterControl();
    break;
   case this.ContextMenuItems.ShowFilterRow:
    this.ContextMenuShowFilterRow(!this.GetContextMenuItemChecked(item));
    break;
   case this.ContextMenuItems.ClearFilter:
    this.AutoFilterByColumn(this.GetColumn(elementInfo.index));
    break;
   case this.ContextMenuItems.ShowFilterRowMenu:
    this.ContextMenuShowFilterRowMenu(!this.GetContextMenuItemChecked(item));
    break;
   case this.ContextMenuItems.ShowGroupPanel:
    this.ContextMenuShowGroupPanel(!this.GetContextMenuItemChecked(item));
    break;
   case this.ContextMenuItems.ShowSearchPanel:
    this.ContextMenuShowSearchPanel(!this.GetContextMenuItemChecked(item));
    break;
   case this.ContextMenuItems.ShowCustomizationWindow:
    if(!this.IsCustomizationWindowVisible())
     this.ShowCustomizationWindow();
    else
     this.HideCustomizationWindow();
    break;
   case this.ContextMenuItems.ShowFooter:
    this.ContextMenuShowFooter(!this.GetContextMenuItemChecked(item));
    break;
   case this.ContextMenuItems.ExpandRow:
    this.ExpandRow(elementInfo.index);
    break;
   case this.ContextMenuItems.CollapseRow:
    this.CollapseRow(elementInfo.index);
    break;
   case this.ContextMenuItems.ExpandDetailRow:
    this.ExpandDetailRow(elementInfo.index);
    break;
   case this.ContextMenuItems.CollapseDetailRow:
    this.CollapseDetailRow(elementInfo.index);
    break;
   case this.ContextMenuItems.NewRow:
    this.AddNewItem();
    break;
   case this.ContextMenuItems.EditRow:
    this.ContextMenuStartEditItem(elementInfo.index, e.item.menu);
    break;
   case this.ContextMenuItems.DeleteRow:
    this.DeleteGridItem(elementInfo.index);
    break;
   case this.ContextMenuItems.Refresh:
    this.Refresh();
    break;
   case this.ContextMenuItems.HideColumn:
    var groupped = ASPx.IsExists(this.GetHeader(elementInfo.index, true));
    this.MoveColumn(elementInfo.index, -1, false, false, groupped);
    break;
   case this.ContextMenuItems.ShowColumn:
    this.MoveColumn(elementInfo.index, elementInfo.index);
    break;
   case this.ContextMenuItems.SummarySum:
    this.ContextMenuSetSummary(item, elementInfo.index, 0);
    break;
   case this.ContextMenuItems.SummaryMin:
    this.ContextMenuSetSummary(item, elementInfo.index, 1);
    break;
   case this.ContextMenuItems.SummaryMax:
    this.ContextMenuSetSummary(item, elementInfo.index, 2);
    break;
   case this.ContextMenuItems.SummaryCount:
    this.ContextMenuSetSummary(item, elementInfo.index, 3);
    break;
   case this.ContextMenuItems.SummaryAverage:
    this.ContextMenuSetSummary(item, elementInfo.index, 4);
    break;
   case this.ContextMenuItems.SummaryNone:
    this.ContextMenuClearSummary(elementInfo.index);
    break;
  }
 },
 ContextMenuStartEditItem: function(visibleIndex, menu) {
  var rowCells = this.GetRow(visibleIndex).children;
  var colIndex = -1;
  var menuLocationX = menu.GetMainElement().getBoundingClientRect().left;
  for(var i = 0; i < rowCells.length; ++i) {
   var cell = rowCells[i];
   if(cell.tagName !== "TD") continue;
   var cellRect = cell.getBoundingClientRect();
   if(cellRect.left > menuLocationX) break;
   if(menuLocationX > cellRect.left && menuLocationX < cellRect.right) {
    colIndex = i;
    break;
   }
  }
  this.StartEditItem(visibleIndex, colIndex);
 },
 RaiseContextMenuItemClick: function(e, itemInfo) {
  return false;
 },
 ProcessCustomContextMenuItemClick: function(item, usePostBack) {
  if(usePostBack) {
   this.clickedMenuItem = null;
   var menu = item.menu;
   this.gridPostBack([ASPxClientGridViewCallbackCommand.ContextMenu, "ItemClick", menu.cpType, item.indexPath, menu.elementInfo.index]);
  } else {
   this.gridCallBack([ASPxClientGridViewCallbackCommand.ContextMenu, ""]);
  }
 },
 ContextMenuShowGroupPanel: function(show) {
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ContextMenu, "ShowGroupPanel", show ? 1 : 0]);
 },
 ContextMenuShowSearchPanel: function(show) {
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ContextMenu, "ShowSearchPanel", show ? 1 : 0]);
 },
 ContextMenuShowFilterRow: function(show) {
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ContextMenu, "ShowFilterRow", show ? 1 : 0]);
 },
 ContextMenuShowFilterRowMenu: function(show) {
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ContextMenu, "ShowFilterRowMenu", show ? 1 : 0]);
 },
 ContextMenuShowFooter: function(show) {
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ContextMenu, "ShowFooter", show ? 1 : 0]);
 },
 ContextMenuClearGrouping: function() {
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ContextMenu, "ClearGrouping"]);
 },
 ContextMenuSetSummary: function(item, index, typeSummary) {
  var checkSummary = this.GetContextMenuItemChecked(item) ? 0 : 1;
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ContextMenu, "SetSummary", index, typeSummary, checkSummary]);
 }, 
 ContextMenuClearSummary: function(index) {
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ContextMenu, "ClearSummary", index]);
 },
 Focus: function() {
  if(this.kbdHelper)
   this.kbdHelper.Focus();
 },
 PerformCallback: function(args){
  if(!ASPx.IsExists(args)) args = "";
  this.gridCallBack([ASPxClientGridViewCallbackCommand.CustomCallback, args]);
 },
 GetValuesOnCustomCallback: function(args, onCallBack) {
  this.gridFuncCallBack([ASPxClientGridViewCallbackCommand.CustomValues, args], onCallBack);
 },
 GotoPage: function(pageIndex){
  if(this.useEndlessPaging)
   return;
  this.gridCallBack([ASPxClientGridViewCallbackCommand.GotoPage, pageIndex]);
 },
 GetPageIndex: function(){
  return this.pageIndex;
 },
 GetPageCount: function(){
  return this.pageCount;
 },
 NextPage: function(){
  this.gridCallBack([ASPxClientGridViewCallbackCommand.NextPage]);
 },
 PrevPage: function(focusBottomRow){
  if(!this.useEndlessPaging)
   this.gridCallBack([ASPxClientGridViewCallbackCommand.PreviousPage, focusBottomRow ? "T" : "F"]);
 },
 IsLastPage: function() {
  return this.pageIndex === this.pageCount - 1;
 },
 GetItemKey: function(visibleIndex) {
  var arrayIndex = visibleIndex - this.visibleStartIndex;
  if(arrayIndex < 0 || arrayIndex > this.keys.length - 1) 
   return null;
  var key = this.keys[arrayIndex];
  if(key == "/^DXN")
   key = null;
  return key;
 },   
 StartEditItem: function(visibleIndex, columnIndex) {
  var batchEditHelper = this.GetBatchEditHelper();
  if(batchEditHelper) {
   batchEditHelper.StartEditCell(visibleIndex, columnIndex);
  } else {
   var key = this.GetItemKey(visibleIndex);
   if(key != null)
    this.StartEditItemByKey(key);
  }
 },
 StartEditItemByKey: function(key) {
  var batchEditHelper = this.GetBatchEditHelper();
  if(batchEditHelper)
   batchEditHelper.StartEditItemByKey(key);
  else
   this.gridCallBack([ASPxClientGridViewCallbackCommand.StartEdit, key]);
 },
 IsEditing: function() { return this.editState > 0; },
 IsNewItemEditing: function() { return this.editState > 1; },
 IsEditingItem: function(visibleIndex) { return this.editItemVisibleIndex === visibleIndex; },
 IsNewRowAtBottom: function() { return this.editState == 3; },
 UpdateEdit: function(){
  this._updateEdit();
 },
 CancelEdit: function() {
  var batchEditHelper = this.GetBatchEditHelper();
  if(batchEditHelper)
   batchEditHelper.CancelEdit();
  else
   this.gridCallBack([ASPxClientGridViewCallbackCommand.CancelEdit]);
 },
 AddNewItem: function(){
  var batchEditHelper = this.GetBatchEditHelper();
  if(batchEditHelper)
   batchEditHelper.AddNewItem();
  else 
   this.gridCallBack([ASPxClientGridViewCallbackCommand.AddNewRow]);
 },
 DeleteItem: function(visibleIndex){
  var batchEditHelper = this.GetBatchEditHelper();
  if(batchEditHelper) {
   batchEditHelper.DeleteItem(visibleIndex);
  } else {
   var key = this.GetItemKey(visibleIndex);
   if(key != null)
    this.DeleteItemByKey(key);
  }
 },
 DeleteItemByKey: function(key) {
  var batchEditHelper = this.GetBatchEditHelper();
  if(batchEditHelper)
   batchEditHelper.DeleteItemByKey(key);
  else
   this.gridCallBack([ASPxClientGridViewCallbackCommand.DeleteRow, key]);
 },
 Refresh: function(){
  var batchEditHelper = this.GetBatchEditHelper();
  if(batchEditHelper)
   batchEditHelper.CancelEdit();
  this.gridCallBack([ASPxClientGridViewCallbackCommand.Refresh]);
 },
 ApplyFilter: function(expression){
  expression = expression || "";
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ApplyFilter, expression]);
 },
 ClearFilter: function () {
  this.ClearAutoFilterState();
  this.ApplyFilter();
 },
 GetAutoFilterEditor: function(column) { 
  var index = this._getColumnIndexByColumnArgs(column);
  if(!ASPx.IsExists(index)) return null;
  return ASPx.GetControlCollection().Get(this.name + "_DXFREditorcol" + index);
 },
 AutoFilterByColumn: function(column, val){
  var index = this._getColumnIndexByColumnArgs(column);
  if(!ASPx.IsExists(index)) return;
  if(!ASPx.IsExists(val)) val = "";  
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ApplyColumnFilter, index, val]);
 },
 ApplyHeaderFilterByColumn: function(){
  this.GetHeaderFilterPopup().Hide();
  var helper = this.GetHeaderFilterHelper();
  if(helper.column)
   this.gridCallBack([ASPxClientGridViewCallbackCommand.ApplyHeaderColumnFilter, helper.column.index, ASPx.Json.ToJson(helper.GetCallbackValue())]);
 },
 SortBy: function(column, sortOrder, reset, sortIndex){
  if(this.RaiseColumnSorting(this._getColumnObjectByArg(column))) return;
  column = this._getColumnIndexByColumnArgs(column);
  if(!ASPx.IsExists(sortIndex)) sortIndex = "";
  if(!ASPx.IsExists(sortOrder)) sortOrder = "";
  if(!ASPx.IsExists(reset)) reset = true;
  this.gridCallBack([ASPxClientGridViewCallbackCommand.Sort, column, sortIndex, sortOrder, reset]);
 },
 MoveColumn: function(column, columnMoveTo, moveBefore, moveToGroup, moveFromGroup){
  if(!ASPx.IsExists(column)) return;
  if(!ASPx.IsExists(columnMoveTo)) columnMoveTo = -1;
  if(!ASPx.IsExists(moveBefore)) moveBefore = true;
  if(!ASPx.IsExists(moveToGroup)) moveToGroup = false;
  if(!ASPx.IsExists(moveFromGroup)) moveFromGroup = false;
  if(moveToGroup) {
   if(this.RaiseColumnGrouping(this._getColumnObjectByArg(column))) return;
  }
  column = this._getColumnIndexByColumnArgs(column);
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ColumnMove, column, columnMoveTo, moveBefore, moveToGroup, moveFromGroup]);
 },
 IsCustomizationWindowVisible: function(){
  var custWindow = this.GetCustomizationWindow();
  return custWindow != null && custWindow.IsVisible();
 },
 ShowCustomizationWindow: function(showAtElement){
  var custWindow = this.GetCustomizationWindow();
  if(!custWindow) return;
  if(!showAtElement) showAtElement = this.GetMainElement();
  custWindow.ShowAtElement(showAtElement);
 },
 HideCustomizationWindow: function(){
  var custWindow = this.GetCustomizationWindow();
  if(custWindow != null) custWindow.Hide();
 },
 GetSelectedFieldValues: function(fieldNames, onCallBack) {
  this.gridFuncCallBack([ASPxClientGridViewCallbackCommand.SelFieldValues, fieldNames], onCallBack);
 },
 GetSelectedKeysOnPage: function() {
  var keys = [];
  for(var i = 0; i < this.pageRowCount; i++) {
   if(this._isRowSelected(this.visibleStartIndex + i))
    keys.push(this.keys[i]);
  }
  return keys; 
 },
 GetItemValues: function(visibleIndex, fieldNames, onCallBack) {
  this.gridFuncCallBack([ASPxClientGridViewCallbackCommand.RowValues, visibleIndex, fieldNames], onCallBack);
 },
 GetPageItemValues: function(fieldNames, onCallBack) {
  this.gridFuncCallBack([ASPxClientGridViewCallbackCommand.PageRowValues, fieldNames], onCallBack);
 },
 GetVisibleItemsOnPage: function() {
  var batchEditHelper = this.GetBatchEditHelper();
  if(batchEditHelper)
   return batchEditHelper.GetVisibleItemsOnPageCount();
  return this.pageRowCount;
 },
 GetTopVisibleIndex: function() {
  return this.visibleStartIndex;
 },
 GetColumnsCount: function() {
  return this.GetColumnCount();
 },
 GetColumnCount: function() {
  return this._getColumnCount();
 },
 GetColumn: function(index) {
  return this._getColumn(index);
 },
 GetColumnById: function(id) {
  return this._getColumnById(id);
 },
 GetColumnByField: function(fieldName) {
  return this._getColumnByField(fieldName);
 },
 GetEditor: function(column) {
  var columnObject = this._getColumnObjectByArg(column);
  return columnObject != null ? this.GetEditorByColumnIndex(columnObject.index) : null;
 },
 FocusEditor: function(column) {
  var editor = this.GetEditor(column);
  if(editor && editor.SetFocus) {
   editor.SetFocus();  
  }
 },
 GetEditValue: function(column) {
  var editor = this.GetEditor(column);
  return editor != null && editor.enabled ? editor.GetValue() : null;
 },
 SetEditValue: function(column, value) {
  var editor = this.GetEditor(column);
  if(editor != null && editor.enabled) {
   editor.SetValue(value);
  }
 },
 ShowFilterControl: function() {
  this.PreventCallbackAnimation();
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ShowFilterControl]);
 },
 CloseFilterControl: function() {
  this.PreventCallbackAnimation();
  this.HideFilterControlPopup();
  this.gridCallBack([ASPxClientGridViewCallbackCommand.CloseFilterControl]);
 },
 HideFilterControlPopup: function() {
  var popup = this.GetFilterControlPopup();
  if(popup) popup.Hide();
 },
 ApplyFilterControl: function() {
  this.PreventCallbackAnimation();
  var fc = this.GetFilterControl();
  if(fc == null) return;
  if(!this.callBacksEnabled)
   this.HideFilterControlPopup();
  if(!fc.isApplied)
   fc.Apply(this);
 },
 SetFilterEnabled: function(isFilterEnabled) {
  this.gridCallBack([ASPxClientGridViewCallbackCommand.SetFilterEnabled, isFilterEnabled]);
 },
 GetVerticalScrollPosition: function() { return 0; },
 SetVerticalScrollPosition: function(value) { },
 RaiseSelectionChangedOutOfServer: function() {
  this.RaiseSelectionChanged(-1, false, false, true);
 },
 RaiseSelectionChanged: function(visibleIndex, isSelected, isAllRecordsOnPage, isChangedOnServer) {
  if(!this.SelectionChanged.IsEmpty()){
   var args = this.CreateSelectionEventArgs(visibleIndex, isSelected, isAllRecordsOnPage, isChangedOnServer);
   this.SelectionChanged.FireEvent(this, args);
   if(args.processOnServer) {
    this.gridCallBack([ASPxClientGridViewCallbackCommand.Selection]);
   }
  }
  return false; 
 },
 CreateSelectionEventArgs: function(visibleIndex, isSelected, isAllRecordsOnPage, isChangedOnServer){
  return null;
 },
 RaiseFocusedItemChanged: function() { return false; },
 RaiseColumnSorting: function(column) {
  if(!this.ColumnSorting.IsEmpty()){
   var args = this.CreateColumnCancelEventArgs(column);
   this.ColumnSorting.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 CreateColumnCancelEventArgs: function(column){
  return null;
 },
 RaiseColumnGrouping: function(column) {
  return false; 
 },
 RaiseItemClick: function(visibleIndex, htmlEvent) {
  return false; 
 },
 RaiseItemDblClick: function(visibleIndex, htmlEvent) {
  return false; 
 },
 RaiseContextMenu: function(objectType, index, htmlEvent, menu, showBrowserMenu) {
  return false;
 },
 RaiseCustomizationWindowCloseUp: function() {
  if(!this.CustomizationWindowCloseUp.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.CustomizationWindowCloseUp.FireEvent(this, args);
  }
  return false; 
 },
 RaiseColumnMoving: function(targets) {
  return false;
 },
 RaiseBatchEditStartEditing: function(visibleIndex, column, rowValues) { return null; },
 RaiseBatchEditEndEditing: function(visibleIndex, rowValues) { return null; },
 RaiseBatchEditItemValidating: function(visibleIndex, validationInfo) { return null; },
 RaiseBatchEditConfirmShowing: function(requestTriggerID) { return false; },
 RaiseBatchEditTemplateCellFocused: function(columnIndex) { return false; },
 RaiseInternalCheckBoxClick: function(visibleIndex) {
  if(!this.InternalCheckBoxClick.IsEmpty()){
   var args = {"visibleIndex": visibleIndex, cancel: false};
   this.InternalCheckBoxClick.FireEvent(this, args);
   return args.cancel;
  }
  return false;
 },
 UA_AddNew: function() {
  this.AddNewItem();
 },
 UA_StartEdit: function(visibleIndex) {
  this.StartEditItem(visibleIndex);
 },
 UA_Delete: function(visibleIndex) {
  this.DeleteGridItem(visibleIndex);
 },
 UA_UpdateEdit: function() {
  this.UpdateEdit();
 },
 UA_CancelEdit: function() {
  this.CancelEdit();
 },
 UA_CustomButton: function(id, visibleIndex) {
  this.CommandCustomButton(id, visibleIndex);
 },
 UA_Select: function(visibleIndex) {
  if(!this.lookupBehavior || this.allowSelectByItemClick){
   var selected = this.allowSelectSingleRowOnly || !this._isRowSelected(visibleIndex);
   this.SelectItem(visibleIndex, selected);
  }
 },
 UA_ClearFilter: function() {
  this.ClearFilter();
 },
 UA_ApplyMultiColumnAutoFilter: function() {
  this.ApplyMultiColumnAutoFilter();
 },
 UA_ApplySearchFilter: function() {
  this.ApplySearchFilterFromEditor(this.GetSearchEditor());
 },
 UA_ClearSearchFilter: function() {
  var editor = this.GetSearchEditor();
  if(editor)
   editor.SetValue(null);
  this.ApplySearchFilterFromEditor(this.GetSearchEditor());
 },
 CalcCellStyle: function(styleType, cell) {
  var styleInfo = this.getItemStyleInfo(styleType);
  return { 
   className: cell.initialClassName + " " + styleInfo.css,
   cssText: cell.initialCssText + ";" + styleInfo.style
  };
 },
 ChangeCellInitialClass: function(cell, className, add) {
  if(!cell.initialClassName)
   return;
  var hasClass = cell.initialClassName.indexOf(className) > -1;
  if(hasClass && !add)
   cell.initialClassName = cell.initialClassName.replace(className, "");
  if(!hasClass && add)
   cell.initialClassName += " " + className;
 },
 SaveCellInitialStyle: function(cell) {
  if(!ASPx.IsExists(cell.initialClassName))
   cell.initialClassName = cell.className;
  if(!ASPx.IsExists(cell.initialCssText))
   cell.initialCssText = cell.style.cssText;
 },
 RestoreCellInitialStyle: function(cell) {
  if(ASPx.IsExists(cell.initialClassName))
   cell.className = cell.initialClassName;
  if(ASPx.IsExists(cell.initialCssText))
   cell.style.cssText = cell.initialCssText;
 }
});
ASPxClientGridBase.Cast = ASPxClientControl.Cast;
var ASPxClientGridColumnBase = ASPx.CreateClass(null, {
 constructor: function(name, index, fieldName, visible, allowSort, HFCheckedList) {
  this.name = name;
  this.id = name;
  this.index = index;
  this.fieldName = fieldName;
  this.visible = !!visible;
  this.allowSort = !!allowSort;
  this.HFCheckedList = !!HFCheckedList;
 }
});
var GridViewDragHelper = ASPx.CreateClass(null, {
 constructor: function(grid) {
  this.grid = grid;
 },
 CreateDrag: function(e, element, canDrag) {
  var drag = new ASPx.DragHelper(e, element, true);
  drag.centerClone = true;
  drag.canDrag = canDrag;  
  drag.grid = this.grid;
  drag.ctrl = e.ctrlKey;
  drag.shift = e.shiftKey;
  drag.onDragDivCreating = this.OnDragDivCreating;
  drag.onDoClick = this.OnDoClick;
  drag.onCloneCreating = this.OnCloneCreating;
  drag.onEndDrag = this.OnEndDrag;
  drag.onCancelDrag = this.OnCancelDrag;
  return drag;
 },
 PrepareTargetHeightFunc: function() {
  GridViewDragHelper.Target_GetElementHeight = null;
  var headerRowCount = this.grid.GetHeaderMatrix().GetRowCount();
  if(headerRowCount) {
   var row = this.grid.GetHeaderRow(headerRowCount - 1);
   var headerBottom = ASPx.GetAbsoluteY(row) + row.offsetHeight;
   GridViewDragHelper.Target_GetElementHeight = function() {
    return headerBottom - this.absoluteY;
   };
  }
 },
 CreateTargets: function(drag, e) {
  if(!drag.canDrag) return;
  var grid = this.grid;
  this.PrepareTargetHeightFunc();
  var targets = new ASPx.CursorTargets();
  targets.obj = drag.obj;
  targets.grid = grid;
  targets.onTargetCreated = this.OnTargetCreated;
  targets.onTargetChanging = this.OnTargetChanging;
  targets.onTargetChanged = this.OnTargetChanged;
  var scrollLeft = null, scrollRight;
  var scrollHelper = grid.GetScrollHelper();
  var scrollableControl = scrollHelper && scrollHelper.GetHorzScrollableControl();
  if(scrollableControl) {
   scrollLeft = ASPx.GetAbsoluteX(scrollableControl);
   scrollRight = scrollLeft + scrollableControl.offsetWidth;
  }
  var sourceColumn = grid.getColumnObject(drag.obj.id);
  var win = grid.GetCustomizationWindow();
  if(win && !sourceColumn.inCustWindow)
   this.AddDragDropTarget(targets, win.GetWindowClientTable(-1));
  for(var i = 0; i < grid.columns.length; i++) {
   var column = grid.columns[i];
   for(var grouped = 0; grouped <= 1; grouped++) {
    var targetElement = grid.GetHeader(column.index, !!grouped);
    if(!targetElement)
     continue;
    if(scrollLeft !== null) {
     var targetX = ASPx.GetAbsoluteX(targetElement);
     if(targetX < scrollLeft || targetX + targetElement.offsetWidth > scrollRight)
      continue;
    }
    if(this.IsValidColumnDragDropTarget(drag.obj, targetElement, sourceColumn, column))
     this.AddDragDropTarget(targets, targetElement);  
   }
  }
  this.AddAdaptivePanelTarget(targets, grid.GetAdaptiveHeaderPanel());
  this.AddAdaptivePanelTarget(targets, grid.GetAdaptiveGroupPanel());
  this.AddDragDropTarget(targets, grid.GetGroupPanel());
  this.AddDragDropTarget(targets, ASPx.GetElementById(grid.name + this.grid.EmptyHeaderSuffix));
 },
 IsValidColumnDragDropTarget: function(sourceElement, targetElement, sourceColumn, targetColumn) {
  if(sourceColumn == targetColumn)
   return false;
  if(sourceColumn.parentIndex == targetColumn.parentIndex)
   return true;
  if(sourceColumn.parentIndex == targetColumn.index) {
   return (sourceColumn.inCustWindow || this.IsGroupingTarget(sourceElement))
    && this.grid.GetHeaderMatrix().IsLeaf(targetColumn.index);
  }
  if(this.IsGroupingTarget(targetElement))
   return true;
  if(this.IsValidAdaptiveTarget(sourceElement, targetElement, sourceColumn, targetColumn))
   return true;
  return false;
 },
 AddAdaptivePanelTarget: function(targets, panel) {
  if(!panel) return;
  this.AppendAdaptivePanelDragAreas(targets, panel);
  this.AddDragDropTarget(targets, panel);
 },
 AppendAdaptivePanelDragAreas: function(targets, panel) {
  panel.dragAreas = [ ];
  var headers = ASPx.GetNodesByPartialClassName(panel, this.grid.HeaderCellCssClass);
  if(headers.length === 0) 
   return;
  var rows = [ ];
  var row = [ headers[0] ];
  rows.push(row);
  for(var i = 0; i < headers.length - 1; i++) {
   var currentHeader = headers[i];
   var nextHeader = headers[i + 1];
   if(ASPx.GetAbsoluteY(currentHeader) !== ASPx.GetAbsoluteY(nextHeader)) {
    row = [ ];
    rows.push(row);
   }
   row.push(nextHeader);
  }
  for(var i = 0; i < rows.length; i++) {
   var row = rows[i];
   this.CreateDragArea(panel, row[0], targets, true);
   this.CreateDragArea(panel, row[row.length - 1], targets,  false);
  }
 },
 CreateDragArea: function(panel, target, targets, isLeft) {
  if(!this.ContainsTarget(targets, target)) 
   return; 
  var targetTop = ASPx.GetAbsolutePositionY(target);
  var area = { 
   target: target,
   isLeft: isLeft,
   top: targetTop,
   bottom: targetTop + target.offsetHeight,
   left: isLeft ? ASPx.GetAbsolutePositionX(panel) : ASPx.GetAbsolutePositionX(target) + target.offsetWidth,
   right: isLeft ? ASPx.GetAbsolutePositionX(target) :  ASPx.GetAbsolutePositionX(panel) + panel.offsetWidth
  };
  panel.dragAreas.push(area);
 },
 ContainsTarget: function(targets, target) {
  for(var i = 0; i < targets.list.length; i++) {
   if(targets.list[i].element == target)
    return true;
  }
  return false;
 },
 IsValidAdaptiveTarget: function(sourceElement, targetElement, sourceColumn, targetColumn) {
  this.EnsureAdaptiveTargetInfo(sourceElement, targetElement, sourceColumn, targetColumn);
  return !!targetElement.adaptiveInfo;
 },
 EnsureAdaptiveTargetInfo: function(sourceElement, targetElement, sourceColumn, targetColumn) {
  if(!this.IsAdaptiveHeaderTarget(targetElement))
   return;
  var matrix = this.grid.GetHeaderMatrix();
  var sourceLevel = matrix.GetColumnLevel(sourceColumn.index);
  var targetLevel = matrix.GetColumnLevel(targetColumn.index);
  targetElement.adaptiveInfo = null;
  if(targetLevel < 0 || sourceLevel >= targetLevel)
   return;
  var brother = this.FindColumnBrother(sourceColumn, targetColumn);
  if(!brother) 
   return;
  var leftLeaf = matrix.GetLeaf(brother.index, true);
  var rightLeaf = matrix.GetLeaf(brother.index, false);  
  if(targetColumn.index === leftLeaf || targetColumn.index === rightLeaf)
   targetElement.adaptiveInfo = { brotherIndex : brother.index, brotherHasOnlyOneLeaf: leftLeaf == rightLeaf, isLeftLeaf: targetColumn.index == leftLeaf };
 },
 FindColumnBrother: function(sourceColumn, targetColumn) {
  while(targetColumn && targetColumn.parentIndex !== sourceColumn.parentIndex)
   targetColumn = this.grid.GetColumn(targetColumn.parentIndex);
  return targetColumn;
 },
 AddDragDropTarget: function(targets, element) {
  element && targets.addElement(element);
 },
 IsAdaptiveHeaderPanelVisible: function() { return ASPx.IsElementDisplayed(this.grid.GetAdaptiveHeaderPanel()) },
 IsAdaptiveGroupPanelVisible: function() { return ASPx.IsElementDisplayed(this.grid.GetAdaptiveGroupPanel()) },
 IsDataHeaderTarget: function(element) { return element && element.id.indexOf(this.grid.name + "_col") == 0; },
 IsAdaptiveHeaderTarget: function(element) { return this.IsAdaptiveHeaderPanelVisible() && this.IsDataHeaderTarget(element) && element.adaptiveMoved; },
 IsAdaptivePanelTarget: function(element) { return element && (element == this.grid.GetAdaptiveHeaderPanel() || element == this.grid.GetAdaptiveGroupPanel()); },
 IsAdaptiveGroupHeaderTarget: function(element) { return this.IsAdaptiveGroupPanelVisible && this.IsGroupHeaderTarget(element) && element.adaptiveMoved; },
 IsGroupHeaderTarget: function(element) {
  if(!element)
   return false;
  return element.id.indexOf(this.grid.name + "_groupcol") == 0;
 },
 IsGroupingTarget: function(element) { 
  return element == this.grid.GetGroupPanel() || this.IsGroupHeaderTarget(element) || element ==  this.grid.GetAdaptiveGroupPanel();
 },
 IsCustWindowTarget: function(element) {
  var win = this.grid.GetCustomizationWindow();
  return win && element == win.GetWindowClientTable(-1); 
 },
 OnDragDivCreating: function(drag, dragDiv) {
  var rootTable = drag.grid.GetRootTable();
  if(!dragDiv || !rootTable) return;
  dragDiv.className = rootTable.className;
  dragDiv.style.cssText = rootTable.style.cssText;
 },
 OnDoClick: function(drag) {
  window.setTimeout(function() {
   if(drag.grid.contextMenuActivating) {
    drag.grid.contextMenuActivating = false;
    return;
   }
   if(!drag.grid.canSortByColumn(drag.obj) || drag.grid.InCallback() && drag.grid.GetWaitedFuncCallbackCount() === 0) 
    return;
   drag.grid.SortBy(drag.grid.getColumnIndex(drag.obj.id), drag.ctrl ? "NONE" : "", !drag.shift && !drag.ctrl);
  }, 0);
 },
 OnCancelDrag: function(drag) {
  drag.grid.dragHelper.ChangeTargetImagesVisibility(false);
 },
 OnEndDrag: function(drag) {
  if(!drag.targetElement)
   return;
  var grid = drag.grid;
  var sourceElement = drag.obj;
  var targetElement = drag.targetElement;
  var sourceIndex = grid.getColumnIndex(sourceElement.id);
  var targetIndex =  grid.getColumnIndex(targetElement.id);
  var isLeft = drag.targetTag;
  if(grid.IsEmptyHeaderID(targetElement.id) || targetElement == grid.GetAdaptiveHeaderPanel())
   targetIndex = 0;
  if(grid.dragHelper.IsAdaptiveHeaderTarget(targetElement) && targetElement.adaptiveInfo) {
   targetIndex = targetElement.adaptiveInfo.brotherIndex;
   isLeft = !targetElement.adaptiveInfo.brotherHasOnlyOneLeaf ? targetElement.adaptiveInfo.isLeftLeaf : isLeft;
  }
  if(grid.rtl)
   isLeft = !isLeft;
  grid.MoveColumn(
   sourceIndex,
   targetIndex,
   isLeft,
   grid.dragHelper.IsGroupingTarget(targetElement),
   grid.dragHelper.IsGroupingTarget(sourceElement)
  );
 },
 OnCloneCreating: function(clone) {
  var table = document.createElement("table");
  table.cellSpacing = 0;
  if(this.obj.offsetWidth > 0)
   table.style.width = Math.min(200, this.obj.offsetWidth) + "px";
  if(this.obj.offsetHeight > 0)
   table.style.height = this.obj.offsetHeight + "px";
  var row = table.insertRow(-1);
  clone.style.borderLeftWidth = "";
  clone.style.borderTopWidth = "";
  clone.style.borderRightWidth = "";
  row.appendChild(clone);
  table.style.opacity = 0.80;
  table.style.filter = "alpha(opacity=80)"; 
  if(ASPx.IsElementRightToLeft(this.obj))
   table.dir = "rtl";
  return table;
 },
 OnTargetCreated: function(targets, targetObj) {
  var f = GridViewDragHelper.Target_GetElementHeight;
  var h = targets.grid.dragHelper;
  var el = targetObj.element;
  if(f && !h.IsCustWindowTarget(el) && !h.IsGroupingTarget(el) && !h.IsAdaptiveHeaderTarget(el) && !h.IsAdaptivePanelTarget(el))
   targetObj.GetElementHeight = f;
 },
 OnTargetChanging: function(targets) {
  if(!targets.targetElement)
   return;
  targets.targetTag = targets.isLeftPartOfElement();
  var grid = targets.grid;
  var grouping = false;
  if(targets.targetElement == grid.GetGroupPanel() || targets.targetElement == grid.GetAdaptiveGroupPanel()) {
   targets.targetTag = true;
   grouping = true;
  }  
  if(grid.dragHelper.IsGroupHeaderTarget(targets.targetElement)) {
   grouping = true;
  }
  if(grouping && !grid.canGroupByColumn(targets.obj))
   targets.targetElement = null;
   if(grid.dragHelper.IsAdaptivePanelTarget(targets.targetElement)) {
   var info = grid.dragHelper.GetAdaptivePanelTargetInfo(targets, targets.targetElement);
   targets.targetTag = info.isLeftSide;
   targets.targetElement = info.targetElement;
   targets.skipNeighbor = true;
  }
  if(targets.targetElement) {
   grid.RaiseColumnMoving(targets);
  }
 },
 GetAdaptivePanelTargetInfo: function(targets, panel) {
  var x = targets.x;
  var y = targets.y;
  for(var i = 0; i < panel.dragAreas.length; i++) {
   var dragArea = panel.dragAreas[i];
   if(x >= dragArea.left && x <= dragArea.right && y >= dragArea.top && y <= dragArea.bottom)
    return { targetElement: dragArea.target, isLeftSide: dragArea.isLeft };
  }
  return { targetElement: panel.children.length == 0 ? panel : null, isLeftSide: true };
 },
 OnTargetChanged: function(targets) {
  if(ASPx.currentDragHelper == null)
   return;
  var element = targets.targetElement;
  if(element == ASPx.currentDragHelper.obj)
   return;
  var grid = targets.grid;
  grid.dragHelper.ChangeTargetImagesVisibility(false);
  if(!element) {
   ASPx.currentDragHelper.targetElement = null;
   return;
  }
  ASPx.currentDragHelper.targetElement = element;
  ASPx.currentDragHelper.targetTag = targets.targetTag;
  var moveToGroup = grid.dragHelper.IsGroupingTarget(element);
  var moveToCustWindow = grid.dragHelper.IsCustWindowTarget(element);
  if(moveToCustWindow) {
   ASPx.currentDragHelper.addElementToDragDiv(grid.GetArrowDragFieldImage());
   return;
  }
  var info = grid.dragHelper.GetTargetChangedInfo(targets, moveToGroup);
  if(!info) {
   ASPx.currentDragHelper.targetElement = null;
   return;
  }
  var targetColumnIndex = info.targetColumnIndex;
  var isRightSide = info.isRightSide;
  var neighbor = targets.skipNeighbor ? null : info.neighbor;
  var left = ASPx.GetAbsoluteX(element);
  if(element == grid.GetGroupPanel() || element == grid.GetAdaptiveHeaderPanel() || element == grid.GetAdaptiveGroupPanel()) {
   if(grid.rtl)
    left += element.offsetWidth;
  } else {
   if(isRightSide) {
    if(neighbor)
     left = ASPx.GetAbsoluteX(neighbor);
    else
     left += element.offsetWidth;
   }
  }
  var bottomElement = element;
  if(!moveToGroup && targetColumnIndex > -1)
   bottomElement = grid.GetHeader(grid.GetHeaderMatrix().GetLeaf(targetColumnIndex, !isRightSide, false));
  grid.dragHelper.SetDragImagesPosition(left, ASPx.GetAbsoluteY(element),  ASPx.GetAbsoluteY(bottomElement) + bottomElement.offsetHeight);
  grid.dragHelper.ChangeTargetImagesVisibility(true);
 },
 GetTargetChangedInfo: function(targets, moveToGroup) {
  var grid = targets.grid;
  var targetElement = targets.targetElement;
  var info = { 
   targetColumnIndex: grid.getColumnIndex(targetElement.id), 
   isRightSide: !targets.targetTag,
   neighbor: null
  };
  var matrix =  grid.GetHeaderMatrix();
  if(moveToGroup) {
   var method = info.isRightSide ^ grid.rtl ? "nextSibling" : "previousSibling";
   info.neighbor = grid.dragHelper.GetGroupNodeNeighbor(targetElement, method);
   if(info.neighbor && info.neighbor.id == ASPx.currentDragHelper.obj.id)
    return;
   return info;
  } 
  var isAdaptiveHeader = grid.dragHelper.IsAdaptiveHeaderTarget(targetElement);
  if(!isAdaptiveHeader && info.targetColumnIndex < 0)
   return info;
  if(isAdaptiveHeader && targetElement.adaptiveInfo) {
   info.targetColumnIndex = targetElement.adaptiveInfo.brotherIndex;
   info.isRightSide = !targetElement.adaptiveInfo.brotherHasOnlyOneLeaf ? !targetElement.adaptiveInfo.isLeftLeaf : info.isRightSide;
  }
  var method = info.isRightSide ^ grid.rtl ? "GetRightNeighbor" : "GetLeftNeighbor";
  var neighborIndex = matrix[method](info.targetColumnIndex, !isAdaptiveHeader);
  var sourceColumn = grid.getColumnObject(ASPx.currentDragHelper.obj.id);
  if(neighborIndex == sourceColumn.index && !sourceColumn.inCustWindow && !grid.dragHelper.IsGroupHeaderTarget(ASPx.currentDragHelper.obj))
   return;
  if(!isNaN(neighborIndex)){
   if(isAdaptiveHeader && !matrix.IsLeaf(neighborIndex))
    neighborIndex = matrix.GetLeaf(neighborIndex, info.isRightSide);
   info.neighbor = grid.GetHeader(neighborIndex);
  }
  return info;
 },
 GetGroupNodeNeighbor: function(element, method) {
  if(this.IsAdaptiveGroupHeaderTarget(element)) 
   return this.GetAdaptiveGroupNodeNeighbor(element, method);
  return this.GetGroupNodeNeighborCore(element, method, 2);
 },
 GetAdaptiveGroupNodeNeighbor: function(element, method) {   
  var headers = ASPx.GetNodesByPartialClassName(this.grid.GetAdaptiveGroupPanel(), this.grid.HeaderCellCssClass);
  var index = ASPx.Data.ArrayIndexOf(headers, element);
  if(index < 0) return null;   
  return method == "nextSibling" ? headers[index + 1] : headers[index - 1];
 },
 GetGroupNodeNeighborCore: function(element, method, distance) {
  var neighbor = element[method];
  if(neighbor && neighbor.nodeType == 1) {
   if(this.IsGroupingTarget(neighbor)) 
    return neighbor;
   if(distance > 1)
    return this.GetGroupNodeNeighborCore(neighbor, method, --distance);
  }
  return null;
 },
 ChangeTargetImagesVisibility: function(vis) {
  if(this.grid.GetArrowDragDownImage() == null) return;
  var value = vis ? "visible" : "hidden";
  this.grid.GetArrowDragDownImage().style.visibility = value;
  this.grid.GetArrowDragUpImage().style.visibility = value;
  if(ASPx.currentDragHelper != null) {
   ASPx.currentDragHelper.removeElementFromDragDiv();
  }
 },
 SetDragImagesPosition: function(left, top, bottom) {
  var downImage = this.grid.GetArrowDragDownImage();
  if(downImage) {
   ASPx.SetAbsoluteX(downImage, left - downImage.offsetWidth / 2);
   ASPx.SetAbsoluteY(downImage, top - downImage.offsetHeight);
  }
  var upImage = this.grid.GetArrowDragUpImage();
  if(upImage) {
   ASPx.SetAbsoluteX(upImage, left - upImage.offsetWidth / 2);
   ASPx.SetAbsoluteY(upImage, bottom);
  }
 }
});
GridViewDragHelper.Target_GetElementHeight = null;
ASPxClientGridBase.SelectStartHandler = function(e) {
 if(ASPx.Evt.GetEventSource(e).tagName.match(/input|select|textarea/i))
  return;
 if(e.ctrlKey || e.shiftKey) {
  ASPx.Selection.Clear();
  ASPx.Evt.PreventEventAndBubble(e);
 }
};
ASPxClientGridBase.SaveActiveElementSettings = function(grid) {
 var element = grid.activeElement;
 grid.activeElement = null;
 ASPxClientGridBase.activeElementData = null;
 if (!element || !element.id || element.tagName != "INPUT" || !(ASPx.GetIsParent(grid.GetMainElement(), element) || element.id.indexOf(grid.name + "_") == 0))
  return;  
 ASPxClientGridBase.activeElementData = [ grid.name, element.id, ASPx.Selection.GetInfo(element).endPos ];
 if(typeof(Sys) != "undefined" && typeof(Sys.Application) != "undefined") {
  if(!ASPxClientGridBase.MsAjaxActiveElementHandlerAdded) {
   Sys.Application.add_load(function() { ASPxClientGridBase.RestoreActiveElementSettings(); } );
   ASPxClientGridBase.MsAjaxActiveElementHandlerAdded = true;
  }
 } 
};
ASPxClientGridBase.RestoreActiveElementSettings = function(grid) {
 var data = ASPxClientGridBase.activeElementData;
 if(!data || grid && data[0] != grid.name) return;
 var element = ASPx.GetElementById(data[1]);
 if(element) {
  window.setTimeout(function() {
   element.focus();
   ASPx.Selection.Set(element, data[2], data[2]);
  }, 0);
 }
 ASPxClientGridBase.activeElementData = null;
};
var ASPxClientGridItemStyle = {
 Item: "items",
 Selected: "sel",
 FocusedItem: "fi",
 FocusedGroupItem: "fgi",
 ErrorItemHtml: "ei",
 BatchEditCell: "bec",
 BatchEditModifiedCell: "bemc",
 BatchEditMergedModifiedCell: "bemergmc"
};
var ASPxClientGridHeaderFilterHelper = ASPx.CreateClass(null, {
 constructor: function(grid){
  this.grid = grid;
  this.column = null;
  this.initSelectedIndices = [];
  this.initCalendarDates = {};
  this.initDateRangePickerRange = [];
  this.FilterMenuID = "HFFM";
  this.FilterMenuPostfix = "_" + this.FilterMenuID + "_GCTC";
 },
 GetPopup: function() { return this.grid.GetHeaderFilterPopup(); },
 GetSelectAllCheckBox: function() { return ASPx.GetControlCollection().Get(this.grid.name + "_HFSACheckBox"); },
 GetListBox: function() { return ASPx.GetControlCollection().Get(this.grid.name + "_HFListBox"); },
 GetCalendar: function(){ return ASPx.GetControlCollection().Get(this.grid.name + "_HFC"); },
 GetHeaderFilterFromDateEdit: function() { return ASPx.GetControlCollection().Get(this.grid.name + "_HFFDE"); },
 GetHeaderFilterToDateEdit: function() { return ASPx.GetControlCollection().Get(this.grid.name + "_HFTDE"); },
 GetFilterValuesSeparatorClassName: function() { return this.grid.GetCssClassNamePrefix() + "HFSD"; },
 OnFilterPopupCallback: function(values) {
  var grid = ASPx.GetControlCollection().Get(values[0]);
  if(!grid) return;
  var helper = grid.GetHeaderFilterHelper();
  helper.GetPopup().SetContentHtml(values[1], grid.enableCallbackAnimation);
  ASPx.GetControlCollection().ControlsInitialized.AddHandler(helper.OnControlsInitialized, helper);
 },
 OnControlsInitialized: function(){
  this.Initialize();
  ASPx.GetControlCollection().ControlsInitialized.RemoveHandler(this.OnControlsInitialized, this);
 },
 Initialize: function(){
  this.initSelectedIndices = [];
  this.initCalendarDates = {};
  this.initDateRangePickerRange = [];
  var columnIndex = this.grid.FindColumnIndexByHeaderChild(this.GetPopup().GetCurrentPopupElement());
  this.column = this.grid.GetColumn(columnIndex);
  this.InitializeListBox();
  this.InitializeSelectAllCheckBox();
  this.InitializeCalendar();
  this.InitializeDateRangePicker();
 },
 InitializeListBox: function() {
  var listBox = this.GetListBox();
  if(!this.RenderExistsOnPage(listBox))
   return;
  this.initSelectedIndices = listBox.GetSelectedIndices();
  var element = listBox.GetListTable ? listBox.GetListTable() : listBox.GetMainElement();
  ASPx.Evt.AttachEventToElement(element, "mousedown", function() { window.setTimeout(ASPx.Selection.Clear, 0); });
  listBox.SelectedIndexChanged.AddHandler(function(s) { this.OnListBoxSelectionChanged(s); }.aspxBind(this));
  if(listBox.cpFSI)
   this.PrepareSeparators(listBox);
 },
 PrepareSeparators: function(listBox) {
  if(this.IsASPxClientListBox(listBox))
   GridHFListBoxWrapper.Initialize(listBox);
  for(var i = 0; i < listBox.cpFSI.length; i++) {
   var separatorIndex = listBox.cpFSI[i];
   var item = listBox.GetItemElement(separatorIndex);
   if(ASPx.IsExists(item)) {
    var tr = ASPx.GetParentByTagName(item, "TR");
    this.AppendSeparatorRow(tr);
   }
  }
 },
 IsASPxClientListBox: function(control){
  return typeof(ASPxClientListBox) != "undefined" && control instanceof ASPxClientListBox;
 },
 AppendSeparatorRow: function(targetRow){
  var newTr = document.createElement("TR");
  ASPx.InsertElementAfter(newTr, targetRow);
  var td = document.createElement("TD");
  var colSpan = this.GetColSpanSum(targetRow);
  if(colSpan > 1)
   td.colSpan = colSpan;
  newTr.appendChild(td);
  var separatorDiv = document.createElement("DIV");
  separatorDiv.className = this.GetFilterValuesSeparatorClassName();
  td.appendChild(separatorDiv);
 },
 GetColSpanSum: function(tableRow){
  var colSpan = 0;
  var cells = ASPx.GetChildNodesByTagName(tableRow, "TD");
  for(var i = 0; i < cells.length; i++){
   colSpan += cells[i].colSpan;
  }
  return colSpan;
 },
 InitializeSelectAllCheckBox: function(){
  var checkBox = this.GetSelectAllCheckBox();
  if(this.RenderExistsOnPage(checkBox))
   checkBox.CheckedChanged.AddHandler(function(s){ this.OnSelectAllCheckedChanged(s); }.aspxBind(this));
 },
 InitializeCalendar: function() {
  var calendar = this.GetCalendar();
  if(this.RenderExistsOnPage(calendar))
   this.initCalendarDates = calendar.GetSelectedDates();
 },
 InitializeDateRangePicker: function(){
  var fromDateEdit = this.GetHeaderFilterFromDateEdit();
  var toDateEdit = this.GetHeaderFilterToDateEdit();
  if(!this.RenderExistsOnPage(toDateEdit) || !this.RenderExistsOnPage(toDateEdit))
   return;
  var fromDECaptionCell = fromDateEdit.GetCaptionCell();
  var toDECaptionCell = toDateEdit.GetCaptionCell();
  var width = Math.max(ASPx.GetClearClientWidth(fromDECaptionCell), ASPx.GetClearClientWidth(toDECaptionCell));
  fromDECaptionCell.style.minWidth = width + "px";
  toDECaptionCell.style.minWidth = width + "px";
  fromDateEdit.ValueChanged.AddHandler(function(){ this.OnDateRangePickerValueChanged(); }.aspxBind(this));
  toDateEdit.ValueChanged.AddHandler(function(){ this.OnDateRangePickerValueChanged(); }.aspxBind(this));
  this.initDateRangePickerRange.start = fromDateEdit.GetValue();
  this.initDateRangePickerRange.end = toDateEdit.GetValue();
 },
 InitializeCalendar: function(){
  var calendar = this.GetCalendar();
  if(calendar){
   calendar.SelectionChanged.AddHandler(function(s) { this.OnCalendarSelectionChanged(s); }.aspxBind(this));
   this.initCalendarDates = calendar.GetSelectedDates();
  }
 },
 OnSelectAllCheckedChanged: function(checkBox){
  var listBox = this.GetListBox();
  if(checkBox.GetChecked())
   listBox.SelectAll();
  else
   listBox.UnselectAll();
  this.UpdateOkButtonEnabledState();
 },
 OnListBoxSelectionChanged: function(){
  if(!this.column) return;
  if(!this.column.HFCheckedList) {
   this.grid.ApplyHeaderFilterByColumn();
   return;
  }
  this.UpdateSelectAllCheckState();
  this.UpdateOkButtonEnabledState();
 },
 OnDateRangePickerValueChanged: function(){
  this.UpdateOkButtonEnabledState();
 },
 OnCalendarSelectionChanged: function(){
  this.UpdateOkButtonEnabledState();
 },
 UpdateSelectAllCheckState: function(){
  var checkBox = this.GetSelectAllCheckBox();
  if(!this.RenderExistsOnPage(checkBox))
   return;
  var listBox = this.GetListBox();
  var selectedItemCount = listBox.GetSelectedIndices().length;
  var checkState = ASPx.CheckBoxCheckState.Indeterminate;
  if(selectedItemCount == 0)
   checkState = ASPx.CheckBoxCheckState.Unchecked;
  else if(selectedItemCount == listBox.GetItemCount())
   checkState = ASPx.CheckBoxCheckState.Checked;
  checkBox.SetCheckState(checkState);
 },
 UpdateOkButtonEnabledState: function(){
  this.SetOkButtonEnabled(this.IsFilterChanged());
 },
 SetOkButtonEnabled: function(enabled) {
  var popup = this.GetPopup();
  if(!popup) return;
  var button = ASPx.GetControlCollection().Get(popup.cpOkButtonID);
  if(!button) return;
  button.SetEnabled(enabled);
 },
 IsFilterChanged: function(){
  return this.IsListBoxSelectedIndicesChanged() || this.IsDateRangePickerValueChanged() || this.IsCalendarSelectedDatesChanged();
 },
 IsListBoxSelectedIndicesChanged: function(){
  var listBox = this.GetListBox();
  if(!listBox) return false;
  var indices = listBox.GetSelectedIndices();
  if(indices.length != this.initSelectedIndices.length)
   return true;
  for(var i = 0; i < indices.length; i++) {
   if(ASPx.Data.ArrayBinarySearch(this.initSelectedIndices, indices[i]) < 0)
    return true;
  }
  return false;
 },
 IsCalendarSelectedDatesChanged: function(){
  var calendar = this.GetCalendar();
  if(!this.RenderExistsOnPage(calendar))
   return false;
  return !ASPx.Data.ArrayEqual(this.initCalendarDates, calendar.GetSelectedDates());
 },
 IsDateRangePickerValueChanged: function(){
  var fromDateEdit = this.GetHeaderFilterFromDateEdit();
  var toDateEdit = this.GetHeaderFilterToDateEdit();
  if(!this.RenderExistsOnPage(fromDateEdit) || !this.RenderExistsOnPage(toDateEdit))
   return false;
  return this.initDateRangePickerRange.start != fromDateEdit.GetValue() || this.initDateRangePickerRange.end != toDateEdit.GetValue();
 },
 GetCallbackValue: function(){
  var values = [ ];
  var listBox = this.GetListBox();
  if(listBox)
   values = listBox.GetSelectedValues();
  var calendarValue = this.GetCalendarCallbackValue();
  calendarValue && values.push(calendarValue);
  var pickerValue = this.GetDateRangePickerCallbackValue();
  pickerValue && values.push(pickerValue);
  return values;
 },
 GetCalendarCallbackValue: function(){
  var calendar = this.GetCalendar();
  if(!this.RenderExistsOnPage(calendar))
   return null;
  var dates = calendar.GetSelectedDates();
  if(dates && dates.length == 0)
   return null;
  dates.sort(function(a,b){ return a-b; });
  var selectedRanges = [ ];
  var range = {};
  for(var i = 0; i < dates.length; i++){
   if(!range.start)
    range.start = range.end = dates[i];
   if(i + 1 < dates.length && ASPx.DateUtils.AreDatesEqualExact(this.GetNextDate(range.end), dates[i + 1]))
    range.end = dates[i + 1];
   else {
    selectedRanges.push(ASPx.DateUtils.GetInvariantDateString(range.start));
    selectedRanges.push(ASPx.DateUtils.GetInvariantDateString(range.end));
    range.start = range.end = null;
   }
  }
  return "(Calendar)|" + selectedRanges.join("|");
 },
 GetNextDate: function(date){
  var nextDate = new Date(date.getTime());
  nextDate.setDate(nextDate.getDate() + 1);
  return nextDate;
 },
 GetDateRangePickerCallbackValue: function(){
  var fromDateEdit = this.GetHeaderFilterFromDateEdit();
  var toDateEdit = this.GetHeaderFilterToDateEdit();
  if(!this.RenderExistsOnPage(fromDateEdit) || !this.RenderExistsOnPage(toDateEdit))
   return null;
  var start = fromDateEdit.GetValue();
  var end = toDateEdit.GetValue();
  var range = [ ];
  if(start || end){
   range.push(start && ASPx.DateUtils.GetInvariantDateString(start) || "");
   range.push(end && ASPx.DateUtils.GetInvariantDateString(end) || "");
  }
  return range.length > 0 ? "(DateRangePicker)|" + range.join("|") : null;
 },
 RestoreState: function(){
  this.RestoreListBoxState();
  this.RestoreCalendarState();
  this.RestoreDateRangePickerState();
  this.SetOkButtonEnabled(false);
 },
 RestoreListBoxState: function() {
  var listBox = this.GetListBox();
  if(!this.column.HFCheckedList || !this.RenderExistsOnPage(listBox))
   return;
  listBox.UnselectAll();
  listBox.SelectIndices(this.initSelectedIndices);
  this.UpdateSelectAllCheckState();
 },
 RestoreCalendarState: function(){
  var calendar = this.GetCalendar();
  if(!this.RenderExistsOnPage(calendar))
   return;
  calendar.SetValue(null);
  for(var i = 0; i < this.initCalendarDates.length; i++)
   calendar.SelectDate(this.initCalendarDates[i]);
 },
 RestoreDateRangePickerState: function(){
  var fromDateEdit = this.GetHeaderFilterFromDateEdit();
  var toDateEdit = this.GetHeaderFilterToDateEdit();
  if(!this.RenderExistsOnPage(fromDateEdit) || !this.RenderExistsOnPage(toDateEdit))
   return;
  fromDateEdit.SetValue(this.initDateRangePickerRange.start);
  toDateEdit.SetValue(this.initDateRangePickerRange.end);
 },
 RenderExistsOnPage: function(control){
  return control && !control.IsDOMDisposed();
 }
});
var GridHFListBoxWrapper = {
 Initialize: function(listBox){
  listBox.GetItemRow = GridHFListBoxWrapper.GetItemRow;
  listBox.GetItemCount = GridHFListBoxWrapper.GetItemCount;
  listBox.OnItemClickCore = listBox.OnItemClick;
  listBox.OnItemClick = GridHFListBoxWrapper.OnItemClick;
  listBox.FindInternalCheckBoxIndexCore = listBox.FindInternalCheckBoxIndex;
  listBox.FindInternalCheckBoxIndex = GridHFListBoxWrapper.FindInternalCheckBoxIndex;
 },
 GetItemRow: function(index){
  var itemRows = GridHFListBoxWrapper.GetItemRows(this);
  if(index >= 0)
   return itemRows[index] || null;
  return null;
 },
 OnItemClick: function(index, evt){
  var correctIndex = GridHFListBoxWrapper.GetCorrectItemIndex(this, index);
  this.OnItemClickCore(correctIndex, evt);
 },
 FindInternalCheckBoxIndex: function(element){
  var index = this.FindInternalCheckBoxIndexCore(element);
  return GridHFListBoxWrapper.GetCorrectItemIndex(this, index);
 },
 GetItemCount: function(){
  return GridHFListBoxWrapper.GetItemRows(this).length;
 },
 GetCorrectItemIndex: function(listBox, index){
  for(var i = 0; i < listBox.cpFSI.length; i++) {
   if(listBox.cpFSI[i] < index)
    index--;
  }
  return index;
 },
 GetItemRows: function(listBox){
  var itemRows = [];
  var listTable = listBox.GetListTable();
  var rows = listTable ? listTable.rows : null;
  for(var i = 0; rows && i < rows.length; i++){
   if(ASPx.ElementContainsCssClass(rows[i], "dxeListBoxItemRow"))
    itemRows.push(rows[i]);
  }
  return itemRows;
 }
}
var ASPxClientGridViewCallbackCommand = {
 NextPage: "NEXTPAGE",
 PreviousPage: "PREVPAGE",
 GotoPage: "GOTOPAGE",
 SelectRows: "SELECTROWS",
 SelectRowsKey: "SELECTROWSKEY",
 Selection: "SELECTION",
 FocusedRow: "FOCUSEDROW",
 Group: "GROUP",
 UnGroup: "UNGROUP",
 Sort: "SORT",
 ColumnMove: "COLUMNMOVE",
 CollapseAll: "COLLAPSEALL",
 ExpandAll: "EXPANDALL",
 ExpandRow: "EXPANDROW",
 CollapseRow: "COLLAPSEROW",
 HideAllDetail: "HIDEALLDETAIL",
 ShowAllDetail: "SHOWALLDETAIL",
 ShowDetailRow: "SHOWDETAILROW",
 HideDetailRow: "HIDEDETAILROW",
 PagerOnClick: "PAGERONCLICK",
 ApplyFilter: "APPLYFILTER",
 ApplyColumnFilter: "APPLYCOLUMNFILTER",
 ApplyMultiColumnFilter: "APPLYMULTICOLUMNFILTER",
 ApplyHeaderColumnFilter: "APPLYHEADERCOLUMNFILTER",
 ApplySearchPanelFilter: "APPLYSEARCHPANELFILTER",
 FilterRowMenu: "FILTERROWMENU",
 StartEdit: "STARTEDIT",
 CancelEdit: "CANCELEDIT",
 UpdateEdit: "UPDATEEDIT",
 AddNewRow: "ADDNEWROW",
 DeleteRow: "DELETEROW",
 CustomButton: "CUSTOMBUTTON",
 CustomCallback: "CUSTOMCALLBACK",
 ShowFilterControl: "SHOWFILTERCONTROL",
 CloseFilterControl: "CLOSEFILTERCONTROL",
 SetFilterEnabled: "SETFILTERENABLED",
 Refresh: "REFRESH",
 SelFieldValues: "SELFIELDVALUES",
 RowValues: "ROWVALUES",
 PageRowValues: "PAGEROWVALUES",
 FilterPopup: "FILTERPOPUP",
 ContextMenu: "CONTEXTMENU",
 CustomValues: "CUSTOMVALUES"
};
var ASPxClientGridBatchEditStartEditingEventArgs = ASPx.CreateClass(ASPxClientCancelEventArgs, {
 constructor: function(visibleIndex, focusedColumn, itemValues) {
  this.constructor.prototype.constructor.call(this);
  this.visibleIndex = visibleIndex;
  this.focusedColumn = focusedColumn;
  this.itemValues = ASPx.CloneObject(itemValues);
 }
});
var ASPxClientGridBatchEditEndEditingEventArgs = ASPx.CreateClass(ASPxClientCancelEventArgs, {
 constructor: function(visibleIndex, itemValues) {
  this.constructor.prototype.constructor.call(this);
  this.visibleIndex = visibleIndex;
  this.itemValues = ASPx.CloneObject(itemValues);
 }
});
var ASPxClientGridBatchEditItemValidatingEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(visibleIndex, validationInfo) {
  this.constructor.prototype.constructor.call(this);
  this.visibleIndex = visibleIndex;
  this.validationInfo = ASPx.CloneObject(validationInfo);
 }
});
var ASPxClientGridBatchEditConfirmShowingEventArgs = ASPx.CreateClass(ASPxClientCancelEventArgs, {
 constructor: function(requestTriggerID) {
  this.constructor.prototype.constructor.call(this);
  this.requestTriggerID = requestTriggerID;
 }
});
var ASPxClientGridBatchEditTemplateCellFocusedEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(column) {
  this.constructor.prototype.constructor.call(this);
  this.column = column;
  this.handled = false;
 }
});
var ASPxClientGridBatchEditApi = ASPx.CreateClass(null, {
 constructor: function(grid) {
  this.grid = grid;
 },
 GetHelper: function() { return this.grid.GetBatchEditHelper(); },
 GetColumnIndex: function(column) { return this.grid._getColumnIndexByColumnArgs(column); },
 SetCellValue: function(visibleIndex, column, value, displayText) {
  var helper = this.GetHelper();
  var columnIndex = this.GetColumnIndex(column);
  if(!helper || columnIndex === null) 
   return;
  if(!helper.IsValidVisibleIndex(visibleIndex))
   return;
  if(!ASPx.IsExists(displayText))
   displayText = helper.GetColumnDisplayTextByEditor(value, visibleIndex, columnIndex);
  if(helper.IsCheckColumn(columnIndex))
   displayText = helper.GetCheckColumnDisplayText(value, columnIndex);
  if(helper.IsColorEditColumn(columnIndex))
   displayText = helper.GetColorEditColumnDisplayText(value, columnIndex);
  helper.SetCellValue(visibleIndex, columnIndex, value, displayText);
  helper.UpdateSyncInput(); 
  helper.UpdateItem(visibleIndex, [ columnIndex ], helper.IsEditingCell(visibleIndex, columnIndex), false, true);
 },
 GetCellValue: function(visibleIndex, column) {
  var helper = this.GetHelper();
  var columnIndex = this.GetColumnIndex(column);
  if(!helper || columnIndex === null) return;
  return helper.GetCellValue(visibleIndex, columnIndex);
 },
 HasChanges: function(visibleIndex, column) {
  var helper = this.GetHelper();
  if(!helper) return false;
  var columnIndex = this.GetColumnIndex(column);
  return helper.HasChanges(visibleIndex, columnIndex);
 },
 ResetChanges: function(visibleIndex, columnIndex) {
  var helper = this.GetHelper();
  if(!helper) return;
  helper.ResetChanges(visibleIndex, columnIndex);
 },
 StartEdit: function(visibleIndex, columnIndex) {
  var helper = this.GetHelper();
  if(!helper) return;
  helper.StartEdit(visibleIndex, columnIndex);
 },
 EndEdit: function() {
  var helper = this.GetHelper();
  if(!helper || helper.focusHelper.lockUserEndEdit) 
   return;
  helper.EndEdit();
 },
 MoveFocusBackward: function() {
  var helper = this.GetHelper();
  if(!helper) return;
  return helper.focusHelper.MoveFocusPrev();
 },
 MoveFocusForward: function() {
  var helper = this.GetHelper();
  if(!helper) return;
  return helper.focusHelper.MoveFocusNext();
 },
 IsColumnEdited: function(column) {
  var helper = this.GetHelper();
  if(!helper || !column) return;
  return helper.IsColumnEdited(column.index);
 },
 ValidateItems: function() {
  var helper = this.GetHelper();
  if(!helper) return;
  return helper.UserValidateItems().isValid;
 },
 ValidateItem: function(visibleIndex) {
  var helper = this.GetHelper();
  if(!helper) return;
  return helper.UserValidateItems(visibleIndex).isValid;
 }
});
ASPxClientGridBase.InitializeStyles = function(name, styleInfo, commandButtonIDs){
 var grid = ASPx.GetControlCollection().Get(name);
 if(grid) {
  grid.styleInfo = styleInfo;
  grid.cButtonIDs = commandButtonIDs;
  grid.EnsureRowKeys();
  grid.UpdateItemsStyle();
 }
}
ASPx.GHeaderMouseDown = function(name, element, e) {
 var grid = ASPx.GetControlCollection().Get(name);
 if(grid != null) 
  grid.HeaderMouseDown(element, e);
}
ASPx.GSort = function(name, columnIndex) {
 var grid = ASPx.GetControlCollection().Get(name);
 if(grid != null)  
  grid.SortBy(columnIndex);
}
ASPx.GVPopupEditFormOnInit = function(name, popup) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null)
  window.setTimeout(function() { gv.OnPopupEditFormInit(popup); }, 0);
}
ASPx.GVPagerOnClick = function(name, value) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null) 
  gv.doPagerOnClick(value);
}
ASPx.GVFilterKeyPress = function(name, element, e) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null) 
  gv.OnColumnFilterInputKeyPress(element, e);
}
ASPx.GVFilterSpecKeyPress = function(name, element, e) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null) 
  gv.OnColumnFilterInputSpecKeyPress(element, e);
}
ASPx.GVFilterChanged = function(name, element) {
 window.setTimeout(function() {
  var gv = ASPx.GetControlCollection().Get(name);
  var el = ASPx.GetControlCollection().Get(element.name);
  if(gv != null && el != null) 
   gv.OnColumnFilterInputChanged(el);
 }, 0);
}
ASPx.GVShowParentRows = function(name, evt, element) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null) {
  if(element)
   gv.OnParentRowMouseEnter(element);  
  else 
   gv.OnParentRowMouseLeave(evt);
 }
}
ASPx.GTableClick = function(name, evt) {
 var g = ASPx.GetControlCollection().Get(name);
 if(g != null && g.NeedProcessTableClick(evt))
  g.mainTableClick(evt);
}
ASPx.GVTableDblClick = function(name, evt) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null && gv.NeedProcessTableClick(evt))
  gv.mainTableDblClick(evt);
}
ASPx.GVCustWindowShown_IE = function(s) {
 var div = document.getElementById(s.name + "_Scroller");
 div.style.overflow = "hidden";
 var width1 = div.clientWidth;
 div.style.overflow = "auto";
 var width2 = div.clientWidth;
 if(width2 > width1) {
  div.style.width = width1 + "px";
  div.style.paddingRight = (width2 - width1) + "px";
  window.setTimeout(function() { 
   div.className = "_";
   div.className = "";
  }, 0);
 }
}
ASPx.GVCustWindowCloseUp = function(name) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null) {
  gv.RaiseCustomizationWindowCloseUp();
 }
}
ASPx.GVApplyFilterPopup = function(name) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null)
  gv.ApplyHeaderFilterByColumn();
}
ASPx.GVShowFilterControl = function(name) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null) {
  gv.ShowFilterControl();
 }
}
ASPx.GVCloseFilterControl = function(name) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null) {
  gv.CloseFilterControl();
 }
}
ASPx.GVSetFilterEnabled = function(name, value) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null) {
  gv.SetFilterEnabled(value);
 }
}
ASPx.GVApplyFilterControl = function(name) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null)
  gv.ApplyFilterControl();
}
ASPx.GVFilterRowMenu = function(name, columnIndex, element) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null)
  gv.FilterRowMenuButtonClick(columnIndex, element);
}
ASPx.GVFilterRowMenuClick = function(name, e) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null)
  gv.FilterRowMenuItemClick(e.item);
}
ASPx.GVScheduleCommand = function(name, commandArgs, postponed, event) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null)
  gv.ScheduleUserCommand(commandArgs, postponed, ASPx.Evt.GetEventSource(event));
}
ASPx.GVHFCancelButtonClick = function(name) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null)
  gv.GetHeaderFilterPopup().Hide();
}
window.ASPxClientGridItemStyle = ASPxClientGridItemStyle; 
window.ASPxClientGridBase = ASPxClientGridBase;
window.ASPxClientGridColumnBase = ASPxClientGridColumnBase;
window.ASPxClientGridViewCallbackCommand = ASPxClientGridViewCallbackCommand;
window.ASPxClientGridBatchEditStartEditingEventArgs = ASPxClientGridBatchEditStartEditingEventArgs;
window.ASPxClientGridBatchEditEndEditingEventArgs = ASPxClientGridBatchEditEndEditingEventArgs;
window.ASPxClientGridBatchEditItemValidatingEventArgs = ASPxClientGridBatchEditItemValidatingEventArgs;
window.ASPxClientGridBatchEditConfirmShowingEventArgs = ASPxClientGridBatchEditConfirmShowingEventArgs;
window.ASPxClientGridBatchEditTemplateCellFocusedEventArgs = ASPxClientGridBatchEditTemplateCellFocusedEventArgs;
window.ASPxClientGridBatchEditApi = ASPxClientGridBatchEditApi;
})();
