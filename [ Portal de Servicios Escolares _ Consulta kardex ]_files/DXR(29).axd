(function() {
var dropDownNameSuffix = "_DDD";
var itemImageCellClassName = "dxeIIC";
var ASPxClientDropDownEditBase = ASPx.CreateClass(ASPxClientButtonEditBase, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.DropDown = new ASPxClientEvent();
  this.CloseUp = new ASPxClientEvent();
  this.QueryCloseUp = new ASPxClientEvent();
  this.ddHeightCache = ASPx.InvalidDimension;
  this.ddWidthCache = ASPx.InvalidDimension;
  this.mainElementWidthCache = ASPx.InvalidDimension;
  this.dropDownButtonIndex = -1;
  this.droppedDown = false;
  this.ddButtonPushed = false;
  this.lastSuccessText = "";
  this.isToolbarItem = false;
  this.allowFocusDropDownWindow = false;
  this.pcIsShowingNow = false;
  this.needTimeoutForInputElementFocusEvent = false;
  aspxGetDropDownCollection().Add(this);
 },
 Initialize: function(){
  var pc = this.GetPopupControl();
  if(pc) {
   pc.allowCorrectYOffsetPosition = false;
   pc.dropDownEditName = this.name;
  }
  this.AssignClientAttributes();
  this.InitLastSuccessText();
  if(this.RefocusOnClickRequired()){ 
   ASPx.Evt.AttachEventToElement(this.GetMainElement(), "click", function(evt) {
    if(this.GetInputElement() && ASPx.Evt.GetEventSource(evt).id != this.GetInputElement().id) 
     this.ForceRefocusEditor(evt);
   }.aspxBind(this));
  }
  ASPxClientButtonEditBase.prototype.Initialize.call(this);
 },
 InitLastSuccessText: function(){
  var rawText = this.GetTextInternal();
  this.SetLastSuccessText(rawText);
 },
 AssignClientAttributes: function(){
  var element = this.GetDropDownButton();
  if(ASPx.IsExistsElement(element))
   ASPx.Evt.PreventElementDragAndSelect(element, true);
 },
 RefocusOnClickRequired: function(){
  return false;
 },
 GetDropDownButton: function(){
  return this.GetButton(this.dropDownButtonIndex);
 },
 GetPopupControl: function(){
  var pc = ASPx.GetControlCollection().Get(this.name + dropDownNameSuffix);
  if(pc && pc.GetWindowElement(-1))
   return pc;
  else
   return null;
 },
 GetDropDownInnerControlName: function(suffix){
  var pc = this.GetPopupControl();
  if(pc)
   return this.GetPopupControl().name + suffix;
  return "";
 },
 GetDropDownItemImageCell: function() {
  return ASPx.GetNodesByPartialClassName(this.GetMainElement(), itemImageCellClassName)[0];
 },
 GetIsControlWidthWasChanged: function(){
  return this.mainElementWidthCache == ASPx.InvalidDimension || this.mainElementWidthCache != this.GetMainElement().clientWidth;
 },
 GetDropDownHeight: function(){
  return 0;
 },
 GetDropDownWidth: function(){
  return 0;
 },
 GetDropDownIsWindowElement: function(id, pcPostfix) {
  var pos = id.lastIndexOf(pcPostfix);
  if(pos != -1) {
   var name = id.substring(0, pos);
   var pc = ASPx.GetPopupControlCollection().Get(name);
   if(pc && pc.dropDownEditName)
    return aspxGetDropDownCollection().Get(pc.dropDownEditName);
  }
  return null;
 },
 GetDropDownParents: function() {
  var parents = [ ];
  var mainElement = this.GetMainElement();
  var pcPostfix = ASPx.PCWIdSuffix + "-1";
  var element = mainElement.parentNode;
  while(element != null){
   if(element.tagName == "BODY")
    break;
   if(ASPx.Attr.IsExistsAttribute(element, "id")) { 
    var dropDown = this.GetDropDownIsWindowElement(ASPx.Attr.GetAttribute (element, "id"), pcPostfix);
    if(dropDown != null)
     parents.push(dropDown);
   }
   element = element.parentNode;
  }
  return parents.reverse();
 },
 BeforePopupControlResizing: function() {
 },
 AfterPopupControlResizing: function() {
 },
 ShowDropDownArea: function(isRaiseEvent, forceSize) {
  this.SetPCIsShowingNow(true);
  aspxGetDropDownCollection().RegisterDroppedDownControl(this, this.GetDropDownParents());
  if(!this.droppedDown) 
   this.SetLockListBoxClick();
  this.lockClosing = true; 
  var pc = this.GetPopupControl();
  var element = this.GetMainElement();
  var pcwElement = pc.GetWindowElement(-1);
  if(!ASPx.GetElementDisplay(pcwElement)) {
   pcwElement.style.visibility = "hidden";
  }
  ASPx.SetElementDisplay(pcwElement, true);
  if(ASPx.Browser.Chrome && pcwElement.clientHeight <= 0) 
   this.RestorePopupInsideNonStaticPositionedContainer();
  var height = forceSize ? forceSize.height : this.GetDropDownHeight();
  var width = forceSize ? forceSize.width : this.GetDropDownWidth();
  this.BeforePopupControlResizing();
  if(this.ddHeightCache != height || this.ddWidthCache != width || forceSize) {
   pc.SetSize(width, height);
   if(!forceSize) {
    this.ddHeightCache = height;
    this.ddWidthCache = width;
   }
  }
  this.AfterPopupControlResizing();
  if(ASPx.Browser.Chrome && pcwElement.clientHeight <= 0) 
   this.RestorePopupInsideNonStaticPositionedContainer();
  pc.popupVerticalOffset = - ASPx.GetClientTop(element);
  this.RaiseDropDownEventRequired = isRaiseEvent;
  var needRefreshHorzScroll = ASPx.Browser.Chrome && document.body.scrollWidth > document.body.clientWidth && pc.getParentPopupControl(-1); 
  if(needRefreshHorzScroll)
   ASPx.Attr.ChangeStyleAttribute(document.body, "overflow-x", "hidden");
  pc.ShowAtElement(element);
  if(needRefreshHorzScroll)
   ASPx.Attr.RestoreStyleAttribute(document.body, "overflow-x");
  this.droppedDown = true;
  this.lockClosing = false;
 },
 HideDropDownArea: function(isRaiseEvent){
  if(this.lockClosing || !this.droppedDown) return;
  if(!this.RaiseQueryCloseUp()) {
   return;
  }
  this.RemoveLockListBoxClick();
  this.DropDownButtonPop();
  var pc = this.GetPopupControl();
  if(pc){
   aspxGetDropDownCollection().UnregisterDroppedDownControl(this);
   pc.Hide();
   if(isRaiseEvent)
    this.RaiseCloseUp();
   this.droppedDown = false;
  }
 },
 RestorePopupInsideNonStaticPositionedContainer: function() {
  var pc = this.GetPopupControl();
  var pcwElement = pc.GetWindowElement(-1);
  var pcwParentElement = pcwElement.parentNode;
  var offsetParentElement = pcwElement.offsetParent;
  if(!offsetParentElement || offsetParentElement.tagName == "BODY") return;
  pcwParentElement.style.position = "relative";
  setTimeout(
   function() { 
    pcwParentElement.style.position = "";
    pc.ShowAtElement(this.GetMainElement());
   }.aspxBind(this)
  , 0);
 },
 SetLockListBoxClick: function() {
  this.lockListBoxClick = true;
 },
 RemoveLockListBoxClick: function() {
  delete this.lockListBoxClick;
 },
 ProcessInternalButtonClick: function(buttonIndex) {
  return this.dropDownButtonIndex == buttonIndex;
 },
 ToggleDropDown: function(){
  this.OnApplyChanges();
  if(this.droppedDown)
   this.HideDropDownArea(true);
  else
   this.ShowDropDownArea(true);  
 },
 GetTextInternal: function(){
  var text = ASPxClientButtonEditBase.prototype.GetValue.call(this);
  return text != null ? text : "";
 },
 SetTextInternal: function(text){
  if(!this.readOnly)
   this.SetTextBase(text);
 },
 SetTextBase: function(text) {
  ASPxClientButtonEditBase.prototype.SetValue.call(this, text);
 },
 SetValue: function(value) {
  ASPxClientButtonEditBase.prototype.SetValue.call(this, value);
  this.SetLastSuccessText(this.GetTextInternal());
 },
 SetLastSuccessText: function(text){
  var tmpText = text;
  if(text == null) tmpText = "";
  else if(typeof(text) != "string")
     tmpText = text.toString();
  this.lastSuccessText = tmpText;
 },
 SetVisible: function(visible) {
  ASPxClientButtonEditBase.prototype.SetVisible.call(this, visible);
  if(!visible)
   this.HideDropDown();
 },
 RollbackTextInputValue: function () {
  this.SetTextBase(this.lastSuccessText);
 },
 SetPCIsShowingNow: function(value){
  this.pcIsShowingNow = value;
 },
 GetLastSuccesfullValue: function() {
  return this.lastSuccessText !== '' ? this.lastSuccessText : null;
 },
 OnValueChanged: function() {
  this.SetLastSuccessText(this.GetTextInternal());
  ASPxClientEdit.prototype.OnValueChanged.call(this);
 },
 OnApplyChanges: function(){
 },
 OnCancelChanges: function(){
  var isCancelProcessed = (this.GetTextInternal() != this.lastSuccessText);
  this.SetTextInternal(this.lastSuccessText);
  return isCancelProcessed;
 },
 OnFocus: function () {
  if(this.CorrectFocusWhenDisabled())
   return;
  if(ASPx.Browser.IE && this.needTimeoutForInputElementFocusEvent) {
   setTimeout(function () {
    this.OnSetFocus(true);
    ASPxClientButtonEditBase.prototype.OnFocus.call(this);
    this.needTimeoutForInputElementFocusEvent = false;
   }.aspxBind(this), 0);
  } else {
   this.OnSetFocus(true);
   ASPxClientButtonEditBase.prototype.OnFocus.call(this);
  }
 },
 OnLostFocus: function(){
  this.OnSetFocus(false);
  ASPxClientButtonEditBase.prototype.OnLostFocus.call(this);
 },
 OnSetFocus: function(isFocused){
  aspxGetDropDownCollection().SetFocusedDropDownName(isFocused ? this.name : "");
 },
 IsEditorElement: function(element) {
  if(ASPxClientButtonEditBase.prototype.IsEditorElement.call(this, element))
   return true;
  if(this.allowFocusDropDownWindow)
   return false;
  var pc = this.GetPopupControl();
  if(pc != null) {
   var windowElement = pc.GetWindowElement(-1);
   return windowElement == element || ASPx.GetIsParent(windowElement, element);
  }
  return false;
 },
 OnPopupControlShown: function(){
  this.SetPCIsShowingNow(false);
  if(this.RaiseDropDownEventRequired){
   this.RaiseDropDownEventRequired = false;
   window.setTimeout(function() { this.RaiseDropDown(); }.aspxBind(this), 0);
  }
 },
 IsCanToDropDown: function(){
  return true;
 },
 OnDropDown: function(evt) { 
  if(!this.isInitialized) 
   return true;
  if(!this.IsCanToDropDown()) {
   this.ForceRefocusEditor(evt);
   return true;
  }
  if(ASPx.Browser.IE && ASPx.Browser.Version < 9 || ASPx.Browser.Opera){
   if(!this.droppedDown) {
    ASPx.Evt.EmulateOnMouseDown(this.GetMainElement(), evt);
    ASPx.GetStateController().ClearSavedCurrentPressedElement();
   }
  }
  this.OnDropDownCore(evt);
  return ASPx.Evt.CancelBubble(evt); 
 },
 OnDropDownCore: function(evt) {
  if(!this.droppedDown)
   this.DropDownButtonPush();
  this.ToggleDropDown();
  var inputElement = this.GetInputElement();
  var isNativeFocus = !!inputElement ? this.IsElementBelongToInputElement(ASPx.Evt.GetEventSource(evt)) : false;
  this.ForceRefocusEditor(evt, isNativeFocus);
 },
 DropDownButtonPush: function(){
  if(this.droppedDown || this.ddButtonPushed) return;
  this.ddButtonPushed = true;
  if(ASPx.Browser.IE && ASPx.Browser.Version < 9 || ASPx.Browser.Opera)
   this.DropDownButtonPushPop(true);
  else
   this.DropDownButtonPushMozilla();
 }, 
 DropDownButtonPop: function(force){
  if((!this.droppedDown || !this.ddButtonPushed) && !force) return;
  this.ddButtonPushed = false;
  if(ASPx.Browser.IE && ASPx.Browser.Version < 9 || ASPx.Browser.Opera)
   this.DropDownButtonPushPop(false);
  else
   this.DropDownButtonPopMozilla();
 },
 DropDownButtonPushPop: function(isPush){
  var buttonElement = this.GetDropDownButton();
  if(buttonElement){
   var controller = ASPx.GetStateController();
   var element = controller.GetPressedElement(buttonElement);
   if(element){
    if(isPush){
     controller.SetCurrentHoverElement(null);
     controller.DoSetPressedState(element);
    } else {
     controller.DoClearPressedState(element);
     controller.SetCurrentPressedElement(null);
     controller.SetCurrentHoverElement(element);
    }
   }
  }
 },
 DropDownButtonPushMozilla: function(){
  this.DisableStyleControllerForDDButton();
  var controller = ASPx.GetStateController();
  controller.savedCurrentPressedElement = null;
 },
 DropDownButtonPopMozilla: function(){
  this.EnableStyleControllerForDDButton();
  var controller = ASPx.GetStateController();
  var buttonElement = this.GetDropDownButton();
  if(buttonElement){
   var element = controller.GetPressedElement(buttonElement);
   if(element)
    controller.DoClearPressedState(element);
   controller.currentPressedElement = null;
   element = controller.GetHoverElement(buttonElement);
   if(element)
    controller.SetCurrentHoverElement(element);
  }
 },
 EnableStyleControllerForDDButton: function(){
  var element = this.GetDropDownButton();
  if(element){
   var controller = ASPx.GetStateController();
   this.ReplaceElementControlStyleItem(controller.hoverItems, ASPx.HoverItemKind, element, this.ddButtonHoverStyle);
   this.ReplaceElementControlStyleItem(controller.pressedItems, ASPx.PressedItemKind, element, this.ddButtonPressedStyle);
   this.ReplaceElementControlStyleItem(controller.selectedItems, ASPx.SelectedItemKind, element, this.ddButtonSelectedStyle);
  }
 },
 DisableStyleControllerForDDButton: function(){
  var element = this.GetDropDownButton();
  if(element){
   var controller = ASPx.GetStateController();
   this.ddButtonHoverStyle = this.ReplaceElementControlStyleItem(controller.hoverItems, ASPx.HoverItemKind, element, null);
   this.ddButtonPressedStyle = this.ReplaceElementControlStyleItem(controller.pressedItems, ASPx.PressedItemKind, element, null);
   this.ddButtonSelectedStyle = this.ReplaceElementControlStyleItem(controller.selectedItems, ASPx.SelectedItemKind, element, null);
  }
 },
 ReplaceElementControlStyleItem: function(items, kind, element, newStyleItem){
  var styleItem = items[element.id];
  items[element.id] = newStyleItem;
  element[kind] = newStyleItem;
  return styleItem;
 },
 CloseDropDownByDocumentOrWindowEvent: function(causedByWindowResizing){
  if(!causedByWindowResizing || !this.pcIsShowingNow)
   this.HideDropDownArea(true);
 },
 OnDocumentMouseUp: function() {
  this.DropDownButtonPop();
 },
 OnDDButtonMouseMove: function(evt){
 },
 ShouldCloseOnMCMouseDown: function () {
  return true;
 },
 OnMainCellMouseDown: function (evt) {
  if(this.ShouldCloseOnMCMouseDown())
   this.OnCloseUp(evt);
 },
 OnCloseUp: function (evt) {
  if(ASPx.Browser.IE) {
   this.needTimeoutForInputElementFocusEvent = true;
   setTimeout(function () { this.HideDropDownArea(true); }.aspxBind(this), 0);
  } else {
   this.HideDropDownArea(true);
  }
 },
 OnOpenAnotherDropDown: function(){
  this.HideDropDownArea(true);
 },
 OnTextChanged: function() {
  if(!this.ChangedByEnterKeyPress())
   this.OnTextChangedInternal();
 },
 OnTextChangedInternal: function() {
  this.ParseValue();
 },
 ChangedByEnterKeyPress: function() {
  if(ASPx.Browser.Firefox || ASPx.Browser.WebKitFamily) 
   if(this.enterKeyPressed) {
    this.enterKeyPressed = false;
    return true;
   } 
  return false;
 },
 ChangeEnabledAttributes: function(enabled){
  ASPxClientButtonEditBase.prototype.ChangeEnabledAttributes.call(this, enabled);
  var btnElement = this.GetDropDownButton();
  if(btnElement)
   this.ChangeButtonEnabledAttributes(btnElement, ASPx.Attr.ChangeAttributesMethod(enabled));
  var inputElement = this.GetInputElement();
  if(inputElement)
   this.ChangeInputCellEnabledAttributes(inputElement.parentNode, ASPx.Attr.ChangeAttributesMethod(enabled));
  var imageCell = this.GetDropDownItemImageCell();
  if(ASPx.IsExists(imageCell))
   this.ChangeImageCellEnabledAttributes(imageCell, ASPx.Attr.ChangeAttributesMethod(enabled));
 },
 ChangeEnabledStateItems: function(enabled){
  ASPxClientButtonEditBase.prototype.ChangeEnabledStateItems.call(this, enabled);
  var btnElement = this.GetDropDownButton();
  if(btnElement)
   ASPx.GetStateController().SetElementEnabled(btnElement, enabled);
 },
 ChangeInputCellEnabledAttributes: function(element, method){
  method(element, "onclick");
  method(element, "onkeyup");
  method(element, "on" + ASPx.TouchUIHelper.touchMouseDownEventName);
  method(element, "on" + ASPx.TouchUIHelper.touchMouseUpEventName);
 },
 ChangeImageCellEnabledAttributes: function(imageCell, method){
  method(imageCell, "onmousedown");
 },
 InitializeKeyHandlers: function() {
  this.AddKeyDownHandler(ASPx.Key.Enter, "OnEnter");
  this.AddKeyDownHandler(ASPx.Key.Esc, "OnEscape");
  this.AddKeyDownHandler(ASPx.Key.PageUp, "OnPageUp");
  this.AddKeyDownHandler(ASPx.Key.PageDown, "OnPageDown");
  this.AddKeyDownHandler(ASPx.Key.End, "OnEndKeyDown");
  this.AddKeyDownHandler(ASPx.Key.Home, "OnHomeKeyDown");
  this.AddKeyDownHandler(ASPx.Key.Left, "OnArrowLeft");
  this.AddKeyDownHandler(ASPx.Key.Right, "OnArrowRight");
  this.AddKeyDownHandler(ASPx.Key.Up, "OnArrowUp");
  this.AddKeyDownHandler(ASPx.Key.Down, "OnArrowDown");
  this.AddKeyDownHandler(ASPx.Key.Tab, "OnTab");
 },
 OnArrowUp: function(evt){
  if(evt.altKey) {
   this.ToggleDropDown();
   return true;
  }
  return false;
 },
 OnArrowDown: function(evt){
  if(evt.altKey) {
   this.ToggleDropDown();
   return true;
  }
  return false;
 },
 OnPageUp: function(evt){
  return false;
 }, 
 OnPageDown: function(evt){
  return false;
 },
 OnEndKeyDown: function(evt){
  return false;
 },
 OnHomeKeyDown: function(evt){
  return false;
 },
 OnArrowLeft: function(evt){
  return false;
 },
 OnArrowRight: function(evt){
  return false;
 },
 OnEscape: function(evt){
  return this.OnEscapeInternal();
 },
 OnEscapeInternal: function() {
  var isCancelProcessed = this.OnCancelChanges() || this.droppedDown;
  this.HideDropDownArea(true);
  return isCancelProcessed;
 },
 OnEnter: function(evt){
  return false;
 },
 OnTab: function(evt){
  return false;
 },
 RaiseCloseUp: function(){
  if(!this.CloseUp.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.CloseUp.FireEvent(this, args);
  }
 },
 RaiseDropDown: function(){
  if(!this.DropDown.IsEmpty() && this.isInitialized){
   var args = new ASPxClientEventArgs();
   this.DropDown.FireEvent(this, args);
  }
 },
 RaiseQueryCloseUp: function(){
  if(!this.QueryCloseUp.IsEmpty() && this.isInitialized) {
   var args = new ASPxClientCancelEventArgs();
   this.QueryCloseUp.FireEvent(this, args);
   return !args.cancel;
  }
  return true;
 },
 AdjustDropDownWindow: function(){
  var pc = this.GetPopupControl();
  if(pc) {
   if(ASPx.Browser.IE)
    ASPx.GetPopupControlCollection().LockWindowResizeByBodyScrollVisibilityChanging();
   pc.AdjustSize();
   pc.UpdatePositionAtElement(this.GetMainElement());
   if(ASPx.Browser.IE)
    ASPx.GetPopupControlCollection().UnlockWindowResizeByBodyScrollVisibilityChanging();
  }
 },
 ResetDropDownSizeCache: function(){
  this.ddHeightCache = ASPx.InvalidDimension;
  this.ddWidthCache = ASPx.InvalidDimension;
 },
 ShowDropDown: function(){
  if(!this.droppedDown)
   this.ShowDropDownArea(false);
 },
 HideDropDown: function(){
  if(this.droppedDown)
   this.HideDropDownArea(false);
 }
});
var ASPxClientDropDownEdit = ASPx.CreateClass(ASPxClientDropDownEditBase, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.dropDownWindowHeight = "";
  this.dropDownWindowWidth = "";
  this.allowFocusDropDownWindow = true;
  this.needAdjustControlsInDropDownWindow = true;
 },
 InlineInitialize: function(){
  this.InitSpecialKeyboardHandling();
  this.InitializeEvents();
  this.eventHandlersInitialized = true;
  ASPxClientDropDownEditBase.prototype.InlineInitialize.call(this);
 },
 RefocusOnClickRequired: function(){
  return ASPx.Browser.IE;
 },
 BeforePopupControlResizing: function() {
  var divContainer = this.GetDropDownDivContainer();
  if(divContainer && this.needAdjustControlsInDropDownWindow) {
   this.AdjustControlsInDropDownWindow();
   ASPx.SetElementDisplay(divContainer, false);
  }
 },
 AfterPopupControlResizing: function() {
  var divContainer = this.GetDropDownDivContainer();
  if(divContainer && this.needAdjustControlsInDropDownWindow) {
   ASPx.SetElementDisplay(divContainer, true);
   this.AdjustControlsInDropDownWindow();
   this.needAdjustControlsInDropDownWindow = false;
  }
 },
 AdjustControlsInDropDownWindow: function() {
  var pc = this.GetPopupControl();
  var pcwElement = pc.GetWindowElement(-1);
  ASPx.GetControlCollection().ProcessControlsInContainer(pcwElement, function(control) {
   control.AdjustControl(false);
  });
 },
 GetDropDownDivContainer: function() {
  return ASPx.GetElementById(this.name + dropDownNameSuffix + "_DDDC");
 },
 GetDropDownHeight: function(){
  if(this.dropDownWindowHeight != "")
   return this.dropDownWindowHeight;
  return ASPxClientDropDownEditBase.prototype.GetDropDownHeight.call(this);
 },
 GetDropDownWidth: function(){
  if(this.dropDownWindowWidth != "")
   return this.dropDownWindowWidth;
  return this.GetMainElement().offsetWidth;
 },
 CloseDropDownByDocumentOrWindowEvent: function(causedByWindowResizing){
  if(!ASPx.GetPopupControlCollection().WindowResizeByBodyScrollVisibilityChangingLocked())
   ASPxClientDropDownEditBase.prototype.CloseDropDownByDocumentOrWindowEvent.call(this, causedByWindowResizing);
 },
 OnBrowserWindowResize: function(evt){
  this.needAdjustControlsInDropDownWindow = true;
 },
 OnEnter: function(evt){
  return this.droppedDown;
 },
 OnEscape: function(evt){
  var isCancelProcessed = this.droppedDown;
  this.HideDropDownArea(true);
  return isCancelProcessed;
 },
 OnTextChanged: function() {
  this.OnValueChanged();
 },
 GetKeyValueInternal: function(){
  if(ASPx.IsExists(this.stateObject))
   return this.stateObject.keyValue;
  return null;
 },
 SetKeyValueInternal: function(keyValue){
  this.UpdateStateObjectWithObject({ keyValue: keyValue });
 },
 GetKeyValue: function(){
  return this.GetKeyValueInternal();
 },
 SetKeyValue: function(keyValue){
  this.SetKeyValueInternal(keyValue);
 }
});
ASPxClientDropDownEdit.Cast = ASPxClientControl.Cast;
var ASPxClientDropDownCollection = ASPx.CreateClass(ASPxClientControlCollection, {
 constructor: function() {
  this.constructor.prototype.constructor.call(this);
  this.droppedControlName = "";
  this.droppedParentNames = [ ];
  this.focusedControlName = "";
 },
 GetCollectionType: function(){
  return "DropDown";
 },
 SetFocusedDropDownName: function(name){
  this.focusedControlName = name;
 },
 ResetDroppedDownControl: function(){
  this.droppedControlName = "";
 },
 ResetDroppedDownParentCollection: function(startDroppedDownControlName) {
  var regArray = [ ];
  for(var i = 0; i < this.droppedParentNames.length; i++) {
   if(this.droppedParentNames[i] == startDroppedDownControlName)
    break;
   regArray.push(this.droppedParentNames[i]);
  }
  this.droppedParentNames = regArray;
  if(this.droppedParentNames.length > 0) {
   this.droppedControlName = this.droppedParentNames[this.droppedParentNames.length - 1];
   ASPx.Data.ArrayRemoveAt(this.droppedParentNames, this.droppedParentNames.length - 1);
  }
 },
 ResetFocusedControl: function(){
  this.focusedControlName = "";
 },
 GetFocusedDropDown: function(){
  var control = this.GetDropDownControlInternal(this.focusedControlName);
  if(control == null) this.ResetFocusedControl();
  return control;
 },
 GetDroppedDropDown: function(){
  var control = this.GetDropDownControlInternal(this.droppedControlName);
  if(control == null) this.ResetDroppedDownControl();
  return control;
 },
 GetDroppedDropDownParents: function(startDroppedDownControlName) {
  var dropDownArray = [ ];
  var isNeedGetControl = false;
  for(var i = 0; i < this.droppedParentNames.length; i++) {
   if(this.droppedParentNames[i] == startDroppedDownControlName) isNeedGetControl = true;
   if(isNeedGetControl)
    var control = this.GetDropDownControlInternal(this.droppedParentNames[i]);
    if(control != null)
     dropDownArray.push(control);
  }
  return dropDownArray;
 },
 FindFirstNameForClose: function(newDroppedDownParentArray) {
  var firstNameToClose = newDroppedDownParentArray.length > 0 ? "" : this.droppedParentNames[i];
  for(var i = 0; i < this.droppedParentNames.length; i++) {
   if(ASPx.Data.ArrayIndexOf(newDroppedDownParentArray, this.Get(this.droppedParentNames[i])) == -1) {
    firstNameToClose = this.droppedParentNames[i];
    break;
   }
  }
  return firstNameToClose;
 },
 GetDropDownControlInternal: function(name){
  var control = this.Get(name);
  var isControlExists = control && !control.IsDOMDisposed();
  if(!isControlExists)
   control = null;
  return control;
 },
 IsDroppedDropDownParentExist: function(name) {
  for(var i = 0; i < this.droppedParentNames.length; i++) {
   if(this.droppedParentNames[i] == name)
    return true;
  }
  return false;
 },
 OnDDButtonMouseMove: function(evt){
  var dropDownControl = this.GetDroppedDropDown();
  if(dropDownControl != null)
   dropDownControl.OnDDButtonMouseMove(evt);
 },
 OnDocumentMouseDown: function(evt){
  if(!ASPx.TouchUIHelper.handleFastTapIfRequired(evt, function(){ this.CloseDropDownByDocumentOrWindowEvent(evt, false); }.aspxBind(this), false))
   this.CloseDropDownByDocumentOrWindowEvent(evt, false);
 },
 OnDocumentMouseUp: function(evt){
  var dropDownControl = this.GetDroppedDropDown();
  if(dropDownControl != null)
   dropDownControl.OnDocumentMouseUp();
 },
 OnBrowserWindowResize: function(e){
  if(typeof(ASPx.GetPopupControlCollection) != "undefined" && !ASPx.GetPopupControlCollection().WindowResizeByBodyScrollVisibilityChangingLocked()){
   this.CloseDropDownByDocumentOrWindowEvent(e.htmlEvent, true);
   this.AdjustControls();
  }
 },
 CloseDropDownByDocumentOrWindowEvent: function(evt, causedByWindowResizing){
  var dropDownControl = this.GetDroppedDropDown();
  if(dropDownControl != null && (this.IsEventNotFromControlSelf(evt, dropDownControl) || causedByWindowResizing))
   dropDownControl.CloseDropDownByDocumentOrWindowEvent(causedByWindowResizing);
  var childrenDropDownsToClose = this.GetDroppedDropDownParents(this.droppedParentNames[0]);
  if(childrenDropDownsToClose.length != 0) {
   childrenDropDownsToClose = childrenDropDownsToClose.reverse();
   this.ResetDroppedDownParentCollection(this.droppedParentNames[0]);
   var rollbackDroppedDownNames = [ ];
   for(var c = 0; c < childrenDropDownsToClose.length; c++) {
    if(this.IsEventNotFromControlSelf(evt, childrenDropDownsToClose[c]))
     childrenDropDownsToClose[c].CloseDropDownByDocumentOrWindowEvent(causedByWindowResizing);
    else
     rollbackDroppedDownNames.push(childrenDropDownsToClose[c].name);
   }
   if(rollbackDroppedDownNames != 0) {
    rollbackDroppedDownNames = rollbackDroppedDownNames.reverse();
    this.droppedParentNames = rollbackDroppedDownNames;
   }
  }
 },
 AdjustControls: function(){
  this.ForEachControl(function(control) {
   control.AdjustControl(false);
  });
 },
 IsEventNotFromControlSelf: function(evt, control){
  var srcElement = ASPx.Evt.GetEventSource(evt);
  var mainElement = control.GetMainElement();
  var popupControl = control.GetPopupControl();
  if(!srcElement || !mainElement || !popupControl) return true;
  return (!ASPx.GetIsParent(mainElement, srcElement) &&
   !ASPx.GetIsParent(popupControl.GetWindowElement(-1), srcElement) &&
   !this.IsEventFromSharedPopupOfInnerEditor(popupControl, srcElement));
 },
 IsEventFromSharedPopupOfInnerEditor: function(popupControl, srcElement) {
  var eventFromPopupOfInnerEditor = false;
  ASPx.GetControlCollection().ProcessControlsInContainer(popupControl.GetWindowElement(-1),
   function(control){
    if(control.calendarOwnerName) {
     var sharedCalendarPopup = control.GetCalendarOwner().GetPopupControl().GetWindowElement(-1);
     if(ASPx.GetIsParent(sharedCalendarPopup, srcElement))
      eventFromPopupOfInnerEditor = true;
    }
  });
  return eventFromPopupOfInnerEditor;
 },
 RegisterDroppedDownControl: function(dropDownControl, droppedDownParentArray){
  var prevDropDownControl = this.GetDroppedDropDown();
  var areDroppedDownsCollectionParents = ASPx.Data.ArrayIndexOf(droppedDownParentArray, prevDropDownControl) != -1;
  if(prevDropDownControl != null && prevDropDownControl != dropDownControl && !areDroppedDownsCollectionParents)
   prevDropDownControl.OnOpenAnotherDropDown();
  if(this.droppedParentNames.length > 0) {
   var firstDropDownsNameToClose = this.FindFirstNameForClose(droppedDownParentArray);
   if(firstDropDownsNameToClose != "") {
    var childrenDropDownsToClose = this.GetDroppedDropDownParents(firstDropDownsNameToClose);
    this.ResetDroppedDownParentCollection(firstDropDownsNameToClose);
    this.CloseDroppedDownCollection(childrenDropDownsToClose.reverse());
   }
  }
  this.droppedControlName = dropDownControl.name;
  this.droppedParentNames = [ ];
  for(var i = 0; i < droppedDownParentArray.length; i++)
   this.droppedParentNames.push(droppedDownParentArray[i].name);
 },
 UnregisterDroppedDownControl: function(dropDownControl){
  if(this.droppedControlName == dropDownControl.name)
   this.ResetDroppedDownControl();
  if(this.IsDroppedDropDownParentExist(dropDownControl.name)) {
   var prevDropDownControl = this.GetDroppedDropDown();
   if(prevDropDownControl != null)
    prevDropDownControl.OnOpenAnotherDropDown();
   var childrenDropDownsToClose = this.GetDroppedDropDownParents(dropDownControl.name);
   this.ResetDroppedDownParentCollection(dropDownControl.name);
   ASPx.Data.ArrayRemoveAt(childrenDropDownsToClose, 0);
   this.CloseDroppedDownCollection(childrenDropDownsToClose.reverse());
  }
 },
 CloseDroppedDownCollection: function(dropDownParentArray) {
  for(var c = 0; c < dropDownParentArray.length; c++)
   dropDownParentArray[c].OnOpenAnotherDropDown();
 }
});
var dropDownCollection = null;
function aspxGetDropDownCollection() {
 if(dropDownCollection == null)
  dropDownCollection  = new ASPxClientDropDownCollection();
 return dropDownCollection;
}
ASPx.Ident.IsASPxClientDateEdit = function(obj) {
 return !!obj.isASPxClientDateEdit;
};
ASPx.DDDropDown = function(name, evt){
 if(ASPx.Evt.IsLeftButtonPressed(evt)){
  var dd = ASPx.GetControlCollection().Get(name);
  if(dd)
   return dd.OnDropDown(evt);
 }
}
ASPx.DDMC_MD = function(name, evt) {
 var dd = ASPx.GetControlCollection().Get(name);
 if(dd)
  dd.OnMainCellMouseDown(evt);
}
ASPx.DDBPCShown = function(name){
 var cb = ASPx.GetControlCollection().Get(name);
 if(cb != null) cb.OnPopupControlShown();
}
ASPx.CBLBSelectedIndexChanged = function(name, evt){
 var cb = ASPx.GetControlCollection().Get(name);
 if(cb != null) cb.OnLBSelectedIndexChanged();
}
ASPx.CBLBItemMouseUp = function(name, evt){
 var cb = ASPx.GetControlCollection().Get(name);
 if(cb != null) cb.OnListBoxItemMouseUp(evt);
}
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseDownEventName, function(evt) {
 return aspxGetDropDownCollection().OnDocumentMouseDown(evt);
});
ASPx.Evt.AttachEventToDocument("mouseup", function(evt) {
 return aspxGetDropDownCollection().OnDocumentMouseUp(evt);
});
window.ASPxClientDropDownEditBase = ASPxClientDropDownEditBase;
window.ASPxClientDropDownEdit = ASPxClientDropDownEdit;
ASPx.GetDropDownCollection = aspxGetDropDownCollection;
})();

