(function() {
var serializingSeparator = "|";
var serializingSeparatorLength = serializingSeparator.length;
var loadRangeItemsCallbackPrefix = "LBCRI";
var lbIPostfixes = ['C', 'I', 'T'];
var lbIIdSuffix = "LBI";
var lbSIIdSuffix = lbIIdSuffix + "-1";
var lbAIRIdSuffix = "AIR";
var lbAIRTIdSuffix = lbAIRIdSuffix + "-1";
var lbTSIdSuffix = "_TS";
var lbBSIdSuffix = "_BS";
var lbHeaderDivIdSuffix = "_H";
var lTableIdSuffix = "_LBT";
var leVISuffix = "_VI";
var lbDSuffix = "_D";
var emptyItemsRange = "0:-1";
var nbsp = "&nbsp;";
var nameSeparator = "_";
var nbspChar = String.fromCharCode(160);
var accessibilityAssistID =  "AcAs";
var ListBoxSelectionMode = { Single : 0, Multiple : 1, CheckColumn : 2 };
var ASPxClientListEdit = ASPx.CreateClass(ASPxClientEdit, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.SelectedIndexChanged = new ASPxClientEvent();
  this.savedSelectedIndex = -1;
 },
 FindInputElement: function() {
  return this.FindStateInputElement();
 },
 FindStateInputElement: function(){
  return document.getElementById(this.name + leVISuffix);
 },
 GetItem: function(index) {
  throw "Not implemented";
 },
 GetItemValue: function(index) {
  throw "Not implemented";
 },
 GetValue: function(){
  return this.GetItemValue(this.GetSelectedIndex());
 }, 
 GetSelectedIndexInternal: function(){
  return this.savedSelectedIndex;
 }, 
 SetSelectedIndexInternal: function(index){
  this.savedSelectedIndex = index;
 },
 FindItemIndexByValue: function(value){
  for(var i = 0; i < this.GetItemCount(); i++){
   if(this.GetItemValue(i) == value)
    return i;
  }
  return -1;
 },
 RaiseItemClick: function() {
  var processOnServer = this.autoPostBack;
  if(!this.ItemClick.IsEmpty()){
   var args = new ASPxClientProcessingModeEventArgs(processOnServer);
   this.ItemClick.FireEvent(this, args);
   processOnServer = args.processOnServer;
  }
  return processOnServer;
 },
 RaiseItemDoubleClick: function() {
  var processOnServer = this.autoPostBack;
  if(!this.ItemDoubleClick.IsEmpty()){
   var args = new ASPxClientProcessingModeEventArgs(processOnServer);
   this.ItemDoubleClick.FireEvent(this, args);
   processOnServer = args.processOnServer;
  }
  return processOnServer;
 },
 RaiseValueChangedEvent: function() {
  if(!this.isInitialized) return false;
  var processOnServer = ASPxClientEdit.prototype.RaiseValueChangedEvent.call(this);
  processOnServer = this.RaiseValueChangedAdditionalEvents(processOnServer);
  return processOnServer;
 },
 RaiseValueChangedAdditionalEvents: function(processOnServer){
  return this.RaiseSelectedIndexChanged(processOnServer);
 },
 RaiseSelectedIndexChanged: function (processOnServer) {
  this.RaiseValidationInternal();
  if(!this.SelectedIndexChanged.IsEmpty()){
   var args = new ASPxClientProcessingModeEventArgs(processOnServer);
   this.SelectedIndexChanged.FireEvent(this, args);
   processOnServer = args.processOnServer;
  }
  return processOnServer;
 },
 UpdateHiddenInputs: function(){
  var element = this.FindStateInputElement();
  if(ASPx.IsExistsElement(element)) {
   var value = this.GetValue();
   if(value == null)
    value = "";
   element.value = value;
  }
 },
 GetSelectedItem: function(){
  var index = this.GetSelectedIndexInternal();
  return this.GetItem(index);
 },
 GetSelectedIndex: function(){
  return this.GetSelectedIndexInternal();
 },
 SetSelectedItem: function(item){
  var index = (item != null) ? item.index : -1;
  this.SetSelectedIndex(index);
 },
 SetSelectedIndex: function(index){
  this.SelectIndexSilent(index);
 },
 SelectIndexSilent: function(index){
  throw "Not implemented";
 },
 OnValueChanged: function () {
  var processOnServer = this.RaiseValueChangedEvent() && this.GetIsValid();
  if(processOnServer)
   this.SendPostBackInternal("");
 }
});
var ASPxClientListEditItem = ASPx.CreateClass(null, {
 constructor: function(listEditBase, index, text, value, imageUrl){
  this.listEditBase = listEditBase;
  this.index = index;
  this.imageUrl = imageUrl;
  this.text = text;
  this.value = value;
 }
});
var ASPxClientListBoxItem = ASPx.CreateClass(ASPxClientListEditItem, {
 constructor: function(listEditBase, index, texts, value, imageUrl, selected){
  this.constructor.prototype.constructor.call(this, listEditBase, index, null, value, imageUrl);
  this.selected = selected ? selected : false;
  this.texts = texts;
  this.text = listEditBase.FormatText(texts);
 },
 GetColumnText: function(columnIndexOrFieldName){
  var columnIndex = -1;
  if(typeof(columnIndexOrFieldName) == "string")
   columnIndex = ASPx.Data.ArrayIndexOf(this.listEditBase.columnFieldNames, columnIndexOrFieldName);
  else if(typeof(columnIndexOrFieldName) == "number")
   columnIndex = columnIndexOrFieldName;
  return this.GetColumnTextByIndex(columnIndex);
 },
 GetColumnTextByIndex: function(columnIndex){
  if(0 <= columnIndex && columnIndex < this.texts.length)
   return this.texts[columnIndex];
  else
   return null;
 }
});
var ListBoxScrollCallbackHelperBase = ASPx.CreateClass(null, {
 constructor: function(listBoxControl) {
  this.listBoxControl = listBoxControl;
  this.itemsRange = "";
  this.defaultItemsRange = "0:" + (this.listBoxControl.callbackPageSize - 1);
 },
 OnScroll: function(){ },
 Reset: function(){ },
 IsScrolledToTopSpacer: function(){ return false; },
 IsScrolledToBottomSpacer: function(){ return false; },
 GetIsNeedToHideTopSpacer: function(){ return false; },
 GetIsNeedCallback: function(){ return false; },
 GetItemsRangeForLoad: function(){ return this.defaultItemsRange; },
 SetItemsRangeForLoad: function(){}
});
var ListBoxScrollCallbackHelper = ASPx.CreateClass(ListBoxScrollCallbackHelperBase, {
 constructor: function(listBoxControl) {
  this.constructor.prototype.constructor.call(this, listBoxControl);
  this.isScrolledToTopSpacer = false;
  this.isScrolledToBottomSpacer = false;
 },
 OnScroll: function(){
  this.DetectScrollDirection();
  this.ResetItemsRange();
  if(this.GetIsAnySpacerVisible())
   this.RecalcItemsRangeForLoad();
 },
 DetectScrollDirection: function(){
  var listBoxControl = this.listBoxControl;
  var divElement = listBoxControl.GetScrollDivElement();
  var listTable = listBoxControl.GetListTable();
  var scrollTop = divElement.scrollTop;
  var scrollBottom = divElement.scrollTop + divElement.clientHeight;
  var isTopSpacerVisible = listBoxControl.GetScrollSpacerVisibility(true);
  var isBottomSpacerVisible = listBoxControl.GetScrollSpacerVisibility(false);
  var topSpacerHeight = listBoxControl.GetScrollSpacerVisibility(true) ? parseInt(listBoxControl.GetScrollSpacerElement(true).clientHeight) : 0;
  this.isScrolledToTopSpacer = (scrollTop < topSpacerHeight) && isTopSpacerVisible;
  this.isScrolledToBottomSpacer = (scrollBottom >= topSpacerHeight + listTable.clientHeight) && isBottomSpacerVisible;
 },
 Reset: function(){
  this.ResetItemsRange();
  this.isScrolledToTopSpacer = false;
  this.isScrolledToBottomSpacer = false;
 },
 ResetItemsRange: function(){
  this.itemsRange = "";
 },
 RecalcItemsRangeForLoad: function(){
  if(this.listBoxControl.isCallbackMode) {
   if(this.isScrolledToTopSpacer || this.isScrolledToBottomSpacer)
    this.SetItemsRangeForLoad(this.isScrolledToTopSpacer);
  }
 },
 IsScrolledToTopSpacer: function(){
  return this.isScrolledToTopSpacer;
 },
 IsScrolledToBottomSpacer: function(){
  return this.isScrolledToBottomSpacer;
 },
 GetIsAnySpacerVisible: function(){
  return this.isScrolledToTopSpacer || this.isScrolledToBottomSpacer;
 },
 GetIsNeedCallback: function(){
  return !this.GetIsItemsRangeEmpty();
 },
 GetIsNeedToHideTopSpacer: function(){
  return this.isScrolledToTopSpacer && this.GetIsItemsRangeEmpty();
 },
 GetItemsRangeForLoad: function(){
  return (!this.GetIsItemsRangeEmpty() ? this.itemsRange : this.defaultItemsRange);
 },
 SetItemsRangeForLoad: function(isForTop){
  var listbox = this.listBoxControl;
  var beginIndex = isForTop ? 
   listbox.serverIndexOfFirstItem - listbox.callbackPageSize : 
   listbox.serverIndexOfFirstItem + listbox.GetItemCount();
  beginIndex = beginIndex < 0 ? 0 : beginIndex;
  var endIndex = isForTop ? 
   listbox.serverIndexOfFirstItem - 1 : 
   beginIndex + listbox.callbackPageSize - 1;
  this.itemsRange = beginIndex + ":" + endIndex;
  this.isScrolledToTopSpacer = isForTop;
  this.isScrolledToBottomSpacer = !isForTop;
 },
 GetIsItemsRangeEmpty: function(){
  return (this.itemsRange == "" || this.itemsRange == emptyItemsRange);
 }
});
var ASPxClientListBoxBase = ASPx.CreateClass(ASPxClientListEdit, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.APILockCount = 0;
  this.enableSyncOnPerfCallback = false;
  this.scrollOnKBNavigationLockCount = 0;
  this.isComboBoxList = false;
  this.isSyncEnabled = true;
  this.ownerName = "";
  this.selectionEventsLockCount = 0;
  this.syncLockCount = 0;
  this.encodeHtml = true;
  this.useCaseInsensitiveSearch = true;
  this.serializingHelper = null;
  this.deletedItems = [];
  this.insertedItems = [];
  this.itemsValue = [];
  this.ItemDoubleClick = new ASPxClientEvent();
  this.ItemClick = new ASPxClientEvent();
 },
 InlineInitialize: function () {
  ASPxClientListEdit.prototype.InlineInitialize.call(this);
  for(var i = 0; i < this.itemsValue.length; i++)
   this.itemsValue[i] = this.GetDecodeValue(this.itemsValue[i]);
 },
 LockScrollOnKBNavigation: function(){
  this.scrollOnKBNavigationLockCount++;
 },
 UnlockScrollOnKBNavigation: function(){
  this.scrollOnKBNavigationLockCount--;
 },
 IsScrollOnKBNavigationLocked: function() {
  return this.scrollOnKBNavigationLockCount > 0;
 },
 LockSelectionEvents: function(){
  this.selectionEventsLockCount++;
 },
 UnlockSelectionEvents: function(){
  this.selectionEventsLockCount--;
 },
 IsSelectionEventsLocked: function(){
  return this.selectionEventsLockCount > 0;
 },
 LockSynchronizationOnInternalCallback: function(){
  if(!this.enableSyncOnPerfCallback)
   this.LockSynchronization();
 },
 UnlockSynchronizationOnInternalCallback: function (){
  if(!this.enableSyncOnPerfCallback)
   this.UnlockSynchronization();
 },
 GetItemCount: function(){
  return 0;
 },
 GetItemValue: function(index){
  if(0 <= index && index < this.GetItemCount())
   return this.PrepareItemValue(this.itemsValue[index]);
  return null;
 },
 GetItemTexts: function(item) {
  return item.text;
 },
 PrepareItemValue: function(value) {
  return (typeof(value) == "string" && value == "" && this.convertEmptyStringToNull) ? null : value;
 },
 LoadItemsFromCallback: function(isToTop, itemStrings){
 },
 SetValue: function(value){
  var index = this.FindItemIndexByValue(value);
  this.SelectIndexSilentAndMakeVisible(index);
 },
 FindItemIndexByText: function(text){
  var transformText = function(text) { return text; }
  var textIsString = typeof(text) === "string";
  if(this.useCaseInsensitiveSearch && textIsString)
   transformText = function(text) { return text.toUpperCase(); }
  text = transformText(text);
  for(var i = 0; i < this.GetItemCount(); i ++){
   if(transformText(this.GetItem(i).text) == text)
    return i;
  }
  return -1;
 },
 SelectIndex: function (index){ 
  if(this.SelectIndexSilentAndMakeVisible(index, false)){
   this.RaisePersonalStandardValidation();
   this.OnValueChanged();
  }
 },
 SelectIndexSilentAndMakeVisible: function(index){
  var selectionChanged = this.SelectIndexSilent(index);
  if(!this.IsScrollOnKBNavigationLocked())
   this.MakeItemVisible(index);
  return selectionChanged;
 },
 FormatText: function (texts) {
  return texts;
 },
 MakeItemVisible: function(index){
 },
 InitOnContainerMadeVisible: function(){
 },
 AddItem: function(texts, value, imageUrl){
  var index = this.GetItemCount();
  this.InsertItemInternal(index, texts, value, imageUrl);
  return index;
 },
 InsertItem: function(index, texts, value, imageUrl){
  this.InsertItemInternal(index, texts, value, imageUrl);
 },
 InsertItemInternal: function(index, text, value, imageUrl){
 },
 BeginUpdate: function(){
  this.APILockCount ++;
 },
 EndUpdate: function(){
  this.APILockCount --;
  this.Synchronize();
 },
 ClearItems: function(){
  this.BeginUpdate();
  this.UpdateArraysItemsCleared();
  this.ClearItemsCore();
  this.EndUpdate();
 },
 ClearItemsCore: function(){
 },
 ClearItemsForPerformCallback: function(){
  this.itemsValue = [];
  this.ClearItemsCore();
 },
 RemoveItem: function(index){
 },
 FindItemByText: function(text){
  var index = this.FindItemIndexByText(text);
  return this.GetItem(index);
 },
 FindItemByValue: function(value){
  var index = this.FindItemIndexByValue(value);
  return this.GetItem(index);
 },
 PerformCallback: function(arg) {
 },
 GetCallbackArguments: function(){
  var args = this.GetCustomCallbackArg();
  args += this.GetLoadItemsRangeCallbackArg();
  return args;
 },
 GetLoadItemsRangeCallbackArg: function(){
  return this.FormatCallbackArg(loadRangeItemsCallbackPrefix, this.GetItemsRangeForLoad());
 },
 FormatCallbackArg: function(prefix, arg) { 
  arg = arg.toString();
  return (ASPx.IsExists(arg) ? prefix + "|" + arg.length + ';' + arg + ';' : "");
 },
 GetItemsRangeForLoad: function(){
  return emptyItemsRange;
 },
 GetCallbackOwnerControl: function(){
  if(this.ownerName && !this.ownerControl)
   this.ownerControl = ASPx.GetControlCollection().Get(this.ownerName);
  return this.ownerControl;
 },
 GetCustomCallbackArg: function(){
  return this.stateObject["CustomCallback"];
 },
 SetCustomCallbackArg: function(arg){
  this.UpdateStateObjectWithObject({ CustomCallback: arg });
 },
 FormatAndSetCustomCallbackArg: function(arg){
  arg = ASPx.IsExists(arg) ? arg.toString() : ""
  var formatArg = this.FormatCallbackArg("LECC", arg);
  this.SetCustomCallbackArg(formatArg);
 },
 SendCallback: function(){
 },
 LockSynchronization: function(){
  this.syncLockCount++;
 },
 UnlockSynchronization: function(){
  this.syncLockCount--;
 },
 IsSyncLocked: function(){
  return this.syncLockCount > 0;
 },
 IsSyncEnabled: function(){
  return this.isSyncEnabled && !this.IsSyncLocked();
 },
 RegisterInsertedItem: function(index, text, value, imageUrl){
  if(this.IsSyncEnabled()){
   this.RefreshSynchroArraysIndex(index, true);
   var item = this.CreateItem(index, text, value, imageUrl);
   this.insertedItems.push(item);
   this.Synchronize();
  }
 },
 CreateItem: function(index, text, value, imageUrl, selected){
  return new ASPxClientListBoxItem(this, index, text, value, imageUrl, selected);
 },
 UpdateSyncArraysItemDeleted: function(item, isValueRemovingRequired){
  if(isValueRemovingRequired)
   ASPx.Data.ArrayRemoveAt(this.itemsValue, item.index);
  if(this.IsSyncEnabled()){
   var index = this.FindItemInArray(this.insertedItems, item);
   if(index == -1){
    this.RefreshSynchroArraysIndex(item.index, false);
    this.deletedItems.push(item);
   } else {
    this.RefreshSynchroArraysIndex(item.index, false);
    ASPx.Data.ArrayRemoveAt(this.insertedItems, index);
   }
   this.Synchronize();
  }
 },
 UpdateArraysItemsCleared: function(){
  if(this.IsSyncEnabled()){
   for(var i = this.GetItemCount() - 1; i >= 0; i --)
    this.UpdateSyncArraysItemDeleted(this.GetItem(i), false);
  } 
  this.itemsValue = [];
 },
 RefreshSynchroArraysIndex: function(startIndex, isIncrease){
  this.RefreshSynchroArrayIndexIndex(this.deletedItems, startIndex, isIncrease);
  this.RefreshSynchroArrayIndexIndex(this.insertedItems, startIndex, isIncrease);
 },
 RefreshSynchroArrayIndexIndex: function(array, startIndex, isIncrease){
  var delta = isIncrease ? 1 : -1;
  for(var i = 0; i < array.length; i ++){
   if(array[i].index >= startIndex)
    array[i].index += delta;
  }   
 },
 FindItemInArray: function(array, item){
  for(var i = array.length - 1; i >= 0; i--){
   var currentItem = array[i];
   if((!this.encodeHtml || currentItem.text == item.text) && currentItem.value == item.value &&
    currentItem.imageUrl == item.imageUrl)
    break;
  }
  return i;
 },
 Synchronize: function(){
  if(this.APILockCount == 0){
   if(this.IsSyncEnabled()){
    this.SynchronizeItems(this.deletedItems, "DeletedItems");
    this.SynchronizeItems(this.insertedItems, "InsertedItems");
   }
   this.CorrectSizeByTimer();
  }
 },
 CorrectSizeByTimer: function(){
 },
 SynchronizeItems: function(items, syncType){
  var itemsObj = { };
  itemsObj[syncType] = this.SerializeItems(items);
  this.UpdateStateObjectWithObject(itemsObj);
 },
 GetSerializingHelper: function(){ 
  if(this.serializingHelper == null)
   this.serializingHelper = this.CreateSerializingHelper();
  return this.serializingHelper;
 },
 CreateSerializingHelper: function(){
  return new ListBoxBaseItemsSerializingHelper(this);
 },
 SerializeItems: function(items){
  var serialiser = this.GetSerializingHelper();
  return serialiser.SerializeItems(items);
 },
 DeserializeItems: function(serializedItems){
  var serialiser = this.GetSerializingHelper();
  return serialiser.DeserializeItems(serializedItems);
 }
});
var ListBoxBaseItemsSerializingHelper = ASPx.CreateClass(null, {
 constructor: function(listBoxControl) {
  this.listBoxControl = listBoxControl;
  this.startPos = 0;
 },
 SerializeItems: function(items){
  var sb = [ ];
  for(var i = 0; i < items.length; i++)
   this.SerializeItem(sb, items[i]);
  return sb.join("");
 },
 SerializeItem: function(sb, item) {
  if(!item)
   return;
  this.SerializeAtomValue(sb, item.index);
  this.SerializeAtomValue(sb, item.value);
  this.SerializeAtomValue(sb, item.imageUrl);
  var texts = this.listBoxControl.GetItemTexts(item);
  if(typeof(texts) == "string")
   this.SerializeAtomValue(sb, texts);
  else {
   for(var i = 0; i < texts.length; i++)
    this.SerializeAtomValue(sb, texts[i]);
  }
 },
 SerializeAtomValue: function(sb, value) {
  var valueStr = ASPx.IsExists(value) ? value.toString() : "";
  sb.push(valueStr.length);
  sb.push('|');
  sb.push(valueStr);
 },
 DeserializeItems: function(serializedItems){
  var deserializedItems = [];
  var evalItems = ASPx.Json.Eval(serializedItems, this.listBoxControl.name);
  if(evalItems.length > 0) {
   var textsCount = this.listBoxControl.isNative ? 1 : this.listBoxControl.GetItemTextCellCount();
   var itemLength = (this.listBoxControl.imageCellExists ? 1 : 0) + 1 + textsCount;
   var index = 0, selected, value, texts, imageUrl, item;
   for(var i = 0; i < evalItems.length; i += itemLength, index ++) {
    selected = typeof (evalItems[i]) == "object" && !!evalItems[i];
    value = selected ? evalItems[i][0] : evalItems[i];
    texts = textsCount > 0 ? evalItems.slice(i + 1, i + 1 + textsCount) : evalItems[i + 1];
    imageUrl = this.listBoxControl.imageCellExists ? evalItems[i + itemLength - 1] : "";
    item = this.listBoxControl.CreateItem(index, texts, value, imageUrl, selected);
    deserializedItems.push(item);
   }
  }
  return deserializedItems;
 },
 ParseItemIndex: function(serializedItem){
  return parseInt(this.ParseString(serializedItem));
 },
 ParseItemValue: function(serializedItem){
  return this.ParseString(serializedItem);
 },
 ParseString: function(str){
  var indexOfSeparator = str.indexOf(serializingSeparator, this.startPos);
  var strLength = parseInt(str.substring(this.startPos, indexOfSeparator));
  var strStartPos = indexOfSeparator + serializingSeparatorLength;
  this.startPos = strStartPos + strLength;
  return str.substring(strStartPos, strStartPos + strLength);
 },
 ParseTexts: function(serializedItems){
  return this.ParseString(serializedItems);
 },
 DeserializeValues: function(serializedValues){
  var deserializedValues = [];
  this.startPos = 0;
  while(this.startPos < serializedValues.length){
   deserializedValues.push(this.ParseItemValue(serializedValues));
  }
  return deserializedValues;
 }
});
var ListBoxItemsSerializingHelper = ASPx.CreateClass(ListBoxBaseItemsSerializingHelper, {
 constructor: function(listBoxControl) {
  this.constructor.prototype.constructor.call(this, listBoxControl);
 },
 ParseTexts: function(serializedItems){
  var textColumnCount = this.listBoxControl.GetItemTextCellCount();
  return (textColumnCount > 1) ? this.DeserializeItemTexts(serializedItems, textColumnCount) 
   : this.constructor.prototype.ParseTexts.call(this, serializedItems);
 },
 DeserializeItemTexts: function(serializedItem, textColumnCount){
  var text = "";
  var texts = [];
  for(var i = 0; i < textColumnCount; i++)
   texts.push(this.ParseString(serializedItem));
  return texts;
 }
});
var ListBoxSingleSelectionHelper = ASPx.CreateClass(null, {
 constructor: function(listBoxControl) {
  this.listBoxControl = listBoxControl;
  this.savedSelectedIndex = -1;
  this.updateHiddenInputsLockCount = 0;
  this.cachedSelectionChangedArgs = [];
 },
 ClearSelection: function(){
  this.SetSelectedIndexCore(-1);
  this.OnSelectionCleared();
 },
 OnSelectionCleared: function(){
  this.cachedSelectionChangedArgs = [];
 },
 GetSelectedIndexInternal: function(){
  return this.savedSelectedIndex;
 }, 
 SetSelectedIndexInternal: function(index){
  this.savedSelectedIndex = index;
 }, 
 SetSelectedIndexCore: function(index){
  if(index != this.savedSelectedIndex && -1 <= index && index < this.GetItemCount()){
   this.BeginSelectionUpdate();
   this.SetSelectedIndexInternal(index);
   this.EndSelectionUpdate();
   return true;
  }
  return false;
 },
 GetSelectedIndex: function(){
  return this.GetSelectedIndexInternal();
 },
 SetSelectedIndex: function(index){
  this.ChangeSelectedItem(index);
  this.SetSelectedIndexCore(index);
  this.OnItemSelectionChanged(index, true);
 },
 GetSelectedIndices: function(){ 
  var selectedIndex = this.GetSelectedIndexInternal();
  return selectedIndex != -1 ? [selectedIndex] : [];
 },
 GetSelectedValues: function(){ 
  var selectedValue =  this.listBoxControl.GetValue();
  return selectedValue != null ? [selectedValue] : [];
 },
 GetSelectedItems: function(){ 
  var selectedItem = this.listBoxControl.GetSelectedItem();
  return selectedItem != null? [selectedItem] : [];
 },
 SelectIndices: function(indices){},
 SelectItems: function(items){},
 SelectValues: function(values){},
 UnselectIndices: function (selected) { this.SetSelectedIndex(-1); },
 UnselectItems: function(items){},
 UnselectValues: function(values){},
 GetIsItemSelected: function(index){ return index == this.GetSelectedIndexInternal(); },
 ResetSelectionCollectionsCache: function(){ },
 OnItemClick: function(index, evt){
  var selected = true;
  this.BeginSelectionUpdate();
  this.ChangeSelectedItem(index);
  var selectedIndexChanged = this.SetSelectedIndexCore(index);
  this.EndSelectionUpdate();
  if(selectedIndexChanged)
   this.OnItemSelectionChanged(index, selected);
 },
 ChangeSelectedItem: function(newSelectedIndex){
  var selected = true;
  var oldSelectedIndex = this.GetSelectedIndexInternal();
  this.BeginSelectionUpdate();
  this.SetItemSelectionState(oldSelectedIndex, !selected);
  this.SetItemSelectionState(newSelectedIndex, selected);
  this.EndSelectionUpdate();
 },
 SetItemSelectionState: function(itemIndex, selected, controller){
  this.BeginSelectionUpdate();
  this.listBoxControl.SetItemSelectionAppearance(itemIndex, selected, controller);
  this.EndSelectionUpdate();
 },
 GetFocusedIndex: function(){
  return this.GetSelectedIndexInternal();
 },
 BeginSelectionUpdate: function(){
  this.updateHiddenInputsLockCount++;
 },
 EndSelectionUpdate: function(){
  this.updateHiddenInputsLockCount--;
  if(!this.IsUpdateInternalSelectionStateLocked()){
   this.listBoxControl.UpdateInternalState();
   this.FlushSelectionChanged();
  }
 },
 IsUpdateInternalSelectionStateLocked: function(){
  return this.updateHiddenInputsLockCount > 0;
 },
 GetItemCount: function(){
  return this.listBoxControl.GetItemCount();
 },
 OnItemSelectionChanged: function(index, selected){
  if(this.IsUpdateInternalSelectionStateLocked()){
   var a = {Index: index, Selected: selected};
   this.cachedSelectionChangedArgs.push(a);
  }
  else 
   this.listBoxControl.OnItemSelectionChanged(index, selected);
 },
 FlushSelectionChanged: function(){
  if(this.IsUpdateInternalSelectionStateLocked()) 
   return;
  for(var i = 0; i < this.cachedSelectionChangedArgs.length; i++)
   this.listBoxControl.OnItemSelectionChanged(this.cachedSelectionChangedArgs[i].Index, this.cachedSelectionChangedArgs[i].Selected);
  this.cachedSelectionChangedArgs = [];
 },
 OnItemInserted: function(index){
  if(index <= this.savedSelectedIndex && this.savedSelectedIndex != -1)
   this.SetSelectedIndexInternal(this.savedSelectedIndex + 1);
 },
 OnItemRemoved: function(index){
  var selectedIndex = this.GetSelectedIndex();
  if(index < this.savedSelectedIndex)
   this.SetSelectedIndexInternal( this.savedSelectedIndex - 1);
  else if(index == this.savedSelectedIndex)
   this.SetSelectedIndexInternal(-1);
 },
 OnItemsCleared: function(){
  this.ClearSelection();
 }
});
var ListBoxMultiSelectionHelper = ASPx.CreateClass(ListBoxSingleSelectionHelper, {
 constructor: function(listBoxControl) {
  this.constructor.prototype.constructor.call(this, listBoxControl);
  this.selectedValuesCache = [];
  this.selectedItemsCache = [];
  this.savedSelectedIndices = [];
  this.selectedIndicesSortingRequired = false;
  this.focusedIndex = -1;
  this.lastIndexFocusedWithoutShift = -1;
 },
 SetSelectedIndex: function(index){
  this.SingleIndexSelection(index);
 },
 ResetSelectionCollectionsCache: function(){
  this.selectedIndicesSortingRequired = true;
  this.selectedItemsCache = [];
  this.selectedValuesCache = [];
 },
 GetSelectedIndices: function(){
  return this.GetSortedSelectedIndices().slice();
 },
 GetSortedSelectedIndices: function() {
  if(this.savedSelectedIndices.length > 1 && this.selectedIndicesSortingRequired)
   this.SortSelectedIndices();
  return this.savedSelectedIndices;
 },
 GetSelectedValues: function(){ 
  if(this.savedSelectedIndices.length == 0)
   return [];
  if(this.selectedValuesCache.length == 0)
   this.selectedValuesCache = this.GetSelectedValuesCore();
  return this.selectedValuesCache;
 },
 GetSelectedValuesCore: function(){
  var selectedValues = [];
  var selectedIndices = this.GetSortedSelectedIndices();
  if(selectedIndices.length == 0)
   return selectedValues;
  for(var i = 0; i < selectedIndices.length; i++)
   selectedValues.push(this.listBoxControl.GetItemValue([selectedIndices[i]]));
  return selectedValues;
 },
 GetSelectedItems: function(){
  if(this.savedSelectedIndices.length == 0)
   return [];
  if(this.selectedItemsCache.length == 0)
   this.selectedItemsCache = this.GetSelectedItemsCore();
  return this.selectedItemsCache;
 },
 GetSelectedItemsCore: function(){
  var selectedItems = [];
  for(var i = 0; i < this.savedSelectedIndices.length; i++)
   selectedItems.push(this.listBoxControl.GetItem(this.savedSelectedIndices[i]));
  return selectedItems;
 },
 SetIndicesSelectionState: function(indices, selected){
  this.BeginSelectionUpdate();
  var controller = typeof(ASPx.GetStateController) != "undefined" ? ASPx.GetStateController() : null;
  var itemCount = this.listBoxControl.GetItemCount();
  if(indices){
   for(var i = 0; i < indices.length; i++){
    var index = indices[i];
    if(index >= 0 && index < itemCount)
     this.SetItemSelectionState(indices[i], selected, controller);
   }
  } else
   this.SetAllItemsSelectionState(selected, controller);
  this.SetSelectedIndexCore(this.GetFirstSelectedIndex());
  this.EndSelectionUpdate();
 },
 SetItemsSelectionState: function(items, selected){
  var indices = items ? this.ConvertItemsToIndices(items) : null;
  this.SetIndicesSelectionState(indices, selected);
 },
 SetValuesSelectionState: function(values, selected){
  var indices = values ? this.ConvertValuesToIndices(values)  : null;
  this.SetIndicesSelectionState(indices, selected);
 },
 ConvertValuesToIndices: function(values){
  var indices = [];
  for(var i = 0; i < values.length; i++)
   indices.push(this.listBoxControl.FindItemIndexByValue(values[i]));
  return indices;
 },
 ConvertItemsToIndices: function(items){
  var indices = [];
  for(var i = 0; i < items.length; i++)
   indices.push(items[i].index);
  return indices;
 },
 SelectIndices: function(indices){
  this.SetIndicesSelectionState(indices, true);
 },
 SelectItems: function(items){
  this.SetItemsSelectionState(items, true);
 },
 SelectValues: function(values){
  this.SetValuesSelectionState(values, true);
 },
 UnselectIndices: function(indices){
  this.SetIndicesSelectionState(indices, false);
 },
 UnselectItems: function(items){
  this.SetItemsSelectionState(items, false);
 },
 UnselectValues: function(values){
  this.SetValuesSelectionState(values, false);  
 },
 GetIsItemSelected: function(index){ 
  return ASPx.Data.ArrayBinarySearch(this.GetSortedSelectedIndices(), index) > -1;
 },
 OnItemClick: function(index, evt){
  this.BeginSelectionUpdate();
  var ctrlKey = evt.ctrlKey || evt.metaKey;
  var shift = evt.shiftKey;
  if(ctrlKey)
   this.AddSelectedIndex(index);
  else if(shift){
   var startIndex = index > this.lastIndexFocusedWithoutShift ? this.lastIndexFocusedWithoutShift + 1 : index;
   var endIndex = index > this.lastIndexFocusedWithoutShift ? index : this.lastIndexFocusedWithoutShift - 1;
   this.SelectRangeIndicesOnly(startIndex, endIndex);
   this.SetFocusedIndexInternal(index, true);
  }else 
   this.SingleIndexSelection(index);
  this.EndSelectionUpdate();
 },
 OnItemCheckBoxClick: function(index, evt){
  this.BeginSelectionUpdate();
  this.AddSelectedIndex(index);
  this.EndSelectionUpdate();
 },
 AddSelectedIndex: function(index){
  this.SetFocusedIndexInternal(index, false);
  var indexInSelectedIndices = ASPx.Data.ArrayIndexOf(this.savedSelectedIndices, index);
  var selectionOperation = indexInSelectedIndices == -1;
  this.SetItemSelectionState(index, selectionOperation);
  this.SetSelectedIndexCore(this.GetFirstSelectedIndex());
 },
 SelectRangeIndicesOnly: function(startIndex, endIndex){
  this.BeginSelectionUpdate();
  var controller = typeof(ASPx.GetStateController) != "undefined" ? ASPx.GetStateController() : null;
  var itemCount = this.GetItemCount();
  for(var i = 0; i < itemCount; i ++) {
   if(i == this.lastIndexFocusedWithoutShift) 
    continue;
   this.SetItemSelectionState(i, i >= startIndex && i <= endIndex, controller);
  }
  this.SetSelectedIndexCore(this.GetFirstSelectedIndex());
  this.EndSelectionUpdate();
 },
 SingleIndexSelection: function(index){
  this.SetFocusedIndexInternal(-1, false);
  this.SelectRangeIndicesOnly(index, index);
  this.SetFocusedIndexInternal(index, false);
 },
 SetAllItemsSelectionState: function(selected, controller){
  this.BeginSelectionUpdate();
  this.savedSelectedIndices = [ ];
  var itemCount = this.GetItemCount();
  for(var i = 0; i < itemCount; i ++) {
   this.SetItemSelectionStateCore(i, selected, controller);
   if(selected)
    this.PushSelectedIndex(i);
   this.OnItemSelectionChanged(i, selected);
  }
  this.ResetSelectionCollectionsCache();
  this.EndSelectionUpdate();
 },
 SetItemSelectionState: function(itemIndex, selected, controller){
  this.SetItemSelectionStateCore(itemIndex, selected, controller);
  this.ResetSelectionCollectionsCache();
  var indexInSelectionArray = ASPx.Data.ArrayIndexOf(this.savedSelectedIndices, itemIndex);
  if(selected && indexInSelectionArray == -1){
   this.PushSelectedIndex(itemIndex);
   this.OnItemSelectionChanged(itemIndex, true);
  }
  if(!selected && indexInSelectionArray != -1){
   this.RemoveSelectedIndexAt(indexInSelectionArray);
   this.OnItemSelectionChanged(itemIndex, false);
  }
 },
 GetFirstSelectedIndex: function(){
  var selectedIndices = this.GetSelectedIndices();
  var selectedIndicesCount = selectedIndices.length;
  var firstSelectedIndex = -1;
  if(selectedIndicesCount > 0){
   firstSelectedIndex = selectedIndices[0];
   for(var i = 1; i < selectedIndices.length; i++){
    if(firstSelectedIndex > selectedIndices[i])
     firstSelectedIndex = selectedIndices[i];
   }
  }
  return firstSelectedIndex;
 },
 PushSelectedIndex: function(index){
  this.savedSelectedIndices.push(index);
 },
 RemoveSelectedIndex: function(index){
  ASPx.Data.ArrayRemove(this.savedSelectedIndices, index);
 },
 RemoveSelectedIndexAt: function(indexInArray){
  ASPx.Data.ArrayRemoveAt(this.savedSelectedIndices, indexInArray);
 },
 SortSelectedIndices: function(){
  ASPx.Data.ArrayIntegerAscendingSort(this.savedSelectedIndices);
  this.selectedIndicesSortingRequired = false;
 },
 SetItemSelectionStateCore: function(itemIndex, selected, controller){
  ListBoxSingleSelectionHelper.prototype.SetItemSelectionState.call(this, itemIndex, selected, controller);
 },
 GetFocusedIndex: function(){
  return this.focusedIndex;
 },
 SetFocusedIndexInternal: function(index, isShiftPressed){
  if(!isShiftPressed)
   this.lastIndexFocusedWithoutShift = index;
  this.focusedIndex = index;
 },
 OnItemInserted: function(index){
  this.ResetSelectionCollectionsCache();
  ListBoxSingleSelectionHelper.prototype.OnItemInserted.call(this, index);
  if(this.focusedIndex >= index)
   this.focusedIndex ++;
  for(var i = 0; i < this.savedSelectedIndices.length; i++){
   if(this.savedSelectedIndices[i] >= index)
    this.savedSelectedIndices[i]++;
  }
 },
 OnItemRemoved: function(index){
  this.ResetSelectionCollectionsCache();
  ListBoxSingleSelectionHelper.prototype.OnItemRemoved.call(this, index);
  if(this.focusedIndex == index)
   this.focusedIndex = -1;
  else if(this.focusedIndex > index)
   this.focusedIndex --;
  if(this.GetIsItemSelected(index))
   this.RemoveSelectedIndex(index);
  for(var i = 0; i < this.savedSelectedIndices.length; i++){
   if(this.savedSelectedIndices[i] > index)
    this.savedSelectedIndices[i]--;
  }
  if(this.GetSelectedIndex() == -1)
   this.SetSelectedIndexCore(this.GetFirstSelectedIndex());
 },
 ClearSelection: function(){
  this.ResetSelectionCollectionsCache();
  ASPx.Data.ArrayClear(this.savedSelectedIndices);
  this.OnSelectionCleared();
  this.SetSelectedIndexCore(-1);
 }
});
var CheckBoxListMultiSelectionHelper = ASPx.CreateClass(ListBoxMultiSelectionHelper, {
 OnItemClick: function(index){
  this.BeginSelectionUpdate();
  this.AddSelectedIndex(index);
  this.EndSelectionUpdate();
 },
 GetFocusedItemIndex: function(){
  return this.lastIndexFocusedWithoutShift;
 }
});
var ListBoxCheckSelectionHelper = ASPx.CreateClass(ListBoxMultiSelectionHelper, {
 OnItemClick: function(index, evt){
  this.BeginSelectionUpdate();
  if(evt.shiftKey)
   ListBoxMultiSelectionHelper.prototype.OnItemClick.call(this, index, evt);
  else
   this.AddSelectedIndex(index);
  this.EndSelectionUpdate();
 }
});
var ListBoxTemporaryCache = ASPx.CreateClass(null, {
 constructor: function() { 
  this.cache = { };
  this.invalidateTimerID = -1;
 },
 Get: function(key, getObjectFunc, context, args) {
  if(this.invalidateTimerID < 0) {
   this.invalidateTimerID = window.setTimeout(function() {
    this.Invalidate();
   }.aspxBind(this), 0);
  }
  if(!ASPx.IsExists(this.cache[key])) {
   if(!ASPx.IsExists(args))
    args = [ ];
   this.cache[key] = getObjectFunc.apply(context, args);
  }
  return this.cache[key];
 },
 Invalidate: function() {
  this.cache = { };
  this.invalidateTimerID = ASPx.Timer.ClearTimer(this.invalidateTimerID);
 }
});
var ASPxClientListBox = ASPx.CreateClass(ASPxClientListBoxBase, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.freeUniqIndex = -1;
  this.isHasFakeRow = false;
  this.headerDiv = null;
  this.headerTable = null;
  this.listTable = null;
  this.sampleItemFirstTextCell = null;
  this.width = "";
  this.hasSampleItem = false;
  this.hoverClasses = [""];
  this.hoverCssArray = [""];
  this.selectedClasses = [""];
  this.selectedCssArray = [""];
  this.disabledClasses = [""];
  this.disabledCssArray = [""];
  this.imageCellExists = false;
  this.scrollHandlerLockCount = 0;
  this.columnFieldNames = [];
  this.textFormatString = "";
  this.defaultImageUrl = "";
  this.selectionMode = 0;
  this.initSelectedIndices = [];
  this.itemHorizontalAlign = "";
  this.emptyTextRowCellIndices = null;
  this.accessibilityHelper = null;
  this.accessibilityHelperID = "";
  this.allowMultipleCallbacks = false;
  this.isCallbackMode = false;
  this.callbackPageSize = -1;
  this.isTopSpacerVisible = false;
  this.isBottomSpacerVisible = false;
  this.serverIndexOfFirstItem = 0;
  this.scrollHelper = null;
  this.changeSelectAfterCallback = 0;
  this.ownerControl = null;
  this.SampleItem = null;
  this.sampleHeaderRow = null;
  this.scrollDivElement = null;
  this.scrollPageSize = 4;
  this.itemsValue = [];
  this.cachedValue = null;
  this.tempCache = new ListBoxTemporaryCache();
  this.sizingConfig.adjustControl = true;
  this.disableScrolling = false;
  this.icbFocusedStyle = null;
  this.icbImageProperties = null;
  this.internalCheckBoxCollection = null;
  this.focusableCheckInput = null;
  this.nativeCheckOnFocusHandler = null;
 },
 Initialize: function() {   
  this.LockScrollHandler();
  this.InitScrollPos();
  if((ASPx.Browser.WebKitTouchUI || (ASPx.Browser.WindowsPhonePlatform && ASPx.Browser.IE)) && !this.disableScrolling)
   ASPx.TouchUIHelper.MakeScrollable(this.GetScrollDivElement(), {showHorizontalScrollbar: false});
  this.CreateInternalCheckBoxCollection();
  this.InitSelection();
  this.AdjustControl();
  this.InitializeLoadOnDemand();
  this.UnlockScrollHandler();
  this.freeUniqIndex = this.GetItemCount();
  ASPxClientEdit.prototype.Initialize.call(this);
  if(ASPx.Browser.Firefox)
   ASPx.Attr.SetAttribute(this.GetScrollDivElement(), "tabIndex", "-1");
 },
 InitDXTextAttributes: function(){
  if(this.emptyTextRowCellIndices != null){
   var itemWithDXTextCount = this.emptyTextRowCellIndices.length;
   for(var i = 0; i < itemWithDXTextCount; i++){
    var itemIndex = this.emptyTextRowCellIndices[i][0];
    var cellIndices = this.emptyTextRowCellIndices[i][1];
    var itemRow = this.GetItemRow(itemIndex);
    for(var j = 0; j < cellIndices.length; j++){
     ASPx.Attr.SetAttribute(itemRow.cells[cellIndices[j]], "DXText", "");
    }
   }
  }
 },
 InitSelection: function(){
  var valueFromLastTime = this.GetValueFromValueInput();
  if(this.MultiSelectionMode()){
   if(valueFromLastTime != ""){
    var serialiser = this.GetSerializingHelper();
    var selectedValuesFromLastTime = serialiser.DeserializeValues(valueFromLastTime);
    var selectedIdicesFromLastTime = [];
    for(var i = 0; i < selectedValuesFromLastTime.length; i++)
     selectedIdicesFromLastTime.push(this.FindItemIndexByValue(selectedValuesFromLastTime[i]));
    this.SelectIndices(selectedIdicesFromLastTime);
   } else
    this.SelectIndices(this.initSelectedIndices);
  } else {
   var selectedIndex = (valueFromLastTime != "") ? 
    this.FindItemIndexByValue(valueFromLastTime) : this.GetSelectedIndexInternal();
   this.SetSelectedIndexInternal(selectedIndex);
   this.SelectIndexSilent(selectedIndex);
  }
  this.CacheValue();
 },
 CreateInternalCheckBoxCollection: function() {
  if(this.IsNativeCheckBoxes() || this.internalCheckBoxCollection)
   return;
  this.internalCheckBoxCollection = new ASPx.CheckBoxInternalCollection(this.icbImageProperties, false, false, null, true, this.accessibilityCompliant);
  var count = this.GetItemCount();
  var enabled = this.GetEnabled();
  var changeEventMethod = ASPx.Attr.ChangeEventsMethod(enabled);
  for(var i = 0; i < count; i++)
   this.AddInternalCheckBoxToCollectionCore(i, enabled, changeEventMethod);
 },
 AddInternalCheckBoxToCollection: function(index) {
  if(!this.internalCheckBoxCollection)
   return;
  var enabled = this.GetEnabled();
  var changeEventMethod = ASPx.Attr.ChangeEventsMethod(enabled);
  this.AddInternalCheckBoxToCollectionCore(index, enabled, changeEventMethod);
 },
 AddInternalCheckBoxToCollectionCore: function(index, enabled, changeEventMethod) {
  var inputElement = this.GetItemCheckBoxInput(index)
  if(inputElement) {
   var internalCheckBox = this.internalCheckBoxCollection.Add(this.GetInternalCheckBoxKey(index), inputElement);
   internalCheckBox.CreateFocusDecoration(this.icbFocusedStyle);
   internalCheckBox.SetEnabled(enabled);
   internalCheckBox.autoSwitchEnabled = false;
   var checkBoxFocusableElement = this.GetCheckBoxFocusableElement(index);
   this.ChangeSpecialInputEnabledAttributes(checkBoxFocusableElement, changeEventMethod, true);
   internalCheckBox.CheckedChanged.AddHandler(
    function(s, e) {
     if(ASPx.Evt.GetKeyCode(e) == ASPx.Key.Space) {
      var element = ASPx.Evt.GetEventSource(e);
      this.GetItemSelectionHelper().OnItemCheckBoxClick(this.FindInternalCheckBoxIndex(element), e);
     }
    }.aspxBind(this)
   );
   internalCheckBox.Focus.AddHandler(
    function(s, e) {
     var index = this.FindInternalCheckBoxIndex(s.mainElement);
     window.setTimeout(function() { this.ScrollToItemVisible(index); }.aspxBind(this), 50);
    }.aspxBind(this)
   );
  }
 },
 ClearInternalCheckBoxCollection: function() {
  if(this.internalCheckBoxCollection)
   this.internalCheckBoxCollection.Clear();
 },
 RemoveInternalCheckBoxFromCollecntion: function(index) {
  if(this.internalCheckBoxCollection)
   this.internalCheckBoxCollection.Remove(this.GetItemValue(index));
 },
 GetInternalCheckBoxKey: function(index) {
  return this.name + nameSeparator + this.GetItemValue(index);
 },
 GetInternalCheckBox: function (index) {
  if(this.internalCheckBoxCollection == null)
   this.CreateInternalCheckBoxCollection()
  if(this.internalCheckBoxCollection)
   return this.internalCheckBoxCollection.Get(this.GetInternalCheckBoxKey(index));
  return null;
 },
 IsNativeCheckBoxes: function() {
  return !this.icbImageProperties;
 },
 SetCheckBoxChecked: function(index, checked) {
  if(this.IsNativeCheckBoxes()) {
   var checkBox = this.GetItemCheckBoxInput(index);
   checkBox.checked = checked;
  }
  else {
   var internalCheckBox = this.GetInternalCheckBox(index);
   internalCheckBox.SetValue(checked ? ASPx.CheckBoxInputKey.Checked : ASPx.CheckBoxInputKey.Unchecked);
  }
 },
 SetCheckBoxEnabled: function(index, enabled) {
  var inputElement; 
  if(this.IsNativeCheckBoxes()) {
   var checkbox = this.GetItemCheckBoxInput(index);
   checkbox.disabled = !enabled;
   this.ChangeNativeCheckEnabledAttributes(checkbox, ASPx.Attr.ChangeEventsMethod(this.GetEnabled()));
   inputElement = checkbox;
  }
  else {
   var internalCheckBox = this.GetInternalCheckBox(index);
   internalCheckBox.SetEnabled(enabled);
   inputElement = internalCheckBox.inputElement;
  }
  this.ChangeSpecialInputEnabledAttributes(inputElement, ASPx.Attr.ChangeEventsMethod(enabled));
 },
 ClearItems: function() {
  ASPxClientListBoxBase.prototype.ClearItems.call(this);
  this.ClearInternalCheckBoxCollection();
  this.freeUniqIndex = this.GetItemCount();
 },
 OnDelayedSpecialFocusMouseDown: function(evt) {
  if(this.GetIsCheckColumnExists())
   this.SetFocusableCheckInput(this.GetCheckBoxInputFromEvent(evt));
  ASPxClientListBoxBase.prototype.OnDelayedSpecialFocusMouseDown.call(this, evt);
  var shiftPressed = evt.shiftKey;
  var ctrlKey = evt.ctrlKey || evt.metaKey;
  if(shiftPressed || ctrlKey){
   ASPx.Selection.Clear();
   if(ASPx.Browser.IE)
    ASPx.Evt.PreventEventAndBubble(evt);
  }
 },
 GetCheckBoxInputFromEvent: function(evt) {
  var element = ASPx.Evt.GetEventSource(evt);
  if(this.IsNativeCheckBoxes())
   return element.type == "checkbox" ? element : null;
  var index = this.FindInternalCheckBoxIndex(element);
  return index > -1 ? this.GetCheckBoxFocusableElement(index) : null;
 },
 GetCheckBoxFocusableElement: function(index) {
  return this.accessibilityCompliant ? this.GetInternalCheckBox(index).mainElement : this.GetInternalCheckBox(index).inputElement;
 },
 FindInternalCheckBoxIndex: function(element) {
  var level = 5;
  while(level > 0) {
   var id = element.id;
   if(id && element.tagName == "TD" && id.slice(-1) == lbIPostfixes[0])
    return element.parentNode.rowIndex;
   element = element.parentNode;
   level--;
  }
  return -1;
 },
 IsCheckBoxClicked: function(evt) {
  return !!this.GetCheckBoxInputFromEvent(evt);
 },
 GetFocusableInputElement: function() {
  return this.focusableCheckInput || this.GetInputElement();
 },
 SetFocusableCheckInput: function(element) {
  this.focusableCheckInput = element;
 },
 OnFocusCore: function() {
  if(this.UseDelayedSpecialFocus())
   window.clearTimeout(this.specialFocusTimer);
  if(this.focused) {
   this.UnlockFocusEvents();
   return;
  }
  ASPxClientListBoxBase.prototype.OnFocusCore.call(this);
 },
 OnLostFocusCore: function() {
  if(!this.IsFocusEventsLocked())
   this.SetFocusableCheckInput(null);
  ASPxClientListBoxBase.prototype.OnLostFocusCore.call(this);
 },
 GetValueFromValueInput: function(){
  if(this.ShouldRestoreSelectionAfterBackPressed()){
   var valueInput = this.FindStateInputElement();
   if(ASPx.IsExistsElement(valueInput))
    return valueInput.value;
  }
  return "";
 },
 ShouldRestoreSelectionAfterBackPressed: function(){
  return ASPx.Browser.IE || ASPx.Browser.Chrome;
 },
 GetInitSelectedIndex: function(){
  return this.savedSelectedIndex;
 },
 CacheValue: function(){
  this.cachedValue = this.GetValue();
 },
 InitScrollPos: function(){ 
  if(!this.isComboBoxList && this.isCallbackMode && this.GetInitSelectedIndex() == -1)
   this.GetScrollDivElement().scrollTop = 0;
 },
 InitializeLoadOnDemand: function(){
  var loadOnDemandRequired = this.isCallbackMode && this.GetEnabledByServer();
  this.scrollHelper = loadOnDemandRequired ? new ListBoxScrollCallbackHelper(this) : new ListBoxScrollCallbackHelperBase(this);
 },
 InlineInitialize: function(){
  this.InitializeNativeCheckHandlers();
  this.LockScrollHandler();
  if(!this.disableScrolling)
   this.InitSpecialKeyboardHandling();
  this.InitializeItemsAttributes();
  this.InitDXTextAttributes();
  this.GenerateStateItems();
  this.UnlockScrollHandler();
  ASPxClientListBoxBase.prototype.InlineInitialize.call(this);
 },
 InitializeNativeCheckHandlers: function() {
  this.nativeCheckOnFocusHandler = function(evt) {
   this.SetFocusableCheckInput(ASPx.Evt.GetEventSource(evt));
  }.aspxBind(this);
 },
 ChangeNativeCheckEnabledAttributes: function(element, method) {
  if(this.nativeCheckOnFocusHandler)
   method(element, "focus", this.nativeCheckOnFocusHandler);
 },
 InitializeItemsAttributes: function() { 
  var listTable = this.GetListTable();
  if(this.isHasFakeRow){
   this.LockSynchronization();
   this.ClearItems();
   this.UnlockSynchronization();
  }
  listTable.ListBoxId = this.name;  
  var rows = listTable.rows;
  var count = this.GetItemCount();
  if(this.accessibilityCompliant && this.IsMultiColumn())
   count--;
  var rowIdConst = this.name + "_";
  if(this.hasSampleItem)
   this.InitializeItemAttributes(this.GetSampleItemRow(), rowIdConst + lbSIIdSuffix);
  rowIdConst += lbIIdSuffix;
  for(var i = 0; i < count; i ++)
   this.InitializeItemAttributes(rows[i], rowIdConst + i);
  if(this.accessibilityCompliant && rows[count])
   rows[count].id = this.GetAccessibilityHeaderRowID();
 },
 InitializeItemAttributes: function(row, rowId) {
  var cells = row.cells;
  var itemCellsIdSuffixes = this.GetItemCellsIdPostfixes();
  for(var i = 0; i < row.cells.length; i++) {
   cells[i].style.textAlign = this.itemHorizontalAlign;
   cells[i].id = rowId + itemCellsIdSuffixes[i];
  }
  if(this.GetIsCheckColumnExists() && this.IsNativeCheckBoxes() && rowId != this.GetSampleItemRowID()) {
   var input = this.GetItemCheckBoxInput(row.rowIndex);
   this.ChangeNativeCheckEnabledAttributes(input, ASPx.Attr.ChangeEventsMethod(this.GetEnabled()));
   this.ChangeSpecialInputEnabledAttributes(input, ASPx.Attr.ChangeEventsMethod(this.GetEnabled()));
  }
 },
 InitializePageSize: function(){
  var divElement = this.GetScrollDivElement();
  var listTable = this.GetListTable();
  var count = this.GetItemCount();
  if(divElement && count > 0)
   this.scrollPageSize = Math.round(divElement.clientHeight / listTable.rows[0].offsetHeight) - 1;
 },
 GenerateStateItems: function() {
  if(typeof(ASPx.GetStateController) == "undefined") return;
  var itemCellsIdSuffixes = this.GetItemCellsIdPostfixes();
  var count = this.GetItemCount();
  var constName = this.name + "_" + lbIIdSuffix;
  var name = "";
  var controller = ASPx.GetStateController();
  var i = this.hasSampleItem ? -1 : 0 ;
  for(; i < count; i ++){
   name = constName + i;
   if(!ASPx.Browser.WebKitTouchUI)
    controller.AddHoverItem(name, this.hoverClasses, this.hoverCssArray, itemCellsIdSuffixes, null, null, true);
   controller.AddSelectedItem(name, this.selectedClasses, this.selectedCssArray, itemCellsIdSuffixes, null, null, true);
   controller.AddDisabledItem(name, this.disabledClasses, this.disabledCssArray, itemCellsIdSuffixes, null, null, true);
  }
 },
 AfterInitialize: function() {
  if(this.disableScrolling) {
   var scrollDiv = this.GetScrollDivElement();
   var mainElement = this.GetMainElement();
   scrollDiv.style.height = mainElement.style.height = ASPx.GetClearClientHeight(this.GetListTable()) + "px";
  }
  this.CallbackSpaceInit(true);
  if(this.accessibilityCompliant)
   this.accessibilityHelper = new AccessibilityHelperListBox(this);
  this.constructor.prototype.AfterInitialize.call(this);
 },
 GetEnabledByServer: function(){
  return this.enabled;
 },
 SetEnabled: function(enabled){  
  ASPxClientListBoxBase.prototype.SetEnabled.call(this, enabled);
  this.CallbackSpaceInit(false);
 },
 CallbackSpaceInit: function(isInitialization){
  if(this.isCallbackMode){
   this.SetBottomScrollSpacerVisibility(this.GetScrollSpacerVisibility(false));
   this.SetTopScrollSpacerVisibility(this.GetScrollSpacerVisibility(true));
   if(isInitialization || this.isComboBoxList){
    this.EnsureSelectedItemVisible();
    ASPx.Evt.AttachEventToElement(this.GetScrollDivElement(), "scroll", aspxLBScroll);
   }
  }
 },
 GetListTable: function() {
  return this.tempCache.Get("ListTable", this.GetListTableCore, this);
 },
 GetListTableCore: function(){
  if(!ASPx.IsExistsElement(this.listTable))
   this.listTable = ASPx.GetElementById(this.name + lTableIdSuffix);
  return this.listTable;
 },
 GetListTableHeight: function(){
  return this.GetListTable().offsetHeight;
 },
 GetHeaderDivElement: function(){
  if(!ASPx.IsExistsElement(this.headerDiv))
   this.headerDiv = ASPx.GetElementById(this.name + lbHeaderDivIdSuffix);
  return this.headerDiv;
 },
 GetHeaderTableElement: function(){
  if(!ASPx.IsExistsElement(this.headerTable)){
   var headerDiv = this.GetHeaderDivElement();
   this.headerTable = ASPx.GetNodeByTagName(headerDiv, "table", 0);
  }
  return this.headerTable;
 },
 GetScrollDivElement: function(){
  if(!ASPx.IsExistsElement(this.scrollDivElement))
   this.scrollDivElement = document.getElementById(this.name + lbDSuffix);
  return this.scrollDivElement;
 },
 GetItemElement: function(index) {
  var itemElement = this.GetItemRow(index);
  return itemElement ? itemElement.cells[0] : null;
 },
 GetItemRow: function(index){
  var listTable = this.GetListTable();
  if(listTable && index >= 0)
   return listTable.rows[index] || null;
  return null;
 },
 GetItemTexts: function(item) {
  return item.texts ? item.texts : [ item.text ];
 },
 GetItemCount: function(){
  var lbt = this.GetListTable();
  if(lbt) {
   var rowLength = lbt.rows.length;
   if(!!this.GetAccessibilityHeaderRow())
    rowLength--;
   return rowLength;
  }
  return 0;
 },
 GetVisibleItemCount: function(){
  var lbTable = this.GetListTable();
  var count = this.GetItemCount();
  var visibleItemCount = 0;
  for(var i = 0; i < count; i ++){
   if(ASPx.GetElementDisplay(lbTable.rows[i]))
    visibleItemCount++;
  }
  return visibleItemCount;
 },
 GetIndexVisibleItem: function(item) {
  var lbTable = this.GetListTable();
  var count = this.GetItemCount();
  var visibleItemCount = 0;
  for(var i = 0; i < count; i ++){
   if(ASPx.GetElementDisplay(lbTable.rows[i]))
    visibleItemCount++;
   var curItem = this.GetItem(i);
   if(item.value === curItem.value && item.text === curItem.text)
    break;
  }
  return visibleItemCount;
 },
 GetItemCellCount: function(){
  if(this.hasSampleItem)
   return this.GetSampleItemRow().cells.length;
  else if(this.GetItemCount() > 0){
   var listTable = this.GetListTable();
   return listTable.rows[0].cells.length;
  }
  return 0;
 },
 GetItemTextCellCount: function(){
  return this.GetItemCellCount() - this.GetItemFirstTextCellIndex();
 },
 GetItemFirstTextCellIndex: function(){
  var itemFirstTextCellIndex  = 0;
  if(this.GetIsCheckColumnExists())
   itemFirstTextCellIndex++;
  if(this.imageCellExists)
   itemFirstTextCellIndex++;
  return itemFirstTextCellIndex;
 },
 GetItemFirstTextCell: function(index){
  var rowElement = this.GetItemRow(index);
  if(rowElement == null) 
   return null;
   return rowElement.cells[this.GetItemFirstTextCellIndex()];
 },
 GetItemTopOffset: function(index){
  var itemElement = this.GetItemElement(index);
  return (itemElement != null) ? itemElement.offsetTop + this.GetTopScrollSpacerHeight() : 0;
 },
 GetItemHeight: function(index){
  var itemElement = this.GetItemElement(index);
  return (itemElement != null) ? itemElement.offsetHeight : 0;
 },
 GetItemCheckBoxInput: function(index){
  var itemRow = this.GetItemRow(index);
  var checkBoxCell = itemRow.cells[this.GetCheckBoxCellIndex()];
  return ASPx.GetNodesByTagName(checkBoxCell, "input")[0];
 },
 GetItemImageUrl: function(item) {
  return item.imageUrl != "" ? item.imageUrl : this.defaultImageUrl;
 },
 GetIsCheckColumnExists: function(){
  if(!this.checkCellExists)
   this.checkCellExists = this.CheckColumnSelectionMode();
  return this.checkCellExists;
 },
 GetCheckBoxCellIndex: function(){
  return 0;
 },
 GetImageCellIndex: function(){
  return this.GetIsCheckColumnExists() ? 1 : 0;
 },
 GetItemCellsIdPostfixes: function(){
  if(this.itemCellsIdPostfixes == null){
   this.itemCellsIdPostfixes = [];
   var i = 0;
   if(this.GetIsCheckColumnExists()) {
    this.itemCellsIdPostfixes.push(lbIPostfixes[0]);
    i++;
   }
   if(this.imageCellExists){
    this.itemCellsIdPostfixes.push(lbIPostfixes[1]);
    i++;
   }
   var cellCount = this.GetItemCellCount();
   for(; i < cellCount; i++) 
    this.itemCellsIdPostfixes.push(lbIPostfixes[2] + i);
  }
  return this.itemCellsIdPostfixes;
 },
 AdjustControl: function (nestedCall) {
  if(this.IsAdjustmentRequired()) 
   this.heightCorrected = false;
  ASPxClientEdit.prototype.AdjustControl.call(this, nestedCall);
 },
 AdjustControlCore: function(){
  if(this.disableScrolling)
   return;
  ASPxClientEdit.prototype.AdjustControlCore.call(this);
  this.CorrectSize();
  this.EnsureSelectedItemVisible();
  if(!this.isComboBoxList && ASPx.Browser.IE) 
   this.CorrectWidth();
 },
 CorrectSize: function() {
  if(this.isComboBoxList || this.disableScrolling)
   return;
  this.LockScrollHandler();
  this.CorrectHeight();
  this.CorrectWidth();
  this.InitializePageSize();
  this.UnlockScrollHandler();
 },
 OnCorrectSizeByTimer: function() {
  if(this.IsVisible())
   this.CorrectSize();
 }, 
 SetProtectionFromFlick_inFF: function(changeVisibility, changeDisplay){
  if(!ASPx.Browser.Firefox) return;
  var listTable = this.GetListTable();
  if(changeVisibility)
   listTable.style.visibility = "hidden";
  if(changeDisplay)
   listTable.style.display = "none";
 },
 ResetProtectionFromFlick_inFF: function(){
  if(!ASPx.Browser.Firefox) return;
  var listTable = this.GetListTable();
  listTable.style.visibility = "";
  listTable.style.display = "";
 },
 CorrectHeight: function(){
  if(ASPx.Browser.Firefox && this.heightCorrected) return; 
  this.heightCorrected = true;
  var mainElement = this.GetMainElement();
  var divElement = this.GetScrollDivElement();
  divElement.style.height = "0px";
  var height = mainElement.offsetHeight;
  divElement.style.height = height + "px";
  var extrudedHeight = mainElement.offsetHeight;
  var heightCorrection = extrudedHeight - height;
  if(heightCorrection > 0){
   var divHeight = divElement.offsetHeight;
   this.SetProtectionFromFlick_inFF(true, false);
   divElement.style.height = (divHeight - heightCorrection) + "px";
   this.ResetProtectionFromFlick_inFF(); 
   extrudedHeight = mainElement.offsetHeight;
   var paddingsHeightCorrection = extrudedHeight - height;
   if(paddingsHeightCorrection > 0)
    divElement.style.height = (divHeight - heightCorrection - paddingsHeightCorrection) + "px";
  } 
 },
 IsMultiColumn: function(){
  return this.columnFieldNames.length > 0;
 },
 CorrectWidth: function(){
  if(this.IsMultiColumn())
   this.CorrectMultiColumnWidth();
  else
   this.CorrectNonMultiColumnWidth();
 },
 CorrectMultiColumnWidth: function(){
  var scrollDivElement = this.GetScrollDivElement();
  var scrollBarWidth = this.GetVerticalScrollBarWidth(); 
  this.CorrectMultiColumnHeaderWidth(scrollBarWidth);
 },
 CollapseMultiColumnHeaderWidth:function(){
  var headerDivElement = this.GetHeaderDivElement();
  headerDivElement.style.width = "0px";
 },
 CorrectMultiColumnHeaderWidth: function(scrollBarWidth){
  var scrollDivElement = this.GetScrollDivElement();
  var headerDivElement = this.GetHeaderDivElement();
  if(ASPx.IsExistsElement(headerDivElement)){
   var headerTable;
   if(ASPx.Browser.WebKitFamily){
    headerTable = this.GetHeaderTableElement();
    if(!ASPx.IsExistsElement(headerTable))
     headerTable = null;
   }
   if(headerTable)
    headerTable.style.width = "0";
   if(this.rtl)
    headerDivElement.style.paddingLeft = scrollBarWidth + "px";
   else
    headerDivElement.style.paddingRight = scrollBarWidth + "px";
   if(headerTable)
    window.setTimeout(function() { headerTable.style.width = "100%"; }, 0);
  }
 },
 CorrectNonMultiColumnWidth: function(){
  var divElement = this.GetScrollDivElement();
  if(this.width == ""){
   var listTable = this.GetListTable();
   var mainElement = this.GetMainElement();
   if(listTable.offsetWidth != 0 || !ASPx.Browser.NetscapeFamily){ 
    divElement.style.width = (listTable.offsetWidth + this.GetVerticalScrollBarWidth()) + "px";
    if(ASPx.Browser.Firefox) 
     mainElement.style.width = divElement.offsetWidth + "px";
   }
  } else {  
   var mainElement = this.GetMainElement();  
   mainElement.style.width = this.width;
   if(this.width !== "100%") {
    divElement.style.width = ASPx.Browser.WebKitFamily ? "1px" : "0px";
    divElement.style.width = mainElement.clientWidth + "px";
   }
  }
 },
 UpdateAdjustmentFlags: function() {
  var mainElement = this.GetMainElement();
  if(mainElement) {
   var mainElementStyle = ASPx.GetCurrentStyle(mainElement);
   this.UpdatePercentSizeConfig([this.width], [mainElementStyle.height, mainElement.style.height]);
  }
 },
 EnsureSelectedItemVisible: function(){
  var index = this.GetSelectedIndex();
  if(index != -1)
   this.MakeItemVisible(index);
 },
 MakeItemVisible: function(index){
  if(!this.IsItemVisible(index))
   this.ScrollItemToTop(index);
 },
 IsItemVisible: function(index){
  var scrollDiv = this.GetScrollDivElement();
  var itemElement = this.GetItemElement(index);
  var topVisible = false;
  var bottomVisible = false;
  if(itemElement != null){
   var itemOffsetTop = itemElement.offsetTop + this.GetTopScrollSpacerHeight();
   topVisible = itemOffsetTop >= scrollDiv.scrollTop;
   bottomVisible = itemOffsetTop + itemElement.offsetHeight < scrollDiv.scrollTop + scrollDiv.clientHeight;
  }
  return (topVisible && bottomVisible);
 },
 ScrollItemToTop: function(index){
  this.LockScrollHandler();
  this.SetScrollTop(this.GetItemTopOffset(index));
  this.UnlockScrollHandler();
 },
 ScrollToItemVisible: function(index){
  if(!this.IsItemVisible(index)){
   var scrollDiv = this.GetScrollDivElement();
   var scrollTop = scrollDiv.scrollTop;
   var scrollDivHeight = scrollDiv.clientHeight;
   var itemOffsetTop = this.GetItemTopOffset(index);
   var itemHeight = this.GetItemHeight(index);
   var itemAbove = scrollTop > itemOffsetTop;
   var itemBelow = scrollTop  + scrollDivHeight < itemOffsetTop + itemHeight;
   if(itemAbove)
    scrollDiv.scrollTop = itemOffsetTop;
   else if(itemBelow){
    var scrollPaddings = scrollDiv.scrollHeight - this.GetListTable().offsetHeight - 
     this.GetTopScrollSpacerHeight() - this.GetBottomScrollSpacerHeight();
    scrollDiv.scrollTop = itemOffsetTop + itemHeight - scrollDivHeight + scrollPaddings;
   }
  }
 },
 SetScrollTop: function(scrollTop){
  var scrollDiv = this.GetScrollDivElement();
  if(scrollDiv){ 
   scrollDiv.scrollTop = scrollTop;
   if(ASPx.Browser.Opera) 
    this.CachedScrollTop();
  }   
 },
 CachedScrollTop: function(){
  var scrollDiv = this.GetScrollDivElement();
  scrollDiv.cachedScrollTop = scrollDiv.scrollTop;
 },
 RestoreScrollTopFromCache: function(){
  var scrollDiv = this.GetScrollDivElement();
  if(scrollDiv && ASPx.IsExists(scrollDiv.cachedScrollTop))
   scrollDiv.scrollTop = scrollDiv.cachedScrollTop;
 },
 IsListBoxWidthLessThenList: function(){
  var divElement = this.GetScrollDivElement();
  var listTable = this.GetListTable();
  var listTabelWidth = listTable.style.width;
  var isLess = false;
  listTable.style.width = "";
  isLess = listTable.offsetWidth < divElement.offsetWidth;
  listTable.style.width = listTabelWidth;
  return isLess;
 },
 GetVerticalScrollBarWidth: function(){
  var divElement = this.GetScrollDivElement(); 
  if(!this.verticalScrollBarWidth || this.verticalScrollBarWidth <= 0){
   this.verticalScrollBarWidth = this.GetVerticalScrollBarWidthCore(divElement);
   return this.verticalScrollBarWidth;
  } else
   return this.GetIsVerticalScrollBarVisible(divElement) ? this.verticalScrollBarWidth : 0;
 },
 GetIsVerticalScrollBarVisible: function(divElement){
  var verticalOverflow = this.GetVerticalOverflow(divElement);
  if(verticalOverflow != "auto"){ 
   var listTable = this.GetListTable();
   return divElement.clientHeight < listTable.offsetHeight;
  } else {
   var borderWidthWithScroll = divElement.offsetWidth - divElement.clientWidth;
   return borderWidthWithScroll == this.scrollDivBordersWidthWithScroll;
  }
 },
 GetVerticalScrollBarWidthCore: function(divElement){
  var overflowYReserv = this.GetVerticalOverflow(divElement);
  this.SetVerticalOverflow(divElement, "auto");
  this.scrollDivBordersWidthWithScroll = divElement.offsetWidth - divElement.clientWidth;
  if(ASPx.Browser.IE)
   return this.scrollDivBordersWidthWithScroll; 
  this.SetProtectionFromFlick_inFF(false, true);
  this.SetVerticalOverflow(divElement, "hidden");
  var bordersWidthWithoutScroll = divElement.offsetWidth - divElement.clientWidth;
  this.SetVerticalOverflow(divElement, overflowYReserv);
  this.ResetProtectionFromFlick_inFF();
  return this.scrollDivBordersWidthWithScroll - bordersWidthWithoutScroll;
 },
 GetVerticalOverflow: function(element){
  if(ASPx.Browser.IE || ASPx.Browser.Safari && ASPx.Browser.Version >= 3 || ASPx.Browser.Chrome)
   return element.style.overflowY;
  return element.style.overflow;
 },
 SetVerticalOverflow: function(element, value) {
  if(ASPx.Browser.IE || ASPx.Browser.Safari && ASPx.Browser.Version >= 3 || ASPx.Browser.Chrome || ASPx.Browser.AndroidDefaultBrowser) {
   element.style.overflowY = value;
  } else {
   element.style.overflow = value;
  }
 },
 MultiSelectionMode: function(){
  return this.selectionMode != ListBoxSelectionMode.Single;
 },
 CheckColumnSelectionMode: function(){
  return this.selectionMode == ListBoxSelectionMode.CheckColumn;
 },
 OnItemClick: function(index, evt){
  if(!this.isInitialized) 
   return;
  if(this.readOnly)
   return this.OnItemClickOrDblClickReadOnly();
  if(this.CheckColumnSelectionMode() && this.IsCheckBoxClicked(evt))
   this.GetItemSelectionHelper().OnItemCheckBoxClick(index, evt);
  else
   this.GetItemSelectionHelper().OnItemClick(index, evt);
  this.SetFocus();
  this.RaiseItemClick();
 },
 OnItemClickOrDblClickReadOnly: function(){
  return false;
 },
 OnItemDblClick: function(){
  if(this.readOnly)
   return this.OnItemClickOrDblClickReadOnly();
  return this.RaiseItemDoubleClick();
 },
 CanChangeSelection: function(){
  return !this.readOnly || !this.isInitialized;
 },
 SelectIndexSilent: function(index){ 
  return this.SetItemSelectionStateSilent(index);
 },
 SetItemSelectionStateSilent: function(index){
  if(!this.CanChangeSelection())
   return;
  var oldSelectionIndex = this.GetSelectedIndex();
  this.LockSelectionEvents();
  this.SetSelectedIndexCore(index);
  this.UnlockSelectionEvents();
  return index != oldSelectionIndex;
 },
 SetItemSelectionAppearance: function(index, selected, controller){
  if(!this.CanChangeSelection())
   return;
  if(!controller)
   controller = ASPx.GetStateController();
  var itemFirstTextCell = this.GetItemFirstTextCell(index);
  if(selected)
   controller.SelectElementBySrcElement(itemFirstTextCell);
  else
   controller.DeselectElementBySrcElement(itemFirstTextCell);
 },
 GetItemSelectionHelper: function(){
  if(!this.itemSelectionHelper)
   this.itemSelectionHelper = this.CreateItemSelectionHelper();
  return this.itemSelectionHelper;
 },
 CreateItemSelectionHelper: function(){
  if(this.selectionMode == ListBoxSelectionMode.Single)
   return new ListBoxSingleSelectionHelper(this);
  else if(this.selectionMode == ListBoxSelectionMode.Multiple)
   return new ListBoxMultiSelectionHelper(this);
  else if(this.selectionMode == ListBoxSelectionMode.CheckColumn)
   return new ListBoxCheckSelectionHelper(this);
 },
 GetValue: function(){
  var index = this.GetSelectedIndex();
  if(0 <= index && index < this.itemsValue.length)
   return this.itemsValue[index];
  return null;
 },
 SetValue: function(value){
  var index = this.FindItemIndexByValue(value);
  this.SetSelectedIndex(index);
 },
 GetSelectedItem: function(){
  var index = this.GetSelectedIndex();
  return this.GetItem(index);
 },
 GetSelectedIndex: function(){
  if(!this.isInitialized)
   return this.GetSelectedIndexInternal();
  return this.GetItemSelectionHelper().GetSelectedIndex();
 },
 SetSelectedIndex: function(index){
  this.LockSelectionEvents();
  this.SetSelectedIndexCore(index);
  this.EnsureSelectedItemVisible(index);
  this.UnlockSelectionEvents();
 },
 SetSelectedIndexCore: function(index){
  this.GetItemSelectionHelper().SetSelectedIndex(index);
 },
 GetSelectedIndices: function(){
  return this.GetItemSelectionHelper().GetSelectedIndices();
 },
 GetSelectedValues: function(){ 
  return this.GetItemSelectionHelper().GetSelectedValues();
 },
 GetSelectedItems: function(){
  return this.GetItemSelectionHelper().GetSelectedItems();
 },
 SelectAll: function(){
  this.SelectIndices();
 },
 UnselectAll: function(){
  this.UnselectIndices();
 },
 SelectIndices: function(indices){
  this.LockSelectionEvents();
  this.GetItemSelectionHelper().SelectIndices(indices);
  this.UnlockSelectionEvents();
 },
 SelectItems: function(items){
  this.LockSelectionEvents();
  this.GetItemSelectionHelper().SelectItems(items);
  this.UnlockSelectionEvents();
 },
 SelectValues: function(values){
  this.LockSelectionEvents();
  this.GetItemSelectionHelper().SelectValues(values);
  this.UnlockSelectionEvents();
 },
 UnselectIndices: function(indices){
  this.LockSelectionEvents();
  this.GetItemSelectionHelper().UnselectIndices(indices);
  this.UnlockSelectionEvents();
 },
 UnselectItems: function(items){
  this.LockSelectionEvents();
  this.GetItemSelectionHelper().UnselectItems(items);
  this.UnlockSelectionEvents();
 },
 UnselectValues: function(values){
  this.LockSelectionEvents();
  this.GetItemSelectionHelper().UnselectValues(values);
  this.UnlockSelectionEvents();
 },
 GetIsItemSelected: function(index){
  return this.GetItemSelectionHelper().GetIsItemSelected(index);
 },
 GetFocusedIndex: function(){
  return this.GetItemSelectionHelper().GetFocusedIndex();
 },
 UpdateInternalState: function(){
  this.UpdateHiddenInputs();
 },
 IsUpdateHiddenInputsLocked: function(){
  return this.GetItemSelectionHelper().IsUpdateInternalSelectionStateLocked();
 },
 UpdateHiddenInputs: function(){
  if(this.IsUpdateHiddenInputsLocked())
   return;
  if(this.MultiSelectionMode()){ 
   var element = this.FindStateInputElement();
   if(ASPx.IsExistsElement(element)) {
    var sb = [ ];
    var serialiser = this.GetSerializingHelper();
    var selectedIndices = this.GetSelectedIndices();
    for(var i = 0; i < selectedIndices.length; i++)
     serialiser.SerializeAtomValue(sb, this.GetItemValue(selectedIndices[i]));
    element.value = sb.join("");
   }
  } else 
   ASPxClientListBoxBase.prototype.UpdateHiddenInputs.call(this);
 },
 UseDelayedSpecialFocus: function() { 
  return true;
 },
 ShowLoadingPanel: function() { 
  if(!this.isComboBoxList){
   var loadingParentElement = this.GetScrollDivElement().parentNode;
   var lp = this.CreateLoadingPanelWithAbsolutePosition(loadingParentElement);
   this.PreventMouseWheelOnElement(lp);
  }
 },
 ShowLoadingDiv: function () {
  if(!this.isComboBoxList){
   var loadingParentElement = this.GetScrollDivElement().parentNode;
   var ld = this.CreateLoadingDiv(loadingParentElement);
   this.PreventMouseWheelOnElement(ld);
  }
 },
 PreventMouseWheelOnElement: function(element) {
  if(!element) return;
  var wheelEventName = ASPx.Evt.GetMouseWheelEventName();
  ASPx.Evt.AttachEventToElement(element, wheelEventName, function(evt) {
   if(this.scrollHelper.GetIsAnySpacerVisible())
    ASPx.Evt.PreventEvent(evt);
  }.aspxBind(this));
 },
 ParseCallbackResult: function(result, shouldSelectSilentDelegate){
  var gottenEgdeOfCollection = false;
  var nothingToLoad = result == "[]";
  var isLoadindToTopByScroll = this.scrollHelper.IsScrolledToTopSpacer();
  if(!nothingToLoad){
   var deserializedItems = this.DeserializeItems(result);
   this.LoadItemsFromCallback(isLoadindToTopByScroll, deserializedItems, shouldSelectSilentDelegate);
   gottenEgdeOfCollection = deserializedItems.length != this.callbackPageSize;
  }
  var noMoreItemsForLoadThisDirection = nothingToLoad || gottenEgdeOfCollection;
  this.SetScrollSpacerVisibility(isLoadindToTopByScroll, !noMoreItemsForLoadThisDirection);
  this.scrollHelper.Reset();
 },
 LoadItemsFromCallback: function(isToTop, deserializedItems, shouldSelectSilentDelegate){
  this.LockSynchronizationOnInternalCallback();
  this.BeginUpdate();
  var isMultiSelect = this.MultiSelectionMode();
  this.RemoveAccessibilityHeaderRow();
  if(isToTop){
   var scrollHeightCorrection = 0;
   for(var i = deserializedItems.length - 1; i >= 0; i --){
    this.InsertItem(0, deserializedItems[i].texts, deserializedItems[i].value, this.GetItemImageUrl(deserializedItems[i]));
    scrollHeightCorrection += this.GetItemHeight(0);
   } 
   this.GetScrollDivElement().scrollTop += scrollHeightCorrection;
   this.serverIndexOfFirstItem -= deserializedItems.length;
   if(this.serverIndexOfFirstItem < 0) this.serverIndexOfFirstItem = 0;
  } else {
   for(var i = 0; i < deserializedItems.length; i ++){
    var itemIndex = this.AddItem(deserializedItems[i].texts, deserializedItems[i].value, this.GetItemImageUrl(deserializedItems[i]));
    var shouldSelectSilent = shouldSelectSilentDelegate && shouldSelectSilentDelegate(deserializedItems[i].value, deserializedItems[i].text);
    this.SelectValueOnLoad(itemIndex, deserializedItems[i].selected, shouldSelectSilent, isMultiSelect);
   } 
  }
  if(this.changeSelectAfterCallback != 0) {
   var newIndex = this.GetSelectedIndex() + this.changeSelectAfterCallback;
   newIndex = this.GetAdjustedIndex(newIndex);
   this.SelectIndexSilent(newIndex);
   if(this.scrollHelper.isScrolledToTopSpacer)
    this.ScrollItemToTop(newIndex);
   else
    this.ScrollToItemVisible(newIndex);
  }
  this.AddAccessibilityHeaderRow();
  this.EndUpdate();
  this.UnlockSynchronizationOnInternalCallback();
 },
 SelectValueOnLoad: function (index, selected, shouldSelectSilent, isMultiSelect) {
  if(selected && this.changeSelectAfterCallback == 0) {
   if(isMultiSelect) {
    this.SelectIndices([index]);
   } else {
    if(shouldSelectSilent)
     this.SelectIndexSilent(index);
    else
     this.SelectIndex(index);
   }
  }
 },
 CreateSerializingHelper: function(){
  return new ListBoxItemsSerializingHelper(this);
 },
 InCallback: function(){
  var callbackOwner = this.GetCallbackOwnerControl();
  if(callbackOwner != null)
   return callbackOwner.InCallback();
  return ASPxClientListEdit.prototype.InCallback.call(this);
 },
 GetItemsRangeForLoad: function(){
  return this.scrollHelper.GetItemsRangeForLoad();
 },
 GetScrollSpacerElement: function(isTop){
  return document.getElementById(this.name + (isTop ? lbTSIdSuffix : lbBSIdSuffix));
 },
 GetScrollSpacerVisibility: function(isTop){
  if(!this.clientEnabled)
   return false;
  return isTop ? this.isTopSpacerVisible : this.isBottomSpacerVisible;
 },
 SetScrollSpacerVisibility: function(isTop, visibility){
  this.LockScrollHandler();
  var spacer = this.GetScrollSpacerElement(isTop);
  if(spacer){
   if(visibility)
    spacer.style.height = this.GetScrollDivElement().clientHeight + "px";
   if(this.clientEnabled){
    if(isTop)
     this.isTopSpacerVisible = visibility;
    else
     this.isBottomSpacerVisible = visibility;
   }
   if(ASPx.GetElementDisplay(spacer) != visibility){
    ASPx.SetElementDisplay(spacer, visibility);
    ASPx.GetElementVisibility(spacer, visibility);
   }
  }
  this.UnlockScrollHandler();
 },
 SetTopScrollSpacerVisibility: function(visibility){
  this.SetScrollSpacerVisibility(true, visibility);
 },
 SetBottomScrollSpacerVisibility: function(visibility){
  this.SetScrollSpacerVisibility(false, visibility);
 },
 GetTopScrollSpacerHeight: function(){
  return this.GetScrollSpacerVisibility(true) ? this.GetScrollSpacerElement(true).clientHeight : 0;
 },
 GetBottomScrollSpacerHeight: function(){
  return this.GetScrollSpacerVisibility(false) ? this.GetScrollSpacerElement(false).clientHeight : 0;
 },
 SendCallback: function(){
  if(!this.InCallback()){
   this.ShowLoadingElements();
   var callbackOwner = this.GetCallbackOwnerControl();
   if(callbackOwner != null)
    callbackOwner.SendCallback();
    else {
    var argument = this.GetCallbackArguments();
    this.CreateCallback(argument);
   }
  }
 },
 OnCallback: function(result, shouldSelectSilentDelegate) {
  this.ParseCallbackResult(result, shouldSelectSilentDelegate);
  this.OnCallbackFinally();
 },
 OnCallbackError: function(result){
  ASPxClientListBoxBase.prototype.OnCallbackError.call(this, result);
  this.OnCallbackFinally();
 },
 OnCallbackFinally: function(){
  this.HideLoadingPanel();
  this.changeSelectAfterCallback = 0;
 },
 LockScrollHandler: function(){
  this.scrollHandlerLockCount ++;
 },
 UnlockScrollHandler: function(){
  this.scrollHandlerLockCount --;
 },
 IsScrollHandlerLocked: function(){
  return this.scrollHandlerLockCount > 0;
 },
 OnScroll: function(){
  if(this.IsScrollHandlerLocked()) return;
  if(this.IsVisible() && !this.InCallback() && ( this.GetScrollSpacerVisibility(true) || this.GetScrollSpacerVisibility(false))) {
   this.scrollHelper.OnScroll();
   if(this.scrollHelper.GetIsNeedToHideTopSpacer())
    this.SetTopScrollSpacerVisibility(false);
   if(this.scrollHelper.GetIsNeedCallback())
    this.SendCallback();
  }
 },
 OnBrowserWindowResize: function(evt) {
  if(this.IsVisible())
   this.CorrectSize();
 },
 KeyboardSupportAllowed: function(){
  return !this.CheckColumnSelectionMode();
 },
 InitializeKeyHandlers: function() {
  if(this.KeyboardSupportAllowed()){
   this.AddKeyDownHandler(ASPx.Key.PageUp, "OnPageUp");
   this.AddKeyDownHandler(ASPx.Key.PageDown, "OnPageDown");
   this.AddKeyDownHandler(ASPx.Key.End, "OnEndKeyDown");
   this.AddKeyDownHandler(ASPx.Key.Home, "OnHomeKeyDown");
   this.AddKeyDownHandler(ASPx.Key.Up, "OnArrowUp");
   this.AddKeyDownHandler(ASPx.Key.Down, "OnArrowDown");
  } else if(this.accessibilityCompliant && !this.IsNativeCheckBoxes()) {
   this.AddKeyDownHandler(ASPx.Key.Up, "OnAccessArrowUp");
   this.AddKeyDownHandler(ASPx.Key.Down, "OnAccessArrowDown");
  }
 },
 OnArrowUp: function(evt){
  if(this.isInitialized)
   this.SelectNeighbour(-1);
  return true;
 },
 OnArrowDown: function(evt){
  if(this.isInitialized)
   this.SelectNeighbour(1);
  return true;
 },
 OnAccessArrowUp: function(evt){
  if(!this.isInitialized) return true;
  var index = this.GetFocusedIndex();
  var isFocused = this.GetInternalCheckBox(index) && this.GetInternalCheckBox(index).focused;
  if(index <= 0 || !isFocused)
   index = this.GetItemCount() - 1;
  else
   index--;
  this.SetFocusedIndex(index);
  return true;
 },
 OnAccessArrowDown: function(evt){
  if(!this.isInitialized) return true;
  var index = this.GetFocusedIndex();
  var isFocused = this.GetInternalCheckBox(index) && this.GetInternalCheckBox(index).focused;
  if(index < 0 || index == this.GetItemCount() - 1 || !isFocused)
   index = 0;
  else
   index++;
  this.SetFocusedIndex(index);
  return true;
 },
 SetFocusedIndex: function(index) {
  if(this.GetIsCheckColumnExists())
   this.GetInternalCheckBox(index).mainElement.focus();
  this.GetItemSelectionHelper().SetFocusedIndexInternal(index, false);
 },
 OnPageUp: function(evt){
  if(this.isInitialized)
   this.SelectNeighbour(-this.scrollPageSize);
  return true;
 },
 OnPageDown: function(evt){
  if(this.isInitialized)
   this.SelectNeighbour(this.scrollPageSize);
  return true;
 },
 OnHomeKeyDown: function(evt){
  if(this.isInitialized)
   this.SelectNeighbour(-this.GetItemCount());
  return true;
 },
 OnEndKeyDown: function(evt){
  if(this.isInitialized)
   this.SelectNeighbour(this.GetItemCount());
  return true;
 },
 GetAdjustedIndex: function(index){
  if(index < 0) index = 0;
  else{
   var itemCount = this.GetItemCount();
   if(index >= itemCount) index = itemCount - 1;
  }
  return index;
 },
 SelectNeighbour: function (step) {
  var itemCount = this.GetItemCount();
  if(itemCount > 0) {
   this.changeSelectAfterCallback = 0;
   var selectedIndex = this.GetFocusedIndex();
   var pageDownSize = step == 1 ? this.scrollPageSize + 1 : this.scrollPageSize; 
   var isFirstPageDown = selectedIndex == -1 && step == pageDownSize && step > 1;
   var newSelectedIndex = isFirstPageDown ? step : selectedIndex + step;
   newSelectedIndex = this.GetAdjustedIndex(newSelectedIndex);
   if(selectedIndex != newSelectedIndex) {
    this.LockScrollOnKBNavigation();
    this.SetSelectedIndexCore(newSelectedIndex);
    this.UnlockScrollOnKBNavigation();
   }
   if(this.GetIsNeedToCallbackLoadItemsToTop(newSelectedIndex, step, itemCount)) {
    this.LoadItemsOnCallback(true, newSelectedIndex);
   } else if(this.GetIsNeedToCallbackLoadItemsToBottom(newSelectedIndex, step, itemCount)) {
    this.LoadItemsOnCallback(false, newSelectedIndex);
   }
   this.ScrollToItemVisible(newSelectedIndex);
  }
 },
 GetIsNeedToCallbackLoadItemsToTop: function(selectedIndex, step, itemCount){
  return this.isCallbackMode && this.GetScrollSpacerVisibility(true) && 
   this.serverIndexOfFirstItem > 0 && ((step < 0 && selectedIndex <= 0) || step <= -itemCount);
 },
 GetIsNeedToCallbackLoadItemsToBottom: function(selectedIndex, step, itemCount){
  return this.isCallbackMode && this.GetScrollSpacerVisibility(false) && 
   ((step > 0 && selectedIndex >= itemCount - 1) || step >= itemCount);
 },
 LoadItemsOnCallback: function(isToTop, index){
  this.changeSelectAfterCallback = index - this.GetSelectedIndex();
  this.scrollHelper.SetItemsRangeForLoad(isToTop);
  this.SendCallback();
 },
 FindInputElement: function(){
  if(this.accessibilityCompliant)
   return this.isComboBoxList ? null : this.GetAccessibilityServiceElement();
  return this.GetKBSInput();
 },
 GetKBSInput: function() {
  return this.GetChildElement("KBS");
 },
 SetHoverElement: function(element){
  ASPx.GetStateController().SetCurrentHoverElementBySrcElement(element);
 },
 InitOnContainerMadeVisible: function(){
  this.AdjustControl();
 },
 ClearItemsCore: function(){
  this.ClearListTableContent();
  this.OnItemsCleared();
  this.SetValue(null);
 },
 OnItemsCleared: function(){
  this.GetItemSelectionHelper().OnItemsCleared();
 },
 CopyCellWidths: function(sourceRowIndex, destinationRowIndex){
  var cellCount = this.GetItemCellCount();
  var sourceRow = this.GetItemRow(sourceRowIndex);
  var destRow = this.GetItemRow(destinationRowIndex);
  for(var i = 0; i < cellCount; i++)
   destRow.cells[i].style.width = sourceRow.cells[i].style.width;
 },
 RemoveItem: function(index){
  if(index == 0 && this.GetItemCount() > 1)
   this.CopyCellWidths(0, 1);
  if(0 <= index && index < this.GetItemCount()){
   if(this.GetIsCheckColumnExists() && !this.IsNativeCheckBoxes())
    this.RemoveInternalCheckBoxFromCollecntion(index);
   this.UpdateSyncArraysItemDeleted(this.GetItem(index), true);
   var row = this.GetItemRow(index);
   if(ASPx.IsExistsElement(row)){
    var firstCellId = row.cells[0].id;
    var itemId = firstCellId.match(/LBI\d+/)[0];
    this.RemoveStateControllerClasses(itemId);
    row.parentNode.removeChild(row);
   }
   this.OnItemRemoved(index);
  }
 },
 GetItem: function(index){
  var listTable = this.GetListTable();
  var rowLength = this.GetAccessibilityHeaderRow() ? listTable.rows.length - 1 : listTable.rows.length;
  if(!listTable || index < 0 || index >= rowLength)
   return null;
  var row = listTable.rows[index];
  var image = this.imageCellExists ? ASPx.GetNodeByTagName(row.cells[this.GetImageCellIndex()], "IMG", 0) : null;
  var src = image == null ? "" : ASPx.ImageUtils.GetImageSrc(image);
  var i = this.GetItemFirstTextCellIndex();
  var texts = [];
  for(;i < row.cells.length; i ++){
   var textCell = row.cells[i],
    text;
   if(typeof(textCell.attributes["DXText"]) != "undefined")
    text = ASPx.Attr.GetAttribute(textCell, "DXText");
   else
    text = ASPx.GetInnerText(textCell);
   text = text.replace(new RegExp(nbspChar, "g"), " ");
   texts.push(text);
  }
  return new ASPxClientListBoxItem(this, index, texts, this.itemsValue[index], src, this.GetIsItemSelected(index));
 },
 PerformCallback: function(arg) {
  this.SetScrollSpacerVisibility(true, false);
  this.SetScrollSpacerVisibility(false, false);
  this.ClearItemsForPerformCallback();
  this.serverIndexOfFirstItem = 0;
  this.SetScrollSpacerVisibility(true, false);
  this.SetScrollSpacerVisibility(false, false);
  this.FormatAndSetCustomCallbackArg(arg);
  this.SendCallback();
 },
 GetTableRowParent: function(table){
  if(table.tBodies.length > 0)
   return table.tBodies[0];
  return table;
 },
 ProtectWhitespaceSerieses: function(text){
  if(text == "") 
   text = nbsp;
  else {
   if(text.charAt(0) == ' ')
    text = nbsp + text.slice(1);
   if(text.charAt(text.length - 1) == ' ')
    text = text.slice(0, -1) + nbsp;
   text = text.replace(new RegExp("  ", "g"), " &nbsp;");
  }
  return text;
 },
 CreateItem: function(index, texts, value, imageUrl, selected){
  return new ASPxClientListBoxItem(this, index, texts, value, imageUrl, selected);
 },
 InsertItemInternal: function(index, texts, value, imageUrl){
  if(!texts || texts.length == 0)
   texts = [""];
  else if(typeof(texts) == "string")
   texts = [ texts ];
  if(typeof (value) == "undefined")
   value = texts[0];
  if(!ASPx.IsExists(imageUrl))
   imageUrl = "";
  var newItemRow = this.CreateNewItem();
  ASPx.Attr.RemoveAttribute(newItemRow, "id");
  var listTable = this.GetListTable();
  var tbody = this.GetTableRowParent(listTable);
  var isAdd = listTable.rows.length <= index;
  if(isAdd)
   tbody.appendChild(newItemRow);
  else
   tbody.insertBefore(newItemRow, this.GetItemRow(index));
  var newIndex = this.FindFreeIndex();
  var newId = this.CreateItemId(newIndex);
  var newClientId = this.CreateItemClientId(newIndex);
  this.InitializeItemAttributes(newItemRow, newClientId, true);
  this.AddStateControllerClasses(newId);
  this.PrepareItem(newItemRow, texts, imageUrl); 
  ASPx.Data.ArrayInsert(this.itemsValue, value, index);
  this.RegisterInsertedItem(index, texts, value, imageUrl);
  if(this.GetIsCheckColumnExists() && !this.IsNativeCheckBoxes())
   this.AddInternalCheckBoxToCollection(index);
  this.OnItemInserted(index);
 },
 AddStateControllerClasses: function(itemId){
  var itemCellsIdPostfixes = this.GetItemCellsIdPostfixes();
  var sampleItemFirstTextCell = this.GetSampleItemFirstTextCell();
  var styleController = ASPx.GetStateController();
  var hoverStyleClasses = this.CreateStyleClasses(itemId, itemCellsIdPostfixes, 
      styleController.GetHoverElement(sampleItemFirstTextCell), ASPx.HoverItemKind);
  var selectedStyleClasses = this.CreateStyleClasses(itemId, itemCellsIdPostfixes, 
      styleController.GetSelectedElement(sampleItemFirstTextCell), ASPx.SelectedItemKind);
  var disabledStyleClasses = this.CreateStyleClasses(itemId, itemCellsIdPostfixes, 
      styleController.GetDisabledElement(sampleItemFirstTextCell), ASPx.DisabledItemKind);
    ASPx.AddHoverItems(this.name, hoverStyleClasses, true);
    ASPx.AddSelectedItems(this.name, selectedStyleClasses, true);
    ASPx.AddDisabledItems(this.name, disabledStyleClasses, true);
  ASPx.Attr.RemoveAttribute(sampleItemFirstTextCell, ASPx.CachedStatePrefix + ASPx.HoverItemKind);
  ASPx.Attr.RemoveAttribute(sampleItemFirstTextCell, ASPx.CachedStatePrefix + ASPx.SelectedItemKind);
  ASPx.Attr.RemoveAttribute(sampleItemFirstTextCell, ASPx.CachedStatePrefix + ASPx.DisabledItemKind);
 },
 RemoveStateControllerClasses: function(itemId){
  var itemCellsIdPostfixes = this.GetItemCellsIdPostfixes();
  var classes = [];
  classes[0] = [];
  classes[0][0] = [itemId];
  classes[0][1] = itemCellsIdPostfixes;
    ASPx.RemoveHoverItems(this.name, classes);
    ASPx.RemoveSelectedItems(this.name, classes);
    ASPx.RemoveDisabledItems(this.name, classes);
 },
 PrepareItem: function(newItemRow, texts, imageUrl){ 
  var i = 0;
  if(this.GetIsCheckColumnExists())
   i ++;
  if(this.imageCellExists) {
   this.PrepareItemImage(newItemRow, i, imageUrl);
   i ++;
  }
  var cellCount = this.GetItemCellCount();
  for(var j = 0; i < cellCount; i++, j++)
   this.PrepareItemTextCell(newItemRow.cells[i], texts[j])
 },
 PrepareItemImage: function(newItemRow, imageCellIndex, imageUrl){
  var imageCell = newItemRow.cells[imageCellIndex];
  var image = ASPx.GetNodeByTagName(imageCell, "IMG", 0);
  if(!imageUrl) {
   if(image)
    ASPx.RemoveElement(image);
   imageCell.innerHTML = "&nbsp;";
  } else {
   if(!image) {
    image = document.createElement("IMG");
    imageCell.innerHTML = "";
    imageCell.appendChild(image);
   }
   ASPx.ImageUtils.SetImageSrc(image, imageUrl);
  }
 }, 
 PrepareItemTextCell: function(cell, text){
  if(!ASPx.IsExists(text)) 
   text = "";
  if(this.encodeHtml)
   text = ASPx.Str.EncodeHtml(text);
  cell.innerHTML = this.ProtectWhitespaceSerieses(text);
  if(text == "")
   ASPx.Attr.SetAttribute(cell, "DXText", text);
 },
 ClearListTableContent: function(){
  var tBody = this.GetTableRowParent(this.GetListTable());
  if(ASPx.Browser.IE)
   tBody.innerText = "";
  else
   tBody.innerHTML = "";
 },
 FormatText: function(texts){
  if(typeof(texts) == "string")
   return texts;
  else if(!this.IsMultiColumn())
   return texts[0];
  else
   return this.FormatTextCore(texts);
 },
 FormatTextCore: function(texts){
  if(this.isComboBoxList)
   return ASPx.Formatter.Format(this.textFormatString, texts);
  else
   return texts.join("; ");
 },
 OnItemInserted: function(index){
  this.GetItemSelectionHelper().OnItemInserted(index);
 },
 OnItemRemoved: function(index){
  this.GetItemSelectionHelper().OnItemRemoved(index);
 },
 CreateItemId: function(index){
  return lbIIdSuffix + index;
 },
 CreateItemClientId: function(index){
  return this.name + "_" + lbIIdSuffix + index;
 },
 CreateNewItem: function(){
  var newItemRow = this.GetSampleItemRow();
  if(ASPx.IsExistsElement(newItemRow)) 
   newItemRow = newItemRow.cloneNode(true);
  return newItemRow;
 },
 CreateStyleClasses: function(id, postfixes, item, kind){
  var classes = [];
  if(item && item[kind]){
   classes[0] = [];
   classes[0][0] = item[kind].classNames;
   classes[0][1] = item[kind].cssTexts;
   classes[0][2] = [];
   classes[0][2][0] = id;
   classes[0][3] = postfixes;
  }
  return classes;
 },
 CorrectSizeByTimer: function(){
  if(this.APILockCount == 0 && this.IsDisplayed())
   window.setTimeout(function() { this.OnCorrectSizeByTimer(); }.aspxBind(this), 0);
 },
 FindFreeIndex: function(){
  return this.freeUniqIndex ++;
 },
 GetSampleItemRowID: function(){
  return this.name + "_" + lbSIIdSuffix;
 },
 GetAccessibilitySampleHeaderRowID: function() {
  return this.name + "_" + lbAIRTIdSuffix;
 },
 GetSampleItemRow: function(){
  if(this.SampleItem == null)
   this.SampleItem = ASPx.GetElementById(this.GetSampleItemRowID());
  return this.SampleItem;
 },
 GetAccessibilitySampleHeaderRow: function() {
  if(this.sampleHeaderRow == null)
   this.sampleHeaderRow = ASPx.GetElementById(this.GetAccessibilitySampleHeaderRowID());
  return this.sampleHeaderRow;
 },
 AddAccessibilityHeaderRow: function() {
  if(!this.accessibilityCompliant || !this.IsMultiColumn()) return;
  var listTableBody = ASPx.GetChildByTagName(this.GetListTable(), "TBODY", 0);
  var headerRow = this.GetAccessibilitySampleHeaderRow().cloneNode(true);
  headerRow.id = this.GetAccessibilityHeaderRowID();
  listTableBody.appendChild(headerRow);
 },
 GetAccessibilityHeaderRow: function() {
  return this.GetChildElement(lbAIRIdSuffix);
 },
 RemoveAccessibilityHeaderRow: function() {
  var headerRow = this.GetAccessibilityHeaderRow();
  if(headerRow)
   ASPx.RemoveElement(headerRow);
 },
 GetAccessibilityHeaderRowID: function() {
  return this.name + "_" + lbAIRIdSuffix;
 },
 GetSampleItemFirstTextCell: function(){
  if(!ASPx.IsExistsElement(this.sampleItemFirstTextCell)){
   var sampleItemRow = this.GetSampleItemRow();
   if(ASPx.IsExistsElement(sampleItemRow))
    this.sampleItemFirstTextCell = sampleItemRow.cells[this.imageCellExists ? 1 : 0];
  }
  return this.sampleItemFirstTextCell;
 },
 ChangeEnabledAttributes: function(enabled){
  this.ChangeListTableEvents(this.GetListTable(), ASPx.Attr.ChangeEventsMethod(enabled));
  var focusableElement = this.GetInputElement();
  if(focusableElement) {
   this.ChangeSpecialInputEnabledAttributes(focusableElement, ASPx.Attr.ChangeEventsMethod(enabled));
   if(this.accessibilityCompliant && !this.isComboBoxList)
    enabled ? ASPx.Attr.SetAttribute(focusableElement, "tabindex", "0") : focusableElement.removeAttribute("tabindex");
  }
 },
 ChangeEnabledStateItems: function(enabled){
  var controller = ASPx.GetStateController();
  controller.SetElementEnabled(this.GetMainElement(), enabled);
  var count = this.GetItemCount();
  var i = this.hasSampleItem ? -1 : 0 ;
  var checkColumnExists = this.GetIsCheckColumnExists();
  for(; i < count; i ++){
   var element = this.GetItemFirstTextCell(i);
   if(element)
    controller.SetElementEnabled(element, enabled);
   if(checkColumnExists && i >= 0)
    this.SetCheckBoxEnabled(i, enabled);
  }
 },
 ChangeListTableEvents: function(listTable, method){
  if(this.isComboBoxList){
   method(listTable, "mouseup", aspxLBIClick);
   if(ASPx.Browser.Firefox)
    method(listTable, "mousedown", ASPx.Evt.PreventEvent); 
  }
  else{
   method(listTable, "click", aspxLBIClick);   
   method(listTable, "dblclick", aspxLBIClick); 
   if(this.MultiSelectionMode())
    ASPx.Evt.AttachEventToElement(listTable, "selectstart", aspxLBTSelectStart);
  }
 },
 IsValueChanged: function(){
  return this.cachedValue != this.GetValue();
 },
 OnItemSelectionChanged: function(index, selected){
  if(this.CheckColumnSelectionMode())
   this.SetCheckBoxChecked(index, selected);
  if(!this.IsSelectionEventsLocked()) {
   this.SetRaiseSelectedIndexChangedArguments(this.autoPostBack, index, selected);
   var valueChanged = this.IsValueChanged();
   if(valueChanged) {
    this.RaisePersonalStandardValidation();
    this.OnValueChanged();
   } else {
    if(this.RaiseSelectedIndexChanged())
     this.SendPostBackInternal("");
   }
  }
  this.CacheValue();
  if(this.accessibilityHelper)
   this.accessibilityHelper.OnSelectedIndexChanged(index);
 },
 SetRaiseSelectedIndexChangedArguments: function(processOnServer, index, selected){
  this.selectedIndexChangedArguments = {
   processOnServer: processOnServer,
   index: index,
   selected: selected
  };
 },
 GetRaiseSelectedIndexChangedArguments: function(){
  if(!this.selectedIndexChangedArguments)
   this.SetRaiseSelectedIndexChangedArguments(false, this.GetSelectedIndex(), true);
  return this.selectedIndexChangedArguments;
 },
 RaiseSelectedIndexChanged: function (processOnServer) {
  this.RaiseValidationInternal();
  var savedArgs = this.GetRaiseSelectedIndexChangedArguments();
  processOnServer = savedArgs.processOnServer || processOnServer;
  if(!this.SelectedIndexChanged.IsEmpty()){
   var args = new ASPxClientListEditItemSelectedChangedEventArgs(savedArgs.index, savedArgs.selected, processOnServer);
   this.SelectedIndexChanged.FireEvent(this, args);
   processOnServer = args.processOnServer;
  }
  return processOnServer;
 },
 SetWidth: function(width) {
  this.width = width + "px";
   this.GetScrollDivElement().style.width = "100%";
   this.constructor.prototype.SetWidth.call(this, width);
 },
 SetHeight: function(height) {
  this.heightCorrected = false;
  this.constructor.prototype.SetHeight.call(this, height);
 },
 GetAccessibilityServiceElement: function() {
  return this.GetChildElement(accessibilityAssistID);
 },
 OnAssociatedLabelClick: function(evt) {
  ASPxClientListBoxBase.prototype.OnDelayedSpecialFocusMouseDown.call(this, evt);
 }
});
var ASPxClientNativeListBox = ASPx.CreateClass(ASPxClientListBoxBase, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
 },
 InitializeEvents: function() {
  ASPxClientListBoxBase.prototype.InitializeEvents.call(this);
  if(!!this.GetMainElement()) {
   ASPx.Evt.AttachEventToElement(this.GetMainElement(), "keydown", this.OnKeyDown.aspxBind(this));
   ASPx.Evt.AttachEventToElement(this.GetMainElement(), "keyup", this.OnKeyUp.aspxBind(this));
   ASPx.Evt.AttachEventToElement(this.GetMainElement(), "keypress", this.OnKeyPress.aspxBind(this));
  }
 },
 SetMainElement: function(mainElement){
  this.mainElement = mainElement;
 },
 FindInputElement: function(){
  return this.GetMainElement();
 }, 
 GetOptionCount: function(){
  return this.GetMainElement().options.length;
 },
 GetOption: function(index){
  return this.GetMainElement().options[index];
 },
 GetItemCount: function(){
  return this.GetOptionCount();
 },
 SelectIndexSilent: function(index){
  var selectedIndex = this.GetSelectedIndexInternal();
  var isValidIndex = (-1 <= index && index < this.GetItemCount());
  if((selectedIndex != index && isValidIndex) || !this.isInitialized){
   this.SetSelectedIndexInternal(index);
   return true;
  }
  return false;
 },
 GetSelectedIndexInternal: function(){
  return this.GetMainElement().selectedIndex; 
 },
 SetSelectedIndexInternal: function(index){
  this.GetMainElement().selectedIndex = index; 
 },
 ClearItemsCore: function(){
  this.GetMainElement().innerHTML = "";
 },
 RemoveItem: function(index){
  if(0 <= index && index < this.GetItemCount()){
   var oldSelectedIndex = this.GetSelectedIndexInternal();
   this.UpdateSyncArraysItemDeleted(this.GetItem(index), true);
   var option = this.GetOption(index);
   this.GetMainElement().removeChild(option);
   this.UpdateOptionValues();
   this.OnItemRemoved(oldSelectedIndex, index);
  }
 },
 OnItemRemoved: function(oldSelectedIndex, newSelectedIndex){
  if(newSelectedIndex == oldSelectedIndex && !this.MultiSelectionMode())
   this.SetSelectedIndexInternal(-1);
 },
 MultiSelectionMode: function(){
  return this.GetMainElement().multiple;
 },
 GetItem: function(index){
  if(0 <= index && index < this.GetOptionCount()) {
   var text = this.GetOption(index).text;
   var selected = this.GetMainElement().options[index].selected
   if(ASPx.IsExists(text))
    return new ASPxClientListBoxItem(this, index, text, this.itemsValue[index], "", selected);
  }
  return null;
 },
 PerformCallback: function(arg) {
  this.ClearItemsForPerformCallback();
  this.FormatAndSetCustomCallbackArg(arg);
  this.SendCallback();
 },
 SendCallback: function(){
  if(!this.InCallback()){
   var callbackOwner = this.GetCallbackOwnerControl();
   if(callbackOwner != null)
    callbackOwner.SendCallback();
    else {
    var argument = this.GetCallbackArguments();
    this.CreateCallback(argument);
   }
  }
 },
 ParseCallbackResult: function(result){
  var deserializedItems = this.DeserializeItems(result);
  this.LoadItemsFromCallback(true, deserializedItems);
 },
 InsertItemInternal: function(index, text, value, imageUrl) {
  if(typeof (value) == "undefined")
   value = text;
  var oldSelectedIndex = this.GetSelectedIndexInternal();
  var isAdd = this.GetOptionCount() <= index;
  var newOption = document.createElement("OPTION");
  if(isAdd)
   this.GetMainElement().appendChild(newOption);
  else
   this.GetMainElement().insertBefore(newOption, this.GetOption(index));
  newOption.innerHTML = text;
  this.UpdateOptionValues();
  ASPx.Data.ArrayInsert(this.itemsValue, value, index);
  this.RegisterInsertedItem(index, text, value, imageUrl); 
  if(index == oldSelectedIndex && index != -1)
   this.SetSelectedIndex(index + 1);
 },
 UpdateOptionValues: function() {
  if(this.APILockCount == 0){
   for(var i = 0; i < this.GetOptionCount(); i++)
    this.GetOption(i).value = i;
  }
 },
 ChangeEnabledAttributes: function(enabled){
  if(!this.isComboBoxList)
   this.GetMainElement().disabled = !enabled;
 },
 OnCallback: function(result) {
  this.ParseCallbackResult(result);
 },
 OnItemDblClick: function(){
  this.RaiseItemDoubleClick();
 },
 LoadItemsFromCallback: function(isToTop, deserializedItems){
  this.BeginUpdate();
  this.LockSynchronizationOnInternalCallback();
  var mainElement = this.GetMainElement();
  for(var i = deserializedItems.length - 1; i >= 0; i--) {
   this.InsertItemInternal(0, deserializedItems[i].text, deserializedItems[i].value, deserializedItems[i].imageUrl);
   if(deserializedItems[i].selected) {
    var index = deserializedItems[i].index;
    mainElement.options[0].selected = true;
   }
  }
  this.UnlockSynchronizationOnInternalCallback();
  this.EndUpdate();
 },
 EndUpdate: function(){
  ASPxClientListBoxBase.prototype.EndUpdate.call(this);
  this.UpdateOptionValues();
 },
 GetSelectedIndices: function(){
  var selectedIndices = [];
  var mainElement = this.GetMainElement();
  for(var i = 0; i < mainElement.options.length; i++){
   if(mainElement.options[i].selected)
    selectedIndices.push(i);
  }
  return selectedIndices;
 },
 GetSelectedValues: function(){ 
  var selectedValues = [];
  var selectedIndices = this.GetSelectedIndices();
  for(var i = 0; i < selectedIndices.length; i++)
   selectedValues.push(this.GetItemValue(selectedIndices[i]));
  return selectedValues;
 },
 GetSelectedItems: function(){
  var selectedItems = [];
  var selectedIndices = this.GetSelectedIndices();
  for(var i = 0; i < selectedIndices.length; i++)
   selectedItems.push(this.GetItem(selectedIndices[i]));
  return selectedItems;
 },
 SelectAll: function(){
  this.SetAllItemsSelectedValue(true);
 },
 UnselectAll: function(){
  this.SetAllItemsSelectedValue(false);
 },
 SetAllItemsSelectedValue: function(selected){
  var mainElement = this.GetMainElement();
  for(var i = 0; i < mainElement.options.length; i++)
   mainElement.options[i].selected = selected;
 },
 SelectIndices: function(indices){
  this.SetIndicesSelectionState(indices, true);
 },
 UnselectIndices: function(indices){
  this.SetIndicesSelectionState(indices, false);
 },
 SetIndicesSelectionState: function(indices, selected){
  var mainElement = this.GetMainElement();
  for(var i = 0; i < indices.length; i++){
   mainElement.options[indices[i]].selected = selected;
  }
 },
 SelectItems: function(items){
  if(ASPx.IsExists(items))
   this.SetItemsSelectionState(items, true);
  else
   this.SelectAll();
 },
 UnselectItems: function(items){
  if(ASPx.IsExists(items))
   this.SetItemsSelectionState(items, false);
  else
   this.UnselectAll();
 },
 SetItemsSelectionState: function(items, selected){
  var mainElement = this.GetMainElement();
  for(var i = 0; i < items.length; i++){
   mainElement.options[items[i].index].selected = selected;
  }
 },
 SelectValues: function(values){
  this.SetValuesSelectedState(values, true);
 },
 UnselectValues: function(values){
  this.SetValuesSelectedState(values, false);
 },
 SetValuesSelectedState: function(values, selected){
  var mainElement = this.GetMainElement();
  var index;
  for(var i = 0; i < values.length; i++){
   index = this.FindItemIndexByValue(values[i]);
   mainElement.options[index].selected = selected;
  }
 }
});
var AccessibilityHelperListBox = ASPx.CreateClass(ASPx.AccessibilityHelperBase, {
 constructor: function(listBox) {
  this.constructor.prototype.constructor.call(this, listBox);
  this.checkBoxRefocusTimeout = 1000;
  this.firstReadingColumnIndex = this.control.CheckColumnSelectionMode() ? 1 : 0;
  this.Initialize();
 },
 Initialize: function() {
  this.initializeLabelElement();
  if(this.control.CheckColumnSelectionMode() && !this.control.IsNativeCheckBoxes())
   this.control.GotFocus.AddHandler(function() { this.SetCheckBoxFocus(); }.aspxBind(this));
  this.OnSelectedIndexChanged(this.control.GetSelectedIndex());
 },
 initializeLabelElement: function() {
  var captionCell = this.control.GetCaptionCell();
  if(!captionCell) return;
  this.changeActivityAttributes(this.getMainElement(), { "aria-labelledby": captionCell.id });
  var captionSpan = captionCell.childNodes[0];
  ASPx.Evt.AttachEventToElement(captionSpan, ASPx.TouchUIHelper.touchMouseDownEventName, function(evt) {
   this.OnDelayedSpecialFocusMouseDown(evt);
  }.aspxBind(this.control));
 },
 OnSelectedIndexChanged: function(index) {
  var stateSelected = index != -1 && this.control.GetItem(index).selected;
  var selectedIndex = this.control.GetSelectedIndex();
  if(this.control.CheckColumnSelectionMode() || stateSelected || selectedIndex == -1)
   this.setSelectionAttributes(index, stateSelected);
 },
 getPronounceTimeout: function() {
  if(ASPx.Browser.WebKitFamily && this.control.CheckColumnSelectionMode())
   return 1000;
  return ASPx.AccessibilityHelperBase.prototype.getPronounceTimeout.call(this);
 },
 getHeaderCellCaptionText: function(index) {
  var headerDiv = this.control.GetHeaderDivElement();
  if(!headerDiv) return "";
  var headerTable = headerDiv.firstElementChild;
  return headerTable.rows[0].cells[this.firstReadingColumnIndex + index].textContent;
 },
 SetCheckBoxFocus: function() {
  var isCheckBoxFocused = false;
  for(var i = 0; i < this.control.GetItemCount(); i++)
   if(this.control.GetInternalCheckBox(i).focused) {
    isCheckBoxFocused = true;
    break;
   }
  if(!isCheckBoxFocused)
   setTimeout(function() {
    if(!this.control.focused) return;
    this.control.SetFocusedIndex(0);
   }.aspxBind(this), this.checkBoxRefocusTimeout);
 },
 setSelectionAttributes: function(index, stateSelected) {
  if(index == -1) index = 0;
  var item = this.control.GetItem(index);
  if(!item) return;
  var assistText = "";
  if(!this.control.IsMultiColumn()) {
   assistText = item.text;
  } else {
   var columnsCount = this.control.columnFieldNames.length;
   var formatString = ASPx.AccessibilitySR.TableItemFormatString; 
   for(var i = 0; i < columnsCount; i++)
    assistText += ASPx.Str.ApplyReplacement(formatString, [["{0}", this.getHeaderCellCaptionText(i)], ["{1}", item.texts[i]]]);
  }
  var activeItemArgs = {
   "role"    : "option",
   "aria-posinset" : index + 1,
   "aria-setsize"  : this.control.itemTotalCount,
   "aria-selected" : stateSelected
  };
  var inactiveItemArgs = {
   "role"    : "",
   "aria-posinset" : "",
   "aria-setsize"  : "",
   "aria-selected" : ""
  };
  this.PronounceMessage(assistText, activeItemArgs, inactiveItemArgs);
 }
});
ASPxClientListBox.Cast = ASPxClientControl.Cast;
var ASPxClientCheckListBase = ASPx.CreateClass(ASPxClientListEdit, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);          
  this.imageProperties = null;
  this.internalButtonCollection = null; 
  this.icbFocusedStyle = [];
  this.items = [];
 },
 Initialize: function() {
  ASPxClientListEdit.prototype.Initialize.call(this);
  this.UpdateInternalSelectedIndex(); 
 },
 UpdateInternalSelectedIndex: function() {
  var selectedIndexFromServer = this.GetSelectedIndex();
  if(ASPx.Browser.IE) {
   var stateInput = this.FindStateInputElement();
   if(stateInput) {
    var restoredSelectedIndex = stateInput.value;
    if(restoredSelectedIndex != '' && restoredSelectedIndex != selectedIndexFromServer)
     this.SetSelectedIndex(restoredSelectedIndex);
   }
  }
 },
 CreateButtonInternalCollection: function() { 
  this.internalButtonCollection = new ASPx.CheckBoxInternalCollection(this.imageProperties, false, true, ASPx.CheckEditElementHelper.Instance, undefined,
   this.accessibilityCompliant);
  var instance = this;
  for(var i = 0; i < this.GetItemCount(); i++) {
   var icbInputElement = this.GetItemInput(i);
   var internalButton = this.internalButtonCollection.Add(icbInputElement.id, icbInputElement, this.GetItemElement(i));
   internalButton.CreateFocusDecoration(this.icbFocusedStyle);
   internalButton.SetEnabled(this.GetEnabled());
   internalButton.readOnly = this.readOnly;
   internalButton.CheckedChanged.AddHandler(function(s, e) { instance.OnItemClick(instance.GetItemIndexByElement(ASPx.Evt.GetEventSource(e))); });
   internalButton.Focus.AddHandler(function(s, e) { instance.OnFocus(); });
   internalButton.LostFocus.AddHandler(function(s, e) { instance.OnLostFocus(); });
   this.attachToCellsClick(i);
   this.PrepareInternalButton(internalButton, i);
  }
  this.attachToMainElementMouseDown();
 },
 CheckableElementsExist: function() {
  return !!this.imageProperties;
 },
 SetEnabled: function(enabled){
  ASPxClientListEdit.prototype.SetEnabled.call(this, enabled);
  var stateInput = this.FindStateInputElement();
  if(enabled)
   ASPx.Attr.RemoveAttribute(stateInput, "disabled");
  else
   ASPx.Attr.SetAttribute(stateInput, "disabled", "disabled");
 },
 SetFocus: function() {
  this.UpdateFocus(); 
 },
 UpdateFocus: function() {
 },
 IsElementBelongToInputElement: function(element) {
  return this.GetItemIndexByElement(element) != -1;
 },
 attachToCellsClick: function(index) {
  var element = this.GetItemElement(index);
  ASPx.Evt.AttachEventToElement(element, "click", function(evt) {
   var src = ASPx.Evt.GetEventSource(evt);
   var label = ASPx.CheckEditElementHelper.Instance.GetLabelElement(element);
   var button = this.internalButtonCollection.Get(this.GetItemInput(index).id);
   if(!ASPx.GetIsParent(button.mainElement, src) && src !== label && src.parentElement !== label) {
    ASPx.CheckEditElementHelper.Instance.InvokeClick(button, evt);
   }
  }.aspxBind(this));
 },
 attachToMainElementMouseDown: function() {
  var mainElement = this.GetMainElement();
  ASPx.Evt.AttachEventToElement(mainElement, "mousedown", function() { 
   if(this.enabled && !this.readOnly)
    this.LockFocusEvents();
  }.aspxBind(this));
 },
 GetItemIndexByElement: function(element) {
  for(var i = 0; i < this.GetItemCount(); i++) {
   var itemElement = this.GetItemElement(i);
   if(ASPx.GetIsParent(itemElement, element))
    return i;
  }
  return -1;  
 },
 GetItemInput: function(index) {
  return this.GetChildElement("RB" + index + "_I");
 },
 GetItemElement: function(index) {
  return this.GetChildElement("RB" + index);
 },
 GetItemFocusableElement: function(index) {
  return this.accessibilityCompliant ? this.GetChildElement("RB" + index + "_I_D") : this.GetItemInput(index);
 },
 GetItemCount: function() {
  return this.items.length;
 },
 OnItemClick: function(index) {
 },
 OnItemClickReadonly: function() {
  var index = this.GetSelectedIndexInternal();
  this.SelectIndexSilent(index);
 },
 UpdateHiddenInputs: function(index) {
  var stateInput = this.FindStateInputElement();
  if(ASPx.IsExistsElement(stateInput))
   stateInput.value = index;
  var valueInput = this.GetValueInputElement();
  if(ASPx.IsExistsElement(valueInput)) {
   var value = this.GetValue();
   valueInput.value = ASPx.IsExists(value) ? value : " ";
  }
 },
 GetItemValue: function(index){
  if(index > -1 && index < this.items.length) {
   if(typeof(this.items[index].value) == "string" && this.items[index].value == "" && this.convertEmptyStringToNull)
    return null;
   else
    return this.items[index].value;
  }
  return null;
 },
 SetValue: function(value) {
  for(var i = 0; i < this.items.length; i++) {
   if(this.GetItemValue(i) == value) {   
    this.SelectIndexSilent(i);
    return;
   }
  } 
  this.SelectIndexSilent(-1);    
 },
 CreateItems: function(itemsProperties){
  for(var i = 0; i < itemsProperties.length; i++)
   this.CreateItem(i, itemsProperties[i][0], this.GetDecodeValue(itemsProperties[i][1]), itemsProperties[i][2]);
 },
 CreateItem: function(index, text, value, imageUrl){
  var item = new ASPxClientListEditItem(this, index, text, value, imageUrl);
  this.items.push(item);
 },
 GetItem: function(index){
  return (0 <= index && index < this.items.length) ? this.items[index] : null;
 },
 ChangeEnabledAttributes: function(enabled){
  if(!this.CheckableElementsExist()) {
   for(var i = 0; i < this.GetItemCount(); i++){
    var element = this.GetItemInput(i);
    if(element){
     this.ChangeItemEnabledAttributes(element, ASPx.Attr.ChangeAttributesMethod(enabled));
     element.disabled = !enabled;
    }
   }
  } else {
   var selectedIndex = this.GetSelectedIndexInternal();
   this.UpdateCheckableElementDecorations(selectedIndex, enabled);
  }
 },
 ChangeEnabledStateItems: function(enabled){
  ASPx.GetStateController().SetElementEnabled(this.GetMainElement(), enabled);
  if(this.isNative){
   for(var i = 0; i < this.GetItemCount(); i++){
    var element = this.GetItemInput(i);
    if(element)
     ASPx.GetStateController().SetElementEnabled(element, enabled);
   }
  }
 },
 ChangeItemEnabledAttributes: function(element, method){
  method(element, "onclick");
 }
});
var ASPxClientRadioButtonList = ASPx.CreateClass(ASPxClientCheckListBase, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);          
 },
 InlineInitialize: function() {
  var selectedIndex = this.GetSelectedIndex();
  this.UpdateHiddenInputs(selectedIndex);
  if(this.CheckableElementsExist()) 
   this.CreateButtonInternalCollection();
  this.SetSelectedIndex(this.GetSelectedIndex()); 
  ASPxClientCheckListBase.prototype.InlineInitialize.call(this);
 },
 Initialize: function() {
  ASPxClientCheckListBase.prototype.Initialize.call(this);
 },
 PrepareInternalButton: function(internalRadioButton){
  internalRadioButton.autoSwitchEnabled = false;
 },
 GetInputElement: function() {
  if(this.isNative) {
   var index = this.GetSelectedIndexInternal();
   return this.GetItemInput(index);
  } else 
   return this.GetValueInputElement();
 },
 GetValueInputElement: function() {
  if(this.valueInput == null) {
   var stateInput = this.FindStateInputElement();
   this.valueInput = this.GetHiddenField(null, this.name + "_ValueInput", stateInput.parentNode, stateInput);
  }
  return this.valueInput;
 },
 GetValueInputToValidate: function() {
  return this.GetValueInputElement();
 },
 SelectIndexSilent: function(index) {
  var itemCount = this.GetItemCount();
  var isValidIndex = (-1 <= index && index < itemCount);
  if(isValidIndex) {
   if(this.CheckableElementsExist()) 
    this.UpdateCheckableElementDecorations(index, this.GetEnabled());
   else {
    for(var i = 0; i < itemCount; i++) {
     var element = this.GetItemInput(i);
     if(element)
      element.checked = (i == index);
    }
   }
   this.SetSelectedIndexInternal(index);
   this.UpdateHiddenInputs(index);
  }
 },
 UpdateCheckableElementDecorations: function(selectedIndex, enabled) {
  if(this.CheckableElementsExist()) {
   for(var i = 0; i < this.items.length; i++) {
    var inputElement = this.GetItemInput(i);
    var internalButton = this.internalButtonCollection.Get(inputElement.id);
    internalButton.SetEnabled(enabled);
    internalButton.SetValue(i == selectedIndex ? ASPx.CheckBoxInputKey.Checked : ASPx.CheckBoxInputKey.Unchecked);
   }
  }
 },
 UpdateFocus: function() {
  var index = this.GetSelectedIndexInternal();
  if(index == -1)
   index = 0;
  var itemElement = this.GetItemFocusableElement(index);
  if(itemElement != null && ASPx.GetActiveElement() != itemElement && ASPx.IsEditorFocusable(itemElement)) 
   ASPx.SetFocus(itemElement);
 },
 OnItemClick: function(index) {
  if(this.GetSelectedIndexInternal() != index) {
   this.SelectIndexSilent(index);
   this.RaisePersonalStandardValidation();
   this.OnValueChanged();
  }
  this.UpdateFocus();
 },
 RequireInputElementToValidate: function() {
  return false;
 }
});
ASPxClientRadioButtonList.Cast = ASPxClientControl.Cast;
var ASPxClientCheckBoxList = ASPx.CreateClass(ASPxClientCheckListBase, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);          
  this.selectionEventsLockCount = 0;
 },
 InlineInitialize: function() {
  if(this.CheckableElementsExist()) 
   this.CreateButtonInternalCollection();
  ASPxClientCheckListBase.prototype.InlineInitialize.call(this);
 },
 Initialize: function() {
  ASPxClientCheckListBase.prototype.Initialize.call(this);
  this.InitSelection();
 },
 InitSelection: function() {
  this.SelectIndices(this.initSelectedIndices);
  this.CacheValue();
 },
 PrepareInternalButton: function(internalCheckBox, index){
  internalCheckBox.autoSwitchEnabled = true;
  internalCheckBox.SetChecked(this.GetItemSelectionHelper().GetIsItemSelected(index));
 },
 SelectIndexSilent: function(index) {
  var itemCount = this.GetItemCount();
  var isValidIndex = (-1 <= index && index < itemCount);
  if(isValidIndex) {
   this.UpdateHiddenInputs(index);
  }
 },
 UpdateCheckableElementDecorations: function(selectedIndex, enabled) {
  if(this.CheckableElementsExist()) {
   for(var i = 0; i < this.items.length; i++) {
    var inputElement = this.GetItemInput(i);
    var internalButton = this.internalButtonCollection.Get(inputElement.id);
    internalButton.SetEnabled(enabled);
   }
  }
 },
 SetSelectionDecoration: function(index, selected){ 
  if(this.CheckableElementsExist()){
   var inputElement = this.GetItemInput(index);
   var internalButton = this.internalButtonCollection.Get(inputElement.id);
   internalButton.SetValue(selected ? ASPx.CheckBoxInputKey.Checked : ASPx.CheckBoxInputKey.Unchecked);
  } else {
   var element = this.GetItemInput(index);
   if(element)
    element.checked = (selected); 
  }
 },
 OnItemClick: function(index) {
  this.GetItemSelectionHelper().OnItemClick(index);
 },
 UpdateFocus: function() {
  var index = this.GetItemSelectionHelper().GetFocusedItemIndex();
  if(index == -1)
   index = this.GetSelectedIndexInternal();
  if(index == -1)
   index = 0;
  var itemElement = this.GetItemFocusableElement(index);
  if(itemElement != null && ASPx.GetActiveElement() != itemElement && ASPx.IsEditorFocusable(itemElement)) 
   ASPx.SetFocus(itemElement);
 },
 UpdateInternalState: function(){
  this.UpdateHiddenInputs();
 },
 IsUpdateHiddenInputsLocked: function(){
  return this.GetItemSelectionHelper().IsUpdateInternalSelectionStateLocked();
 },
 UpdateHiddenInputs: function(){
  if(this.IsUpdateHiddenInputsLocked()) 
   return;
  var element = this.FindStateInputElement();
  if(ASPx.IsExistsElement(element)) { 
   var sb = [ ];
   var serialiser = this.GetSerializingHelper();
   var selectedIndices = this.GetSelectedIndices();
   for(var i = 0; i < selectedIndices.length; i++)
    serialiser.SerializeAtomValue(sb, selectedIndices[i]);
   element.value = sb.join("");
  }
 },
 GetSerializingHelper: function(){ 
  if(this.serializingHelper == null)
   this.serializingHelper = new ListBoxBaseItemsSerializingHelper(this);
  return this.serializingHelper;
 },
 SetItemSelectionAppearance: function(index, selected, controller){
 },
 LockSelectionEvents: function(){
  this.selectionEventsLockCount++;
 },
 UnlockSelectionEvents: function(){
  this.selectionEventsLockCount--;
 },
 IsSelectionEventsLocked: function(){
  return this.selectionEventsLockCount > 0;
 },
 CacheValue: function(){
  this.cachedValue = this.GetValue();
 },
 IsValueChanged: function(){
  return this.cachedValue != this.GetValue();
 },
 OnItemSelectionChanged: function(index, selected){
  this.SetSelectionDecoration(index, selected);
  if(!this.IsSelectionEventsLocked()) {
   this.SetRaiseSelectedIndexChangedArguments(this.autoPostBack, index, selected);
   var valueChanged = this.IsValueChanged();
   if(valueChanged) {
    this.RaisePersonalStandardValidation();
    this.OnValueChanged();
   } else {
    if(this.RaiseSelectedIndexChanged())
     this.SendPostBackInternal("");
   }
  }
  this.CacheValue();
 },
 SetRaiseSelectedIndexChangedArguments: function(processOnServer, index, selected){
  this.selectedIndexChangedArguments = {
   processOnServer: processOnServer,
   index: index,
   selected: selected
  };
 },
 GetRaiseSelectedIndexChangedArguments: function(){
  if(!this.selectedIndexChangedArguments)
   this.SetRaiseSelectedIndexChangedArguments(false, this.GetSelectedIndex(), true);
  return this.selectedIndexChangedArguments;
 },
 RaiseSelectedIndexChanged: function (processOnServer) {
  this.RaiseValidationInternal();
  var savedArgs = this.GetRaiseSelectedIndexChangedArguments();
  processOnServer = savedArgs.processOnServer || processOnServer;
  if(!this.SelectedIndexChanged.IsEmpty()){
   var args = new ASPxClientListEditItemSelectedChangedEventArgs(savedArgs.index, savedArgs.selected, processOnServer);
   this.SelectedIndexChanged.FireEvent(this, args);
   processOnServer = args.processOnServer;
  }
  return processOnServer;
 },
 GetItemSelectionHelper: function(){
  if(!this.itemSelectionHelper)
   this.itemSelectionHelper = this.CreateItemSelectionHelper();
  return this.itemSelectionHelper;
 },
 CreateItemSelectionHelper: function(){
  return new CheckBoxListMultiSelectionHelper(this);
 },
 GetItem: function(index){
  var item = ASPxClientCheckListBase.prototype.GetItem.call(this, index);
  item.selected = this.GetItemSelectionHelper().GetIsItemSelected(index);
  return item;
 },
 SetValue: function(value){
  var index = this.FindItemIndexByValue(value);
  this.SetSelectedIndex(index);
 },
 GetSelectedIndexInternal: function(){
  if(!this.isInitialized)
   return ASPxClientCheckListBase.prototype.GetSelectedIndexInternal.call(this);
  return this.GetItemSelectionHelper().GetSelectedIndex();
 },
 SetSelectedIndex: function(index){
  this.LockSelectionEvents();
  this.GetItemSelectionHelper().SetSelectedIndex(index);
  this.UnlockSelectionEvents();
 },
 GetSelectedIndices: function(){
  return this.GetItemSelectionHelper().GetSelectedIndices();
 },
 GetSelectedValues: function(){ 
  return this.GetItemSelectionHelper().GetSelectedValues();
 },
 GetSelectedItems: function(){
  return this.GetItemSelectionHelper().GetSelectedItems();
 },
 SelectAll: function(){
  this.SelectIndices();
 },
 UnselectAll: function(){
  this.UnselectIndices();
 },
 SelectIndices: function(indices){
  this.LockSelectionEvents();
  this.GetItemSelectionHelper().SelectIndices(indices);
  this.UnlockSelectionEvents();
 },
 SelectItems: function(items){
  this.LockSelectionEvents();
  this.GetItemSelectionHelper().SelectItems(items);
  this.UnlockSelectionEvents();
 },
 SelectValues: function(values){
  this.LockSelectionEvents();
  this.GetItemSelectionHelper().SelectValues(values);
  this.UnlockSelectionEvents();
 },
 UnselectIndices: function(indices){
  this.LockSelectionEvents();
  this.GetItemSelectionHelper().UnselectIndices(indices);
  this.UnlockSelectionEvents();
 },
 UnselectItems: function(items){
  this.LockSelectionEvents();
  this.GetItemSelectionHelper().UnselectItems(items);
  this.UnlockSelectionEvents();
 },
 UnselectValues: function(values){
  this.LockSelectionEvents();
  this.GetItemSelectionHelper().UnselectValues(values);
  this.UnlockSelectionEvents();
 }
});
ASPxClientCheckBoxList.Cast = ASPxClientControl.Cast;
var ASPxClientListEditItemSelectedChangedEventArgs = ASPx.CreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(index, isSelected, processOnServer){
  this.constructor.prototype.constructor.call(this, processOnServer);
  this.index = index;
  this.isSelected = isSelected;
 }
});
function aspxLBTSelectStart(evt){
 var element = ASPx.Evt.GetEventSource(evt);
 var shiftPressed = evt.shiftKey;
 var ctrlKey = evt.ctrlKey || evt.metaKey;
 if(shiftPressed || ctrlKey){
  ASPx.Selection.Clear();
  ASPx.Evt.PreventEventAndBubble(evt);
 }
}
function aspxLBIClick(evt){
 if(ASPx.TouchUIHelper.isMouseEventFromScrolling) return;
 var element = ASPx.Evt.GetEventSource(evt);
 while(element != null && element.tagName != "BODY"){
  if(element.tagName == "TR"){
   var table = element.offsetParent;
   if(table && table.ListBoxId){
    var lb = ASPx.GetControlCollection().Get(table.ListBoxId);
    if(lb != null) {
     var retValue;
     if(evt.type == "dblclick") 
      retValue =lb.OnItemDblClick();
     else if(!lb.isComboBoxList || ASPx.Evt.IsLeftButtonPressed(evt)) 
      retValue = lb.OnItemClick(element.rowIndex, evt);
     if(typeof(retValue) != "undefined")
      return retValue;
    }
    break;
   }
  }
  element = element.parentNode;
 }
}
function aspxLBScroll(evt){
 var sourceId = ASPx.Evt.GetEventSource(evt).id;
 if(sourceId.slice(-lbDSuffix.length) == lbDSuffix){
  var name = sourceId.slice(0, -2);
  var lb = ASPx.GetControlCollection().Get(name);
  if(lb != null && lb.isInitialized) 
   lb.OnScroll();
 }
}
ASPx.NLBIDClick = function(evt) {
 var element = ASPx.Evt.GetEventSource(evt);
 if(element != null && element.tagName == "SELECT"){
  var lb = ASPx.GetControlCollection().Get(element.id);
  if(lb != null)
   lb.OnItemDblClick();
 }
}
ASPx.ERBLIClick = function(name, index) {
 var list = ASPx.GetControlCollection().Get(name);
 if(list != null)
  list.OnItemClick(index);
}
ASPx.ERBLICancel = function(name) {
 var list = ASPx.GetControlCollection().Get(name);
 if(list != null)
  list.OnItemClickReadonly();
}
window.ASPxClientListEdit = ASPxClientListEdit;
window.ASPxClientListEditItem = ASPxClientListEditItem;
window.ASPxClientListBoxItem = ASPxClientListBoxItem;
window.ASPxClientListBoxBase = ASPxClientListBoxBase;
window.ASPxClientListBox = ASPxClientListBox;
window.ASPxClientNativeListBox = ASPxClientNativeListBox;
window.ASPxClientCheckListBase = ASPxClientCheckListBase;
window.ASPxClientRadioButtonList = ASPxClientRadioButtonList;
window.ASPxClientCheckBoxList = ASPxClientCheckBoxList;
window.ASPxClientListEditItemSelectedChangedEventArgs = ASPxClientListEditItemSelectedChangedEventArgs;
})();
