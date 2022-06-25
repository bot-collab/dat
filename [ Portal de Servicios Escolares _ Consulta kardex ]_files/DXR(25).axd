(function() {
var ASPxClientEditBase = ASPx.CreateClass(ASPxClientControl, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.EnabledChanged = new ASPxClientEvent();
  this.captionPosition = ASPx.Position.Left;
  this.showCaptionColon = true;
 },
 InlineInitialize: function(){
  ASPxClientControl.prototype.InlineInitialize.call(this);
  this.InitializeEnabled(); 
 },
 InitializeEnabled: function() {
  this.SetEnabledInternal(this.clientEnabled, true);
 },
 GetValue: function() {
  var element = this.GetMainElement();
  if(ASPx.IsExistsElement(element))
   return element.innerHTML;
  return "";
 },
 GetValueString: function(){
  var value = this.GetValue();
  return (value == null) ? null : value.toString();
 },
 SetValue: function(value) {
  if(value == null)
   value = "";
  var element = this.GetMainElement();
  if(ASPx.IsExistsElement(element))
   element.innerHTML = value;
 },
 GetEnabled: function(){
  return this.enabled && this.clientEnabled;
 },
 SetEnabled: function(enabled){
  if(this.clientEnabled != enabled) {
   var errorFrameRequiresUpdate = this.GetIsValid && !this.GetIsValid();
   if(errorFrameRequiresUpdate && !enabled)
    this.UpdateErrorFrameAndFocus(false , null , true );
   this.clientEnabled = enabled;
   this.SetEnabledInternal(enabled, false);
   if(errorFrameRequiresUpdate && enabled)
    this.UpdateErrorFrameAndFocus(false );
   this.RaiseEnabledChangedEvent();
  }
 },
 SetEnabledInternal: function(enabled, initialization){
  if(!this.enabled) return;
  if(!initialization || !enabled)
   this.ChangeEnabledStateItems(enabled);
  this.ChangeEnabledAttributes(enabled);
  if(ASPx.Browser.Chrome) {   
   var mainElement = this.GetMainElement();
   if(mainElement)
    mainElement.className = mainElement.className;
  } 
 },
 ChangeEnabledAttributes: function(enabled){
 },
 ChangeEnabledStateItems: function(enabled){
 },
 RaiseEnabledChangedEvent: function(){
  if(!this.EnabledChanged.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.EnabledChanged.FireEvent(this, args);
  }
 },
 GetDecodeValue: function (value) { 
  if(typeof (value) == "string" && value.length > 1)
   value = this.SimpleDecodeHtml(value);
  return value;
 },
 SimpleDecodeHtml: function (html) {
  return ASPx.Str.ApplyReplacement(html, [
   [/&lt;/g, '<'],
   [/&amp;/g, '&'],
   [/&quot;/g, '"'],
   [/&#39;/g, '\''],
   [/&#32;/g, ' ']
  ]);
 },
 GetCachedElementById: function(idSuffix) {
  return ASPx.CacheHelper.GetCachedElementById(this, this.name + idSuffix);
 },
 GetCaptionCell: function() {
  return this.GetCachedElementById(EditElementSuffix.CaptionCell);
 },
 GetExternalTable: function() {
  return this.GetCachedElementById(EditElementSuffix.ExternalTable);
 },
 getCaptionRelatedCellCount: function() {
  if(!this.captionRelatedCellCount)
   this.captionRelatedCellCount = ASPx.GetNodesByClassName(this.GetExternalTable(), CaptionRelatedCellClassName).length;
  return this.captionRelatedCellCount;
 },
 addCssClassToCaptionRelatedCells: function() {
  if(this.captionPosition == ASPx.Position.Left || this.captionPosition == ASPx.Position.Right) {
   var captionRelatedCellsIndex = this.captionPosition == ASPx.Position.Left ? 0 : this.GetCaptionCell().cellIndex;
   for(var i = 0; i < this.GetExternalTable().rows.length; i++)
    ASPx.AddClassNameToElement(this.GetExternalTable().rows[i].cells[captionRelatedCellsIndex], CaptionRelatedCellClassName);
  }
  if(this.captionPosition == ASPx.Position.Top || this.captionPosition == ASPx.Position.Bottom)
   for(var i = 0; i < this.GetCaptionCell().parentNode.cells.length; i++)
    ASPx.AddClassNameToElement(this.GetCaptionCell().parentNode.cells[i], CaptionRelatedCellClassName);
 },
 GetCaption: function() {
  if(ASPx.IsExists(this.GetCaptionCell()))
   return this.getCaptionInternal();
  return "";
 },
 SetCaption: function(caption) {
  if(!ASPx.IsExists(this.GetCaptionCell()))
   return;
  if(this.getCaptionRelatedCellCount() == 0)
   this.addCssClassToCaptionRelatedCells();
  if(caption !== "")
   ASPx.RemoveClassNameFromElement(this.GetExternalTable(), ASPxEditExternalTableClassNames.TableWithEmptyCaptionClassName);
  else
   ASPx.AddClassNameToElement(this.GetExternalTable(), ASPxEditExternalTableClassNames.TableWithEmptyCaptionClassName);
  this.setCaptionInternal(caption);
 },
 getCaptionTextNode: function() {
  var captionElement = ASPx.GetNodesByPartialClassName(this.GetCaptionCell(), CaptionElementPartialClassName)[0];
  return ASPx.GetTextNode(captionElement);
 },
 getCaptionInternal: function() {
  var captionText = this.getCaptionTextNode().nodeValue;
  if(captionText !== "" && captionText[captionText.length - 1] == ":")
   captionText = captionText.substring(0, captionText.length - 1);
  return captionText;
 },
 setCaptionInternal: function(caption) {
  caption = ASPx.Str.Trim(caption);
  var captionTextNode = this.getCaptionTextNode();
  if(this.showCaptionColon && caption[caption.length - 1] != ":" && caption !== "")
   caption += ":";
  captionTextNode.nodeValue = caption;
 }
});
var ValidationPattern = ASPx.CreateClass(null, {
 constructor: function(errorText) {
  this.errorText = errorText;
 }
});
var RequiredFieldValidationPattern = ASPx.CreateClass(ValidationPattern, {
 constructor: function(errorText) {
  this.constructor.prototype.constructor.call(this, errorText);
 },
 EvaluateIsValid: function(value) {
  return value != null && (value.constructor == Array || ASPx.Str.Trim(value.toString()) != "");
 }
});
var RegularExpressionValidationPattern = ASPx.CreateClass(ValidationPattern, {
 constructor: function(errorText, pattern) {
  this.constructor.prototype.constructor.call(this, errorText);
  this.pattern = pattern;
 },
 EvaluateIsValid: function(value) {
  if(value == null) 
   return true;
  var strValue = value.toString();
  if(ASPx.Str.Trim(strValue).length == 0)
   return true;
  var regEx = new RegExp(this.pattern);
  var matches = regEx.exec(strValue);
  return matches != null && strValue == matches[0];
 }
});
function _aspxIsEditorFocusable(inputElement) {
 return ASPx.IsFocusableCore(inputElement, function(container) {
  return container.getAttribute("errorFrame") == "errorFrame";
 });
}
var invalidEditorToBeFocused = null;
var ValidationType = {
 PersonalOnValueChanged: "ValueChanged",
 PersonalViaScript: "CalledViaScript",
 MassValidation: "MassValidation"
};
var ErrorFrameDisplay = {
 None: "None",
 Static: "Static",
 Dynamic: "Dynamic"
};
var EditElementSuffix = {
 ExternalTable: "_ET",
 ControlCell: "_CC",
 ErrorCell: "_EC",
 ErrorTextCell: "_ETC",
 ErrorImage: "_EI",
 CaptionCell: "_CapC"
};
var ASPxEditExternalTableClassNames = {
 ValidStaticTableClassName: "dxeValidStEditorTable",
 ValidDynamicTableClassName: "dxeValidDynEditorTable",
 TableWithSeparateBordersClassName: "tableWithSeparateBorders",
 TableWithEmptyCaptionClassName: "tableWithEmptyCaption"
};
var CaptionRelatedCellClassName = "dxeCaptionRelatedCell";
var CaptionElementPartialClassName = "dxeCaption";
var ASPxClientEdit = ASPx.CreateClass(ASPxClientEditBase, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.isASPxClientEdit = true;
  this.inputElement = null;
  this.convertEmptyStringToNull = true;
  this.readOnly = false;
  this.focused = false;
  this.focusEventsLocked = false;
  this.receiveGlobalMouseWheel = true;
  this.styleDecoration = null;
  this.heightCorrectionRequired = false;
  this.customValidationEnabled = false;
  this.display = ErrorFrameDisplay.Static;
  this.initialErrorText = "";
  this.causesValidation = false;
  this.validateOnLeave = true;
  this.validationGroup = "";
  this.sendPostBackWithValidation = null;
  this.validationPatterns = [];
  this.setFocusOnError = false;
  this.errorDisplayMode = "it";
  this.errorText = "";
  this.isValid = true;
  this.errorImageIsAssigned = false;
  this.notifyValidationSummariesToAcceptNewError = false;
  this.enterProcessed = false;
  this.keyDownHandlers = {};
  this.keyPressHandlers = {};
  this.keyUpHandlers = {};
  this.specialKeyboardHandlingUsed = false;
  this.onKeyDownHandler = null;
  this.onKeyPressHandler = null;
  this.onKeyUpHandler = null;
  this.onGotFocusHandler = null;
  this.onLostFocusHandler = null;
  this.GotFocus = new ASPxClientEvent();
  this.LostFocus = new ASPxClientEvent();
  this.Validation = new ASPxClientEvent();
  this.ValueChanged = new ASPxClientEvent();
  this.KeyDown = new ASPxClientEvent();
  this.KeyPress = new ASPxClientEvent();
  this.KeyUp = new ASPxClientEvent();
  this.eventHandlersInitialized = false;
 },
 Initialize: function() {
  this.initialErrorText = this.errorText;
  ASPxClientEditBase.prototype.Initialize.call(this);
  this.InitializeKeyHandlers();
  this.UpdateClientValidationState();
  this.UpdateValidationSummaries(null , true );
 },
 InlineInitialize: function() {
  ASPxClientEditBase.prototype.InlineInitialize.call(this);
  if(!this.eventHandlersInitialized)
   this.InitializeEvents();
  if(this.styleDecoration)
   this.styleDecoration.Update();
  var externalTable = this.GetExternalTable();
  if(externalTable && ASPx.IsPercentageSize(externalTable.style.width)) {
   this.width = "100%";
   this.GetMainElement().style.width = "100%";
  }
 }, 
 InitializeEvents: function() {
 },
 InitSpecialKeyboardHandling: function(){
  var name = this.name;
  this.onKeyDownHandler = function(evt) { ASPx.KBSIKeyDown(name,evt); };
  this.onKeyPressHandler = function(evt) { ASPx.KBSIKeyPress(name, evt); };
  this.onKeyUpHandler = function(evt) { ASPx.KBSIKeyUp(name, evt); };
  this.onGotFocusHandler = function(evt) { ASPx.ESGotFocus(name); };
  this.onLostFocusHandler = function(evt) { ASPx.ESLostFocus(name); };
  this.specialKeyboardHandlingUsed = true;
  this.InitializeDelayedSpecialFocus();
 },
 InitializeKeyHandlers: function() {
 },
 AddKeyDownHandler: function(key, handler) {
  this.keyDownHandlers[key] = handler;
 },
 AddKeyPressHandler: function(key, handler) {
  this.keyPressHandlers[key] = handler;
 },
 ChangeSpecialInputEnabledAttributes: function(element, method, doNotChangeAutoComplete){
  if(!doNotChangeAutoComplete) 
   element.autocomplete = "off";
  if(this.onKeyDownHandler != null)
   method(element, "keydown", this.onKeyDownHandler);
  if(this.onKeyPressHandler != null)
   method(element, "keypress", this.onKeyPressHandler);
  if(this.onKeyUpHandler != null)
   method(element, "keyup", this.onKeyUpHandler);
  if(this.onGotFocusHandler != null)
   method(element, "focus", this.onGotFocusHandler);
  if(this.onLostFocusHandler != null)
   method(element, "blur", this.onLostFocusHandler);
 },
 UpdateClientValidationState: function() {
  if(!this.customValidationEnabled)
   return;
  var mainElement = this.GetMainElement();
  if(mainElement) {
   var validationState = !this.GetIsValid() ? ("-" + this.GetErrorText()) : "";
   this.UpdateStateObjectWithObject({ validationState: validationState });
  }
 },
 UpdateValidationSummaries: function(validationType, initializing) {
  if(typeof(ASPxClientValidationSummary) != "undefined") {
   var summaryCollection = ASPx.GetClientValidationSummaryCollection();
   summaryCollection.OnEditorIsValidStateChanged(this, validationType, initializing && this.notifyValidationSummariesToAcceptNewError);
  }
 },
 FindInputElement: function(){
  return null;
 },
 GetInputElement: function(){
  if(!ASPx.IsExistsElement(this.inputElement))
   this.inputElement = this.FindInputElement();
  return this.inputElement;
 },
 GetFocusableInputElement: function() {
  return this.GetInputElement();
 },
 GetErrorImage: function() {
  return this.GetCachedElementById(EditElementSuffix.ErrorImage);
 },
 GetControlCell: function() {
  return this.GetCachedElementById(EditElementSuffix.ControlCell);
 },
 GetErrorCell: function() {
  return this.GetCachedElementById(EditElementSuffix.ErrorCell);
 },
 GetErrorTextCell: function() {
  return this.GetCachedElementById(this.errorImageIsAssigned ? EditElementSuffix.ErrorTextCell : EditElementSuffix.ErrorCell);
 },
 SetVisible: function (isVisible) {
  if(this.clientVisible == isVisible)
   return;
  var externalTable = this.GetExternalTable();
  if(externalTable) {
   ASPx.SetElementDisplay(externalTable, isVisible);
   if(this.customValidationEnabled) {
    var isValid = !isVisible ? true : void (0);
    this.UpdateErrorFrameAndFocus(false , true , isValid );
   }
  }
  ASPxClientControl.prototype.SetVisible.call(this, isVisible);
 },
 GetStateHiddenFieldName: function() {
  return this.uniqueID + "$State";
 },
 GetValueInputToValidate: function() {
  return this.GetInputElement();
 },
 IsVisible: function() {
  if(!this.clientVisible)
   return false;
  var element = this.GetMainElement();
  if(!element) 
   return false;
  while(element && element.tagName != "BODY") {
   if(element.getAttribute("errorFrame") != "errorFrame" && (!ASPx.GetElementVisibility(element) || !ASPx.GetElementDisplay(element)))
    return false;
   element = element.parentNode;
  }
  return true;
 },
 AdjustControlCore: function() {
  this.CollapseEditor();
  this.UnstretchInputElement();
  if(this.heightCorrectionRequired)
   this.CorrectEditorHeight();
 },
 CorrectEditorHeight: function() {
 },
 UnstretchInputElement: function() {
 },
 UseDelayedSpecialFocus: function() {
  return false;
 },
 GetDelayedSpecialFocusTriggers: function() {
  return [ this.GetMainElement() ];
 },
 InitializeDelayedSpecialFocus: function() {
  if(!this.UseDelayedSpecialFocus())
   return;
  this.specialFocusTimer = -1;    
  var handler = function(evt) { this.OnDelayedSpecialFocusMouseDown(evt); }.aspxBind(this);
  var triggers = this.GetDelayedSpecialFocusTriggers();
  for(var i = 0; i < triggers.length; i++)
   ASPx.Evt.AttachEventToElement(triggers[i], "mousedown", handler);
 },
 OnDelayedSpecialFocusMouseDown: function(evt) {
  window.setTimeout(function() { this.SetFocus(); }.aspxBind(this), 0);
 },
 IsFocusEventsLocked: function() {
  return this.focusEventsLocked;
 },
 LockFocusEvents: function() {
  if(!this.focused) return;
  this.focusEventsLocked = true;
 },
 UnlockFocusEvents: function() {
  this.focusEventsLocked = false;
 },
 ForceRefocusEditor: function(evt, isNativeFocus) {
  if(ASPx.Browser.VirtualKeyboardSupported) {
   var focusedEditor = ASPx.VirtualKeyboardUI.getFocusedEditor();
   if(ASPx.VirtualKeyboardUI.getInputNativeFocusLocked() && (!focusedEditor || focusedEditor === this))
     return;
   ASPx.VirtualKeyboardUI.setInputNativeFocusLocked(!isNativeFocus);
  }
  this.LockFocusEvents();
  this.BlurInputElement();
  window.setTimeout(function() { 
   if(ASPx.Browser.VirtualKeyboardSupported) {
    ASPx.VirtualKeyboardUI.setFocusEditorCore(this);
   } else {
    this.SetFocus();
   }
  }.aspxBind(this), 0);
 },
 BlurInputElement: function() {
  var inputElement = this.GetFocusableInputElement();
  if(inputElement && inputElement.blur)
   inputElement.blur();
 },
 IsEditorElement: function(element) {
  return this.GetMainElement() == element || ASPx.GetIsParent(this.GetMainElement(), element);
 },
 IsClearButtonElement: function(element) {
  return false;
 },
 IsElementBelongToInputElement: function(element) {
  return this.GetInputElement() == element;
 },
 OnFocusCore: function() {
  if(this.UseDelayedSpecialFocus())
   window.clearTimeout(this.specialFocusTimer);
  if(!this.IsFocusEventsLocked()){
   this.focused = true;
   ASPxClientEdit.SetFocusedEditor(this);
   if(this.styleDecoration)
    this.styleDecoration.Update();
   if(this.isInitialized)
    this.RaiseFocus();
  }
  else
   this.UnlockFocusEvents();
 },
 OnLostFocusCore: function() {
  if(!this.IsFocusEventsLocked()){
   this.focused = false;
   if(!this.UseDelayedSpecialFocus() || ASPxClientEdit.GetFocusedEditor() === this) 
    ASPxClientEdit.SetFocusedEditor(null);
   if(this.styleDecoration)
    this.styleDecoration.Update();
   this.RaiseLostFocus();
  }
 },
 OnFocus: function() {
  if(!this.specialKeyboardHandlingUsed)
   this.OnFocusCore();
 },
 OnLostFocus: function() {
  if(this.isInitialized && !this.specialKeyboardHandlingUsed)
   this.OnLostFocusCore();
 },
 OnSpecialFocus: function() {
  if(this.isInitialized)
   this.OnFocusCore();
 },
 OnSpecialLostFocus: function() {
  if(this.isInitialized)
   this.OnLostFocusCore();
 },
 OnMouseWheel: function(evt){
 },
 OnValidation: function(validationType) {
  if(this.customValidationEnabled && this.isInitialized && ASPx.IsExistsElement(this.GetMainElement()) &&
   (!this.IsErrorFrameDisplayed() || this.GetExternalTable())) {
   this.BeginErrorFrameUpdate();
   try {
    if(this.validateOnLeave || validationType != ValidationType.PersonalOnValueChanged) {
     this.SetIsValid(true, true );
     this.SetErrorText(this.initialErrorText, true );
     this.ValidateWithPatterns();
     this.RaiseValidation();
    }
    this.UpdateErrorFrameAndFocus(this.editorFocusingRequired(validationType));
   } finally {
    this.EndErrorFrameUpdate();
   }
   this.UpdateValidationSummaries(validationType);
  }
 },
 editorFocusingRequired: function(validationType) {
  return !this.GetIsValid() && ((validationType == ValidationType.PersonalOnValueChanged && this.validateOnLeave) ||
         (validationType == ValidationType.PersonalViaScript && this.setFocusOnError));
 },
 OnValueChanged: function() {
  var processOnServer = this.RaiseValidationInternal();
  processOnServer = this.RaiseValueChangedEvent() && processOnServer;
  if(processOnServer)
   this.SendPostBackInternal("");
 },
 ParseValue: function() {
 },
 RaisePersonalStandardValidation: function() {
  if(ASPx.IsFunction(window.ValidatorOnChange)) {
   var inputElement = this.GetValueInputToValidate();
   if(inputElement && inputElement.Validators)
    window.ValidatorOnChange({ srcElement: inputElement });
  }
 },
 RaiseValidationInternal: function() {
  if(this.isPostBackAllowed() && this.causesValidation && this.validateOnLeave)
   return ASPxClientEdit.ValidateGroup(this.validationGroup);
  else {
   this.OnValidation(ValidationType.PersonalOnValueChanged);
   return this.GetIsValid();
  }
 },
 RaiseValueChangedEvent: function(){
  return this.RaiseValueChanged();
 },
 SendPostBackInternal: function(postBackArg) {
  if(ASPx.IsFunction(this.sendPostBackWithValidation))
   this.sendPostBackWithValidation(postBackArg);
  else
   this.SendPostBack(postBackArg);
 },
 SetElementToBeFocused: function() {
  if(this.IsVisible())
   invalidEditorToBeFocused = this;
 },
 GetFocusSelectAction: function() {
  return null;
 },
 SetFocus: function() {
  var inputElement = this.GetFocusableInputElement();
  if(!inputElement) return; 
  var isIE9 = ASPx.Browser.IE && ASPx.Browser.Version >= 9;
  if((ASPx.GetActiveElement() != inputElement || isIE9) && _aspxIsEditorFocusable(inputElement))
   ASPx.SetFocus(inputElement, this.GetFocusSelectAction());
 },
 SetFocusOnError: function() {
  if(invalidEditorToBeFocused == this) {
   this.SetFocus();
   invalidEditorToBeFocused = null;
  }
 },
 BeginErrorFrameUpdate: function() {
  if(!this.errorFrameUpdateLocked)
   this.errorFrameUpdateLocked = true;
 },
 EndErrorFrameUpdate: function() {
  this.errorFrameUpdateLocked = false;
  var args = this.updateErrorFrameAndFocusLastCallArgs;
  if(args) {
   this.UpdateErrorFrameAndFocus(args[0], args[1]);
   delete this.updateErrorFrameAndFocusLastCallArgs;
  }
 },
 UpdateErrorFrameAndFocus: function(setFocusOnError, ignoreVisibilityCheck, isValid) {
  if(!this.GetEnabled() || !ignoreVisibilityCheck && !this.GetVisible())
   return;
  if(this.errorFrameUpdateLocked) {
   this.updateErrorFrameAndFocusLastCallArgs = [ setFocusOnError, ignoreVisibilityCheck ];
   return;
  }
  if(this.styleDecoration)
   this.styleDecoration.Update();
  if(typeof(isValid) == "undefined")
   isValid = this.GetIsValid();
  var externalTable = this.GetExternalTable();
  var isStaticDisplay = this.display == ErrorFrameDisplay.Static;
  if(isValid && this.IsErrorFrameDisplayed()) {
   if(isStaticDisplay) {
    this.HideErrorCell(true);
    ASPx.AddClassNameToElement(externalTable, ASPxEditExternalTableClassNames.ValidStaticTableClassName);
   } else {
    this.HideErrorCell();
    this.SaveControlCellStyles();
    this.ClearControlCellStyles();
    ASPx.AddClassNameToElement(externalTable, ASPxEditExternalTableClassNames.ValidDynamicTableClassName);
   }
  } else {
   var editorLocatedWithinVisibleContainer = this.IsVisible();
   if(this.IsErrorFrameDisplayed()) {
    this.UpdateErrorCellContent();
    if(isStaticDisplay) {
     this.ShowErrorCell(true);
     ASPx.RemoveClassNameFromElement(externalTable, ASPxEditExternalTableClassNames.ValidStaticTableClassName);
    } else {
     this.EnsureControlCellStylesLoaded();
     this.RestoreControlCellStyles();
     this.ShowErrorCell();
     ASPx.RemoveClassNameFromElement(externalTable, ASPxEditExternalTableClassNames.ValidDynamicTableClassName);
    }
   }
   if(editorLocatedWithinVisibleContainer) {
    if(setFocusOnError && this.setFocusOnError && invalidEditorToBeFocused == null) {
     this.SetElementToBeFocused();
     this.SetFocusOnError();
    }
   }
  }
 },
 ShowErrorCell: function (useVisibilityAttribute) {
  var errorCell = this.GetErrorCell();
  if(errorCell) {
   if(useVisibilityAttribute)
    ASPx.SetElementVisibility(errorCell, true);
   else
    ASPx.SetElementDisplay(errorCell, true);
  }
 },
 HideErrorCell: function(useVisibilityAttribute) {
  var errorCell = this.GetErrorCell();
  if(errorCell) {
   if(useVisibilityAttribute)
    ASPx.SetElementVisibility(errorCell, false);
   else
    ASPx.SetElementDisplay(errorCell, false);
  }
 },
 SaveControlCellStyles: function() {
  this.EnsureControlCellStylesLoaded();
 },
 EnsureControlCellStylesLoaded: function() {
  if(typeof(this.controlCellStyles) == "undefined") {
   var controlCell = this.GetControlCell();
   this.controlCellStyles = {
    cssClass: controlCell.className,
    style: this.ExtractElementStyleStringIgnoringVisibilityProps(controlCell)
   };
  }
 },
 ClearControlCellStyles: function() {
  this.ClearElementStyle(this.GetControlCell());
 },
 RestoreControlCellStyles: function() {
  var controlCell = this.GetControlCell();
  var externalTable = this.GetExternalTable();
  if(ASPx.Browser.WebKitFamily)
   this.MakeBorderSeparateForTable(externalTable);
  controlCell.className = this.controlCellStyles.cssClass;
  controlCell.style.cssText = this.controlCellStyles.style;
  if(ASPx.Browser.WebKitFamily)
   this.UndoBorderSeparateForTable(externalTable);
 },
 MakeBorderSeparateForTable: function(table) {
  ASPx.AddClassNameToElement(table, ASPxEditExternalTableClassNames.TableWithSeparateBordersClassName);
 },
 UndoBorderSeparateForTable: function(table) {
  setTimeout(function () {
   ASPx.RemoveClassNameFromElement(table, ASPxEditExternalTableClassNames.TableWithSeparateBordersClassName);
  }, 0);
 },
 ExtractElementStyleStringIgnoringVisibilityProps: function(element) {
  var savedVisibility = element.style.visibility;
  var savedDisplay = element.style.display;
  element.style.visibility = "";
  element.style.display = "";
  var styleStr = element.style.cssText;
  element.style.visibility = savedVisibility;
  element.style.display = savedDisplay;
  return styleStr;
 },
 ClearElementStyle: function(element) {
  if(!element)
   return;
  element.className = "";
  var excludedAttrNames = [
   "width", "display", "visibility",
   "position", "left", "top", "z-index",
   "margin", "margin-top", "margin-right", "margin-bottom", "margin-left",
   "float", "clear"
  ];
  var savedAttrValues = { };
  for(var i = 0; i < excludedAttrNames.length; i++) {
   var attrName = excludedAttrNames[i];
   var attrValue = element.style[attrName];
   if(attrValue)
    savedAttrValues[attrName] = attrValue;
  }
  element.style.cssText = "";
  for(var styleAttrName in savedAttrValues)
   element.style[styleAttrName] = savedAttrValues[styleAttrName];
 },
 Clear: function() {
  this.SetValue(null);
  this.SetIsValid(true);
  return true;
 },
 UpdateErrorCellContent: function() {
  if(this.errorDisplayMode.indexOf("t") > -1)
   this.UpdateErrorText();
  if(this.errorDisplayMode == "i")
   this.UpdateErrorImage();
 },
 UpdateErrorImage: function() {
  var image = this.GetErrorImage();
  if(ASPx.IsExistsElement(image)) {
   image.alt = this.errorText;
   image.title = this.errorText;
  } else {
   this.UpdateErrorText();
  }
 },
 UpdateErrorText: function() {
  var errorTextCell = this.GetErrorTextCell();
  if(ASPx.IsExistsElement(errorTextCell))
   errorTextCell.innerHTML = this.HtmlEncode(this.errorText);
 },
 ValidateWithPatterns: function() {
  if(this.validationPatterns.length > 0) {
   var value = this.GetValue();
   for(var i = 0; i < this.validationPatterns.length; i++) {
    var validator = this.validationPatterns[i];
    if(!validator.EvaluateIsValid(value)) {
     this.SetIsValid(false, true );
     this.SetErrorText(validator.errorText, true );
     return;
    }
   }
  }
 },
 OnSpecialKeyDown: function(evt){
  this.RaiseKeyDown(evt);
  var handler = this.keyDownHandlers[evt.keyCode];
  if(handler) 
   return this[handler](evt);
  return false;
 },
 OnSpecialKeyPress: function(evt){
  this.RaiseKeyPress(evt);
  var handler = this.keyPressHandlers[evt.keyCode];
  if(handler) 
   return this[handler](evt);
  if(ASPx.Browser.NetscapeFamily || ASPx.Browser.Opera){
   if(evt.keyCode == ASPx.Key.Enter)
    return this.enterProcessed;
  }
  return false;
 },
 OnSpecialKeyUp: function(evt){
  this.RaiseKeyUp(evt);
  var handler = this.keyUpHandlers[evt.keyCode];
  if(handler) 
   return this[handler](evt);
  return false;
 },
 OnKeyDown: function(evt) {
  if(!this.specialKeyboardHandlingUsed)
   this.RaiseKeyDown(evt);
 },
 OnKeyPress: function(evt) {
  if(!this.specialKeyboardHandlingUsed)
   this.RaiseKeyPress(evt);
 },
 OnKeyUp: function(evt) {
  if(!this.specialKeyboardHandlingUsed)
   this.RaiseKeyUp(evt);
 },
 RaiseKeyDown: function(evt){
  if(!this.KeyDown.IsEmpty()){
   var args = new ASPxClientEditKeyEventArgs(evt);
   this.KeyDown.FireEvent(this, args);
  }
 },
 RaiseKeyPress: function(evt){
  if(!this.KeyPress.IsEmpty()){
   var args = new ASPxClientEditKeyEventArgs(evt);
   this.KeyPress.FireEvent(this, args);
  }
 },
 RaiseKeyUp: function(evt){
  if(!this.KeyUp.IsEmpty()){
   var args = new ASPxClientEditKeyEventArgs(evt);
   this.KeyUp.FireEvent(this, args);
  }
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
 RaiseValidation: function() {
  if(this.customValidationEnabled && !this.Validation.IsEmpty()) {
   var currentValue = this.GetValue();
   var args = new ASPxClientEditValidationEventArgs(currentValue, this.errorText, this.GetIsValid());
   this.Validation.FireEvent(this, args);
   this.SetErrorText(args.errorText, true );
   this.SetIsValid(args.isValid, true );
   if(args.value != currentValue)
    this.SetValue(args.value);
  }
 },
 RaiseValueChanged: function(){
  var processOnServer = this.isPostBackAllowed();
  if(!this.ValueChanged.IsEmpty()){
   var args = new ASPxClientProcessingModeEventArgs(processOnServer);
   this.ValueChanged.FireEvent(this, args);
   processOnServer = args.processOnServer;
  }
  return processOnServer;  
 },
 isPostBackAllowed: function() {
  return this.autoPostBack;
 },
 RequireStyleDecoration: function() {
  this.styleDecoration = new ASPx.EditorStyleDecoration(this);
  this.PopulateStyleDecorationPostfixes();
 }, 
 PopulateStyleDecorationPostfixes: function() {
  this.styleDecoration.AddPostfix("");
 },
 Focus: function(){
  this.SetFocus();
 },
 GetIsValid: function() {
  var hasRequiredInputElement = !this.RequireInputElementToValidate() || ASPx.IsExistsElement(this.GetInputElement());
  if(!hasRequiredInputElement || this.IsErrorFrameDisplayed() && !ASPx.IsExistsElement(this.GetExternalTable()))
   return true;
  return this.isValid;
 },
 RequireInputElementToValidate: function() {
  return true;
 },
 IsErrorFrameDisplayed: function() {
  return this.display !== ErrorFrameDisplay.None;
 },
 GetErrorText: function(){
  return this.errorText;
 },
 SetIsValid: function(isValid, validating){
  if(this.customValidationEnabled && this.isValid != isValid) {
   this.isValid = isValid;
   this.UpdateErrorFrameAndFocus(false );
   this.UpdateClientValidationState();
   if(!validating)
    this.UpdateValidationSummaries(ValidationType.PersonalViaScript);
  }
 },
 SetErrorText: function(errorText, validating){
  if(this.customValidationEnabled && this.errorText != errorText) {
   this.errorText = errorText;
   this.UpdateErrorFrameAndFocus(false );
   this.UpdateClientValidationState();
   if(!validating)
    this.UpdateValidationSummaries(ValidationType.PersonalViaScript);
  }
 },
 Validate: function(){
  this.ParseValue();
  this.OnValidation(ValidationType.PersonalViaScript);
 }
});
var focusedEditorName = "";
ASPxClientEdit.GetFocusedEditor = function() {
 var focusedEditor = ASPx.GetControlCollection().Get(focusedEditorName);
 if(focusedEditor && !focusedEditor.focused){
  ASPxClientEdit.SetFocusedEditor(null);
  focusedEditor = null;
 }
 return focusedEditor;
}
ASPxClientEdit.SetFocusedEditor = function(editor) {
 focusedEditorName = editor ? editor.name : "";
}
ASPxClientEdit.ClearEditorsInContainer = function(container, validationGroup, clearInvisibleEditors) {
 invalidEditorToBeFocused = null;
 ASPx.ProcessEditorsInContainer(container, ASPx.ClearProcessingProc, ASPx.ClearChoiceCondition, validationGroup, clearInvisibleEditors, true );
 ASPxClientEdit.ClearExternalControlsInContainer(container, validationGroup, clearInvisibleEditors);
}
ASPxClientEdit.ClearEditorsInContainerById = function(containerId, validationGroup, clearInvisibleEditors) {
 var container = document.getElementById(containerId);
 this.ClearEditorsInContainer(container, validationGroup, clearInvisibleEditors);
}
ASPxClientEdit.ClearGroup = function(validationGroup, clearInvisibleEditors) {
 return this.ClearEditorsInContainer(null, validationGroup, clearInvisibleEditors);
}
ASPxClientEdit.ValidateEditorsInContainer = function(container, validationGroup, validateInvisibleEditors) {
 var summaryCollection;
 if(typeof(ASPxClientValidationSummary) != "undefined") {
  summaryCollection = ASPx.GetClientValidationSummaryCollection();
  summaryCollection.AllowNewErrorsAccepting(validationGroup);
 }
 var validationResult = ASPx.ProcessEditorsInContainer(container, ASPx.ValidateProcessingProc, _aspxValidateChoiceCondition, validationGroup, validateInvisibleEditors,
  false );
 validationResult.isValid = ASPxClientEdit.ValidateExternalControlsInContainer(container, validationGroup, validateInvisibleEditors) && validationResult.isValid;
 if(typeof(validateInvisibleEditors) == "undefined")
  validateInvisibleEditors = false;
 if(typeof(validationGroup) == "undefined")
  validationGroup = null;    
 ASPx.GetControlCollection().RaiseValidationCompleted(container, validationGroup,
 validateInvisibleEditors, validationResult.isValid, validationResult.firstInvalid, validationResult.firstVisibleInvalid);
 if(summaryCollection)
  summaryCollection.ForbidNewErrorsAccepting(validationGroup);
 return validationResult.isValid;
}
ASPxClientEdit.ValidateEditorsInContainerById = function(containerId, validationGroup, validateInvisibleEditors) {
 var container = document.getElementById(containerId);
 return this.ValidateEditorsInContainer(container, validationGroup, validateInvisibleEditors);
}
ASPxClientEdit.ValidateGroup = function(validationGroup, validateInvisibleEditors) {
 return this.ValidateEditorsInContainer(null, validationGroup, validateInvisibleEditors);
}
ASPxClientEdit.AreEditorsValid = function(containerOrContainerId, validationGroup, checkInvisibleEditors) {
 var container = typeof(containerOrContainerId) == "string" ? document.getElementById(containerOrContainerId) : containerOrContainerId;
 var checkResult = ASPx.ProcessEditorsInContainer(container, ASPx.EditorsValidProcessingProc, _aspxEditorsValidChoiceCondition, validationGroup,
  checkInvisibleEditors, false );
 checkResult.isValid = ASPxClientEdit.AreExternalControlsValidInContainer(containerOrContainerId, validationGroup, checkInvisibleEditors) && checkResult.isValid;
 return checkResult.isValid;
}
ASPxClientEdit.AreExternalControlsValidInContainer = function(containerId, validationGroup, validateInvisibleEditors) {
 if(typeof(ASPxClientHtmlEditor) != "undefined")
  return ASPxClientHtmlEditor.AreEditorsValidInContainer(containerId, validationGroup, validateInvisibleEditors);
 return true;
}
ASPxClientEdit.ClearExternalControlsInContainer = function(containerId, validationGroup, validateInvisibleEditors) {
 if(typeof(ASPxClientHtmlEditor) != "undefined")
  return ASPxClientHtmlEditor.ClearEditorsInContainer(containerId, validationGroup, validateInvisibleEditors);
 return true;
}
ASPxClientEdit.ValidateExternalControlsInContainer = function(containerId, validationGroup, validateInvisibleEditors) {
 if(typeof(ASPxClientHtmlEditor) != "undefined")
  return ASPxClientHtmlEditor.ValidateEditorsInContainer(containerId, validationGroup, validateInvisibleEditors);
 return true;
}
var ASPxClientEditKeyEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(htmlEvent) {
  this.constructor.prototype.constructor.call(this);
  this.htmlEvent = htmlEvent;
 }
});
var ASPxClientEditValidationEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(value, errorText, isValid) {
  this.constructor.prototype.constructor.call(this);
  this.errorText = errorText;
  this.isValid = isValid;
  this.value = value;
 }
});
ASPx.ProcessEditorsInContainer = function(container, processingProc, choiceCondition, validationGroup, processInvisibleEditors, processDisabledEditors) {
 var allProcessedSuccessfull = true;
 var firstInvalid = null;
 var firstVisibleInvalid = null;
 var invalidEditorToBeFocused = null;
 ASPx.GetControlCollection().ForEachControl(function(control) {
  var needToProcessRatingControl = window.ASPxClientRatingControl && (control instanceof ASPxClientRatingControl) && processingProc === ASPx.ClearProcessingProc;
  if(!ASPx.Ident.isDialogInvisibleControl(control) && (ASPx.Ident.IsASPxClientEdit(control) || needToProcessRatingControl) && (processDisabledEditors || control.GetEnabled())) {
   var mainElement = control.GetMainElement();
   if(mainElement &&
    (container == null || ASPx.GetIsParent(container, mainElement)) &&
    (processInvisibleEditors || control.IsVisible()) &&
    choiceCondition(control, validationGroup)) {
    var isSuccess = processingProc(control);
    if(!isSuccess) {
     allProcessedSuccessfull = false;
     if(firstInvalid == null)
      firstInvalid = control;
     var isVisible = control.IsVisible();
     if(isVisible && firstVisibleInvalid == null)
      firstVisibleInvalid = control;
     if(control.setFocusOnError && invalidEditorToBeFocused == null && isVisible)
      invalidEditorToBeFocused = control;
    }
   }
  }
 }, this);
 if(invalidEditorToBeFocused != null)
  invalidEditorToBeFocused.SetFocus();
 return new ASPxValidationResult(allProcessedSuccessfull, firstInvalid, firstVisibleInvalid);
}
var ASPxValidationResult = ASPx.CreateClass(null, {
 constructor: function(isValid, firstInvalid, firstVisibleInvalid) {
  this.isValid = isValid;
  this.firstInvalid = firstInvalid;
  this.firstVisibleInvalid = firstVisibleInvalid;
 }
});
ASPx.ClearChoiceCondition = function(edit, validationGroup) {
 return !ASPx.IsExists(validationGroup) || (edit.validationGroup == validationGroup);
}
function _aspxValidateChoiceCondition(edit, validationGroup) {
 return ASPx.ClearChoiceCondition(edit, validationGroup) && edit.customValidationEnabled;
}
function _aspxEditorsValidChoiceCondition(edit, validationGroup) {
 return _aspxValidateChoiceCondition(edit, validationGroup);
}
function wrapLostFocusHandler(handler) {
 if(ASPx.Browser.Edge) {
  return function(name) {
   var edit = ASPx.GetControlCollection().Get(name);
   if(edit && !ASPx.IsElementVisible(edit.GetMainElement()))
    setTimeout(handler, 0, name);
   else
    handler(name);
  };
 }
 return handler;
};
ASPx.EGotFocus = function(name) {
 var edit = ASPx.GetControlCollection().Get(name); 
 if(!edit) return;
 if(!edit.isInitialized){
  var inputElement = edit.GetFocusableInputElement();
  if(inputElement && inputElement === document.activeElement)
   ASPx.Browser.Firefox ? window.setTimeout(function() { document.activeElement.blur(); }, 0) : document.activeElement.blur();
  return;
 }
  if(ASPx.Browser.VirtualKeyboardSupported) {
  ASPx.VirtualKeyboardUI.onCallingVirtualKeyboard(edit, false);
 } else {
  edit.OnFocus();
 }
}
ASPx.ELostFocusCore = function(name) {
 if(ASPx.Browser.VirtualKeyboardSupported) {
  var supressLostFocus = ASPx.VirtualKeyboardUI.isInputNativeBluring();
  if(supressLostFocus)
   return;
  ASPx.VirtualKeyboardUI.resetFocusedEditor();
 }
 var edit = ASPx.GetControlCollection().Get(name);
 if(edit != null) 
  edit.OnLostFocus();
}
ASPx.ELostFocus = wrapLostFocusHandler(ASPx.ELostFocusCore);
ASPx.ESGotFocus = function(name) {
 var edit = ASPx.GetControlCollection().Get(name); 
 if(!edit) return;
   if(ASPx.Browser.VirtualKeyboardSupported) {
  ASPx.VirtualKeyboardUI.onCallingVirtualKeyboard(edit, true);
 } else {
  edit.OnSpecialFocus();
 }
}
ASPx.ESLostFocusCore = function(name) {
 if(ASPx.Browser.VirtualKeyboardSupported) {
  var supressLostFocus = ASPx.VirtualKeyboardUI.isInputNativeBluring();
  if(supressLostFocus)
   return;
  ASPx.VirtualKeyboardUI.resetFocusedEditor();
 }
 var edit = ASPx.GetControlCollection().Get(name);
 if(!edit) return;
 if(edit.UseDelayedSpecialFocus())
  edit.specialFocusTimer = window.setTimeout(function() { edit.OnSpecialLostFocus(); }, 30);
 else
  edit.OnSpecialLostFocus();
}
ASPx.ESLostFocus = wrapLostFocusHandler(ASPx.ESLostFocusCore);
ASPx.EValueChanged = function(name) {
 var edit = ASPx.GetControlCollection().Get(name);
 if(edit != null)
  edit.OnValueChanged();
}
ASPx.VirtualKeyboardUI = (function() {
 var focusedEditor = null;
 var inputNativeFocusLocked = false;
 function elementBelongsToEditor(element) {
  if(!element) return false;
  var isBelongsToEditor = false;
  ASPx.GetControlCollection().ForEachControl(function(control) {
   if(ASPx.Ident.IsASPxClientEdit(control) && control.IsEditorElement(element)) {
    isBelongsToEditor = true;
    return true;
   }
  }, this);
  return isBelongsToEditor;
 }
 function elementBelongsToFocusedEditor(element) {
  return focusedEditor && focusedEditor.IsEditorElement(element);
 }
 return {
  onTouchStart: function (evt) {
   if (!ASPx.Browser.VirtualKeyboardSupported) return;
   inputNativeFocusLocked = false;
   if(ASPx.TouchUIHelper.pointerEnabled) {
    if(evt.pointerType != 'touch') 
     return;
    this.processFocusEditorControl(evt);
   } else
    ASPx.TouchUIHelper.handleFastTapIfRequired(evt,  function(){ this.processFocusEditorControl(evt); }.aspxBind(this), false);
  },
  processFocusEditorControl: function(evt) {
   var evtSource = ASPx.Evt.GetEventSource(evt);
   var timeEditHasAppliedFocus = focusedEditor && (ASPx.Ident.IsASPxClientTimeEdit && ASPx.Ident.IsASPxClientTimeEdit(focusedEditor));
   var focusedTimeEditBelongsToDateEdit = timeEditHasAppliedFocus && focusedEditor.OwnerDateEdit && focusedEditor.OwnerDateEdit.GetShowTimeSection();
   if(focusedTimeEditBelongsToDateEdit) {
    focusedEditor.OwnerDateEdit.ForceRefocusTimeSectionTimeEdit(evtSource);
    return;
   }
   var elementWithNativeFocus = ASPx.GetActiveElement();
   var someEditorInputIsFocused = elementBelongsToEditor(elementWithNativeFocus);
   var touchKeyboardIsVisible = someEditorInputIsFocused;
   var tapOutsideEditorAndInputs = !elementBelongsToEditor(evtSource) && !ASPx.Ident.IsFocusableElementRegardlessTabIndex(evtSource);
   var blurToHideTouchKeyboard = touchKeyboardIsVisible && tapOutsideEditorAndInputs;
   if(blurToHideTouchKeyboard) {
    elementWithNativeFocus.blur();
    return;
   }
   var tapOutsideFocusedEditor = focusedEditor && !elementBelongsToFocusedEditor(evtSource);
   if(tapOutsideFocusedEditor) {
    var focusedEditorWithBluredInput = !elementBelongsToFocusedEditor(elementWithNativeFocus);
    if(focusedEditorWithBluredInput) 
     this.lostAppliedFocusOfEditor();
   }
  },
  smartFocusEditor: function(edit) {
   if(!edit.focused) {
    this.setInputNativeFocusLocked(true);
    this.setFocusEditorCore(edit);
   } else {
    edit.ForceRefocusEditor();
   }
  },
  setFocusEditorCore: function(edit) {
   if(ASPx.Browser.MacOSMobilePlatform) {
    var timeoutDuration = ASPx.Browser.Chrome ? 250 : 30;
    window.setTimeout(function(){ edit.SetFocus(); }, timeoutDuration);
   } else {
    edit.SetFocus();
   }
  },
  onCallingVirtualKeyboard: function(edit, isSpecial) {
   this.setAppliedFocusOfEditor(edit, isSpecial);
   if(edit.specialKeyboardHandlingUsed == isSpecial && inputNativeFocusLocked)
    edit.BlurInputElement();
  },
  isInputNativeBluring: function() {
   return focusedEditor && inputNativeFocusLocked;
  },
  setInputNativeFocusLocked: function(locked) {
   inputNativeFocusLocked = locked;
  },
  getInputNativeFocusLocked: function() {
   return inputNativeFocusLocked;
  },
  setAppliedFocusOfEditor: function(edit, isSpecial) {
   if(focusedEditor === edit) {
    if(edit.specialKeyboardHandlingUsed == isSpecial) {
     focusedEditor.UnlockFocusEvents();
     if(focusedEditor.EnsureClearButtonVisibility)
      focusedEditor.EnsureClearButtonVisibility();
    }
    return;
   }
   if(edit.specialKeyboardHandlingUsed == isSpecial) {
    this.lostAppliedFocusOfEditor();
    focusedEditor = edit;
    ASPxClientEdit.SetFocusedEditor(edit);
   }
   if(isSpecial)
    edit.OnSpecialFocus();
   else
    edit.OnFocus();
  },
  lostAppliedFocusOfEditor: function() {
   if(!focusedEditor) return;
   var curEditorName = focusedEditor.name; 
   var skbdHandlingUsed = focusedEditor.specialKeyboardHandlingUsed;
   var focusedEditorInputElementExists = focusedEditor.GetInputElement();
   focusedEditor = null;
   if(!focusedEditorInputElementExists)
    return;
   ASPx.ELostFocusCore(curEditorName);
   if(skbdHandlingUsed)
    ASPx.ESLostFocusCore(curEditorName);
  },
  getFocusedEditor: function() {
   return focusedEditor;
  },
  resetFocusedEditor: function() {
   focusedEditor = null;
  },
  focusableInputElementIsActive: function(edit) {
   var inputElement = edit.GetFocusableInputElement();
   return !!inputElement ? ASPx.GetActiveElement() === inputElement : false;
  }
 }
})();
if(ASPx.Browser.VirtualKeyboardSupported) {
 var touchEventName = ASPx.TouchUIHelper.pointerEnabled ? ASPx.TouchUIHelper.pointerDownEventName : 'touchstart';
 ASPx.Evt.AttachEventToDocument(touchEventName, function(evt){ ASPx.VirtualKeyboardUI.onTouchStart(evt); });
}
ASPx.Evt.AttachEventToDocument("mousedown", function(evt) {
 var editor = ASPxClientEdit.GetFocusedEditor();
 if(!editor) 
  return;
 var evtSource = ASPx.Evt.GetEventSource(evt);
 if(editor.IsClearButtonElement(evtSource))
  return;
 if(editor.OwnerDateEdit && editor.OwnerDateEdit.GetShowTimeSection()) {
  editor.OwnerDateEdit.ForceRefocusTimeSectionTimeEdit(evtSource);
  return;
 }
 if(editor.IsEditorElement(evtSource) && !editor.IsElementBelongToInputElement(evtSource))
  editor.ForceRefocusEditor(evt);
});
ASPx.Evt.AttachEventToDocument(ASPx.Evt.GetMouseWheelEventName(), function(evt) {
 var editor = ASPxClientEdit.GetFocusedEditor();
 if(editor != null && ASPx.IsExistsElement(editor.GetMainElement()) && editor.focused && editor.receiveGlobalMouseWheel)
  editor.OnMouseWheel(evt);
});
ASPx.KBSIKeyDown = function(name, evt){
 var control = ASPx.GetControlCollection().Get(name);
 if(control != null){
  var isProcessed = control.OnSpecialKeyDown(evt);
  if(isProcessed)
   return ASPx.Evt.PreventEventAndBubble(evt);
 }
}
ASPx.KBSIKeyPress = function(name, evt){
 var control = ASPx.GetControlCollection().Get(name);
 if(control != null){
  var isProcessed = control.OnSpecialKeyPress(evt);
  if(isProcessed)
   return ASPx.Evt.PreventEventAndBubble(evt);
 }
}
ASPx.KBSIKeyUp = function(name, evt){
 var control = ASPx.GetControlCollection().Get(name);
 if(control != null){
  var isProcessed = control.OnSpecialKeyUp(evt);
  if(isProcessed)
   return ASPx.Evt.PreventEventAndBubble(evt);
 }
}
ASPx.ClearProcessingProc = function(edit) {
 return edit.Clear();
}
ASPx.ValidateProcessingProc = function(edit) {
 edit.OnValidation(ValidationType.MassValidation);
 return edit.GetIsValid();
}
ASPx.EditorsValidProcessingProc = function(edit) {
 return edit.GetIsValid();
}
var CheckEditElementHelper = ASPx.CreateClass(ASPx.CheckableElementHelper, {
 AttachToMainElement: function(internalCheckBox) {
  ASPx.CheckableElementHelper.prototype.AttachToMainElement.call(this, internalCheckBox);
  this.AttachToLabelElement(this.GetLabelElement(internalCheckBox.container), internalCheckBox);
 },
 AttachToLabelElement: function(labelElement, internalCheckBox) {
  var _this = this;
  if(labelElement) {
   ASPx.Evt.AttachEventToElement(labelElement, "click", 
    function (evt) { 
     _this.InvokeClick(internalCheckBox, evt);
    }
   );
   ASPx.Evt.AttachEventToElement(labelElement, "mousedown",
    function (evt) {
     internalCheckBox.Refocus();
    }
   );
  }
 },
 GetLabelElement: function(container) {
  var labelElement = ASPx.GetNodeByTagName(container, "LABEL", 0);
  if(!labelElement) {
   var labelCell = ASPx.GetNodeByClassName(container, "dxichTextCellSys", 0);
   labelElement = ASPx.GetNodeByTagName(labelCell, "SPAN", 0);
  }
  return labelElement;
 }
});
CheckEditElementHelper.Instance = new CheckEditElementHelper();
ASPx.ValidationType = ValidationType;
ASPx.ErrorFrameDisplay = ErrorFrameDisplay;
ASPx.EditElementSuffix = EditElementSuffix;
ASPx.ValidationPattern = ValidationPattern;
ASPx.RequiredFieldValidationPattern = RequiredFieldValidationPattern;
ASPx.RegularExpressionValidationPattern = RegularExpressionValidationPattern;
ASPx.CheckEditElementHelper = CheckEditElementHelper;
ASPx.IsEditorFocusable = _aspxIsEditorFocusable;
window.ASPxClientEditBase = ASPxClientEditBase;
window.ASPxClientEdit = ASPxClientEdit;
window.ASPxClientEditKeyEventArgs = ASPxClientEditKeyEventArgs;
window.ASPxClientEditValidationEventArgs = ASPxClientEditValidationEventArgs;
})();

