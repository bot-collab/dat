(function() {
ASPx.TEInputSuffix = "_I";
ASPx.PasteCheckInterval = 50;
var passwordInputClonedSuffix = "_CLND";
var memoMinHeight = 34;
var BrowserHelper = {
 SAFARI_SYSTEM_CLASS_NAME: "dxeSafariSys",
 MOBILE_SAFARI_SYSTEM_CLASS_NAME: "dxeIPadSys",
 GetBrowserSpecificSystemClassName: function() {
  if(ASPx.Browser.Safari)
   return ASPx.Browser.MacOSMobilePlatform ? this.MOBILE_SAFARI_SYSTEM_CLASS_NAME : this.SAFARI_SYSTEM_CLASS_NAME;
  return "";
 }
};
var ASPxClientTextEdit = ASPx.CreateClass(ASPxClientEdit, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);      
  this.isASPxClientTextEdit = true;
  this.nullText = "";
  this.escCount = 0;
  this.raiseValueChangedOnEnter = true;
  this.autoResizeWithContainer = false;
  this.lastChangedValue = null;
  this.passwordNullTextIntervalID = -1;
  this.nullTextInputElement = null;
  this.helpText = "";
  this.helpTextObj = null;  
  this.helpTextStyle = [];
  this.externalTableStyle = [];
  this.helpTextPosition = ASPx.Position.Right;
  this.helpTextMargins = null;
  this.helpTextHAlign = ASPxClientTextEditHelpTextHAlign.Left;
  this.helpTextVAlign = ASPxClientTextEditHelpTextVAlign.Top;
  this.enableHelpTextPopupAnimation = true;
  this.helpTextDisplayMode = ASPxClientTextEditHelpTextDisplayMode.Inline;
  this.maskInfo = null;  
  this.maskValueBeforeUserInput = "";
  this.maskPasteTimerID = -1;
  this.maskPasteLock = false;    
  this.maskPasteCounter = 0;
  this.maskTextBeforePaste = "";    
  this.maskHintHtml = "";
  this.maskHintTimerID = -1;
  this.maskedEditorClickEventHandlers = [];
  this.errorCellPosition = ASPx.Position.Right;
  this.displayFormat = null;
  this.TextChanged = new ASPxClientEvent();
 },
 Initialize: function(){
  this.SaveChangedValue();
  ASPxClientEdit.prototype.Initialize.call(this);
  this.CorrectInputMaxLength();
  this.SubscribeToIeDropEvent();
  if(ASPx.Browser.WebKitFamily)  
   this.CorrectMainElementWhiteSpaceStyle();
  if(this.GetInputElement().type == "password")
   this.ToggleTextDecoration();
 },
 InlineInitialize: function(){
  ASPxClientEdit.prototype.InlineInitialize.call(this);
  if(this.maskInfo != null)
   this.InitMask();
  this.ApplyBrowserSpecificClassName();
  this.helpTextInitialize();
  if(ASPx.Browser.IE && ASPx.Browser.Version >= 10 && this.nullText != "")
   this.addIEXButtonEventHandler();
 },
 InitializeEvents: function() {
  ASPxClientEdit.prototype.InitializeEvents.call(this);
  ASPx.Evt.AttachEventToElement(this.GetInputElement(), "keydown", this.OnKeyDown.aspxBind(this));
  ASPx.Evt.AttachEventToElement(this.GetInputElement(), "keyup", this.OnKeyUp.aspxBind(this));
  ASPx.Evt.AttachEventToElement(this.GetInputElement(), "keypress", this.OnKeyPress.aspxBind(this));
 },
 AdjustControl: function() {
  ASPxClientEdit.prototype.AdjustControl.call(this);
  if(ASPx.Browser.IE && ASPx.Browser.Version > 8 && !this.isNative)
   this.correctInputElementHeight();
 },
 correctInputElementHeight: function() {
  var mainElement = this.GetMainElement();
  var inputElement = this.GetInputElement();
  if(mainElement) {
   var mainElementHeight = mainElement.style.height;
   var mainElementHeightSpecified = mainElementHeight && mainElementHeight.indexOf('px') !== -1; 
   if(mainElementHeightSpecified) {
    var inputElementHeight = this.getInputElementHeight();
    inputElement.style.height = inputElementHeight + "px";
    if(!ASPx.Ident.IsASPxClientMemo(this))
     inputElement.style.lineHeight = inputElementHeight + "px";
   }
  }
 },
 getInputElementHeight: function() {
  var mainElement = this.GetMainElement(),
   inputElement = this.GetInputElement();
  var inputElementHeight = ASPx.Browser.IE && ASPx.Browser.Version > 9 ? ASPx.PxToInt(getComputedStyle(mainElement).height)
   : mainElement.offsetHeight - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(mainElement);
  var inputElementContainer = inputElement.parentNode,
   inputContainerStyle = ASPx.GetCurrentStyle(inputElementContainer);
  inputElementHeight -= ASPx.GetTopBottomBordersAndPaddingsSummaryValue(inputElementContainer, inputContainerStyle) 
   + ASPx.GetTopBottomMargins(inputElementContainer, inputContainerStyle);
  var mainElementCellspacing = ASPx.GetCellSpacing(mainElement);
  if(mainElementCellspacing)
   inputElementHeight -= mainElementCellspacing * 2;
  var inputStyle = ASPx.GetCurrentStyle(inputElement);
  inputElementHeight -= ASPx.GetTopBottomBordersAndPaddingsSummaryValue(inputElement, inputStyle) 
   + ASPx.GetTopBottomMargins(inputElement, inputStyle);
  return inputElementHeight;
 },
 addIEXButtonEventHandler: function() {
  var inputElement = this.GetInputElement()
  if(ASPx.IsExists(inputElement)) {
   this.isDeleteOrBackspaceKeyClick = false;
   ASPx.Evt.AttachEventToElement(inputElement, "input", function (evt) {
    if(this.isDeleteOrBackspaceKeyClick) {
     this.isDeleteOrBackspaceKeyClick = false;
     return;
    }
    if(inputElement.value === '') {
     this.SyncRawValue();
    }
   }.aspxBind(this));
   ASPx.Evt.AttachEventToElement(inputElement, "keydown", function (evt) {
    this.isDeleteOrBackspaceKeyClick = (evt.keyCode == ASPx.Key.Delete || evt.keyCode == ASPx.Key.Backspace);
   }.aspxBind(this));
  }   
 },
 ensureOutOfRangeWarningManager: function (minValue, maxValue, defaultMinValue, defaultMaxValue, valueFormatter) {
  if (!this.outOfRangeWarningManager)
   this.outOfRangeWarningManager = new ASPxOutOfRangeWarningManager(this, minValue, maxValue, defaultMinValue, defaultMaxValue,
    this.hasRightPopupHelpText() ? ASPx.Position.Bottom : ASPx.Position.Right, valueFormatter);
 },
 helpTextInitialize: function () {
  if(this.helpText) {
   this.helpTextObj = new ASPxClientTextEditHelpText(this, this.helpTextStyle, this.helpText, this.helpTextPosition,
    this.helpTextHAlign, this.helpTextVAlign, this.helpTextMargins, this.enableHelpTextPopupAnimation, this.helpTextDisplayMode);
  }
 },
 hasRightPopupHelpText: function() {
  return this.helpText && this.helpTextDisplayMode === ASPxClientTextEditHelpTextDisplayMode.Popup
   && this.helpTextPosition === ASPx.Position.Right;
 },
 showHelpText: function () {
  if(this.helpTextObj)
   this.helpTextObj.show();
 },
 hideHelpText: function () {
  if(this.helpTextObj)
   this.helpTextObj.hide();
 },
 ApplyBrowserSpecificClassName: function() {
  var mainElement = this.GetMainElement();
  if(ASPx.IsExistsElement(mainElement)) {
   var className = BrowserHelper.GetBrowserSpecificSystemClassName();
   if(className)
    mainElement.className += " " + className;
  }
 },
  CorrectMainElementWhiteSpaceStyle: function() {
  var inputElement = this.GetInputElement();
  if(inputElement && inputElement.parentNode) {
   if(this.IsElementHasWhiteSpaceStyle(inputElement.parentNode))
    inputElement.parentNode.style.whiteSpace = "normal";
  }
 },
 IsElementHasWhiteSpaceStyle: function(element) {
  var currentStyle = ASPx.GetCurrentStyle(element);
  return currentStyle.whiteSpace == "nowrap" || currentStyle.whiteSpace == "pre";  
 },
 FindInputElement: function(){
  return this.isNative ? this.GetMainElement() : ASPx.GetElementById(this.name + ASPx.TEInputSuffix);
 },
 DecodeRawInputValue: function(value) {
  return value;
 },
 GetRawValue: function(value){
  return ASPx.IsExists(this.stateObject) ? this.stateObject.rawValue : null;
 },
 SetRawValue: function(value){
  if(ASPx.IsExists(value))
   value = value.toString();
  this.UpdateStateObjectWithObject({ rawValue: value });
 },
 SyncRawValue: function() {
  if(this.maskInfo != null)
   this.SetRawValue(this.maskInfo.GetValue());
  else
   this.SetRawValue(this.GetInputElement().value);
 },
 HasTextDecorators: function() {
  return this.nullText != "" || this.displayFormat != null;
 },
 CanApplyTextDecorators: function(){
  return !this.focused;
 },
 GetDecoratedText: function(value) {
  if(this.IsNull(value) && this.nullText != "") {
   if(this.CanApplyNullTextDecoration) {
    if(this.CanApplyNullTextDecoration())
     return this.nullText;
   } else {
    return this.nullText;
   }
  }
  if(this.displayFormat != null)
   return ASPx.Formatter.Format(this.displayFormat, value);
  if(this.maskInfo != null)
   return this.maskInfo.GetText();
  if(value == null)
   return "";
  return value;
 },
 ToggleTextDecoration: function() {
  if(this.HasTextDecorators()) {
   if(this.focused) {
    var input = this.GetInputElement();
    var oldValue = input.value;
    var sel = ASPx.Selection.GetExtInfo(input);
    this.ToggleTextDecorationCore();
    if(oldValue != input.value) {
     if(sel.startPos == 0 && sel.endPos == oldValue.length)
      sel.endPos = input.value.length;
     else
      sel.endPos = sel.startPos;
     ASPx.Selection.Set(input, sel.startPos, sel.endPos);
    }
   } else
    this.ToggleTextDecorationCore();
  }
 },
 ToggleTextDecorationCore: function() {
  if(this.maskInfo != null) {   
   this.ApplyMaskInfo(false);
  } else {
   var input = this.GetInputElement();
   var rawValue = this.GetRawValue();
   var value = this.CanApplyTextDecorators() ? this.GetDecoratedText(rawValue) : rawValue;
   if(input.value != value) {
    if(input.type == "password")
     this.TogglePasswordInputTextDecoration(value);
    else
     input.value = value;
   }
  }
 },
 GetPasswordNullTextInputElement: function() {
  if(!this.isPasswordNullTextInputElementExists())
   this.nullTextInputElement = this.createPasswordNullTextInputElement();
  return this.nullTextInputElement;
 },
 createPasswordNullTextInputElement: function() {
  var inputElement = this.GetInputElement(),
   nullTextInputElement = document.createElement("INPUT");
  nullTextInputElement.className = inputElement.className;
  nullTextInputElement.style.cssText = inputElement.style.cssText;
  nullTextInputElement.id = inputElement.id + passwordInputClonedSuffix;
  nullTextInputElement.type = "text";
  if(ASPx.IsExists(inputElement.tabIndex))
   nullTextInputElement.tabIndex = inputElement.tabIndex;
  var onFocusEventHandler = function() {
   var inputElement = this.GetInputElement(),
    nullTextInputElement = this.GetPasswordNullTextInputElement();
   if(inputElement) {
    this.LockFocusEvents();  
    ASPx.SetElementDisplay(inputElement, true);
    inputElement.focus();
    ASPx.SetElementDisplay(nullTextInputElement, false);
    this.ReplaceAssociatedIdInLabels(nullTextInputElement.id, inputElement.id);
   }
  }.aspxBind(this);
  ASPx.Evt.AttachEventToElement(nullTextInputElement, "focus", onFocusEventHandler);
  return nullTextInputElement;
 },
 isPasswordNullTextInputElementExists: function() {
  return ASPx.IsExistsElement(this.nullTextInputElement);
 },
 TogglePasswordNullTextTimeoutChecker: function() {
  if(this.passwordNullTextIntervalID < 0) {
   var timeoutChecker = function() {
    var inputElement = this.GetInputElement();
    if(ASPx.GetControlCollection().GetByName(this.name) !== this || inputElement == null) {
     window.clearTimeout(this.passwordNullTextIntervalID);
     this.passwordNullTextIntervalID = -1;
     return;
    } else {
     if(!this.focused) {
      var passwordNullTextInputElement = this.GetPasswordNullTextInputElement();
      if(passwordNullTextInputElement.value != this.nullText && inputElement.value == "") { 
       passwordNullTextInputElement.value = this.nullText;
       this.SetValue(null);
      }
      if(inputElement.value != "") {
       if(inputElement.style.display == "none") {
        this.SetValue(inputElement.value);
        this.UnhidePasswordInput();
       }
      } else {
       if(inputElement.style.display != "none") {
        this.SetValue(null);
        this.HidePasswordInput();
       }
      }
     }
    }
   }.aspxBind(this);
   timeoutChecker(); 
   this.passwordNullTextIntervalID = window.setInterval(timeoutChecker, 100);
  }
 },
 TogglePasswordInputTextDecoration: function(value) {
  var inputElement = this.GetInputElement();
  var nullTextInputElement = this.GetPasswordNullTextInputElement();
  nullTextInputElement.value = value;
  var parentNode = inputElement.parentNode;
  if(ASPx.Data.ArrayIndexOf(parentNode.childNodes, nullTextInputElement) < 0) {
   ASPx.Attr.ChangeStyleAttribute(nullTextInputElement, "display", "none");
   parentNode.appendChild(nullTextInputElement);
  }
  this.HidePasswordInput();
  this.TogglePasswordNullTextTimeoutChecker();
 },
 HidePasswordInput: function() {
  ASPx.Attr.ChangeStyleAttribute(this.GetInputElement(), "display", "none");
  ASPx.Attr.ChangeStyleAttribute(this.GetPasswordNullTextInputElement(), "display", "");
  this.ReplaceAssociatedIdInLabels(this.GetInputElement().id, this.GetPasswordNullTextInputElement().id);
 },
 UnhidePasswordInput: function() {
  ASPx.Attr.ChangeStyleAttribute(this.GetInputElement(), "display", "");
  ASPx.Attr.ChangeStyleAttribute(this.GetPasswordNullTextInputElement(), "display", "none");
  this.ReplaceAssociatedIdInLabels(this.GetPasswordNullTextInputElement().id, this.GetInputElement().id);
 },
 ReplaceAssociatedIdInLabels: function(oldId, newId) {
  var labels = document.getElementsByTagName("LABEL");
  for(var i = 0; i < labels.length; i++) {
   if(labels[i].attributes["for"] && labels[i].attributes["for"].value == oldId)
    labels[i].attributes["for"].value = newId;
  }
 },
 GetFormattedText: function() {
  var value = this.GetValue();
  if(this.IsNull(value) && this.nullText != "")
   return this.GetText();
  return this.GetDecoratedText(value);
 },
 IsNull: function(value) {
  return value == null || value === "";
 },
 PopulateStyleDecorationPostfixes: function() {
  ASPxClientEdit.prototype.PopulateStyleDecorationPostfixes.call(this);
  this.styleDecoration.AddPostfix(ASPx.TEInputSuffix);
 },
 GetValue: function() {
  var value = null;
  if(this.maskInfo != null)
   value = this.maskInfo.GetValue();
  else if(this.HasTextDecorators())
   value = this.GetRawValue();
  else
   value = this.GetInputElement().value;
  return (value == "" && this.convertEmptyStringToNull) ? null : value;
 },
 SetValue: function(value) {
  if(value == null || value === undefined) 
   value = "";
  if(this.maskInfo != null) {
   this.maskInfo.SetValue(value.toString());
   this.ApplyMaskInfo(false);
   this.SavePrevMaskValue();
  } 
  else if(this.HasTextDecorators()) {
   this.SetRawValue(value);
   this.GetInputElement().value = this.CanApplyTextDecorators() && this.GetInputElement().type != "password" ? this.GetDecoratedText(value) : value;
  }
  else
   this.GetInputElement().value = value;
  if(this.styleDecoration)
   this.styleDecoration.Update();   
  this.SaveChangedValue();   
 },
 SetVisible: function(visible) {
  ASPxClientEdit.prototype.SetVisible.call(this, visible);
  if(this.helpTextDisplayMode === ASPxClientTextEditHelpTextDisplayMode.Inline) {
   if(visible)
    this.showHelpText();
   else
    this.hideHelpText();
  }
 },
 UnstretchInputElement: function(){
  var inputElement = this.GetInputElement();
  var mainElement = this.GetMainElement();
  var mainElementCurStyle = ASPx.GetCurrentStyle(mainElement);
  if(ASPx.IsExistsElement(mainElement) && ASPx.IsExistsElement(inputElement) && ASPx.IsExists(mainElementCurStyle) && 
   inputElement.style.width == "100%" &&
   (mainElementCurStyle.width == "" || mainElementCurStyle.width == "auto"))
   inputElement.style.width = "";
 },
 RestoreActiveElement: function(activeElement) {
  if(activeElement && activeElement.setActive && activeElement.tagName != "IFRAME")
   activeElement.setActive();
 },
 RaiseValueChangedEvent: function() {
  var processOnServer = ASPxClientEdit.prototype.RaiseValueChangedEvent.call(this);
  processOnServer = this.RaiseTextChanged(processOnServer);
  return processOnServer;
 },
 InitMask: function() {
  var rawValue = this.GetRawValue();
  this.SetValue(rawValue.length ? this.DecodeRawInputValue(rawValue) : this.maskInfo.GetValue());
  this.validationPatterns.unshift(new MaskValidationPattern(this.maskInfo.errorText, this.maskInfo));
 },
 SetMaskPasteTimer: function() {
  this.ClearMaskPasteTimer();
  this.maskPasteTimerID = ASPx.Timer.SetControlBoundInterval(this.MaskPasteTimerProc, this, ASPx.PasteCheckInterval);
 },
 ClearMaskPasteTimer: function() {
  this.maskPasteTimerID = ASPx.Timer.ClearInterval(this.maskPasteTimerID);
 },
 SavePrevMaskValue: function() {
  this.maskValueBeforeUserInput = this.maskInfo.GetValue();
 },
 FillMaskInfo: function() {
  var input = this.GetInputElement();
  if(!input) return; 
  var sel = ASPx.Selection.GetInfo(input);
  this.maskInfo.SetCaret(sel.startPos, sel.endPos - sel.startPos);  
 },
 ApplyMaskInfo: function(applyCaret) {
  this.SyncRawValue();
  var input = this.GetInputElement();
  var text = this.GetMaskDisplayText();
  this.maskTextBeforePaste = text;
  if(input.value != text)
   input.value = text;
  if(applyCaret)
   ASPx.Selection.Set(input, this.maskInfo.caretPos, this.maskInfo.caretPos + this.maskInfo.selectionLength);
 },
 GetMaskDisplayText: function() {
  if(!this.focused && this.HasTextDecorators())
   return this.GetDecoratedText(this.maskInfo.GetValue());
  return this.maskInfo.GetText();
 },
 ShouldCancelMaskKeyProcessing: function(htmlEvent, keyDownInfo) {
  return ASPx.Evt.IsEventPrevented(htmlEvent);
 }, 
 HandleMaskKeyDown: function(evt) {
  var keyInfo = ASPx.MaskManager.CreateKeyInfoByEvent(evt);
  ASPx.MaskManager.keyCancelled = this.ShouldCancelMaskKeyProcessing(evt, keyInfo);
  if(ASPx.MaskManager.keyCancelled) {
   ASPx.Evt.PreventEvent(evt);
   return;
  }
  this.maskPasteLock = true;
  this.FillMaskInfo();  
  var canHandle = ASPx.MaskManager.CanHandleControlKey(keyInfo);   
  ASPx.MaskManager.savedKeyDownKeyInfo = keyInfo;
  if(canHandle) {   
   ASPx.MaskManager.OnKeyDown(this.maskInfo, keyInfo);
   this.ApplyMaskInfo(true);
   ASPx.Evt.PreventEvent(evt);
  }
  ASPx.MaskManager.keyDownHandled = canHandle;
  this.maskPasteLock = false;
  this.UpdateMaskHintHtml();
 },
 HandleMaskKeyPress: function(evt) {
  var keyInfo = ASPx.MaskManager.CreateKeyInfoByEvent(evt);
  ASPx.MaskManager.keyCancelled = ASPx.MaskManager.keyCancelled || this.ShouldCancelMaskKeyProcessing(evt, ASPx.MaskManager.savedKeyDownKeyInfo);
  if(ASPx.MaskManager.keyCancelled) {
   ASPx.Evt.PreventEvent(evt);
   return;
  }
  this.maskPasteLock = true;  
  var printable = ASPx.MaskManager.savedKeyDownKeyInfo != null && ASPx.MaskManager.IsPrintableKeyCode(ASPx.MaskManager.savedKeyDownKeyInfo);
  if(printable) {
   ASPx.MaskManager.OnKeyPress(this.maskInfo, keyInfo);
   this.ApplyMaskInfo(true);
  }
  if(printable || ASPx.MaskManager.keyDownHandled)   
   ASPx.Evt.PreventEvent(evt); 
  this.maskPasteLock = false;
  this.UpdateMaskHintHtml();
 },
 MaskPasteTimerProc: function() {
  if(this.maskPasteLock || !this.maskInfo) return;
  this.maskPasteCounter++;
  var inputElement = this.inputElement;
  if(!inputElement || this.maskPasteCounter > 40) {
   this.maskPasteCounter = 0;
   inputElement = this.GetInputElement();
   if(!ASPx.IsExistsElement(inputElement)) {
    this.ClearMaskPasteTimer();
    return;
   }
  }
  if(this.maskTextBeforePaste !== inputElement.value) {
   this.maskInfo.ProcessPaste(inputElement.value, ASPx.Selection.GetInfo(inputElement).endPos);
   this.ApplyMaskInfo(true);
  }
  if(!this.focused)
   this.ClearMaskPasteTimer();
 },
 BeginShowMaskHint: function() {  
  if(!this.readOnly && this.maskHintTimerID == -1)
   this.maskHintTimerID = window.setInterval(ASPx.MaskHintTimerProc, 500);
 },
 EndShowMaskHint: function() {
  window.clearInterval(this.maskHintTimerID);
  this.maskHintTimerID = -1;
 },
 MaskHintTimerProc: function() {  
  if(this.maskInfo) {
   this.FillMaskInfo();
   this.UpdateMaskHintHtml();
  } else {
   this.EndShowMaskHint();
  }
 },
 UpdateMaskHintHtml: function() {  
  var hint =  this.GetMaskHintElement();
  if(!ASPx.IsExistsElement(hint))
   return;
  var html = ASPx.MaskManager.GetHintHtml(this.maskInfo);
  if(html == this.maskHintHtml)
   return;
  if(html != "") {
   var mainElement = this.GetMainElement();
   if(ASPx.IsExistsElement(mainElement)) {
    hint.innerHTML = html;
    hint.style.position = "absolute";  
    hint.style.left = ASPx.PrepareClientPosForElement(ASPx.GetAbsoluteX(mainElement), mainElement, true) + "px";
    hint.style.top = (ASPx.PrepareClientPosForElement(ASPx.GetAbsoluteY(mainElement), mainElement, false) + mainElement.offsetHeight + 2) + "px";
    hint.style.display = "block";    
   }   
  } else {
   hint.style.display = "none";
  }
  this.maskHintHtml = html;
 },
 HideMaskHint: function() {
  var hint =  this.GetMaskHintElement();
  if(ASPx.IsExistsElement(hint))
   hint.style.display = "none";
  this.maskHintHtml = "";
 },
 GetMaskHintElement: function() {
  return ASPx.GetElementById(this.name + "_MaskHint");
 },
 OnFocus: function() {
  if(this.maskInfo != null && !ASPx.GetControlCollection().InCallback())
   this.SetMaskPasteTimer();
  ASPxClientEdit.prototype.OnFocus.call(this);
 },
 OnMouseWheel: function(evt){
  if(this.readOnly || this.maskInfo == null) return;
  this.FillMaskInfo();
  ASPx.MaskManager.OnMouseWheel(this.maskInfo, ASPx.Evt.GetWheelDelta(evt) < 0 ? -1 : 1);
  this.ApplyMaskInfo(true);
  ASPx.Evt.PreventEvent(evt);
  this.UpdateMaskHintHtml();
 }, 
 OnBrowserWindowResize: function(evt) {
  if(!this.autoResizeWithContainer)
   this.AdjustControl();
 },
 IsValueChanged: function() {
  return this.GetValue() != this.lastChangedValue; 
 },
 OnKeyDown: function(evt) {        
  if(this.NeedPreventBrowserUndoBehaviour(evt))
   return ASPx.Evt.PreventEvent(evt);
  if(ASPx.Browser.IE && ASPx.Evt.GetKeyCode(evt) == ASPx.Key.Esc) {   
   if(++this.escCount > 1) {
    ASPx.Evt.PreventEvent(evt);
    return;
   }
  } else 
   this.escCount = 0;
  ASPxClientEdit.prototype.OnKeyDown.call(this, evt);
  if(!this.IsRaiseStandardOnChange(evt)) {
   if(!this.readOnly && this.maskInfo != null)
    this.HandleMaskKeyDown(evt);
  }
 },
 IsCtrlZ: function(evt) {
  return evt.ctrlKey && !evt.altKey && !evt.shiftKey && (ASPx.Evt.GetKeyCode(evt) == 122 || ASPx.Evt.GetKeyCode(evt) == 90)
 },
 NeedPreventBrowserUndoBehaviour: function(evt) {
  var inputElement = this.GetInputElement();
  return this.IsCtrlZ(evt) && !!inputElement && !inputElement.value;
 },
 OnKeyPress: function(evt) {
  ASPxClientEdit.prototype.OnKeyPress.call(this, evt);
  if(!this.readOnly && this.maskInfo != null && !this.IsRaiseStandardOnChange(evt))
   this.HandleMaskKeyPress(evt);
  if(this.NeedOnKeyEventEnd(evt, true))
   this.OnKeyEventEnd(evt);
 },
 OnKeyUp: function(evt) {
  if(ASPx.Browser.Firefox && !this.focused && ASPx.Evt.GetKeyCode(evt) === ASPx.Key.Tab)
   return;
  if(this.NeedOnKeyEventEnd(evt, false)) {
   var proccessNextCommingPress = ASPx.Evt.GetKeyCode(evt) === ASPx.Key.Alt; 
   this.OnKeyEventEnd(evt, proccessNextCommingPress);
  }
  ASPxClientEdit.prototype.OnKeyUp.call(this, evt);
 },
 NeedOnKeyEventEnd: function(evt, isKeyPress) { 
  var handleKeyPress = this.maskInfo != null && evt.keyCode == ASPx.Key.Enter;
  return handleKeyPress == isKeyPress;
 },
 OnKeyEventEnd: function(evt, withDelay){
  if(!this.readOnly) {
   if(this.IsRaiseStandardOnChange(evt))
    this.RaiseStandardOnChange();
   this.SyncRawValueIfHasTextDecorators(withDelay);
  }
 },
 SyncRawValueIfHasTextDecorators: function(withDelay) {
  if(this.HasTextDecorators()) {
   if(withDelay) {
    window.setTimeout(function() {
     this.SyncRawValue();
    }.aspxBind(this), 0);
   } else 
    this.SyncRawValue();
  }
 },
 IsRaiseStandardOnChange: function(evt){
  return !this.specialKeyboardHandlingUsed && this.raiseValueChangedOnEnter && evt.keyCode == ASPx.Key.Enter;
 },
 GetFocusSelectAction: function() {
  if(this.maskInfo)
   return "start";
  return "all"; 
 },
 CorrectFocusWhenDisabled: function() {
  if(!this.GetEnabled()) {
   var inputElement = this.GetInputElement();
   if(inputElement)
    inputElement.blur();
   return true;
  }
  return false;
 },
 EnsureShowPopupHelpText: function() {
  if(this.helpTextDisplayMode === ASPxClientTextEditHelpTextDisplayMode.Popup)
   this.showHelpText();
 },
 EnsureHidePopupHelpText: function() {
  if(this.helpTextDisplayMode === ASPxClientTextEditHelpTextDisplayMode.Popup)
   this.hideHelpText();
 },
 OnFocusCore: function() {
  if(this.CorrectFocusWhenDisabled())
   return;
  var wasLocked = this.IsFocusEventsLocked();
  ASPxClientEdit.prototype.OnFocusCore.call(this);
  this.CorrectInputMaxLength(true);
  if(this.maskInfo != null) {
   this.SavePrevMaskValue();
   this.BeginShowMaskHint();
   this.AttachOnMouseClickIfNeeded();
  }
  if(!wasLocked)
   this.ToggleTextDecoration();
  if(this.isPasswordNullTextInputElementExists())
   setTimeout(function() { this.EnsureShowPopupHelpText(); }.aspxBind(this), 0);
  else
   this.EnsureShowPopupHelpText();
 },
 clearMaskedEditorClickEventHandlers: function () {
  for(var i = 0; i < this.maskedEditorClickEventHandlers.length; i++)
   ASPx.Evt.DetachEventFromElement(this.GetInputElement(), "click", this.maskedEditorClickEventHandlers[i]);
  this.maskedEditorClickEventHandlers = [];
 },
 addMaskedEditorClickEventHandler: function () {
  this.maskedEditorClickEventHandlers.push(this.MouseClickOnMaskedEditorFunc);
  ASPx.Evt.AttachEventToElement(this.GetInputElement(), "click", this.MouseClickOnMaskedEditorFunc);
 },
 AttachOnMouseClickIfNeeded: function () {
  this.clearMaskedEditorClickEventHandlers();
  if(this.GetValue() == "" || this.GetValue() == null) {
   this.MouseClickOnMaskedEditorFunc = function (e) {
    this.clearMaskedEditorClickEventHandlers();
    var selectionInfo = ASPx.Selection.GetExtInfo(this.GetInputElement());
    if(selectionInfo.startPos == selectionInfo.endPos)
     this.SetCaretPosition(this.GetInitialCaretPositionInEmptyMaskedInput());
   }.aspxBind(this);
   this.addMaskedEditorClickEventHandler();
  }
 },
 GetInitialCaretPositionInEmptyMaskedInput: function() {
  var maskParts = this.maskInfo.parts;
  return ASPx.MaskManager.IsLiteralPart(maskParts[0]) ? maskParts[0].GetSize() : 0;
 },
 OnLostFocusCore: function() {
  var wasLocked = this.IsFocusEventsLocked();
  ASPxClientEdit.prototype.OnLostFocusCore.call(this);
  this.CorrectInputMaxLength();
  if(this.maskInfo != null) {
   this.EndShowMaskHint();
   this.HideMaskHint();   
   if(this.maskInfo.ApplyFixes(null))
    this.ApplyMaskInfo(false);
   this.RaiseStandardOnChange();
  }
  if(!wasLocked)
   this.ToggleTextDecoration();
  this.escCount = 0;
  this.EnsureHidePopupHelpText();
 },
 InputMaxLengthCorrectionRequired: function () {
  return ASPx.Browser.IE && ASPx.Browser.Version >= 10 && (!this.isNative || this.nullText != "");
 },
 CorrectInputMaxLength: function (onFocus) {
  if(this.InputMaxLengthCorrectionRequired()) {
   var input = this.GetInputElement();
   if(!ASPx.IsExists(this.inputMaxLength))
    this.inputMaxLength = input.maxLength;
   input.maxLength = onFocus ? this.inputMaxLength : -1;
  }
 },
 SubscribeToIeDropEvent: function() {
  if(this.InputMaxLengthCorrectionRequired()) {
   var input = this.GetInputElement();
   ASPx.Evt.AttachEventToElement(input, "drop", function(e) { this.CorrectInputMaxLength(true); }.aspxBind(this));
  }
 },
 SetFocus: function() {
  if(this.isPasswordNullTextInputElementExists()) {
   this.GetPasswordNullTextInputElement().focus();
  } else {
     ASPxClientEdit.prototype.SetFocus.call(this);
  }
 },
 OnValueChanged: function() {
  if(this.maskInfo != null) {
   if(this.maskInfo.GetValue() == this.maskValueBeforeUserInput && !this.IsValueChangeForced())
    return;
   this.SavePrevMaskValue();
  }
  if(this.HasTextDecorators())
   this.SyncRawValue();
  if(!this.IsValueChanged() && !this.IsValueChangeForced())
   return;
  this.SaveChangedValue(); 
  ASPxClientEdit.prototype.OnValueChanged.call(this);
 },
 IsValueChangeForced: function() {
  return false;
 },
 OnTextChanged: function() {
 },
 SaveChangedValue: function() {
  this.lastChangedValue = this.GetValue();
 },
 RaiseStandardOnChange: function(){
  var element = this.GetInputElement();
  if(element && element.onchange) {
   element.onchange({ target: this.GetInputElement() });
  }
  else if(this.ValueChanged) {
   this.ValueChanged.FireEvent(this);
  }
 },
 RaiseTextChanged: function(processOnServer){
  if(!this.TextChanged.IsEmpty()){
   var args = new ASPxClientProcessingModeEventArgs(processOnServer);
   this.TextChanged.FireEvent(this, args);
   processOnServer = args.processOnServer;
  }
  return processOnServer;  
 },
 GetText: function(){
  if(this.maskInfo != null) {
   return this.maskInfo.GetText();
  } else {
   var value = this.GetValue();
   return value != null ? value : "";
  }
 },
 SetText: function (value){
  if(this.maskInfo != null) {
   this.maskInfo.SetText(value);
   this.ApplyMaskInfo(false);
   this.SavePrevMaskValue();
  } else {
   this.SetValue(value);
  }
 },
 SelectAll: function() {
  this.SetSelection(0, -1, false);
 },
 SetCaretPosition: function(pos) {
  var inputElement = this.GetInputElement();
  ASPx.Selection.SetCaretPosition(inputElement, pos);
 },
 SetSelection: function(startPos, endPos, scrollToSelection) { 
  var inputElement = this.GetInputElement();
  ASPx.Selection.Set(inputElement, startPos, endPos, scrollToSelection);
 },
 ChangeEnabledAttributes: function(enabled){
  var inputElement = this.GetInputElement();
  if(inputElement){
   this.ChangeInputEnabledAttributes(inputElement, ASPx.Attr.ChangeAttributesMethod(enabled), enabled);
   if(this.specialKeyboardHandlingUsed)
    this.ChangeSpecialInputEnabledAttributes(inputElement, ASPx.Attr.ChangeEventsMethod(enabled));
   this.ChangeInputEnabled(inputElement, enabled, this.readOnly);
  }
 },
 ChangeEnabledStateItems: function(enabled){
  if(!this.isNative) {
   var sc = ASPx.GetStateController();
   sc.SetElementEnabled(this.GetMainElement(), enabled);
   sc.SetElementEnabled(this.GetInputElement(), enabled);
  }
 },
 ChangeInputEnabled: function(element, enabled, readOnly) {
  if(this.UseReadOnlyForDisabled())
   element.readOnly = !enabled || readOnly;
  else
   element.disabled = !enabled;
 },
 ChangeInputEnabledAttributes: function(element, method, enabled) {
  var ieTabIndexFix = enabled && ASPx.Browser.IE && element.setAttribute && ASPx.Attr.IsExistsAttribute(element, "savedtabIndex");
  method(element, "tabIndex");
  if(!enabled) element.tabIndex = -1;
  if(ieTabIndexFix) { 
   window.setTimeout(function() {
    if(element && element.parentNode)
     element.parentNode.replaceChild(element, element); 
   }, 0);
  }
  method(element, "onclick");
  if(!this.NeedFocusCorrectionWhenDisabled())
   method(element, "onfocus");
  method(element, "onblur");
  method(element, "onkeydown");
  method(element, "onkeypress");
  method(element, "onkeyup");
 },
 UseReadOnlyForDisabled: function() {
  return (ASPx.Browser.IE && ASPx.Browser.Version < 10) && !this.isNative;
 },
 NeedFocusCorrectionWhenDisabled: function(){
  return (ASPx.Browser.IE && ASPx.Browser.Version < 10) && !this.isNative;
 },
 OnPostFinalization: function(args) {
  if(this.GetEnabled() || !this.UseReadOnlyForDisabled() || args.isDXCallback)
   return;
  var inputElement = this.GetInputElement();
  if(inputElement) {
   var inputDisabled = inputElement.disabled;
   inputElement.disabled = true;
   window.setTimeout(function() {
    inputElement.disabled = inputDisabled;
   }.aspxBind(this), 0);
  }
 }
});
MaskValidationPattern = ASPx.CreateClass(ASPx.ValidationPattern, {
 constructor: function(errorText, maskInfo) {
  this.constructor.prototype.constructor.call(this, errorText);
  this.maskInfo = maskInfo;
 },
 EvaluateIsValid: function(value) {
  return this.maskInfo.IsValid();
 }
});
ASPx.Ident.IsASPxClientTextEdit = function(obj) {
 return !!obj.isASPxClientTextEdit;
};
var ASPxClientTextBoxBase = ASPx.CreateClass(ASPxClientTextEdit, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.sizingConfig.allowSetHeight = false;
  this.sizingConfig.adjustControl = true;
 }
});
var ASPxClientTextBox = ASPx.CreateClass(ASPxClientTextBoxBase, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.isASPxClientTextBox = true;
 }
});
ASPxClientTextBox.Cast = ASPxClientControl.Cast;
ASPx.Ident.IsASPxClientTextBox = function(obj) {
 return !!obj.isASPxClientTextBox;
};
var ASPxClientMemo = ASPx.CreateClass(ASPxClientTextEdit, { 
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);        
  this.isASPxClientMemo = true;
  this.raiseValueChangedOnEnter = false;
  this.maxLength = 0;
  this.pasteTimerID = -1;
  this.pasteTimerActivatorCount = 0;
 },
 Initialize: function() {
  ASPxClientTextEdit.prototype.Initialize.call(this);
  this.SaveChangedValue();
  this.maxLengthRestricted = this.maxLength > 0;
 },
 CutString: function() {
  var text = this.GetText();
  if(text.length > this.maxLength) {
   text = text.substring(0, this.maxLength);
   this.SetText(text);
  }
 },
 EventKeyCodeChangesTheInput: function(evt){
  if(ASPx.IsPasteShortcut(evt))
   return true;
  else if(evt.ctrlKey)
   return false;
  var keyCode = ASPx.Evt.GetKeyCode(evt);
  var isSystemKey = ASPx.Key.Windows <= keyCode && keyCode <= ASPx.Key.ContextMenu;
  var isFKey = ASPx.Key.F1 <= keyCode && keyCode <= 127; 
  return ASPx.Key.Delete < keyCode && !isSystemKey && !isFKey || keyCode == ASPx.Key.Enter || keyCode == ASPx.Key.Space;
 },
 OnTextChangingCheck: function() {
  if(this.maxLengthRestricted)  
   this.CutString(); 
 },
 StartTextChangingTimer: function() {
  if(this.maxLengthRestricted) {
   if(this.pasteTimerActivatorCount == 0) 
    this.SetTextChangingTimer();
   this.pasteTimerActivatorCount ++;
  }
 },
 EndTextChangingTimer: function() {
  if(this.maxLengthRestricted) {
   this.pasteTimerActivatorCount --;
   if(this.pasteTimerActivatorCount == 0) 
    this.ClearTextChangingTimer();
  }
 },
 CollapseEditor: function() {
  if(!this.IsAdjustmentRequired()) return;
  var mainElement = this.GetMainElement();
  var inputElement = this.GetInputElement();
  if(!ASPx.IsExistsElement(mainElement) || !ASPx.IsExistsElement(inputElement))
   return;
  ASPxClientTextEdit.prototype.CollapseEditor.call(this);
  var mainElementCurStyle = ASPx.GetCurrentStyle(mainElement);
  if(this.heightCorrectionRequired && mainElement && inputElement) {
   if(mainElement.style.height == "100%" || mainElementCurStyle.height == "100%") {
    mainElement.style.height = "0";
    mainElement.wasCollapsed = true;
   }
   inputElement.style.height = "0";
  }
 },
 CorrectEditorHeight: function() {
  var mainElement = this.GetMainElement();
  if(mainElement.wasCollapsed) {
   mainElement.wasCollapsed = null;
   ASPx.SetOffsetHeight(mainElement, ASPx.GetClearClientHeight(ASPx.FindOffsetParent(mainElement)));
  }
  if(!this.isNative) {
   var inputElement = this.GetInputElement();
   var inputClearClientHeight = ASPx.GetClearClientHeight(ASPx.FindOffsetParent(inputElement));
   if(ASPx.Browser.IE) {
    inputClearClientHeight -= 2;
    var calculatedMainElementStyle = ASPx.GetCurrentStyle(mainElement);
    inputClearClientHeight += ASPx.PxToInt(calculatedMainElementStyle.borderTopWidth) + ASPx.PxToInt(calculatedMainElementStyle.borderBottomWidth);
   }
   if(inputClearClientHeight < memoMinHeight)
    inputClearClientHeight = memoMinHeight;
   ASPx.SetOffsetHeight(inputElement, inputClearClientHeight);
   mainElement.style.height = "100%";
   var inputParentOffsetHeight = ASPx.GetClearClientHeight(ASPx.FindOffsetParent(inputElement));
   if(inputParentOffsetHeight != inputClearClientHeight) {
    ASPx.SetOffsetHeight(inputElement, inputParentOffsetHeight);
   }
  }
 },
 SetWidth: function(width) {
  this.constructor.prototype.SetWidth.call(this, width);
  if(ASPx.Browser.IE)
   this.AdjustControl();
 },
 SetHeight: function(height) {
  var textarea = this.GetInputElement();
  textarea.style.height = "1px";
  this.constructor.prototype.SetHeight.call(this, height);
  textarea.style.height = ASPx.GetClearClientHeight(this.GetMainElement()) - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(textarea) + "px";
 },
 ClearErrorFrameElementsStyles: function() {
  var textarea = this.GetInputElement();
  if(!textarea)
   return;
  var scrollBarPosition = textarea.scrollTop;
  ASPxClientTextEdit.prototype.ClearErrorFrameElementsStyles.call(this);
  if(ASPx.Browser.Firefox)
   textarea.scrollTop = scrollBarPosition;
 },
 OnMouseOver: function() {
  this.StartTextChangingTimer();
 },  
 OnMouseOut: function() {
  this.EndTextChangingTimer();
 },   
 OnFocus: function() {  
  this.StartTextChangingTimer();
  ASPxClientEdit.prototype.OnFocus.call(this);
 },
 OnLostFocus: function() {
  this.EndTextChangingTimer();
  ASPxClientEdit.prototype.OnLostFocus.call(this);
 },
 OnKeyDown: function(evt) { 
  if(this.NeedPreventBrowserUndoBehaviour(evt))
   return ASPx.Evt.PreventEvent(evt);
  if(this.maxLengthRestricted){
   var selection = ASPx.Selection.GetInfo(this.GetInputElement()); 
   var noCharToReplace = selection.startPos == selection.endPos;
   if(this.GetText().length >= this.maxLength && noCharToReplace && this.EventKeyCodeChangesTheInput(evt)) {
    return ASPx.Evt.PreventEvent(evt);
   }
  }
  ASPxClientEdit.prototype.OnKeyDown.call(this, evt);
 },
 SetTextChangingTimer: function() {
  this.pasteTimerID = ASPx.Timer.SetControlBoundInterval(this.OnTextChangingCheck, this, ASPx.PasteCheckInterval);
 },
 ClearTextChangingTimer: function() {
  this.pasteTimerID = ASPx.Timer.ClearInterval(this.pasteTimerID);
 }
});
ASPxClientMemo.Cast = ASPxClientControl.Cast;
ASPx.Ident.IsASPxClientMemo = function(obj) {
 return !!obj.isASPxClientMemo;
};
var CLEAR_BUTTON_INDEX = -100;
var HIDE_CONTENT_CSS_CLASS_NAME = "dxHideContent";
var setContentVisibility = function(clearButtonElement, value) {
 var action = value ? ASPx.RemoveClassNameFromElement : ASPx.AddClassNameToElement;
 action(clearButtonElement, HIDE_CONTENT_CSS_CLASS_NAME);
};
var CLEAR_BUTTON_DISPLAY_MODE = {
 AUTO: 'Auto',
 ALWAYS: 'Always',
 NEVER: 'Never',
 ON_HOVER: 'OnHover'
};
var ASPxClientButtonEditBase = ASPx.CreateClass(ASPxClientTextBoxBase, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);        
  this.allowUserInput = true;
  this.isValueChanging = false;
  this.allowMouseWheel = true;
  this.isMouseOver = false;
  this.buttonCount = 0;
  this.emptyValueMaskDisplayText = "";
  this.clearButtonDisplayMode = CLEAR_BUTTON_DISPLAY_MODE.AUTO;
  this.forceShowClearButtonAlways = false;
  this.ButtonClick = new ASPxClientEvent();
 },
 Initialize: function() {
  ASPxClientTextBoxBase.prototype.Initialize.call(this);
  this.EnsureEmptyValueMaskDisplayText();
  if(this.HasClearButton())
   this.InitializeClearButton();
 },
 InlineInitialize: function() {
  ASPxClientTextBoxBase.prototype.InlineInitialize.call(this);
  if(this.clearButtonDisplayMode === CLEAR_BUTTON_DISPLAY_MODE.AUTO) {
   this.clearButtonDisplayMode = this.IsClearButtonVisibleAuto() || this.forceShowClearButtonAlways ?
    CLEAR_BUTTON_DISPLAY_MODE.ALWAYS : CLEAR_BUTTON_DISPLAY_MODE.NEVER;
  }
  this.EnsureClearButtonVisibility();
 },
 InitializeClearButton: function() {
  if(this.clearButtonDisplayMode === CLEAR_BUTTON_DISPLAY_MODE.ON_HOVER) {
   var mainElement = this.GetMainElement();
   ASPx.Evt.AttachMouseEnterToElement(mainElement, this.OnMouseOver.aspxBind(this), this.OnMouseOut.aspxBind(this));
  }
 },
 IsClearButtonVisibleAuto: function() {
  return ASPx.Browser.MobileUI;
 },
 EnsureEmptyValueMaskDisplayText: function() {
  if(this.maskInfo && this.HasClearButton()) {
   var savedText = this.maskInfo.GetText();
   this.maskInfo.SetText("");
   this.emptyValueMaskDisplayText = this.maskInfo.GetText();
   this.maskInfo.SetText(savedText);
  }
 },
 GetButton: function(number) {
  return this.GetChildElement("B" + number);
 },
 SetButtonVisible: function(number, value) {
  var button = this.GetButton(number);
  if(!button)
   return;
  var isAlwaysShownClearButton = number === CLEAR_BUTTON_INDEX && this.clearButtonDisplayMode === CLEAR_BUTTON_DISPLAY_MODE.ALWAYS;
  var visibilityModifier = isAlwaysShownClearButton ? setContentVisibility : ASPx.SetElementDisplay;
  visibilityModifier(button, value);
 },
 GetButtonVisible: function(number) {
  var button = this.GetButton(number);
  if(number === CLEAR_BUTTON_INDEX && this.clearButtonDisplayMode === CLEAR_BUTTON_DISPLAY_MODE.ALWAYS)
   return button && !ASPx.ElementHasCssClass(button, HIDE_CONTENT_CSS_CLASS_NAME);
  return button && ASPx.IsElementVisible(button);
 },
 ProcessInternalButtonClick: function(buttonIndex) {
  return false;
 },
 OnButtonClick: function(number) {
  var processOnServer = this.RaiseButtonClick(number);
  if(!this.ProcessInternalButtonClick(number) && processOnServer)
   this.SendPostBack('BC:' + number);
 },
 GetLastSuccesfullValue: function() {
  return this.lastChangedValue;
 },
 OnClear: function() {
  this.ClearEditorValueAndForceOnChange();
  this.ForceRefocusEditor(null, true);
  window.setTimeout(this.EnsureClearButtonVisibility.aspxBind(this), 0);
 },
 ClearEditorValueAndForceOnChange: function() {
  if(this.readOnly || !this.GetButtonVisible(CLEAR_BUTTON_INDEX))
   return;
  var raiseOnChange = this.ClearEditorValueByClearButton();
  if(raiseOnChange)
   this.ForceStandardOnChange();
 },
 ClearEditorValueByClearButton: function() {
  var prevValue = this.GetLastSuccesfullValue();
  this.ClearEditorValueByClearButtonCore();
  return prevValue !== this.GetValue();
 },
 ClearEditorValueByClearButtonCore: function() {
  this.Clear();
  this.GetInputElement().value = '';
 },
 ForceStandardOnChange: function() {
  this.forceValueChanged = true;
  this.RaiseStandardOnChange();
  this.forceValueChanged = false;
 },
 IsValueChangeForced: function() {
  return this.forceValueChanged || ASPxClientTextBoxBase.prototype.IsValueChangeForced.call(this);
 },
 IsValueChanging: function() { return this.isValueChanging; },
 StartValueChanging: function() { this.isValueChanging = true; },
 EndValueChanging: function() { this.isValueChanging = false; },
 IsClearButtonElement: function(element) {
  return ASPx.GetIsParent(this.GetClearButton(), element);
 },
 OnFocusCore: function() {
  ASPxClientTextBoxBase.prototype.OnFocusCore.call(this);
  this.EnsureClearButtonVisibility();
 },
 OnLostFocusCore: function() {
  ASPxClientTextBoxBase.prototype.OnLostFocusCore.call(this);
  this.EnsureClearButtonVisibility();
 },
 GetClearButton: function() {
  return this.GetButton(CLEAR_BUTTON_INDEX);
 },
 HasClearButton: function() {
  return !!this.GetClearButton();
 },
 RequireShowClearButton: function() {
  if(!this.clientEnabled || !this.HasClearButton() || this.clearButtonDisplayMode === CLEAR_BUTTON_DISPLAY_MODE.NEVER)
   return false;
  var isFocused = this.IsFocused();
  if(!isFocused && !this.isMouseOver && this.clearButtonDisplayMode !== CLEAR_BUTTON_DISPLAY_MODE.ALWAYS)
   return false;
  if(isFocused)
   return this.RequireShowClearButtonCore();
  return !this.IsNullState();
 },
 IsFocused: function() {
  return this === ASPxClientEdit.GetFocusedEditor();
 },
 IsNullState: function() {
  return this.IsNull(this.GetValue());
 },
 RequireShowClearButtonCore: function() {
  var inputText = this.GetInputElement().value;
  return inputText !== this.GetEmptyValueDisplayText();
 },
 GetEmptyValueDisplayText: function() { 
  return this.maskInfo ? this.emptyValueMaskDisplayText : "";
 },
 EnsureClearButtonVisibility: function() {
  this.SetButtonVisible(CLEAR_BUTTON_INDEX, this.RequireShowClearButton());
 },
 OnMouseOver: function() {
  this.isMouseOver = true;
  this.EnsureClearButtonVisibility();
 },
 OnMouseOut: function() {
  this.isMouseOver = false;
  this.EnsureClearButtonVisibility();
 },
 OnKeyPress: function(evt) {
  if(this.allowUserInput)
   ASPxClientTextBoxBase.prototype.OnKeyPress.call(this, evt);
 },
 OnKeyEventEnd: function(evt, withDelay) {
  ASPxClientTextBoxBase.prototype.OnKeyEventEnd.call(this, evt, withDelay);
  this.EnsureClearButtonVisibility();
 },
 RaiseButtonClick: function(number){
  var processOnServer = this.autoPostBack || this.IsServerEventAssigned("ButtonClick");
  if(!this.ButtonClick.IsEmpty()){
   var args = new ASPxClientButtonEditClickEventArgs(processOnServer, number);
   this.ButtonClick.FireEvent(this, args);
   processOnServer = args.processOnServer;
  }
  return processOnServer;
 },
 ChangeEnabledAttributes: function(enabled){
  ASPxClientTextEdit.prototype.ChangeEnabledAttributes.call(this, enabled);
  for(var i = 0; i < this.buttonCount; i++){
   var element = this.GetButton(i);
   if(element) 
    this.ChangeButtonEnabledAttributes(element, ASPx.Attr.ChangeAttributesMethod(enabled));
  }
 },
 ChangeEnabledStateItems: function(enabled){
  ASPxClientTextEdit.prototype.ChangeEnabledStateItems.call(this, enabled);
  for(var i = 0; i < this.buttonCount; i++){
   var element = this.GetButton(i);
   if(element) 
    ASPx.GetStateController().SetElementEnabled(element, enabled);
  }
 },
 ChangeButtonEnabledAttributes: function(element, method){
  method(element, "onclick");
  method(element, "ondblclick");
  method(element, "on" + ASPx.TouchUIHelper.touchMouseDownEventName);
  method(element, "on" + ASPx.TouchUIHelper.touchMouseUpEventName);
 },
 ChangeInputEnabled: function(element, enabled, readOnly) {
  ASPxClientTextEdit.prototype.ChangeInputEnabled.call(this, element, enabled, readOnly || !this.allowUserInput);
 },
 SetValue: function(value) {
  ASPxClientTextEdit.prototype.SetValue.call(this, value);
  if(!this.IsFocused())
   this.EnsureClearButtonVisibility();
 }
});
var ASPxClientButtonEdit = ASPx.CreateClass(ASPxClientButtonEditBase, {
});
ASPxClientButtonEdit.Cast = ASPxClientControl.Cast;
var ASPxClientButtonEditClickEventArgs = ASPx.CreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(processOnServer, buttonIndex){
  this.constructor.prototype.constructor.call(this, processOnServer);
  this.buttonIndex = buttonIndex;
 }
});
var ASPxClientTextEditHelpTextHAlign = {
 Left: "Left",
 Right: "Right",
 Center: "Center"
};
var ASPxClientTextEditHelpTextVAlign = {
 Top: "Top",
 Bottom: "Bottom",
 Middle: "Middle"
};
var ASPxClientTextEditHelpTextDisplayMode = {
 Inline: "Inline",
 Popup: "Popup"
};
var ASPxClientTextEditHelpTextConsts = {
 VERTICAL_ORIENTATION_CLASS_NAME: "dxeVHelpTextSys",
 HORIZONTAL_ORIENTATION_CLASS_NAME: "dxeHHelpTextSys"
};
var ASPxClientTextEditHelpText = ASPx.CreateClass(null, {
 constructor: function (editor, helpTextStyle, helpText, position, hAlign, vAlign, margins, animationEnabled, helpTextDisplayMode) {
  this.hAlign = hAlign;
  this.vAlign = vAlign;
  this.animationEnabled = animationEnabled;
  this.displayMode = helpTextDisplayMode;
  this.editor = editor;
  this.editorMainElement = editor.GetMainElement();
  this.margins = margins ? { Top: margins[0], Right: margins[1], Bottom: margins[2], Left: margins[3] } : null;
  this.defaultMargins = { Top: 10, Right: 10, Bottom: 10, Left: 10 };
  this.position = position;
  this.helpTextElement = this.createHelpTextElement();
  this.setHelpTextZIndex(true);
  this.prepareHelpTextElement(helpTextStyle, helpText);
 },
 getRows: function (table) {
  return ASPx.GetChildNodesByTagName(table, "TR");
 },
 getCells: function (row) {
  return ASPx.GetChildNodesByTagName(row, "TD");
 },
 getCellByIndex: function(row, cellIndex) {
  return this.getCells(row)[cellIndex];
 },
 getCellIndex: function(row, cell) {
  var cells = this.getCells(row);
  for(var i = 0; i < cells.length; i++) {
   if(cells[i] === cell)
    return i;
  }
 },
 isHorizontal: function(position) {
  return position === ASPx.Position.Left || position === ASPx.Position.Right;
 },
 isVertical: function (position) {
  return position === ASPx.Position.Top || position === ASPx.Position.Bottom;
 },
 createEmptyCell: function(assignClassName) {
  var cell = document.createElement("TD");
  if(assignClassName)
   cell.className = "dxeFakeEmptyCell";
  return cell;
 },
 addHelpTextCellToExternalTableWithTwoCells: function (captionCell, errorCell, helpTextCell, errorTableBody, tableRows) {
  var captionPosition = this.editor.captionPosition;
  var errorCellPosition = this.editor.errorCellPosition;
  var helpTextRow = this.isVertical(this.position) ? document.createElement("TR") : null;
  if(captionPosition === ASPx.Position.Left && this.position === ASPx.Position.Left && this.isHorizontal(errorCellPosition))
   captionCell.parentNode.insertBefore(helpTextCell, captionCell.nextSibling);
  if(captionPosition === ASPx.Position.Right && this.position === ASPx.Position.Right && this.isHorizontal(errorCellPosition))
   captionCell.parentNode.insertBefore(helpTextCell, captionCell);
  if(captionPosition === ASPx.Position.Left && this.position === ASPx.Position.Right && this.isHorizontal(errorCellPosition))
   tableRows[0].appendChild(helpTextCell);
  if(captionPosition === ASPx.Position.Right && this.position === ASPx.Position.Left && this.isHorizontal(errorCellPosition))
   tableRows[0].insertBefore(helpTextCell, tableRows[0].childNodes[0]);
  if(captionPosition === ASPx.Position.Top && this.position === ASPx.Position.Bottom && this.isVertical(errorCellPosition)) {
   helpTextRow.appendChild(helpTextCell);
   errorTableBody.appendChild(helpTextRow);
  }
  if(captionPosition === ASPx.Position.Bottom && this.position === ASPx.Position.Top && this.isVertical(errorCellPosition)) {
   helpTextRow.appendChild(helpTextCell);
   errorTableBody.insertBefore(helpTextRow, errorTableBody.childNodes[0]);
  }
  if(captionPosition === ASPx.Position.Top && this.position === ASPx.Position.Top && this.isVertical(errorCellPosition)) {
   helpTextRow.appendChild(helpTextCell);
   errorTableBody.insertBefore(helpTextRow, captionCell.parentNode.nextSibling);
  }
  if(captionPosition === ASPx.Position.Bottom && this.position === ASPx.Position.Bottom && this.isVertical(errorCellPosition)) {
   helpTextRow.appendChild(helpTextCell);
   errorTableBody.insertBefore(helpTextRow, captionCell.parentNode);
  }
  if(captionPosition === ASPx.Position.Right && this.position === ASPx.Position.Top && this.isVertical(errorCellPosition)) {
   helpTextRow.appendChild(helpTextCell);
   helpTextRow.appendChild(this.createEmptyCell());
   errorTableBody.insertBefore(helpTextRow, errorTableBody.childNodes[0]);
  }
  if(this.position === ASPx.Position.Bottom) {
   if(captionPosition === ASPx.Position.Right && errorCellPosition === ASPx.Position.Top || captionPosition === ASPx.Position.Top && errorCellPosition === ASPx.Position.Right) {
    helpTextRow.appendChild(helpTextCell);
    helpTextRow.appendChild(this.createEmptyCell());
    errorTableBody.appendChild(helpTextRow);
   }
  }
  if(captionPosition === ASPx.Position.Left && this.position === ASPx.Position.Top && this.isVertical(errorCellPosition)) {
   helpTextRow.appendChild(this.createEmptyCell());
   helpTextRow.appendChild(helpTextCell);
   errorTableBody.insertBefore(helpTextRow, errorTableBody.childNodes[0]);
  }
  if(captionPosition === ASPx.Position.Left && this.position === ASPx.Position.Bottom && this.isVertical(errorCellPosition)) {
   helpTextRow.appendChild(this.createEmptyCell());
   helpTextRow.appendChild(helpTextCell);
   errorTableBody.appendChild(helpTextRow);
  }
  if(this.position === ASPx.Position.Right) {
   if(captionPosition === ASPx.Position.Top && errorCellPosition === ASPx.Position.Left || captionPosition === ASPx.Position.Left && errorCellPosition === ASPx.Position.Top
    || captionPosition === ASPx.Position.Top && errorCellPosition === ASPx.Position.Right) {
    tableRows[1].appendChild(helpTextCell);
    tableRows[0].appendChild(this.createEmptyCell());
   }
   if(captionPosition === ASPx.Position.Left && errorCellPosition === ASPx.Position.Bottom || captionPosition === ASPx.Position.Bottom && errorCellPosition === ASPx.Position.Left) {
    tableRows[0].appendChild(helpTextCell);
    tableRows[1].appendChild(this.createEmptyCell());
   }
  }
  if(this.position === ASPx.Position.Left) {
   if(captionPosition === ASPx.Position.Right && errorCellPosition === ASPx.Position.Top || captionPosition === ASPx.Position.Top && errorCellPosition === ASPx.Position.Right
    || captionPosition === ASPx.Position.Top && errorCellPosition === ASPx.Position.Left) {
    tableRows[1].insertBefore(helpTextCell, tableRows[1].childNodes[0]);
    tableRows[0].insertBefore(this.createEmptyCell(), tableRows[0].childNodes[0]);
   }
   if(captionPosition === ASPx.Position.Bottom && errorCellPosition === ASPx.Position.Top || captionPosition === ASPx.Position.Top && errorCellPosition === ASPx.Position.Bottom) {
    tableRows[1].insertBefore(helpTextCell, tableRows[1].childNodes[0]);
    tableRows[0].insertBefore(this.createEmptyCell(errorCellPosition === ASPx.Position.Top), tableRows[0].childNodes[0]);
    tableRows[2].insertBefore(this.createEmptyCell(errorCellPosition !== ASPx.Position.Top), tableRows[2].childNodes[0]);
   }
   if(captionPosition === ASPx.Position.Top && errorCellPosition === ASPx.Position.Top) {
    tableRows[2].insertBefore(helpTextCell, tableRows[2].childNodes[0]);
    tableRows[0].insertBefore(this.createEmptyCell(false), tableRows[0].childNodes[0]);
    tableRows[1].insertBefore(this.createEmptyCell(true), tableRows[1].childNodes[0]);
   }
   if(captionPosition === ASPx.Position.Bottom && errorCellPosition === ASPx.Position.Bottom) {
    tableRows[0].insertBefore(helpTextCell, tableRows[0].childNodes[0]);
    tableRows[1].insertBefore(this.createEmptyCell(true), tableRows[1].childNodes[0]);
    tableRows[2].insertBefore(this.createEmptyCell(false), tableRows[2].childNodes[0]);
   }
   if(captionPosition === ASPx.Position.Bottom && errorCellPosition === ASPx.Position.Left || captionPosition === ASPx.Position.Right && errorCellPosition === ASPx.Position.Bottom
    || captionPosition === ASPx.Position.Bottom && errorCellPosition === ASPx.Position.Right) {
    tableRows[0].insertBefore(helpTextCell, tableRows[0].childNodes[0]);
    tableRows[1].insertBefore(this.createEmptyCell(), tableRows[1].childNodes[0]);
   }
   if(captionPosition === ASPx.Position.Left && this.isVertical(errorCellPosition)) {
    captionCell.parentNode.insertBefore(helpTextCell, captionCell.nextSibling);
    var emptyCellParentRow = errorCellPosition === ASPx.Position.Top ? tableRows[0] : tableRows[1];
    var helpTextCellIndex = this.getCellIndex(helpTextCell.parentNode, helpTextCell);
    emptyCellParentRow.insertBefore(this.createEmptyCell(), this.getCellByIndex(emptyCellParentRow, helpTextCellIndex));
   }
  }
  if(this.position === ASPx.Position.Right) {
   if(captionPosition === ASPx.Position.Bottom && errorCellPosition === ASPx.Position.Top || captionPosition === ASPx.Position.Top && errorCellPosition === ASPx.Position.Bottom) {
    tableRows[1].appendChild(helpTextCell);
    tableRows[0].appendChild(this.createEmptyCell(errorCellPosition === ASPx.Position.Top));
    tableRows[2].appendChild(this.createEmptyCell(errorCellPosition !== ASPx.Position.Top));
   }
   if(captionPosition === ASPx.Position.Top && errorCellPosition === ASPx.Position.Top) {
    tableRows[2].appendChild(helpTextCell);
    tableRows[0].appendChild(this.createEmptyCell(false));
    tableRows[1].appendChild(this.createEmptyCell(true));
   }
   if(captionPosition === ASPx.Position.Bottom && errorCellPosition === ASPx.Position.Bottom) {
    tableRows[0].appendChild(helpTextCell);
    tableRows[1].appendChild(this.createEmptyCell(true));
    tableRows[2].appendChild(this.createEmptyCell(false));
   }
   if(captionPosition === ASPx.Position.Bottom && errorCellPosition === ASPx.Position.Right) {
    tableRows[0].appendChild(helpTextCell);
    tableRows[1].appendChild(this.createEmptyCell());
   }
   if(captionPosition === ASPx.Position.Right && this.isVertical(errorCellPosition)) {
    captionCell.parentNode.insertBefore(helpTextCell, captionCell);
    var emptyCellParentRow = errorCellPosition === ASPx.Position.Top ? tableRows[0] : tableRows[1];
    var helpTextCellIndex = this.getCellIndex(helpTextCell.parentNode, helpTextCell);
    emptyCellParentRow.insertBefore(this.createEmptyCell(), this.getCellByIndex(emptyCellParentRow, helpTextCellIndex));
   }
  }
  if(captionPosition === ASPx.Position.Top && this.position === ASPx.Position.Top && this.isHorizontal(errorCellPosition)) {
   if(errorCellPosition === ASPx.Position.Left) {
    helpTextRow.appendChild(this.createEmptyCell(true));
    helpTextRow.appendChild(helpTextCell);
   }
   else {
    helpTextRow.appendChild(helpTextCell);
    helpTextRow.appendChild(this.createEmptyCell());
   }
   errorTableBody.insertBefore(helpTextRow, captionCell.parentNode.nextSibling);
  }
  if(captionPosition === ASPx.Position.Bottom && this.position === ASPx.Position.Top && this.isHorizontal(errorCellPosition)) {
   if(errorCellPosition === ASPx.Position.Left) {
    helpTextRow.appendChild(this.createEmptyCell(true));
    helpTextRow.appendChild(helpTextCell);
   }
   else {
    helpTextRow.appendChild(helpTextCell);
    helpTextRow.appendChild(this.createEmptyCell());
   }
   errorTableBody.insertBefore(helpTextRow, errorTableBody.childNodes[0]);
  }
  if(captionPosition === ASPx.Position.Bottom && this.position === ASPx.Position.Bottom && this.isHorizontal(errorCellPosition)) {
   if(errorCellPosition === ASPx.Position.Left) {
    helpTextRow.appendChild(this.createEmptyCell(true));
    helpTextRow.appendChild(helpTextCell);
   }
   else {
    helpTextRow.appendChild(helpTextCell);
    helpTextRow.appendChild(this.createEmptyCell());
   }
   errorTableBody.insertBefore(helpTextRow, captionCell.parentNode);
  }
  if(captionPosition === ASPx.Position.Top && this.position === ASPx.Position.Bottom && errorCellPosition === ASPx.Position.Left) {
   helpTextRow.appendChild(this.createEmptyCell(true));
   helpTextRow.appendChild(helpTextCell);
   errorTableBody.appendChild(helpTextRow);
  }
  if(captionPosition === ASPx.Position.Right && this.position === ASPx.Position.Bottom && errorCellPosition === ASPx.Position.Bottom) {
   helpTextRow.appendChild(helpTextCell);
   helpTextRow.appendChild(this.createEmptyCell());
   errorTableBody.appendChild(helpTextRow);
  }
  if(this.position === ASPx.Position.Bottom) {
   if(captionPosition === ASPx.Position.Left && errorCellPosition === ASPx.Position.Right || captionPosition === ASPx.Position.Right && errorCellPosition === ASPx.Position.Left) {
    helpTextRow.appendChild(this.createEmptyCell(errorCellPosition !== ASPx.Position.Right));
    helpTextRow.appendChild(helpTextCell);
    helpTextRow.appendChild(this.createEmptyCell(errorCellPosition === ASPx.Position.Right));
    errorTableBody.appendChild(helpTextRow);
   }
   if(captionPosition === ASPx.Position.Left && errorCellPosition === ASPx.Position.Left) {
    helpTextRow.appendChild(this.createEmptyCell(false));
    helpTextRow.appendChild(this.createEmptyCell(true));
    helpTextRow.appendChild(helpTextCell);
    errorTableBody.appendChild(helpTextRow);
   }
   if(captionPosition === ASPx.Position.Right && errorCellPosition === ASPx.Position.Right) {
    helpTextRow.appendChild(helpTextCell);
    helpTextRow.appendChild(this.createEmptyCell(true));
    helpTextRow.appendChild(this.createEmptyCell(false));
    errorTableBody.appendChild(helpTextRow);
   }   
  }
  if(this.position === ASPx.Position.Top) {
   if(captionPosition === ASPx.Position.Left && errorCellPosition === ASPx.Position.Right || captionPosition === ASPx.Position.Right && errorCellPosition === ASPx.Position.Left) {
    helpTextRow.appendChild(this.createEmptyCell(errorCellPosition !== ASPx.Position.Right));
    helpTextRow.appendChild(helpTextCell);
    helpTextRow.appendChild(this.createEmptyCell(errorCellPosition === ASPx.Position.Right));
    errorTableBody.insertBefore(helpTextRow, errorTableBody.childNodes[0]);
   }
   if(captionPosition === ASPx.Position.Left && errorCellPosition === ASPx.Position.Left) {
    helpTextRow.appendChild(this.createEmptyCell(false));
    helpTextRow.appendChild(this.createEmptyCell(true));
    helpTextRow.appendChild(helpTextCell);
    errorTableBody.insertBefore(helpTextRow, errorTableBody.childNodes[0]);
   }
   if(captionPosition === ASPx.Position.Right && errorCellPosition === ASPx.Position.Right) {
    helpTextRow.appendChild(helpTextCell);
    helpTextRow.appendChild(this.createEmptyCell(true));
    helpTextRow.appendChild(this.createEmptyCell(false));
    errorTableBody.insertBefore(helpTextRow, errorTableBody.childNodes[0]);
   }
  }
 },
 addHelpTextCellToExternalTableWithErrorCell: function (errorCell, helpTextCell, errorTableBody, tableRows) {
  var errorCellPosition = this.editor.errorCellPosition;
  var helpTextRow = document.createElement("TR");
  if(this.position === ASPx.Position.Left && this.isHorizontal(errorCellPosition))
   tableRows[0].insertBefore(helpTextCell, tableRows[0].childNodes[0]);
  if(this.position === ASPx.Position.Right && this.isHorizontal(errorCellPosition))
   tableRows[0].appendChild(helpTextCell);
  if(this.position === ASPx.Position.Top && this.isVertical(errorCellPosition)) {
   helpTextRow.appendChild(helpTextCell);
   errorTableBody.insertBefore(helpTextRow, errorTableBody.childNodes[0]);
  }
  if(this.position === ASPx.Position.Bottom && this.isVertical(errorCellPosition)) {
   helpTextRow.appendChild(helpTextCell);
   errorTableBody.appendChild(helpTextRow);
  }
  if(errorCellPosition === ASPx.Position.Left && this.isVertical(this.position)) {
   helpTextRow.appendChild(this.createEmptyCell(true));
   helpTextRow.appendChild(helpTextCell);
   if(this.position === ASPx.Position.Top)
    errorTableBody.insertBefore(helpTextRow, errorTableBody.childNodes[0]);
   else
    errorTableBody.appendChild(helpTextRow);
  }
  if(errorCellPosition === ASPx.Position.Right && this.isVertical(this.position)) {
   helpTextRow.appendChild(helpTextCell);
   helpTextRow.appendChild(this.createEmptyCell(true));
   if(this.position === ASPx.Position.Top)
    errorTableBody.insertBefore(helpTextRow, errorTableBody.childNodes[0]);
   else
    errorTableBody.appendChild(helpTextRow);
  }
  if(this.position === ASPx.Position.Left && this.isVertical(errorCellPosition)) {
   var helpTextParentRowIndex = errorCellPosition === ASPx.Position.Top ? 1 : 0;
   var emptyCellRowIndex = helpTextParentRowIndex === 0 ? 1 : 0;
   tableRows[helpTextParentRowIndex].insertBefore(helpTextCell, tableRows[helpTextParentRowIndex].childNodes[0]);
   tableRows[emptyCellRowIndex].insertBefore(this.createEmptyCell(true), tableRows[emptyCellRowIndex].childNodes[0]);
  }
  if(this.position === ASPx.Position.Right && this.isVertical(errorCellPosition)) {
   var helpTextParentRowIndex = errorCellPosition === ASPx.Position.Top ? 1 : 0;
   var emptyCellRowIndex = helpTextParentRowIndex === 0 ? 1 : 0;
   tableRows[helpTextParentRowIndex].appendChild(helpTextCell);
   tableRows[emptyCellRowIndex].appendChild(this.createEmptyCell(true));
  }
 },
 addHelpTextCellToExternalTableWithCaption: function (captionCell, helpTextCell, errorTableBody, tableRows) {
  var captionPosition = this.editor.captionPosition;
  var helpTextRow = document.createElement("TR");
  if(captionPosition === ASPx.Position.Left && this.isVertical(this.position)) {
   helpTextRow.appendChild(this.createEmptyCell());
   helpTextRow.appendChild(helpTextCell);
   if(this.position === ASPx.Position.Top)
    errorTableBody.insertBefore(helpTextRow, errorTableBody.childNodes[0]);
   else
    errorTableBody.appendChild(helpTextRow);
  }
  if(this.position === ASPx.Position.Left && this.isVertical(captionPosition)) {
   var helpTextParentRowIndex = captionPosition === ASPx.Position.Top ? 1 : 0;
   var emptyCellParentRowIndex = helpTextParentRowIndex === 0 ? 1 : 0;
   tableRows[helpTextParentRowIndex].insertBefore(helpTextCell, tableRows[helpTextParentRowIndex].childNodes[0]);
   tableRows[emptyCellParentRowIndex].insertBefore(this.createEmptyCell(), tableRows[emptyCellParentRowIndex].childNodes[0]);
  }
  if(this.position === ASPx.Position.Right && this.isVertical(captionPosition)) {
   var helpTextParentRowIndex = captionPosition === ASPx.Position.Top ? 1 : 0;
   var emptyCellParentRowIndex = helpTextParentRowIndex === 0 ? 1 : 0;
   tableRows[helpTextParentRowIndex].appendChild(helpTextCell);
   tableRows[emptyCellParentRowIndex].appendChild(this.createEmptyCell());
  }
  if(captionPosition === ASPx.Position.Right && this.isVertical(this.position)) {
   helpTextRow.appendChild(helpTextCell);
   helpTextRow.appendChild(this.createEmptyCell());
   if(this.position === ASPx.Position.Top)
    errorTableBody.insertBefore(helpTextRow, errorTableBody.childNodes[0]);
   else
    errorTableBody.appendChild(helpTextRow);
  }
  if(this.isVertical(captionPosition) && this.isVertical(this.position)) {
   helpTextRow.appendChild(helpTextCell);
   if(captionPosition === ASPx.Position.Top && this.position === ASPx.Position.Top)
    errorTableBody.insertBefore(helpTextRow, captionCell.parentNode.nextSibling);
   if(captionPosition === ASPx.Position.Top && this.position === ASPx.Position.Bottom)
    errorTableBody.appendChild(helpTextRow);
   if(captionPosition === ASPx.Position.Bottom && this.position === ASPx.Position.Top)
    errorTableBody.insertBefore(helpTextRow, errorTableBody.childNodes[0]);
   if(captionPosition === ASPx.Position.Bottom && this.position === ASPx.Position.Bottom)
    errorTableBody.insertBefore(helpTextRow, captionCell.parentNode);
  }
  if(captionPosition === ASPx.Position.Left && this.position === ASPx.Position.Left)
   captionCell.parentNode.insertBefore(helpTextCell, captionCell.nextSibling);
  if(captionPosition === ASPx.Position.Right && this.position === ASPx.Position.Right)
   captionCell.parentNode.insertBefore(helpTextCell, captionCell);
  if(captionPosition === ASPx.Position.Left && this.position === ASPx.Position.Right)
   tableRows[0].appendChild(helpTextCell);
  if(captionPosition === ASPx.Position.Right && this.position === ASPx.Position.Left)
   tableRows[0].insertBefore(helpTextCell, tableRows[0].childNodes[0]);
 },
 addHelpTextCellToExternalTableWithEditorOnly: function (helpTextCell, errorTableBody, tableRows) {
  if(this.isHorizontal(this.position)) {
   if(this.position === ASPx.Position.Left)
    tableRows[0].insertBefore(helpTextCell, tableRows[0].childNodes[0]);
   else
    tableRows[0].appendChild(helpTextCell);
  }
  else {
   var helpTextRow = document.createElement("TR");
   helpTextRow.appendChild(helpTextCell);
   if(this.position === ASPx.Position.Top)
    errorTableBody.insertBefore(helpTextRow, errorTableBody.childNodes[0]);
   else
    errorTableBody.appendChild(helpTextRow);
  }
 },
 addHelpTextCellToExternalTable: function (errorTable, helpTextCell) {
  var errorTableBody = ASPx.GetNodeByTagName(errorTable, "TBODY", 0);
  var tableRows = this.getRows(errorTableBody);
  var captionCell = this.editor.GetCaptionCell();
  var errorCell = this.editor.GetErrorCell();
  if(captionCell) {
   if(errorCell)
    this.addHelpTextCellToExternalTableWithTwoCells(captionCell, errorCell, helpTextCell, errorTableBody, tableRows);
   else
    this.addHelpTextCellToExternalTableWithCaption(captionCell, helpTextCell, errorTableBody, tableRows);
  }
  else if(errorCell)
   this.addHelpTextCellToExternalTableWithErrorCell(errorCell, helpTextCell, errorTableBody, tableRows);
  else
   this.addHelpTextCellToExternalTableWithEditorOnly(helpTextCell, errorTableBody, tableRows);
 },
 createExternalTable: function () {
  var externalTable = document.createElement("TABLE");
  externalTable.id = this.editor.name + ASPx.EditElementSuffix.ExternalTable;
  externalTable.cellPadding = 0;
  externalTable.cellSpacing = 0;
  this.applyExternalTableStyle(externalTable);
  var editorWidth = this.editorMainElement.style.width;
  if(ASPx.IsPercentageSize(editorWidth)) {
   externalTable.style.width = editorWidth;
   this.editorMainElement.style.width = "100%";
   this.editor.width = "100%";
  }
  var externalTableBody = document.createElement("TBODY");
  var externalTableRow = document.createElement("TR");
  var externalTableCell = document.createElement("TD");
  externalTable.appendChild(externalTableBody);
  externalTableBody.appendChild(externalTableRow);
  externalTableRow.appendChild(externalTableCell);
  this.editorMainElement.parentNode.appendChild(externalTable);
  ASPx.ChangeElementContainer(this.editorMainElement, externalTableCell, true);
  return externalTable;
 },
 applyExternalTableStyle: function (externalTable) {
  var externalTableStyle = this.editor.externalTableStyle;
  if(externalTableStyle.length > 0) {
   this.applyStyleToElement(externalTable, externalTableStyle);
  }
 },
 applyStyleToElement: function(element, style) {
  element.className = style[0];
  if(style[1]) {
   var styleSheet = ASPx.GetCurrentStyleSheet();
   element.className += " " + ASPx.CreateImportantStyleRule(styleSheet, style[1]);
  }
 },
 createInlineHelpTextElement: function () {
  var helpTextElement = document.createElement("TD");
  var externalTable = this.editor.GetExternalTable();
  if(!externalTable)
   externalTable = this.createExternalTable();
  this.addHelpTextCellToExternalTable(externalTable, helpTextElement);
  return helpTextElement;
 },
 createPopupHelpTextElement: function () {
  var helpTextElement = document.createElement("DIV");
  document.body.appendChild(helpTextElement);
  ASPx.AnimationHelper.setOpacity(helpTextElement, 0);
  return helpTextElement;
 },
 createHelpTextElement: function () {
  return this.displayMode === ASPxClientTextEditHelpTextDisplayMode.Popup ?
   this.createPopupHelpTextElement() : this.createInlineHelpTextElement();
 },
 prepareHelpTextElement: function (helpTextStyle, helpText) {
  this.applyStyleToElement(this.helpTextElement, helpTextStyle);
  ASPx.SetInnerHtml(this.helpTextElement, "<SPAN>" + helpText + "</SPAN>");
  if(this.displayMode === ASPxClientTextEditHelpTextDisplayMode.Popup)
   this.updatePopupHelpTextPosition();
  else {
   var isVerticalOrientation = this.position === ASPx.Position.Top || this.position === ASPx.Position.Bottom;
   var orientationClassName = isVerticalOrientation ? ASPxClientTextEditHelpTextConsts.VERTICAL_ORIENTATION_CLASS_NAME :
    ASPxClientTextEditHelpTextConsts.HORIZONTAL_ORIENTATION_CLASS_NAME;
   this.helpTextElement.className += " " + orientationClassName;
   this.setInlineHelpTextElementAlign();
   ASPx.SetElementDisplay(this.helpTextElement, this.editor.clientVisible);
  }
 },
 setInlineHelpTextElementAlign: function() {
  var hAlignValue = "", vAlignValue = "";
  switch(this.hAlign) {
   case ASPxClientTextEditHelpTextHAlign.Left: hAlignValue = "left"; break;
   case ASPxClientTextEditHelpTextHAlign.Right: hAlignValue = "right"; break;
   case ASPxClientTextEditHelpTextHAlign.Center: hAlignValue = "center"; break;
  }
  switch(this.vAlign) {
   case ASPxClientTextEditHelpTextVAlign.Top: vAlignValue = "top"; break;
   case ASPxClientTextEditHelpTextVAlign.Bottom: vAlignValue = "bottom"; break;
   case ASPxClientTextEditHelpTextVAlign.Middle: vAlignValue = "middle"; break;
  }
  this.helpTextElement.style.textAlign = hAlignValue;
  this.helpTextElement.style.verticalAlign = vAlignValue;
 },
 getHelpTextMargins: function() {
  if(this.margins)
   return this.margins;
  var result = this.defaultMargins;
  if(this.position === ASPx.Position.Top || this.position === ASPx.Position.Bottom)
   result.Left = result.Right = 0;
  else
   result.Top = result.Bottom = 0;
  return result;
 },
 updatePopupHelpTextPosition: function (editorMainElement) {
  var editorWidth = this.editorMainElement.offsetWidth;
  var editorHeight = this.editorMainElement.offsetHeight;
  var helpTextWidth = this.helpTextElement.offsetWidth;
  var helpTextHeight = this.helpTextElement.offsetHeight;
  var editorX = ASPx.GetAbsoluteX(this.editorMainElement);
  var editorY = ASPx.GetAbsoluteY(this.editorMainElement);
  var helpTextX = 0, helpTextY = 0;
  var margins = this.getHelpTextMargins();
  if(this.position === ASPx.Position.Top || this.position === ASPx.Position.Bottom) {
   if(this.position === ASPx.Position.Top)
    helpTextY = editorY - margins.Bottom - helpTextHeight;
   else if(this.position === ASPx.Position.Bottom)
    helpTextY = editorY + editorHeight + margins.Top;
   if(this.hAlign === ASPxClientTextEditHelpTextHAlign.Left)
    helpTextX = editorX + margins.Left;
   else if(this.hAlign === ASPxClientTextEditHelpTextHAlign.Right)
    helpTextX = editorX + editorWidth - helpTextWidth - margins.Right;
   else if(this.hAlign === ASPxClientTextEditHelpTextHAlign.Center) {
    var editorCenterX = editorX + editorWidth / 2;
    var helpTextWidthWithMargins = helpTextWidth + margins.Left + margins.Right;
    helpTextX = editorCenterX - helpTextWidthWithMargins / 2 + margins.Left;
   }
  } else {
   if(this.position === ASPx.Position.Left)
    helpTextX = editorX - margins.Right - helpTextWidth;
   else if(this.position === ASPx.Position.Right)
    helpTextX = editorX + editorWidth + margins.Left;
   if(this.vAlign === ASPxClientTextEditHelpTextVAlign.Top)
    helpTextY = editorY + margins.Top;
   else if(this.vAlign === ASPxClientTextEditHelpTextVAlign.Bottom)
    helpTextY = editorY + editorHeight - helpTextHeight - margins.Bottom;
   else if(this.vAlign === ASPxClientTextEditHelpTextVAlign.Middle) {
    var editorCenterY = editorY + editorHeight / 2;
    var helpTextHeightWithMargins = helpTextHeight + margins.Top + margins.Bottom;
    helpTextY = editorCenterY - helpTextHeightWithMargins / 2 + margins.Top;
   }
  }
  helpTextX = helpTextX < 0 ? 0 : helpTextX;
  helpTextY = helpTextY < 0 ? 0 : helpTextY;
  ASPx.SetAbsoluteX(this.helpTextElement, helpTextX);
  ASPx.SetAbsoluteY(this.helpTextElement, helpTextY);
 },
 setHelpTextZIndex: function (hide) { 
  var newZIndex = 41998 * (hide ? -1 : 1);
  if(this.helpTextElement.style.zIndex != newZIndex)
   this.helpTextElement.style.zIndex = newZIndex;
 },
 hide: function () {
  if(this.displayMode === ASPxClientTextEditHelpTextDisplayMode.Inline) {
   ASPx.SetElementDisplay(this.helpTextElement, false);
  }
  else {
   this.animationEnabled ? ASPx.AnimationHelper.fadeOut(this.helpTextElement) :
    ASPx.AnimationHelper.setOpacity(this.helpTextElement, 0);
   this.setHelpTextZIndex(true);
  }
 },
 show: function () {
  if(this.displayMode === ASPxClientTextEditHelpTextDisplayMode.Inline) {
   ASPx.SetElementDisplay(this.helpTextElement, true);
  }
  else {
   this.updatePopupHelpTextPosition();
   this.animationEnabled ? ASPx.AnimationHelper.fadeIn(this.helpTextElement) :
    ASPx.AnimationHelper.setOpacity(this.helpTextElement, 1);
   this.setHelpTextZIndex(false);
  }
 }
});
var ASPxOutOfRangeWarningManager = ASPx.CreateClass(null, {
 constructor: function (editor, minValue, maxValue, defaultMinValue, defaultMaxValue, outOfRangeWarningElementPosition, valueFormatter) {
  this.editor = editor;
  this.outOfRangeWarningElementPosition = outOfRangeWarningElementPosition;
  this.minValue = minValue;
  this.maxValue = maxValue;
  this.defaultMinValue = defaultMinValue;
  this.defaultMaxValue = defaultMaxValue;
  this.minMaxValueFormatter = valueFormatter;
  this.animationDuration = 150;
  this.CreateOutOfRangeWarningElement();
 },
 SetMinValue: function (minValue) {
  this.minValue = minValue;
  this.UpdateOutOfRangeWarningElementText();
 },
 SetMaxValue: function (maxValue) {
  this.maxValue = maxValue;
  this.UpdateOutOfRangeWarningElementText();
 },
 CreateOutOfRangeWarningElement: function () {
  this.outOfRangeWarningElement = document.createElement("DIV");
  this.outOfRangeWarningElement.id = this.editor.name + "OutOfRWarn";
  ASPx.InsertElementAfter(this.outOfRangeWarningElement, this.editor.GetMainElement());
  ASPx.AnimationHelper.setOpacity(this.outOfRangeWarningElement, 0);
  this.outOfRangeWarningElement.className = this.editor.outOfRangeWarningClassName;
  this.UpdateOutOfRangeWarningElementText();
 },
 IsValueInRange: function (value) {
  return (!this.IsMinValueExists() || value >= this.minValue)
   && (!this.IsMaxValueExists() || value <= this.maxValue);
 },
 IsMinValueExists: function() {
  return ASPx.IsExists(this.minValue) && !isNaN(this.minValue) && this.minValue !== this.defaultMinValue;
 },
 IsMaxValueExists: function () {
  return ASPx.IsExists(this.maxValue) && !isNaN(this.maxValue) && this.maxValue !== this.defaultMaxValue;
 },
 GetFormattedTextByValue: function(value) {
  if (this.minMaxValueFormatter)
   return this.minMaxValueFormatter.Format(value);
  return value;
 },
 GetWarningText: function() {
  var textTemplate = arguments[0];
  var valueTexts = [];
  for (var i = 1; i < arguments.length; i++) {
   var valueText = this.GetFormattedTextByValue(arguments[i]);
   valueTexts.push(valueText);
  }
  return ASPx.Formatter.Format(textTemplate, valueTexts);
 },
 UpdateOutOfRangeWarningElementText: function () {
  var text = "";
  if (this.IsMinValueExists() && this.IsMaxValueExists())
   text = this.GetWarningText(this.editor.outOfRangeWarningMessages[0], this.minValue, this.maxValue);
  if (this.IsMinValueExists() && !this.IsMaxValueExists())
   text = this.GetWarningText(this.editor.outOfRangeWarningMessages[1], this.minValue);
  if (!this.IsMinValueExists() && this.IsMaxValueExists())
   text = this.GetWarningText(this.editor.outOfRangeWarningMessages[2], this.maxValue);
  ASPx.SetInnerHtml(this.outOfRangeWarningElement, "<LABEL>" + text + "</LABEL>");
 },
 UpdateOutOfRangeWarningElementVisibility: function (currentValue) {
  var isValidValue = currentValue == null || this.IsValueInRange(currentValue);
  if (!isValidValue && !this.outOfRangeWarningElementShown)
   this.ShowOutOfRangeWarningElement();
  if (isValidValue && this.outOfRangeWarningElementShown)
   this.HideOutOfRangeWarningElement();
 },
 GetOutOfRangeWarningElementCoordinates: function() {
  var editorMainElement = this.editor.GetMainElement();
  var editorWidth = editorMainElement.offsetWidth;
  var editorHeight = editorMainElement.offsetHeight;
  var editorX = ASPx.GetAbsoluteX(editorMainElement);
  var editorY = ASPx.GetAbsoluteY(editorMainElement);
  var outOfRangeWarningElementX = this.outOfRangeWarningElementPosition === ASPx.Position.Right ? editorX + editorWidth : editorX;
  var outOfRangeWarningElementY = this.outOfRangeWarningElementPosition === ASPx.Position.Right ? editorY : editorY + editorHeight;
  outOfRangeWarningElementX = outOfRangeWarningElementX < 0 ? 0 : outOfRangeWarningElementX;
  outOfRangeWarningElementY = outOfRangeWarningElementY < 0 ? 0 : outOfRangeWarningElementY;
  return {
   x: outOfRangeWarningElementX,
   y: outOfRangeWarningElementY
  };
 },
 ShowOutOfRangeWarningElement: function () {
  this.outOfRangeWarningElement.style.display = "inline";
  var outOfRangeWarningElementCoordinates = this.GetOutOfRangeWarningElementCoordinates();
  ASPx.SetAbsoluteX(this.outOfRangeWarningElement, outOfRangeWarningElementCoordinates.x);
  ASPx.SetAbsoluteY(this.outOfRangeWarningElement, outOfRangeWarningElementCoordinates.y);
  ASPx.AnimationHelper.fadeIn(this.outOfRangeWarningElement, null, this.animationDuration);
  this.outOfRangeWarningElementShown = true;
 },
 HideOutOfRangeWarningElement: function () {
  ASPx.AnimationHelper.fadeOut(this.outOfRangeWarningElement, function () {
   ASPx.SetElementDisplay(this.outOfRangeWarningElement, false);
  }.aspxBind(this), this.animationDuration);
  this.outOfRangeWarningElementShown = false;
 }
});
ASPx.MMMouseOut = function(name, evt) {
 var edit = ASPx.GetControlCollection().Get(name);
 if(edit != null) edit.OnMouseOut(evt);
}
ASPx.MMMouseOver = function(name, evt) {
 var edit = ASPx.GetControlCollection().Get(name);
 if(edit != null) edit.OnMouseOver(evt);
}
ASPx.MaskHintTimerProc = function() {
 var focusedEditor = ASPxClientEdit.GetFocusedEditor();
 if(focusedEditor != null && ASPx.IsFunction(focusedEditor.MaskHintTimerProc))
  focusedEditor.MaskHintTimerProc();
}
ASPx.ETextChanged = function(name) {
 var edit = ASPx.GetControlCollection().Get(name);
 if(edit != null) edit.OnTextChanged(); 
}
ASPx.BEClick = function(name,number){
 var edit = ASPx.GetControlCollection().Get(name);
 if(edit != null) edit.OnButtonClick(number);
}
ASPx.BEClear = function(name, evt) {
 var edit = ASPx.GetControlCollection().Get(name);
 if(edit && (evt.button === 0 || ASPx.Browser.TouchUI)) {
  var requireFocus = !ASPx.Browser.VirtualKeyboardSupported || ASPx.Browser.MSTouchUI;
  if(requireFocus)
   edit.GetInputElement().focus();
  (function performOnClean() {
   if(edit.IsFocused() || !requireFocus)
    edit.OnClear();
   else
    window.setTimeout(performOnClean, 100);
  })();
 }
}
ASPx.SetFocusToTextEditWithDelay = function(name) {
 window.setTimeout(function() {
  var edit = ASPx.GetControlCollection().Get(name);
  if(!edit)
   return;
  ASPx.Browser.IE ? edit.SetCaretPosition(0) : edit.SetFocus();
 }, 500);
}
window.ASPxClientTextEdit = ASPxClientTextEdit;
window.ASPxClientTextBoxBase = ASPxClientTextBoxBase;
window.ASPxClientTextBox = ASPxClientTextBox;
window.ASPxClientMemo = ASPxClientMemo;
window.ASPxClientButtonEditBase = ASPxClientButtonEditBase;
window.ASPxClientButtonEdit = ASPxClientButtonEdit;
window.ASPxClientButtonEditClickEventArgs = ASPxClientButtonEditClickEventArgs;
})();

