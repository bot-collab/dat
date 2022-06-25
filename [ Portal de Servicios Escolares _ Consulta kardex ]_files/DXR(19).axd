(function () {
ASPx.StateItemsExist = false;
ASPx.FocusedItemKind = "FocusedStateItem";
ASPx.HoverItemKind = "HoverStateItem";
ASPx.PressedItemKind = "PressedStateItem";
ASPx.SelectedItemKind = "SelectedStateItem";
ASPx.DisabledItemKind = "DisabledStateItem";
ASPx.CachedStatePrefix = "cached";
ASPxStateItem = ASPx.CreateClass(null, {
 constructor: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, kind, disableApplyingStyleToLink){
  this.name = name;
  this.classNames = classNames;
  this.customClassNames = [];
  this.resultClassNames = [];
  this.cssTexts = cssTexts;
  this.postfixes = postfixes;
  this.imageObjs = imageObjs;
  this.imagePostfixes = imagePostfixes;
  this.kind = kind;
  this.classNamePostfix = kind.substr(0, 1).toLowerCase();
  this.enabled = true;
  this.needRefreshBetweenElements = false;
  this.elements = null;
  this.images = null;
  this.links = [];
  this.linkColor = null;
  this.linkTextDecoration = null;
  this.disableApplyingStyleToLink = !!disableApplyingStyleToLink; 
 },
 GetCssText: function(index){
  if(ASPx.IsExists(this.cssTexts[index]))
   return this.cssTexts[index];
  return this.cssTexts[0];
 },
 CreateStyleRule: function(index){
  if(this.GetCssText(index) == "") return "";
  var styleSheet = ASPx.GetCurrentStyleSheet();
  if(styleSheet)
   return ASPx.CreateImportantStyleRule(styleSheet, this.GetCssText(index), this.classNamePostfix);  
  return ""; 
 },
 GetClassName: function(index){
  if(ASPx.IsExists(this.classNames[index]))
   return this.classNames[index];
  return this.classNames[0];
 },
 GetResultClassName: function(index){
  if(!ASPx.IsExists(this.resultClassNames[index])) {
   if(!ASPx.IsExists(this.customClassNames[index]))
    this.customClassNames[index] = this.CreateStyleRule(index);
   if(this.GetClassName(index) != "" && this.customClassNames[index] != "")
    this.resultClassNames[index] = this.GetClassName(index) + " " + this.customClassNames[index];
   else if(this.GetClassName(index) != "")
    this.resultClassNames[index] = this.GetClassName(index);
   else if(this.customClassNames[index] != "")
    this.resultClassNames[index] = this.customClassNames[index];
   else
    this.resultClassNames[index] = "";
  }
  return this.resultClassNames[index];
 },
 GetElements: function(element){
  if(!this.elements || !ASPx.IsValidElements(this.elements)){
   if(this.postfixes && this.postfixes.length > 0){
    this.elements = [ ];
    var parentNode = element.parentNode;
    if(parentNode){
     for(var i = 0; i < this.postfixes.length; i++){
      var id = this.name + this.postfixes[i];
      this.elements[i] = ASPx.GetChildById(parentNode, id);
      if(!this.elements[i])
       this.elements[i] = ASPx.GetElementById(id);
     }
    }
   }
   else
    this.elements = [element];
  }
  return this.elements;
 },
 GetImages: function(element){
  if(!this.images || !ASPx.IsValidElements(this.images)){
   this.images = [ ];
   if(this.imagePostfixes && this.imagePostfixes.length > 0){
    var elements = this.GetElements(element);
    for(var i = 0; i < this.imagePostfixes.length; i++){
     var id = this.name + this.imagePostfixes[i];
     for(var j = 0; j < elements.length; j++){
      if(!elements[j]) continue;
      if(elements[j].id == id)
       this.images[i] = elements[j];
      else
       this.images[i] = ASPx.GetChildById(elements[j], id);
      if(this.images[i])
       break;
     }
    }
   }
  }
  return this.images;
 },
 Apply: function(element){
  if(!this.enabled) return;
  try{
   this.ApplyStyle(element);
   if(this.imageObjs && this.imageObjs.length > 0)
    this.ApplyImage(element);
   if(ASPx.Browser.IE && ASPx.Browser.MajorVersion >= 11)
    this.ForceRedrawAppearance(element);
  }
  catch(e){
  }
 },
 ApplyStyle: function(element){
  var elements = this.GetElements(element);
  for(var i = 0; i < elements.length; i++){
   if(!elements[i]) continue;
   var className = elements[i].className.replace(this.GetResultClassName(i), "");
   elements[i].className = ASPx.Str.Trim(className) + " " + this.GetResultClassName(i);
   if(!ASPx.Browser.Opera || ASPx.Browser.Version >= 9)
    this.ApplyStyleToLinks(elements, i);
  }
 },
 ApplyStyleToLinks: function(elements, index){
  if(this.disableApplyingStyleToLink)
   return;
  if(!ASPx.IsValidElements(this.links[index]))
   this.links[index] = ASPx.GetNodesByTagName(elements[index], "A");
  for(var i = 0; i < this.links[index].length; i++)
   this.ApplyStyleToLinkElement(this.links[index][i], index);
 },
 ApplyStyleToLinkElement: function(link, index){
  if(this.GetLinkColor(index) != "")
   ASPx.Attr.ChangeAttributeExtended(link.style, "color", link, "saved" + this.kind + "Color", this.GetLinkColor(index));
  if(this.GetLinkTextDecoration(index) != "")
   ASPx.Attr.ChangeAttributeExtended(link.style, "textDecoration", link, "saved" + this.kind + "TextDecoration", this.GetLinkTextDecoration(index));
 },
 ApplyImage: function(element){
  var images = this.GetImages(element);
  for(var i = 0; i < images.length; i++){
   if(!images[i] || !this.imageObjs[i]) continue;
   var useSpriteImage = typeof(this.imageObjs[i]) != "string";
   var newUrl = "", newCssClass = "", newBackground = "";
   if(useSpriteImage){
    newUrl = ASPx.EmptyImageUrl;           
    if(this.imageObjs[i].spriteCssClass) 
     newCssClass = this.imageObjs[i].spriteCssClass;
    if(this.imageObjs[i].spriteBackground)
     newBackground = this.imageObjs[i].spriteBackground;
   }
   else{
    newUrl = this.imageObjs[i];
    if(ASPx.Attr.IsExistsAttribute(images[i].style, "background"))   
     newBackground = " ";
   }
   if(newUrl != "")
    ASPx.Attr.ChangeAttributeExtended(images[i], "src", images[i], "saved" + this.kind + "Src", newUrl);
   if(newCssClass != "")
    this.ApplyImageClassName(images[i], newCssClass);
   if(newBackground != ""){
    if(ASPx.Browser.WebKitFamily) {
     var savedBackground = ASPx.Attr.GetAttribute(images[i].style, "background");
     if(!useSpriteImage)
      savedBackground += " " + images[i].style["backgroundPosition"];
     ASPx.Attr.SetAttribute(images[i], "saved" + this.kind + "Background", savedBackground);
     ASPx.Attr.SetAttribute(images[i].style, "background", newBackground);
    }
    else
     ASPx.Attr.ChangeAttributeExtended(images[i].style, "background", images[i], "saved" + this.kind + "Background", newBackground);
   }     
  }
 },
 ApplyImageClassName: function(element, newClassName){
  var className = element.className.replace(newClassName, "");
  ASPx.Attr.SetAttribute(element, "saved" + this.kind + "ClassName", className);
  element.className = className + " " + newClassName;
 },
 Cancel: function(element){
  if(!this.enabled) return;
  try{  
   if(this.imageObjs && this.imageObjs.length > 0)
    this.CancelImage(element);
   this.CancelStyle(element);
  }
  catch(e){
  }
 },
 CancelStyle: function(element){
  var elements = this.GetElements(element);
  for(var i = 0; i < elements.length; i++){
   if(!elements[i]) continue;
   var className = ASPx.Str.Trim(elements[i].className.replace(this.GetResultClassName(i), ""));
   elements[i].className = className;
   if(!ASPx.Browser.Opera || ASPx.Browser.Version >= 9)
    this.CancelStyleFromLinks(elements, i);
  }
 },
 CancelStyleFromLinks: function(elements, index){
  if(this.disableApplyingStyleToLink)
   return;
  if(!ASPx.IsValidElements(this.links[index]))
   this.links[index] = ASPx.GetNodesByTagName(elements[index], "A");
  for(var i = 0; i < this.links[index].length; i++)
   this.CancelStyleFromLinkElement(this.links[index][i], index);
 },
 CancelStyleFromLinkElement: function(link, index){
  if(this.GetLinkColor(index) != "")
   ASPx.Attr.RestoreAttributeExtended(link.style, "color", link, "saved" + this.kind + "Color");
  if(this.GetLinkTextDecoration(index) != "")
   ASPx.Attr.RestoreAttributeExtended(link.style, "textDecoration", link, "saved" + this.kind + "TextDecoration");
 },
 CancelImage: function(element){
  var images = this.GetImages(element);
  for(var i = 0; i < images.length; i++){
   if(!images[i] || !this.imageObjs[i]) continue;
   ASPx.Attr.RestoreAttributeExtended(images[i], "src", images[i], "saved" + this.kind + "Src");
   this.CancelImageClassName(images[i]);
   ASPx.Attr.RestoreAttributeExtended(images[i].style, "background", images[i], "saved" + this.kind + "Background");
  }
 },
 CancelImageClassName: function(element){
  var savedClassName = ASPx.Attr.GetAttribute(element, "saved" + this.kind + "ClassName");
  if(ASPx.IsExists(savedClassName)) {
   element.className = savedClassName;
   ASPx.Attr.RemoveAttribute(element, "saved" + this.kind + "ClassName");
  }
 },
 Clone: function(){
  return new ASPxStateItem(this.name, this.classNames, this.cssTexts, this.postfixes, 
   this.imageObjs, this.imagePostfixes, this.kind, this.disableApplyingStyleToLink);
 },
 IsChildElement: function(element){
  if(element != null){
   var elements = this.GetElements(element);
   for(var i = 0; i < elements.length; i++){
    if(!elements[i]) continue;
    if(ASPx.GetIsParent(elements[i], element)) 
     return true;
   }
  }
  return false;
 },
 ForceRedrawAppearance: function(element) {
  var value = element.style.opacity;
  element.style.opacity = "0.7777";
  var dummy = element.offsetWidth;
  element.style.opacity = value;
 },
 GetLinkColor: function(index){
  if(!ASPx.IsExists(this.linkColor)){
   var rule = ASPx.GetStyleSheetRules(this.customClassNames[index]);
   this.linkColor = rule ? rule.style.color : null;
   if(!ASPx.IsExists(this.linkColor)){
    var rule = ASPx.GetStyleSheetRules(this.GetClassName(index));
    this.linkColor = rule ? rule.style.color : null;
   }
   if(this.linkColor == null) 
    this.linkColor = "";
  }
  return this.linkColor;
 },
 GetLinkTextDecoration: function(index){
  if(!ASPx.IsExists(this.linkTextDecoration)){
   var rule = ASPx.GetStyleSheetRules(this.customClassNames[index]);
   this.linkTextDecoration = rule ? rule.style.textDecoration : null;
   if(!ASPx.IsExists(this.linkTextDecoration)){
    var rule = ASPx.GetStyleSheetRules(this.GetClassName(index));
    this.linkTextDecoration = rule ? rule.style.textDecoration : null;
   }
   if(this.linkTextDecoration == null) 
    this.linkTextDecoration = "";
  }
  return this.linkTextDecoration;
 }
});
ASPxClientStateEventArgs = ASPx.CreateClass(null, {
 constructor: function(item, element){
  this.item = item;
  this.element = element;
  this.toElement = null;
  this.fromElement = null;
  this.htmlEvent = null;
 }
});
ASPxStateController = ASPx.CreateClass(null, {
 constructor: function(){
  this.focusedItems = { };
  this.hoverItems = { };
  this.pressedItems = { };
  this.selectedItems = { };
  this.disabledItems = { };
  this.disabledScheme = {};
  this.currentFocusedElement = null;
  this.currentFocusedItemName = null;
  this.currentHoverElement = null;
  this.currentHoverItemName = null;
  this.currentPressedElement = null;
  this.currentPressedItemName = null;
  this.savedCurrentPressedElement = null;
  this.savedCurrentMouseMoveSrcElement = null;
  this.AfterSetFocusedState = new ASPxClientEvent();
  this.AfterClearFocusedState = new ASPxClientEvent();
  this.AfterSetHoverState = new ASPxClientEvent();
  this.AfterClearHoverState = new ASPxClientEvent();
  this.AfterSetPressedState = new ASPxClientEvent();
  this.AfterClearPressedState = new ASPxClientEvent();
  this.AfterDisabled = new ASPxClientEvent();
  this.AfterEnabled = new ASPxClientEvent();
  this.BeforeSetFocusedState = new ASPxClientEvent();
  this.BeforeClearFocusedState = new ASPxClientEvent();
  this.BeforeSetHoverState = new ASPxClientEvent();
  this.BeforeClearHoverState = new ASPxClientEvent();
  this.BeforeSetPressedState = new ASPxClientEvent();
  this.BeforeClearPressedState = new ASPxClientEvent();
  this.BeforeDisabled = new ASPxClientEvent();
  this.BeforeEnabled = new ASPxClientEvent();
  this.FocusedItemKeyDown = new ASPxClientEvent();
 }, 
 AddHoverItem: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink){
  this.AddItem(this.hoverItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, ASPx.HoverItemKind, disableApplyingStyleToLink);
  this.AddItem(this.focusedItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, ASPx.FocusedItemKind, disableApplyingStyleToLink);
 },
 AddPressedItem: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes ,disableApplyingStyleToLink){
  this.AddItem(this.pressedItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, ASPx.PressedItemKind, disableApplyingStyleToLink);
 },
 AddSelectedItem: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink){
  this.AddItem(this.selectedItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, ASPx.SelectedItemKind, disableApplyingStyleToLink);
 },
 AddDisabledItem: function (name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink, rootId) {
  this.AddItem(this.disabledItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes,
   ASPx.DisabledItemKind, disableApplyingStyleToLink, this.addIdToDisabledItemScheme, rootId);
 },
 addIdToDisabledItemScheme: function(rootId, childId) {
  if (!rootId)
   return;
  if (!this.disabledScheme[rootId])
   this.disabledScheme[rootId] = [rootId];
  if (childId && (rootId != childId) && ASPx.Data.ArrayIndexOf(this.disabledScheme[rootId], childId) == -1)
   this.disabledScheme[rootId].push(childId);
 },
 removeIdFromDisabledItemScheme: function(rootId, childId) {
  if (!rootId || !this.disabledScheme[rootId])
   return;
  ASPx.Data.ArrayRemove(this.disabledScheme[rootId], childId);
  if (this.disabledScheme[rootId].length == 0)
   delete this.disabledScheme[rootId];
 },
 AddItem: function (items, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, kind, disableApplyingStyleToLink, onAdd, rootId) {
  var stateItem = new ASPxStateItem(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, kind, disableApplyingStyleToLink);
  if (postfixes && postfixes.length > 0) {
   for (var i = 0; i < postfixes.length; i++) {
    items[name + postfixes[i]] = stateItem;
    if (onAdd)
     onAdd.call(this, rootId, name + postfixes[i]);
   }
  }
  else {
   if (onAdd)
    onAdd.call(this, rootId, name);
   items[name] = stateItem;
  }
  ASPx.StateItemsExist = true;
 },
 RemoveHoverItem: function(name, postfixes){
  this.RemoveItem(this.hoverItems, name, postfixes);
  this.RemoveItem(this.focusedItems, name, postfixes);
 },
 RemovePressedItem: function(name, postfixes){
  this.RemoveItem(this.pressedItems, name, postfixes);
 },
 RemoveSelectedItem: function(name, postfixes){
  this.RemoveItem(this.selectedItems, name, postfixes);
 },
 RemoveDisabledItem: function (name, postfixes, rootId) {
  this.RemoveItem(this.disabledItems, name, postfixes, this.removeIdFromDisabledItemScheme, rootId);
 },
 RemoveItem: function (items, name, postfixes, onRemove, rootId) {
  if (postfixes && postfixes.length > 0) {
   for (var i = 0; i < postfixes.length; i++) {
    delete items[name + postfixes[i]];
    if (onRemove)
     onRemove.call(this, rootId, name + postfixes[i]);
   }
  }
  else {
   delete items[name];
   if (onRemove)
    onRemove.call(this, rootId, name);
  }
 },
 RemoveDisposedItems: function(){
  this.RemoveDisposedItemsByType(this.hoverItems);
  this.RemoveDisposedItemsByType(this.pressedItems);
  this.RemoveDisposedItemsByType(this.focusedItems);
  this.RemoveDisposedItemsByType(this.selectedItems);
  this.RemoveDisposedItemsByType(this.disabledItems);
  this.RemoveDisposedItemsByType(this.disabledScheme);
 },
 RemoveDisposedItemsByType: function(items){
  for(var key in items) {
   var item = items[key];
   var element = document.getElementById(key);
   if(!element || !ASPx.IsValidElement(element))
    delete items[key];
   try{
    if(item && item.elements) {
     for(var i = 0; i < item.elements.length; i++) {
      if(!ASPx.IsValidElements(item.links[i]))
       item.links[i] = null;
     }
    }
   }
   catch(e){
   }
  }
 },
 GetFocusedElement: function(srcElement){
  return this.GetItemElement(srcElement, this.focusedItems, ASPx.FocusedItemKind);
 },
 GetHoverElement: function(srcElement){
  return this.GetItemElement(srcElement, this.hoverItems, ASPx.HoverItemKind);
 },
 GetPressedElement: function(srcElement){
  return this.GetItemElement(srcElement, this.pressedItems, ASPx.PressedItemKind);
 },
 GetSelectedElement: function(srcElement){
  return this.GetItemElement(srcElement, this.selectedItems, ASPx.SelectedItemKind);
 },
 GetDisabledElement: function(srcElement){
  return this.GetItemElement(srcElement, this.disabledItems, ASPx.DisabledItemKind);
 },
 GetItemElement: function(srcElement, items, kind){
  if(srcElement && srcElement[ASPx.CachedStatePrefix + kind]){
   var cachedElement = srcElement[ASPx.CachedStatePrefix + kind];
   if(cachedElement != ASPx.EmptyObject)
    return cachedElement;
   return null;
  }
  var element = srcElement;
  while(element != null) {
   var item = items[element.id];
   if(item){
    this.CacheItemElement(srcElement, kind, element);
    element[kind] = item;
    return element;
   }
   element = element.parentNode;
  }
  this.CacheItemElement(srcElement, kind, ASPx.EmptyObject);
  return null;
 },
 CacheItemElement: function(srcElement, kind, value){
  if(srcElement && !srcElement[ASPx.CachedStatePrefix + kind])
   srcElement[ASPx.CachedStatePrefix + kind] = value;
 },
 DoSetFocusedState: function(element, fromElement){
  var item = element[ASPx.FocusedItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   args.fromElement = fromElement;
   this.BeforeSetFocusedState.FireEvent(this, args);
   item.Apply(element);
   this.AfterSetFocusedState.FireEvent(this, args);
  }
 },
 DoClearFocusedState: function(element, toElement){
  var item = element[ASPx.FocusedItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   args.toElement = toElement;
   this.BeforeClearFocusedState.FireEvent(this, args);
   item.Cancel(element);
   this.AfterClearFocusedState.FireEvent(this, args);
  }
 },
 DoSetHoverState: function(element, fromElement){
  var item = element[ASPx.HoverItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   args.fromElement = fromElement;
   this.BeforeSetHoverState.FireEvent(this, args);
   item.Apply(element);
   this.AfterSetHoverState.FireEvent(this, args);
  }
 },
 DoClearHoverState: function(element, toElement){
  var item = element[ASPx.HoverItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   args.toElement = toElement;
   this.BeforeClearHoverState.FireEvent(this, args);
   item.Cancel(element);
   this.AfterClearHoverState.FireEvent(this, args);
  }
 },
 DoSetPressedState: function(element){
  var item = element[ASPx.PressedItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   this.BeforeSetPressedState.FireEvent(this, args);
   item.Apply(element);
   this.AfterSetPressedState.FireEvent(this, args);
  }
 },
 DoClearPressedState: function(element){
  var item = element[ASPx.PressedItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   this.BeforeClearPressedState.FireEvent(this, args);
   item.Cancel(element);
   this.AfterClearPressedState.FireEvent(this, args);
  }
 },
 SetCurrentFocusedElement: function(element){
  if(this.currentFocusedElement && !ASPx.IsValidElement(this.currentFocusedElement)){
   this.currentFocusedElement = null;
   this.currentFocusedItemName = "";
  }
  if(this.currentFocusedElement != element){
   var oldCurrentFocusedElement = this.currentFocusedElement;
   var item = (element != null) ? element[ASPx.FocusedItemKind] : null;
   var itemName = (item != null) ? item.name : "";
   if(this.currentFocusedItemName != itemName){
    if(this.currentHoverItemName != "")
     this.SetCurrentHoverElement(null);
    if(this.currentFocusedElement != null)
     this.DoClearFocusedState(this.currentFocusedElement, element);
    this.currentFocusedElement = element;
    item = (element != null) ? element[ASPx.FocusedItemKind] : null;
    this.currentFocusedItemName = (item != null) ? item.name : "";
    if(this.currentFocusedElement != null)
     this.DoSetFocusedState(this.currentFocusedElement, oldCurrentFocusedElement);
   }
  }
 },
 SetCurrentHoverElement: function(element){
  if(this.currentHoverElement && !ASPx.IsValidElement(this.currentHoverElement)){
   this.currentHoverElement = null;
   this.currentHoverItemName = "";
  }
  var item = (element != null) ? element[ASPx.HoverItemKind] : null;
  if(item && !item.enabled) { 
   element = this.GetItemElement(element.parentNode, this.hoverItems, ASPx.HoverItemKind);
   item = (element != null) ? element[ASPx.HoverItemKind] : null;
  }
  if(this.currentHoverElement != element){
   var oldCurrentHoverElement = this.currentHoverElement,
    itemName = (item != null) ? item.name : "";
   if(this.currentHoverItemName != itemName || (item != null && item.needRefreshBetweenElements)){
    if(this.currentHoverElement != null)
     this.DoClearHoverState(this.currentHoverElement, element);
    item = (element != null) ? element[ASPx.HoverItemKind] : null;
    if(item == null || item.enabled){
     this.currentHoverElement = element;
     this.currentHoverItemName = (item != null) ? item.name : "";
     if(this.currentHoverElement != null)
      this.DoSetHoverState(this.currentHoverElement, oldCurrentHoverElement);
    }
   }
  }
 },
 SetCurrentPressedElement: function(element){
  if(this.currentPressedElement && !ASPx.IsValidElement(this.currentPressedElement)){
   this.currentPressedElement = null;
   this.currentPressedItemName = "";
  }
  if(this.currentPressedElement != element){
   if(this.currentPressedElement != null)
    this.DoClearPressedState(this.currentPressedElement);
   var item = (element != null) ? element[ASPx.PressedItemKind] : null;
   if(item == null || item.enabled){
    this.currentPressedElement = element;
    this.currentPressedItemName = (item != null) ? item.name : "";
    if(this.currentPressedElement != null)
     this.DoSetPressedState(this.currentPressedElement);
   }
  }
 },
 SetCurrentFocusedElementBySrcElement: function(srcElement){
  var element = this.GetFocusedElement(srcElement);
  this.SetCurrentFocusedElement(element);
 },
 SetCurrentHoverElementBySrcElement: function(srcElement){
  var element = this.GetHoverElement(srcElement);
  this.SetCurrentHoverElement(element);
 },
 SetCurrentPressedElementBySrcElement: function(srcElement){
  var element = this.GetPressedElement(srcElement);
  this.SetCurrentPressedElement(element);
 },
 SetPressedElement: function (element) {
  this.SetCurrentHoverElement(null);
  this.SetCurrentPressedElementBySrcElement(element);
  this.savedCurrentPressedElement = this.currentPressedElement;
 },
 SelectElement: function (element) {
  var item = element[ASPx.SelectedItemKind];
  if(item)
   item.Apply(element);
 }, 
 SelectElementBySrcElement: function(srcElement){
  var element = this.GetSelectedElement(srcElement);
  if(element != null) this.SelectElement(element);
 }, 
 DeselectElement: function(element){
  var item = element[ASPx.SelectedItemKind];
  if(item)
   item.Cancel(element);
 }, 
 DeselectElementBySrcElement: function(srcElement){
  var element = this.GetSelectedElement(srcElement);
  if(element != null) this.DeselectElement(element);
 },
 SetElementEnabled: function(element, enable){
  if(enable)
   this.EnableElement(element);
  else
   this.DisableElement(element);
 },
 SetElementWithChildNodesEnabled: function (parentName, enabled) {
  var procFunct = (enabled ? this.EnableElement : this.DisableElement);
  var childItems = this.disabledScheme[parentName];
  if (childItems && childItems.length > 0)
   for (var i = 0; i < childItems.length; i++) {
    procFunct.call(this, document.getElementById(childItems[i]));
   }
 },
 DisableElement: function (element) {
  var element = this.GetDisabledElement(element);
  if(element != null) {
   var item = element[ASPx.DisabledItemKind];
   if(item){
    var args = new ASPxClientStateEventArgs(item, element);
    this.BeforeDisabled.FireEvent(this, args);
    if(item.name == this.currentPressedItemName)
     this.SetCurrentPressedElement(null);
    if(item.name == this.currentHoverItemName)
     this.SetCurrentHoverElement(null);
    item.Apply(element);
    this.SetMouseStateItemsEnabled(item.name, item.postfixes, false);
    this.AfterDisabled.FireEvent(this, args);
   }
  }
 }, 
 EnableElement: function(element){
  var element = this.GetDisabledElement(element);
  if(element != null) {
   var item = element[ASPx.DisabledItemKind];
   if(item){
    var args = new ASPxClientStateEventArgs(item, element);
    this.BeforeEnabled.FireEvent(this, args);
    item.Cancel(element);
    this.SetMouseStateItemsEnabled(item.name, item.postfixes, true);
    this.AfterEnabled.FireEvent(this, args);
   }
  }
 }, 
 SetMouseStateItemsEnabled: function(name, postfixes, enabled){   
  if(postfixes && postfixes.length > 0){
   for(var i = 0; i < postfixes.length; i ++){
    this.SetItemsEnabled(this.hoverItems, name + postfixes[i], enabled);
    this.SetItemsEnabled(this.pressedItems, name + postfixes[i], enabled);
    this.SetItemsEnabled(this.focusedItems, name + postfixes[i], enabled);
   }
  }
  else{
   this.SetItemsEnabled(this.hoverItems, name, enabled);
   this.SetItemsEnabled(this.pressedItems, name, enabled);
   this.SetItemsEnabled(this.focusedItems, name, enabled);
  }  
 },
 SetItemsEnabled: function(items, name, enabled){   
  if(items[name])
   items[name].enabled = enabled;
 },
 OnFocusMove: function(evt){
  var element = ASPx.Evt.GetEventSource(evt);
  aspxGetStateController().SetCurrentFocusedElementBySrcElement(element);
 },
 OnMouseMove: function(evt, checkElementChanged){
  var srcElement = ASPx.Evt.GetEventSource(evt);
  if(checkElementChanged && srcElement == this.savedCurrentMouseMoveSrcElement) return;
  this.savedCurrentMouseMoveSrcElement = srcElement;
  if(ASPx.Browser.IE && !ASPx.Evt.IsLeftButtonPressed(evt) && this.savedCurrentPressedElement != null)
   this.ClearSavedCurrentPressedElement();
  if(this.savedCurrentPressedElement == null)
   this.SetCurrentHoverElementBySrcElement(srcElement);
  else{
   var element = this.GetPressedElement(srcElement);
   if(element != this.currentPressedElement){
    if(element == this.savedCurrentPressedElement)
     this.SetCurrentPressedElement(this.savedCurrentPressedElement);
    else
     this.SetCurrentPressedElement(null);
   }
  }
 },
 OnMouseDown: function(evt){
  if(!ASPx.Evt.IsLeftButtonPressed(evt)) return;
  var srcElement = ASPx.Evt.GetEventSource(evt);
  this.OnMouseDownOnElement(srcElement);
 },
 OnMouseDownOnElement: function (element) {
  if(this.GetPressedElement(element) == null) return;
  this.SetPressedElement(element);
 },
 OnMouseUp: function(evt){
  var srcElement = ASPx.Evt.GetEventSource(evt);
  this.OnMouseUpOnElement(srcElement);
 },
 OnMouseUpOnElement: function(element){
  if(this.savedCurrentPressedElement == null) return;
  this.ClearSavedCurrentPressedElement();
  this.SetCurrentHoverElementBySrcElement(element);
 },
 OnMouseOver: function(evt){
  var element = ASPx.Evt.GetEventSource(evt);
  if(element && element.tagName == "IFRAME")
   this.OnMouseMove(evt, true);
 },
 OnKeyDown: function(evt){
  var element = this.GetFocusedElement(ASPx.Evt.GetEventSource(evt));
  if(element != null && element == this.currentFocusedElement) {
   var item = element[ASPx.FocusedItemKind];
   if(item){
    var args = new ASPxClientStateEventArgs(item, element);
    args.htmlEvent = evt;
    this.FocusedItemKeyDown.FireEvent(this, args);
   }
  }
 },
 OnSelectStart: function(evt){
  if(this.savedCurrentPressedElement) {
   ASPx.Selection.Clear();
   return false;
  }
 },
 ClearSavedCurrentPressedElement: function() {
  this.savedCurrentPressedElement = null;
  this.SetCurrentPressedElement(null);
 },
 ClearCache: function(srcElement, kind) {
  if(srcElement[ASPx.CachedStatePrefix + kind])
   srcElement[ASPx.CachedStatePrefix + kind] = null;
 },
 ClearElementCache: function(srcElement) {
  this.ClearCache(srcElement, ASPx.FocusedItemKind);
  this.ClearCache(srcElement, ASPx.HoverItemKind);
  this.ClearCache(srcElement, ASPx.PressedItemKind);
  this.ClearCache(srcElement, ASPx.SelectedItemKind);
  this.ClearCache(srcElement, ASPx.DisabledItemKind);
 }
});
var stateController = null;
function aspxGetStateController(){
 if(stateController == null)
  stateController = new ASPxStateController();
 return stateController;
}
function aspxAddStateItems(method, namePrefix, classes, disableApplyingStyleToLink){
 for(var i = 0; i < classes.length; i ++){
  for(var j = 0; j < classes[i][2].length; j ++) {
   var name = namePrefix;
   if(classes[i][2][j])
    name += "_" + classes[i][2][j];
   var postfixes = classes[i][3] || null;
   var imageObjs = (classes[i][4] && classes[i][4][j]) || null;
   var imagePostfixes = classes[i][5] || null;
   method.call(aspxGetStateController(), name, classes[i][0], classes[i][1], postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink, namePrefix);
  }
 }
}
ASPx.AddHoverItems = function(namePrefix, classes, disableApplyingStyleToLink){
 aspxAddStateItems(aspxGetStateController().AddHoverItem, namePrefix, classes, disableApplyingStyleToLink);
}
ASPx.AddPressedItems = function(namePrefix, classes, disableApplyingStyleToLink){
 aspxAddStateItems(aspxGetStateController().AddPressedItem, namePrefix, classes, disableApplyingStyleToLink);
}
ASPx.AddSelectedItems = function(namePrefix, classes, disableApplyingStyleToLink){
 aspxAddStateItems(aspxGetStateController().AddSelectedItem, namePrefix, classes, disableApplyingStyleToLink);
}
ASPx.AddDisabledItems = function(namePrefix, classes, disableApplyingStyleToLink){
 aspxAddStateItems(aspxGetStateController().AddDisabledItem, namePrefix, classes, disableApplyingStyleToLink);
}
function aspxRemoveStateItems(method, namePrefix, classes){
 for(var i = 0; i < classes.length; i ++){
  for(var j = 0; j < classes[i][0].length; j ++) {
   var name = namePrefix;
   if(classes[i][0][j])
    name += "_" + classes[i][0][j];
   method.call(aspxGetStateController(), name, classes[i][1], namePrefix);
  }
 }
}
ASPx.RemoveHoverItems = function(namePrefix, classes){
 aspxRemoveStateItems(aspxGetStateController().RemoveHoverItem, namePrefix, classes);
}
ASPx.RemovePressedItems = function(namePrefix, classes){
 aspxRemoveStateItems(aspxGetStateController().RemovePressedItem, namePrefix, classes);
}
ASPx.RemoveSelectedItems = function(namePrefix, classes){
 aspxRemoveStateItems(aspxGetStateController().RemoveSelectedItem, namePrefix, classes);
}
ASPx.RemoveDisabledItems = function(namePrefix, classes){
 aspxRemoveStateItems(aspxGetStateController().RemoveDisabledItem, namePrefix, classes);
}
ASPx.AddAfterClearFocusedState = function(handler){
 aspxGetStateController().AfterClearFocusedState.AddHandler(handler);
}
ASPx.AddAfterSetFocusedState = function(handler){
 aspxGetStateController().AfterSetFocusedState.AddHandler(handler);
}
ASPx.AddAfterClearHoverState = function(handler){
 aspxGetStateController().AfterClearHoverState.AddHandler(handler);
}
ASPx.AddAfterSetHoverState = function(handler){
 aspxGetStateController().AfterSetHoverState.AddHandler(handler);
}
ASPx.AddAfterClearPressedState = function(handler){
 aspxGetStateController().AfterClearPressedState.AddHandler(handler);
}
ASPx.AddAfterSetPressedState = function(handler){
 aspxGetStateController().AfterSetPressedState.AddHandler(handler);
}
ASPx.AddAfterDisabled = function(handler){
 aspxGetStateController().AfterDisabled.AddHandler(handler);
}
ASPx.AddAfterEnabled = function(handler){
 aspxGetStateController().AfterEnabled.AddHandler(handler);
}
ASPx.AddBeforeClearFocusedState = function(handler){
 aspxGetStateController().BeforeClearFocusedState.AddHandler(handler);
}
ASPx.AddBeforeSetFocusedState = function(handler){
 aspxGetStateController().BeforeSetFocusedState.AddHandler(handler);
}
ASPx.AddBeforeClearHoverState = function(handler){
 aspxGetStateController().BeforeClearHoverState.AddHandler(handler);
}
ASPx.AddBeforeSetHoverState = function(handler){
 aspxGetStateController().BeforeSetHoverState.AddHandler(handler);
}
ASPx.AddBeforeClearPressedState = function(handler){
 aspxGetStateController().BeforeClearPressedState.AddHandler(handler);
}
ASPx.AddBeforeSetPressedState = function(handler){
 aspxGetStateController().BeforeSetPressedState.AddHandler(handler);
}
ASPx.AddBeforeDisabled = function(handler){
 aspxGetStateController().BeforeDisabled.AddHandler(handler);
}
ASPx.AddBeforeEnabled = function(handler){
 aspxGetStateController().BeforeEnabled.AddHandler(handler);
}
ASPx.AddFocusedItemKeyDown = function(handler){
 aspxGetStateController().FocusedItemKeyDown.AddHandler(handler);
}
ASPx.SetHoverState = function(element){
 aspxGetStateController().SetCurrentHoverElementBySrcElement(element);
}
ASPx.ClearHoverState = function(evt){
 aspxGetStateController().SetCurrentHoverElementBySrcElement(null);
}
ASPx.UpdateHoverState = function(evt){
 aspxGetStateController().OnMouseMove(evt, false);
}
ASPx.SetFocusedState = function(element){
 aspxGetStateController().SetCurrentFocusedElementBySrcElement(element);
}
ASPx.ClearFocusedState = function(evt){
 aspxGetStateController().SetCurrentFocusedElementBySrcElement(null);
}
ASPx.UpdateFocusedState = function(evt){
 aspxGetStateController().OnFocusMove(evt);
}
ASPx.AccessibilityMarkerClass = "dxalink";
ASPx.AssignAccessabilityEventsToChildrenLinks = function(container){
 var links = ASPx.GetNodesByPartialClassName(container, ASPx.AccessibilityMarkerClass);
 for(var i = 0; i < links.length; i++)
  ASPx.AssignAccessabilityEventsToLink(links[i]);
}
ASPx.AssignAccessabilityEventsToLink = function(link) {
 if(!ASPx.ElementContainsCssClass(link, ASPx.AccessibilityMarkerClass))
  return;
 ASPx.Evt.AttachEventToElement(link, "focus", function(e) { ASPx.UpdateFocusedState(e); });
 ASPx.Evt.AttachEventToElement(link, "blur", function(e) { ASPx.ClearFocusedState(e); });
}
ASPx.Evt.AttachEventToDocument("mousemove", function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  aspxGetStateController().OnMouseMove(evt, true);
});
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseDownEventName, function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  aspxGetStateController().OnMouseDown(evt);
});
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseUpEventName, function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  aspxGetStateController().OnMouseUp(evt);
});
ASPx.Evt.AttachEventToDocument("mouseover", function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  aspxGetStateController().OnMouseOver(evt);
});
ASPx.Evt.AttachEventToDocument("keydown", function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  aspxGetStateController().OnKeyDown(evt);
});
ASPx.Evt.AttachEventToDocument("selectstart", function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  return aspxGetStateController().OnSelectStart(evt);
});
ASPx.GetStateController = aspxGetStateController;
})();
