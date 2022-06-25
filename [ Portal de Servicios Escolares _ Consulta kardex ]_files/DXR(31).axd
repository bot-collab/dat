(function() {
ASPx.PCWIdSuffix = "_PW";
var popupControlZIndex = 11998;
var defaultZIndexFromServer = "10000";
function PCResizeCursorInfo(horizontalDirection, verticalDirection, horizontalOffset, verticalOffset) {
 this.horizontalDirection = horizontalDirection;
 this.verticalDirection = verticalDirection;
 this.horizontalOffset = horizontalOffset;
 this.verticalOffset = verticalOffset;
 this.course = verticalDirection + horizontalDirection;
}
var PopupControlCssClasses = {};
PopupControlCssClasses.Prefix = "dxpc-";
PopupControlCssClasses.SizeGripLiteCssClassName = PopupControlCssClasses.Prefix + "sizeGrip";
PopupControlCssClasses.LinkCssClassName = PopupControlCssClasses.Prefix + "link";
PopupControlCssClasses.ShadowLiteCssClassName = PopupControlCssClasses.Prefix + "shadow";
PopupControlCssClasses.MainDivLiteCssClass = PopupControlCssClasses.Prefix + "mainDiv";
PopupControlCssClasses.ContentWrapperCssClassName = PopupControlCssClasses.Prefix + "contentWrapper";
PopupControlCssClasses.ContentCssClassName = PopupControlCssClasses.Prefix + "content";
PopupControlCssClasses.HeaderContentCssClassName = PopupControlCssClasses.Prefix + "headerContent";
var constants = {
 DEFAULT_WINDOW_WIDTH: 200,
 DEFAULT_WINDOW_HEIGHT: 0
};
var ASPxClientPopupControl = ASPx.CreateClass(ASPxClientControl, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.leadingAfterInitCall = ASPxClientControl.LeadingAfterInitCallConsts.Direct; 
  this.adjustInnerControlsSizeOnShow = true;
  this.slideAnimationDuration = 80;
  this.fadeAnimationDuration = 400;
  this.appearAfter = 300;
  this.disappearAfter = 500;
  this.allowResize = false;
  this.popupAnimationType = "none";
  this.closeAnimationType = "none";
  this.enableAnimation = true;
  this.animationLockCount = 0;
  this.shadowVisible = true;
  this.allowCorrectYOffsetPosition = true; 
  this.contentUrl = "";
  this.contentUrlArray = [];
  this.contentUrlIFrameTitle = "";
  this.contentUrlIFrameTitleArray = [];
  this.contentLoadingMode = "Default"
  this.loadingPanels = [];
  this.loadingDivs = [];
  this.lpTimers = [];
  this.windowRequestCount = [];
  this.callbackAnimationProcessings = [];
  this.savedCallbackResults = [];
  this.isCallbackFinishedStates = [];
  this.savedCallbackWindowIndex = null;
  this.cookieName = "";
  this.closeOnEscape = false;
  this.closeAction = "OuterMouseClick";
  this.popupAction = "LeftMouseClick";
  this.closeOnEscapeArray = [];
  this.closeActionArray = [];
  this.popupActionArray = [];
  this.windowsPopupElementIDList = [];
  this.windowsPopupElementList = [];
  this.windowsLastUsedPopupElementInfoList = [];
  this.windowsIsPopupedList = [];
  this.windowsPopupReasonMouseEventList = [];
  this.defaultWindowPopupElementIDList = [];
  this.defaultWindowPopupElementList = [];
  this.defaultLastUsedPopupElementInfo = {};
  this.defaultIsPopuped = false;
  this.defaultPopupReasonMouseEvent = null;
  this.showOnPageLoad = false;
  this.showOnPageLoadArray = [];
  this.popupHorizontalAlign = ASPx.PopupUtils.NotSetAlignIndicator;
  this.popupVerticalAlign = ASPx.PopupUtils.NotSetAlignIndicator;
  this.popupHorizontalOffset = 0;
  this.popupVerticalOffset = 0;
  this.windows = [];
  this.windowCount = 0;
  this.isDragged = false;
  this.isResized = false;
  this.zIndex = -1;
  this.left = 0;
  this.top = 0;
  this.iframeLoading = false;
  this.isDraggedArray = [];
  this.isResizedArray = [];
  this.zIndexArray = [];
  this.leftArray = [];
  this.topArray = [];
  this.height = constants.DEFAULT_WINDOW_HEIGHT;
  this.width = constants.DEFAULT_WINDOW_WIDTH;
  this.widthFromServer = false;
  this.minHeight = null;
  this.minWidth = null;
  this.maxHeight = null;
  this.maxWidth = null;
  this.shownArray = [];
  this.heightArray = [];
  this.widthArray = [];
  this.widthFromServerArray = [];
  this.minHeightArray = [];
  this.minWidthArray = [];
  this.maxHeightArray = [];
  this.maxWidthArray = [];
  this.iframeLoadingArray = [];
  this.isLiveResizingMode = true;
  this.isPopupPositionCorrectionOn = true;
  this.isPopupFullCorrectionOn = true;
  this.windowElements = {};
  this.hideBodyScrollWhenModal = true;
  this.hideBodyScrollWhenModalArray = [];
  this.hideBodyScrollWhenMaximized = true;
  this.autoUpdatePosition = false;
  this.autoUpdatePositionArray = [];
  this.cachedSize = null;
  this.cachedSizeArray = [];
  this.fakeDragDiv = null;
  this.headerHeight = 0;
  this.headerHeightArray = [];
  this.footerHeight = 0;
  this.footerHeightArray = [];
  this.ResizeBorderSize = ASPx.Browser.TouchUI ? 10 : 6;
  this.ResizeCornerBorderSize = 20;
  this.allowDragging = false;
  this.isWindowDragging = false;
  this.enableContentScrolling = false;
  this.enableContentScrollingArray = [];
  this.contentOverflowX = "None";
  this.contentOverflowY = "None";
  this.contentOverflowXArray = [];
  this.contentOverflowYArray = [];
  this.isPinned = false;
  this.isPinnedArray = [];
  this.pinX = 0;
  this.pinXArray = [];
  this.pinY = 0;
  this.pinYArray = [];
  this.lockScroll = 0;
  this.isCollapsed = false;
  this.isCollapsedArray = [];
  this.isCollapsedInit = false;
  this.isCollapsedInitArray = [];
  this.collapseExecutingLockCount = 0;
  this.isMaximized = false;
  this.isMaximizedArray = [];
  this.isMaximizedInit = false;
  this.isMaximizedInitArray = [];
  this.maximizationExecutingLockCount = 0;
  this.restoredWindowValues = {};
  this.restoredWindowValuesArray = [];
  this.browserResizingForMaxWindowLockCount = 0;
  this.updateRestoredWindowSizeLockCount = 0;
  this.iframeAdjustingPostponedArray = [];
  this.iframeAdjustingPostponed = false;
  this.touchUIScrollers = {};
  this.prohibitClearSelectionOnMouseDown = false;
  this.CloseButtonClick = new ASPxClientEvent();
  this.CloseUp = new ASPxClientEvent();
  this.Closing = new ASPxClientEvent();
  this.PopUp = new ASPxClientEvent();
  this.Resize = new ASPxClientEvent();
  this.Shown = new ASPxClientEvent();
  this.BeforeResizing = new ASPxClientEvent();
  this.AfterResizing = new ASPxClientEvent();
  this.PinnedChanged = new ASPxClientEvent();
  aspxGetPopupControlCollection().Add(this);
 },
 InlineInitialize: function() {
  ASPxClientControl.prototype.InlineInitialize.call(this);
  this.InitializeArrayCores();
 },
 Initialize: function() {
  aspxGetPopupControlCollection().EnsureSaveScrollState();
  this.InitializeBeforeAnyShow();
  if(this.HasDefaultWindow())
   this.InitializeWindow(-1);
  for(var i = 0; i < this.GetWindowCount() ; i++)
   this.InitializeWindow(i);
  this.InitializeScrollbars();
  this.constructor.prototype.Initialize.call(this);
 },
 InitializeBeforeAnyShow: function() {
  this.InitializeEnableContentScrolling();
 },
 InitializeEnableContentScrolling: function() {
  for(var windowIndex = 0; windowIndex < this.GetWindowCount() ; windowIndex++) {
   var contentOverflowX = this.GetWindowOverflowX(windowIndex);
   var contentOverflowY = this.GetWindowOverflowY(windowIndex);
   this.enableContentScrollingArray.push(contentOverflowX != "None" || contentOverflowY != "None");
  }
  this.enableContentScrolling = this.contentOverflowX != "None" || this.contentOverflowY != "None";
 },
 InitializeScrollbars: function() {
  if(!ASPx.Browser.WebKitTouchUI && (!ASPx.Browser.WindowsPhonePlatform || !ASPx.Browser.IE))
   return;
  var indices = [];
  for(var i = 0; i < this.GetWindowCount(); i++)
   indices.push(i);
  if(this.HasDefaultWindow())
   indices.push(-1);
  for(var i = 0; i < indices.length; i++) {
   if(this.GetEnableContentScrolling(i)) {
    var windowIndex = indices[i];
    var scrollElement = this.GetContentContainer(windowIndex);
    if(scrollElement) {
     var contentOverflowX = this.GetWindowOverflowX(windowIndex);
     var contentOverflowY = this.GetWindowOverflowY(windowIndex);
     var options = {
      showHorizontalScrollbar: contentOverflowX === "Auto" || contentOverflowX === "Scroll",
      showVerticalScrollbar: contentOverflowY === "Auto" || contentOverflowY === "Scroll"
     };
     this.touchUIScrollers[windowIndex] = ASPx.TouchUIHelper.MakeScrollable(scrollElement, options);
    }
   }
  }
 },
 OnDispose: function() { 
  this.constructor.prototype.OnDispose.call(this);
  this.ClearPopupElementConnection();
 },
 preventParentOverlowOnIos: function(index) {
  if(!ASPx.Browser.MacOSMobilePlatform) return;
  var parent = this.getParentPopupControl(index);
  if(parent) 
   parent.popupControl.changeContentOverflow(parent.windowIndex);
 },
 restoreParentOverflowOnIos: function(index) {
  if(!ASPx.Browser.MacOSMobilePlatform) return;
  var parent = this.getParentPopupControl(index);
  if(parent) 
   parent.popupControl.restoreContentOverflow(parent.windowIndex);
 },
 getTouchScrollerElement: function(index) {
  var touchUIScroller = this.touchUIScrollers[index];
  if(!touchUIScroller) return null;
  return touchUIScroller.element;
 },
 changeContentOverflow: function(index) {
  var scrollerElement = this.getTouchScrollerElement(index);
  if(!scrollerElement) return;
  ASPx.Attr.ChangeStyleAttribute(scrollerElement, "overflow", "visible");
  ASPx.Attr.ChangeStyleAttribute(scrollerElement, "overflowX", "visible");
  ASPx.Attr.ChangeStyleAttribute(scrollerElement, "overflowY", "visible");
 },
 restoreContentOverflow: function(index) {
  var scrollerElement = this.getTouchScrollerElement(index);
  if(!scrollerElement) return;
  ASPx.Attr.RestoreStyleAttribute(scrollerElement, "overflow");
  ASPx.Attr.RestoreStyleAttribute(scrollerElement, "overflowX");
  ASPx.Attr.RestoreStyleAttribute(scrollerElement, "overflowY");
 },
 UpdateScrollbar: function(index) {
  var touchUIScroller = this.touchUIScrollers[index];
  if(!touchUIScroller)
   return;
  var scrollElement = this.GetContentContainer(index);
  if(scrollElement)
   touchUIScroller.ChangeElement(scrollElement);
 },
 AfterInitialize: function() {
  if(this.HasDefaultWindow())
   this.AfterInitializeWindow(-1);
  for(var i = 0; i < this.GetWindowCount() ; i++)
   this.AfterInitializeWindow(i);
  this.constructor.prototype.AfterInitialize.call(this);
 },
 InitializeArrayCores: function() {
  if(this.GetWindowCountCore() > 0) {
   this.InitializeWindowPopupElementList();
   this.InitializeWindowPopupElementIDList();
   this.InitializeWindowLastUsedPopupElementInfoList();
   this.InitializeArray(this.shownArray);
   this.InitializeArray(this.windowsPopupReasonMouseEventList, null);
   this.InitializeArray(this.windowsIsPopupedList, false);
   this.InitializeArray(this.contentUrlArray, "");
   this.InitializeArray(this.contentUrlIFrameTitleArray, "");
   this.InitializeArray(this.popupActionArray, this.popupAction);
   this.InitializeArray(this.closeActionArray, this.closeAction);
   this.InitializeArray(this.showOnPageLoadArray, false);
   this.InitializeArray(this.isDraggedArray, false);
   this.InitializeArray(this.isPinnedArray, false);
   this.InitializeArray(this.isCollapsedArray, false);
   this.InitializeArray(this.isCollapsedInitArray, false);
   this.InitializeArray(this.isMaximizedArray, false);
   this.InitializeArray(this.isMaximizedInitArray, false);
   this.InitializeArray(this.restoredWindowValuesArray, {});
   this.InitializeArray(this.iframeAdjustingPostponedArray, {});
   this.InitializeArray(this.isResizedArray, false);
   this.InitializeArray(this.zIndexArray, -1);
   this.InitializeArray(this.leftArray, 0);
   this.InitializeArray(this.topArray, 0);
   this.InitializeArray(this.widthArray, constants.DEFAULT_WINDOW_WIDTH);
   this.InitializeArray(this.heightArray, constants.DEFAULT_WINDOW_HEIGHT);
   this.InitializeArray(this.widthFromServerArray, false);
   this.InitializeArray(this.pinXArray, 0);
   this.InitializeArray(this.pinYArray, 0);
   this.InitializeArray(this.minWidthArray, null);
   this.InitializeArray(this.minHeightArray, null);
   this.InitializeArray(this.maxWidthArray, null);
   this.InitializeArray(this.maxHeightArray, null);
   this.InitializeArray(this.cachedSizeArray, null);
   this.InitializeArray(this.iframeLoadingArray, false);
   this.InitializeArray(this.autoUpdatePositionArray, false);
   this.InitializeArray(this.hideBodyScrollWhenModalArray, true);
   this.InitializeArray(this.closeOnEscapeArray, this.closeOnEscape);
   if(ASPx.Browser.IE) {
    this.InitializeArray(this.headerHeightArray, -1);
    this.InitializeArray(this.footerHeightArray, -1);
   }
  }
 },
 InitializeArray: function(array, defaultValue) {
  if(array.length == 0) {
   for(var i = 0; i < this.GetWindowCountCore() ; i++)
    array[i] = defaultValue;
  }
 },
 InitializeWindowPopupElementIDList: function() {
  for(var i = 0; i < this.GetWindowCountCore() ; i++) {
   if(!this.windowsPopupElementIDList[i])
    this.windowsPopupElementIDList[i] = [];
  }
 },
 InitializeWindowPopupElementList: function() {
  for(var i = 0; i < this.GetWindowCountCore() ; i++) {
   if(!this.windowsPopupElementList[i])
    this.windowsPopupElementList[i] = [];
  }
 },
 InitializeWindowLastUsedPopupElementInfoList: function() {
  for(var i = 0; i < this.GetWindowCountCore() ; i++) {
   if(!this.windowsLastUsedPopupElementInfoList[i])
    this.windowsLastUsedPopupElementInfoList[i] = {};
  }
 },
 WindowElementIDAssignmentMap: [
  { cssClass: "dxpc-header", prefix: "_PWH" },
  { cssClass: "dxpc-headerText", prefix: "_PWH", postfix: "T" },
  { cssClass: "dxpc-headerImg", prefix: "_PWH", postfix: "I" },
  { cssClass: "dxpc-closeBtn", prefix: "_HCB" },
  { cssClass: "dxpc-pinBtn", prefix: "_HPB" },
  { cssClass: "dxpc-refreshBtn", prefix: "_HRB" },
  { cssClass: "dxpc-collapseBtn", prefix: "_HMNB" },
  { cssClass: "dxpc-maximizeBtn", prefix: "_HMXB" },
  { cssClass: "dxpc-content", prefix: "_PWC" },
  { cssClass: "dxpc-iFrame", prefix: "_CIF" },
  { cssClass: "dxpc-footer", prefix: "_PWF" },
  { cssClass: "dxpc-footerText", prefix: "_PWF", postfix: "T" },
  { cssClass: "dxpc-footerImg", prefix: "_PWF", postfix: "I" }
 ],
 AssignElementID: function(element, index, prefix, postfix) {
  element.id = this.name + prefix + index + (postfix ? postfix : "");
 },
 AssignWindowElementsID: function(index, windowElement) {
  for(var i = 0; i < this.WindowElementIDAssignmentMap.length; i++) {
   var elementClass = this.WindowElementIDAssignmentMap[i].cssClass;
   var elements = ASPx.GetNodesByClassName(windowElement, elementClass);
   for(var j = 0; j < elements.length; j++) {
    var element = elements[j];
    if(this.GetFirstParentWindow(element) === windowElement)
     this.AssignElementID(element, index, this.WindowElementIDAssignmentMap[i].prefix, this.WindowElementIDAssignmentMap[i].postfix);
   }
  }
 },
 AddKeyDownHandler: function(shortcutString, handler) {
  if(typeof(this.keyDownHandlers) === "undefined")
   this.keyDownHandlers = [];
  this.keyDownHandlers[ASPx.ParseShortcutString(shortcutString)] = handler;
 },
 GetFirstParentWindow: function(el) {
  while(el && el.tagName != "BODY") {
   if(el.nodeType == 1 && el.className.indexOf("dxpclW") > -1 && !isNaN(this.GetWindowIndex(el)))
    return el;
   el = el.parentNode;
  }
 },
 getParentPopupControl: function(index) {
  var parentPopupWindowElement = this.GetFirstParentWindow(this.GetWindowElement(index).parentNode);
  if(parentPopupWindowElement)
   return aspxGetPopupControlCollection().GetPopupWindowFromID(parentPopupWindowElement.id);
 },
 PreventHeaderButtonMouseDownBubbling: function(evt, hdrButton) {
  if(hdrButton) {
   var source = ASPx.Evt.GetEventSource(evt);
   if(ASPx.GetIsParent(hdrButton, source)) {
    ASPx.PWHMDown(evt);
    return true;
   }
  }
  return false;
 },
 GetWindowElementMouseDownEventHandler: function(index) {
  var instance = this;
  return function(evt) {
   if(!instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowCloseButton(index)) &&
    !instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowPinButton(index)) &&
    !instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowRefreshButton(index)) &&
    !instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowCollapseButton(index)) &&
    !instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowMaximizeButton(index)))
    ASPx.PWMDown(evt, instance.name, index, instance.isWindowDragging);
  }
 },
 GetWindowElementMouseMoveEventHandler: function(index) {
  var instance = this;
  return function(evt) { ASPx.PWMMove(evt, instance.name, index); };
 },
 GetWindowHeaderElementMouseDownEventHandler: function(index) {
  var instance = this;
  return function(evt) {
   if(!instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowCloseButton(index)) &&
    !instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowPinButton(index)) &&
    !instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowRefreshButton(index)) &&
    !instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowCollapseButton(index)) &&
    !instance.PreventHeaderButtonMouseDownBubbling(evt, instance.GetWindowMaximizeButton(index)))
    ASPx.PWDGMDown(evt, instance.name, index);
  }
 },
 AssignWindowElementsEvents: function(index, element) {
  var instance = this;
  var mdEventName = ASPx.TouchUIHelper.touchMouseDownEventName;
  ASPx.Evt.AttachEventToElement(element, mdEventName, this.GetWindowElementMouseDownEventHandler(index));
  if(this.allowResize) {
   var mmEventName = ASPx.TouchUIHelper.touchMouseMoveEventName;
   ASPx.Evt.AttachEventToElement(element, mmEventName, this.GetWindowElementMouseMoveEventHandler(index));
  }
  var header = this.GetWindowHeaderElement(index);
  if(header && this.allowDragging && !this.isWindowDragging) {
   ASPx.Evt.AttachEventToElement(header, mdEventName, this.GetWindowHeaderElementMouseDownEventHandler(index), true);
  }
  var sizeGrip = this.GetWindowSizeGripElement(index);
  if(sizeGrip) {
   ASPx.Evt.AttachEventToElement(sizeGrip, mdEventName, function(evt) {
    ASPx.PWGripMDown(evt, instance.name, index);
    ASPx.Evt.PreventEvent(evt);
   });
  }
  this.AttachClickToHeaderButton(index, this.GetWindowCloseButton(index), "ASPx.PWCBClick");
  this.AttachClickToHeaderButton(index, this.GetWindowPinButton(index), "ASPx.PWPBClick");
  this.AttachClickToHeaderButton(index, this.GetWindowRefreshButton(index), "ASPx.PWRBClick");
  this.AttachClickToHeaderButton(index, this.GetWindowCollapseButton(index), "ASPx.PWMNBClick");
  this.AttachClickToHeaderButton(index, this.GetWindowMaximizeButton(index), "ASPx.PWMXBClick");
 },
 AttachClickToHeaderButton: function(index, headerButton, eventFuncName) {
  var instance = this;
  if(headerButton) {
   ASPx.Evt.AttachEventToElement(headerButton, "click", function(evt) {
    eval(eventFuncName)(evt, instance.name, index);
   });
  }
 },
 InitializeWindow: function(index) {
  var modalElement = this.GetWindowModalElement(index);
  if(modalElement)
   ASPx.Evt.AttachEventToElement(modalElement, "mousedown", aspxPWMEMDown);
  this.RemoveWindowAllPopupElements(index);
  this.PopulatePopupElements(index);
  var element = this.GetWindowElement(index);
  if(element != null) {
   this.AssignWindowElementsID(index, element);
   this.AssignWindowElementsEvents(index, element);
   element.DXPopupWindowElement = true;
   ASPx.Evt.AttachEventToElement(element, "resize", this.CreateWindowResizeHandler(this.name, index));
   if(ASPx.Browser.IE)
    this.AttachOnDragStartEventToWindowImages(index);
   var contentUrl = this.GetWindowContentIFrameUrl(index);
   if(contentUrl != "")
    this.SetWindowContentUrlInternal(index, contentUrl);
   element.isHiding = false;
   element.isContentHeightInit = false;
   element.isPopupPositionCorrectionOn = this.isPopupPositionCorrectionOn || !this.GetShowOnPageLoad(index);
   if(this.GetShowOnPageLoad(index) && this.GetZIndex(index) > 0) {
    this.FirstShowWindow(index, false);
    aspxGetPopupControlCollection().SetWindowElementZIndex(element, this.GetZIndex(index));
    element.isPopupPositionCorrectionOn = true;
   }
   this.InitializeWindowEscKeyHandler(element, index);
  }
 },
 InitializeWindowEscKeyHandler: function(element, index) {
  if(!this.GetEnableCloseByEsc(index)) return;
  this.AddKeyDownHandler("ESC", this.OnEscKeyDown.aspxBind(this));
 },
 OnEscKeyDown: function(index) {
  if(this.GetEnableCloseByEsc(index))
   this.DoHideWindow(index, false, ASPxClientPopupControlCloseReason.Escape);
 }, 
 OnDocumentKeyDown: function(evt, popupWindow) {
  var handler = this.keyDownHandlers && this.keyDownHandlers[ASPx.GetShortcutCode(evt.keyCode, evt.ctrlKey, evt.shiftKey, evt.altKey)];
  if(handler)
   handler(this.GetWindowIndex(popupWindow));
 },
 CreateWindowResizeHandler: function(name, index) {
  return function() {
   var pc = aspxGetPopupControlCollection().Get(name);
   if(pc)
    pc.ResizeWindowIFrame(index);
  };
 },
 BrowserWindowResizeSubscriber: function() {
  return true;
 },
 OnBrowserWindowResize: function(evt) {
  window.setTimeout(this.SetPopupMaximizedPositionOnBrowserResize.aspxBind(this), 0);
 },
 SetPopupMaximizedPositionOnBrowserResize: function() {
  if(this.HasDefaultWindow())
   this.SetMaximizedPositionOnBrowserResize(-1);
  for(var i = 0; i < this.GetWindowCount() ; i++)
   this.SetMaximizedPositionOnBrowserResize(i);
 },
 SetMaximizedPositionOnBrowserResize: function(index) {
  var element = this.GetWindowElement(index);
  if(element && this.GetIsMaximized(index) && this.InternalIsWindowVisible(index)) {
   var left = this.GetMaximizedPosition(element, true);
   var top = this.GetMaximizedPosition(element, false);
   this.SetWindowPos(index, element, left, top);
  }
 },
 InitIFrame: function(index) {
  var contentIFrameElement = this.GetWindowContentIFrameElement(index);
  if(contentIFrameElement) {
   contentIFrameElement.popupControlName = this.name;
   contentIFrameElement.pcWndIndex = index;
   ASPx.Evt.AttachEventToElement(contentIFrameElement, "load", ASPx.PCIframeLoad);
  }
 },
 InitCollapsedWindows: function(index) {
  if((this.isCollapsedInit && index == -1) || (index >= 0 && index < this.isCollapsedInitArray.length && this.isCollapsedInitArray[index])) {
   if(this.InternalIsWindowVisible(index)) {
    this.DoCollapse(index, true);
    if(index == -1)
     this.isCollapsedInit = false;
    else
     this.isCollapsedInitArray[index] = false;
   }
  }
 },
 InitMaximizedWindows: function(index) {
  if(this.GetIsMaximizedInit(index) && this.InternalIsWindowVisible(index)) {
   this.DoMaximize(index, true);
   this.SetIsMaximizedInit(index, false);
  }
 },
 InitPinnedWindows: function(index) {
  if((this.isPinned && index == -1) || (index >= 0 && index < this.isPinnedArray.length && this.isPinnedArray[index]))
   this.HoldPosition(index, true);
 },
 AfterInitializeWindow: function(index) {
  if(this.contentOverflowX !== "None" && !this.GetWindowWidthFromServer(index))
   this.SetWindowWidth(index, 0);
  if(this.GetShowOnPageLoad(index) && this.GetZIndex(index) < 0) {
   this.FirstShowWindow(index, true);
   var element = this.GetWindowElement(index);
   if(element != null)
    element.isPopupPositionCorrectionOn = true;
  }
  this.EnsureContent(index, true);
  this.InitPinnedWindows(index);
  this.InitMaximizedWindows(index);
  this.InitCollapsedWindows(index);
 },
 AttachOnDragStartEventToWindowImages: function(index) {
  this.AttachChildImagesPreventDragStartEvent(this.GetWindowHeaderElement(index));
  this.AttachChildImagesPreventDragStartEvent(this.GetWindowFooterElement(index));
 },
 AttachChildImagesPreventDragStartEvent: function(parentElem) {
  var images = parentElem == null ? null : ASPx.GetNodesByTagName(parentElem, "img");
  if(images != null) {
   for(var i = 0; i < images.length; i++)
    ASPx.Evt.AttachEventToElement(images[i], "dragstart", ASPx.Evt.PreventDragStart);
  }
 },
 FirstShowWindow: function(index, allowChangeZIndex) {
  var isFreeWindow = this.GetIsDragged(index);
  var x = ASPx.InvalidPosition;
  var y = ASPx.InvalidPosition;
  if(isFreeWindow) {
   x = this.GetWindowLeft(index);
   y = this.GetWindowTop(index);
   var popupHorizontalOffsetBackup = this.popupHorizontalOffset;
   var popupVerticalOffsetBackup = this.popupVerticalOffset;
   this.popupHorizontalOffset = 0;
   this.popupVerticalOffset = 0;
  }
  this.LockAnimation();
  this.DoShowWindowAtPos(index, x, y, isFreeWindow ? -1 : 0, false, allowChangeZIndex);
  this.UnlockAnimation();
  if(isFreeWindow) {
   this.popupHorizontalOffset = popupHorizontalOffsetBackup;
   this.popupVerticalOffset = popupVerticalOffsetBackup;
  }
  this.CorrectElementVerticalAlignment(ASPx.AdjustVerticalMarginsInContainer, this.GetWindowHeaderElement(index));
 },
 GetIsDragged: function(index) {
  if(0 <= index && index < this.isDraggedArray.length)
   return this.isDraggedArray[index];
  return this.isDragged;
 },
 SetIsDragged: function(index, value) {
  if(0 <= index && index < this.isDraggedArray.length)
   this.isDraggedArray[index] = value;
  else
   this.isDragged = value;
 },
 GetIsPinned: function(index) {
  if(0 <= index && index < this.isPinnedArray.length)
   return this.isPinnedArray[index];
  return this.isPinned;
 },
 SetIsPinned: function(index, value) {
  if(0 <= index && index < this.isPinnedArray.length)
   this.isPinnedArray[index] = value;
  else
   this.isPinned = value;
 },
 GetPinPosX: function(index) {
  if(0 <= index && index < this.pinXArray.length)
   return this.pinXArray[index];
  return this.pinX;
 },
 SetPinPosX: function(index, pinX) {
  if(0 <= index && index < this.pinXArray.length)
   this.pinXArray[index] = pinX;
  else
   this.pinX = pinX;
 },
 GetPinPosY: function(index) {
  if(0 <= index && index < this.pinYArray.length)
   return this.pinYArray[index];
  return this.pinY;
 },
 SetPinPosY: function(index, pinY) {
  if(0 <= index && index < this.pinYArray.length)
   this.pinYArray[index] = pinY;
  else
   this.pinY = pinY;
 },
 GetIsCollapsed: function(index) {
  if(0 <= index && index < this.isCollapsedArray.length)
   return this.isCollapsedArray[index];
  return this.isCollapsed;
 },
 SetIsCollapsed: function(index, value) {
  if(0 <= index && index < this.isCollapsedArray.length)
   this.isCollapsedArray[index] = value;
  else
   this.isCollapsed = value;
 },
 GetIsMaximized: function(index) {
  if(0 <= index && index < this.isMaximizedArray.length)
   return this.isMaximizedArray[index];
  return this.isMaximized;
 },
 GetIsMaximizedOnWebKitTouch: function(index) {
  return this.GetIsMaximized(index) && ASPx.Browser.WebKitTouchUI;
 },
 SetIsMaximized: function(index, value) {
  if(0 <= index && index < this.isMaximizedArray.length)
   this.isMaximizedArray[index] = value;
  else
   this.isMaximized = value;
 },
 GetIsMaximizedInit: function(index) {
  if(0 <= index && index < this.isMaximizedInitArray.length)
   return this.isMaximizedInitArray[index];
  return this.isMaximizedInit;
 },
 SetIsMaximizedInit: function(index, value) {
  if(0 <= index && index < this.isMaximizedInitArray.length)
   this.isMaximizedInitArray[index] = value;
  else
   this.isMaximizedInit = value;
 },
 GetRestoredWindowData: function(index) {
  if(0 <= index && index < this.restoredWindowValuesArray.length)
   return this.restoredWindowValuesArray[index];
  return ASPx.CloneObject(this.restoredWindowValues);
 },
 SetRestoredWindowData: function(index, value) {
  if(0 <= index && index < this.restoredWindowValuesArray.length)
   this.restoredWindowValuesArray[index] = value;
  else
   this.restoredWindowValues = value;
 },
 GetIsResized: function(index) {
  if(0 <= index && index < this.isResizedArray.length)
   return this.isResizedArray[index];
  return this.isResized;
 },
 SetIsResized: function(index, value) {
  if(0 <= index && index < this.isResizedArray.length)
   this.isResizedArray[index] = value;
  else
   this.isResized = value;
 },
 GetHorizontalAlign: function() {
  return this.popupHorizontalAlign;
 },
 GetVerticalAlign: function() {
  return this.popupVerticalAlign;
 },
 GetPopupHorizontalOffset: function() {
  return this.popupHorizontalOffset;
 },
 SetPopupHorizontalOffset: function(offset) {
  this.popupHorizontalOffset = offset;
 },
 SetPopupVerticalOffset: function(offset) {
  this.popupVerticalOffset = offset;
 },
 GetPopupVerticalOffset: function() {
  return this.popupVerticalOffset;
 },
 HasDefaultWindow: function() {
  return this.GetWindowCountCore() == 0;
 },
 GetCurrentLeft: function(index) {
  return this.GetPosition(index, true);
 },
 GetCurrentTop: function(index) {
  return this.GetPosition(index, false);
 },
 GetHeaderHeight: function(index) {
  if(0 <= index && index < this.headerHeightArray.length)
   return this.headerHeightArray[index];
  return this.headerHeight;
 },
 GetFooterHeight: function(index) {
  if(0 <= index && index < this.footerHeightArray.length)
   return this.footerHeightArray[index];
  return this.footerHeight;
 },
 GetWindowFooterHeightLite: function(index) {
  var footer = this.GetWindowFooterElement(index);
  if(footer)
   return footer.offsetHeight;
  return null;
 },
 SetHeaderHeight: function(index, height) {
  if(0 <= index && index < this.headerHeightArray.length)
   this.headerHeightArray[index] = height;
  else
   this.headerHeight = height;
 },
 SetFooterHeight: function(index, height) {
  if(0 <= index && index < this.footerHeightArray.length)
   return this.footerHeightArray[index] = height;
  else
   this.footerHeight = height;
 },
 GetPosition: function(index, isLeft) {
  if(0 <= index && index < this.GetWindowCountCore())
   return isLeft ? this.leftArray[index] : this.topArray[index];
  return isLeft ? this.left : this.top;
 },
 GetEnableCloseByEsc: function(index) {
  if(0 <= index && index < this.closeOnEscapeArray.length)
   return this.closeOnEscapeArray[index];
  return this.closeOnEscape;
 },
 SetPopupElementReference: function(index, popupElement, popupElementIndex, attach) {
  if(!ASPx.IsExistsElement(popupElement)) return;
  var setReferenceFunction = attach ? ASPx.Evt.AttachEventToElement : ASPx.Evt.DetachEventFromElement;
  var windowPopupAction = this.GetWindowPopupAction(index);
  if(windowPopupAction == "LeftMouseClick")
   setReferenceFunction(popupElement, "mouseup", aspxPEMEvent);
  else if(windowPopupAction == "RightMouseClick")
   setReferenceFunction(popupElement, "contextmenu", aspxPEMEvent);
  else if(windowPopupAction == "MouseOver") {
   var windowElement = this.GetWindowElement(index);
   setReferenceFunction(popupElement, "mouseover", ASPx.PopupUtils.OverControl.OnMouseOver);
   setReferenceFunction(windowElement, "mouseover", aspxPWEMOver);
   if(attach)
    this.SetMSTouchMouseOverReference(popupElement, windowElement, this.name, index, this.appearAfter);
  }
  if(windowPopupAction == "LeftMouseClick" || windowPopupAction == "RightMouseClick") {
   setReferenceFunction(popupElement, "mousedown", aspxPEMEvent);
  }
  if(attach) {
   popupElement.DXPopupElementControl = this;
   popupElement.DXPopupWindowIndex = index;
   popupElement.DXPopupElementIndex = popupElementIndex;
  } else
   popupElement.DXPopupElementControl = popupElement.DXPopupWindowIndex = popupElement.DXPopupElementIndex = undefined;
 },
 SetMSTouchMouseOverReference: function(popupElement, windowElement, popupName, index, appearAfter) {
  if(!ASPx.TouchUIHelper.pointerEnabled) return;
  popupElement.dxMsTouchGesture = popupElement.dxMsTouchGesture ||
   ASPx.TouchUIHelper.msTouchCreateGesturesWrapper(popupElement, function(evt) {
    window.setTimeout(function() {
     aspxGetPopupControlCollection().SetAppearTimer(popupName, index, popupElement.DXPopupElementIndex, appearAfter, evt);
    }, 0);
   });
  windowElement.dxMsTouchGesture = windowElement.dxMsTouchGesture || ASPx.TouchUIHelper.msTouchCreateGesturesWrapper(windowElement, function(evt) {
   window.setTimeout(function() {
    aspxGetPopupControlCollection().ClearDisappearTimer();
   }, 0);
  });
 },
 PopulatePopupElements: function(index) {
  var ids = this.GetPopupElementIDList(index);
  for(var i = 0; i < ids.length; i++) {
   var popupElement = ASPx.PopupUtils.FindPopupElementById(ids[i]);
   if(popupElement)
    this.AddWindowPopupElement(index, popupElement);
  }
 },
 GetPopupElement: function(index, popupElementIndex) {
  var popupElement = this.GetPopupElementList(index)[popupElementIndex];
  return popupElement ? popupElement : null;
 },
 GetPopupElementIDList: function(index) {
  if(0 <= index && index < this.GetWindowCountCore())
   return this.windowsPopupElementIDList[index];
  return this.defaultWindowPopupElementIDList;
 },
 GetPopupElementList: function(index) {
  if(0 <= index && index < this.GetWindowCountCore())
   return this.windowsPopupElementList[index];
  return this.defaultWindowPopupElementList;
 },
 SetPopupElementIDs: function(index, ids) {
  if(0 <= index && index < this.GetWindowCountCore())
   this.windowsPopupElementIDList[index] = ids;
  this.defaultWindowPopupElementIDList = ids;
 },
 AddPopupElementInternal: function(index, element) {
  var popupElements = this.GetPopupElementList(index);
  for(var i = 0; i < popupElements.length; i++) {
   if(!popupElements[i]) {
    popupElements[i] = element;
    return i;
   }
  }
  popupElements.push(element);
  return popupElements.length - 1;
 },
 RemovePopupElementInternal: function(index, element) {
  var popupElements = this.GetPopupElementList(index);
  for(var i = 0; i < popupElements.length; i++) {
   if(popupElements[i] == element) {
    popupElements[i] = null;
    return;
   }
  }
 },
 AddPopupElement: function(popupElement) {
  this.AddWindowPopupElement(-1, popupElement);
 },
 AddWindowPopupElement: function(index, popupElement) {
  var popupElementIndex = this.AddPopupElementInternal(index, popupElement);
  this.SetPopupElementReference(index, popupElement, popupElementIndex, true);
 },
 RemovePopupElement: function(popupElement) {
  this.RemoveWindowPopupElement(-1, popupElement);
 },
 RemoveWindowPopupElement: function(index, popupElement) {
  this.RemovePopupElementInternal(index, popupElement);
  this.SetPopupElementReference(index, popupElement, null, false);
 },
 RemoveAllPopupElements: function() {
  this.RemoveWindowAllPopupElements(-1);
 },
 RemoveWindowAllPopupElements: function(index) {
  var popupElements = this.GetPopupElementList(index);
  for(var i = 0; i < popupElements.length; i++)
   this.RemoveWindowPopupElement(index, popupElements[i]);
 },
 GetIsPopuped: function(index) {
  if(0 <= index && index < this.GetWindowCountCore())
   return this.windowsIsPopupedList[index];
  return this.defaultIsPopuped;
 },
 SetIsPopuped: function(index, isPopuped) {
  if(0 <= index && index < this.GetWindowCountCore())
   this.windowsIsPopupedList[index] = isPopuped;
  this.defaultIsPopuped = isPopuped;
 },
 GetLastShownPopupElementIndex: function(windowIndex) {
  var info = this.GetLastUsedPopupElementInfo(windowIndex);
  return ASPx.GetDefinedValue(info.shownPEIndex, 0);
 },
 SetLastShownPopupElementIndex: function(windowIndex, popupElementIndex) {
  var info = this.GetLastUsedPopupElementInfo(windowIndex);
  info.shownPEIndex = popupElementIndex;
 },
 GetLastOverPopupElementIndex: function(windowIndex) {
  var info = this.GetLastUsedPopupElementInfo(windowIndex);
  return ASPx.GetDefinedValue(info.overPEIndex, -1);
 },
 SetLastOverPopupElementIndex: function(windowIndex, popupElementIndex) {
  var info = this.GetLastUsedPopupElementInfo(windowIndex);
  info.overPEIndex = popupElementIndex;
 },
 GetLastUsedPopupElementInfo: function(index) {
  if(0 <= index && index < this.GetWindowCountCore())
   return this.windowsLastUsedPopupElementInfoList[index];
  return this.defaultLastUsedPopupElementInfo;
 },
 SetWindowPopUpReasonMouseEvent: function(index, evt) {
  evt = ASPx.CloneObject(evt);
  if(evt === undefined)
   evt = null;
  if(0 <= index && index < this.GetWindowCountCore())
   this.windowsPopupReasonMouseEventList[index] = evt;
  this.defaultPopupReasonMouseEvent = evt;
 },
 GetPopUpReasonMouseEvent: function() {
  return this.GetWindowPopUpReasonMouseEvent(null);
 },
 GetWindowPopUpReasonMouseEvent: function(window) {
  var index = (window != null) ? window.index : -1;
  if(0 <= index && index < this.GetWindowCountCore())
   return this.windowsPopupReasonMouseEventList[index];
  return this.defaultPopupReasonMouseEvent;
 },
 GetShowOnPageLoad: function(index) {
  if(0 <= index && index < this.showOnPageLoadArray.length)
   return this.showOnPageLoadArray[index];
  return this.showOnPageLoad;
 },
 GetWindowCountCore: function() {
  return (this.windows.length > 0) ? this.windows.length : this.windowCount;
 },
 GetWindowIFrame: function(index) {
  var element = this.GetWindowElement(index);
  var iFrame = element.overflowElement;
  if(!iFrame) {
   iFrame = this.FindWindowIFrame(index);
   element.overflowElement = iFrame;
  }
  return iFrame;
 },
 FindWindowIFrame: function(index) {
  return ASPx.GetElementById(this.name + "_DXPWIF" + index);
 },
 GetWindowModalElement: function(index) {
  var element = this.GetWindowElement(index);
  if(!element) return;
  var modalElement = element.modalElement;
  if(!modalElement) {
   modalElement = this.FindWindowModalElement(index);
   element.modalElement = modalElement;
   if(modalElement) {
    modalElement.DXModalPopupControl = this;
    modalElement.DXModalPopupWindowIndex = index;
   }
  }
  return modalElement;
 },
 GetModalElementEndAnimationOpacity: function(index) {
  if(typeof (this.modalElementOpacity) == "undefined")
   this.modalElementOpacity = [];
  if(typeof (this.modalElementOpacity[index]) == "undefined")
   this.modalElementOpacity[index] = ASPx.GetElementOpacity(this.GetWindowModalElement(index));
  return this.modalElementOpacity[index];
 },
 FindWindowModalElement: function(index) {
  return ASPx.GetElementById(this.name + "_DXPWMB" + index);
 },
 GetWindowElementId: function(index) {
  return this.name + ASPx.PCWIdSuffix + index;
 },
 WindowIsModal: function(index) {
  return !!this.GetWindowModalElement(index);
 },
 SetClientModality: function(isModal) {
  this.SetWindowClientModality(-1, isModal);
 },
 SetWindowClientModality: function(index, isModal) {
  var modalElement = this.GetWindowModalElement(index);
  if(isModal && !ASPx.IsElementVisible(modalElement))
   this.DoShowWindowModalElement(index);
  if(!isModal && ASPx.IsElementVisible(modalElement)) {
   var element = this.GetWindowElement(index);
   this.DoHideWindowModalElement(element);
  }
 },
 GetWindowElement: function(index) {
  if(!ASPx.IsExistsElement(this.windowElements[index]))
   this.windowElements[index] = ASPx.GetElementById(this.GetWindowElementId(index));
  return this.windowElements[index];
 },
 GetWindowCloseButton: function(index) {
  return ASPx.GetElementById(this.name + "_HCB" + index);
 },
 GetWindowPinButton: function(index) {
  return ASPx.GetElementById(this.name + "_HPB" + index);
 },
 GetWindowRefreshButton: function(index) {
  return ASPx.GetElementById(this.name + "_HRB" + index);
 },
 GetWindowCollapseButton: function(index) {
  return ASPx.GetElementById(this.name + "_HMNB" + index);
 },
 GetWindowMaximizeButton: function(index) {
  return ASPx.GetElementById(this.name + "_HMXB" + index);
 },
 GetWindowChild: function(index, idPostfix) {
  var elem = this.GetWindowElement(index);
  if(elem)
   return ASPx.GetChildById(elem, this.name + idPostfix);
  return null;
 },
 GetWindowContentIFrameDivElementID: function(index) {
  return this.name + "_CIFD" + index;
 },
 GetWindowContentIFrameDivElement: function(index) {
  return this.GetWindowChild(index, "_CIFD" + index);
 },
 GetWindowScrollDiv: function(index) {
  return this.GetWindowChild(index, "_CSD" + index);
 },
 GetWindowContentIFrameElementId: function(index) {
  return this.name + "_CIF" + index;
 },
 GetWindowContentIFrameElement: function(index) {
  return this.GetWindowChild(index, "_CIF" + index);
 },
 GetWindowContentIFrameUrl: function(index) {
  if(0 <= index && index < this.contentUrlArray.length)
   return this.contentUrlArray[index];
  return this.contentUrl;
 },
 GetWindowContentIFrameTitle: function(index) {
  if(0 <= index && index < this.contentUrlIFrameTitleArray.length)
   return this.contentUrlIFrameTitleArray[index];
  return this.contentUrlIFrameTitle;
 },
 GetWindowPopupAction: function(index) {
  if(0 <= index && index < this.popupActionArray.length)
   return this.popupActionArray[index];
  return this.popupAction;
 },
 GetWindowCloseAction: function(index) {
  if(0 <= index && index < this.closeActionArray.length)
   return this.closeActionArray[index];
  return this.closeAction;
 },
 SetWindowContentIFrameUrl: function(index, url) {
  if(0 <= index && index < this.contentUrlArray.length)
   this.contentUrlArray[index] = url;
  else
   this.contentUrl = url;
 },
 ShowWindowContentUrl: function(index) {
  var contentIFrame = this.GetWindowContentIFrameElement(index);
  this.LoadWindowContentUrl(index);
  if(contentIFrame && contentIFrame.DXReloadAfterShowRequired) {
   this.RefreshWindowContentUrl(this.GetWindow(index));
   contentIFrame.DXReloadAfterShowRequired = false;
  }
 },
 LoadWindowContentUrl: function(index) {
  var url = this.GetWindowContentIFrameUrl(index);
  this.LoadWindowContentFromUrl(index, url);
 },
 LoadWindowContentFromUrl: function(index, url) {
  var element = this.GetWindowContentIFrameElement(index);
  if(element && element.src != url && element.DXSrcRaw != url) {
   this.SetSrcToIframeElement(index, element, url);
   this.SetWindowContentIFrameUrl(index, element.src); 
  }
 },
 SetSrcToIframeElement: function(index, iframeElement, src) {
  this.SetIframeLoading(index, true);
  iframeElement.src = src;
  if(ASPx.Browser.Chrome && src.indexOf("#"))
   this.PreventScrollingAfterIframeLoaded(iframeElement)
  iframeElement.DXSrcRaw = src;
 },
 PreventScrollingAfterIframeLoaded: function(iframeElement) {
  var docScrollTop = ASPx.GetDocumentScrollTop();
  var onIframeLoadedHandler = function() {
   window.setTimeout(function() {
    ASPx.SetDocumentScrollTop(docScrollTop);
    ASPx.Evt.DetachEventFromElement(iframeElement, "load", onIframeLoadedHandler);
   }, 0);
  };
  ASPx.Evt.AttachEventToElement(iframeElement, "load", onIframeLoadedHandler);
 },
 GetWindowContentElement: function(index) {
  return this.GetWindowChild(index, "_PWC" + index);
 },
 GetWindowHeaderElement: function(index) {
  return this.GetWindowChild(index, "_PWH" + index);
 },
 GetWindowHeaders: function() {
  var elements = [];
  if(this.HasDefaultWindow())
   elements = elements.concat(ASPx.GetNodesByClassName(this.GetWindowElement(-1), "dxpc-header"));
  for(var i = 0; i < this.GetWindowCount() ; i++)
   elements = elements.concat(ASPx.GetNodesByClassName(this.GetWindowElement(i), "dxpc-header"));
  return elements;
 },
 GetEnableContentScrolling: function(index) {
  if(0 <= index && index < this.enableContentScrollingArray.length)
   return this.enableContentScrollingArray[index];
  else
   return this.enableContentScrolling;
 },
 GetWindowOverflowX: function(index) {
  if(0 <= index && index < this.contentOverflowXArray.length)
   return this.contentOverflowXArray;
  else
   return this.contentOverflowX;
 },
 GetWindowOverflowY: function(index) {
  if(0 <= index && index < this.contentOverflowYArray.length)
   return this.contentOverflowYArray;
  else
   return this.contentOverflowY;
 },
 GetWindowSizeGripElement: function(index) {
  return this.GetWindowSizeGripLite(index);
 },
 GetWindowSizeGripLite: function(index) {
  var footer = this.GetWindowFooterElement(index);
  if(!footer)
   return null;
  var descendants = ASPx.GetNodesByClassName(footer, PopupControlCssClasses.SizeGripLiteCssClassName);
  return descendants.length > 0 ? descendants[0] : null;
 },
 GetWindowFooterElement: function(index) {
  return this.GetWindowChild(index, "_PWF" + index);
 },
 GetContentContainer: function(index) {
  return this.GetWindowContentElement(index);
 },
 GetWindowIndex: function(element) {
  var id = element.id;
  var pos = id.lastIndexOf(ASPx.PCWIdSuffix);
  return parseInt(id.substr(pos + ASPx.PCWIdSuffix.length));
 },
 GetWindowElementDisplayValue: function(windowHasAnyScrollbars, windowHeight) {
  return windowHasAnyScrollbars && windowHeight ? "block" : "table";
 },
 HaveSpecialDivForAnimation: function() {
  return this.enableAnimation;
 },
 GetWindowMainCell: function(element) {
  return this.HaveSpecialDivForAnimation() ? ASPx.GetNodeByTagName(element, "DIV", 0) : element;
 },
 GetWindowMainTable: function(element) {
  return this.GetWindowMainCell(element);
 },
 GetWindowShadowTable: function(index) {
  var shadowTable = this.HaveSpecialDivForAnimation() ? this.GetWindowShadowTableCore(index) : this.GetWindowElement(index);
  if(!shadowTable) return null;
  if(shadowTable.tagName != "TABLE")
   shadowTable = this.GetWindowShadowTableCore(index);
  return (shadowTable && shadowTable.tagName == "TABLE") ? shadowTable : null;
 },
 GetWindowShadowTableCore: function(index) {
  return this.GetWindowChild(index, "_PWST" + index);
 },
 GetWindowClientTable: function(index) {
  return this.GetWindowElement(index);
 },
 GetWindowIsShown: function(index) {
  if(0 <= index && index < this.shownArray.length)
   return this.shownArray[index];
  return this.shown;
 },
 SetWindowIsShown: function(index, shown) {
  if(0 <= index && index < this.shownArray.length)
   this.shownArray[index] = shown;
  else
   this.shown = shown;
 },
 GetWindowLeft: function(index) {
  if(0 <= index && index < this.leftArray.length)
   return this.leftArray[index];
  return this.left;
 },
 SetWindowLeft: function(index, left) {
  if(0 <= index && index < this.leftArray.length)
   this.leftArray[index] = left;
  else
   this.left = left;
 },
 GetWindowHeightInternal: function(index) {
  if(0 <= index && index < this.heightArray.length)
   return this.heightArray[index];
  return this.height;
 },
 GetWindowMinHeight: function(index) {
  if(0 <= index && index < this.minHeightArray.length)
   return this.minHeightArray[index];
  return this.minHeight;
 },
 GetWindowMaxHeight: function(index) {
  if(0 <= index && index < this.maxHeightArray.length)
   return this.maxHeightArray[index];
  return this.maxHeight;
 },
 SetWindowHeight: function(index, height) {
  if(0 <= index && index < this.heightArray.length)
   this.heightArray[index] = height;
  else
   this.height = height;
 },
 GetWindowWidthInternal: function(index) {
  if(0 <= index && index < this.widthArray.length)
   return this.widthArray[index];
  return this.width;
 },
 GetWindowWidthFromServer: function(index) {
  if(0 <= index && index < this.widthFromServerArray.length)
   return this.widthFromServerArray[index];
  return this.widthFromServer;
 },
 GetWindowMinWidth: function(index) {
  if(0 <= index && index < this.minWidthArray.length)
   return this.minWidthArray[index];
  return this.minWidth;
 },
 GetWindowMaxWidth: function(index) {
  if(0 <= index && index < this.maxWidthArray.length)
   return this.maxWidthArray[index];
  return this.maxWidth;
 },
 SetWindowWidth: function(index, width) {
  if(0 <= index && index < this.widthArray.length)
   this.widthArray[index] = width;
  else
   this.width = width;
 },
 GetWindowTop: function(index) {
  if(0 <= index && index < this.topArray.length)
   return this.topArray[index];
  return this.top;
 },
 SetWindowTop: function(index, top) {
  if(0 <= index && index < this.topArray.length)
   return this.topArray[index] = top;
  else
   return this.top = top;
 },
 GetStateHiddenFieldName: function() {
  return this.uniqueID + "State";
 },
 GetZIndex: function(index) {
  if(0 <= index && index < this.zIndexArray.length)
   return this.zIndexArray[index];
  return this.zIndex;
 },
 GetCurrentZIndex: function(index) {
  var element = this.GetWindowElement(index);
  if(element != null) {
   if(element.style.zIndex != "" && element.style.zIndex != defaultZIndexFromServer)
    return element.style.zIndex;
   if(0 <= index && index < this.GetWindowCountCore())
    return this.zIndexArray[index];
   return this.zIndex;
  }
 },
 GetMainWindowWidth: function(index, noCache) {
  return this.GetClientWindowWidth(index, true, noCache);
 },
 GetClientWindowWidth: function(index, outerSize, noCache) {
  if(!noCache && (this.GetIsCollapsed(index) || this.GetIsMaximized(index))) {
   var cachedSize = this.GetWindowCachedSize(index);
   if(cachedSize != null)
    return cachedSize.width;
  }
  var element = this.GetWindowElement(index);
  if(element != null)
   return element.offsetWidth;
 },
 GetMainWindowHeight: function(index, noCache) {
  return this.GetClientWindowHeight(index, true, noCache);
 },
 GetClientWindowHeight: function(index, outerSize, noCache) {
  if(!noCache && (this.GetIsCollapsed(index) || this.GetIsMaximized(index))) {
   var cachedSize = this.GetWindowCachedSize(index);
   if(cachedSize != null)
    return cachedSize.height;
  }
  var element = this.GetWindowElement(index);
  if(element != null)
   return element.offsetHeight;
 },
 GetIframeLoading: function(index) {
  if(0 <= index && index < this.iframeLoadingArray.length)
   return this.iframeLoadingArray[index];
  return this.iframeLoading;
 },
 SetIframeLoading: function(index, value) {
  if(0 <= index && index < this.iframeLoadingArray.length)
   this.iframeLoadingArray[index] = value;
  else
   this.iframeLoading = value;
 },
 GetAutoUpdatePosition: function(index) {
  if(0 <= index && index < this.autoUpdatePositionArray.length)
   return this.autoUpdatePositionArray[index];
  return this.autoUpdatePosition;
 },
 GetHideBodyScrollWhenModal: function(index) {
  if(0 <= index && index < this.hideBodyScrollWhenModalArray.length)
   return this.hideBodyScrollWhenModalArray[index];
  return this.hideBodyScrollWhenModal;
 },
 SetHideBodyScrollWhenModal: function(index, value) {
  if(0 <= index && index < this.hideBodyScrollWhenModalArray.length)
   this.hideBodyScrollWhenModalArray[index] = value;
  else
   this.hideBodyScrollWhenModal = value;
 },
 GetClientPopupPos: function(element, popupElement, pos, isX, isDragged) {
  var index = this.GetWindowIndex(element);
  var popupPosition = null;
  if(this.GetIsMaximizedOnWebKitTouch(index))
   return new ASPx.PopupPosition(ASPx.PrepareClientPosForElement(0, element, isX), false);
  if(isDragged)
   popupPosition = new ASPx.PopupPosition(pos == ASPx.InvalidPosition ? this.GetPosition(index, isX) : pos, false);
  else
   popupPosition = isX ? this.GetClientPopupPosX(element, popupElement, pos) : this.GetClientPopupPosY(element, popupElement, pos);
  popupPosition.position = ASPx.PrepareClientPosForElement(popupPosition.position, element, isX);
  if(ASPx.Browser.Firefox && ASPx.Browser.Version < 3 && this.GetWindowModalElement(index))
   popupPosition.position -= isX ? ASPx.GetDocumentScrollLeft() : ASPx.GetDocumentScrollTop();
  return popupPosition;
 },
 GetClientPopupPosX: function(element, popupElement, x) {
  var mainElement = this.GetWindowMainCell(element);
  var popupPosition = ASPx.PopupUtils.GetPopupAbsoluteX(mainElement, popupElement, this.getWindowHorizontalAlign(element), this.getWindowHorizontalOffset(element),
   x, this.GetWindowLeft(this.GetWindowIndex(element)), this.rtl, this.isPopupFullCorrectionOn);
  return this.CorrectPopupPositionForClientWindow(element, popupPosition, true);
 },
 getWindowHorizontalOffset: function(element) {
  return this.popupHorizontalOffset;
 },
 getWindowHorizontalAlign: function(element) {
  return this.popupHorizontalAlign;
 },
 GetClientPopupPosY: function(element, popupElement, y) {
  var mainElement = this.GetWindowMainCell(element);
  var popupPosition = ASPx.PopupUtils.GetPopupAbsoluteY(mainElement, popupElement, this.getWindowVerticalAlign(element), this.getWindowVerticalOffset(element),
   y, this.GetWindowTop(this.GetWindowIndex(element)), this.isPopupFullCorrectionOn);
  return (this.allowCorrectYOffsetPosition ? this.CorrectPopupPositionForClientWindow(element, popupPosition, false) : popupPosition);
 },
 getWindowVerticalAlign: function(element) {
  return this.popupVerticalAlign;
 },
 getWindowVerticalOffset: function(element) {
  return this.popupVerticalOffset;
 },
 CorrectPopupPositionForClientWindow: function(element, popupPosition, isX) {
  if(element.isPopupPositionCorrectionOn && this.isPopupFullCorrectionOn) {
   popupPosition.position = ASPx.PopupUtils.AdjustPositionToClientScreen(element, popupPosition.position, this.rtl, isX);
  }
  return popupPosition;
 },
 DoShowWindow: function(index, popupElementIndex, evt) {
  if(!this.InternalIsWindowVisible(index)) {
   var x = ASPx.Evt.GetEventX(evt);
   var y = ASPx.Evt.GetEventY(evt);
   this.DoShowWindowAtPos(index, x, y, popupElementIndex, true, true, evt, ASPxClientPopupControlCloseReason.OuterMouseClick);
  }
 },
 AdjustContentOnShow: function(index) {
  var windowElement = this.GetWindowElement(index);
  if(this.adjustInnerControlsSizeOnShow)
   ASPx.GetControlCollection().AdjustControls(windowElement);
 },
 DoShowWindowAtPos: function(index, x, y, popupElementIndex, closeOtherWindows, allowChangeZIndex, evt, closeOtherReason) {
  if(!this.isInitialized)
   this.PopulatePopupElements(index);
  var element = this.GetWindowElement(index);
  if(element != null) {
   this.StopCloseAnimation(index);
   if(this.adjustInnerControlsSizeOnShow) {
    var windowContent = this.GetContentContainer(index);
    var collection = ASPx.GetControlCollection();
    collection.CollapseControls(windowContent);
   }
   this.FFTextCurFixShow(index, true);
   if(closeOtherWindows)
    aspxGetPopupControlCollection().DoHideAllWindows(element, this.GetWindowElementId(index), false, closeOtherReason);
   var isMoving = this.InternalIsWindowVisible(index);
   ASPx.SetElementDisplay(element, true);
   element.style.display = this.GetWindowElementDisplayValue(this.HasAnyScrollBars(index), this.GetPopupWindowDimensionFromCache(index, false));
   element.style.position = "absolute";
   var scrollDiv = this.GetWindowScrollDiv(index),
    shouldResetScrollSize = scrollDiv && this.GetEnableContentScrolling(index) && ASPx.GetDocumentMaxClientHeight() <= element.offsetHeight,
    savedScrollDivHeight = shouldResetScrollSize && scrollDiv.style.height;
   if(shouldResetScrollSize)
    scrollDiv.style.height = 0;
   var cachedSize = this.GetWindowCachedSize(index);
   if(cachedSize != null) {
    this.SetWindowSize(this.GetWindow(index), cachedSize.width, cachedSize.height);
    this.ResetWindowCachedSize(index);
   }
   if(!this.GetWindowIsShown(index)) {
    var width = this.GetPopupWindowDimensionFromCache(index, true),
     height = this.GetPopupWindowDimensionFromCache(index, false);
    this.SetClientWindowSizeCoreLite(index, width, height);
     this.SetWindowIsShown(index, true);
   }
   var popupElement = this.GetPopupElement(index, popupElementIndex);
   if(popupElement)
    this.SetLastShownPopupElementIndex(index, popupElementIndex);
   var isDragged = this.GetIsDragged(index),
    isMaximized = this.GetIsMaximized(index);
   if(isMaximized)
    this.NormalizeMaximizedWindowSize(index);
   var horizontalPopupPosition = this.GetClientPopupPos(element, popupElement, x, true, isDragged);
   var verticalPopupPosition = this.GetClientPopupPos(element, popupElement, y, false, isDragged);
   var clientX = horizontalPopupPosition.position;
   var clientY = verticalPopupPosition.position;
   this.SetWindowPos(index, element, clientX, clientY);
   if(shouldResetScrollSize)
    scrollDiv.style.height = savedScrollDivHeight;
   if(this.hideBodyScrollWhenMaximized && this.GetIsMaximized(index))
    ASPx.PopupUtils.BodyScrollHelper.HideBodyScroll(element.id);
   this.DoShowWindowModalElement(index);
   var isAnimationNeed = this.IsAnimationAllowed() && !isMoving;
   if(isAnimationNeed && this.popupAnimationType !== "none") {
    if(this.popupAnimationType === 'slide')
     this.StartSlideAnimation(element, index, horizontalPopupPosition, verticalPopupPosition);
    else
     this.StartFadeAnimation(element, index);
   } else
    ASPx.SetElementVisibility(element, true);
   this.SetWindowPopUpReasonMouseEvent(index, evt);
   this.ShowWindowContentUrl(index);
   this.AdjustContentOnShow(index);
   var scrollDiv = this.GetWindowScrollDiv(index);
   if(scrollDiv && this.GetEnableContentScrolling(index)) {
    var dimension = null;
    var windowMainCell = this.GetWindowMainCell(element);
    if(windowMainCell.style.width && windowMainCell.style.height)
     dimension = 'both';
    else if(windowMainCell.style.width)
     dimension = 'width';
    else if(windowMainCell.style.height)
     dimension = 'height';
    if(!dimension)
     return;
    ASPx.SetElementDisplay(scrollDiv, false);
    this.SetWindowScrollDivSize(scrollDiv, index, dimension);
    ASPx.SetElementDisplay(scrollDiv, true);
   }
   this.registerAndActivateWindow(element, index, allowChangeZIndex);
   if(!isMoving) {
    this.RaisePopUp(index);
    if(!this.IsAnimationAllowed())
     this.OnWindowShown(index);
   }
   this.CorrectWindowSizeGripPositionLite(index);
   this.CorrectWindowHeaderText(index);
   this.InitMaximizedWindows(index);
   this.InitCollapsedWindows(index);
   if(this.GetIsPinned(index)) window.setTimeout(function() { this.HoldPosition(index, true); }.aspxBind(this), 0);
   if(!this.GetShowOnPageLoad(index))
    this.CorrectElementVerticalAlignment(ASPx.AdjustVerticalMarginsInContainer, this.GetWindowHeaderElement(index));
  }
 },
 registerAndActivateWindow: function(windowElement, index, allowChangeZIndex) {
  aspxGetPopupControlCollection().RegisterVisibleWindow(windowElement, this, index);
  if(allowChangeZIndex)
   aspxGetPopupControlCollection().ActivateWindowElement(windowElement);
 },
 GetPopupWindowDimensionFromCache: function(index, isWidth) {
  var dimension;
  if(isWidth) {
   dimension = Math.max(this.GetWindowWidthInternal(index), this.GetWindowMinWidth(index));
   var maxWidth = this.GetWindowMaxWidth(index);
   if(maxWidth)
    dimension = Math.min(dimension, maxWidth);
  }
  else {
   dimension = Math.max(this.GetWindowHeightInternal(index), this.GetWindowMinHeight(index));
   var maxHeight = this.GetWindowMaxHeight(index);
   if(maxHeight)
    dimension = Math.min(dimension, maxHeight);
  }
  return dimension;
 },
 NormalizeMaximizedWindowSize: function(index) {
  var width = this.GetPopupWindowDimensionFromCache(index, true),
   height = this.GetPopupWindowDimensionFromCache(index, false),
   dimensions = this.getDocumentDimensions(index),
   sizeNormalizationIsNeeded = width < dimensions.width || height < dimensions.height;
  if(sizeNormalizationIsNeeded)
   this.NormalizeWindowSize(index, true);
 },
 NormalizeWindowSize: function(index, isMaximized) {
  var width = this.GetClientWindowWidth(index),
   height = this.GetClientWindowHeight(index),
   normWidth = width,
   normHeight = height,
   maxWidth = this.GetWindowMaxWidth(index),
   minWidth = this.GetWindowMinWidth(index),
   maxHeight = this.GetWindowMaxHeight(index),
   minHeight = this.GetWindowMinHeight(index);
  if(maxWidth)
   normWidth = Math.min(normWidth, maxWidth);
  if(minWidth)
   normWidth = Math.max(normWidth, minWidth);
  if(maxHeight)
   normHeight = Math.min(normHeight, maxHeight);
  if(minHeight)
   normHeight = Math.max(normHeight, minHeight);
  if(normWidth !== width || normHeight !== height)
   this.SetWindowSize(this.GetWindow(index), normWidth, normHeight);
  if(isMaximized) {
   var dimensions = this.getDocumentDimensions(index);
   if(this.GetIsCollapsed(index)) {
    if(normWidth != dimensions.width) {
     this.SetWindowSizeByIndexCore(index, dimensions.width, normHeight, true);
    }
   } else {
    if(normWidth != dimensions.width || normHeight != dimensions.height) {
     this.SetWindowSizeByIndexCore(index, dimensions.width, dimensions.height, false);
    }
   }
  }
 },
 DoShowWindowIFrame: function(index, x, y, width, height) {
  if(!this.renderIFrameForPopupElements) return;
  var element = this.GetWindowElement(index);
  var iFrame = this.GetWindowIFrame(index);
  if(element && iFrame) {
   var cell = this.GetWindowMainCell(element);
   if(width < 0)
    width = cell.offsetWidth;
   if(height < 0)
    height = cell.offsetHeight;
   ASPx.SetStyles(iFrame, { width: width, height: height });
   if(x != ASPx.InvalidPosition && y != ASPx.InvalidPosition)
    ASPx.SetStyles(iFrame, { left: x, top: y });
   if(ASPx.Browser.IE || ASPx.Browser.Firefox)
    this.ClearWindowIframeBodyInnerHtml(iFrame);
   ASPx.SetElementDisplay(iFrame, true);
  }
 },
 GetIframeBody: function(iFrame) {
  var document = iFrame.contentDocument || iFrame.contentWindow.document;
  if(document)
   return document.getElementsByTagName('body')[0];
 },
 ClearWindowIframeBodyInnerHtml: function(iFrame) {
  var iFrameBody = this.GetIframeBody(iFrame);
  if(iFrameBody)
   iFrameBody.innerHTML = "";
 },
 DoShowWindowModalElement: function(index) {
  var modalElement = this.GetWindowModalElement(index);
  if(modalElement) {
   var bodyScrollHasJustBeingHidden = false;
   if(this.GetHideBodyScrollWhenModal(index) && (!this.IsWindowVisible(this.GetWindow(index)) || !ASPx.IsElementVisible(modalElement))) {
    bodyScrollHasJustBeingHidden = true;
    aspxGetPopupControlCollection().LockWindowResizeByBodyScrollVisibilityChanging();
    ASPx.PopupUtils.BodyScrollHelper.HideBodyScroll(this.GetWindowElementId(index));
   }
   if(ASPx.Browser.IE && this.GetHideBodyScrollWhenModal(index))
    ASPx.Evt.AttachEventToElement(modalElement, ASPx.Evt.GetMouseWheelEventName(), function(evt) { return ASPx.Evt.PreventEventAndBubble(evt); });
   ASPx.SetElementDisplay(modalElement, true);
   aspxGetPopupControlCollection().AdjustModalElementBounds(modalElement);
   if(this.popupAnimationType == "fade") {
    var endOpacity = this.GetModalElementEndAnimationOpacity(index);
    if(ASPx.Browser.IE && ASPx.Browser.MajorVersion < 9) {
     ASPx.SetElementVisibility(modalElement, true);
     ASPx.AnimationHelper.setOpacity(modalElement, 0);
    } else {
     ASPx.AnimationHelper.setOpacity(modalElement, 0);
     ASPx.SetElementVisibility(modalElement, true);
    }
    ASPx.AnimationHelper.fadeTo(modalElement, { to: endOpacity });
   } else {
    ASPx.SetElementVisibility(modalElement, true);
   }
   aspxGetPopupControlCollection().RegisterVisibleModalElement(modalElement);
   if(bodyScrollHasJustBeingHidden)
    aspxGetPopupControlCollection().UnlockWindowResizeByBodyScrollVisibilityChanging();
  }
 },
 DoHideWindowCore: function(index, closeReason) {
  this.FFTextCurFixHide(index, true);
  var element = this.GetWindowElement(index);
  if(element != null) {
   if(this.HasCloseAnimation())
    this.PrepareElementAfterCloseAnimation(element);
   element.isHiding = true;
   element.style.zIndex = defaultZIndexFromServer;
   this.SetIsDragged(index, false);
   this.UpdateWindowsStateCookie();
   element.isHiding = false;
   this.StopShowAnimation(index);
   ASPx.SetElementDisplay(element, false);
   ASPx.SetElementVisibility(element, false);
   if(this.hideBodyScrollWhenMaximized && this.GetIsMaximized(index))
    ASPx.PopupUtils.BodyScrollHelper.RestoreBodyScroll(element.id);
   this.DoHideWindowModalElement(element, closeReason);
   this.DoHideWindowIFrame(element);
   aspxGetPopupControlCollection().UnregisterVisibleWindow(element);
   this.HideWindowLoadingPanel(index);
  }
 },
 PrepareElementAfterCloseAnimation: function(element) {
  element.closeAnimationCompleted = true;
  if(this.closeAnimationType == "fade")
   ASPx.SetStyles(element, { opacity: 1 });
  else
   ASPx.SetStyles(this.GetWindowMainTable(element), {
    left: 0,
    top: 0
   });
 },
 HasCloseAnimation: function() {
  return this.closeAnimationType != "none";
 },
 StopCloseAnimation: function(index) {
  var element = this.GetWindowElement(index);
  if(this.HasCloseAnimation() && !element.closeAnimationCompleted) {
   ASPx.AnimationHelper.cancelAnimation(element);
   this.DoHideWindowCore(index);
  }
 },
 StopShowAnimation: function(index) {
  if(this.popupAnimationType != "none") {
   var windowElement = this.GetWindowElement(index);
   if(this.popupAnimationType === 'slide')
    ASPx.PopupUtils.StopAnimation(windowElement, this.GetWindowMainCell(windowElement));
   else
    ASPx.AnimationHelper.cancelAnimation(windowElement);
  }
 },
 DoHideWindowCoreWithAnimation: function(index, closeReason) {
  this.StopShowAnimation(index);
  var element = this.GetWindowElement(index);
  element.closeAnimationCompleted = false;
  if(this.closeAnimationType == "fade") {
   if(element.modalElement)
    ASPx.AnimationHelper.fadeOut(element.modalElement, null, this.fadeAnimationDuration);
   ASPx.AnimationHelper.fadeOut(element, function() {
    this.DoHideWindowCore(index);
    this.RaiseCloseUp(index, closeReason);
   }.aspxBind(this), this.fadeAnimationDuration);
  }
  else
   this.DoHideWindowWithSlideAnimation(index, closeReason);
 },
 DoHideWindowWithSlideAnimation: function(index, closeReason) {
  var element = this.GetWindowElement(index);
  var horizontalPopupPosition = this.GetClientPopupPos(element, null, ASPx.InvalidPosition, true, true);
  var verticalPopupPosition = this.GetClientPopupPos(element, null, ASPx.InvalidPosition, false, true);
  var horizontalDirection = ASPx.PopupUtils.GetAnimationHorizontalDirection(horizontalPopupPosition, this.popupHorizontalAlign, this.popupVerticalAlign, this.rtl);
  var verticalDirection = ASPx.PopupUtils.GetAnimationVerticalDirection(verticalPopupPosition, this.popupHorizontalAlign, this.popupVerticalAlign);
  ASPx.PopupUtils.InitAnimationDivCore(element);
  ASPx.AnimationHelper.createMultipleAnimationTransition(this.GetWindowMainTable(element), {
   duration: this.slideAnimationDuration,
   onComplete: function(element) {
    this.DoHideWindowCore(index);
    this.RaiseCloseUp(index, closeReason);
   }.aspxBind(this)
  }).Start({
   left: { to: horizontalDirection * element.offsetWidth, unit: "px" },
   top: { to: verticalDirection * element.offsetHeight, unit: "px" }
  });
 },
 DoHideWindow: function(index, dontRaiseClosing, closeReason) {
  if(!this.InternalIsWindowVisible(index)) return;
  var cancel = !dontRaiseClosing && this.RaiseClosing(index, closeReason);
  if(!cancel) {
   if(this.HasCloseAnimation())
    this.DoHideWindowCoreWithAnimation(index, closeReason);
   else {
    this.DoHideWindowCore(index, closeReason);
    this.RaiseCloseUp(index, closeReason);
   }
  }
  return cancel;
 },
 DoHideWindowIFrame: function(element) {
  if(!this.renderIFrameForPopupElements) return;
  var iFrame = element.overflowElement;
  if(iFrame)
   ASPx.SetElementDisplay(iFrame, false);
 },
 DoHideWindowModalElement: function(element, closeReason) {
  var modalElement = element.modalElement;
  if(modalElement) {
   if(!ASPx.GetElementVisibility(modalElement))
    return;
   function closeModalElement() {
    ASPx.SetStyles(modalElement, { width: 1, height: 1, zIndex: defaultZIndexFromServer - 1 });
    ASPx.SetElementVisibility(modalElement, false);
    ASPx.SetElementDisplay(modalElement, false);
   }
   aspxGetPopupControlCollection().UnregisterVisibleModalElement(modalElement);
   if(this.GetHideBodyScrollWhenModal(this.GetWindowIndex(element))) {
    if(ASPx.Browser.WebKitFamily)
     aspxGetPopupControlCollection().LockScrollEvent();
    ASPx.PopupUtils.BodyScrollHelper.RestoreBodyScroll(element.id);
    if(ASPx.Browser.WebKitFamily)
     aspxGetPopupControlCollection().UnlockScrollEvent();
   }
   if(closeReason == ASPxClientPopupControlCloseReason.OuterMouseClick) {     
    ASPx.SetStyles(modalElement, { opacity: 0 });
    if(!modalElement.mouseHandler) {
     modalElement.mouseHandler = function() {
      ASPx.SetStyles(modalElement, { opacity: "" });
      closeModalElement();
      ASPx.Evt.DetachEventFromElement(modalElement, "mouseup", modalElement.mouseHandler);
      ASPx.Evt.DetachEventFromElement(modalElement, "mouseout", modalElement.mouseHandler);
     }
    }
    ASPx.Evt.AttachEventToElement(modalElement, "mouseup", modalElement.mouseHandler);
    ASPx.Evt.AttachEventToElement(modalElement, "mouseout", modalElement.mouseHandler);
   } else
    closeModalElement();
  }
 },
 SetWindowDisplay: function(index, value) {
  var pcwElement = this.GetWindowElement(index);
  this.SetFFTextCurFixShowing(index, value, false);
  ASPx.SetElementDisplay(pcwElement, value);
 },
 GetTextCurFixDiv: function(index) {
  return ASPx.GetElementById(this.name + "_" + "TCFix" + index);
 },
 FFTextCurFixShow: function(index, isSetVisibility) {
  this.SetFFTextCurFixShowing(index, true, isSetVisibility);
 },
 FFTextCurFixHide: function(index, isSetVisibility) {
  this.SetFFTextCurFixShowing(index, false, isSetVisibility);
 },
 IsFFTextCurFixRequired: function(index) {
  return ASPx.Browser.Firefox && ASPx.Browser.Version < 3 && this.GetWindowModalElement(index);
 },
 SetFFTextCurFixShowing: function(index, value, isSetVisibility) {
  if(this.IsFFTextCurFixRequired(index)) {
   var fixDiv = this.GetTextCurFixDiv(index);
   if(fixDiv) {
    if(isSetVisibility)
     ASPx.SetElementVisibility(fixDiv, value);
    ASPx.SetElementDisplay(fixDiv, value);
   }
  }
 },
 SetWindowPos: function(index, element, x, y) {
  ASPx.SetStyles(element, { left: x, top: y });
  this.DoShowWindowIFrame(index, x, y, ASPx.InvalidDimension, ASPx.InvalidDimension);
  this.SetIsDragged(index, true);
  this.SetWindowLeft(index, ASPx.GetAbsoluteX(element));
  this.SetWindowTop(index, ASPx.GetAbsoluteY(element));
  this.UpdateWindowsStateCookie();
 },
 OnWindowShown: function(windowIndex) {
  this.EnsureContent(windowIndex, false);
  this.EnsureIFrameHeightAdjusted(windowIndex);
  var isMaximized = this.GetIsMaximized(windowIndex);
  if(isMaximized || this.HasAnyScrollBars(windowIndex))
   this.NormalizeWindowSize(windowIndex, isMaximized);
  this.RaiseShown(windowIndex);
  var loadingElementsWillNotBeShown = !this.lpTimers[windowIndex] || this.lpTimers[windowIndex] < 0;
  if(this.InWindowCallback(windowIndex) && loadingElementsWillNotBeShown) {
   this.ShowWindowLoadingElementsInternal(windowIndex);
  }
 },
 EnsureContent: function(windowIndex, isInit) {
  var element = this.GetWindowElement(windowIndex);
  if(element && !element.loaded && !element.loading) {
   var shouldLoad = this.contentLoadingMode == "OnPageLoad" || this.contentLoadingMode == "OnFirstShow" && !isInit;
   if(shouldLoad) {
    element.loading = true;
    this.CreateWindowCallback(windowIndex, windowIndex);
   } else if(this.contentLoadingMode == "Default")
    element.loaded = true;
  }
 },
 CreateWindowCallback: function(windowIndex, argument) {
  this.IncreaseWindowRequestCount(windowIndex);
  var element = this.GetWindowElement(windowIndex);
  if(this.contentLoadingMode != "OnPageLoad" || !element.loading || this.GetShowOnPageLoad(windowIndex))
   this.ShowWindowLoadingElements(windowIndex);
  this.CreateCallback(argument);
 },
 OnCallback: function(result) {
  this.OnCallbackInternal(result.html, result.index, false);
 },
 OnCallbackError: function(result, data) {
  this.OnCallbackInternal(result, ASPx.IsExists(data) ? data : -1, true);
 },
 OnCallbackErrorAfterUserHandle: function(result, data) {
  this.DecreaseWindowRequestCount(data);
 },
 RaiseCallbackError: function(message) {
  var result = ASPxClientControl.prototype.RaiseCallbackError.call(this, message);
  if(result.isHandled)
   this.HideAllLoadingPanels();
  return result;
 },
 OnCallbackInternal: function(html, windowIndex, isError) {
  var element = this.GetWindowElement(windowIndex);
  element.loaded = !isError;
  element.loading = false;
  this.DecreaseWindowRequestCount(windowIndex);
  this.HideWindowLoadingPanel(windowIndex);
  this.SetWindowContentHtmlCore(windowIndex, html);
  if(this.contentLoadingMode === "OnFirstShow" && this.InternalIsWindowVisible(windowIndex))
   this.UpdateWindowPositionInternal(windowIndex, this.GetPopupElement(windowIndex, this.GetLastShownPopupElementIndex(windowIndex)));
  this.savedCallbackWindowIndex = windowIndex;
  this.UpdateWindowsStateCookie();
 },
 IncreaseWindowRequestCount: function(index) {
  !this.windowRequestCount[index] ? this.windowRequestCount[index] = 1 : this.windowRequestCount[index]++;
 },
 DecreaseWindowRequestCount: function(index) {
  this.windowRequestCount[index]--;
 },
 InWindowCallback: function(windowIndex) {
  return this.windowRequestCount[windowIndex] > 0;
 },
 ShowWindowLoadingElements: function(windowIndex) {
  if(this.lpTimers[windowIndex] && this.lpTimers[windowIndex] > -1) return;
  if(this.enableCallbackAnimation)
   this.StartWindowBeginCallbackAnimation(windowIndex);
  else
   this.ShowWindowLoadingElementsInternal(windowIndex);
 },
 ShowWindowLoadingElementsInternal: function(windowIndex) {
  if(this.lpDelay > 1 && !this.enableCallbackAnimation) {
   var _this = this;
   this.lpTimers[windowIndex] = window.setTimeout(function() { _this.ShowWindowLoadingPanelOnTimer(windowIndex); }, this.lpDelay);
  }
  else
   this.ShowWindowLoadingPanel(windowIndex);
 },
 StartWindowBeginCallbackAnimation: function(windowIndex) {
  this.callbackAnimationProcessings[windowIndex] = true;
  this.isCallbackFinishedStates[windowIndex] = false;
  ASPx.AnimationHelper.fadeOut(this.GetWindowContentElement(windowIndex), function() { this.FinishWindowBeginCallbackAnimation(windowIndex); }.aspxBind(this));
 },
 FinishWindowBeginCallbackAnimation: function(windowIndex) {
  this.callbackAnimationProcessings[windowIndex] = false;
  if(!this.isCallbackFinishedStates[windowIndex])
   this.ShowWindowLoadingElementsInternal(windowIndex);
  else
   this.DoCallback(this.savedCallbackResults[windowIndex]);
 },
 CheckBeginCallbackAnimationInProgress: function(callbackResult) {
  var windowIndex = this.EvalCallbackResult(callbackResult).result.index;
  if(this.enableCallbackAnimation && this.callbackAnimationProcessings[windowIndex]) {
   this.savedCallbackResults[windowIndex] = callbackResult;
   this.isCallbackFinishedStates[windowIndex] = true;
   return true;
  }
  return false;
 },
 StartWindowEndCallbackAnimation: function(windowIndex) {
  this.callbackAnimationProcessings[windowIndex] = true;
  ASPx.AnimationHelper.fadeIn(this.GetWindowContentElement(windowIndex), function() { this.FinishWindowEndCallbackAnimation(windowIndex); }.aspxBind(this));
 },
 FinishWindowEndCallbackAnimation: function(windowIndex) {
  this.DoEndCallback();
  this.callbackAnimationProcessings[windowIndex] = false;
 },
 CheckEndCallbackAnimationNeeded: function() {
  var windowIndex = this.savedCallbackWindowIndex;
  this.savedCallbackWindowIndex = null;
  if(windowIndex !== null && !this.callbackAnimationProcessings[windowIndex]) {
   this.StartWindowEndCallbackAnimation(windowIndex);
   return true;
  }
  return false;
 },
 CreateLoadingDiv: function(parentElement, offsetElement, windowIndex) {
  if(typeof (windowIndex) != "undefined") { 
   var loadingDiv = ASPxClientControl.prototype.CreateLoadingDiv.call(this, parentElement, offsetElement);
   loadingDiv.id += windowIndex;
   return loadingDiv;
  }
 },
 CreateLoadingPanelWithAbsolutePosition: function(parentElement, offsetElement, windowIndex) {
  if(typeof (windowIndex) != "undefined") { 
   var loadingPanel = ASPxClientControl.prototype.CreateLoadingPanelWithAbsolutePosition.call(this, parentElement, offsetElement);
   loadingPanel.id += windowIndex;
   return loadingPanel;
  }
 },
 ShowWindowLoadingPanelOnTimer: function(windowIndex) {
  this.ClearWindowLoadingPanelTimer(windowIndex);
  this.ShowWindowLoadingPanel(windowIndex);
 },
 ClearWindowLoadingPanelTimer: function(windowIndex) {
  this.lpTimers[windowIndex] = ASPx.Timer.ClearTimer(this.lpTimers[windowIndex]);
 },
 ShowWindowLoadingPanel: function(windowIndex) {
  if(!this.IsExistLoadingPanel())
   return;
  if(!this.loadingPanels[windowIndex] && this.InternalIsWindowVisible(windowIndex)) {
   var contentElement = this.GetWindowContentWrapperElement(windowIndex);
   this.loadingDivs[windowIndex] = this.CreateLoadingDiv(this.GetWindowElement(windowIndex).parentNode, contentElement, windowIndex);
   this.loadingPanels[windowIndex] = this.CreateLoadingPanelWithAbsolutePosition(this.GetWindowElement(windowIndex).parentNode, contentElement, windowIndex);
  }
 },
 HideAllLoadingPanels: function() {
  if(this.HasDefaultWindow())
   this.HideWindowLoadingPanel(-1);
  for(var i = 0; i < this.GetWindowCount() ; i++)
   this.HideWindowLoadingPanel(i);
 },
 HideWindowLoadingPanel: function(windowIndex) {
  this.ClearWindowLoadingPanelTimer(windowIndex);
  if(this.loadingDivs[windowIndex]) {
   ASPx.RemoveElement(this.loadingDivs[windowIndex]);
   this.loadingDivs[windowIndex] = null;
  }
  if(this.loadingPanels[windowIndex]) {
   ASPx.RemoveElement(this.loadingPanels[windowIndex]);
   this.loadingPanels[windowIndex] = null;
  }
 },
 ShouldHideExistingLoadingElements: function() {
  return false;
 },
 IsLoadingContainerVisible: function() {
  return true;
 },
 IsExistLoadingPanel: function() {
  return !!this.GetLoadingDiv();
 },
 InitializeDOM: function() {
  var windowElement = this.GetWindowElement(this.GetWindowCountCore() - 1);
  if(windowElement)
   windowElement["dxinit"] = true;
 },
 IsDOMInitialized: function() {
  var windowElement = this.GetWindowElement(this.GetWindowCountCore() - 1);
  return windowElement && windowElement["dxinit"];
 },
 IsDOMDisposed: function() { 
  var windowElement = this.GetWindowElement(this.GetWindowCountCore() - 1);
  return !ASPx.IsExistsElement(windowElement);
 },
 PerformCallback: function(parameter) {
  this.PerformWindowCallback(null, parameter);
 },
 PerformWindowCallback: function(window, parameter) {
  parameter = ASPx.IsExists(parameter) ? parameter.toString() : ""
  var index = (window != null) ? window.index : -1;
  if(!this.InWindowCallback(index)) {
   var windowCallbackArguments = index + ";" + parameter;
   this.CreateWindowCallback(index, windowCallbackArguments);
  }
 },
 RegisterInControlTree: function(tree) {
  var mainNode = tree.createNode(null, this);
  if(this.HasDefaultWindow())
   this.RegisterRelatedNodeForWindowElement(tree, -1, mainNode);
  for(var i = 0; i < this.GetWindowCount() ; i++)
   this.RegisterRelatedNodeForWindowElement(tree, i, mainNode);
 },
 RegisterRelatedNodeForWindowElement: function(tree, windowElementIndex, mainNode) {
  var windowElement = this.GetWindowElement(windowElementIndex);
  if(windowElement) {
   var childNode = tree.createNode(windowElement.id, null);
   tree.addRelatedNode(mainNode, childNode);
  }
 },
 GetTwoVerticalPaddingSize: function(element) {
  var heightWithBorders = element.clientHeight;
  var paddingTopBackup = element.style.paddingTop;
  var paddingBottomBackup = element.style.paddingBottom;
  element.style.paddingTop = "0px";
  element.style.paddingBottom = "0px";
  var heightWithoutBorders = element.clientHeight;
  element.style.paddingTop = paddingTopBackup;
  element.style.paddingBottom = paddingBottomBackup;
  return (heightWithBorders - heightWithoutBorders);
 },
 InternalIsWindowVisible: function(index) {
  var element = this.GetWindowElement(index);
  if(!element)
   return false;
  if(this.HasCloseAnimation() && !element.closeAnimationCompleted)
   return false;
  var currentStyle = ASPx.GetCurrentStyle(element);
  return ((currentStyle && currentStyle.visibility != "hidden") && ASPx.GetElementDisplay(element) ? true : false);
 },
 InternalIsWindowDisplayed: function(index) {
  var element = this.GetWindowElement(index);
  return (element != null) ? ASPx.GetElementDisplay(element) : false;
 },
 OnActivate: function(index, evt) {
  var element = this.GetWindowElement(index);
  if(element != null)
   aspxGetPopupControlCollection().ActivateWindowElement(element, evt);
 },
 OnAnimationStop: function(index) {
  this.OnWindowShown(index);
  if(ASPx.Browser.Firefox)
   this.GetWindowElement(index).style.display = "table";
 },
 OnDragStart: function(evt, index) {
  this.SetIsDragged(index, true);
  this.ShowDragCursor(index);
  if(this.GetWindowContentIFrameElement(index))
   this.HideIframeElementBeforeDragging(index);
  this.InitDragInfo(index, evt);
 },
 InitDragInfo: function(index, evt) {
  var element = this.GetWindowElement(index);
  var gragXOffset = ASPx.GetAbsoluteX(element) - ASPx.Evt.GetEventX(evt);
  var gragYOffset = ASPx.GetAbsoluteY(element) - ASPx.Evt.GetEventY(evt);
  var xClientCorrection = ASPx.GetPositionElementOffset(element, true);
  var yClientCorrection = ASPx.GetPositionElementOffset(element, false);
  gragXOffset -= xClientCorrection;
  gragYOffset -= yClientCorrection;
  aspxGetPopupControlCollection().InitDragObject(this, index, gragXOffset, gragYOffset, xClientCorrection, yClientCorrection);
 },
 OnDrag: function(index, x, y, xClientCorrection, yClientCorrection) {
  var element = this.GetWindowElement(index);
  if(element != null) {
   ASPx.SetStyles(element, { left: x, top: y });
   xClientCorrection = typeof(xClientCorrection) != "undefined" ? xClientCorrection : 0;
   yClientCorrection = typeof(yClientCorrection) != "undefined" ? yClientCorrection : 0;
   this.SetWindowLeft(index, x + xClientCorrection);
   this.SetWindowTop(index, y + yClientCorrection);
   var iFrame = element.overflowElement;
   if(iFrame)
    ASPx.SetStyles(iFrame, { left: x, top: y });
   if(ASPx.Browser.Opera)
    ASPx.Selection.Clear();
  }
 },
 OnDragStop: function(index) {
  var element = this.GetWindowElement(index);
  this.HideDragCursor(index);
  this.UpdateWindowsStateCookie();
  if(this.GetWindowContentIFrameElement(index))
   this.ShowIframeElementAfterDragging(index);
 },
 OnPopupElementMouseOver: function(evt, popupElement) {
  if(popupElement != null) {
   var index = popupElement.DXPopupWindowIndex;
   var isVisible = this.InternalIsWindowVisible(index);
   var popupElementIndex = popupElement.DXPopupElementIndex;
   if(this.GetLastOverPopupElementIndex(index) != popupElementIndex) {
    if(aspxGetPopupControlCollection().IsAppearTimerActive())
     aspxGetPopupControlCollection().ClearAppearTimer();
    if(aspxGetPopupControlCollection().IsDisappearTimerActive())
     aspxGetPopupControlCollection().ClearDisappearTimer();
    if(isVisible) {
     this.DoHideWindow(index, false, ASPxClientPopupControlCloseReason.MouseOut);
     isVisible = false;
    }
   }
   if(!isVisible) {
    aspxGetPopupControlCollection().SetAppearTimer(this.name, index, popupElement.DXPopupElementIndex, this.appearAfter, evt);
    aspxGetPopupControlCollection().InitOverObject(this, index, evt);
   }
   this.SetLastOverPopupElementIndex(index, popupElementIndex);
  }
 },
 OnPopupElementMouseOut: function(evt, popupElement) {
 },
 HideIframeElementBeforeDragging: function(index) {
  var iframeElement = this.GetWindowContentIFrameElement(index);
  if(ASPx.Browser.IE) {
   this.CreateFakeDragDiv(iframeElement);
   ASPx.SetElementDisplay(iframeElement, false);
  } else
   ASPx.SetElementVisibility(iframeElement, false);
 },
 ShowIframeElementAfterDragging: function(index) {
  var iframeElement = this.GetWindowContentIFrameElement(index);
  if(this.fakeDragDiv != null) {
   this.RemoveFakeDragDiv(iframeElement);
   ASPx.SetElementDisplay(iframeElement, true);
  } else
   ASPx.SetElementVisibility(iframeElement, true);
 },
 CreateFakeDivForIframe: function(iframe) {
  fakeDiv = document.createElement("div");
  ASPx.SetStyles(fakeDiv, { width: iframe.offsetWidth, height: iframe.offsetHeight });
  return fakeDiv;
 },
 CreateFakeDragDiv: function(iframe) {
  this.fakeDragDiv = this.CreateFakeDivForIframe(iframe);
  iframe.parentElement.appendChild(this.fakeDragDiv);
 },
 CreateFakeResizeDiv: function(iframe, index) {
  if(!this.fakeResizeDiv)
   this.fakeResizeDiv = [];
  if(!this.fakeResizeDiv[index])
   this.fakeResizeDiv[index] = this.CreateFakeDivForIframe(iframe);
  this.fakeResizeDiv[index].style.position = "absolute";
  iframe.parentElement.appendChild(this.fakeResizeDiv[index]);
  ASPx.SetAbsoluteX(this.fakeResizeDiv[index], ASPx.GetAbsoluteX(iframe));
  ASPx.SetAbsoluteY(this.fakeResizeDiv[index], ASPx.GetAbsoluteY(iframe));
 },
 RemoveFakeResizeDiv: function(iframe, index) {
  iframe.parentElement.removeChild(this.fakeResizeDiv[index]);
  this.fakeResizeDiv[index] = null;
 },
 RemoveFakeDragDiv: function(iframe) {
  iframe.parentElement.removeChild(this.fakeDragDiv);
  this.fakeDragDiv = null;
 },
 CreateResizePanel: function(index) {
  var element = this.GetWindowElement(index);
  var mainCell = this.GetWindowMainCell(element);
  var resizePanel = document.createElement("DIV");
  element.parentNode.appendChild(resizePanel);
  resizePanel.style.overflow = "hidden";
  resizePanel.style.position = "absolute";
  resizePanel.style.zIndex = popupControlZIndex + aspxGetPopupControlCollection().visiblePopupWindowIds.length * 2 + 2;
  if(!this.isLiveResizingMode)
   resizePanel.style.border = "black 1px dotted";
  return resizePanel;
 },
 OnResizeStart: function(evt, index) {
  if(!aspxGetPopupControlCollection().IsResizeInint()) {
   var cursor = this.CreateResizeCursorInfo(evt, index);
   if(cursor.course != "") {
    aspxGetPopupControlCollection().setIframesMouseMoveEnabled(false);
    this.SetIsResized(index, true);
    var resizePanel = this.CreateResizePanel(index);
    this.UpdateResizeCursor(resizePanel, cursor.verticalDirection, cursor.horizontalDirection);
    aspxGetPopupControlCollection().InitResizeObject(this, index, cursor, resizePanel);
    this.OnResize(evt, index, cursor, resizePanel);
   }
  }
  return aspxGetPopupControlCollection().IsResizeInint();
 },
 OnResize: function(evt, index, cursor, resizePanel) {
  this.OnResizePanelLite(evt, index, cursor, resizePanel);
  if(this.isLiveResizingMode)
   this.OnResizeWindow(index, cursor, resizePanel);
  ASPx.Selection.Clear();
  if(ASPx.Browser.WebKitTouchUI)
   evt.preventDefault();
  if(this.GetIsPinned(index))
   this.HoldPosition(index, true, resizePanel);
 },
 OnResizePanelLite: function(evt, index, cursor, resizePanel) {
  var x = ASPx.Evt.GetEventX(evt);
  var y = ASPx.Evt.GetEventY(evt);
  var element = this.GetWindowElement(index);
  if(ASPx.Browser.IE && ASPx.Browser.Version >= 10) {
   x = Math.round(x);
   y = Math.round(y);
  }
  var newLeft = ASPx.GetAbsoluteX(element);
  var newTop = ASPx.GetAbsoluteY(element);
  var newWidth = element.offsetWidth;
  var newHeight = element.offsetHeight;
  if(cursor.verticalDirection == "n") {
   if(!this.fixedBottom)
    this.fixedBottom = newTop + newHeight;
   newHeight = newHeight + (newTop - y) + cursor.verticalOffset;
   newTop = y - cursor.verticalOffset;
  }
  if(cursor.verticalDirection == "s") {
   newHeight = newHeight + (y - (newTop + newHeight)) + cursor.verticalOffset;
   this.fixedBottom = null;
  }
  if(cursor.horizontalDirection == "w") {
   if(!this.fixedRight)
    this.fixedRight = newLeft + newWidth;
   newWidth = newWidth + (newLeft - x) + cursor.horizontalOffset;
   newLeft = x - cursor.horizontalOffset;
  }
  if(cursor.horizontalDirection == "e") {
   newWidth = newWidth + (x - (newLeft + newWidth)) + cursor.horizontalOffset;
   this.fixedRight = null;
  }
  if(newWidth > 0 && newHeight > 0) {
   var minWidth = this.GetWindowMinWidth(index);
   var maxWidth = this.GetWindowMaxWidth(index);
   if(minWidth && newWidth < minWidth)
    newWidth = minWidth;
   if(maxWidth && newWidth > maxWidth)
    newWidth = maxWidth;
   var minHeight = this.GetWindowMinHeight(index);
   var maxHeight = this.GetWindowMaxHeight(index);
   if(minHeight && newHeight < minHeight)
    newHeight = minHeight;
   if(maxHeight && newHeight > maxHeight)
    newHeight = maxHeight;
   newLeft = ASPx.PrepareClientPosForElement(newLeft, element, true);
   newTop = ASPx.PrepareClientPosForElement(newTop, element, false);
   if(ASPx.Browser.IE && ASPx.Browser.Version >= 10) {
    newLeft = Math.round(newLeft);
    newTop = Math.round(newTop);
    newHeight = Math.round(newHeight);
    newWidth = Math.round(newWidth);
   }
   var widthWithoutBorders = newWidth - ASPx.GetLeftRightBordersAndPaddingsSummaryValue(resizePanel);
   var heightWithoutBorders = newHeight - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(resizePanel);
   ASPx.SetStyles(resizePanel, {
    left: newLeft, top: newTop,
    width: widthWithoutBorders, height: heightWithoutBorders
   });
   this.SetWindowLeft(index, ASPx.GetAbsoluteX(element));
   this.SetWindowTop(index, ASPx.GetAbsoluteY(element));
  }
 },
 OnResizeWindow: function(index, cursor, resizePanel) {
  var windowElement = this.GetWindowElement(index);
  var left = ASPx.GetAbsoluteX(resizePanel);
  var top = ASPx.GetAbsoluteY(resizePanel);
  this.SetClientWindowSizeLite(index, resizePanel.offsetWidth, resizePanel.offsetHeight);
  var bottom = top + windowElement.offsetHeight;
  var right = left + windowElement.offsetWidth;
  if(this.fixedBottom && (bottom > this.fixedBottom || bottom < this.fixedBottom))
   top = this.fixedBottom - windowElement.offsetHeight;
  if(this.fixedRight && (right > this.fixedRight || right < this.fixedRight))
   left = this.fixedRight - windowElement.offsetWidth;
  this.fixedBottom = null;
  this.fixedRight = null;
  var styleLeft = ASPx.PrepareClientPosForElement(left, windowElement, true);
  var styleTop = ASPx.PrepareClientPosForElement(top, windowElement, false);
  if(ASPx.Browser.IE && ASPx.Browser.Version >= 10) {
   styleLeft = Math.round(styleLeft);
   styleTop = Math.round(styleTop);
  }
  ASPx.SetStyles(windowElement, {
   left: styleLeft,
   top: styleTop
  });
  if(this.InternalIsWindowVisible(index)) 
   this.DoShowWindowIFrame(index, left, top, ASPx.InvalidDimension, ASPx.InvalidDimension);
  this.CorrectElementVerticalAlignment(ASPx.AdjustVerticalMarginsInContainer, this.GetWindowHeaderElement(index), true);
 },
 OnResizeStop: function(evt, index, cursor, resizePanel) {
  if(this.allowResize) {
   aspxGetPopupControlCollection().setIframesMouseMoveEnabled(true);
   if(!this.isLiveResizingMode) {
    var windowElement = this.GetWindowElement(index);
    ASPx.GetControlCollection().CollapseControls(windowElement);
    this.OnResizeWindow(index, cursor, resizePanel);
   }
   this.CreateResizeCursorInfo(evt, index);
   this.UpdateWindowsStateCookie();
   this.RaiseResize(index);
   if(!this.isLiveResizingMode)
    ASPx.GetControlCollection().AdjustControls(windowElement, true);
   this.SetWindowCachedSize(index, this.GetClientWindowWidth(index), this.GetClientWindowHeight(index));
  }
 },
 OnMouseDownModalElement: function(evt, index) {
  aspxGetPopupControlCollection().DoHideAllWindows(ASPx.Evt.GetEventSource(evt), "", false, ASPxClientPopupControlCloseReason.OuterMouseClick);
  this.SetIsPopuped(index, true)
 },
 IsRaiseAfterResizingLocked: function() {
  return this.CollapseExecuting() || this.MaximizationExecuting();
 },
 SetClientWindowSizeLite: function(index, width, height, isWindowCollapsed) {
  this.RaiseBeforeResizing(index);
  this.SetClientWindowSizeCoreLite(index, width, height, isWindowCollapsed);
  if(!this.IsRaiseAfterResizingLocked())
   this.RaiseAfterResizing(index);
 },
 HasAnyScrollBars: function(index) {
  var contentElement = this.GetWindowContentElement(index);
  var hasBothScrollBars = contentElement.style.overflow == "scroll" || contentElement.style.overflow == "auto";
  return hasBothScrollBars || contentElement.style.overflowX == "scroll" ||
    contentElement.style.overflowY == "scroll" || contentElement.style.overflowX == "auto" ||
    contentElement.style.overflowY == "auto";
 },
 SetClientWindowSizeCoreLite: function(index, width, height, isWindowCollapsed) {
  var contentUrl = this.GetWindowContentIFrameUrl(index);
  var needToHideContent = !contentUrl;
  var element = this.GetWindowElement(index);
  var contentWrapper = this.GetWindowContentWrapperElement(index);
  var contentElement = this.GetWindowContentElement(index);
  if(ASPx.Browser.IE) {
   var scrollTop = contentElement.scrollTop;
   var scrollLeft = contentElement.scrollLeft;
  }
  var contentIframeElement = this.GetWindowContentIFrameElement(index);
  var iframeHeightCorrectionOnFirstShow = height > 0;
  if(contentIframeElement && (this.GetWindowIsShown(index) || iframeHeightCorrectionOnFirstShow))
   contentIframeElement.style.height = "0px";
  contentWrapper.style.height = "";
  contentWrapper.style.width = "";
  contentElement.style.height = "";
  contentElement.style.width = "";
  if(needToHideContent) {
   if(ASPx.Browser.IE) {
    var contentElementChildren = contentElement.getElementsByTagName("*"),
     contentElementChildrenScroll = [];
    for(var i = 0; i < contentElementChildren.length; i++) {
     var child = contentElementChildren[i];
     if(!!child.scrollLeft || !!child.scrollTop)
      contentElementChildrenScroll.push([i, child.scrollLeft, child.scrollTop]);
    }
   }
   contentElement.style.display = "none";
  }
  var hasAnyScrollBars = this.HasAnyScrollBars(index);
  var elementsDisplayValue = this.GetWindowElementDisplayValue(hasAnyScrollBars, height);
  element.style.display = elementsDisplayValue;
  if(!this.GetIsCollapsed(index))
   contentWrapper.style.display = elementsDisplayValue;
  if(typeof (width) != "undefined") {
   var actualWidth = width - ASPx.GetLeftRightBordersAndPaddingsSummaryValue(element);
   if(actualWidth <= 0)
    actualWidth = ASPx.Browser.WebKitFamily ? 1 : 0; 
   element.style.width = actualWidth + "px";
   if(element.offsetWidth != width) {
    actualWidth += (width - element.offsetWidth);
    if(actualWidth <= 0)
     actualWidth = ASPx.Browser.WebKitFamily ? 1 : 0;
    element.style.width = actualWidth + "px";
   }
   if(ASPx.Browser.WebKitFamily && hasAnyScrollBars) {
    var mainDiv = this.GetWindowMainCell(element);
    var dxpcMainDiv = ASPx.GetNodeByClassName(mainDiv, "dxpc-mainDiv");
    var dxpcMainDivBordersAndPaddings = dxpcMainDiv ? ASPx.GetLeftRightBordersAndPaddingsSummaryValue(dxpcMainDiv) : 0;
    contentWrapper.style.width = width - ASPx.GetLeftRightBordersAndPaddingsSummaryValue(mainDiv) - dxpcMainDivBordersAndPaddings + "px";
   }
  }
  if(typeof (height) != "undefined") {
   var actualHeight = height - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(element);
   if(actualHeight < 0)
    actualHeight = 0;
   element.style.height = actualHeight + "px";
   if(element.offsetHeight != height) {
    actualHeight += (height - element.offsetHeight);
    if(actualHeight < 0) actualHeight = 0;
    element.style.height = actualHeight + "px";
   }
  }
  this.CorrectWindowSizeGripPositionLite(index);
  this.CorrectWindowHeaderText(index);
  this.SetContentWrapperHeightLite(index);
  var correctContentElementSize = hasAnyScrollBars || contentElement.style.overflow == "hidden" || contentElement.style.overflowX == "hidden" || contentElement.style.overflowY == "hidden";
  if((correctContentElementSize || contentUrl) && height) {
   var contentHeight = ASPx.GetClearClientHeight(contentWrapper) -
    (ASPx.Browser.IE && ASPx.Browser.MajorVersion < 9 ? 0 : ASPx.GetTopBottomBordersAndPaddingsSummaryValue(contentElement));
   if(contentHeight < 0)
    contentHeight = 0;
   contentElement.style.height = contentHeight + "px";
  }
  if(correctContentElementSize && width) {
   if(ASPx.Browser.IE && ASPx.Browser.MajorVersion < 9)
    contentElement.style.width = ASPx.GetClearClientWidth(contentWrapper);
   else
    ASPx.SetOffsetWidth(contentElement, ASPx.GetClearClientWidth(contentWrapper));
  }
  contentElement.style.display = correctContentElementSize || contentUrl ? "block" : "table-cell";
  if(ASPx.IsExists(contentElementChildrenScroll) && contentElementChildrenScroll.length > 0) {
   for(var i = 0; i < contentElementChildrenScroll.length; i++) {
    var childScroll = contentElementChildrenScroll[i],
     childIndex = childScroll[0],
     childScrollLeft = childScroll[1],
     childScrollTop = childScroll[2];
    if(!!childScrollLeft)
     contentElementChildren[childIndex].scrollLeft = childScrollLeft;
    if(!!childScrollTop)
     contentElementChildren[childIndex].scrollTop = childScrollTop;
   }
  }
  if(ASPx.Browser.IE) {
   contentElement.scrollTop = scrollTop;
   contentElement.scrollLeft = scrollLeft;
  }
  if(contentIframeElement)
   contentIframeElement.style.height = "100%";
  this.SetWindowWidth(index, width);
  this.SetWindowHeight(index, height);
  if(isWindowCollapsed)
   this.ResetWindowHeight(index);
 },
 SetContentWrapperHeightLite: function(index) {
  var windowElem = this.GetWindowElement(index);
  if(!windowElem.style.height || ASPx.IsPercentageSize(windowElem.style.height))
   return;
  var borderOwner;
  if(ASPx.ElementHasCssClass(windowElem, PopupControlCssClasses.MainDivLiteCssClass))
   borderOwner = windowElem;
  else
   borderOwner = ASPx.GetNodeByClassName(windowElem, PopupControlCssClasses.MainDivLiteCssClass);
  var height = windowElem.offsetHeight - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(borderOwner);
  var extenders = [
   this.GetWindowHeaderElement(index),
   this.GetWindowFooterElement(index)
  ];
  for(var i = 0; i < extenders.length; i++) {
   if(extenders[i])
    height -= extenders[i].offsetHeight;
  }
  var contentWrapper = this.GetWindowContentWrapperElement(index);
  if(height > 0)
   contentWrapper.style.height = height + "px";
 },
 GetWindowContentWrapperElement: function(index) {
  var windowElem = this.GetWindowElement(index);
  var mainDiv = this.GetWindowMainCell(windowElem);
  var contentWrapperParent = mainDiv;
  return ASPx.GetChildByClassName(contentWrapperParent, PopupControlCssClasses.ContentWrapperCssClassName);
 },
 SetWindowScrollDivSize: function(scrollDiv, index, dimension) {
  var windowClientTable = this.GetWindowClientTable(index);
  var headerElement = this.GetWindowHeaderElement(index);
  var height = windowClientTable.offsetHeight;
  if(headerElement)
   height -= headerElement.offsetHeight;
  height -= this.GetWindowFooterHeightLite(index);
  if(dimension == 'height' || dimension == 'both')
   ASPx.SetOffsetHeight(scrollDiv, height);
  if(dimension == 'width' || dimension == 'both') {
   var width = windowClientTable.offsetWidth;
   var contentElement = this.GetWindowContentElement(index);
   width -= ASPx.GetLeftRightBordersAndPaddingsSummaryValue(scrollDiv) + ASPx.GetHorizontalBordersWidth(contentElement);
   if(width > -1)
    scrollDiv.style.width = width + "px";
  }
  scrollDiv.style.marginRight = "0px";
 },
 CorrectWindowSizeGripPositionLite: function(index) {
  var sizeGrip = this.GetWindowSizeGripElement(index);
  if(!sizeGrip || sizeGrip.corrected) return;
  if(this.rtl)
   sizeGrip.style.marginRight = "-" + sizeGrip.offsetWidth + "px";
  else
   sizeGrip.style.marginLeft = "-" + sizeGrip.offsetWidth + "px";
  sizeGrip.style.marginTop = "-" + sizeGrip.offsetHeight + "px";
  sizeGrip.corrected = true;
 },
 CorrectWindowHeaderText: function(index) {
  var headerElement = this.GetWindowHeaderElement(index);
  if(!headerElement || headerElement.corrected) return;
  var leftChildrenWidth = 0, rightChildrenWidth = 0, headerContentElement;
  for(var i = 0; i < headerElement.childNodes.length; i++) {
   var child = headerElement.childNodes[i];
   if(!child.offsetWidth) continue;
   if(ASPx.GetElementFloat(child) === "right")
    rightChildrenWidth += child.offsetWidth + ASPx.GetLeftRightMargins(child);
   else if(ASPx.GetElementFloat(child) === "left")
    leftChildrenWidth += child.offsetWidth + ASPx.GetLeftRightMargins(child);
   else if(!headerContentElement)
    headerContentElement = child;
  }
  if(headerContentElement && (leftChildrenWidth > 0 || rightChildrenWidth > 0)) {
   var headerContentElementStyle = ASPx.GetCurrentStyle(headerContentElement);
   var originalPaddingLeft = parseInt(headerContentElementStyle.paddingLeft);
   var originalPaddingRight = parseInt(headerContentElementStyle.paddingRight);
   ASPx.SetStyles(headerContentElement, {
    paddingLeft: leftChildrenWidth + originalPaddingLeft,
    paddingRight: rightChildrenWidth + originalPaddingRight
   }, true);
   this.CorrectHeaderContentElementHeight(index);
  }
  headerElement.corrected = true;
 },
 CorrectHeaderContentElementHeight: function(index) {
  var headerElement = this.GetWindowHeaderElement(index),
   headerContentElement = ASPx.GetChildByClassName(headerElement, PopupControlCssClasses.HeaderContentCssClassName);
  if(!headerElement || !headerContentElement) return;
  if(headerContentElement.style.height)
   headerContentElement.style.height = "";
  var contentElementHeight = ASPx.GetClearClientHeight(headerElement) - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(headerContentElement),
   lineHeightForTextVerticalAlign = contentElementHeight,
   windowHeaderTextCell = this.GetWindowHeaderTextCell(index);
  if(windowHeaderTextCell)
     lineHeightForTextVerticalAlign -= ASPx.GetTopBottomBordersAndPaddingsSummaryValue(windowHeaderTextCell);
  ASPx.SetStyles(headerContentElement, { lineHeight: lineHeightForTextVerticalAlign, height: contentElementHeight }, false);
 },
 SetWindowCachedSize: function(index, width, height) {
  if(0 <= index && index < this.heightArray.length)
   this.cachedSizeArray[index] = new ASPx.PopupSize(width, height);
  else
   this.cachedSize = new ASPx.PopupSize(width, height);
 },
 GetWindowCachedSize: function(index) {
  if(0 <= index && index < this.heightArray.length)
   return this.cachedSizeArray[index];
  else
   return this.cachedSize;
 },
 ResetWindowCachedSize: function(index) {
  if(0 <= index && index < this.heightArray.length)
   this.cachedSizeArray[index] = null;
  else
   this.cachedSize = null;
 },
 SetWindowSizeByIndex: function(index, width, height) {
  var minWidth = this.GetWindowMinWidth(index);
  var minHeight = this.GetWindowMinHeight(index);
  var maxWidth = this.GetWindowMaxWidth(index);
  var maxHeight = this.GetWindowMaxHeight(index);
  if(minWidth)
   width = Math.max(width, minWidth);
  if(minHeight)
   height = Math.max(height, minHeight);
  if(maxWidth)
   width = Math.min(width, maxWidth);
  if(maxHeight)
   height = Math.min(height, maxHeight);
  var isWindowMaximized = this.GetIsMaximized(index);
  var isWindowCollapsed = this.GetIsCollapsed(index);
  var isWindowMaximizedAndCollapsed = (isWindowMaximized && isWindowCollapsed);
  if(this.InternalIsWindowDisplayed(index) && (!isWindowMaximizedAndCollapsed || this.ResizingForMaxWindowLocked())) {
   if(!this.CollapseExecuting() && !this.MaximizationExecuting() && !this.ResizingForMaxWindowLocked()) {
    this.SetWindowCachedSize(index, width, height);
    this.SetIsResized(index, true);
   }
   if(isWindowCollapsed && !this.MaximizationExecuting() && !this.ResizingForMaxWindowLocked()) {
    this.SetWindowCachedSize(index, width, height);
    this.UpdateRestoredWindowSize(index, width, height);
    height = 0;
   }
   if(isWindowMaximized && !this.CollapseExecuting() && !this.ResizingForMaxWindowLocked()) {
    this.SetWindowCachedSize(index, width, height);
    this.UpdateRestoredWindowSize(index, width, height);
   } else {
    this.SetWindowSizeByIndexCore(index, width, height, isWindowCollapsed);
   }
  } else
   this.SetWindowCachedSize(index, width, height);
 },
 SetWindowSizeByIndexCore: function(index, width, height, isWindowCollapsed) {
  this.SetClientWindowSizeLite(index, width, height, isWindowCollapsed);
  var iFrame = this.GetWindowIFrame(index);
  if(iFrame && !isWindowCollapsed) {
   var winElememnt = this.GetWindowElement(index);
   var realWidth = winElememnt.offsetWidth;
   var realHeight = winElememnt.offsetHeight;
   ASPx.SetStyles(iFrame, { width: realWidth, height: realHeight });
  }
  this.UpdateWindowsStateCookie();
 },
 CreateResizeCursorInfo: function(evt, index) {
  var element = this.GetWindowElement(index);
  var mainCell = this.GetWindowMainCell(element);
  var clientWindow = this.GetWindowClientTable(index);
  var headerElement = this.GetWindowHeaderElement(index);
  var left = ASPx.GetAbsoluteX(mainCell);
  var top = ASPx.GetAbsoluteY(mainCell);
  var x = ASPx.Evt.GetEventX(evt);
  var y = ASPx.Evt.GetEventY(evt);
  var mainCellWidth = mainCell.offsetWidth;
  var mainCellHeight = mainCell.offsetHeight;
  var leftOffset = Math.abs(x - left);
  var rightOffset = Math.abs(x - left - mainCellWidth);
  var topOffset = Math.abs(y - top);
  var bottomOffset = Math.abs(y - top - mainCellHeight);
  var cursorInfo = this.CreateResizeBorderCursorInfo(index, leftOffset, rightOffset, topOffset, bottomOffset);
  var grip = this.GetWindowSizeGripElement(index);
  if(grip) {
   var gripCursorInfo = this.CreateGripCursorInfo(index, mainCell, grip, leftOffset, rightOffset, bottomOffset);
   if(gripCursorInfo)
    cursorInfo = gripCursorInfo;
  }
  this.UpdateResizeCursor(clientWindow, cursorInfo.verticalDirection, cursorInfo.horizontalDirection);
  this.UpdateResizeCursor(mainCell, cursorInfo.verticalDirection, cursorInfo.horizontalDirection);
  if(headerElement)
   this.UpdateResizeCursor(headerElement, cursorInfo.verticalDirection, cursorInfo.horizontalDirection);
  return cursorInfo;
 },
 CreateGripCursorInfo: function(index, mainCell, grip, leftOffset, rightOffset, bottomOffset) {
  var gripWidth = this.rtl
   ? ASPx.GetAbsoluteX(grip) - ASPx.GetAbsoluteX(mainCell) + grip.offsetWidth
   : mainCell.offsetWidth - (ASPx.GetAbsoluteX(grip) - ASPx.GetAbsoluteX(mainCell));
  var gripHeight = mainCell.offsetHeight - (ASPx.GetAbsoluteY(grip) - ASPx.GetAbsoluteY(mainCell));
  if(gripHeight > bottomOffset) {
   if(this.rtl && gripWidth > leftOffset)
    return new PCResizeCursorInfo("w", "s", leftOffset, bottomOffset);
   if(gripWidth > rightOffset)
    return new PCResizeCursorInfo("e", "s", rightOffset, bottomOffset);
  }
  return null;
 },
 CreateResizeBorderCursorInfo: function(index, leftOffset, rightOffset, topOffset, bottomOffset) {
  var ResizeBorderSize = this.ResizeBorderSize;
  var verticalDirection = this.GetResizeVerticalCourse(ResizeBorderSize, topOffset, bottomOffset);
  ResizeBorderSize = verticalDirection != "" ? this.ResizeCornerBorderSize : this.ResizeBorderSize;
  var horizontalDirection = this.GetResizeHorizontalCourse(ResizeBorderSize, leftOffset, rightOffset);
  if(verticalDirection == "" && horizontalDirection != "")
   verticalDirection = this.GetResizeVerticalCourse(this.ResizeCornerBorderSize, topOffset, bottomOffset);
  var horizontalOffset = leftOffset < rightOffset ? leftOffset : rightOffset;
  var verticalOffset = topOffset < bottomOffset ? topOffset : bottomOffset;
  return new PCResizeCursorInfo(horizontalDirection, verticalDirection, horizontalOffset, verticalOffset);
 },
 GetResizeVerticalCourse: function(ResizeBorderSize, topOffset, bottomOffset) {
  if(ResizeBorderSize > topOffset) return "n";
  if(ResizeBorderSize > bottomOffset) return "s";
  return "";
 },
 GetResizeHorizontalCourse: function(ResizeBorderSize, leftOffset, rightOffset) {
  if(ResizeBorderSize > leftOffset) return "w";
  if(ResizeBorderSize > rightOffset) return "e";
  return "";
 },
 UpdateResizeCursor: function(element, verticalDirection, horizontalDirection) {
  var cursor = verticalDirection + horizontalDirection;
  if(cursor != "") {
   cursor += "-resize";
   this.ShowTemporaryCursor(element, cursor);
  }
  else
   this.HideTemporaryCursor(element);
 },
 ShowTemporaryCursor: function(element, cursor) {
  ASPx.Attr.ChangeStyleAttribute(element, "cursor", cursor);
 },
 HideTemporaryCursor: function(element) {
  ASPx.Attr.RestoreStyleAttribute(element, "cursor");
 },
 ResizeWindowIFrame: function(index) {
  if(!this.renderIFrameForPopupElements) return;
  if(!this.InternalIsWindowVisible(index)) return;
  var iFrame = this.GetWindowIFrame(index);
  if(iFrame) {
   var cell = this.GetWindowMainCell(this.GetWindowElement(index));
   ASPx.SetStyles(iFrame, { width: cell.offsetWidth, height: cell.offsetHeight });
  }
 },
 GetContentIFrameWindow: function() {
  var iframeElement = this.GetContentIFrame();
  return iframeElement.contentWindow;
 },
 ShowDragCursor: function(index) {
  var dragElement = this.GetDragElement(index);
  if(dragElement)
   this.ShowTemporaryCursor(dragElement, "move");
 },
 HideDragCursor: function(index) {
  var dragElement = this.GetDragElement(index);
  if(dragElement != null)
   this.HideTemporaryCursor(dragElement);
 },
 GetDragElement: function(index) {
  var headerElement = this.GetWindowHeaderElement(index);
  var element = this.GetWindowElement(index);
  if(element != null)
   return (headerElement != null ? headerElement : this.GetWindowMainCell(element));
  return null;
 },
 OnActivateMouseDown: function(evt, index) {
  this.OnActivate(index, evt);
 },
 OnCloseButtonClick: function(index) {
  this.RaiseCloseButtonClick(index);
  if(this.GetWindowCloseAction(index) != "None")
   this.DoHideWindow(index, false, ASPxClientPopupControlCloseReason.CloseButton);
 },
 OnRefreshButtonClick: function(index) {
  var contentIFrame = this.GetWindowContentIFrameElement(index);
  if(contentIFrame)
   this.RefreshWindowContentUrl(this.GetWindow(index));
  else
   this.PerformWindowCallback(this.GetWindow(index));
 },
 OnPinButtonClick: function(index) {
  var value = this.GetIsPinned(index);
  this.SetPinCore(index, !value);
 },
 SetPinCore: function(index, value) {
  if(this.GetIsPinned(index) != value) {
   this.SetIsPinned(index, value);
   this.HoldPosition(index, value);
   this.UpdateWindowsStateCookie();
   this.OnPinned(index, value);
  }
 },
 OnPinned: function(index, pinned) {
  this.RaisePinnedChanged(index, pinned);
 },
 HoldPosition: function(index, hold, element) {
  if(hold) {
   var element = element || this.GetWindowElement(index);
   if(!element) return;
   var x = ASPx.GetAbsoluteX(element);
   var y = ASPx.GetAbsoluteY(element);
   scrollX = ASPx.GetDocumentScrollLeft();
   scrollY = ASPx.GetDocumentScrollTop();
   this.SetPinPosX(index, x - scrollX);
   this.SetPinPosY(index, y - scrollY);
  }
  this.UpdateHeaderButtonSelected(index, "GetWindowPinButton", hold);
  this.CheckHeaderCursor(index);
 },
 GetBodyWidth: function() {
  return aspxGetPopupControlCollection().GetSavedBodyWidth();
 },
 GetBodyHeight: function() {
  return aspxGetPopupControlCollection().GetSavedBodyHeight();
 },
 GetIsOutFromViewPort: function(index) {
  var element = this.GetWindowElement(index);
  if(!element) return false;
  var pinXTarget = this.GetPinPosX(index);
  var pinYTarget = this.GetPinPosY(index);
  var popupWindowWidth = this.GetClientWindowWidth(index);
  var docClientWidth = ASPx.GetDocumentClientWidth();
  var rightOutOffset = (pinXTarget + popupWindowWidth) - docClientWidth;
  var popupWindowHeight = this.GetClientWindowHeight(index);
  var docClientHeight = ASPx.GetDocumentClientHeight();
  var bottomOutOffset = (pinYTarget + popupWindowHeight) - docClientHeight;
  return (rightOutOffset > 0 || bottomOutOffset > 0);
 },
 needToHidePinnedOutFromViewPort: function(index) {
  return this.GetIsPinned(index) && this.GetIsOutFromViewPort(index);
 },
 AdjustPinPositionWhileScroll: function(index) {
  var element = this.GetWindowElement(index);
  if(!element) return;
  var x = ASPx.GetAbsoluteX(element);
  var y = ASPx.GetAbsoluteY(element);
  var scrollX = ASPx.GetDocumentScrollLeft();
  var scrollY = ASPx.GetDocumentScrollTop();
  var pinX = x - scrollX;
  var pinY = y - scrollY;
  var pinXTarget = this.GetPinPosX(index);
  var pinYTarget = this.GetPinPosY(index);
  if((pinX != pinXTarget) || (pinY != pinYTarget)) {
   this.lockScroll++;
   var xNew = pinXTarget + scrollX;
   var yNew = pinYTarget + scrollY;
   var bodyWidth = this.GetBodyWidth();
   var bodyHeight = this.GetBodyHeight();
   var popupWindowWidth = this.GetClientWindowWidth(index);
   var docClientWidth = ASPx.GetDocumentClientWidth();
   var rightOutOffset = (pinXTarget + popupWindowWidth) - docClientWidth;
   var popupWindowHeight = this.GetClientWindowHeight(index);
   var docClientHeight = ASPx.GetDocumentClientHeight();
   var bottomOutOffset = (pinYTarget + popupWindowHeight) - docClientHeight;
   var cancelScrollX = false;
   if(xNew + (popupWindowWidth - rightOutOffset) > bodyWidth) {
    xNew -= (xNew + (popupWindowWidth - rightOutOffset) - bodyWidth);
    cancelScrollX = true;
   }
   var cancelScrollY = false;
   if(yNew + (popupWindowHeight - bottomOutOffset) > bodyHeight) {
    yNew -= (yNew + (popupWindowHeight - bottomOutOffset) - bodyHeight);
    cancelScrollY = true;
   }
   xNew = ASPx.PrepareClientPosForElement(xNew, element, true);
   yNew = ASPx.PrepareClientPosForElement(yNew, element, false);
   this.SetWindowPos(index, element, xNew, yNew);
   if(cancelScrollX) {
    var scrollLeftMax = bodyWidth - ASPx.GetDocumentClientWidth();
    if((rightOutOffset > 0) && (scrollX > scrollLeftMax)) {
     this.lockScroll++;
     ASPx.SetDocumentScrollLeft(scrollLeftMax);
     this.lockScroll--;
    }
   }
   if(cancelScrollY) {
    var scrollTopMax = bodyHeight - ASPx.GetDocumentClientHeight();
    if((bottomOutOffset > 0) && (scrollY > scrollTopMax)) {
     this.lockScroll++;
     ASPx.SetDocumentScrollTop(scrollTopMax);
     this.lockScroll--;
    }
   }
   this.lockScroll--;
  }
 },
 OnScroll: function(evt, index) {
  if(!this.GetIsPinned(index) || (this.lockScroll > 0)) return;
  this.AdjustPinPositionWhileScroll(index);
 },
 OnCollapseButtonClick: function(index) {
  this.SetCollapsedCore(index, !this.GetIsCollapsed(index));
 },
 SetCollapsedCore: function(index, minimization) {
  if(this.GetIsCollapsed(index) == minimization) return;
  this.DoCollapse(index, minimization);
  this.OnCollapsed(index, minimization);
 },
 DoCollapse: function(index, minimization) {
  if(this.GetIsCollapsed(index) == minimization) return;
  this.StartCollapse();
  if(minimization) {
   var cachedWidth = this.GetClientWindowWidth(index);
   var cachedHeight = this.GetClientWindowHeight(index);
   var shouldUpdateRestoredSize = this.ShoulUpdatedRestoredWindowSizeOnCollapse(index);
   var width = this.GetMainWindowWidth(index, !shouldUpdateRestoredSize);
   var height = this.GetMainWindowHeight(index, !shouldUpdateRestoredSize);
   this.SetWindowSizeByIndex(index, width, 0);
   this.SetWindowContentVisible(index, false);
   this.SetWindowFooterVisible(index, false);
   this.ResetWindowHeight(index);
   this.SetIsCollapsed(index, minimization);
   this.SetWindowCachedSize(index, cachedWidth, cachedHeight);
   if(shouldUpdateRestoredSize)
    this.UpdateRestoredWindowSize(index, width, height);
  }
  else {
   if(this.MaximizationExecuting()) {
    var element = this.GetWindowElement(index);
    if(element) {
     element.style.left = ASPx.GetDocumentScrollLeft();
     element.style.top = ASPx.GetDocumentScrollTop();
    }
   }
   this.SetWindowContentVisible(index, true);
   this.SetWindowFooterVisible(index, true);
   this.SetIsCollapsed(index, minimization);
   if(this.GetIsMaximized(index)) {
    var documentClientWidth = ASPx.PopupUtils.GetDocumentClientWidthForPopup();
    var documentClientHeight = ASPx.PopupUtils.GetDocumentClientHeightForPopup();
    this.SetWindowSizeByIndex(index, documentClientWidth, documentClientHeight);
   } else {
    var restoredWindowData = this.GetRestoredWindowData(index);
    this.SetWindowSizeByIndex(index, restoredWindowData.width, restoredWindowData.height);
   }
   ASPx.GetControlCollection().AdjustControls(this.GetWindowElement(index));
  }
  this.UpdateHeaderButtonSelected(index, "GetWindowCollapseButton", minimization);
  this.EndCollapse();
  this.UpdateWindowsStateCookie();
 },
 ResetWindowHeight: function(index) {
  var element = this.GetWindowElement(index);
  if(element)
   element.style.height = "";
 },
 ShoulUpdatedRestoredWindowSizeOnCollapse: function(index) {
  return !this.GetIsMaximized(index);
 },
 OnCollapsed: function(index, value) {
  if(value)
   this.RaiseCollapsed(index);
  else
   this.RaiseExpanded(index);
  this.RaiseAfterResizing(index);
 },
 OnMaximizeButtonClick: function(index) {
  this.SetMaximizedCore(index, !this.GetIsMaximized(index));
 },
 SetMaximizedCore: function(index, maximization) {
  if(this.GetIsMaximized(index) == maximization) return;
  this.DoMaximize(index, maximization);
  this.OnMaximizedChanged(index, maximization);
 },
 GetMaximizedPosition: function(element, isX) {
  if(ASPx.Browser.WebKitTouchUI)
   return ASPx.PrepareClientPosForElement(0, element, isX);
  return ASPx.PrepareClientPosForElement(isX ? ASPx.GetDocumentScrollLeft() : ASPx.GetDocumentScrollTop(), element, isX);
 },
 DoMaximize: function(index, maximization) {
  if(this.GetIsMaximized(index) == maximization) return;
  var element = this.GetWindowElement(index);
  if(!element) return;
  this.StartMaximization();
  if(maximization) {
   if(this.hideBodyScrollWhenMaximized)
    ASPx.PopupUtils.BodyScrollHelper.HideBodyScroll(element.id);
   if(this.GetIsCollapsed(index))
    this.DoCollapse(index, false);
   var cachedWidth = this.GetClientWindowWidth(index);
   var cachedHeight = this.GetClientWindowHeight(index);
   var restoredWindowData = this.GetInitRestoredWindowData(index);
   var documentClientWidth = ASPx.PopupUtils.GetDocumentClientWidthForPopup();
   var documentClientHeight = ASPx.PopupUtils.GetDocumentClientHeightForPopup();
   var currentStyle = ASPx.GetCurrentStyle(element);
   var windowClientTable = this.GetWindowClientTable(index);
   var windowClientTableParent = windowClientTable.parentNode;
   childStyle = ASPx.GetCurrentStyle(windowClientTableParent);
   var left = this.GetMaximizedPosition(element, true);
   var top = this.GetMaximizedPosition(element, false);
   this.SetWindowPos(index, element, left, top);
   this.SetWindowSizeByIndex(index, documentClientWidth, documentClientHeight);
   this.SetWindowCachedSize(index, cachedWidth, cachedHeight);
   this.SetRestoredWindowData(index, restoredWindowData);
   this.SetIsMaximized(index, maximization);
  }
  else {
   var restoredWindowData = this.GetRestoredWindowData(index);
   var width = restoredWindowData.width || this.GetMainWindowWidth(index);
   var height = restoredWindowData.height || this.GetMainWindowHeight(index);
   this.SetIsMaximized(index, maximization);
   var left = ASPx.PrepareClientPosForElement(restoredWindowData.left, element, true);
   var top = ASPx.PrepareClientPosForElement(restoredWindowData.top, element, false);
   this.SetWindowPos(index, element, left, top);
   this.SetWindowSizeByIndex(index, width, height);
   if(this.GetIsCollapsed(index)) {
    this.SetIsCollapsed(index, false);
    this.DoCollapse(index, true);
   }
   if(this.hideBodyScrollWhenMaximized)
    ASPx.PopupUtils.BodyScrollHelper.RestoreBodyScroll(element.id);
  }
  if(this.GetIsPinned(index))
   this.HoldPosition(index, true, element);
  this.UpdateHeaderButtonSelected(index, "GetWindowMaximizeButton", maximization);
  this.EndMaximization();
  this.UpdateWindowsStateCookie();
  this.CheckHeaderCursor(index);
 },
 OnMaximizedChanged: function(index, value) {
  if(value)
   this.RaiseMaximized(index);
  else
   this.RaiseRestoredAfterMaximized(index);
  this.RaiseAfterResizing(index);
 },
 GetInitRestoredWindowData: function(index) {
  var restoredWindowData = this.GetRestoredWindowData(index);
  restoredWindowData.left = this.GetCurrentLeft(index);
  restoredWindowData.top = this.GetCurrentTop(index);
  restoredWindowData.width = this.GetMainWindowWidth(index);
  restoredWindowData.height = this.GetMainWindowHeight(index);
  return restoredWindowData;
 },
 getDocumentDimensions: function(index) {
  if(ASPx.Browser.WebKitTouchUI)
   ASPx.Attr.ChangeStyleAttribute(this.GetWindowElement(index), "display", "none");
  var documentClientWidth = ASPx.PopupUtils.GetDocumentClientWidthForPopup(),
   documentClientHeight = ASPx.PopupUtils.GetDocumentClientHeightForPopup();
  if(ASPx.Browser.WebKitTouchUI)
   ASPx.Attr.RestoreStyleAttribute(this.GetWindowElement(index), "display");
  return { width: documentClientWidth, height: documentClientHeight};
 }, 
 UpdateMaximizedWindowSizeOnResize: function(index) {
  this.StartUpdateMaximizedWindowSizeOnResize();
  var dimensions = this.getDocumentDimensions(index);
  if(this.GetIsCollapsed(index)) dimensions.height = 0;
  this.SetWindowSizeByIndex(index, dimensions.width, dimensions.height);
  if(this.GetIsCollapsed(index)) {
   this.CorrectCollapsedSize(index);
  }
  window.setTimeout(function() { this.SetMaximizedWindowSizeAfterOnResize(index); }.aspxBind(this), 0);
  this.EndUpdateMaximizedWindowSizeOnResize();
 },
 SetMaximizedWindowSizeAfterOnResize: function(index) {
  this.StartUpdateMaximizedWindowSizeOnResize();
  var dimensions = this.getDocumentDimensions(index);
  windowWidthCurrent = this.GetMainWindowWidth(index, true);
  windowHeightCurrent = this.GetMainWindowHeight(index, true);
  if(this.GetIsCollapsed(index))
   dimensions.height = 0;
  if(dimensions.width != windowWidthCurrent || dimensions.height != windowHeightCurrent) {
   this.SetWindowSizeByIndex(index, dimensions.width, dimensions.height);
   if(this.GetIsCollapsed(index)) {
    this.CorrectCollapsedSize(index);
   }
  }
  this.EndUpdateMaximizedWindowSizeOnResize();
 },
 CorrectCollapsedSize: function(index) {
  var contentWrapper = this.GetWindowContentWrapperElement(index);
  if(contentWrapper && ASPx.IsElementVisible(contentWrapper))
   contentWrapper.style.display = 'none';
 },
 UpdateHeaderButtonSelected: function(index, methodGetWindowButton, flagSelected) {
  if(typeof (ASPx.GetStateController) != "undefined") {
   button = this[methodGetWindowButton](index);
   var method = flagSelected ? "SelectElementBySrcElement" : "DeselectElementBySrcElement";
   ASPx.GetStateController()[method](button);
  }
 },
 CheckHeaderCursor: function(index) {
  if(!this.allowDragging) return;
  var dragElement = this.GetDragElement(index);
  if(!dragElement) return;
  var styleCursor = dragElement.style.cursor;
  var isPinned = this.GetIsPinned(index);
  var isMaximized = this.GetIsMaximized(index);
  if((isPinned || isMaximized) && styleCursor != "default")
   dragElement.style.cursor = "default";
  else if(!isPinned && !isMaximized && styleCursor != "move")
   dragElement.style.cursor = "move";
 },
 LockAnimation: function() {
  this.animationLockCount++;
 },
 UnlockAnimation: function() {
  this.animationLockCount--;
 },
 IsAnimationLocked: function() {
  return this.animationLockCount > 0;
 },
 IsAnimationAllowed: function() {
  return this.enableAnimation && !this.IsAnimationLocked();
 },
 StartCollapse: function() {
  this.collapseExecutingLockCount++;
 },
 EndCollapse: function() {
  this.collapseExecutingLockCount--;
 },
 CollapseExecuting: function() {
  return this.collapseExecutingLockCount > 0;
 },
 StartMaximization: function() {
  this.maximizationExecutingLockCount++;
 },
 EndMaximization: function() {
  this.maximizationExecutingLockCount--;
 },
 MaximizationExecuting: function() {
  return this.maximizationExecutingLockCount > 0;
 },
 StartUpdateMaximizedWindowSizeOnResize: function() {
  this.browserResizingForMaxWindowLockCount++;
 },
 EndUpdateMaximizedWindowSizeOnResize: function() {
  this.browserResizingForMaxWindowLockCount--;
 },
 ResizingForMaxWindowLocked: function() {
  return this.browserResizingForMaxWindowLockCount > 0;
 },
 UpdateRestoredWindowSizeLock: function() {
  this.updateRestoredWindowSizeLockCount++;
 },
 UpdateRestoredWindowSizeUnlock: function() {
  this.updateRestoredWindowSizeLockCount--;
 },
 UpdateRestoredWindowSizeLocked: function() {
  return this.updateRestoredWindowSizeLockCount > 0;
 },
 UpdateRestoredWindowSize: function(index, width, height) {
  if(!this.UpdateRestoredWindowSizeLocked()) {
   restoredMinWindowData = this.GetRestoredWindowData(index);
   restoredMinWindowData.width = width;
   restoredMinWindowData.height = height;
   this.SetRestoredWindowData(index, restoredMinWindowData);
  }
 },
 OnMouseDown: function(evt, index, isDraggingAllowed, pointOnScrollBar) {
  if(ASPx.Evt.IsLeftButtonPressed(evt)) {
   if((this.allowResize || isDraggingAllowed) && !this.prohibitClearSelectionOnMouseDown) 
    ASPx.Selection.Clear();
   var isResizing = false;
   if(this.allowResize && !this.GetIsCollapsed(index) && !this.GetIsMaximized(index)) {
    var eventSourceControl = ASPx.Evt.GetEventSource(evt);
    var eventFromPopupContainer = ASPx.ElementHasCssClass(eventSourceControl, PopupControlCssClasses.ContentCssClassName) ||
     !ASPx.GetParentByClassName(eventSourceControl, PopupControlCssClasses.ContentCssClassName) ||
     this.eventFromOwnPopupContent(eventSourceControl);
    if(eventFromPopupContainer)
     isResizing = this.OnResizeStart(evt, index);
   }
   if(isResizing && ASPx.Browser.WebKitTouchUI)
    aspxGetPopupControlCollection().OverStop();
   var clickedOnScroll = pointOnScrollBar && this.GetEnableContentScrolling(index);
   if(isDraggingAllowed && !isResizing && !clickedOnScroll && !this.GetIsPinned(index) && !this.GetIsMaximized(index))
    this.OnDragStart(evt, index);
  }
 },
 eventFromOwnPopupContent: function(element) {
  while(element != null) {
   if(element.tagName == "BODY")
    return false;
   if(element.style.position == "absolute") {
    var windowIndex = this.GetWindowIndex(element);
    if(!isNaN(windowIndex)) {
     if(this.GetWindowElementId(windowIndex) == element.id)
      return true;
     return false;
    }
   }
   element = element.parentNode;
  }
  return false;
 },
 OnMouseMove: function(evt, index) {
  if(this.allowResize && !this.GetIsCollapsed(index) && !this.GetIsMaximized(index))
   this.CreateResizeCursorInfo(evt, index);
 },
 SetShadowVisibility: function(visible, index) {
  var shadowTable = this.GetWindowShadowTable(index);
  if(shadowTable && shadowTable.rows.length > 1) {
   var shadowCol = shadowTable.rows[0].cells[1];
   var shadowRow = shadowTable.rows[1];
   ASPx.SetElementVisibility(shadowCol, visible);
   ASPx.SetElementVisibility(shadowRow, visible);
  }
 },
 StartFadeAnimation: function(element, index) {
  if(ASPx.Browser.IE && ASPx.Browser.MajorVersion < 9) {
   ASPx.SetElementVisibility(element, true);
   ASPx.AnimationHelper.setOpacity(element, 0);
   this.SetShadowVisibility(false, index); 
  } else {
   ASPx.AnimationHelper.setOpacity(element, 0);
   ASPx.SetElementVisibility(element, true);
  }
  var callback = function() {
   if(ASPx.Browser.IE && ASPx.Browser.Version < 9 && element.style.filter) {
    if(element.style.filter)
     element.style.filter = "";
    this.SetShadowVisibility(true, index);
   }
   this.OnAnimationStop(index);
  }.aspxBind(this);
  ASPx.AnimationHelper.fadeIn(element, callback, this.fadeAnimationDuration);
 },
 StartSlideAnimation: function(animationDivElement, index, horizontalPopupPosition, verticalPopupPosition) {
  var element = this.GetWindowMainTable(animationDivElement);
  var clientX = horizontalPopupPosition.position;
  var clientY = verticalPopupPosition.position;
  var args = "(\"" + this.name + "\", " + index + ")";
  var onAnimStopCallString = "ASPx.PCAStop" + args;
  if(ASPx.Browser.Firefox)
   animationDivElement.style.display = "block";
  ASPx.PopupUtils.InitAnimationDiv(animationDivElement, clientX, clientY, onAnimStopCallString, true);
  var horizontalDirection = ASPx.PopupUtils.GetAnimationHorizontalDirection(horizontalPopupPosition, this.popupHorizontalAlign, this.popupVerticalAlign, this.rtl);
  var verticalDirection = ASPx.PopupUtils.GetAnimationVerticalDirection(verticalPopupPosition, this.popupHorizontalAlign, this.popupVerticalAlign);
  var xPos = horizontalDirection * animationDivElement.offsetWidth;
  var yPos = verticalDirection * animationDivElement.offsetHeight;
  neddToForceAnimation = xPos === 0 && yPos === 0;
  if(neddToForceAnimation) 
   yPos = 1;
  ASPx.SetStyles(element, { left: xPos, top: yPos });
  ASPx.SetElementVisibility(animationDivElement, true);
  this.DoShowWindowIFrame(index, clientX, clientY, 0, 0);
  ASPx.PopupUtils.StartSlideAnimation(animationDivElement, element, this.GetWindowIFrame(index), this.slideAnimationDuration);
 },
 GetWindowsState: function() {
  var state = "";
  if(this.HasDefaultWindow()) {
   state += this.GetWindowState(-1);
  }
  for(var i = 0; i < this.GetWindowCountCore() ; i++) {
   state += this.GetWindowState(i);
   if(i < this.GetWindowCountCore() - 1) state += ";";
  }
  return state;
 },
 GetWindowState: function(index) {
  var element = this.GetWindowElement(index);
  if(element != null) {
   var visibleFlag = (!this.InternalIsWindowVisible(index) || element.isHiding) ? "0" : "1";
   var isDraggedFlag = this.GetIsDragged(index) ? "1" : "0";
   var zIndex = this.GetCurrentZIndex(index);
   var isResized = this.GetIsResized(index);
   var isResizedFlag = isResized ? "1" : "0";
   var width = isResized ? this.GetWindowWidthInternal(index) : ASPx.InvalidDimension;
   var height = isResized ? this.GetWindowHeightInternal(index) : ASPx.InvalidDimension;
   var contentWasLoaded = element.loaded ? "1" : "0";
   var left, top;
   var isMaximized = this.GetIsMaximized(index);
   if(isMaximized && !this.MaximizationExecuting()) {
    var restoredWindowData = this.GetRestoredWindowData(index);
    left = restoredWindowData.left;
    top = restoredWindowData.top;
   } else {
    left = this.GetCurrentLeft(index);
    top = this.GetCurrentTop(index);
   }
   var isPinned = this.GetIsPinned(index);
   if(isPinned) {
    left -= ASPx.GetDocumentScrollLeft();
    top -= ASPx.GetDocumentScrollTop();
   }
   left = Math.ceil(left);
   top = Math.ceil(top);
   var pinFlag = isPinned ? "1" : "0";
   var minFlag = this.GetIsCollapsed(index) ? "1" : "0";
   var maxFlag = isMaximized || this.GetIsMaximizedInit(index) ? "1" : "0";
   return [visibleFlag, isDraggedFlag, zIndex, left, top, isResizedFlag, width, height, contentWasLoaded, pinFlag, minFlag, maxFlag].join(":");
  }
  return "";
 },
 UpdateWindowsStateCookie: function() {
  if(this.cookieName == "") return;
  ASPx.Cookie.DelCookie(this.cookieName);
  ASPx.Cookie.SetCookie(this.cookieName, this.GetWindowsState());
 },
 UpdateStateObject: function(){
  this.UpdateStateObjectWithObject({ windowsState: this.GetWindowsState() });
 },
 GetStateHiddenFieldOrigin: function() {
  return this.GetWindowElement(this.GetWindowCountCore() - 1);
 },
 OnIFrameLoad: function(index) {
  this.SetIframeLoading(index, false);
 },
 OnPWHBClickCore: function(evt, index, method) {
  if(ASPx.TouchUIHelper.handleFastTapIfRequired(evt,
   function() { this[method](index); }.aspxBind(this), true)) {
   return;
  }
  if((ASPx.Browser.IE && ASPx.Browser.Version < 9) || ASPx.Browser.Opera)
   ASPx.Evt.EmulateDocumentOnMouseDown(evt);
  this[method](index);
 },
 CreateWindows: function(windowsNames) {
  for(var i = 0; i < windowsNames.length; i++) {
   var window = new ASPxClientPopupWindow(this, i, windowsNames[i]);
   this.windows.push(window);
  }
 },
 RaiseCloseButtonClick: function(index) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.CloseButtonClick.IsEmpty()) {
   var args = new ASPxClientPopupWindowEventArgs(window);
   this.CloseButtonClick.FireEvent(this, args);
  }
 },
 RaiseClosing: function(index, closeReason) {
  var window = index < 0 ? null : this.GetWindow(index);
  var cancel = false;
  if(!this.Closing.IsEmpty()) {
   var args = new ASPxClientPopupWindowCancelEventArgs(window, closeReason);
   this.Closing.FireEvent(this, args);
   cancel = args.cancel;
  }
  return cancel;
 },
 RaiseCloseUp: function(index, closeReason) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.CloseUp.IsEmpty()) {
   var args = new ASPxClientPopupWindowCloseUpEventArgs(window, closeReason);
   this.CloseUp.FireEvent(this, args);
  }
 },
 RaisePopUp: function(index) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.PopUp.IsEmpty()) {
   var args = new ASPxClientPopupWindowEventArgs(window);
   this.PopUp.FireEvent(this, args);
  }
 },
 RaiseResize: function(index, resizeState) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.Resize.IsEmpty()) {
   if(!resizeState)
    resizeState = ASPxClientPopupControlResizeState.Resized;
   var args = new ASPxClientPopupWindowResizeEventArgs(window, resizeState);
   this.Resize.FireEvent(this, args);
  }
 },
 RaiseBeforeResizing: function(index) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.BeforeResizing.IsEmpty()) {
   var args = new ASPxClientPopupWindowEventArgs(window);
   this.BeforeResizing.FireEvent(this, args);
  }
 },
 RaiseAfterResizing: function(index) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.AfterResizing.IsEmpty()) {
   var args = new ASPxClientPopupWindowEventArgs(window);
   this.AfterResizing.FireEvent(this, args);
  }
 },
 RaiseShown: function(index) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.Shown.IsEmpty()) {
   var args = new ASPxClientPopupWindowEventArgs(window);
   this.Shown.FireEvent(this, args);
  }
 },
 RaisePinnedChanged: function(index, pinned) {
  var window = index < 0 ? null : this.GetWindow(index);
  if(!this.PinnedChanged.IsEmpty()) {
   var args = new ASPxClientPopupWindowPinnedChangedEventArgs(window, pinned);
   this.PinnedChanged.FireEvent(this, args);
  }
 },
 RaiseCollapsed: function(index) {
  this.RaiseResize(index, ASPxClientPopupControlResizeState.Collapsed);
 },
 RaiseExpanded: function(index) {
  this.RaiseResize(index, ASPxClientPopupControlResizeState.Expanded);
 },
 RaiseMaximized: function(index) {
  this.RaiseResize(index, ASPxClientPopupControlResizeState.Maximized);
 },
 RaiseRestoredAfterMaximized: function(index) {
  this.RaiseResize(index, ASPxClientPopupControlResizeState.RestoredAfterMaximized);
 },
 AdjustSize: function() {
  if(this.enableContentScrolling)
   return;
  this.SetSize(0, 0);
 },
 GetHeight: function() {
  return this.GetWindowHeight(null);
 },
 GetWidth: function() {
  return this.GetWindowWidth(null);
 },
 GetContentWidth: function() {
  return this.GetWindowContentWidth(null);
 },
 GetContentHeight: function() {
  return this.GetWindowContentHeight(null);
 },
 SetSize: function(width, height) {
  this.SetWindowSize(null, width, height);
 },
 SetWidth: function(width) {
  var height = this.GetHeight();
  this.SetSize(width, height);
 },
 SetHeight: function(height) {
  var width = this.GetWidth();
  this.SetSize(width, height);
 },
 GetWindowDimensionByIndex: function(index, isWidth, forceFromCache) {
  var cachedSize = this.GetWindowCachedSize(index);
  var dimensionValue = null;
  if(forceFromCache == undefined && !this.GetWindowElement(index))
   forceFromCache = true;
  if(cachedSize && forceFromCache)
   dimensionValue = isWidth ? cachedSize.width : cachedSize.height;
  if(dimensionValue)
   return dimensionValue;
  else {
   var element = this.GetWindowElement(index);
   var sizeFromDOM = 0;
   if(this.GetIsCollapsed(index)) {
    var headerCell = this.GetWindowHeaderElement(index);
    sizeFromDOM = isWidth ? headerCell.offsetWidth : headerCell.offsetHeight;
   }
   else {
    var mainCell = this.GetWindowMainCell(element);
    sizeFromDOM = isWidth ? mainCell.offsetWidth : mainCell.offsetHeight;
   }
   if(sizeFromDOM === 0 && cachedSize)
    sizeFromDOM = isWidth ? cachedSize.width : cachedSize.height;
   return sizeFromDOM;
  }
 },
 GetWindowDimension: function(window, isWidth, forceFromCache) {
  var index = (window != null) ? window.index : -1;
  return this.GetWindowDimensionByIndex(index, isWidth, forceFromCache);
 },
 GetWindowContentDimension: function(window, isWidth) {
  var index = (window != null) ? window.index : -1,
   dimension = 0,
   contentElem = this.GetWindowContentElement(index),
   dimensionHolder = contentElem.parentNode,
   paddingsHolder = contentElem;
  return isWidth ?
  (dimensionHolder.offsetWidth - ASPx.GetLeftRightBordersAndPaddingsSummaryValue(paddingsHolder)) :
  (dimensionHolder.offsetHeight - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(paddingsHolder));
 },
 GetWindowContentWidth: function(window) {
  return this.GetWindowContentDimension(window, true);
 },
 GetWindowContentHeight: function(window) {
  return this.GetWindowContentDimension(window, false);
 },
 GetWindowHeight: function(window) {
  return this.GetWindowDimension(window, false);
 },
 GetWindowWidth: function(window) {
  return this.GetWindowDimension(window, true);
 },
 SetWindowSize: function(window, width, height) {
  var index = (window != null) ? window.index : -1;
  this.SetWindowSizeByIndex(index, width, height);
 },
 GetContentHTML: function() {
  return this.GetContentHtml();
 },
 SetContentHTML: function(html) {
  this.SetContentHtml(html);
 },
 GetContentHtml: function() {
  return this.GetWindowContentHtml(null);
 },
 SetContentHtml: function(html, useAnimation) {
  this.SetWindowContentHtml(null, html, useAnimation);
 },
 GetContentIFrame: function(window) {
  return this.GetWindowContentIFrame(null);
 },
 GetContentUrl: function() {
  return this.GetWindowContentUrl(null);
 },
 SetContentUrl: function(url) {
  this.SetWindowContentUrl(null, url);
 },
 RefreshContentUrl: function() {
  this.RefreshWindowContentUrl(null);
 },
 SetWindowPopupElementID: function(window, popupElementId) {
  var index = (window != null) ? window.index : -1;
  this.RemoveWindowAllPopupElements(index);
  this.SetPopupElementIDs(index, popupElementId.split(';'));
  if(aspxGetPopupControlCollection().IsDisappearTimerActive()) {
   aspxGetPopupControlCollection().ClearDisappearTimer();
   this.Hide(index);
  }
  this.PopulatePopupElements(index);
 },
 SetPopupElementID: function(popupElementId) {
  this.SetWindowPopupElementID(null, popupElementId);
 },
 GetCurrentPopupElementIndex: function() {
  return this.GetWindowCurrentPopupElementIndex(null);
 },
 GetWindowCurrentPopupElementIndex: function(window) {
  var popupElement = this.GetWindowCurrentPopupElement(window);
  return popupElement ? popupElement.DXPopupElementIndex : -1;
 },
 GetCurrentPopupElement: function() {
  return this.GetWindowCurrentPopupElement(null);
 },
 GetWindowCurrentPopupElement: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.GetWindowCurrentPopupElementByIndex(index);
 },
 GetWindowCurrentPopupElementByIndex: function(index) {
  var popupElement = this.GetPopupElement(index, this.GetLastShownPopupElementIndex(index));
  if(popupElement && popupElement.DXPopupElementControl)
   return popupElement;
  return null;
 },
 Show: function(popupElementIndex) {
  this.ShowWindow(null, popupElementIndex);
 },
 ShowAtElement: function(htmlElement) {
  this.ShowWindowAtElement(null, htmlElement);
 },
 ShowAtElementByID: function(id) {
  var htmlElement = document.getElementById(id);
  this.ShowWindowAtElement(null, htmlElement);
 },
 ShowAtPos: function(x, y) {
  this.ShowWindowAtPos(null, Math.round(x), Math.round(y));
 },
 BringToFront: function() {
  this.BringWindowToFront(null);
 },
 Hide: function() {
  this.HideWindow(null);
 },
 IsWindowVisible: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.InternalIsWindowVisible(index);
 },
 IsVisible: function() {
  return this.InternalIsWindowVisible(-1);
 },
 GetWindow: function(index) {
  return (0 <= index && index < this.windows.length) ? this.windows[index] : null;
 },
 GetWindowByName: function(name) {
  for(var i = 0; i < this.windows.length; i++)
   if(this.windows[i].name == name) return this.windows[i];
  return null;
 },
 GetWindowCount: function() {
  return this.GetWindowCountCore();
 },
 ShowWindow: function(window, popupElementIndex) {
  var index = (window != null) ? window.index : -1;
  if(popupElementIndex === undefined)
   popupElementIndex = this.GetLastShownPopupElementIndex(index);
  this.DoShowWindowAtPos(index, ASPx.InvalidPosition, ASPx.InvalidPosition, popupElementIndex, false, true);
 },
 ShowWindowAtElement: function(window, htmlElement) {
  var index = (window != null) ? window.index : -1;
  var lastIndexBackup = this.GetLastShownPopupElementIndex(index);
  this.ShowWindow(window, this.AddPopupElementInternal(index, htmlElement));
  this.RemovePopupElementInternal(index, htmlElement);
  this.SetLastShownPopupElementIndex(index, lastIndexBackup);
 },
 ShowWindowAtElementByID: function(window, id) {
  var htmlElement = document.getElementById(id);
  this.ShowWindowAtElement(window, htmlElement);
 },
 ShowWindowAtPos: function(window, x, y) {
  var index = (window != null) ? window.index : -1;
  this.DoShowWindowAtPos(index, x, y, -1, false, true);
 },
 BringWindowToFront: function(window) {
  var index = (window != null) ? window.index : -1;
  var element = this.GetWindowElement(index);
  aspxGetPopupControlCollection().ActivateWindowElement(element);
 },
 HideWindow: function(window) {
  var index = (window != null) ? window.index : -1;
  this.DoHideWindow(index, false, ASPxClientPopupControlCloseReason.API);
 },
 GetWindowContentHTML: function(window) {
  return this.GetWindowContentHtml(window);
 },
 SetWindowContentHTML: function(window, html) {
  this.SetWindowContentHtml(window, html);
 },
 GetWindowContentHtml: function(window) {
  var index = (window != null) ? window.index : -1;
  var element = this.GetContentContainer(index);
  return (element != null) ? element.innerHTML : "";
 },
 SetWindowContentHtml: function(window, html, useAnimation) {
  var index = (window != null) ? window.index : -1;
  this.SetWindowContentHtmlCore(index, html, useAnimation);
 },
 SetWindowContentHtmlCore: function(index, html, useAnimation) {
  var element = this.GetContentContainer(index);
  if(element != null) {
   ASPx.SetInnerHtml(element, html);
   this.RecalculateWindowSize(index);
   if(useAnimation && typeof (ASPx.AnimationHelper) != "undefined")
    ASPx.AnimationHelper.fadeIn(element, function() { this.ResizeWindowIFrame(index); }.aspxBind(this));
   else
    this.ResizeWindowIFrame(index);
   this.UpdateScrollbar(index);
  }
 },
 RecalculateWindowSize: function(index) {
  var window = this.GetWindowElement(index);
  var displayAfterSetSize = window.style.display;
  this.SetClientWindowSizeCoreLite(index, this.GetWindowWidthInternal(index), this.GetWindowHeightInternal(index), this.GetIsCollapsed(index));
  window.style.display = displayAfterSetSize;
  if(this.HasAnyScrollBars(index))
   this.NormalizeWindowSize(index, this.GetIsMaximized(index));
 },
 GetWindowContentIFrame: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.GetWindowContentIFrameElement(index);
 },
 GetWindowContentUrl: function(window) {
  var index = (window != null) ? window.index : -1;
  if(!this.IsWindowVisible(window))
   return this.GetWindowContentIFrameUrl(index);
  var element = this.GetWindowContentIFrameElement(index);
  return (element != null) ? element.src : "";
 },
 SetWindowContentUrl: function(window, url) {
  var index = (window != null) ? window.index : -1;
  this.SetWindowContentUrlInternal(index, url);
 },
 SetWindowContentUrlInternal: function(index, url) {
  var element = this.GetWindowContentIFrameElement(index);
  var windowVisible = this.InternalIsWindowVisible(index);
  if(windowVisible && element != null)
   this.ShowIframeElementAfterDragging(index);
  this.SetWindowContentIFrameUrl(index, url);
  var src = !windowVisible ? ASPx.SSLSecureBlankUrl : url;
  if(element == null) {
   this.CreateWindowContentIFrameElement(index, src);
   if(ASPx.IsElementVisible(this.GetWindowElement(index))) {
    var windowWidth = this.GetWindowDimensionByIndex(index, true, false);
    var windowHeight = this.GetWindowDimensionByIndex(index, false, false);
    this.SetClientWindowSizeCoreLite(index, windowWidth, windowHeight);
   }
  }
  else
   this.SetSrcToIframeElement(index, element, src);
 },
 GetPinned: function() {
  return this.GetIsPinned(-1);
 },
 SetPinned: function(value) {
  this.SetPinCore(-1, value);
 },
 GetWindowPinned: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.GetIsPinned(index);
 },
 SetWindowPinned: function(window, value) {
  var index = (window != null) ? window.index : -1;
  this.SetPinCore(index, value);
 },
 GetMaximized: function() {
  return this.GetIsMaximized(-1);
 },
 SetMaximized: function(value) {
  this.SetMaximizedCore(-1, value);
 },
 GetWindowMaximized: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.GetIsMaximized(index);
 },
 SetWindowMaximized: function(window, value) {
  var index = (window != null) ? window.index : -1;
  this.SetMaximizedCore(index, value);
 },
 GetCollapsed: function() {
  return this.GetIsCollapsed(-1);
 },
 SetCollapsed: function(value) {
  this.SetCollapsedCore(-1, value);
 },
 GetWindowCollapsed: function(window) {
  var index = (window != null) ? window.index : -1;
  return this.GetIsCollapsed(index);
 },
 SetWindowCollapsed: function(window, value) {
  var index = (window != null) ? window.index : -1;
  this.SetCollapsedCore(index, value);
 },
 RefreshWindowContentUrl: function(window) {
  var index = (window != null) ? window.index : -1;
  if(ASPx.Browser.IE)
   this.RefreshWindowContentUrlIE(index, window);
  else
   this.RefreshWindowContentUrlCommon(window);
 },
 RefreshWindowContentUrlIE: function(index, window) {
  var windowVisible = this.InternalIsWindowVisible(index);
  if(windowVisible)
   this.RefreshWindowContentUrlIECore(index, window);
  else {
   var iframe = this.GetWindowContentIFrameElement(index);
   if(iframe)
    iframe.DXReloadAfterShowRequired = true;
  }
 },
 RefreshWindowContentUrlIECore: function(index, window) {
  try {
   if(!this.GetIframeLoading(index)) {
    var iframe = this.GetWindowContentIFrameElement(index);
    if(iframe)
     iframe.contentWindow.location.reload();
   }
  } catch (e) {
   this.RefreshWindowContentUrlCommon(window);
  }
 },
 RefreshWindowContentUrlCommon: function(window) {
  this.SetWindowContentUrl(window, this.GetWindowContentUrl(window));
 },
 SetWindowContentVisible: function(index, visible) {
  var contentElement = this.GetWindowContentWrapperElement(index);
  if(contentElement)
   this.SetWindowPartVisibleCore(contentElement, "DXPopupWindowContentDisplay", visible);
 },
 SetWindowFooterVisible: function(index, visible) {
  var footerElement = this.GetWindowFooterElement(index);
  if(footerElement)
   this.SetWindowPartVisibleCore(footerElement, "DXPopupWindowFooterDisplay", visible);
 },
 SetWindowPartVisibleCore: function(partElement, displayCacheName, visible) {
  var nothingChanged = ASPx.IsElementVisible(partElement) && visible;
  if(nothingChanged) return;
  if(!(ASPx.IsExists(partElement[displayCacheName])))
   partElement[displayCacheName] = partElement.style.display;
  partElement.style.display = visible ? partElement[displayCacheName] : 'none';
 },
 UpdatePosition: function() {
  this.UpdatePositionAtElement(this.GetPopupElement(-1, this.GetLastShownPopupElementIndex(-1)));
 },
 UpdatePositionAtElement: function(popupElement) {
  this.UpdateWindowPositionAtElement(null, popupElement);
 },
 UpdateWindowPosition: function(window) {
  var index = (window != null) ? window.index : -1;
  this.UpdateWindowPositionAtElement(window, this.GetPopupElement(index, this.GetLastShownPopupElementIndex(index)));
 },
 UpdateWindowPositionAtElement: function(window, popupElement) {
  var index = (window != null) ? window.index : -1;
  this.UpdateWindowPositionInternal(index, popupElement);
 },
 UpdateWindowPositionInternal: function(index, popupElement) {
  var element = this.GetWindowElement(index);
  if(this.InternalIsWindowVisible(index) && element != null) {
   var horizontalPopupPosition = this.GetClientPopupPos(element, popupElement, ASPx.InvalidPosition, true, false);
   var verticalPopupPosition = this.GetClientPopupPos(element, popupElement, ASPx.InvalidPosition, false, false);
   this.SetWindowPos(index, element, horizontalPopupPosition.position, verticalPopupPosition.position);
  } else
   this.DoShowWindowAtPos(index, ASPx.InvalidDimension, ASPx.InvalidDimension, this.GetLastShownPopupElementIndex(index), false, false);
 },
 TryAutoUpdatePosition: function(index) {
  if(this.GetAutoUpdatePosition(index))
   this.UpdateWindowPositionInternal(index, this.GetPopupElement(index, this.GetLastShownPopupElementIndex(index)));
  if(this.GetIsMaximized(index))
   this.UpdateMaximizedWindowSizeOnResize(index);
 },
 CreateWindowContentIFrameElement: function(index, src) {
  var content = this.GetContentContainer(index);
  var iframeParent = content;
  content.innerHTML = "";
  content.style.display = "block";
  var iframe = this.CreateContentIFrameElement(index, src);
  this.RequireIFrameHeightAdjusting(index, iframe);
  iframeParent.appendChild(iframe);
  this.InitIFrame(index);
  return iframe;
 },
 RequireIFrameHeightAdjusting: function(index, iframe) {
  if(this.InternalIsWindowVisible(index))
   this.AdjustIFrameHeight(index, iframe);
  else
   this.PostponeIframeAdjusting(index);
 },
 EnsureIFrameHeightAdjusted: function(index) {
  if(this.GetIframeAdjustingPostponed(index)) {
   var iframe = this.GetWindowContentIFrameElement(index);
   this.AdjustIFrameHeight(index, iframe);
  }
 },
 PostponeIframeAdjusting: function(index) {
  this.SetIframeAdjustingPostponed(index, true);
 },
 SetIframeAdjustingPostponed: function(index, value) {
  if(0 <= index && index < this.iframeAdjustingPostponedArray.length)
   this.iframeAdjustingPostponedArray[index] = value;
  else
   this.iframeAdjustingPostponed = value;
 },
 GetIframeAdjustingPostponed: function(index) {
  if(0 <= index && index < this.iframeAdjustingPostponedArray.length)
   return this.iframeAdjustingPostponedArray[index];
  return this.iframeAdjustingPostponed;
 },
 AdjustIFrameHeight: function(index, iframe) {
  if(!this.InternalIsWindowVisible(index) || !iframe) return;
  this.SetIframeAdjustingPostponed(index, false);
  var content = this.GetContentContainer(index);
  var contentWrapper = this.GetWindowContentWrapperElement(index);
  iframe.style.verticalAlign = "text-bottom";
  var iframeHeight = contentWrapper.offsetHeight - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(content);
  if(iframeHeight >= 0)
   iframe.style.height = iframeHeight + "px";
 },
 CreateContentIFrameElement: function(index, src) {
  var iframe = document.createElement("IFRAME");
  iframe.id = this.GetWindowContentIFrameElementId(index);
  iframe.scrolling = "auto";
  iframe.frameBorder = 0;
  iframe.style.width = "100%";
  iframe.style.height = "100%";
  iframe.style.overflow = "auto";
  if(ASPx.Browser.Chrome) iframe.style.webkitBackfaceVisibility = "hidden";
  var titleText = this.GetWindowContentIFrameTitle(index);
  if(!!titleText)
   iframe.title = titleText;
  this.SetSrcToIframeElement(index, iframe, src);
  return iframe;
 },
 GetWindowHeaderTextCell: function(index) {
  return this.GetWindowChild(index, "_PWH" + index + "T");
 },
 GetWindowHeaderImageCell: function(index) {
  return this.GetWindowChild(index, "_PWH" + index + "I");
 },
 GetWindowFooterTextCell: function(index) {
  return this.GetWindowChild(index, "_PWF" + index + "T");
 },
 GetWindowFooterImageCell: function(index) {
  return this.GetWindowChild(index, "_PWF" + index + "I");
 },
 GetWindowHeaderImageUrl: function(index) {
  var element = this.GetWindowHeaderImageCell(index);
  return element ? element.src : "";
 },
 SetWindowHeaderImageUrl: function(index, url) {
  var element = this.GetWindowHeaderImageCell(index);
  if(element != null) {
   element.onload = function() { this.CorrectHeaderContentElementHeight(index); }.aspxBind(this);
   element.src = url;
  }
 },
 GetWindowFooterImageUrl: function(index) {
  var element = this.GetWindowFooterImageCell(index);
  return element ? element.src : "";
 },
 SetWindowFooterImageUrl: function(index, url) {
  var element = this.GetWindowFooterImageCell(index);
  if(element != null) {
   element.src = url;
   this.CorrectWindowSizeGripPositionLite(index);
  }
 },
 GetWindowHeaderNavigateUrl: function(index) {
  var header = this.GetWindowHeaderElement(index);
  if(header) {
   var link = ASPx.GetNodeByClassName(header, PopupControlCssClasses.LinkCssClassName);
   if(link)
    return link.href || ASPx.Attr.GetAttribute(linkEl, "savedhref");
  }
  return "";
 },
 SetWindowHeaderNavigateUrl: function(index, url) {
  var header = this.GetWindowHeaderElement(index);
  if(header) {
   var link = ASPx.GetNodeByClassName(header, PopupControlCssClasses.LinkCssClassName);
   if(link) {
    if(ASPx.Attr.IsExistsAttribute(link, "savedhref"))
     ASPx.Attr.SetAttribute(link, "savedhref", url);
    else if(ASPx.Attr.IsExistsAttribute(link, "href"))
     link.href = url;
   }
  }
 },
 GetWindowFooterNavigateUrl: function(index) {
  var footer = this.GetWindowFooterElement(index);
  if(footer) {
   var link = ASPx.GetNodeByClassName(footer, PopupControlCssClasses.LinkCssClassName);
   if(link)
    return link.href || ASPx.Attr.GetAttribute(linkEl, "savedhref");
  }
  return "";
 },
 SetWindowFooterNavigateUrl: function(index, url) {
  var footer = this.GetWindowFooterElement(index);
  if(footer) {
   var link = ASPx.GetNodeByClassName(footer, PopupControlCssClasses.LinkCssClassName);
   if(link) {
    if(ASPx.Attr.IsExistsAttribute(link, "savedhref"))
     ASPx.Attr.SetAttribute(link, "savedhref", url);
    else if (ASPx.Attr.IsExistsAttribute(link, "href"))
     link.href = url;
   }
  }
  return;
 },
 GetWindowHeaderText: function(index) {
  var element = this.GetWindowHeaderTextCell(index);
  if(element != null) {
   var link = ASPx.GetNodeByTagName(element, "A", 0);
   if(link != null)
    return link.innerHTML;
   else
    return element.innerHTML;
  }
  return "";
 },
 SetWindowHeaderText: function(index, text) {
  var element = this.GetWindowHeaderTextCell(index);
  if(element != null) {
   var link = ASPx.GetNodeByTagName(element, "A", 0);
   if(link != null)
    link.innerHTML = text;
   else
    element.innerHTML = text;
   this.CorrectElementVerticalAlignment(ASPx.AdjustVerticalMarginsInContainer, this.GetWindowHeaderElement(index), true);
  }
 },
 GetWindowFooterText: function(index) {
  var element = this.GetWindowFooterTextCell(index);
  if(element != null) {
   var link = ASPx.GetNodeByTagName(element, "A", 0);
   if(link != null)
    return link.innerHTML;
   else
    return element.innerHTML;
  }
  return "";
 },
 SetWindowFooterText: function(index, text) {
  var element = this.GetWindowFooterTextCell(index);
  if(element != null) {
   var link = ASPx.GetNodeByTagName(element, "A", 0);
   if(link != null)
    link.innerHTML = text;
   else
    element.innerHTML = text;
   this.CorrectWindowSizeGripPositionLite(index);
  }
 },
 RefreshPopupElementConnection: function() {
  this.ClearPopupElementConnection();
  var index = this.HasDefaultWindow() ? -1 : 0;
  for(; index < this.GetWindowCount() ; index++)
   this.PopulatePopupElements(index);
 },
 ClearPopupElementConnection: function() {
  var index = this.HasDefaultWindow() ? -1 : 0;
  for(; index < this.GetWindowCount() ; index++)
   this.RemoveWindowAllPopupElements(index);
 },
 GetHeaderImageUrl: function() {
  return this.GetWindowHeaderImageUrl(-1);
 },
 SetHeaderImageUrl: function(value) {
  this.SetWindowHeaderImageUrl(-1, value);
 },
 GetFooterImageUrl: function() {
  return this.GetWindowFooterImageUrl(-1);
 },
 SetFooterImageUrl: function(value) {
  this.SetWindowFooterImageUrl(-1, value);
 },
 GetHeaderNavigateUrl: function() {
  return this.GetWindowHeaderNavigateUrl(-1);
 },
 SetHeaderNavigateUrl: function(value) {
  this.SetWindowHeaderNavigateUrl(-1, value);
 },
 GetFooterNavigateUrl: function() {
  return this.GetWindowFooterNavigateUrl(-1);
 },
 SetFooterNavigateUrl: function(value) {
  this.SetWindowFooterNavigateUrl(-1, value);
 },
 GetHeaderText: function() {
  return this.GetWindowHeaderText(-1);
 },
 SetHeaderText: function(value) {
  this.SetWindowHeaderText(-1, value);
 },
 GetFooterText: function() {
  return this.GetWindowFooterText(-1);
 },
 SetFooterText: function(value) {
  this.SetWindowFooterText(-1, value);
 },
 GetVisible: function() {
  return this.IsVisible();
 },
 SetVisible: function(visible) {
  if(visible && !this.IsVisible())
   this.Show();
  else if(!visible && this.IsVisible())
   this.Hide();
 }
});
ASPxClientPopupControl.Cast = ASPxClientControl.Cast;
ASPxClientPopupControl.GetPopupControlCollection = function() {
 return aspxGetPopupControlCollection();
}
var ASPxClientPopupWindow = ASPx.CreateClass(null, {
 constructor: function(popupControl, index, name) {
  this.popupControl = popupControl;
  this.index = index;
  this.name = name;
 },
 GetHeaderImageUrl: function() {
  return this.popupControl.GetWindowHeaderImageUrl(this.index);
 },
 SetHeaderImageUrl: function(value) {
  this.popupControl.SetWindowHeaderImageUrl(this.index, value);
 },
 GetFooterImageUrl: function() {
  return this.popupControl.GetWindowFooterImageUrl(this.index);
 },
 SetFooterImageUrl: function(value) {
  this.popupControl.SetWindowFooterImageUrl(this.index, value);
 },
 GetHeaderNavigateUrl: function() {
  return this.popupControl.GetWindowHeaderNavigateUrl(this.index);
 },
 SetHeaderNavigateUrl: function(value) {
  this.popupControl.SetWindowHeaderNavigateUrl(this.index, value);
 },
 GetFooterNavigateUrl: function() {
  return this.popupControl.GetWindowFooterNavigateUrl(this.index);
 },
 SetFooterNavigateUrl: function(value) {
  this.popupControl.SetWindowFooterNavigateUrl(this.index, value);
 },
 GetHeaderText: function() {
  return this.popupControl.GetWindowHeaderText(this.index);
 },
 SetHeaderText: function(value) {
  this.popupControl.SetWindowHeaderText(this.index, value);
 },
 GetFooterText: function() {
  return this.popupControl.GetWindowFooterText(this.index);
 },
 SetFooterText: function(value) {
  this.popupControl.SetWindowFooterText(this.index, value);
 }
});
var ASPxClientPopupWindowEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(window) {
  this.constructor.prototype.constructor.call(this);
  this.window = window;
 }
});
var ASPxClientPopupWindowCancelEventArgs = ASPx.CreateClass(ASPxClientCancelEventArgs, {
 constructor: function(window, closeReason) {
  this.constructor.prototype.constructor.call(this);
  this.window = window;
  this.closeReason = closeReason;
 }
});
var ASPxClientPopupWindowCloseUpEventArgs = ASPx.CreateClass(ASPxClientPopupWindowEventArgs, {
 constructor: function(window, closeReason) {
  this.constructor.prototype.constructor.call(this, window);
  this.closeReason = closeReason;
 }
});
var ASPxClientPopupWindowResizeEventArgs = ASPx.CreateClass(ASPxClientPopupWindowEventArgs, {
 constructor: function(window, resizeState) {
  this.constructor.prototype.constructor.call(this, window);
  this.resizeState = resizeState;
 }
});
var ASPxClientPopupWindowPinnedChangedEventArgs = ASPx.CreateClass(ASPxClientPopupWindowEventArgs, {
 constructor: function(window, pinned) {
  this.constructor.prototype.constructor.call(this, window);
  this.pinned = pinned;
 }
});
var ASPxClientPopupControlCollection = ASPx.CreateClass(ASPxClientControlCollection, {
 constructor: function() {
  this.constructor.prototype.constructor.call(this);
  this.draggingControl = null;
  this.draggingWindowIndex = -1;
  this.gragXOffset = 0;
  this.gragYOffset = 0;
  this.visibleModalElements = [];
  this.visiblePopupWindowIds = [];
  this.zIndex = popupControlZIndex;
  this.windowResizeByBodyScrollVisibilityChangingLockCount = 0;
  this.savedBodyWidth = 0;
  this.savedBodyHeight = 0;
  this.overControl = null;
  this.overWindowIndex = -1;
  this.overXPos = ASPx.InvalidPosition;
  this.overYPos = ASPx.InvalidPosition;
  this.appearTimerID = -1;
  this.disappearTimerID = -1;
  this.scrollEventLockCount = 0;
  this.currentActiveWindowElement = null;
  this.resizeControl = null;
  this.resizeIndex = -2;
  this.resizeCursor = "";
  this.resizePanel = null;
  this.selectBanned = false;
  this.pcWindowsAreRestrictedByDocumentWindow = true;
  this.searchForTabIndexInAllElements = false;
  this.docScrollLeft = -1;
  this.docScrollTop = -1;
  this.EnsureSaveScrollState();
 },
 GetCollectionType: function(){
  return "Popup";
 },
 Remove: function(popupControl) {
  for(var i = this.visibleModalElements.length - 1; i >= 0; i--) {
   var modalElement = this.visibleModalElements[i];
   if(modalElement && modalElement.DXModalPopupControl === popupControl)
    this.UnregisterVisibleModalElement(modalElement);
  }
  for(var i = this.visiblePopupWindowIds.length - 1; i >= 0; i--) {
   var id = this.visiblePopupWindowIds[i];
   if(!ASPx.IsExists(id)) continue;
   var popupWindow = this.GetPopupWindowFromID(id);
   if(popupWindow.popupControl === popupControl) {
    var windowElement = popupControl.GetWindowElement(popupWindow.windowIndex);
    if(windowElement)
     this.UnregisterVisibleWindow(windowElement);
    else
     ASPx.Data.ArrayRemove(this.visiblePopupWindowIds, id);
   }
  }
  ASPxClientControlCollection.prototype.Remove.call(this, popupControl);
 },
 EnsureSaveScrollState: function() {
  if(ASPx.documentLoaded && this.docScrollLeft < 0 && this.docScrollTop < 0)
   this.SaveScrollState();
 },
 GetPopupWindowFromID: function(id) {
  var pos = id.lastIndexOf(ASPx.PCWIdSuffix);
  var name = id.substring(0, pos);
  var index = id.substr(pos + ASPx.PCWIdSuffix.length);
  var popupControl = aspxGetPopupControlCollection().Get(name);
  return new _aspxPopupWindow(popupControl, index);
 },
 DoHideAllWindows: function(srcElement, excptId, applyToAll, closeReason) {
  for(var i = this.visiblePopupWindowIds.length - 1; i >= 0; i--) {
   var id = this.visiblePopupWindowIds[i];
   if(id == excptId) continue;
   if(srcElement != null && ASPx.GetParentById(srcElement, id) != null) continue;
   var popupWindow = this.GetPopupWindowFromID(id);
   var windowCloseAction = popupWindow.popupControl.GetWindowCloseAction(popupWindow.windowIndex);
   if(popupWindow.popupControl != null) {
    var popupWindowZIndexArray = ASPx.PopupUtils.GetElementZIndexArray(popupWindow.popupControl.GetWindowElement(popupWindow.windowIndex));
    var isPopupHigherSrcElement = ASPx.PopupUtils.IsHigher(popupWindowZIndexArray, ASPx.PopupUtils.GetElementZIndexArray(srcElement)) || !popupWindow.popupControl.HasDefaultWindow();
   }
   if(popupWindow.popupControl != null && (
    (windowCloseAction != "CloseButton" && windowCloseAction != "None") && isPopupHigherSrcElement || applyToAll)) {
    popupWindow.popupControl.DoHideWindow(parseInt(popupWindow.windowIndex), false, closeReason);
   }
  }
 },
 DoShowAtCurrentPos: function(name, index, popupElementIndex, evtClone) {
  var pc = this.Get(name);
  if(pc != null && !pc.InternalIsWindowVisible(index))
   pc.DoShowWindowAtPos(index, this.overXPos, this.overYPos, popupElementIndex, true, true, evtClone, ASPxClientPopupControlCloseReason.MouseOut);
 },
 WindowZIndexWasInitialized: function(zIndex) {
  return popupControlZIndex <= zIndex;
 },
 ActivateWindowElement: function(element, evt) {
  var maxZIndex = this.GetMaxZIndex(),
   topZIndex = this.WindowZIndexWasInitialized(maxZIndex) ? parseInt(maxZIndex) : popupControlZIndex;
  if(this.WindowZIndexWasInitialized(element.style.zIndex) && element.style.zIndex != topZIndex) {
   this.DeleteWindowFromZIndexOrder(element);
  }
  if(!this.WindowZIndexWasInitialized(element.style.zIndex))
   topZIndex += 2;
  this.SetWindowElementZIndex(element, topZIndex);
  var pcWElementEventSource = ASPx.PopupUtils.FindEventSourceParentByTestFunc(evt, aspxTestPopupWindowElement);
  if(!evt || (evt && pcWElementEventSource == element)) { 
   if(this.GetCurrentActiveWindowElement() != element) {
    this.RefreshTabIndexes(false);
    this.SaveCurrentActiveWindowElement(element);
   }
  }
 },
 RefreshTabIndexes: function(forceRecalculate) {
  var topModalWindow = this.GetTopModalWindow();
  if(topModalWindow != null || forceRecalculate) {
   var topModalWindowZIndexArray = ASPx.PopupUtils.GetElementZIndexArray(topModalWindow);
   this.CalculateTabIndexes(topModalWindowZIndexArray);
  }
 },
 ElementHasTabIndex: function(element) {
  return ASPx.IsExists(ASPx.Attr.GetAttribute(element, "tabindex"));
 },
 IsElementCanBeActive: function(element) {
  return element.tagName === "INPUT" || element.tagName === "A" ||
   element.tagName === "BUTTON" || element.tagName === "TEXTAREA" ||
   element.tagName === "SELECT" || this.ElementHasTabIndex(element);
 },
 GetCanBeActiveElements: function() {
  var searchForTabIndexInAllElements = aspxGetPopupControlCollection().searchForTabIndexInAllElements;
  if(searchForTabIndexInAllElements) {
   var elements = document.getElementsByTagName("*");
   var canBeActiveElements = [];
   for(var i = 0; i < elements.length; i++) {
    if(this.IsElementCanBeActive(elements[i], searchForTabIndexInAllElements))
     canBeActiveElements.push(elements[i]);
   }
   return canBeActiveElements;
  } else {
   var inputs = document.getElementsByTagName("INPUT");
   var links = document.getElementsByTagName("A");
   var lists = document.getElementsByTagName("UL");
   var buttons = document.getElementsByTagName("BUTTON");
   var textareas = document.getElementsByTagName("TEXTAREA");
   var selects = document.getElementsByTagName("SELECT");
   var iframes = document.getElementsByTagName("IFRAME");
   var editableDivs = this.GetEditableDivs();
   var union = ASPx.Data.CollectionsUnionToArray(inputs, links);
   union = ASPx.Data.CollectionsUnionToArray(union, buttons);
   union = ASPx.Data.CollectionsUnionToArray(union, textareas);
   union = ASPx.Data.CollectionsUnionToArray(union, selects);
   union = ASPx.Data.CollectionsUnionToArray(union, iframes);
   union = ASPx.Data.CollectionsUnionToArray(union, editableDivs);
   return ASPx.Data.CollectionsUnionToArray(union, lists);
  }
 },
 GetEditableDivs: function(){
  if(document.querySelectorAll)
   return document.querySelectorAll("div[contenteditable=true]");
  var editableDivs = [ ];
  var allDivs = document.getElementsByTagName("DIV");
  for(var i = 0; i < allDivs.length; i++){
   var div = allDivs[i];
   (div.getAttribute("contenteditable") == 'true') && editableDivs.push(div);
  }
  return editableDivs;
 },
 CalculateTabIndexes: function(topModalWindowZIndexArray) {
  var elements = this.GetCanBeActiveElements();
  for(var i = 0; i < elements.length; i++) {
   var currentElementZIndexArray = ASPx.PopupUtils.GetElementZIndexArray(elements[i]);
   if(ASPx.PopupUtils.IsHigher(currentElementZIndexArray, topModalWindowZIndexArray))
    ASPx.Attr.RestoreTabIndexAttribute(elements[i]);
   else
    ASPx.Attr.ChangeTabIndexAttribute(elements[i]);
  }
 },
 PopupWindowIsModalByVisibleIndex: function(visiblePopupWindowIndex) {
  return this.PopupWindowIsModalByID(this.visiblePopupWindowIds[visiblePopupWindowIndex]);
 },
 PopupWindowIsModalByID: function(windowElementID) {
  var popupWindow = this.GetPopupWindowFromID(windowElementID);
  return popupWindow.popupControl.WindowIsModal(popupWindow.windowIndex);
 },
 SaveCurrentActiveWindowElement: function(windowElement) {
  this.currentActiveWindowElement = windowElement;
 },
 SkipCurrentActiveWindowElement: function(element) {
  if(element == this.GetCurrentActiveWindowElement())
   this.SaveCurrentActiveWindowElement(null);
 },
 GetCurrentActiveWindowElement: function() {
  return this.currentActiveWindowElement;
 },
 GetMaxZIndex: function () {
  var maxZIndex = defaultZIndexFromServer;
  for(var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var currentWindow = ASPx.GetElementById(this.visiblePopupWindowIds[i]);
   if(!!currentWindow && ASPx.IsElementVisible(currentWindow) && currentWindow.style && currentWindow.style.zIndex > maxZIndex)
    maxZIndex = currentWindow.style.zIndex;
  }
  return maxZIndex;
 },
 GetTopModalWindow: function() {
  return this.GetTopWindow(true);
 },
 GetTopWindow: function(onlyModal) {
  var topWindow = null;
  var topWindowZIndexArray = null;
  for(var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var currentWindow = ASPx.GetElementById(this.visiblePopupWindowIds[i]);
   if(onlyModal && !this.PopupWindowIsModalByVisibleIndex(i))
    continue;
   if(ASPx.IsElementVisible(currentWindow)) {
    var currentWindowZIndexArray = ASPx.PopupUtils.GetElementZIndexArray(currentWindow);
    if(topWindow == null || ASPx.PopupUtils.IsHigher(currentWindowZIndexArray, topWindowZIndexArray)) {
     topWindow = currentWindow;
     topWindowZIndexArray = currentWindowZIndexArray;
    }
   }
  }
  return topWindow;
 },
 DeleteWindowFromZIndexOrder: function(element) {
  for(var i = this.visiblePopupWindowIds.length - 1; i >= 0; i--) {
   var windowElement = ASPx.GetElementById(this.visiblePopupWindowIds[i]);
   if(!windowElement)
    ASPx.Data.ArrayRemoveAt(this.visiblePopupWindowIds, i);
   else if(windowElement.style.zIndex > element.style.zIndex)
    this.SetWindowElementZIndex(windowElement, windowElement.style.zIndex - 2);
  }
 },
 SetWindowElementZIndex: function(element, zIndex) {
  element.style.zIndex = zIndex;
  var iFrame = element.overflowElement;
  if(iFrame)
   iFrame.style.zIndex = zIndex - 1;
  var modalElement = element.modalElement;
  if(modalElement)
   modalElement.style.zIndex = zIndex - 1;
  this.UpdateWindowsStateCookie(element.id);
 },
 AdjustModalElementsBounds: function() {
  for(var i = 0; i < this.visibleModalElements.length; i++)
   this.AdjustModalElementBounds(this.visibleModalElements[i]);
 },
 AdjustModalElementBounds: function(element) {
  if(!ASPx.IsExistsElement(element)) return;
  var x = ASPx.PrepareClientPosForElement(0, element, true);
  var y = ASPx.PrepareClientPosForElement(0, element, false);
  ASPx.SetStyles(element, { left: x, top: y });
  if(ASPx.Browser.NetscapeFamily && !ASPx.Browser.Firefox)
   ASPx.SetStyles(element, { width: 1, height: 1 });
  ASPx.SetStyles(element, { width: ASPx.GetDocumentWidth(), height: ASPx.GetDocumentHeight() });
 },
 ClearAppearTimer: function() {
  this.appearTimerID = ASPx.Timer.ClearTimer(this.appearTimerID);
 },
 ClearDisappearTimer: function() {
  this.disappearTimerID = ASPx.Timer.ClearTimer(this.disappearTimerID);
 },
 IsAppearTimerActive: function() {
  return this.appearTimerID > -1;
 },
 IsDisappearTimerActive: function() {
  return this.disappearTimerID > -1;
 },
 SetAppearTimer: function(name, index, popupElementIndex, timeout, evt) {
  var evtClone = ASPx.CloneObject(evt);
  this.appearTimerID = window.setTimeout(function() {
   aspxGetPopupControlCollection().DoShowAtCurrentPos(name, index, popupElementIndex, evtClone);
  }, timeout);
 },
 SetDisappearTimer: function(name, index, timeout) {
  this.disappearTimerID = window.setTimeout(function() {
   aspxGetPopupControlCollection().OnPWDisappearTimer(name, index);
  }, timeout);
 },
 GetDocScrollDifference: function() {
  return new _aspxScrollDifference(ASPx.GetDocumentScrollLeft() - this.docScrollLeft, ASPx.GetDocumentScrollTop() - this.docScrollTop);
 },
 IsDocScrolled: function(scroll) {
  return scroll.horizontal != 0 || scroll.vertical != 0;
 },
 SaveScrollState: function() {
  this.docScrollLeft = ASPx.GetDocumentScrollLeft();
  this.docScrollTop = ASPx.GetDocumentScrollTop();
 },
 InitDragObject: function(control, index, x, y, xClientCorrection, yClientCorrection) {
  this.draggingControl = control;
  this.draggingWindowIndex = index;
  this.gragXOffset = x;
  this.gragYOffset = y;
  this.xClientCorrection = xClientCorrection;
  this.yClientCorrection = yClientCorrection;
  this.SetDocumentSelectionBan(true);
 },
 InitOverObject: function(control, index, evt) {
  this.overControl = control;
  this.overWindowIndex = index;
  if(evt)
   this.SaveCurrentMouseOverPos(evt);
 },
 InitResizeObject: function(control, index, cursor, resizePanel) {
  this.resizeControl = control;
  this.resizeIndex = index;
  this.resizeCursor = cursor;
  this.resizePanel = resizePanel;
  this.SetDocumentSelectionBan(true);
 },
 SetDocumentSelectionBan: function(value) {
  if(this.selectBanned === value)
   return;
  this.selectBanned = value;
  if(ASPx.Browser.WebKitFamily) {
   if(value) {
    if(!this.webkitUserSelectBackup && document.body.style.webkitUserSelect)
     this.webkitUserSelectBackup = document.body.style.webkitUserSelect;
    document.body.style.webkitUserSelect = "none";
   } else {
    if(this.webkitUserSelectBackup) {
     document.body.style.webkitUserSelect = this.webkitUserSelectBackup;
     delete this.webkitUserSelectBackup;
    } else
     document.body.style.webkitUserSelect = "auto";
   }
  }
 },
 IsResizeInint: function() {
  return this.resizeControl != null;
 },
 ClearDragObject: function() {
  this.draggingControl = null;
  this.draggingWindowIndex = -1;
  this.gragXOffset = 0;
  this.gragYOffset = 0;
  this.SetDocumentSelectionBan(this.resizeControl != null);
 },
 ClearResizeObject: function() {
  this.resizeControl = null;
  this.resizeIndex = -2;
  this.resizeCursor = "";
  this.SetDocumentSelectionBan(this.draggingControl != null);
  this.resizePanel.parentNode.removeChild(this.resizePanel);
 },
 Drag: function(evt) {
  if(ASPx.tableColumnResizing || ASPx.currentDragHelper || !ASPx.Evt.IsLeftButtonPressed(evt)) return;
  var x = ASPx.Evt.GetEventX(evt);
  var y = ASPx.Evt.GetEventY(evt);
  if(this.pcWindowsAreRestrictedByDocumentWindow && ASPx.PopupUtils.CoordinatesInDocumentRect(x, y)) {
   x += this.gragXOffset;
   y += this.gragYOffset;
   this.draggingControl.OnDrag(this.draggingWindowIndex, x, y, this.xClientCorrection, this.yClientCorrection, evt);
   if(ASPx.Browser.WebKitTouchUI)
    evt.preventDefault();
  }
 },
 DragStop: function() {
  this.draggingControl.OnDragStop(this.draggingWindowIndex);
  this.ClearDragObject();
 },
 ResizeStop: function(evt) {
  this.resizeControl.OnResizeStop(evt, this.resizeIndex, this.resizeCursor, this.resizePanel);
  aspxGetPopupControlCollection().ClearResizeObject();
 },
 setIframesMouseMoveEnabled: function(enabled) {
  for(var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var popupWindow = this.GetPopupWindowFromID(this.visiblePopupWindowIds[i]);
   var popupControl = popupWindow.popupControl;
   if(popupControl) {
    iframe = popupControl.GetWindowContentIFrameElement(popupWindow.windowIndex);
    if(iframe) {
     iframe.style.pointerEvents = enabled ? "" : "none";
     if(ASPx.Browser.IE && ASPx.Browser.MajorVersion < 11) {
      if(enabled)
       popupControl.RemoveFakeResizeDiv(iframe, popupWindow.windowIndex)
      else
       popupControl.CreateFakeResizeDiv(iframe, popupWindow.windowIndex);
     }
    }
   }
  }
 },
 OnPWMouseMove: function(evt, name, index) {
  if(this.draggingControl == null &&
   this.overControl == null &&
   this.resizeControl == null) {
   var pc = aspxGetPopupControlCollection().Get(name);
   if(pc != null) pc.OnMouseMove(evt, index);
  }
 },
 OnPWMouseOver: function(evt) {
  if(!this.overControl || this.draggingControl) return;
  if(this.IsOverPopupWindow(evt))
   this.ClearDisappearTimer();
 },
 IsOverPopupWindow: function(evt) {
  return ASPx.PopupUtils.FindEventSourceParentByTestFunc(evt, aspxTestPopupControlOverElement) != null;
 },
 OnDocumentKeyDown: function(evt) {
  var windowElement = this.GetTopWindow(false);
  if(windowElement) {
   var window = this.GetPopupWindowFromID(windowElement.id)
   if(window.popupControl);
    window.popupControl.OnDocumentKeyDown(evt, windowElement);
  }
 },
 OnDocumentMouseDown: function(evt) {
  var popupElement = ASPx.PopupUtils.FindEventSourceParentByTestFunc(evt, aspxTestPopupControlElement);
  var excptId = popupElement == null ? "" :
   popupElement.DXPopupElementControl.GetWindowElementId(popupElement.DXPopupWindowIndex);
  this.OnMouseDownCore(evt, excptId);
 },
 OnMouseDown: function(evt) {
  this.OnMouseDownCore(evt, "");
 },
 OnMouseDownCore: function(evt, excptId) {
  var srcElement = ASPx.Evt.GetEventSource(evt);
  this.DoHideAllWindows(srcElement, excptId, false, ASPxClientPopupControlCloseReason.OuterMouseClick);
  aspxGetPopupControlCollection().ClearAppearTimer();
 },
 OnMouseMove: function(evt) {
  if(ASPx.Browser.WebKitTouchUI && ASPx.TouchUIHelper.isGesture)
   return;
  if(this.draggingControl != null) {
   this.Drag(evt);
  }
  else if(this.overControl != null) {
   this.OnMouseOver(evt);
  }
  else if(this.resizeControl != null) {
   if(ASPx.Browser.IE && !ASPx.Evt.IsLeftButtonPressed(evt))
    this.ResizeStop(evt);
   else
    this.resizeControl.OnResize(evt, this.resizeIndex, this.resizeCursor, this.resizePanel);
  }
 },
 OnMouseOver: function(evt) {
  var element = ASPx.PopupUtils.FindEventSourceParentByTestFunc(evt, aspxTestPopupControlOverElement);
  var curPopupElement = this.overControl.GetWindowCurrentPopupElementByIndex(this.overWindowIndex);
  var popup = element != null ? element.DXPopupElementControl : null;
  var isPopupActionMouseOver = popup && popup.GetWindowPopupAction(this.overWindowIndex) == 'MouseOver';
  var isCurPopupElement = element !== null && element === curPopupElement;
  var isCurPopupWindow = element != null && element.id === this.overControl.GetWindowElementId(this.overWindowIndex);
  var isCurPopupElementOrCurPopupWindow = isCurPopupElement || isCurPopupWindow || isPopupActionMouseOver;
  if(isCurPopupElementOrCurPopupWindow) {
   var clearTimer = true;
   var popup = element.DXPopupElementControl;
   if(popup && popup.GetLastShownPopupElementIndex(element.DXPopupWindowIndex) != element.DXPopupElementIndex)
    clearTimer = false;
   if(clearTimer)
    this.ClearDisappearTimer();
   this.SaveCurrentMouseOverPos(evt);
   if(ASPx.Browser.TouchUI && !ASPx.TouchUIHelper.IsNativeScrolling())
    return;
   return ASPx.Evt.CancelBubble(evt);
  }
  this.OnMouseOut();
 },
 OnMouseOut: function(evt) {
  if(!this.overControl || this.draggingControl) return;
  this.ClearAppearTimer();
  var windowCloseAction = this.overControl.GetWindowCloseAction(this.overWindowIndex);
  if(windowCloseAction == "MouseOut" && this.overControl.InternalIsWindowVisible(this.overWindowIndex)) {
   if(!this.IsDisappearTimerActive() && this.IsDisappearAllowedByMouseOut(evt))
    this.SetDisappearTimer(this.overControl.name, this.overWindowIndex, this.overControl.disappearAfter);
  }
  else
   this.OverStop();
 },
 IsDisappearAllowedByMouseOut: function(evt) {
  return ASPx.Browser.Firefox ? !this.IsOverPopupWindow(evt) : true;  
 },
 OnMouseUp: function(evt) {
  if(this.draggingControl != null)
   this.DragStop();
  if(this.resizeControl != null)
   this.ResizeStop(evt);
 },
 OnResize: function(evt) {
  this.AutoUpdateElementsPosition();
  this.AdjustModalElementsBounds();
 },
 OnScroll: function(evt) {
  if(this.scrollEventLockCount > 0)
   return;
  var scroll = this.GetDocScrollDifference();
  if(this.IsDocScrolled(scroll)) { 
   this.CorrectPositionAtScroll(scroll);
   this.AdjustModalElementsBounds();
   this.SaveScrollState();
  }
  if(ASPx.Browser.IE && ASPx.Browser.Version <= 8) {
   this.CalculateDocumentDimensionsWithoutPinnedWindowsOldIE(function() {
    this.FireScrollEventToWindowsOldIE(evt);
   }.aspxBind(this), evt);
  }
  else {
   this.CalculateDocumentDimensionsWithoutPinnedWindows(evt);
   this.FireScrollEventToWindows(evt);
  }
 },
 GetSavedBodyWidth: function() {
  if(this.savedBodyWidth == 0)
   this.CalculateDocumentDimensionsWithoutPinnedWindows();
  return this.savedBodyWidth;
 },
 GetSavedBodyHeight: function() {
  if(this.savedBodyHeight == 0)
   this.CalculateDocumentDimensionsWithoutPinnedWindows();
  return this.savedBodyHeight;
 },
 HidePinnedPopupsThatOutFromViewPort: function() {
  var popupsToRestoreVisible = [];
  for(var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var popupWindow = this.GetPopupWindowFromID(this.visiblePopupWindowIds[i]);
   var popupControl = popupWindow.popupControl;
   if(!popupControl.needToHidePinnedOutFromViewPort(popupWindow.windowIndex))
    continue;
   var element = popupControl.GetWindowElement(popupWindow.windowIndex);
   if(!element) continue;
   var restoreData = {};
   restoreData.element = element;
   restoreData.display = element.style.display;
   element.style.display = "none";
   popupsToRestoreVisible.push(restoreData);
  }
  return popupsToRestoreVisible;
 },
 RestorePinnedPopupsThatOutFromViewPort: function(popupsToRestoreVisible) {
  if(popupsToRestoreVisible.length > 0) {
   for(var i = 0; i < popupsToRestoreVisible.length; i++) {
    var restoreData = popupsToRestoreVisible[i];
    restoreData.element.style.display = restoreData.display;
   }
  }
 },
 CalculateDocumentDimensionsWithoutPinnedWindows: function(evt) { 
  var popupsToRestoreVisible = [];
  var needToHideRestorePopupsThatOutFromViewPort = !!evt && ASPx.Evt.GetEventSource(evt) == document;
  if(needToHideRestorePopupsThatOutFromViewPort)
   popupsToRestoreVisible = this.HidePinnedPopupsThatOutFromViewPort();
  this.savedBodyWidth = ASPx.GetDocumentWidth();
  this.savedBodyHeight = ASPx.GetDocumentHeight();
  if(needToHideRestorePopupsThatOutFromViewPort)
   this.RestorePinnedPopupsThatOutFromViewPort(popupsToRestoreVisible);
 },
 FireScrollEventToWindows: function(evt) {
  for(var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var popupWindow = this.GetPopupWindowFromID(this.visiblePopupWindowIds[i]);
   var popupControl = popupWindow.popupControl;
   popupControl.OnScroll(evt, popupWindow.windowIndex);
  }
 },
 CalculateDocumentDimensionsWithoutPinnedWindowsOldIE: function(onCalculateFinished, evt) {  
  var popupsToRestoreVisible = [];
  var needToHideRestorePopupsThatOutFromViewPort = !!evt && ASPx.Evt.GetEventSource(evt) == document;
  if(needToHideRestorePopupsThatOutFromViewPort)
   popupsToRestoreVisible = this.HidePinnedPopupsThatOutFromViewPort();
  this.scrollEventLockCount++;
  window.setTimeout(function() {
   this.savedBodyWidth = ASPx.GetDocumentWidth();
   this.savedBodyHeight = ASPx.GetDocumentHeight();
   if(needToHideRestorePopupsThatOutFromViewPort)
    this.RestorePinnedPopupsThatOutFromViewPort(popupsToRestoreVisible);
   if(onCalculateFinished)
    window.setTimeout(function() { onCalculateFinished(); }.aspxBind(this), 0);
   this.scrollEventLockCount--;
  }.aspxBind(this), 0);
 },
 FireScrollEventToWindowsOldIE: function(evt) {
  this.scrollEventLockCount++;
  this.FireScrollEventToWindows(evt);
  this.scrollEventLockCount--;
 },
 LockScrollEvent: function() {
  this.scrollEventLockCount++;
 },
 UnlockScrollEvent: function() {
  this.scrollEventLockCount--;
 },
 CorrectPositionAtScroll: function(scroll) {
  for(var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var popupWindow = this.GetPopupWindowFromID(this.visiblePopupWindowIds[i]);
   var popupControl = popupWindow.popupControl;
   if(popupControl != null && popupControl.InternalIsWindowVisible(popupWindow.windowIndex)) {
    if(popupControl.GetAutoUpdatePosition(popupWindow.windowIndex))
     popupWindow.popupControl.TryAutoUpdatePosition(popupWindow.windowIndex);
   }
  }
 },
 OnSelectStart: function() {
  return !this.selectBanned;
 },
 OverStop: function() {
  this.overControl = null;
  this.overWindowIndex = -1;
 },
 OnPWDisappearTimer: function(name, index) {
  var pc = this.Get(name);
  if(pc != null) {
   if(!pc.DoHideWindow(index, false, ASPxClientPopupControlCloseReason.MouseOut))
    this.OverStop();
   this.ClearDisappearTimer();
  }
 },
 SaveCurrentMouseOverPos: function(evt) {
  this.overXPos = ASPx.Evt.GetEventX(evt);
  this.overYPos = ASPx.Evt.GetEventY(evt);
 },
 RegisterVisibleModalElement: function(element) {
  if(ASPx.Data.ArrayIndexOf(this.visibleModalElements, element) == -1)
   this.visibleModalElements.push(element);
 },
 UnregisterVisibleModalElement: function(element) {
  ASPx.Data.ArrayRemove(this.visibleModalElements, element);
 },
 RegisterVisibleWindow: function(element, popupControl, index) {
  if(ASPx.Data.ArrayIndexOf(this.visiblePopupWindowIds, element.id) == -1) {
   this.visiblePopupWindowIds.push(element.id);
   if(popupControl && popupControl.GetWindowCloseAction(index) == "MouseOut")
    aspxGetPopupControlCollection().InitOverObject(popupControl, index, null);
   this.OnRegisteredVisibleWindow(element);
  }
 },
 OnRegisteredVisibleWindow: function(element) {
  var elementIndex = ASPx.Data.ArrayIndexOf(this.visiblePopupWindowIds, element.id);
  if(this.PopupWindowIsModalByVisibleIndex(elementIndex))
   ASPx.PopupUtils.RemoveFocus(element);
 },
 UnregisterVisibleWindow: function(element) {
  this.DeleteWindowFromZIndexOrder(element);
  ASPx.Data.ArrayRemove(this.visiblePopupWindowIds, element.id);
  var forceRecalculate = this.PopupWindowIsModalByID(element.id);
  this.RefreshTabIndexes(forceRecalculate);
  this.SkipCurrentActiveWindowElement(element);
 },
 UpdateWindowsStateCookie: function(id) {
  var pos = id.lastIndexOf(ASPx.PCWIdSuffix);
  var name = id.substring(0, pos);
  var popupControl = aspxGetPopupControlCollection().Get(name);
  if(popupControl != null)
   popupControl.UpdateWindowsStateCookie(false);
 },
 AutoUpdateElementsPosition: function() {
  for(var i = 0; i < this.visiblePopupWindowIds.length; i++) {
   var popupWindow = this.GetPopupWindowFromID(this.visiblePopupWindowIds[i]);
   var popupControl = popupWindow.popupControl;
   if(popupControl != null && popupControl.InternalIsWindowVisible(popupWindow.windowIndex))
    popupControl.TryAutoUpdatePosition(popupWindow.windowIndex);
  }
 },
 LockWindowResizeByBodyScrollVisibilityChanging: function() {
  this.windowResizeByBodyScrollVisibilityChangingLockCount++;
 },
 UnlockWindowResizeByBodyScrollVisibilityChanging: function() {
  this.windowResizeByBodyScrollVisibilityChangingLockCount--;
 },
 WindowResizeByBodyScrollVisibilityChangingLocked: function() {
  return this.windowResizeByBodyScrollVisibilityChangingLockCount > 0;
 },
 HideAllWindows: function() {
  this.DoHideAllWindows(null, "", true, ASPxClientPopupControlCloseReason.API);
 }
});
var ASPxClientPopupControlResizeState = {
 Resized: 0,
 Collapsed: 1,
 Expanded: 2,
 Maximized: 3,
 RestoredAfterMaximized: 4
};
var ASPxClientPopupControlCloseReason = {
 API: "API",
 CloseButton: "CloseButton",
 OuterMouseClick: "OuterMouseClick",
 MouseOut: "MouseOut",
 Escape: "Escape"
};
var popupControlCollection = null;
function aspxGetPopupControlCollection() {
 if(popupControlCollection == null)
  popupControlCollection = new ASPxClientPopupControlCollection();
 return popupControlCollection;
}
function _aspxPopupWindow(popupControl, windowIndex) {
 this.popupControl = popupControl;
 this.windowIndex = windowIndex;
}
function _aspxScrollDifference(horizontal, vertical) {
 this.horizontal = horizontal;
 this.vertical = vertical;
}
function aspxPWEMOver(evt) {
 aspxGetPopupControlCollection().OnPWMouseOver(evt);
}
ASPx.PWHMDown = function(evt) {
 return ASPx.Evt.CancelBubble(evt);
}
ASPx.PWCBClick = function(evt, name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if(pc != null) pc.OnPWHBClickCore(evt, index, "OnCloseButtonClick");
}
ASPx.PWPBClick = function(evt, name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if(pc != null) pc.OnPWHBClickCore(evt, index, "OnPinButtonClick");
}
ASPx.PWRBClick = function(evt, name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if(pc != null) pc.OnPWHBClickCore(evt, index, "OnRefreshButtonClick");
}
ASPx.PWMNBClick = function(evt, name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if(pc != null) pc.OnPWHBClickCore(evt, index, "OnCollapseButtonClick");
}
ASPx.PWMXBClick = function(evt, name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if(pc != null) pc.OnPWHBClickCore(evt, index, "OnMaximizeButtonClick");
}
ASPx.PWDGMDown = function(evt, name, index) {
 return ASPx.PWMDown(evt, name, index, true);
}
ASPx.PWGripMDown = function(evt, name, index) {
 aspxPWMDownCore(evt, name, index, false);
 return ASPx.PWHMDown(evt);
}
ASPx.PWMMove = function(evt, name, index) {
 aspxGetPopupControlCollection().OnPWMouseMove(evt, name, index);
}
ASPx.PWMDown = function(evt, name, index, isWindowContentDraggingAllowed) {
 var pointOnScrollBar = false;
 var pc = aspxGetPopupControlCollection().Get(name);
 if(pc && pc.GetEnableContentScrolling(index)) {
  var rtl = pc.rtl && (ASPx.Browser.IE || ASPx.Browser.Firefox || ASPx.Browser.Opera);
  pointOnScrollBar = aspxPointOnElementScrollBar(pc.GetContentContainer(index), evt.clientX, evt.clientY, rtl);
 }
 aspxPWMDownCore(evt, name, index, isWindowContentDraggingAllowed, pointOnScrollBar);
 if(isWindowContentDraggingAllowed) { 
  aspxGetPopupControlCollection().OnDocumentMouseDown(evt); 
  if(typeof (ASPx.GetDropDownCollection) == "function")
   ASPx.GetDropDownCollection().OnDocumentMouseDown(evt); 
  if(!pointOnScrollBar) {
   if(!ASPx.Browser.WebKitTouchUI && ASPx.Evt.GetEventSource(evt).tagName == "IMG") 
    ASPx.Evt.PreventEvent(evt);
  }
 }
}
function aspxPWMDownCore(evt, name, index, isDraggingAllowed, pointOnScrollBar) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if(pc != null) {
  pc.OnActivateMouseDown(evt, index);
  pc.OnMouseDown(evt, index, isDraggingAllowed, pointOnScrollBar);
 }
}
function aspxPWMEMDown(evt) {
 var internalScrollableModalDiv = ASPx.Browser.AndroidDefaultBrowser ? ASPx.Evt.GetEventSource(evt) : null;
 var modalDiv = internalScrollableModalDiv ? internalScrollableModalDiv.parentNode : ASPx.Evt.GetEventSource(evt);
 if(modalDiv != null) 
  modalDiv.DXModalPopupControl.OnMouseDownModalElement(evt, modalDiv.DXModalPopupWindowIndex);
}
function aspxPEMEvent(evt) {
 var element = ASPx.PopupUtils.FindEventSourceParentByTestFunc(evt, aspxTestPopupControlElement);
 if(element != null) {
  var popupControl = element.DXPopupElementControl;
  var index = element.DXPopupWindowIndex;
  if(evt.type == "mousedown") {
   popupControl.SetIsPopuped(index, popupControl.InternalIsWindowVisible(index));
   aspxGetPopupControlCollection().OnMouseDown(evt);
  }
  else {
   var windowPopupAction = popupControl.GetWindowPopupAction(element.DXPopupWindowIndex);
   var leftMouseButtonAction = windowPopupAction == "LeftMouseClick" && ASPx.Evt.IsLeftButtonPressed(evt);
   var rightMouseButtonAction = windowPopupAction == "RightMouseClick" && !ASPx.Evt.IsLeftButtonPressed(evt);
   if(leftMouseButtonAction || rightMouseButtonAction) {
    if(rightMouseButtonAction)
     ASPx.PopupUtils.PreventContextMenu(evt);
    var windowCloseAction = popupControl.GetWindowCloseAction(index);
    var isPopuped = popupControl.GetIsPopuped(index);
    var isNewPopupElement = popupControl.GetLastShownPopupElementIndex(index) != element.DXPopupElementIndex;
    if(isPopuped && isNewPopupElement) {
     popupControl.DoHideWindow(index, false, ASPxClientPopupControlCloseReason.OuterMouseClick);
     aspxGetPopupControlCollection().ClearDisappearTimer();
     isPopuped = false;
    }
    if(!(isPopuped && windowCloseAction == "OuterMouseClick")) {
     popupControl.DoShowWindow(index, element.DXPopupElementIndex, evt);
    }
    if(windowCloseAction == "MouseOut")
     aspxGetPopupControlCollection().InitOverObject(popupControl, element.DXPopupWindowIndex, evt);
    return false;
   }
  }
 }
}
function aspxPointOnElementScrollBar(element, x, y, rtl) {
 var scrollWidth = ASPx.GetVerticalScrollBarWidth();
 var hasHorizontalScroll = element.scrollWidth > element.clientWidth;
 var hasVerticalScroll = element.scrollHeight > element.clientHeight;
 var ceilX = rtl ? ASPx.GetAbsoluteX(element) + scrollWidth :
  ASPx.GetAbsoluteX(element) + (element.offsetWidth - ASPx.GetHorizontalBordersWidth(element));
 var ceilY = ASPx.GetAbsoluteY(element) + (element.offsetHeight - ASPx.GetVerticalBordersWidth(element));
 return (hasVerticalScroll && x >= ceilX - scrollWidth && x <= ceilX) ||
   (hasHorizontalScroll && y >= ceilY - scrollWidth && y <= ceilY);
}
ASPx.PCAStop = function(name, index) {
 var pc = aspxGetPopupControlCollection().Get(name);
 if(pc != null) pc.OnAnimationStop(index);
}
ASPx.PCIframeLoad = function(evt) {
 var srcElement = ASPx.Evt.GetEventSource(evt);
 if(srcElement) {
  var pcName = srcElement.popupControlName;
  var pcWndIndex = srcElement.pcWndIndex;
  if(pcName) {
   var pc = aspxGetPopupControlCollection().Get(pcName);
   if(pc) pc.OnIFrameLoad(pcWndIndex);
  }
 }
}
function aspxTestPopupWindowElement(element) {
 return !!element.DXPopupWindowElement;
}
function aspxTestPopupControlElement(element) {
 return element.DXPopupElementControl && ASPx.IsExists(element.DXPopupWindowIndex);
}
function aspxTestPopupControlOverElement(element) {
 var collection = aspxGetPopupControlCollection();
 var popupControl = collection.overControl;
 var index = collection.overWindowIndex;
 var windowId = popupControl.GetWindowElementId(index);
 if(element.id == windowId)
  return true;
 var popupElements = popupControl.GetPopupElementList(index);
 for(var i = 0; i < popupElements.length; i++)
  if(popupElements[i] == element)
   return true;
 return false;
}
ASPx.Evt.AttachEventToDocument("keydown", function(evt) {
 aspxGetPopupControlCollection().OnDocumentKeyDown(evt);
});
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseDownEventName, function(evt) {
 aspxGetPopupControlCollection().OnDocumentMouseDown(evt);
});
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseUpEventName, function(evt) {
 return aspxGetPopupControlCollection().OnMouseUp(evt);
});
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseMoveEventName, function(evt) {
 if(typeof (aspxGetPopupControlCollection) != "undefined")
  aspxGetPopupControlCollection().OnMouseMove(evt);
});
ASPx.Evt.AttachEventToDocument("mouseout", function(evt) {
 if(typeof (aspxGetPopupControlCollection) != "undefined")
  aspxGetPopupControlCollection().OnMouseOut(evt);
});
ASPx.Evt.AttachEventToElement(window, ASPx.Browser.MacOSMobilePlatform ? "orientationchange" : "resize", function(evt) {
 aspxGetPopupControlCollection().OnResize(evt);
});
ASPx.Evt.AttachEventToElement(window, "scroll", function(evt) {
 aspxGetPopupControlCollection().OnScroll(evt);
});
ASPx.Evt.AttachEventToDocument("selectstart", function(evt) {
 var ret = aspxGetPopupControlCollection().OnSelectStart(evt);
 if(!ret) return false; 
});
window.ASPxClientPopupControl = ASPxClientPopupControl;
window.ASPxClientPopupWindow = ASPxClientPopupWindow;
window.ASPxClientPopupWindowEventArgs = ASPxClientPopupWindowEventArgs;
window.ASPxClientPopupWindowCancelEventArgs = ASPxClientPopupWindowCancelEventArgs;
window.ASPxClientPopupWindowResizeEventArgs = ASPxClientPopupWindowResizeEventArgs;
window.ASPxClientPopupWindowPinnedChangedEventArgs = ASPxClientPopupWindowPinnedChangedEventArgs;
window.ASPxClientPopupControlCollection = ASPxClientPopupControlCollection;
window.ASPxClientPopupControlResizeState = ASPxClientPopupControlResizeState;
window.ASPxClientPopupControlCloseReason = ASPxClientPopupControlCloseReason;
ASPx.GetPopupControlCollection = aspxGetPopupControlCollection;
ASPx.PopupControlCssClasses = PopupControlCssClasses;
})();
