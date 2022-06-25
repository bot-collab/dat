(function(){
var ASPxClientGridView = ASPx.CreateClass(ASPxClientGridBase, {
 AdaptiveGroupPanelID: "DXAGroupPanel",
 AdaptiveHeaderPanelID: "DXAHeaderPanel",
 AdaptiveFooterPanelID: "DXAFooterPanel",
 AdaptiveGroupHeaderID: "DXADGroupHeader",
 AdaptiveHeaderID: "DXADHeader",
 HeaderTableID: "DXHeaderTable",
 FilterRowID: "DXFilterRow",
 DataRowID: "DXDataRow",
 DetailRowID: "DXDRow",
 AdaptiveDetailRowID: "DXADRow",
 PreviewRowID: "DXPRow",
 GroupRowID: "DXGroupRow",
 EmptyDataRowID: "DXEmptyRow",
 FooterRowID: "DXFooterRow",
 FixedColumnsDivID: "DXFixedColumnsDiv",
 FixedColumnsContentDivID: "DXFixedColumnsContentDiv",
 HeaderRowID: "_DXHeadersRow",
 NewRowVisibleIndex: -2147483647,
 GridViewMarkerCssClass: "dxgv",
 GroupRowCssClass: "dxgvGroupRow",
 EmptyPagerRowCssClass: "dxgvEPDR",
 GroupFooterRowClass: "dxgvGroupFooter",
 GroupPanelCssClass: "dxgvGroupPanel",
 FooterScrollDivContainerCssClass: "dxgvFSDC",
 HeaderScrollDivContainerCssClass: "dxgvHSDC",
 HeaderCellCssClass: "dxgvHeader",
 CommandColumnCellCssClass: "dxgvCommandColumn",
 IndentCellCssClass: "dxgvIndentCell",
 InlineEditCellCssClass: "dxgvInlineEditCell",
 DetailIndentCellCssClass: "dxgvDIC",
 DetailButtonCellCssClass: "dxgvDetailButton",
 AdaptivityEnabledCssClass: "dxgvAE",
 AdaptivityWithLimitEnabledCssClass: "dxgvALE",
 AdaptiveHiddenCssClass: "dxgvAH",
 AdaptiveIndentCellCssClass: "dxgvAIC",
 AdaptiveDetailShowButtonCssClass: "dxgvADSB",
 AdaptiveDetailHideButtonCssClass: "dxgvADHB",
 AdaptiveDetailTableCssClass: "dxgvADT",
 AdaptiveDetailCaptionCellCssClass: "dxgvADCC",
 AdaptiveDetailDataCellCssClass: "dxgvADDC",
 AdaptiveDetailSpacerCellCssClass: "dxgvADSC",
 AdaptiveDetailCommandCellCssClass: "dxgvADCMDC",
 AdaptiveDetailLayoutItemContentCssClass: "dxgvADLIC",
 LastVisibleRowClassName: "dxgvLVR",
 constructor: function(name){
  this.constructor.prototype.constructor.call(this, name);
  this.editMode = 2;
  this.FocusedRowChanged = new ASPxClientEvent();
  this.ColumnGrouping = new ASPxClientEvent();
  this.ColumnStartDragging  = new ASPxClientEvent();
  this.ColumnResizing  = new ASPxClientEvent();
  this.ColumnResized  = new ASPxClientEvent();
  this.ColumnMoving = new ASPxClientEvent();
  this.RowExpanding  = new ASPxClientEvent();
  this.RowCollapsing  = new ASPxClientEvent();
  this.DetailRowExpanding  = new ASPxClientEvent();
  this.DetailRowCollapsing  = new ASPxClientEvent();
  this.RowClick  = new ASPxClientEvent();
  this.RowDblClick  = new ASPxClientEvent();
  this.ContextMenu = new ASPxClientEvent();
  this.ContextMenuItemClick = new ASPxClientEvent();
  this.BatchEditRowValidating = new ASPxClientEvent();
  this.allowFixedGroups = false;
  this.virtualScrollMode = 0;
  this.tableHelper = null;
  this.dragHelper = null;
  this.batchEditHelper = null;
  this.virtualScrollingDelay = 500;
  this.adaptivityMode = 0;
  this.adaptiveColumnsOrder = null;
  this.allowTextTruncationInAdaptiveMode = null;
  this.activeAdaptiveDetailVisibleIndex = null;
  this.visibleAdaptiveDetailVisibleIndices = [];
  this.hasAdaptiveDetailsFormLayout = null;
  this.adaptivePagerEmptyRows = [];
 },
 GetItem: function(visibleIndex){
  var res = this.GetDataRow(visibleIndex);
  if(res == null) res = this.GetGroupRow(visibleIndex);
  return res;
 },
 IsDataItem: function(visibleIndex) { return this.IsDataRow(visibleIndex); },
 GetRow: function(visibleIndex) { return this.GetItem(visibleIndex); },
 GetDataItemIDPrefix: function() { return this.DataRowID; },
 GetEmptyDataItemIDPostfix: function() { return this.EmptyDataRowID; },
 GetEmptyDataItemCell: function() { 
  var row = this.GetEmptyDataItem();
  return row ? this.GetLastNonAdaptiveIndentCell(row) : null;
 },
 GetDataRow: function(visibleIndex) { return this.GetChildElement(this.DataRowID + visibleIndex); },
 GetEditingCell: function(columnIndex) { 
  var row = this.GetEditingRow();
  var cellIndex = this.GetDataCellIndex(columnIndex);
  return row ? row.cells[cellIndex] : null;
 },
 GetEditingErrorCell: function(row) { 
  var row = row || this.GetEditingErrorItem();
  return row ? this.GetLastNonAdaptiveIndentCell(row) : null;
 },
 GetErrorTextContainer: function(displayIn) {
  var errorRow = this.GetEditingErrorItem(displayIn);
  if(!errorRow) {
   var editRow = this.GetEditingRow(displayIn);
   if(editRow) {
    errorRow = this.CreateEditingErrorItem();
    errorRow.id = editRow.id.replace("DXEditingRow", this.EditingErrorItemID);
    ASPx.InsertElementAfter(errorRow, editRow);
   }
  }
  return this.GetEditingErrorCell(errorRow);
 },
 CreateEditingErrorItem: function() {
  var wrapperElement = document.createElement("div");
  wrapperElement.innerHTML = "<table><tbody>" + this.styleInfo[ASPxClientGridItemStyle.ErrorItemHtml] + "</tbody></table>";
  var row = wrapperElement.firstChild.rows[0];
  for(var i = 0; i < row.cells.length; i++) {
   var cell = row.cells[i];
   var colSpan = parseInt(ASPx.Attr.GetAttribute(cell, "data-colSpan"));
   if(!isNaN(colSpan)) 
    cell.colSpan = colSpan;
  }
  if(this.hasAdaptiveElements) {
   var errorCell = this.GetLastNonAdaptiveIndentCell(row);
   var adaptiveSampleCell = this.GetSampleAdaptiveDetailCell();
   errorCell.colSpan = adaptiveSampleCell.colSpan;
   errorCell.originalColSpan = adaptiveSampleCell.originalColSpan;
  }
  return row;
 },
 GetDetailRow: function(visibleIndex) { return this.GetChildElement(this.DetailRowID + visibleIndex); },
 GetDetailCell: function(visibleIndex) { 
  var row = this.GetDetailRow(visibleIndex);
  return row ? this.GetLastNonAdaptiveIndentCell(row) : null;
 },
 GetPreviewRow: function(visibleIndex) { return this.GetChildElement(this.PreviewRowID + visibleIndex); },
 GetPreviewCell: function(visibleIndex) { 
  var row = this.GetPreviewRow(visibleIndex);
  return row ? this.GetLastNonAdaptiveIndentCell(row) : null;
 },
 GetSampleAdaptiveDetailRow: function() { 
  return this.GetChildElement(this.AdaptiveDetailRowID); 
 },
 GetSampleAdaptiveDetailCell: function() { 
  var row = this.GetSampleAdaptiveDetailRow();
  return row ? this.GetLastNonAdaptiveIndentCell(row) : null;
 },
 GetAdaptiveDataRow: function(visibleIndex) { 
  if(this.IsGroupRow(visibleIndex))
   return null;
  var row = this.GetDataRow(visibleIndex);
  if(row) 
   return row;
  if(this.IsInlineEditMode())
   return this.GetEditingRow();
  return null;
 },
 GetAdaptiveDetailRow: function(visibleIndex, forceCreate) { 
  var row = this.GetChildElement(this.AdaptiveDetailRowID + visibleIndex); 
  if(!row && forceCreate) {
   var sampleRow = this.GetSampleAdaptiveDetailRow();
   var dataRow = this.GetAdaptiveDataRow(visibleIndex);
   if(sampleRow && dataRow) {
    row = sampleRow.cloneNode(true);
    row.id = this.name + "_" + this.AdaptiveDetailRowID + visibleIndex;
    this.GetLastNonAdaptiveIndentCell(row).originalColSpan = this.GetLastNonAdaptiveIndentCell(sampleRow).originalColSpan;
    ASPx.InsertElementAfter(row, dataRow);
    for(var i = 0; i < this.indentColumnCount; i++)
     row.cells[i].style.borderBottomWidth = dataRow.cells[i].style.borderBottomWidth;
   }
  }
  return row; 
 },
 GetAdaptiveHeaderContainer: function(visibleIndex, adaptivePanel) { 
  if(!adaptivePanel) return null;
  var isGroupHeader = adaptivePanel == this.GetAdaptiveGroupPanel();
  var containerID = this.name + "_" + (isGroupHeader ? this.AdaptiveGroupHeaderID : this.AdaptiveHeaderID) + visibleIndex;
  var adaptiveHeader = document.getElementById(containerID);
  if(!adaptiveHeader) {
    adaptiveHeader = this.GetSampleAdaptiveHeader(isGroupHeader).cloneNode(true);
    adaptiveHeader.id = containerID;
    ASPx.SetElementDisplay(adaptiveHeader, true);
    var table = ASPx.GetChildByTagName(adaptiveHeader, "TABLE", 0);
    var row = table.rows[0];
    adaptiveHeader.dxHeaderContainer = row;
    adaptivePanel.appendChild(adaptiveHeader);
   }
  return adaptiveHeader.dxHeaderContainer;
 },
 GetAdaptiveGroupPanel: function() {
  return this.GetChildElement(this.AdaptiveGroupPanelID);
 },
 GetAdaptiveHeaderPanel: function() { 
  return this.GetChildElement(this.AdaptiveHeaderPanelID);
 },
 GetAdaptiveFooterPanel: function() { 
  return this.GetChildElement(this.AdaptiveFooterPanelID);
 },
 GetSampleAdaptiveHeader: function(isGroupHeader) { 
  var id = isGroupHeader ? this.AdaptiveGroupHeaderID : this.AdaptiveHeaderID;
  return this.GetChildElement(id); 
 },
 GetAdaptiveDetailCell: function(visibleIndex, forceCreate) { 
  var row = this.GetAdaptiveDetailRow(visibleIndex, forceCreate);
  return row ? this.GetLastNonAdaptiveIndentCell(row) : null;
 },
 GetDetailButtonCell: function(visibleIndex, fromAdaptiveRow) {
  var row = fromAdaptiveRow ? this.GetAdaptiveDetailRow(visibleIndex) : this.GetAdaptiveDataRow(visibleIndex);
  return ASPx.GetChildByPartialClassName(row, this.DetailButtonCellCssClass);
 },
 GetGroupRow: function(visibleIndex) { 
  var element = this.GetChildElement(this.GroupRowID + visibleIndex);
  if(!element)
   element = this.GetExpandedGroupRow(visibleIndex);
  return element; 
 },
 GetGroupCell: function(visibleIndex) { 
  var row = this.GetGroupRow(visibleIndex);
  return row ? this.GetLastNonAdaptiveIndentCell(row) : null;
 },
 GetGroupMoreRows: function(visibleIndex){
  var group = this.GetGroupRow(visibleIndex);
  if(!group)
   return null;
  var elements = ASPx.GetNodesByPartialClassName(group, "dxgvFGI");
  return elements && elements.length ? elements[0] : null;
 },
 GetGroupLevel: function(visibleIndex){
  var group = this.GetGroupRow(visibleIndex);
  return group ? this.GetFooterIndentCount(group) : -1;
 },
 GetExpandedGroupRow: function(visibleIndex) { return this.GetChildElement(this.GroupRowID + "Exp" + visibleIndex); },
 _isGroupRow: function(row) { return row.id.indexOf(this.GroupRowID) > -1; },
 IsHeaderRow: function(row) { return this.IsHeaderRowID(row.id); },
 IsHeaderRowID: function(id) { return id.indexOf(this.name + this.HeaderRowID) == 0; },
 IsEmptyHeaderID: function(id) { return id.indexOf(this.EmptyHeaderSuffix) > -1 },
 CreateEndlessPagingHelper: function(){
  return new ASPx.GridViewEndlessPagingHelper(this);
 },
 GetCssClassNamePrefix: function() { return "dxgv"; },
 GetFilterRow: function() { return this.GetChildElement(this.FilterRowID); },
 GetFilterCell: function(columnIndex) { 
  var row = this.GetFilterRow();
  var cellIndex = this.GetDataCellIndex(columnIndex);
  return row ? row.cells[cellIndex] : null;
 },
 GetDataCellIndex: function(columnIndex) {
  return ASPx.Data.ArrayIndexOf(this.GetVisibleColumnIndices(), columnIndex) + this.indentColumnCount;
 },
 GetColumnIndexByDataCell: function(dataCell) {
  if(!dataCell) return -1;
  if(dataCell.columnIndex) return dataCell.columnIndex;
  var cellIndex = dataCell.cellIndex - this.indentColumnCount;
  var columnIndices = this.GetVisibleColumnIndices();
  if(cellIndex < 0 || cellIndex >= columnIndices.length) 
   return -1;
  return columnIndices[cellIndex];
 },
 GetDataCell: function(row, columnIndex) {
  if(!row || columnIndex < 0) 
   return null;
  var cellIndex = this.GetDataCellIndex(columnIndex);
  return (0 <= cellIndex && cellIndex < row.cells.length) ? row.cells[cellIndex] : null;
 },
 GetVisibleColumnIndices: function() {
  var matrix = this.GetHeaderMatrix();
  if(matrix.GetRowCount() > 0)
   return matrix.GetLeafIndices();
  return this.visibleColumnIndices || [ ];
 },
 GetArmatureCells: function(columnIndex) {
  var result = [];
  var cellIndex = this.GetDataCellIndex(columnIndex);
  var tableHelper = this.GetTableHelper();
  if(tableHelper) {
   if(tableHelper.GetHeaderTable()) {
    var cells = tableHelper.GetArmatureCells(tableHelper.GetHeaderTable());
    if(cells) result.push(cells[cellIndex]);
   }
   if(tableHelper.GetContentTable()) {
    var cells = tableHelper.GetArmatureCells(tableHelper.GetContentTable());
    if(cells) result.push(cells[cellIndex]);
   }
   if(tableHelper.GetFooterTable()) {
    var cells = tableHelper.GetArmatureCells(tableHelper.GetFooterTable());
    if(cells) result.push(cells[cellIndex]);
   }
  }
  else{
   var mainTable = this.GetMainTable();
   result.push(mainTable.rows[0].cells[cellIndex]);
  }
  return result;
 },
 GetLastNonAdaptiveIndentCell: function(row) {
  var count = 1;
  while(count <= row.cells.length){
   var cell = row.cells[row.cells.length - count]
   if(!ASPx.ElementHasCssClass(cell, this.AdaptiveIndentCellCssClass))
    return cell;
   count++;
  }
  return null;
 },
 GetHeaderScrollContainer:function() {
  return ASPx.GetNodeByClassName(this.GetMainElement(), this.HeaderScrollDivContainerCssClass);
 },
 GetFooterScrollContainer:function() {
  return ASPx.GetNodeByClassName(this.GetMainElement(), this.FooterScrollDivContainerCssClass);
 },
 SetHeadersClientEvents: function() {
  if(!this.AllowResizing())
   return;
  var helper = this.GetResizingHelper();
  var attachMouseMove = function(headerCell) { 
   ASPx.Evt.AttachEventToElement(headerCell, "mousemove", function(e) { helper.UpdateCursor(e, headerCell); });
  };
  for(var i = 0; i < this.columns.length; i++) {
   var header = this.GetHeader(this.columns[i].index);
   if(header) 
    attachMouseMove(header);
  }
 },
 GetFooterRow: function(){
  return this.GetChildElement(this.FooterRowID);
 },
 GetFooterCell: function(columnIndex){
  var row = this.GetFooterRow();
  var cellIndex = this.GetDataCellIndex(columnIndex);
  return row ? row.cells[cellIndex] : null;
 },
 GetGroupFooterCells: function(columnIndex) {
  var mainTable = this.GetMainTable();
  var tBody = ASPx.GetChildByTagName(mainTable, "TBODY");
  var groupFooterRows = ASPx.GetChildNodesByPartialClassName(tBody, this.GroupFooterRowClass);
  var cellIndex = this.GetDataCellIndex(columnIndex);
  var result = [ ];
  for(var i = 0; i < groupFooterRows.length; i++) {
   var row = groupFooterRows[i];
   var cell = row && row.cells[cellIndex];
   if(cell)
    result.push(cell);
  }
  return result;
 },
 GetUserCommandNamesForRow: function() { return ASPxClientGridBase.prototype.GetUserCommandNamesForRow().concat([ "ShowAdaptiveDetail", "HideAdaptiveDetail" ]); },
 GetItemVisibleIndexRegExp: function(dataAndGroupOnly) {
  var idParts = [ this.DataRowID, this.GroupRowID + "(?:Exp)?", this.AdaptiveDetailRowID ];
  if(!dataAndGroupOnly) {
   idParts.push(this.PreviewRowID);
   idParts.push(this.DetailRowID);
  }
  return this.GetItemVisibleIndexRegExpByIdParts(idParts);
 },
 IsMainTableChildElement: function(src) {
  if(!src) return true;
  var tables = [ this.GetMainTable() ];
  var tableHelper = this.GetTableHelper();
  if(tableHelper) {
   tables.push(tableHelper.GetHeaderTable());
   tables.push(tableHelper.GetFooterTable());
  }
  for(var i = 0; i < tables.length; i++) {
   if(ASPx.GetIsParent(tables[i], src))
    return true;
  }
  return false;
 },
 CreateBatchEditApi: function() { return new ASPxClientGridViewBatchEditApi(this); },
 IsVirtualScrolling: function() { return this.virtualScrollMode > 0; },
 IsVirtualSmoothScrolling: function() { return this.virtualScrollMode === 2; },
 Initialize: function() {
  ASPxClientGridBase.prototype.Initialize.call(this);
  this.enabled && this.SetHeadersClientEvents();
  if(this.enableKeyboard) {
   this.kbdHelper = this.customKbdHelperName ? new ASPx[this.customKbdHelperName](this) : new ASPx.GridViewKbdHelper(this);
   this.kbdHelper.Init();
   ASPx.KbdHelper.RegisterAccessKey(this);
  }
  this.ResetStretchedColumnWidth();
  this.PrepareEditorsToKeyboardNavigation();
  this.AttachInternalContexMenuEventHandler();
 },
 AttachInternalContexMenuEventHandler: function() {
  if(this.IsDetailGrid()) {
   ASPx.Evt.AttachEventToElement(this.GetMainElement(), "contextmenu", function(e) {
    var showDefaultMenu = ASPx.EventStorage.getInstance().Load(e);
    if(showDefaultMenu)
     ASPx.Evt.CancelBubble(e);
    else 
     ASPx.EventStorage.getInstance().Save(e, true);
   }.aspxBind(this), true);
  }
 },
 AdjustControlCore: function() {
  ASPxClientGridBase.prototype.AdjustControlCore.call(this);
  this.CalculateAdaptivity();
  this.UpdateIndentCellWidths();
  this.ValidateColumnWidths();
 },
 IsAdjustmentRequired: function() {
  if(ASPxClientControl.prototype.IsAdjustmentRequired.call(this))
   return true;
  var scrollHelper = this.GetScrollHelper()
  return scrollHelper ? scrollHelper.IsRestoreScrollPosition() : false;
 },
 SaveCallbackSettings: function() {
  ASPxClientGridBase.prototype.SaveCallbackSettings.call(this);
  var helper = this.GetFixedColumnsHelper();
  if(helper != null) helper.SaveCallbackSettings();
 },
 RestoreCallbackSettings: function() {
  this.ResetStretchedColumnWidth();
  var fixedColumnsHelper = this.GetFixedColumnsHelper();
  if(fixedColumnsHelper != null)
   fixedColumnsHelper.RestoreCallbackSettings();
  this.adaptiveScrollTop = this.stateObject.scrollState ? this.stateObject.scrollState[1] : null;
  this.UpdateScrollableControls();
  if(fixedColumnsHelper != null)
   fixedColumnsHelper.HideColumnsRelyOnScrollPosition();
  this.UpdateIndentCellWidths();
  this.ValidateColumnWidths();
  ASPxClientGridBase.prototype.RestoreCallbackSettings.call(this);
 },
 GetPopupEditFormHorzOffsetCorrection: function(popup) {
  var scrollHelper = this.GetScrollHelper();
  if(!scrollHelper) return 0;
  var scrollDiv = scrollHelper.GetHorzScrollableControl();
  if(!scrollDiv)  return 0;
  var horzAlign = popup.GetHorizontalAlign();
  if(ASPx.PopupUtils.IsRightSidesAlign(horzAlign) || ASPx.PopupUtils.IsOutsideRightAlign(horzAlign))
   return scrollDiv.scrollWidth - scrollDiv.offsetWidth;
  if(ASPx.PopupUtils.IsCenterAlign(horzAlign))
   return (scrollDiv.scrollWidth - scrollDiv.offsetWidth) / 2;
  return 0;
 },
 UpdateIndentCellWidths: function() {
  if(this.indentColumnCount <= 0) 
   return;
  if(this.HasScrolling() || this.AllowResizing()) 
   this.GetTableHelper().UpdateIndentCellWidths();
 },
 OnBeforeCallbackOrPostBack: function() {
  ASPxClientGridBase.prototype.OnBeforeCallbackOrPostBack.call(this);
  this.SaveControlDimensions();
 },
 OnBeforeCallback: function(command) {
  ASPxClientGridBase.prototype.OnBeforeCallback.call(this, command);
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper && this.IsVirtualScrolling())
   scrollHelper.ClearVirtualScrollTimer();
 },
 OnAfterCallback: function() { 
  ASPxClientGridBase.prototype.OnAfterCallback.call(this);
  this.SaveControlDimensions();
  var fixedGroupsHelper = this.GetFixedGroupsHelper();
  if(fixedGroupsHelper){
   fixedGroupsHelper.PopulateRowsHeight();
   fixedGroupsHelper.UpdateFixedGroups();
  }
  this.PrepareEditorsToKeyboardNavigation();
  this.UpdateLastVisibleRow();
 },
 PrepareEditorsToKeyboardNavigation: function() {
  if(!this.RequireEditorsKeyboardNavigation()) return;
  for(var i = 0; i < this.columns.length; i++) {
   this.AttachEventToEditor(this.columns[i].index, "GotFocus", function(s, e) { this.OnEditorGotFocus(s, e); }.aspxBind(this));
   this.AttachEventToEditor(this.columns[i].index, "KeyDown", function(s, e) { this.OnEditorKeyDown(s, e); }.aspxBind(this));
  }
 },
 RequireEditorsKeyboardNavigation: function() {
  return this.IsInlineEditMode() && this.GetFixedColumnsHelper();
 },
 OnEditorGotFocus: function(s, e) {
  if(!this.RequireEditorsKeyboardNavigation()) return;
  var helper = this.GetFixedColumnsHelper();
  helper.TryShowColumn(s.dxgvColumnIndex);
 },
 OnEditorKeyDown: function(s, e) {
  if(!this.RequireEditorsKeyboardNavigation()) return;
  var keyCode = ASPx.Evt.GetKeyCode(e.htmlEvent);
  if(keyCode !== ASPx.Key.Tab) return;
  var helper = this.GetFixedColumnsHelper();
  var matrix = this.GetHeaderMatrix();
  var neighborColumnIndex = e.htmlEvent.shiftKey ? matrix.GetLeftNeighbor(s.dxgvColumnIndex, true) : matrix.GetRightNeighbor(s.dxgvColumnIndex, true);
  var neighborEditor = this.GetEditorByColumnIndex(neighborColumnIndex);
  if(neighborEditor && helper.TryShowColumn(neighborColumnIndex, true)) {
   ASPx.Evt.PreventEventAndBubble(e.htmlEvent);
   ASPx.Selection.SetCaretPosition(s.GetInputElement());
   neighborEditor.Focus();
  }
 },
 IsInlineEditMode: function() { return this.editMode === 0; },
 IsEditRowHasDisplayedDataRow: function() { return this.editMode >= 2; },
 canGroupByColumn: function(headerElement) {
  return this.getColumnObject(headerElement.id).allowGroup;
 },
 canDragColumn: function(headerElement) {
  var column = this._getColumnObjectByArg(this.getColumnIndex(headerElement.id));
  return !this.RaiseColumnStartDragging(column) && this.getColumnObject(headerElement.id).allowDrag;
 },
 doPagerOnClick: function(id) {
  if(!ASPx.IsExists(id)) return;
  if(ASPx.Browser.IE && this.kbdHelper)
   this.kbdHelper.Focus();
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper)
   scrollHelper.ResetScrollTop();
  ASPxClientGridBase.prototype.doPagerOnClick.call(this, id);
 },
 TryStartColumnResizing: function(e, headerCell) {
  var helper = this.GetResizingHelper();
  if(!helper || !helper.CanStartResizing(e, headerCell))
   return false;
  var column = this.columns[helper.GetResizingColumnIndex(e, headerCell)];
  if(this.RaiseColumnResizing(column))
   return false;
  helper.StartResizing(column.index);
  return true;
 },
 IsPossibleSelectItem: function(visibleIndex, newSelectedValue){
  return this.IsDataRow(visibleIndex) && ASPxClientGridBase.prototype.IsPossibleSelectItem.call(this, visibleIndex, newSelectedValue);
 },
 _isRowSelected: function(visibleIndex) {
  return this.IsDataRow(visibleIndex) && ASPxClientGridBase.prototype._isRowSelected.call(this, visibleIndex);
 },
 GetDataItemCountOnPage: function(){
  var dataRowCount = 0;
  for(var i = 0; i < this.pageRowCount; i++){
   var index = i + this.visibleStartIndex;
   if(!this.IsGroupRow(index))
    dataRowCount++;
  }
  return dataRowCount;
 },
 GetFocusedItemStyle: function(visibleIndex, focused){
  var row = this.GetItem(visibleIndex);
  if(focused && row)
   return this._isGroupRow(row) ? ASPxClientGridItemStyle.FocusedGroupItem : ASPxClientGridItemStyle.FocusedItem;
  return ASPxClientGridBase.prototype.GetFocusedItemStyle.call(this, visibleIndex, focused);
 },
 RequireChangeItemStyle: function(visibleIndex, itemStyle){
  if(!ASPxClientGridBase.prototype.RequireChangeItemStyle.call(this, visibleIndex, itemStyle))
   return false;
  return itemStyle != ASPxClientGridItemStyle.Selected || !this.IsGroupRow(visibleIndex); 
 },
 GetItemStyle: function(visibleIndex){
  var style = ASPxClientGridBase.prototype.GetItemStyle.call(this, visibleIndex);
  if(style == ASPxClientGridItemStyle.FocusedItem && this.IsGroupRow(visibleIndex))
   style = ASPxClientGridItemStyle.FocusedGroupItem;
  return style;
 },
 ApplyItemStyle: function(visibleIndex, styleInfo) {
  ASPxClientGridBase.prototype.ApplyItemStyle.call(this, visibleIndex, styleInfo);
  if(this.adaptivityMode === 2) {
   var item = this.GetItem(visibleIndex);
   if(item && this.hasAdaptiveElements && !this.IsGroupRow(visibleIndex))
    ASPx.AddClassNameToElement(item, this.AdaptiveHiddenCssClass);
   var adaptiveItem = this.GetAdaptiveDetailRow(visibleIndex);
   if(adaptiveItem)
    this.ApplyElementStyle(adaptiveItem, styleInfo);
  }
 },
 OnScroll: function(evt){
  var fixedGroupsHelper = this.GetFixedGroupsHelper();
  if(fixedGroupsHelper)
   fixedGroupsHelper.OnDocumentScroll();
 },
 getItemByHtmlEvent: function(evt) {
  return this.getItemByHtmlEventCore(evt, this.DataRowID) || this.getItemByHtmlEventCore(evt, this.GroupRowID) || this.getItemByHtmlEventCore(evt, this.AdaptiveDetailRowID);
 },
 NeedProcessTableClick: function(evt){
  var headerTable = ASPx.GetParentByPartialId(ASPx.Evt.GetEventSource(evt), this.HeaderTableID);
  if(headerTable) {
   var headerTableID = headerTable.id;
   var gridID = headerTableID.substr(0, headerTableID.length - this.HeaderTableID.length - 1);
   return this.name == gridID;
  }
  return ASPxClientGridBase.prototype.NeedProcessTableClick.call(this, evt);
 },
 IsHeaderChild: function(source) {
  var headerRowCount = this.GetHeaderMatrix().GetRowCount();
  for(var i = 0; i < headerRowCount; i++) {
   if(ASPx.GetIsParent(this.GetHeaderRow(i), source))
    return true;
  }
  return false;
 },
 IsActionElement: function(mainElement, source) {
  if(this.testActionElement(source))
   return true;
  var parent = source;
  var controlCollection = ASPx.GetControlCollection();
  while(parent.id !== mainElement.id) {
   var control = controlCollection.Get(parent.id);
   if(ASPx.IsExists(control) && (control instanceof ASPxClientButton || control instanceof ASPxClientEditBase))
    return true;
   parent = parent.parentElement;
  }  
  return false;
 },
 getItemIndex: function(rowId) {   
  if(this.IsHeaderRowID(rowId))
   return -1;
  return ASPxClientGridBase.prototype.getItemIndex.call(this, rowId);
 },
 CreateBatchEditHelper: function() { return new ASPx.GridViewBatchEditHelper(this); },
 GetTableHelper: function() {
  if(!this.tableHelper && typeof(ASPx.GridViewTableHelper) != "undefined")
   this.tableHelper = new ASPx.GridViewTableHelper(this, this.MainTableID, this.HeaderTableID, this.FooterTableID, this.horzScroll, this.vertScroll);
  return this.tableHelper;
 },
 GetScrollHelper: function() {
  if(!this.HasScrolling()) return null;
  if(!this.scrollableHelper)
   this.scrollableHelper = new ASPx.GridViewTableScrollHelper(this.GetTableHelper());
  return this.scrollableHelper;
 },
 GetFixedColumnsHelper: function() {
  if(!this.GetFixedColumnsDiv()) return null;
  if(!this.fixedColumnsHelper)
   this.fixedColumnsHelper = new ASPx.TableFixedColumnsHelper(this.GetTableHelper(), this.FixedColumnsDivID, this.FixedColumnsContentDivID, this.fixedColumnCount);
  return this.fixedColumnsHelper;
 },
 GetFixedGroupsHelper: function() {
  if(!this.allowFixedGroups) return null;
  if(!this.fixedGroupsHelper)
   this.fixedGroupsHelper = new ASPx.GridViewFixedGroupsHelper(this.GetTableHelper());
  return this.fixedGroupsHelper;
 },
 GetResizingHelper: function() {
  if(!this.AllowResizing()) return null;
  if(!this.resizingHelper)
   this.resizingHelper = new ASPx.GridViewTableResizingHelper(this.GetTableHelper());
  return this.resizingHelper;
 },
 GetHeaderMatrix: function() {
  if(!this.headerMatrix)
   this.headerMatrix = new GridViewHeaderMatrix(this);
  return this.headerMatrix;
 },
 ValidateColumnWidths: function() {
  var helper = this.GetResizingHelper();
  if(helper)
   helper.ValidateColumnWidths();
 },
 ResetStretchedColumnWidth: function() {
  var helper = this.GetResizingHelper();
  if(helper)
   helper.ResetStretchedColumnWidth();
 },
 SaveControlDimensions: function() {
  var helper = this.GetResizingHelper();
  if(helper)
   helper.SaveControlDimensions(true);
 },
 OnBrowserWindowResize: function(e) {
  this.EndBatchEdit(e);
  if(this.AllowResizing() && !this.HasScrolling())
   this.ValidateColumnWidths();
  this.AdjustControl();
 },
 EndBatchEdit: function(e){ 
  if(this.IsAdaptivityEnabled() && this.GetBatchEditHelper() && e.prevWndWidth != e.wndWidth)
   this.GetBatchEditHelper().EndEdit();
 },
 IsAdaptivityEnabled: function(){ return this.adaptivityMode !== 0; },
 SetAdaptiveMode: function(data) {
  this.adaptivityMode = data.adaptivityMode;
  this.allowOnlyOneAdaptiveDetailExpanded = data.allowOnlyOneAdaptiveDetailExpanded;
  this.hideDataCellsWindowInnerWidth = data.hideDataCellsWindowInnerWidth;
  this.adaptiveDetailColumnCount = data.adaptiveDetailColumnCount;
  this.adaptiveColumnsOrder = data.adaptiveColumnsOrder;
  this.allowTextTruncationInAdaptiveMode = data.allowTextTruncationInAdaptiveMode;
 }, 
 CalculateAdaptivity: function(){
  if(!this.IsAdaptivityEnabled()) return;
  this.ResetAdaptivity();
  if(this.adaptivityMode === 1) {
   while(this.IsColumnsContentCut()){
    if(!this.HideAdaptiveColumns())
     break;
   }
  }
  else if(this.adaptivityMode === 2) {
   if(this.hideDataCellsWindowInnerWidth > 0 && ASPx.GetCurrentDocumentWidth() <= this.hideDataCellsWindowInnerWidth){
    this.UpdateDataRowsVisibility(false);
    this.ShowAdaptiveHeaderPanel();    
    ASPx.SetElementDisplay(this.GetFilterRow(), false);
    this.UpdateAdaptiveFoorerPanelVisibility(true);
   }
  }
  this.UpdateAdaptiveGroupPanelVisibility(this.hasAdaptiveElements);
  this.UpdateAdaptiveDetails();
  this.UpdateAdaptivitySelector();
  this.UpdateLastVisibleRow();
 },
 RestoreAdaptivityState: function(){
  if(!this.IsAdaptivityEnabled()) return;
  for(var i = 0; i < this.visibleAdaptiveDetailVisibleIndices.length; i ++){
   var visibleIndex = this.visibleAdaptiveDetailVisibleIndices[i];
   if(!this.IsAdaptiveDetailsVisible(visibleIndex))
    this.ToggleAdaptiveDetails(visibleIndex, true);
  }
  if(this.adaptiveScrollTop){
   this.SetVerticalScrollPosition(this.adaptiveScrollTop);
   this.adaptiveScrollTop = null;
  }
  var batchEditHelper = this.GetBatchEditHelper();
  if(batchEditHelper)
   batchEditHelper.ApplyServerState();
  this.adaptivePagerEmptyRows = [];
 },
 ResetAdaptivity: function(){
  if(!this.IsAdaptivityEnabled()) return;
  if(this.adaptivityMode === 2){
   this.UpdateDataRowsVisibility(true);
   this.HideAdaptiveHeaderPanel();
   ASPx.SetElementDisplay(this.GetFilterRow(), true);
   this.UpdateAdaptiveFoorerPanelVisibility(false);
  }
  this.UpdateAdaptiveGroupPanelVisibility();
  this.ShowAdaptiveColumns();
  this.RestoreAdaptiveDetails();
 },
 IsColumnsContentCut: function() {
  var tables = [ this.GetMainTable() ];
  var tableHelper = this.GetTableHelper();
  if(tableHelper) {
   tables.push(tableHelper.GetHeaderTable());
   tables.push(tableHelper.GetFooterTable());
  }
  for(var i = 0; i < tables.length; i++) {
   if(this.IsColumnsContentCutCore(tables[i]))
    return true;
  }
  return false;
 },
 IsColumnsContentCutCore: function(table) {
  if(!table) return false;
  var result = false;
  if(table.style.tableLayout === "fixed"){
   this.HideCellsWithColSpan(table);
   this.ForEachCell(table, 
    function(cell) { 
     if(!this.NeedCheckCellContentCut(cell)) return;
     if(cell.colSpan == 1 && cell.offsetWidth < cell.scrollWidth){
      result = true;
      return true;
     }
    });
  }
  else{
   var width = table.offsetWidth;
   this.ForEachCell(table, 
    function(cell) {
     if(!this.NeedCheckCellContentCut(cell)) return;
     ASPx.Attr.ChangeStyleAttribute(cell, "display", "none");
     if(table.offsetWidth < width){
      result = true;
      return true;
     }
    });
  }
  this.RestoreCellsVisibility(table);
  return result;
 },
 NeedCheckCellContentCut: function(cell){
  if(ASPx.ElementContainsCssClass(cell, this.AdaptiveHiddenCssClass) || 
   (ASPx.ElementContainsCssClass(cell, this.HeaderCellCssClass) && cell.cellIndex < this.indentColumnCount ) ||
   ASPx.ElementContainsCssClass(cell, this.CommandColumnCellCssClass) ||
   ASPx.ElementContainsCssClass(cell, this.InlineEditCellCssClass) ||
   ASPx.ElementContainsCssClass(cell, this.DetailButtonCellCssClass) ||
   ASPx.ElementContainsCssClass(cell, this.AdaptiveIndentCellCssClass) ||
   ASPx.ElementContainsCssClass(cell, this.IndentCellCssClass) ||
   ASPx.ElementContainsCssClass(cell.parentNode, this.GroupRowCssClass)) return false;
  if(cell.parentNode.id.indexOf(this.DataRowID) > 0){
   var columnIndex = this.GetColumnIndexByDataCell(cell);
   if(columnIndex > -1 && this.allowTextTruncationInAdaptiveMode[columnIndex])
    return false;
  }
  return true;
 },
 HideCellsWithColSpan: function(table){
  this.ForEachCell(table, 
   function(cell) { 
    if(cell.colSpan > 1 && !ASPx.ElementContainsCssClass(cell, this.HeaderCellCssClass))
     ASPx.Attr.ChangeStyleAttribute(cell, "display", "none");
   });
 },
 RestoreCellsVisibility: function(table){
  this.ForEachCell(table, 
   function(cell) { 
    ASPx.Attr.RestoreStyleAttribute(cell, "display"); 
   });
 },
 DescreaseCellColSpan: function(cell){
  if(!cell.originalColSpan)
   cell.originalColSpan = cell.colSpan;
  if(cell.colSpan > 1)
   cell.colSpan = cell.colSpan - 1;
 },
 RestoreCellColSpan: function(cell){
  if(cell.originalColSpan)
   cell.colSpan = cell.originalColSpan;
 },
 ForEachCell: function(table, method){
  var shouldBreak = false;
  for(var i = 0; i < table.rows.length; i++){
   for(var j = 0; j < table.rows[i].cells.length; j++){
    var cell = table.rows[i].cells[j];
    shouldBreak = method.call(this, cell);
    if(shouldBreak)
     break;
   }
   if(shouldBreak)
    break;
  }
 },
 GetVisibleRowsIndicesForAdaptivity: function(){
  if(this.GetBatchEditHelper()) 
   return this.GetBatchEditHelper().GetVisibleRowsIndicesForAdaptivity();
  var indices = [];
  var start = this.GetTopVisibleIndex();
  var end = start + this.GetVisibleRowsOnPage();
  for(var i = start; i < end; i++) 
   indices.push(i);
  if(this.IsInlineEditMode() && this.IsNewRowEditing()) 
   indices.push(this.NewRowVisibleIndex);
  return indices;
 },
 ShowAdaptiveColumns: function(){
  for(var i = 0; i < this.adaptiveColumnsOrder.length; i++) {
   var columnIndex = this.adaptiveColumnsOrder[i];
   this.ShowAdaptiveColumn(columnIndex);
  }
  this.hasAdaptiveElements = false;
 },
 HideAdaptiveColumns: function(){
  for(var i = 0; i < this.adaptiveColumnsOrder.length - 1; i++){
   var columnIndex = this.adaptiveColumnsOrder[i];
   var column = this.GetColumn(columnIndex);
   if(column.adaptiveHidden) continue;
   if(ASPx.Data.ArrayIndexOf(this.GetVisibleColumnIndices(), columnIndex) == -1) continue;
   this.HideAdaptiveColumn(columnIndex);
   this.hasAdaptiveElements = true;
   return true;
  }
  return false;
 },
 ShowAdaptiveColumn: function(columnIndex){
  var sampleAdaptiveDetailCell = this.GetSampleAdaptiveDetailCell();
  if(sampleAdaptiveDetailCell) this.RestoreCellColSpan(sampleAdaptiveDetailCell);
  var indices = this.GetVisibleRowsIndicesForAdaptivity();
  for(var i = 0; i < indices.length; i++) 
   this.ShowAdaptiveDataRow(indices[i], columnIndex);
  this.ChangeAdaptiveEmptyPagerCellsVisibility(columnIndex, true);
  this.ShowAdaptiveColumnHeader(columnIndex, false);
  if(this.IsInlineEditMode()) {
   var editingCell = this.GetEditingCell(columnIndex);
   if(editingCell) ASPx.RemoveClassNameFromElement(editingCell, this.AdaptiveHiddenCssClass);
  }
  var editingErrorCell = this.GetEditingErrorCell();
  if(editingErrorCell) this.RestoreCellColSpan(editingErrorCell);
  if(this.GetBatchEditHelper()) {
   var errorRowIndices = this.GetBatchEditHelper().GetVisibleRowsIndicesForAdaptivity();
   for(var i = 0; i < indices.length; i++) {
    var errorCell = this.GetEditingErrorCell(this.GetBatchEditHelper().GetItemError(i));
    if(errorCell) this.RestoreCellColSpan(errorCell);
   }
  }
  var filterCell = this.GetFilterCell(columnIndex);
  if(filterCell) ASPx.RemoveClassNameFromElement(filterCell, this.AdaptiveHiddenCssClass);
  var footerCell = this.GetFooterCell(columnIndex);
  if(footerCell) ASPx.RemoveClassNameFromElement(footerCell, this.AdaptiveHiddenCssClass);
  var groupFooterCells = this.GetGroupFooterCells(columnIndex);
  for(var i = 0; i < groupFooterCells.length; i++)
   ASPx.RemoveClassNameFromElement(groupFooterCells[i], this.AdaptiveHiddenCssClass);
  var armCells = this.GetArmatureCells(columnIndex);
  if(armCells) {
   for(var index in armCells){
    if(!armCells[index]) continue;
    ASPx.RemoveClassNameFromElement(armCells[index], this.AdaptiveHiddenCssClass);
   }
  }
  var editFormCell = this.GetEditFormTableCell();
  if(editFormCell) this.RestoreCellColSpan(editFormCell);
  var emptyDataItemCell = this.GetEmptyDataItemCell();
  if(emptyDataItemCell) this.RestoreCellColSpan(emptyDataItemCell);
  this.GetColumn(columnIndex).adaptiveHidden = false;
 },
 ShowAdaptiveDataRow: function(visibleIndex, columnIndex){
  if(this.IsGroupRow(visibleIndex)) {
   var groupCell = this.GetGroupCell(visibleIndex);
   if(groupCell) this.RestoreCellColSpan(groupCell);
  }
  else {
   var cell = this.GetDataCell(this.GetAdaptiveDataRow(visibleIndex), columnIndex);
   if(cell) ASPx.RemoveClassNameFromElement(cell, this.AdaptiveHiddenCssClass);
  }
  var previewCell = this.GetPreviewCell(visibleIndex);
  if(previewCell) this.RestoreCellColSpan(previewCell);
  var detailCell = this.GetDetailCell(visibleIndex);
  if(detailCell) this.RestoreCellColSpan(detailCell);
  var adaptiveDetailCell = this.GetAdaptiveDetailCell(visibleIndex);
  if(adaptiveDetailCell) this.RestoreCellColSpan(adaptiveDetailCell);
 },
 ShowAdaptiveColumnHeader: function(columnIndex, isBand){
  var headerCell = this.GetHeader(columnIndex, false);
  if(!headerCell) return;
  ASPx.RemoveClassNameFromElement(headerCell, this.AdaptiveHiddenCssClass);
  if(isBand) 
   this.RestoreCellColSpan(headerCell);
  var column = this.GetColumn(columnIndex);
  if(column.parentIndex > -1) 
   this.ShowAdaptiveColumnHeader(column.parentIndex, true);
 },
 HideAdaptiveColumn: function(columnIndex){
  var sampleAdaptiveDetailCell = this.GetSampleAdaptiveDetailCell();
  if(sampleAdaptiveDetailCell) this.DescreaseCellColSpan(sampleAdaptiveDetailCell);
  var indices = this.GetVisibleRowsIndicesForAdaptivity();
  for(var i = 0; i < indices.length; i++) 
   this.HideAdaptiveDataRow(indices[i], columnIndex);
  this.ChangeAdaptiveEmptyPagerCellsVisibility(columnIndex, false);
  this.HideAdaptiveColumnHeader(columnIndex, false);
  if(this.IsInlineEditMode()) {
   var editingCell = this.GetEditingCell(columnIndex);
   if(editingCell) ASPx.AddClassNameToElement(editingCell, this.AdaptiveHiddenCssClass);
  }
  var editingErrorCell = this.GetEditingErrorCell();
  if(editingErrorCell) this.DescreaseCellColSpan(editingErrorCell);
  if(this.GetBatchEditHelper()) {
   var errorRowIndices = this.GetBatchEditHelper().GetVisibleRowsIndicesForAdaptivity();
   for(var i = 0; i < indices.length; i++) {
    var errorCell = this.GetEditingErrorCell(this.GetBatchEditHelper().GetItemError(i));
    if(errorCell) this.DescreaseCellColSpan(errorCell);
   }
  }
  var filterCell = this.GetFilterCell(columnIndex);
  if(filterCell) ASPx.AddClassNameToElement(filterCell, this.AdaptiveHiddenCssClass);
  var footerCell = this.GetFooterCell(columnIndex);
  if(footerCell) ASPx.AddClassNameToElement(footerCell, this.AdaptiveHiddenCssClass);
  var groupFooterCells = this.GetGroupFooterCells(columnIndex);
  for(var i = 0; i < groupFooterCells.length; i++)
   ASPx.AddClassNameToElement(groupFooterCells[i], this.AdaptiveHiddenCssClass);
  var armCells = this.GetArmatureCells(columnIndex);
  if(armCells) {
   for(var index in armCells){
    if(!armCells[index]) continue;
    ASPx.AddClassNameToElement(armCells[index], this.AdaptiveHiddenCssClass);
   }
  }
  var editFormCell = this.GetEditFormTableCell();
  if(editFormCell) this.DescreaseCellColSpan(editFormCell);
  var emptyDataItemCell = this.GetEmptyDataItemCell();
  if(emptyDataItemCell) this.DescreaseCellColSpan(emptyDataItemCell);
  this.GetColumn(columnIndex).adaptiveHidden = true;
 },
 ChangeAdaptiveEmptyPagerCellsVisibility: function(columnIndex, show) {
  var rows = this.GetEmptyPagerRows();
  if(rows.length > 0) {
   var changeVisibilityFunc = show ? ASPx.RemoveClassNameFromElement : ASPx.AddClassNameToElement;
   for(var i = 0; i < rows.length; ++i)
    changeVisibilityFunc(rows[i].cells[columnIndex], this.AdaptiveHiddenCssClass);
  }
 },
 GetEmptyPagerRows: function() {
  if(this.adaptivePagerEmptyRows.length == 0)
   this.adaptivePagerEmptyRows = this.GetMainTable().getElementsByClassName(this.EmptyPagerRowCssClass);
  return this.adaptivePagerEmptyRows;
 },
 HideAdaptiveDataRow: function(visibleIndex, columnIndex){
  if(this.IsGroupRow(visibleIndex)) {
   var groupCell = this.GetGroupCell(visibleIndex);
   if(groupCell) this.DescreaseCellColSpan(groupCell);
  }
  else {
   var cell = this.GetDataCell(this.GetAdaptiveDataRow(visibleIndex), columnIndex);
   if(cell) ASPx.AddClassNameToElement(cell, this.AdaptiveHiddenCssClass);
  }
  var previewCell = this.GetPreviewCell(visibleIndex);
  if(previewCell) this.DescreaseCellColSpan(previewCell);
  var detailCell = this.GetDetailCell(visibleIndex);
  if(detailCell) this.DescreaseCellColSpan(detailCell);
  var adaptiveDetailCell = this.GetAdaptiveDetailCell(visibleIndex);
  if(adaptiveDetailCell) this.DescreaseCellColSpan(adaptiveDetailCell);
 },
 HideAdaptiveColumnHeader: function(columnIndex, isBand){
  var headerCell = this.GetHeader(columnIndex, false);
  if(!headerCell) return;
  if(!isBand) 
   ASPx.AddClassNameToElement(headerCell, this.AdaptiveHiddenCssClass);
  else {
   if(headerCell.colSpan === 1)
    ASPx.AddClassNameToElement(headerCell, this.AdaptiveHiddenCssClass);
   else
    this.DescreaseCellColSpan(headerCell);
  }
  var column = this.GetColumn(columnIndex);
  if(column.parentIndex > -1) 
   this.HideAdaptiveColumnHeader(column.parentIndex, true);
 },
 UA_ShowAdaptiveDetail: function(visibleIndex) {
  this.ToggleAdaptiveDetails(visibleIndex);
 },
 UA_HideAdaptiveDetail: function(visibleIndex) {
  this.ToggleAdaptiveDetails(visibleIndex);
 },
 IsAdaptiveDetailsVisible: function(visibleIndex){
  if(!this.hasAdaptiveElements) return false;
  var row = this.GetAdaptiveDetailRow(visibleIndex);
  return row && ASPx.GetElementDisplay(row);
 },
 ToggleAdaptiveDetails: function(visibleIndex, preventStoreIndices){
  if(!this.hasAdaptiveElements) return;
  if(!preventStoreIndices)
   ASPx.Data.ArrayRemove(this.visibleAdaptiveDetailVisibleIndices, visibleIndex);
  if(ASPx.IsExists(this.activeAdaptiveDetailVisibleIndex) && this.activeAdaptiveDetailVisibleIndex != visibleIndex)
   this.UpdateRowAdaptiveDetails(this.activeAdaptiveDetailVisibleIndex, true);
  var newVisible = !this.IsAdaptiveDetailsVisible(visibleIndex);
  this.UpdateRowAdaptiveDetails(visibleIndex, true);
  this.UpdateDataRowBordersVisibility(visibleIndex, newVisible);
  if(this.allowOnlyOneAdaptiveDetailExpanded)
   this.activeAdaptiveDetailVisibleIndex = newVisible ? visibleIndex : null;
  if(!preventStoreIndices && newVisible)
   this.visibleAdaptiveDetailVisibleIndices.push(visibleIndex)
 },
 UpdateDataRowBordersVisibility: function(visibleIndex, visible){
  var dataRow = this.GetAdaptiveDataRow(visibleIndex);
  if(!dataRow) return;
  for(var i = 0; i < this.indentColumnCount; i++){
   var cell = dataRow.cells[i];
   if(ASPx.ElementHasCssClass(cell, this.DetailIndentCellCssClass) || 
    ASPx.ElementHasCssClass(cell, this.DetailButtonCellCssClass) ||
    ASPx.ElementHasCssClass(cell, this.AdaptiveIndentCellCssClass)) continue;
   ASPx.Attr.RestoreStyleAttribute(cell, "border-bottom-width");
   if(visible)
    ASPx.Attr.ChangeStyleAttribute(cell, "border-bottom-width", "0px");
  }
 },
 GetShowAdaptiveDetailButton: function(visibleIndex){
  var row = this.GetAdaptiveDataRow(visibleIndex);
  var cell = ASPx.GetNodeByClassName(row, this.AdaptiveIndentCellCssClass);
  return ASPx.GetChildByClassName(cell, this.AdaptiveDetailShowButtonCssClass);
 },
 GetHideAdaptiveDetailButtonCore: function(row){
  var cell = ASPx.GetNodeByClassName(row, this.AdaptiveIndentCellCssClass);
  return ASPx.GetChildByClassName(cell, this.AdaptiveDetailHideButtonCssClass);
 },
 GetHideAdaptiveDetailButton: function(visibleIndex){
  var row = this.GetAdaptiveDetailRow(visibleIndex);
  var btn = this.GetHideAdaptiveDetailButtonCore(row);
  if(!btn){
   btn = this.GetHideAdaptiveDetailButtonCore(this.GetAdaptiveDataRow(visibleIndex));
   if(btn){
    var cell = ASPx.GetNodeByClassName(row, this.AdaptiveIndentCellCssClass);
    cell.innerHTML = "";
    cell.appendChild(btn);
   }
  }
  return btn;
 },
 UpdateRowAdaptiveButtonsVisibility: function(visibleIndex, visible){
  var showBtn = this.GetShowAdaptiveDetailButton(visibleIndex);
  if(showBtn) ASPx.SetElementDisplay(showBtn, !visible);
  var hideBtn = this.GetHideAdaptiveDetailButton(visibleIndex);
  if(hideBtn) hideBtn.style.display = visible ? "inherit" : "none";
 },
 UpdateDataRowsVisibility: function(visible){
  var indices = this.GetVisibleRowsIndicesForAdaptivity();
  for(var i = 0; i < indices.length; i++) 
   this.UpdateDataRowVisibility(indices[i], visible);
  for(var i = 0; i < this.GetColumnCount(); i++)
   this.GetColumn(i).adaptiveHidden = !visible;
  this.hasAdaptiveElements = !visible;
 },
 UpdateDataRowVisibility: function(visibleIndex, visible){
  if(this.IsGroupRow(visibleIndex)) return;
  var row = this.GetAdaptiveDataRow(visibleIndex);
  if(!row) return;
  if(!visible)
   ASPx.AddClassNameToElement(row, this.AdaptiveHiddenCssClass);
  else
   ASPx.RemoveClassNameFromElement(row, this.AdaptiveHiddenCssClass);
 },
 UpdateHeaderRowsVisibility: function(visible){
  var headerScroll = this.GetHeaderScrollContainer();
  if(headerScroll) {
   ASPx.SetElementDisplay(headerScroll, visible);
   return;
  }
  ASPx.SetElementDisplay(this.GetHeaderRow(0), visible);
  var headerRowCount = this.GetHeaderMatrix().GetRowCount();  
  for(var i = 1; i < headerRowCount; i++) 
   ASPx.SetElementDisplay(this.GetHeaderRow(i), visible);
 },  
 UpdateAdaptiveGroupPanelVisibility: function(show){
  var groupPanel = ASPx.GetNodesByPartialClassName(this.GetMainElement(), this.GroupPanelCssClass)[0];
  var adaptiveGroupPanel = this.GetAdaptiveGroupPanel();
  if(!groupPanel || !adaptiveGroupPanel) return;
  var source = show ? groupPanel : adaptiveGroupPanel;
  var headers = ASPx.GetNodesByPartialClassName(source, this.HeaderCellCssClass);
  for(var i = 0; i < headers.length; i++){
   var header = headers[i];
   if(show) {
    var container = this.GetAdaptiveHeaderContainer(this.getColumnIndex(header.id), adaptiveGroupPanel);
    header.savedNeighbor = header.nextSibling;
    ASPx.ChangeElementContainer(header, container);
   } else {
    var neighbor = header.savedNeighbor || this.GetGroupPanel();
    neighbor.parentElement.insertBefore(header, neighbor);
     }
   header.adaptiveMoved = show;
  }
  this.UpdateScrollableControls();
  ASPx.SetElementDisplay(groupPanel, !show);
  ASPx.SetElementDisplay(adaptiveGroupPanel, show);  
 },
 HideAdaptiveHeaderPanel: function(){
  var adaptivePanel = this.GetAdaptiveHeaderPanel();
  if(adaptivePanel){
   this.MoveHeadersToHeaderRow();
   this.RestoreAdaptiveHeadersHeight();
   ASPx.SetElementDisplay(adaptivePanel, false);
   this.UpdateHeaderRowsVisibility(true);
   }
 },
 ShowAdaptiveHeaderPanel: function(){
  var adaptivePanel = this.GetAdaptiveHeaderPanel();
  if(adaptivePanel){
   this.MoveHeadersToAdaptivePanel();
   ASPx.SetElementDisplay(adaptivePanel, true);
   this.CorrectAdaptiveHeadersHeight();
   this.UpdateHeaderRowsVisibility(false);
  }
 },
 UpdateAdaptiveFoorerPanelVisibility: function(visible){
  ASPx.SetElementDisplay(this.GetAdaptiveFooterPanel(), visible);
  var footerElement = this.GetFooterScrollContainer() || this.GetFooterRow();
  ASPx.SetElementDisplay(footerElement, !visible);
 },
 GetVisibleHeaderCells: function(){
  var result = [];
  var indices = this.GetVisibleColumnIndices();
  for(var i = 0; i < indices.length; i++){
   var headerCell = this.GetHeader(indices[i]);
   if(headerCell)
    result.push(headerCell);
  }
  return result;
 },
 MoveHeadersToHeaderRow: function(){
  ASPx.Data.ForEach(this.GetVisibleHeaderCells(), function(headerCell){  
   this.MoveHeaderToHeaderRow(headerCell);
  }.aspxBind(this));
 },
 MoveHeadersToAdaptivePanel: function(){
  this.SaveHeadersPositionInfo();
  ASPx.Data.ForEach(this.GetVisibleHeaderCells(), function(headerCell){  
   this.MoveHeaderToAdaptiveHeaderPanel(headerCell);
  }.aspxBind(this));
 },
 SaveHeadersPositionInfo: function(){
  ASPx.Data.ForEach(this.GetVisibleHeaderCells(), function(headerCell){
   headerCell.savedCellIndex = headerCell.cellIndex;
   headerCell.savedHeaderRow = headerCell.parentElement;
  }.aspxBind(this));
 },
 MoveHeaderToHeaderRow: function(headerCell){
  if(headerCell.savedHeaderRow && headerCell.adaptiveMoved){
   var headerRow = headerCell.savedHeaderRow;
   if(headerCell.savedCellIndex >= 0 && headerCell.savedCellIndex < headerRow.cells.length)
    headerRow.insertBefore(headerCell, headerRow.cells[headerCell.savedCellIndex]);   
   else
    headerRow.appendChild(headerCell);
   ASPx.Attr.RestoreStyleAttribute(headerCell, "width");
   headerCell.adaptiveMoved = false;
  }
 },
 MoveHeaderToAdaptiveHeaderPanel: function(headerCell){
  var container = this.GetAdaptiveHeaderContainer(this.getColumnIndex(headerCell.id), this.GetAdaptiveHeaderPanel());   
  ASPx.ChangeElementContainer(headerCell, container);
  ASPx.Attr.ChangeStyleAttribute(headerCell, "width", "");
  headerCell.adaptiveMoved = true;
 },
 CorrectAdaptiveHeadersHeight: function(){
  var cells = this.GetVisibleHeaderCells();
  var maxHeight = 0;
  for(var i = 0; i < cells.length; i++){
   var headerContentHeight = cells[i].clientHeight - ASPx.GetTopBottomPaddings(cells[i]);
   if(maxHeight < headerContentHeight) 
    maxHeight = headerContentHeight;
  }
  for(var i = 0; i < cells.length; i++){
   ASPx.Attr.ChangeStyleAttribute(cells[i], "height", maxHeight + "px");
  }
 },
 RestoreAdaptiveHeadersHeight: function(){
  ASPx.Data.ForEach(this.GetVisibleHeaderCells(), function(headerCell){
   ASPx.Attr.RestoreStyleAttribute(headerCell, "height");
  }.aspxBind(this));
 },
 UpdateAdaptiveDetails: function(){
  var indices = this.GetVisibleRowsIndicesForAdaptivity();
  for(var i = 0; i < indices.length; i++) 
   this.UpdateRowAdaptiveDetails(indices[i]);
 },
 RestoreAdaptiveDetails: function(){
  var indices = this.GetVisibleRowsIndicesForAdaptivity();
  for(var i = 0; i < indices.length; i++) 
   this.RestoreRowAdaptiveDetails(indices[i]);
 },
 UpdateRowAdaptiveDetails: function(visibleIndex, changeVisible){
  var forceCreate = changeVisible || (this.hasAdaptiveElements && this.adaptivityMode === 2);
  var row = this.GetAdaptiveDetailRow(visibleIndex, forceCreate);
  if(row) {
   if(this.hasAdaptiveElements && this.adaptivityMode === 2) {
    ASPx.SetElementDisplay(row, true);
    this.UpdateItemStyle(visibleIndex);
   }
   if(changeVisible) {
    var visible = !ASPx.GetElementDisplay(row);
    ASPx.SetElementDisplay(row, visible);
    this.UpdateRowAdaptiveButtonsVisibility(visibleIndex, visible);
    this.ReplaceBorderBottomWidthRules(visibleIndex, visible);
   }
   if(!this.hasAdaptiveElements){
    ASPx.SetElementDisplay(row, false);
    this.UpdateRowAdaptiveButtonsVisibility(visibleIndex, false);
    this.UpdateDataRowBordersVisibility(visibleIndex, false);
    this.activeAdaptiveDetailVisibleIndex = null;
    this.visibleAdaptiveDetailVisibleIndices = [];
   }
  }
  if(this.hasAdaptiveElements) {
   var cell = this.GetAdaptiveDetailCell(visibleIndex);
   if(cell) 
    this.CreateAdaptiveDetailsContent(cell, visibleIndex);
   this.UpdateDetailButton(visibleIndex, true);
  }
 },
 UpdateDetailButton: function(visibleIndex, moveFromDataRow) {
  if(this.adaptivityMode === 2) {
   var source = this.GetDetailButtonCell(visibleIndex, !moveFromDataRow);
   var target = this.GetDetailButtonCell(visibleIndex, moveFromDataRow);
   if(source && target)
    ASPx.MoveChildrenToElement(source, target);
  }
 },
 ReplaceBorderBottomWidthRules: function(visibleIndex, visible){
  if(!this.IsLastDataRow(visibleIndex)) return;
  this.UpdateLastVisibleRow();
  var dataRow = this.GetAdaptiveDataRow(visibleIndex);
  if(visible){
   var replaceBorderRules = false;
   for(var i = this.indentColumnCount; i < dataRow.cells.length; i++){
    var cell = dataRow.cells[i];
    if(cell.style.borderBottomWidth == "0px"){
     replaceBorderRules = true;
     ASPx.Attr.ChangeStyleAttribute(cell, "border-bottom-width", "");
    }
   }
   if(!replaceBorderRules) return;
   ASPx.Attr.ChangeStyleAttribute(this.GetAdaptiveDetailCell(visibleIndex), "border-bottom-width", "0px");
   var adaptiveDetailIndentCell = this.GetAdaptiveDetailIndentCell(visibleIndex);
   if(adaptiveDetailIndentCell)
    ASPx.Attr.ChangeStyleAttribute(adaptiveDetailIndentCell, "border-bottom-width", "0px");
  } else{
   var adaptiveDetailCell = this.GetAdaptiveDetailCell(visibleIndex);
   if(adaptiveDetailCell.style.borderBottomWidth != "0px") return;
   ASPx.Attr.RestoreStyleAttribute(adaptiveDetailCell, "border-bottom-width");
   var adaptiveDetailIndentCell = this.GetAdaptiveDetailIndentCell(visibleIndex);
   if(adaptiveDetailIndentCell)
    ASPx.Attr.RestoreStyleAttribute(adaptiveDetailIndentCell, "border-bottom-width");
   for(var i = this.indentColumnCount; i < dataRow.cells.length; i++){
    var cell = dataRow.cells[i];
    ASPx.Attr.RestoreStyleAttribute(cell, "border-bottom-width");
   }
  }
 },
 IsLastDataRow: function(visibleIndex) {
  return visibleIndex == this.visibleStartIndex + this.pageRowCount - 1 && (this.IsLastPage() || this.pageIndex < 0);
 },
    GetAdaptiveDetailIndentCell: function(visibleIndex){
  var row = this.GetAdaptiveDetailRow(visibleIndex);
  return ASPx.GetNodeByClassName(row, this.AdaptiveIndentCellCssClass);
 },
 UpdateLastVisibleRow: function() {
  var tBody = ASPx.GetNodeByTagName(this.GetMainTable(), "TBODY", 0);
  var prevLastRows = ASPx.GetChildNodesByClassName(tBody, this.LastVisibleRowClassName);
  if(prevLastRows.length > 0)
   ASPx.RemoveClassNameFromElement(prevLastRows[0], this.LastVisibleRowClassName);
  var lastRow = this.FindLastVisibleRow();
  if(lastRow)
   ASPx.AddClassNameToElement(lastRow, this.LastVisibleRowClassName);
 },
 FindLastVisibleRow: function() {
  var dataGroupRowRegEx = this.GetItemVisibleIndexRegExp(true);
  var rows = this.GetMainTable().rows;
  for(var i = rows.length - 1; i >= 0; i--) {
   var row = rows[i];
   if(ASPx.ElementContainsCssClass(row, this.EmptyPagerRowCssClass))
    return row;
   if((dataGroupRowRegEx.test(row.id) || row.id && row.id.indexOf(this.EditingRowID) > -1) && ASPx.GetElementDisplay(row))
    return row;
  }
  return this.GetEmptyDataItem();
 },
 RestoreRowAdaptiveDetails: function(visibleIndex){
  var cell = this.GetAdaptiveDetailCell(visibleIndex);
  if(cell) this.RestoreAdaptiveDetailsContent(cell, visibleIndex);
  this.UpdateDetailButton(visibleIndex, false);
 },
 CheckAdaptiveDetailsFormLayout: function(parentElement) {
  if(this.hasAdaptiveDetailsFormLayout !== null || this.adaptivityMode !== 2) return;
  this.hasAdaptiveDetailsFormLayout = this.GetAdaptiveDetailsFormLayout(parentElement) != null;
 },
 GetAdaptiveDetailsFormLayout: function(parentElement) {
  var formLayoutElement = this.GetAdaptiveDetailsFormLayoutElement(parentElement);
  return formLayoutElement ? ASPx.GetControlCollection().Get(formLayoutElement.id) : null;
 },
 GetAdaptiveDetailsFormLayoutElement: function(parentElement) {
  if(!ASPx.FormLayoutConsts) return null;
  return ASPx.GetChildByPartialClassName(parentElement,  ASPx.FormLayoutConsts.FORM_LAYOUT_PARTIAL_CLASS_NAME)
 },
 CreateAdaptiveDetailsContent: function(parentElement, visibleIndex){
  this.CheckAdaptiveDetailsFormLayout(parentElement);
  if(this.hasAdaptiveDetailsFormLayout)
   this.CreateAdaptiveDetailsFormLayoutContent(parentElement, visibleIndex);
  else
   this.CreateAdaptiveDetailsSimpleContent(parentElement, visibleIndex);
 },
 CreateAdaptiveDetailsSimpleContent: function(parentElement, visibleIndex){
  if(parentElement.childNodes.length > 0) return;
  var table = document.createElement("TABLE");
  parentElement.appendChild(table);
  table.className = this.AdaptiveDetailTableCssClass;
  table.border = 0;
  table.cellPadding = 0;
  table.cellSpacing = 0;
  var tbody = document.createElement("TBODY");
  table.appendChild(tbody);
  var visibleIndices = this.GetVisibleColumnIndices();
  var columnCount = this.adaptiveDetailColumnCount, tr;
  for(var i = 0; i < visibleIndices.length; i++) {
   var column = this.GetColumn(visibleIndices[i]);
   if(!column || !column.adaptiveHidden) continue;
   if(columnCount == this.adaptiveDetailColumnCount) {
    tr = document.createElement("TR");
    tbody.appendChild(tr);
   }
   var dataColSpan = 1;
   var header = this.GetHeader(column.index);
   if(column.isCommandColumn) {
    if(ASPx.GetChildByTagName(header, "TABLE") || this.adaptivityMode === 2) 
     dataColSpan = 3 * this.adaptiveDetailColumnCount - 1;
    else
     this.CreateAdaptiveDetailsTitleCell(tr, header.innerHTML + ":");
   }
   else {
    var textNode = ASPx.GetNodeByTagName(header, "TD", 0) || header;
    this.CreateAdaptiveDetailsTitleCell(tr, ASPx.GetInnerText(textNode) + ":");
   }
   var dataCell = this.CreateAdaptiveDetailsDataCell(tr, column, dataColSpan);
   var sampleDataCell = this.GetDataCell(this.GetAdaptiveDataRow(visibleIndex), column.index);
   ASPx.MoveChildrenToElement(sampleDataCell, dataCell);
   this.StoreAdaptiveDetailCell(parentElement, column.index, dataCell);
   columnCount--;
   if(columnCount == 0 || column.isCommandColumn) 
    columnCount = this.adaptiveDetailColumnCount;
   else if(!column.isCommandColumn) {
    var spacerCell = document.createElement("TD");
    spacerCell.className = this.AdaptiveDetailSpacerCellCssClass;
    tr.appendChild(spacerCell);
   }
   if(this.GetBatchEditHelper())
    this.GetBatchEditHelper().UpdateItem(visibleIndex, [ column.index ], false, false, false);
  }
 },
 CreateAdaptiveDetailsDataCell: function(tr, column, dataColSpan){
  var dataCell = document.createElement("TD");
  dataCell.colSpan = dataColSpan;
  dataCell.className = (column.isCommandColumn ? this.AdaptiveDetailCommandCellCssClass : this.AdaptiveDetailDataCellCssClass);
  dataCell.columnIndex = column.index;
  tr.appendChild(dataCell);
  return dataCell;
 },
 CreateAdaptiveDetailsTitleCell: function(tr, captionHTML){
  var titleCell = document.createElement("TD");
  titleCell.className = this.AdaptiveDetailCaptionCellCssClass;
  tr.appendChild(titleCell);
  titleCell.innerHTML = captionHTML;
  return titleCell;
 },
 CreateAdaptiveDetailsFormLayoutContent: function(parentElement, visibleIndex){
  this.CreateAdaptiveDetailsFormLayoutClientObject(parentElement, visibleIndex);
  for(var i = 0; i < this.GetColumnCount(); i++) {
   var column = this.GetColumn(i);
   if(!column || !column.adaptiveHidden) continue;
   var sampleDataCell = this.GetDataCell(this.GetAdaptiveDataRow(visibleIndex), column.index);
   var dataCell = ASPx.GetNodeByClassName(parentElement, this.AdaptiveDetailLayoutItemContentCssClass + column.index);
   if(dataCell) {
    if(ASPx.Data.ArrayIndexOf(this.GetVisibleColumnIndices(), column.index) > -1) {
     dataCell.innerHTML = "";
     ASPx.MoveChildrenToElement(sampleDataCell, dataCell);
     var itemElement = ASPx.GetParentByPartialClassName(dataCell, ASPx.FormLayoutConsts.ITEM_SYSTEM_CLASS_NAME);
     if(itemElement) ASPxClientFormLayout.UpdateNestedControlTypeClassName(itemElement, this.IsEditingItem(visibleIndex));
     dataCell.columnIndex = column.index;
     this.StoreAdaptiveDetailCell(parentElement, column.index, dataCell);
    }
    else{
     var itemElement = dataCell.parentNode.parentNode.parentNode;
     if(itemElement.tagName === "TABLE")
      itemElement.style.visibility = "hidden";
     else
      itemElement.style.display = "none";
    }
   }
   if(this.GetBatchEditHelper())
    this.GetBatchEditHelper().UpdateItem(visibleIndex, [ column.index ], false, false, false);
  }
 },
 CreateAdaptiveDetailsFormLayoutClientObject: function(parentElement, visibleIndex){
  if(parentElement.formLayout) return;
  var sampleFormLayout = this.GetAdaptiveDetailsFormLayout(parentElement);
  if(sampleFormLayout) {
   var formLayoutName = sampleFormLayout.name + visibleIndex;
   this.GetAdaptiveDetailsFormLayoutElement(parentElement).id = formLayoutName;
   var formLayout = new ASPxClientFormLayout(formLayoutName);
   formLayout.adaptivityMode = sampleFormLayout.adaptivityMode;
   formLayout.switchToSingleColumnAtWindowInnerWidth = sampleFormLayout.switchToSingleColumnAtWindowInnerWidth;
   formLayout.alignItemCaptionsInAllGroups = sampleFormLayout.alignItemCaptionsInAllGroups;
   formLayout.leftAndRightCaptionsWidth = sampleFormLayout.leftAndRightCaptionsWidth;
   formLayout.showItemCaptionColon = sampleFormLayout.showItemCaptionColon;
   formLayout.AfterCreate();
   formLayout.AdjustControlCore();
   parentElement.formLayout = formLayout;
  }
 },
 StoreAdaptiveDetailCell: function(parentElement, columnIndex, dataCell){
  if(!parentElement.adaptiveDetailsCells)
   parentElement.adaptiveDetailsCells = [];
  parentElement.adaptiveDetailsCells[columnIndex] = dataCell;
 },
 RestoreAdaptiveDetailsContent: function(parentElement, visibleIndex){
  for(var i = 0; i < this.GetColumnCount(); i++) {
   var column = this.GetColumn(i);
   if(!column || !parentElement.adaptiveDetailsCells || !parentElement.adaptiveDetailsCells[column.index]) continue;
   var dataCell = this.GetDataCell(this.GetAdaptiveDataRow(visibleIndex), column.index);
   var storedDataCell = parentElement.adaptiveDetailsCells[column.index];
   if(storedDataCell) ASPx.MoveChildrenToElement(storedDataCell, dataCell);
   parentElement.adaptiveDetailsCells[column.index] = null;
   if(this.GetBatchEditHelper())
    this.GetBatchEditHelper().UpdateItem(visibleIndex, [ column.index ], false, false, false);
  }
  if(!this.hasAdaptiveDetailsFormLayout) 
   parentElement.innerHTML = "";
 },
 UpdateAdaptivitySelector: function() {
  if(!this.IsAdaptivityEnabled()) return;
  var cssClass = (this.adaptivityMode > 1) ? this.AdaptivityWithLimitEnabledCssClass : this.AdaptivityEnabledCssClass;
  if(this.hasAdaptiveElements)
   ASPx.AddClassNameToElement(this.GetMainElement(), cssClass);
  else
   ASPx.RemoveClassNameFromElement(this.GetMainElement(), cssClass);
 },
 OnCallbackFinalized: function() {
  this.ResetAdaptivity();
  this.activeAdaptiveDetailVisibleIndex = null;
  ASPxClientGridBase.prototype.OnCallbackFinalized.call(this);
  this.AdjustPagerControls();
  this.CalculateAdaptivity();
  this.RestoreAdaptivityState();
 },
 ProcessContextMenuItemClick: function(e) {
  var item = e.item;
  var elementInfo = item.menu.elementInfo;
  switch(item.name){
   case this.ContextMenuItems.ClearGrouping:
    this.ContextMenuClearGrouping();
    break;
   case this.ContextMenuItems.GroupByColumn:
    this.GroupBy(elementInfo.index);
    break;
   case this.ContextMenuItems.UngroupColumn:
    this.UnGroup(elementInfo.index);
    break;
   default:
    ASPxClientGridBase.prototype.ProcessContextMenuItemClick.call(this, e);
  }
 },
 GetContextMenuObjectTypes: function(){
  var objectTypes = { };
  objectTypes[this.name + "_" + "grouppanel"]        = "grouppanel";
  objectTypes[this.name + "_" + this.AdaptiveGroupPanelID]    = "grouppanel";
  objectTypes[this.name + this.HeaderRowID]          = "emptyheader";
  objectTypes[this.name + "_" + "col"]         = "header";
  objectTypes[this.name + this.CustomizationWindowSuffix + "_" + "col"]   = "header";
  objectTypes[this.name + "_" + "groupcol"]          = "header";
  objectTypes[this.name + "_" + this.DataRowID]         = "row";
  objectTypes[this.name + "_" + this.DetailRowID]       = "row";
  objectTypes[this.name + "_" + this.EmptyDataRowID]       = "emptyrow";
  objectTypes[this.name + "_" + this.GroupRowID]        = "grouprow";
  objectTypes[this.name + "_" + this.GroupRowID + "Exp"]      = "grouprow";
  objectTypes[this.name + "_" + this.FooterRowID]       = "footer";
  objectTypes[this.name + "_" + this.FilterRowID]       = "filterrow";
  return objectTypes;
 },
 SetWidth: function(width) {
  if(this.IsControlCollapsed())
   this.ExpandControl();
  var mainElemnt = this.GetMainElement();
  if(!ASPx.IsExistsElement(mainElemnt) || mainElemnt.offsetWidth === width) return;
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper)
   scrollHelper.OnSetWidth(width);
  this.ResetControlAdjustment();
  this.constructor.prototype.SetWidth.call(this, width);
  this.AssignEllipsisToolTips();
 },
 NeedCollapseControlCore: function() {
  return this.adaptivityMode === 1 || ASPxClientGridBase.prototype.NeedCollapseControlCore.call(this);
 },
 SortBy: function(column, sortOrder, reset, sortIndex){
    ASPxClientGridBase.prototype.SortBy.call(this, column, sortOrder, reset, sortIndex);
 },
 MoveColumn: function(column, columnMoveTo, moveBefore, moveToGroup, moveFromGroup){
  ASPxClientGridBase.prototype.MoveColumn.call(this, column, columnMoveTo, moveBefore, moveToGroup, moveFromGroup);
 },
 GroupBy: function(column, groupIndex, sortOrder){
  if(this.RaiseColumnGrouping(this._getColumnObjectByArg(column))) return;
  column = this._getColumnIndexByColumnArgs(column);
  if(!ASPx.IsExists(groupIndex)) groupIndex = "";
  if(!ASPx.IsExists(sortOrder)) sortOrder = "ASC";
  this.gridCallBack([ASPxClientGridViewCallbackCommand.Group, column, groupIndex, sortOrder]);
 },
 UnGroup: function(column){
  column = this._getColumnIndexByColumnArgs(column);
  this.GroupBy(column, -1);
 },
 ExpandAll: function(){
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ExpandAll]);
 },
 CollapseAll: function(){
  this.gridCallBack([ASPxClientGridViewCallbackCommand.CollapseAll]);
 },
 ExpandAllDetailRows: function(){
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ShowAllDetail]);
 },
 CollapseAllDetailRows: function(){
  this.gridCallBack([ASPxClientGridViewCallbackCommand.HideAllDetail]);
 },
 ExpandRow: function(visibleIndex, recursive){
  if(this.RaiseRowExpanding(visibleIndex)) return;
  recursive = !!recursive;
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ExpandRow, visibleIndex, recursive]);
 },
 CollapseRow: function(visibleIndex, recursive){
  if(this.RaiseRowCollapsing(visibleIndex)) return;
  recursive = !!recursive;
  this.gridCallBack([ASPxClientGridViewCallbackCommand.CollapseRow, visibleIndex, recursive]);
 },
 MakeRowVisible: function(visibleIndex) {
  if(!this.HasVertScroll()) return;
  var row = this.GetItem(visibleIndex);
  if(row == null && visibleIndex >= this.visibleStartIndex && visibleIndex < this.visibleStartIndex + this.pageRowCount) 
   row = this.GetEditingRow();
  if(row == null) return;
  this.GetScrollHelper().MakeRowVisible(row);
 },
 ExpandDetailRow: function(visibleIndex){
  var key = this.GetRowKey(visibleIndex);
  if(key == null) return;
  if(this.RaiseDetailRowExpanding(visibleIndex)) return;
  this.gridCallBack([ASPxClientGridViewCallbackCommand.ShowDetailRow, key]);
 },
 CollapseDetailRow: function(visibleIndex){
  var key = this.GetRowKey(visibleIndex);
  if(key == null) return;
  if(this.RaiseDetailRowCollapsing(visibleIndex)) return;
  this.gridCallBack([ASPxClientGridViewCallbackCommand.HideDetailRow, key]);
 },
 GetRowKey: function(visibleIndex) {
  return this.GetItemKey(visibleIndex);
 },
 StartEditRow: function(visibleIndex) {
    this.StartEditItem(visibleIndex);
 },
 StartEditRowByKey: function(key) {
  this.StartEditItemByKey(key);
 },
 IsNewRowEditing: function() {
  return this.IsNewItemEditing();
 },
 AddNewRow: function(){
    this.AddNewItem();
 },
 DeleteRow: function(visibleIndex){
  this.DeleteItem(visibleIndex);
 },
 DeleteRowByKey: function(key) {
  this.DeleteItemByKey(key);
 },
 GetFocusedRowIndex: function() {
  return this._getFocusedItemIndex();
 },
 SetFocusedRowIndex: function(visibleIndex) {
  return this._setFocusedItemIndex(visibleIndex);
 },
 SelectRows: function(visibleIndices, selected){
  this.SelectItemsCore(visibleIndices, selected, false);
 },
 SelectRowsByKey: function(keys, selected){
  this.SelectItemsByKey(keys, selected);
 },
 UnselectRowsByKey: function(keys){
  this.SelectRowsByKey(keys, false);
 },
 UnselectRows: function(visibleIndices){
  this.SelectRows(visibleIndices, false);
 },
 UnselectFilteredRows: function() {
  this.UnselectFilteredItemsCore();
 },
 SelectRowOnPage: function(visibleIndex, selected){
  if(!ASPx.IsExists(selected)) selected = true;
  this.SelectItem(visibleIndex, selected);
 },
 UnselectRowOnPage: function(visibleIndex){
  this.SelectRowOnPage(visibleIndex, false);
 },
 SelectAllRowsOnPage: function(selected){
  if(!ASPx.IsExists(selected)) selected = true;
  this._selectAllRowsOnPage(selected);
 },
 UnselectAllRowsOnPage: function(){
  this._selectAllRowsOnPage(false);
 },
 GetSelectedRowCount: function() {
  return this._getSelectedRowCount();
 },
 IsRowSelectedOnPage: function(visibleIndex) {
  return this._isRowSelected(visibleIndex);
 },
 IsGroupRow: function(visibleIndex) {
  return this.GetGroupRow(visibleIndex) != null;
 },
 IsDataRow: function(visibleIndex) {
  return this.GetDataRow(visibleIndex) != null;
 },
 IsGroupRowExpanded: function(visibleIndex) { 
  return this.GetExpandedGroupRow(visibleIndex) != null;
 },
 GetVertScrollPos: function() {
  return this.GetVerticalScrollPosition();
 },
 GetVerticalScrollPosition: function() {
  if(this.IsVirtualScrolling())
   return 0;
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper)
   return scrollHelper.GetVertScrollPosition();
  return 0;
 },
 GetHorzScrollPos: function() {
  return this.GetHorizontalScrollPosition();
 },
 GetHorizontalScrollPosition: function() {
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper)
   return scrollHelper.GetHorzScrollPosition();
  return 0;
 },
 SetVertScrollPos: function(value) {
  this.SetVerticalScrollPosition(value);
 },
 SetVerticalScrollPosition: function(value) {
  if(this.IsVirtualScrolling())
   return;
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper)
   scrollHelper.SetVertScrollPosition(value);
 },
 SetHorzScrollPos: function(value) {
  this.SetHorizontalScrollPosition(value);
 },
 SetHorizontalScrollPosition: function(value) {
  var scrollHelper = this.GetScrollHelper();
  if(scrollHelper)
   scrollHelper.SetHorzScrollPosition(value);
 },
 RaiseColumnGrouping: function(column) {
  if(!this.ColumnGrouping.IsEmpty()){
   var args = new ASPxClientGridViewColumnCancelEventArgs(column);
   this.ColumnGrouping.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseItemClick: function(visibleIndex, htmlEvent) {
  if(!this.RowClick.IsEmpty()){
   var args = new ASPxClientGridViewRowClickEventArgs(visibleIndex, htmlEvent);
   this.RowClick.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseItemDblClick: function(visibleIndex, htmlEvent) {
  if(!this.RowDblClick.IsEmpty()){
   ASPx.Selection.Clear(); 
   var args = new ASPxClientGridViewRowClickEventArgs(visibleIndex, htmlEvent);
   this.RowDblClick.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseContextMenu: function(objectType, index, htmlEvent, menu, showBrowserMenu) {
  var args = new ASPxClientGridViewContextMenuEventArgs(objectType, index, htmlEvent, menu, showBrowserMenu);
  if(!this.ContextMenu.IsEmpty())
   this.ContextMenu.FireEvent(this, args);
  return !!args.showBrowserMenu;
 },
 RaiseFocusedItemChanged: function(){
  if(!this.FocusedRowChanged.IsEmpty()){
   var args = new ASPxClientProcessingModeEventArgs(false);
   this.FocusedRowChanged.FireEvent(this, args);
   if(args.processOnServer)
    this.gridCallBack([ASPxClientGridViewCallbackCommand.FocusedRow]);
  }
  return false; 
 },
 RaiseColumnStartDragging: function(column) {
  if(!this.ColumnStartDragging.IsEmpty()){
   var args = new ASPxClientGridViewColumnCancelEventArgs(column);
   this.ColumnStartDragging.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseColumnResizing: function(column) {
  if(!this.ColumnResizing.IsEmpty()){
   var args = new ASPxClientGridViewColumnCancelEventArgs(column);
   this.ColumnResizing.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseColumnResized: function(column) {
  if(!this.ColumnResized.IsEmpty()){
   var args = new ASPxClientGridViewColumnProcessingModeEventArgs(column);
   this.ColumnResized.FireEvent(this, args);
   if(args.processOnServer)
    this.Refresh();
  }
 },
 RaiseRowExpanding: function(visibleIndex) {
  if(!this.RowExpanding.IsEmpty()){
   var args = new ASPxClientGridViewRowCancelEventArgs(visibleIndex);
   this.RowExpanding.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseRowCollapsing: function(visibleIndex) {
  if(!this.RowCollapsing.IsEmpty()){
   var args = new ASPxClientGridViewRowCancelEventArgs(visibleIndex);
   this.RowCollapsing.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseDetailRowExpanding: function(visibleIndex) {
  if(!this.DetailRowExpanding.IsEmpty()){
   var args = new ASPxClientGridViewRowCancelEventArgs(visibleIndex);
   this.DetailRowExpanding.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseDetailRowCollapsing: function(visibleIndex) {
  if(!this.DetailRowCollapsing.IsEmpty()){
   var args = new ASPxClientGridViewRowCancelEventArgs(visibleIndex);
   this.DetailRowCollapsing.FireEvent(this, args);
   return args.cancel;
  }
  return false; 
 },
 RaiseBatchEditConfirmShowing: function(requestTriggerID) {
  if(!this.BatchEditConfirmShowing.IsEmpty()) {
   var args = new ASPxClientGridViewBatchEditConfirmShowingEventArgs(requestTriggerID);
   this.BatchEditConfirmShowing.FireEvent(this, args);
   return args.cancel;
  }
  return false;
 },
 RaiseBatchEditStartEditing: function(visibleIndex, column, rowValues) {
  var args = new ASPxClientGridViewBatchEditStartEditingEventArgs(visibleIndex, column, rowValues);
  if(!this.BatchEditStartEditing.IsEmpty())
   this.BatchEditStartEditing.FireEvent(this, args);
  return args;
 },
 RaiseBatchEditEndEditing: function(visibleIndex, rowValues) {
  var args = new ASPxClientGridViewBatchEditEndEditingEventArgs(visibleIndex, rowValues);
  if(!this.BatchEditEndEditing.IsEmpty())
   this.BatchEditEndEditing.FireEvent(this, args);
  return args;
 },
 RaiseBatchEditItemValidating: function(visibleIndex, validationInfo) {
  var args = new ASPxClientGridViewBatchEditRowValidatingEventArgs(visibleIndex, validationInfo);
  if(!this.BatchEditRowValidating.IsEmpty())
   this.BatchEditRowValidating.FireEvent(this, args);
  return args.validationInfo;
 },
 RaiseBatchEditTemplateCellFocused: function(columnIndex) {
  var column = this._getColumn(columnIndex);
  if(!column) return false;
  var args = new ASPxClientGridViewBatchEditTemplateCellFocusedEventArgs(column);
  if(!this.BatchEditTemplateCellFocused.IsEmpty())
   this.BatchEditTemplateCellFocused.FireEvent(this, args);
  return args.handled;
 },
 RaiseContextMenuItemClick: function(e, itemInfo) {
  if(this.ContextMenuItemClick.IsEmpty())
   return false;
  var args = new ASPxClientGridViewContextMenuItemClickEventArgs(e.item, itemInfo.objectType, itemInfo.index);
  this.ContextMenuItemClick.FireEvent(this, args);
  if(!args.handled && args.processOnServer) {
   this.ProcessCustomContextMenuItemClick(e.item, args.usePostBack);
   return true;
  }
  return args.handled;
 },
 RaiseColumnMoving: function(targets) {
  if(this.ColumnMoving.IsEmpty()) return;
  var srcColumn = this.getColumnObject(targets.obj.id);
  var destColumn = this.getColumnObject(targets.targetElement.id);
  var isLeft = targets.isLeftPartOfElement();
  var isGroupPanel = targets.targetElement == targets.grid.GetGroupPanel();
  var args = new ASPxClientGridViewColumnMovingEventArgs(srcColumn, destColumn, isLeft, isGroupPanel);
  this.ColumnMoving.FireEvent(this, args);
  if(!args.allow)
   targets.targetElement = null;
 },
 CreateCommandCustomButtonEventArgs: function(index, id){
  return new ASPxClientGridViewCustomButtonEventArgs(index, id);
 },
 CreateSelectionEventArgs: function(visibleIndex, isSelected, isAllRecordsOnPage, isChangedOnServer){
  return new ASPxClientGridViewSelectionEventArgs(visibleIndex, isSelected, isAllRecordsOnPage, isChangedOnServer);
 },
 CreateColumnCancelEventArgs: function(column){
  return new ASPxClientGridViewColumnCancelEventArgs(column);
 },
 CreateColumnMovingEventArgs: function(sourceColumn, destinationColumn, isDropBefore, isGroupPanel){
  return new ASPxClientGridViewColumnMovingEventArgs(sourceColumn, destinationColumn, isDropBefore, isGroupPanel);;
 },
 GetRowValues: function(visibleIndex, fieldNames, onCallBack) {
  this.GetItemValues(visibleIndex, fieldNames, onCallBack);
 },
 GetPageRowValues: function(fieldNames, onCallBack) {
  this.GetPageItemValues(fieldNames, onCallBack);
 },
 GetVisibleRowsOnPage: function() {
  return this.GetVisibleItemsOnPage();
 },
 ApplyOnClickRowFilter: function() {
  this.ApplyMultiColumnAutoFilter();
 }
});
ASPxClientGridView.Cast = ASPxClientControl.Cast;
var ASPxClientGridViewColumn = ASPx.CreateClass(ASPxClientGridColumnBase, {
 constructor: function(name, index, parentIndex, fieldName, visible, filterRowTypeKind, showFilterMenuLikeItem,
  allowGroup, allowSort, allowDrag, HFCheckedList, inCustWindow, minWidth, isCommandColumn){
  this.constructor.prototype.constructor.call(this, name, index, fieldName, visible, allowSort, HFCheckedList);
  this.parentIndex = parentIndex;
  this.filterRowTypeKind = filterRowTypeKind;
  this.showFilterMenuLikeItem = !!showFilterMenuLikeItem;
  this.allowGroup = !!allowGroup;
  this.allowDrag = !!allowDrag;
  this.inCustWindow = !!inCustWindow;
  this.minWidth = minWidth;
  this.isCommandColumn = isCommandColumn;
 }
});
var ASPxClientGridViewColumnCancelEventArgs = ASPx.CreateClass(ASPxClientCancelEventArgs, {
 constructor: function(column){
  this.constructor.prototype.constructor.call(this);
  this.column = column;
 }
});
var ASPxClientGridViewColumnProcessingModeEventArgs = ASPx.CreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(column){
  this.constructor.prototype.constructor.call(this, false);
  this.column = column;
 }
});
var ASPxClientGridViewRowCancelEventArgs = ASPx.CreateClass(ASPxClientCancelEventArgs, {
 constructor: function(visibleIndex){
  this.constructor.prototype.constructor.call(this);
  this.visibleIndex = visibleIndex;
 }
});
var ASPxClientGridViewSelectionEventArgs = ASPx.CreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(visibleIndex, isSelected, isAllRecordsOnPage, isChangedOnServer){
  this.constructor.prototype.constructor.call(this, false);
  this.visibleIndex = visibleIndex;
  this.isSelected = isSelected;
  this.isAllRecordsOnPage = isAllRecordsOnPage;
  this.isChangedOnServer = isChangedOnServer;
 }
});
var ASPxClientGridViewRowClickEventArgs = ASPx.CreateClass(ASPxClientGridViewRowCancelEventArgs, {
 constructor: function(visibleIndex, htmlEvent){
  this.constructor.prototype.constructor.call(this, visibleIndex);
  this.htmlEvent = htmlEvent;
 }
});
var ASPxClientGridViewContextMenuEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(objectType, index, htmlEvent, menu, showBrowserMenu) {
  this.constructor.prototype.constructor.call(this);
  this.objectType = objectType;
  this.index = index;
  this.htmlEvent = htmlEvent;
  this.menu = menu;
  this.showBrowserMenu = showBrowserMenu;
 }
});
var ASPxClientGridViewContextMenuItemClickEventArgs = ASPx.CreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(item, objectType, elementIndex, processOnServer){
  this.constructor.prototype.constructor.call(this, processOnServer);
  this.item = item;
  this.objectType = objectType;
  this.elementIndex = elementIndex;
  this.usePostBack = false;
  this.handled = false;
 }
});
var ASPxClientGridViewCustomButtonEventArgs = ASPx.CreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(visibleIndex, buttonID) {
  this.constructor.prototype.constructor.call(this, false);
  this.visibleIndex = visibleIndex;
  this.buttonID = buttonID;
 } 
});
var ASPxClientGridViewColumnMovingEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(sourceColumn, destinationColumn, isDropBefore, isGroupPanel) {
  this.constructor.prototype.constructor.call(this);
  this.allow = true;
  this.sourceColumn = sourceColumn;
  this.destinationColumn = destinationColumn;
  this.isDropBefore = isDropBefore;
  this.isGroupPanel = isGroupPanel;
 }
});
var ASPxClientGridViewBatchEditConfirmShowingEventArgs = ASPx.CreateClass(ASPxClientGridBatchEditConfirmShowingEventArgs, {
 constructor: function(requestTriggerID) {
  this.constructor.prototype.constructor.call(this, requestTriggerID);
 }
});
var ASPxClientGridViewBatchEditStartEditingEventArgs = ASPx.CreateClass(ASPxClientGridBatchEditStartEditingEventArgs, {
 constructor: function(visibleIndex, focusedColumn, itemValues) {
  this.constructor.prototype.constructor.call(this, visibleIndex, focusedColumn, itemValues);
  this.rowValues = this.itemValues;
 }
});
var ASPxClientGridViewBatchEditEndEditingEventArgs = ASPx.CreateClass(ASPxClientGridBatchEditEndEditingEventArgs, {
 constructor: function(visibleIndex, itemValues) {
  this.constructor.prototype.constructor.call(this, visibleIndex, itemValues);
  this.rowValues = this.itemValues;
 }
});
var ASPxClientGridViewBatchEditRowValidatingEventArgs = ASPx.CreateClass(ASPxClientGridBatchEditItemValidatingEventArgs, {
 constructor: function(visibleIndex, validationInfo) {
  this.constructor.prototype.constructor.call(this, visibleIndex, validationInfo);
 }
});
var ASPxClientGridViewBatchEditTemplateCellFocusedEventArgs = ASPx.CreateClass(ASPxClientGridBatchEditTemplateCellFocusedEventArgs, {
 constructor: function(column) {
  this.constructor.prototype.constructor.call(this, column);
 }
});
ASPx.GVContextMenu = function(name, e) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null) {
  var showDefaultMenu = gv.OnContextMenuClick(e);
  return showDefaultMenu;
  }
 return true;
}
ASPx.GVContextMenuItemClick = function(name, e) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null)
  gv.OnContextMenuItemClick(e);
}
ASPx.GVExpandRow = function(name, visibleIndex, event) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null) {
  if(gv.useEndlessPaging && event)
   visibleIndex = gv.FindParentRowVisibleIndex(ASPx.Evt.GetEventSource(event), true);
  gv.ExpandRow(visibleIndex);
 }
}
ASPx.GVCollapseRow = function(name, visibleIndex, event) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null) {
  if(gv.useEndlessPaging && event)
   visibleIndex = gv.FindParentRowVisibleIndex(ASPx.Evt.GetEventSource(event), true);
  gv.CollapseRow(visibleIndex);
 }
}
ASPx.GVShowDetailRow = function(name, visibleIndex, event) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null) {
  if(gv.useEndlessPaging && event)
   visibleIndex = gv.FindParentRowVisibleIndex(ASPx.Evt.GetEventSource(event), true);
  gv.ExpandDetailRow(visibleIndex);
 }
}
ASPx.GVHideDetailRow = function(name, visibleIndex, event) {
 var gv = ASPx.GetControlCollection().Get(name);
 if(gv != null) {
  if(gv.useEndlessPaging && event)
   visibleIndex = gv.FindParentRowVisibleIndex(ASPx.Evt.GetEventSource(event), true);
  gv.CollapseDetailRow(visibleIndex);
 }
}
ASPx.Evt.AttachEventToElement(window, "scroll", function(evt) {
 ASPx.GetControlCollection().ForEachControl(function(control){
  if(control instanceof ASPxClientGridView && ASPx.IsExists(control.GetMainElement()))
   control.OnScroll(evt);
 });
});
var GridViewKbdHelper = ASPx.CreateClass(ASPx.KbdHelper, {
  CanFocus: function(e) {
  var grid = this.control;
  var batchEditHelper = grid.GetBatchEditHelper();
  if(batchEditHelper && batchEditHelper.CanStartEditOnTableClick(e))
   return false;
  return ASPx.KbdHelper.prototype.CanFocus(e);
 },
 HandleKeyDown: function(e) {
  var grid = this.control;
  var index = grid.GetFocusedRowIndex();
  var busy = grid.keyboardLock;
  var key = ASPx.Evt.GetKeyCode(e);
  if(grid.rtl) {
   if(key == ASPx.Key.Left)
    key = ASPx.Key.Right;
   else if(key == ASPx.Key.Right)
    key = ASPx.Key.Left;
  }
  switch(key) {
   case ASPx.Key.Down:
    if(!busy) 
     this.TryMoveFocusDown(index, e.shiftKey);
    return true;
   case ASPx.Key.Up:
    if(!busy) 
     this.TryMoveFocusUp(index, e.shiftKey);
    return true;
   case ASPx.Key.Right:
    if(!busy) {
     if(!this.TryExpand(index))
      this.TryMoveFocusDown(index, e.shiftKey);
    }
    return true;
   case ASPx.Key.Left:
    if(!busy) {
     if(!this.TryCollapse(index))
      this.TryMoveFocusUp(index, e.shiftKey);
    }
    return true;
   case ASPx.Key.PageDown:
    if(e.shiftKey) {
     if(!busy && grid.pageIndex < grid.pageCount - 1)
      grid.NextPage();
     return true; 
    }
    break;
   case ASPx.Key.PageUp:
    if(e.shiftKey) {
     if(!busy && grid.pageIndex > 0)
      grid.PrevPage();
     return true; 
    }
    break;     
  }
  return false;
 },
 HandleKeyPress: function(e) {
  var grid = this.control;
  var index = grid.GetFocusedRowIndex();
  var busy = grid.keyboardLock;
  switch(ASPx.Evt.GetKeyCode(e)) {
   case ASPx.Key.Space:
    if(!busy && this.IsRowSelectable(index))
     grid.IsRowSelectedOnPage(index) ? grid.UnselectRowOnPage(index) : grid.SelectRowOnPage(index);
    return true;
    case 43:
    if(!busy)
     this.TryExpand(index);
    return true;
    case 45: 
    if(!busy)   
     this.TryCollapse(index);    
    return true;
  }
  return false;
 },
 EnsureFocusedRowVisible: function() {
  var grid = this.control;
  if(!grid.HasVertScroll()) return;
  var row = grid.GetItem(grid.GetFocusedRowIndex());
  grid.GetScrollHelper().MakeRowVisible(row, true);
 },
 HasDetailButton: function(expanded) {
  var grid = this.control;
  var row = grid.GetItem(grid.GetFocusedRowIndex());
  if(!row) return;
  var needle = expanded ? "ASPx.GVHideDetailRow" : "ASPx.GVShowDetailRow";
  return row.innerHTML.indexOf(needle) > -1;
 },
 IsRowSelectable: function(index) {
  if(this.control.allowSelectByItemClick)
   return true;
  var row = this.control.GetItem(index);
  if(row && row.innerHTML.indexOf("aspxGVSelectRow") > -1)
   return true;
  var check = this.control.GetDataRowSelBtn(index); 
  if(check && this.control.internalCheckBoxCollection && !!this.control.internalCheckBoxCollection.Get(check.id))
   return true;
  return false;
 },
 UpdateShiftSelection: function(start, end) {
  var grid = this.control;
  grid.UnselectAllRowsOnPage();
  if(grid.lastMultiSelectIndex > -1)   
   start = grid.lastMultiSelectIndex;
  else   
   grid.lastMultiSelectIndex = start;
  for(var i = Math.min(start, end); i <= Math.max(start, end); i++)
   grid.SelectRowOnPage(i);
 },
 TryExpand: function(index) {
  var grid = this.control;
  if(grid.IsGroupRow(index) && !grid.IsGroupRowExpanded(index)) {
   grid.ExpandRow(index);
   return true;
  }
  if(this.HasDetailButton(false)) {
   grid.ExpandDetailRow(index);
   return true;
  }
  return false;
 },
 TryCollapse: function(index) {
  var grid = this.control;
  if(grid.IsGroupRow(index) && grid.IsGroupRowExpanded(index)) {
   grid.CollapseRow(index);
   return true;
  }
  if(this.HasDetailButton(true)) {
   grid.CollapseDetailRow(index);
   return true;
  }
  return false;
 },
 TryMoveFocusDown: function(index, select) {
  var grid = this.control;
  if(index < grid.visibleStartIndex + grid.pageRowCount - 1) {
   if(index < 0) 
    grid.SetFocusedRowIndex(grid.visibleStartIndex);
    else
    grid.SetFocusedRowIndex(index + 1);
   this.EnsureFocusedRowVisible();
   if(this.IsRowSelectable(index)) {
    if(select) {
     this.UpdateShiftSelection(index, index + 1);
    } else {
     grid.lastMultiSelectIndex = -1;
    }
   }
  } else {
   if(grid.pageIndex < grid.pageCount - 1 && grid.pageIndex >= 0) {       
    grid.NextPage();
   }
  }  
 },
 TryMoveFocusUp: function(index, select) {
  var grid = this.control;
  if(index > grid.visibleStartIndex || index == -1) {
   if(index < 0) 
    grid.SetFocusedRowIndex(grid.visibleStartIndex + grid.pageRowCount - 1);
   else
    grid.SetFocusedRowIndex(index - 1);
   this.EnsureFocusedRowVisible();
   if(this.IsRowSelectable(index)) {
    if(select) {
     this.UpdateShiftSelection(index, index - 1);
    } else {
     grid.lastMultiSelectIndex = -1;
    }
   }
  } else {
   if(grid.pageIndex > 0) {
    grid.PrevPage(true);
   }
  }
 }
});
var GridViewHeaderMatrix = ASPx.CreateClass(null, {
 constructor: function(grid) {
  this.grid = grid;
 },
 Invalidate: function() {
  this.matrix = null;
  this.inverseMatrix = null;
 }, 
 GetRowCount: function() {
  this.EnsureMatrix();
  return this.matrix.length;
 },
 IsLeftmostColumn: function(columnIndex) {
  this.EnsureMatrix();
  return this.inverseMatrix[columnIndex].left == 0;
 },
 IsRightmostColumn: function(columnIndex) {
  this.EnsureMatrix();  
  return this.inverseMatrix[columnIndex].right == this.matrix[0].length - 1;
 },
 IsLeaf: function(columnIndex) {
  this.EnsureMatrix();
  return this.inverseMatrix[columnIndex].bottom == this.matrix.length - 1;
 },
 GetLeaf: function(columnIndex, isLeft, isOuter) {
  this.EnsureMatrix();
  var rect = this.inverseMatrix[columnIndex];
  var row = this.matrix[this.matrix.length - 1];
  if(isLeft) {
   if(isOuter)
    return row[rect.left - 1];
   return row[rect.left];
  }
  if(isOuter)
   return row[rect.right + 1];
  return row[rect.right];
 },
 GetLeafIndex: function(columnIndex) {
  this.EnsureMatrix();
  return this.inverseMatrix[columnIndex].left;
 },
 GetLeafIndices: function() {
  return this.GetRowIndices(this.GetRowCount() - 1);
 },
 GetRowIndices: function(rowIndex) {
  this.EnsureMatrix();
  return this.matrix[rowIndex] || [];
 },
 GetRowSpan: function(columnIndex) {
  this.EnsureMatrix();
  var rect = this.inverseMatrix[columnIndex];
  return rect.bottom - rect.top + 1;
 },
 GetLeftNeighbor: function(columnIndex, skipHiddenColumns) {
  this.EnsureMatrix();
  if(!skipHiddenColumns)
   return this.GetLeftNeighborCore(columnIndex);
  while(columnIndex !== this.GetFirstColumnIndex()) {
   columnIndex = this.GetLeftNeighborCore(columnIndex);
   if(isNaN(columnIndex) || !this.grid.GetColumn(columnIndex).adaptiveHidden)
    return columnIndex;
  }
 },
 GetLeftNeighborCore: function(columnIndex) {
  var rect = this.inverseMatrix[columnIndex];
  return this.matrix[rect.top][rect.left - 1];
 },
 GetRightNeighbor: function(columnIndex, skipHiddenColumns) {
  this.EnsureMatrix();
  if(!skipHiddenColumns)
   return this.GetRightNeighborCore(columnIndex);
  while(columnIndex !== this.GetLastColumnIndex()) {
   columnIndex = this.GetRightNeighborCore(columnIndex);
   if(isNaN(columnIndex) || !this.grid.GetColumn(columnIndex).adaptiveHidden)
    return columnIndex;
  }
 },
 GetRightNeighborCore: function(columnIndex) {
  var rect = this.inverseMatrix[columnIndex];
  return this.matrix[rect.top][rect.right + 1];
 },
 GetLastColumnIndex: function(){
  var leafs = this.GetLeafIndices();
  return leafs[leafs.length - 1];
 },
 GetFirstColumnIndex: function(){
  var leafs = this.GetLeafIndices();
  return leafs[0];
 },
 GetRightNeighborLeaf: function(columnIndex) {
  return this.GetLeaf(columnIndex, false, true);
 },
 GetColumnLevel: function(columnIndex) {
  this.EnsureMatrix();
  var rect = this.inverseMatrix[columnIndex];
  return rect ? rect.top : -1;
 },
 EnsureMatrix: function() {
  this.matrix || this.Fill();
 },
 Fill: function() {
  this.matrix = [ ];
  this.inverseMatrix = { };
  var rowIndex = 0;
  while(true) {
   var row = this.grid.GetHeaderRow(rowIndex);
   if(!row)
    break;
   var lastFreeIndex = 0;
   for(var cellIndex = !rowIndex ? this.grid.indentColumnCount : 0; cellIndex < row.cells.length; cellIndex++) {
    var cell = row.cells[cellIndex];
    var columnIndex = this.grid.getColumnIndex(cell.id);
    if(columnIndex < 0)
     break;
    lastFreeIndex = this.FindFreeCellIndex(rowIndex, lastFreeIndex);
    this.FillBlock(rowIndex, lastFreeIndex, cell.rowSpan, cell.colSpan, columnIndex);
    lastFreeIndex += cell.colSpan;
   }
   ++rowIndex;
  }
 },
 FindFreeCellIndex: function(rowIndex, lastFreeCell) {
  var row = this.matrix[rowIndex];
  var result = lastFreeCell;
  if(row) {
   while(!isNaN(row[result]))
    result++;
  } 
  return result;
 },
 FillBlock: function(rowIndex, cellIndex, rowSpan, colSpan, columnIndex) {
  var rect = {
   top: rowIndex,
   bottom: rowIndex + rowSpan - 1,
   left: cellIndex,
   right: cellIndex + colSpan - 1
  };
  for(var i = rect.top; i <= rect.bottom; i++) {
   while(!this.matrix[i])
    this.matrix.push([]);
   for(var j = rect.left; j <= rect.right; j++)
    this.matrix[i][j] = columnIndex;
  }
  this.inverseMatrix[columnIndex] = rect;
 }
});
var ASPxClientGridViewBatchEditApi = ASPx.CreateClass(ASPxClientGridBatchEditApi, {
 constructor: function(grid) {
  this.constructor.prototype.constructor.call(this, grid);
 },
 ValidateRows: function() {
  return this.ValidateItems();
 },
 ValidateRow: function(visibleIndex) {
  return this.ValidateItem(visibleIndex);
 }
});
window.ASPxClientGridView = ASPxClientGridView;
window.ASPxClientGridViewColumn = ASPxClientGridViewColumn;
window.ASPxClientGridViewColumnCancelEventArgs = ASPxClientGridViewColumnCancelEventArgs;
window.ASPxClientGridViewColumnProcessingModeEventArgs = ASPxClientGridViewColumnProcessingModeEventArgs;
window.ASPxClientGridViewRowCancelEventArgs = ASPxClientGridViewRowCancelEventArgs;
window.ASPxClientGridViewSelectionEventArgs = ASPxClientGridViewSelectionEventArgs;
window.ASPxClientGridViewRowClickEventArgs = ASPxClientGridViewRowClickEventArgs;
window.ASPxClientGridViewContextMenuEventArgs = ASPxClientGridViewContextMenuEventArgs;
window.ASPxClientGridViewContextMenuItemClickEventArgs = ASPxClientGridViewContextMenuItemClickEventArgs;
window.ASPxClientGridViewCustomButtonEventArgs = ASPxClientGridViewCustomButtonEventArgs;
window.ASPxClientGridViewColumnMovingEventArgs = ASPxClientGridViewColumnMovingEventArgs;
window.ASPxClientGridViewBatchEditConfirmShowingEventArgs = ASPxClientGridViewBatchEditConfirmShowingEventArgs;
window.ASPxClientGridViewBatchEditStartEditingEventArgs = ASPxClientGridViewBatchEditStartEditingEventArgs;
window.ASPxClientGridViewBatchEditEndEditingEventArgs = ASPxClientGridViewBatchEditEndEditingEventArgs;
window.ASPxClientGridViewBatchEditRowValidatingEventArgs = ASPxClientGridViewBatchEditRowValidatingEventArgs;
window.ASPxClientGridViewBatchEditTemplateCellFocusedEventArgs = ASPxClientGridViewBatchEditTemplateCellFocusedEventArgs;
ASPx.GridViewKbdHelper = GridViewKbdHelper;
window.ASPxClientGridViewBatchEditApi = ASPxClientGridViewBatchEditApi;
})();
