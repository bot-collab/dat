(function() {
 ASPxClientPanelBase = ASPx.CreateClass(ASPxClientControl, {
  constructor: function(name) {
   this.constructor.prototype.constructor.call(this, name);
   this.touchUIScroller = null;
  },
  Initialize: function(){
   ASPxClientControl.prototype.Initialize.call(this);
   this.touchUIScroller = ASPx.TouchUIHelper.makeScrollableIfRequired(this.GetMainElement());
  },
  getContentElement: function() {
   if(this.getAnimationContentContainerElement())
    return this.getAnimationContentContainerElement();
   if(this.getScrollContentContainerElement())
    return this.getScrollContentContainerElement();
   if(!ASPx.IsExistsElement(this.contentElement)){
    var element = this.GetMainElement();
    this.contentElement = element && element.tagName == "TABLE" ? element.rows[0].cells[0] : element;
   }
   return this.contentElement;
  },
  getAnimationContentContainerElement: function() {
   return null;
  },
  getScrollContentContainerElement: function() {
   return null;
  },
  GetContentHTML: function(){
   return this.GetContentHtml();
  },
  SetContentHTML: function(html){
   this.SetContentHtml(html);
  },
  GetContentHtml: function(){
   return this.getContentElement().innerHTML;
  },
  SetContentHtml: function(html){
   ASPx.SetInnerHtml(this.getContentElement(), html);
   if(this.touchUIScroller)
    this.touchUIScroller.ChangeElement(this.getContentElement());
  }
 });
 ASPxClientPanelBase.Cast = ASPxClientControl.Cast;
 var FixedPanels = {};
 var FixedPositionProperties;
 var InitFixedPositionProperties = function(){
  FixedPositionProperties = {};
  FixedPositionProperties["Top"] = { 
   documentPadding: "padding-top", documentMargin: "margin-top", documentMargin2: "margin-bottom", 
   contentEdge: "top", oppositeContentEdge: "bottom", size: "offsetHeight", animationSize: "height", oppositePanel: "Bottom" 
  };
  FixedPositionProperties["Bottom"] = { 
   documentPadding: "padding-bottom", documentMargin: "margin-top", documentMargin2: "margin-bottom", 
   contentEdge: "bottom", oppositeContentEdge: "top", size: "offsetHeight", animationSize: "height", oppositePanel: "Top"
  };
  FixedPositionProperties["Left"] = { 
   documentPadding: "padding-left", documentMargin: "margin-left", documentMargin2: "margin-right", 
   contentEdge: "left", oppositeContentEdge: "right", size: "offsetWidth", animationSize: "width", oppositePanel: "Right"
  };
  FixedPositionProperties["Right"] = { 
   documentPadding: "padding-right", documentMargin: "margin-left", documentMargin2: "margin-right", 
   contentEdge: "right", oppositeContentEdge: "left", size: "offsetWidth", animationSize: "width", oppositePanel: "Left"
  };
 }
 var ExpandDirectionProperties;
 var InitExpandDirectionProperties = function(){
  ExpandDirectionProperties = {};
  ExpandDirectionProperties["PopupToLeft"] = { 
   hAlign: ASPx.PopupUtils.OutsideLeftAlignIndicator, vAlign: ASPx.PopupUtils.TopSidesAlignIndicator, 
   size: "offsetWidth", animationSize: "width" 
  };
  ExpandDirectionProperties["PopupToRight"] = { 
   hAlign: ASPx.PopupUtils.OutsideRightAlignIndicator, vAlign: ASPx.PopupUtils.TopSidesAlignIndicator, 
   size: "offsetWidth", animationSize: "width" 
  };
  ExpandDirectionProperties["PopupToTop"] = { 
   hAlign: ASPx.PopupUtils.LeftSidesAlignIndicator, vAlign: ASPx.PopupUtils.AboveAlignIndicator, 
   size: "offsetHeight", animationSize: "height" 
  };
  ExpandDirectionProperties["PopupToBottom"] = { 
   hAlign: ASPx.PopupUtils.LeftSidesAlignIndicator, vAlign: ASPx.PopupUtils.BelowAlignIndicator, 
   size: "offsetHeight", animationSize: "height" 
  };
 }
 var CollapsiblePanelsAutoGenGroupCount = 0;
 var CollapsiblePanelsGroups = {};
 var ExpandedPanels = {};
 var DocumentProperties = {};
 var EXPANDED_SELECTOR = "dxpnl-expanded";
 var COLLAPSIBLE_SELECTOR = "dxpnl-collapsible";
 var CENTER_BTN_POSITION_SELECTOR = "dxpnl-cp";
 var EXPAND_BAR_ID = "_EB";
 var EXPAND_BUTTON_ID = "_EBB";
 var CONTENT_CONTAINER_ID = "_CC";
 var COLLAPSED_STATE_CLASS_NAME = "dxpnl-collapsedState";
 var HIDDEN_STATE_CLASS_NAME = "dxpnl-hiddenState";
 ASPxClientPanel = ASPx.CreateClass(ASPxClientPanelBase, {
  constructor: function(name) {
   this.constructor.prototype.constructor.call(this, name);
   this.animationType = "none";
   this.fixedPosition = this.getFixedPosition();
   this.expandEffect = "Slide";
   this.expandOnPageLoad = false;
   this.groupName = "";
   this.fixedPositionOverlap = false;
   this.fixedPositionProperties = null;
   this.expandDirectionProperties = null;
   this.documentMarginsChanged = false;
   this.slideAnimationPosProperty = null;
   this.slideAnimationExpandBarSize = null;
   this.collapseWindowWidth = 0;
   this.collapseWindowHeight = 0;
   this.hideWindowWidth = 0;
   this.hideWindowHeight = 0;
   this.contentElement = null;
   this.expandBarElement = null;
   this.expandButtonElement = null;
   this.animationContentContainerElement = null;
   this.scrollContentContainerElement = null;
   this.Collapsed = new ASPxClientEvent();
   this.Expanded = new ASPxClientEvent();
  },
  InlineInitialize: function(){
   ASPxClientPanelBase.prototype.InlineInitialize.call(this);
   if(this.fixedPosition){
    if(!FixedPositionProperties)
     InitFixedPositionProperties();
    this.fixedPositionProperties = FixedPositionProperties[this.fixedPosition];
   }
   if(this.expandEffect.indexOf("Popup") > -1){
    if(!ExpandDirectionProperties)
     InitExpandDirectionProperties();
    this.expandDirectionProperties = ExpandDirectionProperties[this.expandEffect];
   }
   if(this.isPositionFixed()){
    FixedPanels[this.fixedPosition] = this;
    var scrollContainer = this.getScrollContentContainerElement();
    if(scrollContainer && 
     (scrollContainer.style.overflow !== "" && scrollContainer.style.overflow !== "visible" ||
     scrollContainer.style.overflowX !== "" && scrollContainer.style.overflowX !== "visible" ||
     scrollContainer.style.overflowY !== "" && scrollContainer.style.overflowY !== "visible")){
     ASPx.Evt.AttachEventToElement(scrollContainer, "scroll",
      function (evt) {
       if(typeof(ASPx.GetDropDownCollection) != "undefined")
        ASPx.GetDropDownCollection().ProcessControlsInContainer(scrollContainer, function(control) {
         control.HideDropDown();
        });
       if(typeof(ASPx.GetMenuCollection) != "undefined")
        ASPx.GetMenuCollection().HideAll();
      }.aspxBind(this));
    }
   }
   if(this.hideWindowWidth > 0 || this.hideWindowHeight > 0)
    this.createVisibilityCss();
   if(this.collapseWindowWidth > 0 || this.collapseWindowHeight > 0)
    this.createCollapsibilityCss();
   if(this.useAdaptivityClassNames())
    this.ensureAdaptivityClassNames();
   if(this.groupName == ""){
    this.groupName = "DXAutoGenExpandGroup" + CollapsiblePanelsAutoGenGroupCount;
    CollapsiblePanelsAutoGenGroupCount++;
   }
   if(!CollapsiblePanelsGroups[this.groupName])
    CollapsiblePanelsGroups[this.groupName] = [];
   CollapsiblePanelsGroups[this.groupName].push(this);
   var btnElement = this.getExpandButtonElement();
   if(btnElement){
    ASPx.Evt.AttachEventToElement(btnElement, ASPx.TouchUIHelper.touchMouseUpEventName,
     function (evt) {
      if(ASPx.Evt.IsLeftButtonPressed(evt))
       this.Toggle();
     }.aspxBind(this));
   }
   this.updateFixedPanelContext();
   if(!this.clientEnabled)
    this.SetEnabled(this.clientEnabled);
  },
  AfterInitialize: function(){
   ASPxClientPanelBase.prototype.AfterInitialize.call(this);
   var barElement = this.getExpandBarElement();
   if(barElement && this.isExpandBarChangeVisibilityOnExpanding())
    ASPx.AddClassNameToElement(barElement, "h");
   if(this.expandOnPageLoad)
    this.Expand(true);
  },
  OnDispose: function () {
   if(FixedPanels[this.fixedPosition] === this)
    delete FixedPanels[this.fixedPosition];
   if(ASPx.Ident.IsArray(CollapsiblePanelsGroups[this.groupName])){
    ASPx.Data.ArrayRemove(CollapsiblePanelsGroups[this.groupName], this);
    if(CollapsiblePanelsGroups[this.groupName].length === 0)
     delete CollapsiblePanelsGroups[this.groupName];
   }
   if(ExpandedPanels[this.groupName] === this)
    delete ExpandedPanels[this.groupName];
   this.constructor.prototype.OnDispose.call(this);
  },
  AdjustControlCore: function() {
   this.updateExpandButtonPosition();
   this.updateFixedPanelContext();
  },
  GetAdjustedSizes: function() {
   var sizes = this.constructor.prototype.GetAdjustedSizes.call(this);
   var expandBar = this.getExpandBarElement();
   if(expandBar) {
    sizes["expandBarWidth"] = expandBar.offsetWidth;
    sizes["expandBarHeight"] = expandBar.offsetHeight;
   }
   return sizes;
  },
  IsDisplayed: function() {
   if(this.constructor.prototype.IsDisplayed.call(this))
    return true;
   return this.IsDisplayedElement(this.getExpandBarElement());
  },
  IsHidden: function() {
   if(!this.constructor.prototype.IsHidden.call(this))
    return false;
   return this.IsHiddenElement(this.getExpandBarElement());
  },
  OnBrowserWindowResize: function(evt) {
   if(this.useAdaptivityClassNames())
    this.ensureAdaptivityClassNames();
   window.setTimeout(function() {
    this.updateExpandButtonPosition();
    this.updateFixedPanelContext();
    this.checkCollapseContent();
   }.aspxBind(this), 0);
  },
  BrowserWindowResizeSubscriber: function() {
   return this.isPositionFixed() || this.getExpandBarElement() || this.useAdaptivityClassNames();
  },
  HasFixedPosition: function() {
   return this.isPositionFixed();
  },
  getSizeCore: function(element, sizeProperty){
   return element[sizeProperty];
  },
  getFixedSize: function(sizeProperty){
   return this.getSizeCore(this.getFixedElement(), sizeProperty);
  },
  getExpandedSize: function(sizeProperty){
   if(this.getExpandBarElement() && this.isElementDisplayed(this.getExpandBarElement()))
    return this.getSizeCore(this.GetMainElement(), sizeProperty);
   return 0;
  },
  GetWidth: function() {
   if(!this.getExpandBarElement()) 
    return this.constructor.prototype.GetWidth.call(this);
   var width = 0;
   if(this.isElementDisplayed(this.getExpandBarElement()))
    width += this.getExpandBarElement().offsetWidth;
   if(this.isElementDisplayed(this.GetMainElement()) && (!this.IsExpandedInternal() || !this.isPopupExpanding()))
    width += this.GetMainElement().offsetWidth;
   return width;
  },
  GetHeight: function() {
   if(!this.getExpandBarElement()) 
    return this.constructor.prototype.GetHeight.call(this);
   var height = 0;
   if(this.isElementDisplayed(this.getExpandBarElement()))
    height += this.getExpandBarElement().offsetHeight;
   if(this.isElementDisplayed(this.GetMainElement()) && (!this.IsExpandedInternal() || !this.isPopupExpanding()))
    height += this.GetMainElement().offsetHeight;
   return height;
  },
  SetVisible: function (value) {
   if(this.clientVisible != value) {
    ASPxClientPanelBase.prototype.SetVisible.call(this, value);
    var expandBarElement = this.getExpandBarElement();
    if(expandBarElement) ASPx.SetElementDisplay(expandBarElement, value);
    this.updateFixedPanelContext();
   }
  },
  updateFixedPanelContext: function(){
   if(!this.isPositionFixed()) return;
   this.updateDocumentPaddings();
   this.updateMainElementFixedPosition();
   this.updateFixedPanelsPosition();
  },
  updateExpandButtonPosition: function(){
   var expandButton = this.getExpandButtonElement();
   if(!expandButton) return;
   var isCenterPosition = expandButton.className.indexOf(CENTER_BTN_POSITION_SELECTOR) > -1;
   if(isCenterPosition && expandButton.offsetWidth > 0){
    expandButton.style.width = expandButton.offsetWidth + "px";
    ASPx.SetElementFloat(expandButton, "none");
   }
   var correctButtonPosition = false;
   if(this.fixedPosition == "Top" || this.fixedPosition == "Bottom")
    correctButtonPosition = true;
   else if(this.fixedPosition == "Left" || this.fixedPosition == "Right")
    correctButtonPosition = isCenterPosition;
   else if(this.hasVerticalOrientation())
    correctButtonPosition = isCenterPosition;
   else
    correctButtonPosition = true;
   if(correctButtonPosition) 
    this.CorrectVerticalAlignment(ASPx.AdjustVerticalMargins, this.getExpandButtonElement, "Btn", true);
  },
  updateDocumentPaddings: function(){
   if(!this.fixedPositionProperties) return;
   var size = this.getFixedSize(this.fixedPositionProperties.size);
   var expandedSize = 0;
   if(this.expandEffect == "Slide"){
    expandedSize = this.getExpandedSize(this.fixedPositionProperties.size);
    if(this.fixedPosition == "Right" || this.fixedPosition == "Bottom")
     expandedSize = -expandedSize;
   }
   this.changeStyleSideAttribute(document.documentElement, "padding", this.fixedPositionProperties.documentPadding, size + "px");
   var documentMarginValue = this.getDocumentPropertyValue(this.fixedPositionProperties.documentMargin);
   var documentMargin2Value = this.getDocumentPropertyValue(this.fixedPositionProperties.documentMargin2);
   if(expandedSize != 0){
    ASPx.Attr.ChangeStyleAttribute(document.documentElement, this.fixedPositionProperties.documentMargin, (documentMarginValue + expandedSize) + "px");
    ASPx.Attr.ChangeStyleAttribute(document.documentElement, this.fixedPositionProperties.documentMargin2, (documentMargin2Value - expandedSize) + "px");
    this.documentMarginsChanged = true;
   }
   else if(this.documentMarginsChanged){
    ASPx.Attr.RestoreStyleAttribute(document.documentElement, this.fixedPositionProperties.documentMargin);
    ASPx.Attr.RestoreStyleAttribute(document.documentElement, this.fixedPositionProperties.documentMargin2);
    this.documentMarginsChanged = false;
   }
  },
  changeStyleSideAttribute: function(element, baseAttr, attr, value){
   if(!ASPx.Browser.IE || ASPx.Browser.Version > 8)
    ASPx.Attr.ChangeStyleAttribute(element, attr, value);
   else{
    var style = ASPx.GetCurrentStyle(element);
    var top = (attr == baseAttr + "-top") ? value : style[baseAttr + "Top"];
    var right = (attr == baseAttr + "-right") ? value : style[baseAttr + "Right"];
    var bottom = (attr == baseAttr + "-bottom") ? value : style[baseAttr + "Bottom"];
    var left = (attr == baseAttr + "-left") ? value : style[baseAttr + "Left"];
    ASPx.Attr.ChangeStyleAttribute(element, baseAttr, top + " " + right + " " + bottom + " " + left);
   }
  },
  updateMainElementFixedPosition: function(){
   if(!this.fixedPositionProperties) return;
   var barElement = this.getExpandBarElement();
   if(barElement){
    var size = this.getSizeCore(barElement, this.fixedPositionProperties.size);
    ASPx.Attr.ChangeStyleAttribute(this.GetMainElement(), this.fixedPositionProperties.contentEdge, size + "px");
   }
  },
  updateFixedPanelsPosition: function() {
   this.updateFixedPanelsEdges(this.updateFixedPanelEdge);
   this.updateFixedPanelsEdges(this.updateFixedPanelOppositeEdge);
  },
  updateFixedPanelsEdges: function(method) {
   if(FixedPanels["Top"]){
    if(FixedPanels["Left"] && !FixedPanels["Top"].fixedPositionOverlap && FixedPanels["Left"].fixedPositionOverlap)
     method.call(FixedPanels["Left"], FixedPanels["Top"], FixedPanels["Right"]);
    if(FixedPanels["Right"] && !FixedPanels["Top"].fixedPositionOverlap && FixedPanels["Right"].fixedPositionOverlap)
     method.call(FixedPanels["Right"], FixedPanels["Top"], FixedPanels["Left"]);
   }
   if(FixedPanels["Bottom"]){
    if(FixedPanels["Left"] && !FixedPanels["Bottom"].fixedPositionOverlap && FixedPanels["Left"].fixedPositionOverlap)
     method.call(FixedPanels["Left"], FixedPanels["Bottom"], FixedPanels["Right"]);
    if(FixedPanels["Right"] && !FixedPanels["Bottom"].fixedPositionOverlap && FixedPanels["Right"].fixedPositionOverlap)
     method.call(FixedPanels["Right"], FixedPanels["Bottom"], FixedPanels["Left"]);
   }
   if(FixedPanels["Left"]){
    if(FixedPanels["Top"] && (!FixedPanels["Left"].fixedPositionOverlap || FixedPanels["Top"].fixedPositionOverlap))
     method.call(FixedPanels["Top"], FixedPanels["Left"], FixedPanels["Bottom"]);
    if(FixedPanels["Bottom"] && (!FixedPanels["Left"].fixedPositionOverlap || FixedPanels["Bottom"].fixedPositionOverlap))
     method.call(FixedPanels["Bottom"], FixedPanels["Left"], FixedPanels["Top"]);
   }
   if(FixedPanels["Right"]){
    if(FixedPanels["Top"] && (!FixedPanels["Right"].fixedPositionOverlap || FixedPanels["Top"].fixedPositionOverlap))
     method.call(FixedPanels["Top"], FixedPanels["Right"], FixedPanels["Bottom"]);
    if(FixedPanels["Bottom"] && (!FixedPanels["Right"].fixedPositionOverlap || FixedPanels["Bottom"].fixedPositionOverlap))
     method.call(FixedPanels["Bottom"], FixedPanels["Right"], FixedPanels["Top"]);
   }
  },
  updateFixedPanelEdge: function(panel){
   var size = this.getFixedSize(this.fixedPositionProperties.size);
   if(this.expandEffect == "Slide")
    size += this.getExpandedSize(this.fixedPositionProperties.size);
   this.updateFixedPanelEdgeCore(panel, this.fixedPositionProperties.contentEdge, size);
  },
  updateFixedPanelOppositeEdge: function(panel, opppositePanel){
   if(!this.IsExpandedInternal() && opppositePanel) return;
   if(this.expandEffect == "Slide") {
    var size = this.getExpandedSize(this.fixedPositionProperties.size);
    this.updateFixedPanelEdgeCore(panel, this.fixedPositionProperties.oppositeContentEdge, -size);
   }
  },
  updateFixedPanelEdgeCore: function(panel, edge, size){
   var mainElement = panel.GetMainElement();
   mainElement.style[edge] = size + "px";
   var expandBarElement = panel.getExpandBarElement();
   if(expandBarElement)
    expandBarElement.style[edge] = size + "px";
  },
  isPositionFixed: function(){
   return !!this.fixedPositionProperties;
  },
  getFixedPosition: function(){
   var cssClass = this.GetMainElement().className;
   if(cssClass.indexOf("dxpnl-edge t") > -1)
    return "Top";
   if(cssClass.indexOf("dxpnl-edge b") > -1)
    return "Bottom";
   if(cssClass.indexOf("dxpnl-edge l") > -1)
    return "Left";
   if(cssClass.indexOf("dxpnl-edge r") > -1)
    return "Right";
   return null;
  },
  isPopupExpanding: function(){
   return !!this.expandDirectionProperties;
  },
  isExpandBarChangeVisibilityOnExpanding: function(){
   return !this.isPopupExpanding() && !this.isPositionFixed() && CollapsiblePanelsGroups[this.groupName].length > 1;
  },
  createVisibilityCss: function() {
   var rules = [];
   rules.push({ selector: "#" + this.name, cssText: "display: none!important;" });
   rules.push({ selector: "#" + this.name + EXPAND_BAR_ID, cssText: "display: none!important;" });
   this.insertAdaptivityRules(rules, this.hideWindowWidth, this.hideWindowHeight, HIDDEN_STATE_CLASS_NAME);
  },
  createCollapsibilityCss: function() {
   var rules = [];
   rules.push({ selector: "#" + this.name, cssText: "display: none;" });
   rules.push({ selector: "#" + this.name + EXPAND_BAR_ID + ".dxpnl-bar", cssText: (this.isPositionFixed() ? "display: block;" : "display: table;") });
   rules.push({ selector: "#" + this.name + "." + EXPANDED_SELECTOR, cssText: "display: block!important;" });
   this.insertAdaptivityRules(rules, this.collapseWindowWidth, this.collapseWindowHeight, COLLAPSED_STATE_CLASS_NAME);
  },
  insertAdaptivityRules: function(rules, maxWindowWidth, maxWindowHeight, adaptivityClassName) {
   var styleSheet = ASPx.GetCurrentStyleSheet();
   if(!styleSheet) return;
   if(!this.isIE8()) {
    var mediaRule = "@media all and (max-width: " + maxWindowWidth + "px), (max-height: " + maxWindowHeight + "px) { ";
    for(var i = 0; i < rules.length; i++)
     mediaRule += rules[i].selector + "{" + rules[i].cssText + "}";
    mediaRule += "}";
    if(styleSheet.insertRule)
     styleSheet.insertRule(mediaRule, styleSheet.cssRules.length);
   }
   else
    for(var i = 0; i < rules.length; i++) {
     rules[i].selector += "." + adaptivityClassName;
     ASPx.AddStyleSheetRule(styleSheet, rules[i].selector, rules[i].cssText);
    }
  },
  ensureAdaptivityClassNames: function() {
   this.ensureAdaptivityClassName(HIDDEN_STATE_CLASS_NAME, this.hideWindowWidth, this.hideWindowHeight);
   this.ensureAdaptivityClassName(COLLAPSED_STATE_CLASS_NAME, this.collapseWindowWidth, this.collapseWindowHeight);
  },
  ensureAdaptivityClassName: function(adaptivityClassName, maxWindowWidth, maxWindowHeight) {
   var currentDocumentWidth = ASPx.GetCurrentDocumentWidth();
   var currentDocumentHeight = ASPx.GetCurrentDocumentHeight();
   if(currentDocumentWidth <= maxWindowWidth || currentDocumentHeight <= maxWindowHeight)
    this.addAdaptivityClassName(adaptivityClassName);
   else
    this.removeAdaptivityClassName(adaptivityClassName);
  },
  addAdaptivityClassName: function(className) {
   ASPx.AddClassNameToElement(this.GetMainElement(), className);
   if(ASPx.IsExists(this.getExpandBarElement()))
    ASPx.AddClassNameToElement(this.getExpandBarElement(), className);
  },
  removeAdaptivityClassName: function(className) {
   ASPx.RemoveClassNameFromElement(this.GetMainElement(), className);
   if(ASPx.IsExists(this.getExpandBarElement()))
    ASPx.RemoveClassNameFromElement(this.getExpandBarElement(), className);
  },
  useAdaptivityClassNames: function() {
   return this.isIE8()
    && (this.hideWindowWidth > 0 || this.hideWindowHeight > 0 || this.collapseWindowWidth > 0 || this.collapseWindowHeight > 0);
  },
  isIE8: function() {
   return ASPx.Browser.IE && ASPx.Browser.Version === 8;
  },
  Toggle: function() {
   if(this.IsExpandedInternal()) 
    this.Collapse();
   else 
    this.Expand();
  },
  IsExpandable: function() {
   if(this.GetMainElement().className.indexOf(" " + COLLAPSIBLE_SELECTOR) > -1)
    return true;
   if(this.collapseWindowWidth > 0 || this.collapseWindowHeight > 0){
    var expandBarElement = this.getExpandBarElement();
    return expandBarElement && ASPx.GetCurrentStyle(expandBarElement).display !== "none";
   }
   return false;
  },
  IsExpanded: function() {
   if(this.IsExpandable())
    return this.IsExpandedInternal();
   return true;
  },
  IsExpandedInternal: function() {
   return this.GetMainElement().className.indexOf(" " + EXPANDED_SELECTOR) > -1;
  },
  Expand: function(preventAnimation) {
   if(ExpandedPanels[this.groupName] != this) {
    if(ExpandedPanels[this.groupName])
     ExpandedPanels[this.groupName].Collapse(preventAnimation);
    this.collapseOppositePanel(preventAnimation);
    this.collapseUnfixedPopupPanels();
    ExpandedPanels[this.groupName] = this;
    ASPx.GetStateController().SelectElementBySrcElement(this.GetMainElement());
    ASPx.GetStateController().SelectElementBySrcElement(this.getExpandButtonElement());
    ASPx.GetControlCollection().AdjustControls(this.GetMainElement());
    if(this.isPopupExpanding() && !this.isPositionFixed())
     this.updateMainElementPosition(true);
    if(this.isExpandBarChangeVisibilityOnExpanding())
     this.slideAnimationExpandBarSize = this.getSlideAnimationSize(this.getExpandBarElement(), true);
    ASPx.GetStateController().SelectElementBySrcElement(this.getExpandBarElement());
    if(!preventAnimation && this.animationType == "slide")
     this.startSlideAnimation(this.GetMainElement(), false);
    else if(!preventAnimation && this.animationType == "fade")
     this.startFadeAnimation(this.GetMainElement(), false);
    else
     this.expandCore();
   }
  },
  Collapse: function(preventAnimation) {
   if(ExpandedPanels[this.groupName] == this) {
    ExpandedPanels[this.groupName] = null;
    this.collapseUnfixedPopupPanels();
    if(this.isExpandBarChangeVisibilityOnExpanding()){
     ASPx.GetStateController().DeselectElementBySrcElement(this.getExpandBarElement());
     this.slideAnimationExpandBarSize = this.getSlideAnimationSize(this.getExpandBarElement(), true);
     ASPx.GetStateController().SelectElementBySrcElement(this.getExpandBarElement());
    }
    if(!preventAnimation && this.animationType == "slide")
     this.startSlideAnimation(this.GetMainElement(), true);
    else if(!preventAnimation && this.animationType == "fade")
     this.startFadeAnimation(this.GetMainElement(), true);
    else
     this.collapseCore();
   }
  },
  expandCore: function() {
   if(this.isPositionFixed()) {
    this.updateFixedPanelContext();
   }
   this.raiseExpanded();
  },
  collapseCore: function() {
   ASPx.GetStateController().DeselectElementBySrcElement(this.GetMainElement());
   ASPx.GetStateController().DeselectElementBySrcElement(this.getExpandButtonElement());
   if(this.isPopupExpanding() && !this.isPositionFixed())
    this.updateMainElementPosition(false);
   ASPx.GetStateController().DeselectElementBySrcElement(this.getExpandBarElement());
   if(this.isPositionFixed()) {
    this.updateFixedPanelContext();
   }
   this.slideAnimationPosProperty = null;
   this.raiseCollapsed();
  },
  collapseOppositePanel: function(preventAnimation) {
   if(!this.fixedPositionProperties) return;
   if(FixedPanels[this.fixedPositionProperties.oppositePanel])
    FixedPanels[this.fixedPositionProperties.oppositePanel].Collapse(preventAnimation);
  },
  collapseUnfixedPopupPanels: function() {
   if(!this.isPositionFixed() || this.isPopupExpanding()) return;
   for(var groupName in ExpandedPanels){
    if(ExpandedPanels[groupName] && !ExpandedPanels[groupName].fixedPosition && ExpandedPanels[groupName].isPopupExpanding())
     ExpandedPanels[groupName].Collapse(true);
   }
  },
  saveOpacity: function(element) {
   if(!this.isIE8())
    ASPx.Attr.SaveStyleAttribute(element, "opacity");
   else if(ASPx.GetCurrentStyle(element).filter)
    ASPx.Attr.SaveStyleAttribute(element, "filter");
  },
  restoreOpacity: function(element) {
   if(!this.isIE8())
    ASPx.Attr.RestoreStyleAttribute(element, "opacity");
   else
    ASPx.Attr.RestoreStyleAttribute(element, "filter");
  },
  startFadeAnimation: function (element, isCollapsing) {
   this.saveOpacity(element);
   var onComplete =  function() { this.finishFadeAnimation(element, isCollapsing); }.aspxBind(this);
   if(isCollapsing)
    ASPx.AnimationHelper.fadeOut(element, onComplete, ASPx.AnimationConstants.Durations.SHORT);
   else
    ASPx.AnimationHelper.fadeIn(element, onComplete, ASPx.AnimationConstants.Durations.SHORT);
  },
  finishFadeAnimation: function (element, isCollapsing) {
   this.restoreOpacity(element);
   if(isCollapsing)
    this.collapseCore(); 
   else
    this.expandCore(); 
  },
  startSlideAnimation: function(element, isCollapsing) {
   var sizeProperty = this.getSlideAnimationSizeProperty();
   var offsetWidth = element.offsetWidth;
   var offsetHeight = element.offsetHeight;
   ASPx.Attr.SaveStyleAttribute(element, sizeProperty);
   if(element.style.overflow !== "")
    ASPx.Attr.ChangeStyleAttribute(element, "overflow", "hidden");
   else{
    ASPx.Attr.ChangeStyleAttribute(element, "overflow-x", "hidden");
    ASPx.Attr.ChangeStyleAttribute(element, "overflow-y", "hidden");
   }
   var contentContainer = this.getAnimationContentContainerElement();
   if(contentContainer) {
    if(contentContainer.style.overflow !== "")
     ASPx.Attr.ChangeStyleAttribute(contentContainer, "overflow", "hidden");
    else{
     ASPx.Attr.ChangeStyleAttribute(contentContainer, "overflow-x", "hidden");
     ASPx.Attr.ChangeStyleAttribute(contentContainer, "overflow-y", "hidden");
    }
    ASPx.Attr.ChangeStyleAttribute(contentContainer, "width", offsetWidth - ASPx.GetLeftRightBordersAndPaddingsSummaryValue(element) + "px");
    ASPx.Attr.ChangeStyleAttribute(contentContainer, "height", offsetHeight - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(element) + "px");
   }
   var transitionProperties = {
    duration: ASPx.AnimationConstants.Durations.SHORT, 
    onComplete: function() { this.finishSlideAnimation(element, isCollapsing); }.aspxBind(this)
   };
   if(this.isPositionFixed())
    transitionProperties.onStep = function() { this.performSlideAnimationStep(); }.aspxBind(this);
   var transition = ASPx.AnimationHelper.createMultipleAnimationTransition(element, transitionProperties);
   var size = this.getSlideAnimationSize(element, !this.isPositionFixed());
   var startSize = isCollapsing ? size : 0;
   var endSize = isCollapsing ? 0 : size;
   if(this.isExpandBarChangeVisibilityOnExpanding() && this.slideAnimationExpandBarSize){
    if(startSize == 0)
     startSize = this.slideAnimationExpandBarSize;
    if(endSize == 0)
     endSize = this.slideAnimationExpandBarSize;
   }
   var properties = {};
   properties[sizeProperty] = { from: startSize, to: endSize, unit: "px" };
   if(!isCollapsing) 
    ASPx.Attr.ChangeStyleAttribute(element, sizeProperty, startSize + "px");
   if(this.slideAnimationPosProperty){
    var position = parseInt(element.style[this.slideAnimationPosProperty]);
    var startPosition = isCollapsing ? position : position + size;
    var endPosition = isCollapsing ? position + size : position;
    properties[this.slideAnimationPosProperty] = { from: startPosition, to: endPosition, unit: "px" };
    if(!isCollapsing) 
     ASPx.Attr.ChangeStyleAttribute(element, this.slideAnimationPosProperty, startPosition + "px");
   }
   transition.Start(properties);
  },
  finishSlideAnimation: function(element, isCollapsing) {
   var sizeProperty = this.getSlideAnimationSizeProperty();
   ASPx.Attr.RestoreStyleAttribute(element, sizeProperty);
   ASPx.Attr.RestoreStyleAttribute(element, "overflow");
   ASPx.Attr.RestoreStyleAttribute(element, "overflow-x");
   ASPx.Attr.RestoreStyleAttribute(element, "overflow-y");
   var contentContainer = this.getAnimationContentContainerElement();
   if(contentContainer) {
    ASPx.Attr.RestoreStyleAttribute(contentContainer, "overflow");
    ASPx.Attr.RestoreStyleAttribute(contentContainer, "overflow-x");
    ASPx.Attr.RestoreStyleAttribute(contentContainer, "overflow-y");
    ASPx.Attr.RestoreStyleAttribute(contentContainer, "width");
    ASPx.Attr.RestoreStyleAttribute(contentContainer, "height");
   }
   if(isCollapsing)
    this.collapseCore(); 
   else
    this.expandCore(); 
  },
  performSlideAnimationStep: function() {
   this.updateFixedPanelContext();
  },
  getSlideAnimationSizeProperty: function() {
   if(this.fixedPositionProperties)
    return this.fixedPositionProperties.animationSize;
   else if(this.expandDirectionProperties)
    return this.expandDirectionProperties.animationSize;
   else 
    return this.hasVerticalOrientation() ? "width" : "height";
  },
  getSlideAnimationSize: function(element, fullSize) {
   var sizeProperty;
   if(this.fixedPositionProperties)
    sizeProperty = this.fixedPositionProperties.size;
   else if(this.expandDirectionProperties)
    sizeProperty = this.expandDirectionProperties.size;
   else
    sizeProperty = this.hasVerticalOrientation() ? "offsetWidth" : "offsetHeight";
   var size = this.getSizeCore(element, sizeProperty);
   if(fullSize) {
    if(sizeProperty == "offsetWidth")
     size -= ASPx.GetHorizontalBordersWidth(element);
    else
     size -= ASPx.GetVerticalBordersWidth(element);
   }
   else {
    if(sizeProperty == "offsetWidth")
     size -= ASPx.GetLeftRightBordersAndPaddingsSummaryValue(element);
    else
     size -= ASPx.GetTopBottomBordersAndPaddingsSummaryValue(element);
   }
   return size;
  },
  getSlideAnimationPosProperty: function(x, y) {
   if(this.expandEffect == "PopupToTop")
    return !y.isInverted ? "top" : null;
   if(this.expandEffect == "PopupToBottom")
    return y.isInverted ? "top" : null;
   if(this.expandEffect == "PopupToLeft")
    return !x.isInverted ? "left" : null;
   if(this.expandEffect == "PopupToRight")
    return y.isInverted ? "left" : null;
   return null;
  }, 
  hasVerticalOrientation: function() {
   var float = ASPx.GetElementFloat(this.GetMainElement());
   return (float === "left" || float === "right");
  },
  updateMainElementPosition: function(expanded) {
   if(!this.expandDirectionProperties) return;
   if(expanded)
    this.updateMainElementExpandedPosition(this.GetMainElement());
   else
    this.updateMainElementCollapsedPosition(this.GetMainElement());
  },
  updateMainElementExpandedPosition: function(element) {
   if(element.style.width === "100%")
    ASPx.Attr.ChangeStyleAttribute(element, "width", (element.parentNode.offsetWidth - ASPx.GetLeftRightMargins(element)) + "px");
   if(element.style.height === "100%")
    ASPx.Attr.ChangeStyleAttribute(element, "height", (element.parentNode.offsetHeight - ASPx.GetTopBottomMargins(element)) + "px");
   ASPx.Attr.ChangeStyleAttribute(element, "position", "absolute");
   var barElement = this.getExpandBarElement();
   var x = ASPx.PopupUtils.GetPopupAbsoluteX(element,
    barElement, this.expandDirectionProperties.hAlign, 0, 0, 0, false, false);
   var y = ASPx.PopupUtils.GetPopupAbsoluteY(element,
    barElement, this.expandDirectionProperties.vAlign, 0, 0, 0, true);
   ASPx.Attr.ChangeStyleAttribute(element, "left", x.position + "px");
   ASPx.Attr.ChangeStyleAttribute(element, "top", y.position + "px");
   this.slideAnimationPosProperty = this.getSlideAnimationPosProperty(x, y);
  },
  updateMainElementCollapsedPosition: function(element) {
   ASPx.Attr.RestoreStyleAttribute(element, "position");
   ASPx.Attr.RestoreStyleAttribute(element, "left");
   ASPx.Attr.RestoreStyleAttribute(element, "top");
   ASPx.Attr.RestoreStyleAttribute(element, "width");
   ASPx.Attr.RestoreStyleAttribute(element, "height");
  },
  checkCollapseContent: function(){
   if(!this.getExpandBarElement()) return;
   if(this.IsExpandedInternal()){
    if(CollapsiblePanelsGroups[this.groupName].length === 1 && !this.isElementDisplayed(this.getExpandBarElement()) && this.isElementDisplayed(this.GetMainElement()))
     this.Collapse(true);
    if(!this.isPositionFixed() && this.isPopupExpanding())
     this.Collapse(true);
   }
  },
  raiseCollapsed: function() {
   if(!this.Collapsed.IsEmpty()) {
    var args = new ASPxClientEventArgs();
    this.Collapsed.FireEvent(this, args);
   }
  },
  raiseExpanded: function() {
   if(!this.Expanded.IsEmpty()) {
    var args = new ASPxClientEventArgs();
    this.Expanded.FireEvent(this, args);
   }
  },
  getAnimationContentContainerElement: function() {
   if(!ASPx.IsExistsElement(this.animationContentContainerElement)) 
    this.animationContentContainerElement = ASPx.GetChildByClassName(this.GetMainElement(), "dxpnl-acc");
   return this.animationContentContainerElement;
  },
  getScrollContentContainerElement: function() {
   if(!ASPx.IsExistsElement(this.scrollContentContainerElement)) 
    this.scrollContentContainerElement = ASPx.GetNodesByPartialClassName(this.GetMainElement(), "dxpnl-scc")[0];
   return this.scrollContentContainerElement;
  },
  getExpandBarElement: function() {
   if(!ASPx.IsExistsElement(this.expandBarElement))
    this.expandBarElement = ASPx.GetElementById(this.name + EXPAND_BAR_ID);
   return this.expandBarElement;
  },
  getExpandButtonElement: function() {
   if(!ASPx.IsExistsElement(this.expandButtonElement))
    this.expandButtonElement = ASPx.GetElementById(this.name + EXPAND_BUTTON_ID);
   return this.expandButtonElement;
  },
  getFixedElement: function(){
   if(this.getExpandBarElement() && this.isElementDisplayed(this.getExpandBarElement()))
    return this.getExpandBarElement();
   else
    return this.GetMainElement();
  },
  getDocumentPropertyValue: function(attr){
   if(DocumentProperties[attr] === undefined){
    var currentStyle = ASPx.GetCurrentStyle(document.documentElement);
    var attrValue = parseInt(ASPx.Attr.GetAttribute(currentStyle, attr));
    DocumentProperties[attr] = !isNaN(attrValue) ? attrValue : 0;
   }
   return DocumentProperties[attr];
  },
  isElementDisplayed: function(element){
   return ASPx.GetCurrentStyle(element).display != "none";
  }
 });
 ASPxClientPanel.Cast = ASPxClientControl.Cast;
 window.ASPxClientPanelBase = ASPxClientPanelBase;
 window.ASPxClientPanel = ASPxClientPanel;
})();
