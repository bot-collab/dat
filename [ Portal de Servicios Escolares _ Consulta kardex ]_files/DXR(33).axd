(function() {
var ASPxClientButton = ASPx.CreateClass(ASPxClientControl, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.isASPxClientButton = true;
  this.allowFocus = true;
  this.autoPostBackFunction = null;
  this.causesValidation = true;
  this.checked = false;
  this.clickLocked = false;
  this.groupName = "";
  this.focusElementSelected = false;
  this.pressed = false;
  this.useSubmitBehavior = true;
  this.validationGroup = "";
  this.validationContainerID = null;
  this.validateInvisibleEditors = false;
  this.originalWidth = null;
  this.originalHeight = null;
  this.needUpdateBounds = true;
  this.isTextEmpty = false;
  this.CheckedChanged = new ASPxClientEvent();
  this.GotFocus = new ASPxClientEvent();
  this.LostFocus = new ASPxClientEvent();
  this.Click = new ASPxClientEvent();
 },
 InlineInitialize: function() {
  var mainElement = this.GetMainElement();
  this.originalWidth = mainElement.style.width;
  this.originalHeight = mainElement.style.height;
  ASPxClientControl.prototype.InlineInitialize.call(this);
  this.InitializeElementIDs();
  this.InitializeEvents();
  this.InitializeEnabled();
  this.InitializeChecked();
  if(this.IsLink())
   this.InitializeLink();
  this.PreventButtonImageDragging();
  this.needUpdateBounds = ASPx.Browser.Safari || ASPx.GetCurrentStyle(mainElement).display.indexOf("table") === -1;
  if(this.needUpdateBounds)
   mainElement.className = mainElement.className.replace("dxbTSys", "");
  else {
   var contentElement = this.GetContentDiv();
   if(contentElement) contentElement.style.verticalAlign = mainElement.style.verticalAlign;
  }
 },
 InitializeElementIDs: function(){
  var mainElement = this.GetMainElement();
  var contentElement = ASPx.GetNodeByTagName(mainElement, "DIV", 0);
  if(contentElement) contentElement.id = this.name + "_CD";
  var imageElement = ASPx.GetNodeByTagName(mainElement, "IMG", 0);
  if(imageElement) imageElement.id = this.name + "Img";
 },
 InitializeEnabled: function(){
  this.SetEnabledInternal(this.clientEnabled, true);
 },
 InitializeChecked: function(){
  this.SetCheckedInternal(this.checked, true);
 },
 InitializeLink: function(){
  var mainElement = this.GetMainElement();
  if(this.enabled)
   mainElement.href = "javascript:;";
  if(!this.allowFocus)
   mainElement.style.outline = 0;
  if(!this.GetTextContainer())
   mainElement.style.fontSize = "0pt";
 },
 InitializeEvents: function(){
  if(!this.isNative && !this.IsLink()) {
   var element = this.GetInternalButton();
   if(element)
    element.onfocus = null;
   var textControl = this.GetTextControl();
   if(textControl) {
    if(ASPx.Browser.IE)
     ASPx.Evt.AttachEventToElement(textControl, "mouseup", ASPx.Selection.Clear);
    ASPx.Evt.PreventElementDragAndSelect(textControl, false);
   }    
  }
  this.onClick = function(evt) {
   var processOnServer = ASPx.BClick(this.name, evt);
   if(!processOnServer)
    ASPx.Evt.PreventEvent(evt);
   return processOnServer;
  }.aspxBind(this);
  this.onImageMoseDown = function() { var el = ASPx.GetFocusedElement(); if(el) el.blur(); };
  this.onGotFocus = function() { this.OnFocus(); }.aspxBind(this);
  this.onLostFocus = function() { this.OnLostFocus(); }.aspxBind(this);
  this.onKeyUp = function(evt) { this.OnKeyUp(evt); }.aspxBind(this);
  this.onKeyDown = function(evt) { this.OnKeyDown(evt); }.aspxBind(this); 
  if(!this.isNative && !this.IsLink()) {
   this.AttachNativeHandlerToMainElement("focus", "SetFocus");
   this.AttachNativeHandlerToMainElement("click", "DoClick");
  }
 },
 AdjustControlCore: function () {
  if(this.isNative || this.IsLink()) return;
  var buttonImage = this.GetButtonImage();  
  if(buttonImage && buttonImage.offsetHeight === 0 && buttonImage.offsetWidth === 0)
   buttonImage.onload = function() { this.UpdateSize(); }.aspxBind(this);
  else
   this.UpdateSize();
 },
 UpdateSize: function(){
  if(this.needUpdateBounds){
   this.UpdateWidth();
   this.UpdateHeight();
  }
  else
   this.CorrectWrappedText(this.GetContentDiv, "Text", true);
 },
 UpdateHeight: function(){
  if(this.isNative || this.IsLink() || this.originalHeight === null || ASPx.IsPercentageSize(this.originalHeight)) return;
  var height;
  var mainElement = this.GetMainElement();
  var contentDiv = this.GetContentDiv();
  var borderAndPadding = ASPx.GetTopBottomBordersAndPaddingsSummaryValue(mainElement);
  var contentHasExcessiveHeight = contentDiv.offsetHeight > mainElement.offsetHeight - borderAndPadding;
  var needSetAutoHeight = !this.originalHeight || (ASPx.Browser.Safari && contentHasExcessiveHeight);
  if(needSetAutoHeight) {
   mainElement.style.height = "";
   height = mainElement.offsetHeight - borderAndPadding;
  }
  else
   height = (ASPx.PxToInt(this.originalHeight) - borderAndPadding);
  if(height){
   mainElement.style.height = height + "px";
   if(contentDiv && contentDiv.offsetHeight > 0){
    var contentDivCurrentStyle = ASPx.GetCurrentStyle(contentDiv);
    var paddingTop = parseInt(contentDivCurrentStyle.paddingTop) || 0;
    var paddingBottom = parseInt(contentDivCurrentStyle.paddingBottom) || 0;
    var clientHeightDiff = height - contentDiv.offsetHeight;
    var verticalAlign = ASPx.GetCurrentStyle(mainElement).verticalAlign;
    if(verticalAlign == "top")
     paddingBottom = paddingBottom + clientHeightDiff;
    else if(verticalAlign == "bottom")
     paddingTop = paddingTop + clientHeightDiff;
    else {
     var halfClientHeightDiff = Math.floor(clientHeightDiff / 2);
     paddingTop = paddingTop + halfClientHeightDiff;
     paddingBottom = paddingBottom + (clientHeightDiff - halfClientHeightDiff);
    }
    contentDiv.style.paddingTop = (paddingTop > 0 ? paddingTop : 0) + "px";
    contentDiv.style.paddingBottom = (paddingBottom > 0 ? paddingBottom : 0) + "px";
   }
  }
 },
 UpdateWidth: function(){
  if(this.isNative || this.IsLink() || this.originalWidth === null) return;
  if(!ASPx.IsPercentageSize(this.originalWidth)) {
   var mainElement = this.GetMainElement();
   var borderAndPadding = ASPx.GetLeftRightBordersAndPaddingsSummaryValue(mainElement);
   if(this.originalWidth && ASPx.IsTextWrapped(this.GetTextContainer()))
    mainElement.style.width = (ASPx.PxToInt(this.originalWidth) - borderAndPadding) + "px";
   else
    mainElement.style.width = "";
   var width = mainElement.offsetWidth - borderAndPadding;
   if(this.originalWidth && width < ASPx.PxToInt(this.originalWidth) - borderAndPadding) 
    width = ASPx.PxToInt(this.originalWidth) - borderAndPadding;
   if(width)
    mainElement.style.width = (width > 0 ? width : 0)  + "px";
  }
  this.CorrectWrappedText(this.GetContentDiv, "Text", true);
 },
 GetAdjustedSizes: function() {
  var sizes = ASPxClientControl.prototype.GetAdjustedSizes.call(this);
  var image = this.GetButtonImage();
  if(image) {
   sizes.imageWidth = image.offsetWidth;
   sizes.imageHeight = image.offsetHeight;
  }
  return sizes;
 },
 PreventButtonImageDragging: function() {
  ASPx.Evt.PreventImageDragging(this.GetButtonImage());
 },
 AttachNativeHandlerToMainElement: function(handlerName, correspondingMethodName) {
  var mainElement = this.GetMainElement();
  if(!ASPx.IsExistsElement(mainElement))
   return;
  mainElement[handlerName] = function() { _aspxBCallButtonMethod(this.name, correspondingMethodName); }.aspxBind(this);
 },
 GetContentDiv: function(){
  return this.GetChildElement("CD");
 },       
 GetButtonImage: function(){
  return ASPx.CacheHelper.GetCachedElement(this, "buttonImage", 
   function() { 
    return ASPx.GetNodeByTagName(this.GetMainElement(), "IMG", 0); 
   });
 },
 GetInternalButton: function() {
  return ASPx.CacheHelper.GetCachedElement(this, "internalButton", 
   function() { 
    return this.isNative || this.IsLink() ? this.GetMainElement() : ASPx.GetNodeByTagName(this.GetMainElement(), "INPUT", 0);
   });
 },
 GetTextContainer: function() {
  return ASPx.CacheHelper.GetCachedElement(this, "textContainer", 
   function() { 
    if(this.isNative)
     return this.GetMainElement();
    else{
     var textElement = this.IsLink() ? this.GetMainElement() : this.GetContentDiv();
     return ASPx.GetNodeByTagName(textElement, "SPAN", 0);
    }
   });
 },
 GetTextControl: function(){
  return ASPx.CacheHelper.GetCachedElement(this, "textControl", 
   function() { 
    var element = ASPx.GetParentByTagName(this.GetContentDiv(), "DIV");
    if(!ASPx.IsExistsElement(element) || (element.id == this.name))
     element = this.GetContentDiv();
    return element;
   });
 },
 IsLink: function(){
  if (this.GetMainElement())
   return this.GetMainElement().tagName === "A";
  return false;
 },   
 IsHovered: function(){
  var hoverElement = this.GetMainElement();
  return ASPx.GetStateController().currentHoverItemName == hoverElement.id;
 },   
 SetEnabledInternal: function(enabled, initialization) {
  if(!this.enabled)
   return;
  if(!initialization || !enabled)
   this.ChangeEnabledStateItems(enabled);
  this.ChangeEnabledAttributes(enabled);
 },
 ChangeEnabledAttributes: function(enabled) {
  var element = this.GetInternalButton();
  if(element) {
   element.disabled = !enabled;
   if(this.IsLink()){
    var method = ASPx.Attr.ChangeAttributesMethod(enabled);
    method(this.GetMainElement(), "href");
   }
  }
  this.ChangeEnabledEventsAttributes(ASPx.Attr.ChangeEventsMethod(enabled));
 },
 ChangeEnabledEventsAttributes: function(method) {
  var element = this.GetMainElement();
  method(element, "click", this.onClick);
  if(this.allowFocus){
   if(!this.isNative && !this.IsLink()) 
    element = this.GetInternalButton();
   if(element) {
    method(element, "focus", this.onGotFocus);
    method(element, "blur", this.onLostFocus);
    if(!this.isNative && !this.IsLink()){
     method(element, "keyup", this.onKeyUp);
     method(element, "blur", this.onKeyUp);
     method(element, "keydown", this.onKeyDown);
    }
   }
   if(ASPx.Browser.Firefox){
    var image = this.GetButtonImage();
    if(image)
     method(image, "mousedown", this.onImageMoseDown); 
   }
  }
 },
 ChangeEnabledStateItems: function(enabled){
  if(this.isNative) return;
  ASPx.GetStateController().SetElementEnabled(this.GetMainElement(), enabled);
  this.UpdateFocusedStyle();
 },
 RequiredPreventDoublePostback: function(){
  return ASPx.Browser.Firefox && !this.isNative; 
 },
 OnFocus: function() {
  if(!this.allowFocus)
   return false;
  this.focused = true;
  if(this.isInitialized)
   this.RaiseFocus();
  this.UpdateFocusedStyle();
 },  
 OnLostFocus: function() {
  if(!this.allowFocus)
   return false;
  this.focused = false;
  if(this.isInitialized)
   this.RaiseLostFocus();
  this.UpdateFocusedStyle();
 },
 CauseValidation: function() {
  if(this.causesValidation && typeof(ASPxClientEdit) != "undefined")
   return this.validationContainerID != null ?
    ASPxClientEdit.ValidateEditorsInContainerById(this.validationContainerID, this.validationGroup, this.validateInvisibleEditors) :
    ASPxClientEdit.ValidateGroup(this.validationGroup, this.validateInvisibleEditors);
  else
   return true;
 },
 OnClick: function(evt) {
  if(this.clickLocked) return true;
  if(this.checked && this.groupName != "" && this.GetCheckedGroupList().length > 1) return;
  this.SetFocus();
  var isValid = this.CauseValidation();
  var processOnServer = this.autoPostBack;
  if(this.groupName != "") {
   if(this.GetCheckedGroupList().length == 1)
    this.SetCheckedInternal(!this.checked, false);
   else {
    this.SetCheckedInternal(true, false);
    this.ClearButtonGroupChecked(true);
   }
   processOnServer = this.RaiseCheckedChanged();
   if(processOnServer && isValid)
    this.SendPostBack("CheckedChanged");
  }
  var params = this.RaiseClick();
  if(evt && params.cancelEventAndBubble)
   ASPx.Evt.PreventEventAndBubble(evt);
  if(params.processOnServer && isValid){
   var requiredPreventDoublePostback = this.RequiredPreventDoublePostback();
   var postponePostback = ASPx.Browser.AndroidMobilePlatform; 
   if(requiredPreventDoublePostback || postponePostback)
    window.setTimeout(function() { _aspxBCallButtonMethod(this.name, "SendPostBack", "Click"); }.aspxBind(this), 0); 
   else
    this.SendPostBack("Click");
   return !requiredPreventDoublePostback;
  }
  return false;
 },
 OnKeyUp: function(evt) {
  if(this.pressed)
   this.SetUnpressed();
 },
 OnKeyDown: function(evt) {
  if(evt.keyCode == ASPx.Key.Enter || evt.keyCode == ASPx.Key.Space)
   this.SetPressed();
 },  
 GetChecked: function(){
  return this.groupName != "" ? this.checked : false;
 },  
 GetCheckedGroupList: function(){
  var result = [ ];
  ASPx.GetControlCollection().ForEachControl(function(control) {
   if(ASPx.Ident.IsASPxClientButton(control) && (control.groupName == this.groupName) && !control.IsDOMDisposed())
    result.push(control);
  }, this);
  return result;
 },
 ClearButtonGroupChecked: function(raiseCheckedChanged){
  var list = this.GetCheckedGroupList();
  for(var i = 0; i < list.length; i ++){
   if(list[i] != this && list[i].checked) {
    list[i].SetCheckedInternal(false, false);
    if(raiseCheckedChanged)
     list[i].RaiseCheckedChanged();
   }
  }
 },
 ApplyCheckedStyle: function(){
  var stateController = ASPx.GetStateController();
  if(this.IsHovered()) 
   stateController.SetCurrentHoverElement(null);  
  stateController.SelectElementBySrcElement(this.GetMainElement());
 }, 
 ApplyUncheckedStyle: function(){
  var stateController = ASPx.GetStateController();
  if(this.IsHovered()) 
   stateController.SetCurrentHoverElement(null);
  stateController.DeselectElementBySrcElement(this.GetMainElement());
 },  
 SetCheckedInternal: function(checked, initialization){
  if(initialization && checked || (this.checked != checked)){
   this.checked = checked;
   if(checked)
    this.ApplyCheckedStyle();
   else
    this.ApplyUncheckedStyle();
  }
 },
 UpdateStateObject: function(){
  if(this.groupName != "")
   this.UpdateStateObjectWithObject({ checked: this.checked });
 },
 GetStateHiddenFieldName: function() {
  return this.uniqueID + "$State";
 },
 ApplyPressedStyle: function(){
  ASPx.GetStateController().OnMouseDownOnElement(this.GetMainElement());
 },
 ApplyUnpressedStyle: function(){ 
  ASPx.GetStateController().OnMouseUpOnElement(this.GetMainElement());
 },
 SetPressed: function(){
  this.pressed = true;
  this.ApplyPressedStyle();
 }, 
 SetUnpressed: function(){
  this.pressed = false;
  this.ApplyUnpressedStyle();
 },
 SetFocus: function(){
  if(!this.allowFocus || this.focused)
   return;
  var element = this.GetInternalButton();
  if(element) {
   var hiddenInternalButtonRequiresVisibilityToGetFocused = ASPx.Browser.WebKitFamily  && !this.isNative  && !this.IsLink();
   if(hiddenInternalButtonRequiresVisibilityToGetFocused)
    ASPxClientButton.MakeHiddenElementFocusable(element);
   if(ASPx.IsFocusable(element) && ASPx.GetActiveElement() != element)
    element.focus();
   if(hiddenInternalButtonRequiresVisibilityToGetFocused)
    ASPxClientButton.RestoreHiddenElementAppearance(element);
  }
 },
 ApplyFocusedStyle: function(){
  if(this.focusElementSelected) return;
  if(typeof(ASPx.GetStateController) != "undefined")
   ASPx.GetStateController().SelectElementBySrcElement(this.GetContentDiv());
  this.focusElementSelected = true;
 },
 ApplyUnfocusedStyle: function(){ 
  if(!this.focusElementSelected) return;
  if(typeof(ASPx.GetStateController) != "undefined")
   ASPx.GetStateController().DeselectElementBySrcElement(this.GetContentDiv());
  this.focusElementSelected = false;
 },
 UpdateFocusedStyle: function(){
  if(this.isNative || this.IsLink()) return;
  if(this.enabled && this.clientEnabled && this.allowFocus && this.focused)
   this.ApplyFocusedStyle();
  else
   this.ApplyUnfocusedStyle();
 },
 SendPostBack: function(postBackArg){
  if(!this.enabled || !this.clientEnabled)
   return;
  var arg = postBackArg || "";
  if(this.autoPostBackFunction)
   this.autoPostBackFunction(arg);
  else if(!this.useSubmitBehavior || this.IsLink())
   ASPxClientControl.prototype.SendPostBack.call(this, arg);
  if(this.useSubmitBehavior && !this.isNative) 
   this.ClickInternalButton();
 },
 ClickInternalButton: function(){
  var element = this.GetInternalButton();
  if(element) {
   this.clickLocked = true;
   if(ASPx.Browser.NetscapeFamily)
    this.CreateUniqueIDCarrier(); 
   var postHandler = ASPx.GetPostHandler();
   postHandler.SetLastSubmitElementName(element.name);
   ASPx.Evt.DoElementClick(element);
   postHandler.SetLastSubmitElementName(null);
   if(ASPx.Browser.NetscapeFamily)
    this.RemoveUniqueIDCarrier(); 
   this.clickLocked = false;
  }
 },
 CreateUniqueIDCarrier: function() {
  var name = this.uniqueID;
  var id = this.GetUniqueIDCarrierID();
  var field = ASPx.CreateHiddenField(name, id);
  var form = this.GetParentForm();
  if(form) form.appendChild(field);
 },
 RemoveUniqueIDCarrier: function() {
  var field = document.getElementById(this.GetUniqueIDCarrierID());
  if(field)
   field.parentNode.removeChild(field);
 },
 GetUniqueIDCarrierID: function() {
  return this.uniqueID + "_UIDC";
 },
 DoClick: function(){
  if(!this.enabled || !this.clientEnabled)
   return;
  var button = (this.isNative || this.IsLink()) ? this.GetMainElement() : this.GetInternalButton();
  if(button)
   ASPx.Evt.DoElementClick(button);
  else 
   this.OnClick();   
 },
 GetChecked: function(){
  return this.checked;
 },
 SetChecked: function(checked){
  this.SetCheckedInternal(checked, false);
  this.ClearButtonGroupChecked(false);
 },
 GetText: function(){
  if(!this.isTextEmpty)
   return this.isNative ? this.GetTextContainer().value : this.GetTextContainer().innerHTML;
  return "";
 },
 SetText: function(text){
  this.isTextEmpty = (text == null || text == "");
  var textContainer = this.GetTextContainer();
  if(textContainer){
   if(this.isNative)
    textContainer.value = (text != null) ? text : "";
   else {
    var value = this.isTextEmpty ? "&nbsp;" : text;
      textContainer.innerHTML = value;
    var element = this.GetInternalButton();
    if(element)
     element.value = value;
    if(this.clientVisible && ASPx.Browser.IE && ASPx.Browser.Version >= 9) 
     ASPx.SetElementDisplay(this.GetMainElement(), true);
   }
   this.UpdateSize();
  }
 },
 GetImageUrl: function(){
  var img = this.GetButtonImage();
  return img ?  img.src : "";
 },
 SetImageUrl: function(url){
  var img = this.GetButtonImage();
  if(img) {
   img.src = url;
   this.UpdateSize();
  }
 },
 SetEnabled: function(enabled){
  if(this.clientEnabled != enabled) {
   if(!enabled && this.focused)
    this.OnLostFocus();
   this.clientEnabled = enabled;
   this.SetEnabledInternal(enabled, false);
  }
 },
 GetEnabled: function(){
  return this.enabled && this.clientEnabled;
 },
 Focus: function(){
  this.SetFocus();
 },
 RaiseCheckedChanged: function(){
  var processOnServer = this.autoPostBack || this.IsServerEventAssigned("CheckedChanged");
  if(!this.CheckedChanged.IsEmpty()){
   var args = new ASPxClientProcessingModeEventArgs(processOnServer);
   this.CheckedChanged.FireEvent(this, args);
   processOnServer = args.processOnServer;
  }
  return processOnServer;
 },
 RaiseFocus: function(){
  if(!this.GotFocus.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.GotFocus.FireEvent(this, args);
  }
 },
 RaiseLostFocus: function(){
  if(!this.LostFocus.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.LostFocus.FireEvent(this, args);
  }
 },
 RaiseClick: function() {
  var processOnServer = this.autoPostBack || this.IsServerEventAssigned("Click");
  var cancelEventAndBubble = false;
  if(!this.Click.IsEmpty()) {
   var args = new ASPxClientButtonClickEventArgs(processOnServer, cancelEventAndBubble);
   this.Click.FireEvent(this, args);
   cancelEventAndBubble = args.cancelEventAndBubble;
   processOnServer = args.processOnServer;
  }
  return {
   processOnServer: processOnServer,
   cancelEventAndBubble: cancelEventAndBubble
  };
 }
});
var ASPxClientButtonClickEventArgs = ASPx.CreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(processOnServer, cancelEventAndBubble) {
  this.constructor.prototype.constructor.call(this, processOnServer);
  this.cancelEventAndBubble = cancelEventAndBubble;
 }
});
ASPxClientButton.Cast = ASPxClientControl.Cast;
ASPxClientButton.MakeHiddenElementFocusable = function(element) {
 element.__dxHiddenElementState = {
  parentDisplay: element.parentNode.style.display,
  height: element.style.height,
  width: element.style.width
 };
 element.parentNode.style.display = "block";
 element.style.height = "1px";
 element.style.width = "1px";
};
ASPxClientButton.RestoreHiddenElementAppearance = function(element) {
 var state = element.__dxHiddenElementState;
 element.parentNode.style.display = state.parentDisplay;
 element.style.height = state.height;
 element.style.width = state.width;
 delete element.__dxHiddenElementState;
};
ASPx.Ident.IsASPxClientButton = function(obj) {
 return !!obj.isASPxClientButton;
};
function _aspxBCallButtonMethod(name, methodName, arg) {
 var button = ASPx.GetControlCollection().Get(name); 
 if(button != null)
  button[methodName](arg);
}
ASPx.BClick = function(name, evt) {
 var button = ASPx.GetControlCollection().Get(name); 
 if(button != null)
  return button.OnClick(evt);
}
window.ASPxClientButton = ASPxClientButton;
})();

