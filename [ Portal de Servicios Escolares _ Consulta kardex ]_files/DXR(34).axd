(function() {
 var ASPxClientStaticEdit = ASPx.CreateClass(ASPxClientEditBase, { 
  constructor: function(name) {
   this.constructor.prototype.constructor.call(this, name);
   this.Click = new ASPxClientEvent();
  },
  OnClick: function(htmlEvent) {
   this.RaiseClick(this.GetMainElement(), htmlEvent);
  },
  RaiseClick: function(htmlElement, htmlEvent){
   if(!this.Click.IsEmpty()){
    var args = new ASPxClientEditClickEventArgs(htmlElement, htmlEvent);
    this.Click.FireEvent(this, args);
   }
  },
  ChangeEnabledAttributes: function(enabled){
   this.ChangeMainElementAttributes(this.GetMainElement(), ASPx.Attr.ChangeAttributesMethod(enabled));
  },
  ChangeEnabledStateItems: function(enabled){
   ASPx.GetStateController().SetElementEnabled(this.GetMainElement(), enabled);
  },
  ChangeMainElementAttributes: function(element, method){
   method(element, "onclick");
  },
  AssignEllipsisToolTipsCore: function() {
   this.AssignEllipsisToolTip(this.GetMainElement());
  }
 });
 var ASPxClientEditClickEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
  constructor: function(htmlElement, htmlEvent){
   this.constructor.prototype.constructor.call(this);
   this.htmlElement = htmlElement;
   this.htmlEvent = htmlEvent;
  }
 });
 var ASPxClientHyperLink = ASPx.CreateClass(ASPxClientStaticEdit, {
  constructor: function(name) {
   this.constructor.prototype.constructor.call(this, name);
   this.sizingConfig.allowSetWidth = false;
   this.sizingConfig.allowSetHeight = false;
  },
  Initialize: function() {
   ASPxClientControl.prototype.Initialize.call(this);
   this.AssignEllipsisToolTips();
  },
  GetNavigateUrl: function(){
   var element = this.GetMainElement();
   if(ASPx.IsExistsElement(element))
    return element.href;
   return "";
  },
  SetNavigateUrl: function(url){
   var element = this.GetMainElement();
   if(ASPx.IsExistsElement(element))
    element.href = url;
  },
  GetText: function(){
   return this.GetValue();
  },
  SetText: function(value){
   this.SetValue(value);
  },
  ChangeMainElementAttributes: function(element, method){
   ASPxClientStaticEdit.prototype.ChangeMainElementAttributes.call(this, element, method);
   method(element, "href");
  }
 });
 ASPxClientHyperLink.Cast = ASPxClientControl.Cast;
 var ASPxClientImageBase = ASPx.CreateClass(ASPxClientStaticEdit, {
  constructor: function(name) {
   this.constructor.prototype.constructor.call(this, name);
   this.imageWidth = "";
   this.imageHeight = "";
  },
  GetWidth: function(){
   return this.GetSize(true);
  },
  GetHeight: function(){
   return this.GetSize(false);
  },
  SetWidth: function(width) {
   this.SetSize(width, this.GetHeight());
  },
  SetHeight: function(height) {
   this.SetSize(this.GetWidth(), height);
  },
  SetSize: function(width, height){
   this.imageWidth = width + "px";
   this.imageHeight = height + "px";
   var image = this.GetMainElement();
   if(ASPx.IsExistsElement(image))
    ASPx.ImageUtils.SetSize(image, width, height);
  },
  GetSize: function(isWidth){
   var image = this.GetMainElement();
   if(ASPx.IsExistsElement(image))
    return ASPx.ImageUtils.GetSize(image, isWidth);
   return -1;
  }
 });
 var ASPxClientImage = ASPx.CreateClass(ASPxClientImageBase, {
  constructor: function(name) {
   this.constructor.prototype.constructor.call(this, name);
   this.emptyImageUrl = "";
   this.emptyImageToolTip = "";
   this.emptyImageWidth = "";
   this.emptyImageHeight = "";
   this.imageAlt = "";
   this.imageToolTip = "";
   this.isEmpty = false;
  },
  GetValue: function () {
   if (!this.isEmpty) {
    var image = this.GetMainElement();
    if (ASPx.IsExistsElement(image))
     return image.src;
   }
   return "";
  },
  SetValue: function (value) {
   if (value == null) value = "";
   this.isEmpty = (value == "");
   var image = this.GetMainElement();
   if (ASPx.IsExistsElement(image)) {
    if (image.dxShowLoadingImage)
     this.isEmpty ? this.setEmptyImage() : this.setImageUrlInternal(value);     
    else
     image.src = value;
   }
  },
  GetImageUrl: function(url){
   return this.GetValue();
  },
  SetImageUrl: function (url) {
   this.SetValue(url);
  },
  setEmptyImage: function () {
   this.setImageUrlInternal(this.emptyImageUrl || ASPx.EmptyImageUrl);
  },
  setImageUrlInternal: function (realSrc) {
   this.prepareRealImage();
   this.requestViaFakeImage(realSrc);
  },
  saveAndClearImageSettings: function () {
   var image = this.GetMainElement();
   if (this.isEmpty) {
    image.style.width = this.emptyImageWidth;
    image.style.height = this.emptyImageHeight;
    if (ASPx.IsExists(this.emptyImageAlt)) 
     image.alt = this.emptyImageAlt;
    if (ASPx.IsExists(this.emptyImageToolTip)) 
     image.title = this.emptyImageToolTip;
   };
   this.imageSettings = {
    image: image,
    background: image.style.background,
    alt: image.alt,
    title: image.title
   };
   image.alt = "";
   var isOldIE = ASPx.Browser.IE && ASPx.Browser.Version < 9;
   ASPx.ASPxImageLoad.removeASPxImageBackground(image, isOldIE);
  },
  showLoadingImage: function () {
   var image = this.GetMainElement();
   ASPx.AddClassNameToElement(image, ASPx.ASPxImageLoad.dxDefaultLoadingImageCssClass);
   if (image.dxCustomLoadingImage)
    image.style.backgroundImage = image.dxCustomLoadingImage;
  },
  prepareRealImage: function () {
   this.saveAndClearImageSettings();
   this.showLoadingImage();
   var realImage = this.GetMainElement();
   realImage.src = "";
  },
  requestViaFakeImage: function (realSrc) {
   var fakeImage = document.createElement("IMG");
   fakeImage.imageSettings = this.imageSettings;
   fakeImage.restoreRealImage = this.restoreRealImage;
   this.addFakeImageHandlers(fakeImage);
   fakeImage.src = realSrc;
  },
  addFakeImageHandlers: function (fakeImage) {
   fakeImage.onload = this.onFakeImageLoad;
   fakeImage.onabort = this.onFakeImageLoad;
   fakeImage.onerror = this.onFakeImageLoad;
  },
  onFakeImageLoad: function () {
   this.restoreRealImage();
   var realImage = this.imageSettings.image;
   ASPx.RemoveClassNameFromElement(realImage, ASPx.ASPxImageLoad.dxDefaultLoadingImageCssClass);
  },
  restoreRealImage: function () {
   var  realImage = this.imageSettings.image;
   realImage.style.background = this.imageSettings.background;
   realImage.alt = this.imageSettings.alt;
   realImage.title = this.imageSettings.title;
   realImage.src = this.src;
  }
 });
 ASPxClientImage.Cast = ASPxClientControl.Cast;
 var ASPxClientLabel = ASPx.CreateClass(ASPxClientStaticEdit, {
  constructor: function(name) {
   this.constructor.prototype.constructor.call(this, name);
   this.sizingConfig.allowSetWidth = false;
   this.sizingConfig.allowSetHeight = false;
   this.accessibilityAssociatedElementID = "";
   this.accessibilityAssociatedControlName = "";
  },
  Initialize: function() {
   ASPxClientControl.prototype.Initialize.call(this);
   this.AssignEllipsisToolTips();
   if(this.accessibilityAssociatedElementID !== "")
    this.SetAccessibilityAssociating();
  },
  GetAssociatedControl: function() {
   var endIndex = this.accessibilityAssociatedElementID.indexOf(this.accessibilityAssociatedControlName) + this.accessibilityAssociatedControlName.length;
   var associatedControlName = this.accessibilityAssociatedElementID.slice(0, endIndex);
   return ASPx.GetControlCollection().Get(associatedControlName);
  },
  SetAccessibilityAssociating: function() {
   var accessibilityAssociatedElement = ASPx.GetElementById(this.accessibilityAssociatedElementID);
   if(!accessibilityAssociatedElement) return;
   var clickHandler = function(evt) {
    var associatedControl = this.GetAssociatedControl();
    if(associatedControl && associatedControl.OnAssociatedLabelClick)
     associatedControl.OnAssociatedLabelClick(evt);
    else
     accessibilityAssociatedElement.click();
   }.aspxBind(this);
   ASPx.Evt.AttachEventToElement(this.GetMainElement(), "click", clickHandler);
   var isExistsAriaLabel = !!ASPx.Attr.GetAttribute(accessibilityAssociatedElement, "aria-label");
   ASPx.Attr.SetAttribute(accessibilityAssociatedElement, isExistsAriaLabel ? "aria-describedby" : "aria-labelledby", this.GetMainElement().id);
  },
  GetValue: function() { 
   var element = this.GetMainElement();
   if(ASPx.IsExistsElement(element))
    return element.innerHTML;
  },
  SetValue: function(value) {
   if(value == null)
    value = "";
   var element = this.GetMainElement();
   if(ASPx.IsExistsElement(element)) 
    element.innerHTML = value;
  },
  SetVisible: function(visible){
   if(this.clientVisible != visible){
    this.clientVisible = visible;
    var element = this.GetMainElement();
    if(!visible)
     element.style.display = "none";
    else if((element.style.width != "" || element.style.height != "") && !ASPx.Browser.NetscapeFamily)
     element.style.display = "inline-block";
    else
     element.style.display = "";
   }
  },
  GetText: function(){
   return this.GetValue();
  },
  SetText: function(value){
   this.SetValue(value);
  },
  ChangeMainElementAttributes: function(element, method){
   ASPxClientStaticEdit.prototype.ChangeMainElementAttributes.call(this, element, method);
   method(element, "htmlFor");
  }
 });
 ASPxClientLabel.Cast = ASPxClientControl.Cast;
 ASPx.SEClick = function(name, evt){
  var edit = ASPx.GetControlCollection().Get(name);
  if(edit != null) {
   edit.OnClick(evt);
   return evt.returnValue;
  }
 }
 ASPx.SELoad = function(evt) {
  var image = ASPx.Evt.GetEventSource(evt);
  if(!image.dxLoadingImageBackground)
   image.dxLoadingImageBackground = image.style.background;
  image.style.background = "";
 }
 window.ASPxClientStaticEdit = ASPxClientStaticEdit;
 window.ASPxClientEditClickEventArgs = ASPxClientEditClickEventArgs;
 window.ASPxClientHyperLink = ASPxClientHyperLink;
 window.ASPxClientImageBase = ASPxClientImageBase;
 window.ASPxClientImage = ASPxClientImage;
 window.ASPxClientLabel = ASPxClientLabel;
})();
