(function () {
var PopupUtils = {
 NotSetAlignIndicator: "NotSet",
 InnerAlignIndicator: "Sides",
 OutsideLeftAlignIndicator: "OutsideLeft",
 LeftSidesAlignIndicator: "LeftSides",
 RightSidesAlignIndicator: "RightSides",
 OutsideRightAlignIndicator: "OutsideRight",
 CenterAlignIndicator: "Center",
 AboveAlignIndicator: "Above",
 TopSidesAlignIndicator: "TopSides",
 MiddleAlignIndicator: "Middle",
 BottomSidesAlignIndicator: "BottomSides",
 BelowAlignIndicator: "Below",
 IsAlignNotSet: function (align) {
  return align == PopupUtils.NotSetAlignIndicator;
 },
 IsInnerAlign: function (align) {
  return align.indexOf(PopupUtils.InnerAlignIndicator) != -1;
 },
 IsRightSidesAlign: function(align) {
  return align == PopupUtils.RightSidesAlignIndicator;
 },
 IsOutsideRightAlign: function(align) {
  return align == PopupUtils.OutsideRightAlignIndicator;
 },
 IsCenterAlign: function(align) {
  return align == PopupUtils.CenterAlignIndicator;
 },
 FindPopupElementById: function (id) {
  if(id == "")
   return null; 
  var popupElement = ASPx.GetElementById(id);
  if(!ASPx.IsExistsElement(popupElement)) {
   var idParts = id.split("_");
   var uniqueId = idParts.join("$");
   popupElement = ASPx.GetElementById(uniqueId);
  }
  return popupElement;
 },
 FindEventSourceParentByTestFunc: function (evt, testFunc) {
  return ASPx.GetParent(ASPx.Evt.GetEventSource(evt), testFunc);
 },
 PreventContextMenu: function (evt) {
  if(evt.stopPropagation)
   evt.stopPropagation();
  if(evt.preventDefault)
   evt.preventDefault();
  if(ASPx.Browser.WebKitFamily)
   evt.returnValue = false;
 },
 GetDocumentClientWidthForPopup: function () {
  return ASPx.Browser.WebKitTouchUI ? ASPx.GetDocumentWidth() : ASPx.GetDocumentClientWidth(); 
 },
 GetDocumentClientHeightForPopup: function() {
  return ASPx.Browser.WebKitTouchUI ? ASPx.GetDocumentHeight() : ASPx.GetDocumentClientHeight(); 
 },
 AdjustPositionToClientScreen: function (element, pos, rtl, isX) {
  var min = isX ? ASPx.GetDocumentScrollLeft() : ASPx.GetDocumentScrollTop(),
   viewPortWidth = ASPx.Browser.WebKitTouchUI ? window.innerWidth : ASPx.GetDocumentClientWidth(),
   max = min + (isX ? viewPortWidth : ASPx.GetDocumentClientHeight());
  max -= (isX ? element.offsetWidth : element.offsetHeight);
  if(rtl) {
   if(pos < min) pos = min;
   if(pos > max) pos = max;
  } else {
   if(pos > max) pos = max;
   if(pos < min) pos = min;
  }
  return pos;
 },
 GetPopupAbsoluteX: function (element, popupElement, hAlign, hOffset, x, left, rtl, isPopupFullCorrectionOn) {
  var width = element.offsetWidth;
  var bodyWidth = ASPx.GetDocumentClientWidth();
  var elementX = ASPx.GetAbsoluteX(popupElement);
  var scrollX = ASPx.GetDocumentScrollLeft();
  if(hAlign == "WindowCenter") {
   var showAtPos = x != ASPx.InvalidPosition && !popupElement;
   if(showAtPos)
    hAlign = "";
   else
    return new ASPx.PopupPosition(Math.ceil((ASPx.Browser.WebKitTouchUI ? window.innerWidth : bodyWidth) / 2 - width / 2) + scrollX + hOffset, false);
  }
  if(popupElement) {
   var leftX = elementX - width;
   var rightX = elementX + popupElement.offsetWidth;
   var innerLeftX = elementX;
   var innerRightX = elementX + popupElement.offsetWidth - width;
   var isMoreFreeSpaceLeft = bodyWidth - (rightX + width) < leftX - 2 * scrollX;
  }
  else
   hAlign = "";
  var isInverted = false;
  if(hAlign == PopupUtils.OutsideLeftAlignIndicator) {
   isInverted = isPopupFullCorrectionOn && (!(leftX - scrollX > 0 || isMoreFreeSpaceLeft));
   if(isInverted)
    x = rightX - hOffset;
   else
    x = leftX + hOffset;
  }
  else if(hAlign == PopupUtils.LeftSidesAlignIndicator) {
   x = innerLeftX + hOffset;
   if(isPopupFullCorrectionOn)
    x = PopupUtils.AdjustPositionToClientScreen(element, x, rtl, true);
  }
  else if(hAlign == PopupUtils.CenterAlignIndicator) {
   x = elementX + Math.round((popupElement.offsetWidth - width) / 2) + hOffset;
  }
  else if(hAlign == PopupUtils.RightSidesAlignIndicator) {
   x = innerRightX + hOffset;
   if(isPopupFullCorrectionOn)
    x = PopupUtils.AdjustPositionToClientScreen(element, x, rtl, true);
  }
  else if(hAlign == PopupUtils.OutsideRightAlignIndicator) {
   isInverted = isPopupFullCorrectionOn && (!(rightX + width < bodyWidth + scrollX || !isMoreFreeSpaceLeft));
   if(isInverted)
    x = leftX - hOffset;
   else
    x = rightX + hOffset;
  }
  else {
   if(rtl) {
    if(!ASPx.IsValidPosition(x)) {
     if(popupElement)
      x = innerRightX;
     else if(hOffset)
      x = 0;
     else
      x = left;
    }
    else
     x -= width;
    isInverted = isPopupFullCorrectionOn && (x < scrollX && x - scrollX < bodyWidth / 2);
    if(isInverted)
     x = x + width + hOffset;
    else
     x = x - hOffset;
   } else {
    if(!ASPx.IsValidPosition(x)) {
     if(popupElement)
      x = elementX;
     else if(hOffset)
      x = 0;
     else
      x = left;
    }
    isInverted = isPopupFullCorrectionOn && (x - scrollX + width > bodyWidth && x - scrollX > bodyWidth / 2);
    if(isInverted)
     x = x - width - hOffset;
    else
     x = x + hOffset;
   }
  }
  return new ASPx.PopupPosition(x, isInverted);
 },
 GetPopupAbsoluteY: function (element, popupElement, vAlign, vOffset, y, top, isPopupFullCorrectionOn) {
  var height = element.offsetHeight;
  var bodyHeight = ASPx.GetDocumentClientHeight();
  var elementY = ASPx.GetAbsoluteY(popupElement);
  var scrollY = ASPx.GetDocumentScrollTop();
  if(vAlign == "WindowCenter") {
   var showAtPos = y != ASPx.InvalidPosition && !popupElement;
   if(showAtPos)
    hAlign = "";
   else
    return new ASPx.PopupPosition(Math.ceil((ASPx.Browser.WebKitTouchUI ? window.innerHeight : bodyHeight) / 2 - height / 2) + scrollY + vOffset, false);
  }
  if(popupElement) {
   var bottomY = elementY + popupElement.offsetHeight;
   var topY = elementY - height;
   var innerBottomY = elementY + popupElement.offsetHeight - height;
   var innerTopY = elementY;
   var isMoreFreeSpaceAbove = bodyHeight - (bottomY + height) < topY - 2 * scrollY;
  }
  else
   vAlign = "";
  var isInverted = false;
  if(vAlign == PopupUtils.AboveAlignIndicator) {
   isInverted = isPopupFullCorrectionOn && (!(topY - scrollY > 0 || isMoreFreeSpaceAbove));
   if(isInverted)
    y = bottomY - vOffset;
   else
    y = topY + vOffset;
  }
  else if(vAlign == PopupUtils.TopSidesAlignIndicator) {
   y = innerTopY + vOffset;
   if(isPopupFullCorrectionOn)
    y = PopupUtils.AdjustPositionToClientScreen(element, y, false, false);
  }
  else if(vAlign == PopupUtils.MiddleAlignIndicator) {
   y = elementY + Math.round((popupElement.offsetHeight - height) / 2) + vOffset;
  }
  else if(vAlign == PopupUtils.BottomSidesAlignIndicator) {
   y = innerBottomY + vOffset;
   if(isPopupFullCorrectionOn)
    y = PopupUtils.AdjustPositionToClientScreen(element, y, false, false);
  }
  else if(vAlign == PopupUtils.BelowAlignIndicator) {
   isInverted = isPopupFullCorrectionOn && (!(bottomY + height < bodyHeight + scrollY || !isMoreFreeSpaceAbove));
   if(isInverted)
    y = topY - vOffset;
   else
    y = bottomY + vOffset;
  }
  else {
   if(!ASPx.IsValidPosition(y)) {
    if(popupElement)
     y = ASPx.GetAbsoluteY(popupElement);
    else if(vOffset)
     y = 0;
    else
     y = top;
   }
   isInverted = isPopupFullCorrectionOn && (y - ASPx.GetDocumentScrollTop() + height > bodyHeight && y - ASPx.GetDocumentScrollTop() > bodyHeight / 2);
   if(isInverted)
    y = y - height - vOffset;
   else
    y = y + vOffset;
  }
  return new ASPx.PopupPosition(y, isInverted);
 },
 RemoveFocus: function (parent) {
  var div = document.createElement('div');
  div.tabIndex = "-1";
  PopupUtils.ConcealDivElement(div);
  parent.appendChild(div);
  if(ASPx.IsFocusable(div))
   div.focus();
  ASPx.RemoveElement(div);
 },
 ConcealDivElement: function (div) {
  div.style.position = "absolute";
  div.style.left = 0;
  div.style.top = 0;
  if(ASPx.Browser.WebKitFamily) {
   div.style.opacity = 0;
   div.style.width = 1;
   div.style.height = 1;
  } else {
   div.style.border = 0;
   div.style.width = 0;
   div.style.height = 0;
  }
 },
 InitAnimationDiv: function (element, x, y, onAnimStopCallString, skipSizeInit) {
  PopupUtils.InitAnimationDivCore(element);
  element.popuping = true;
  element.onAnimStopCallString = onAnimStopCallString;
  if(!skipSizeInit)
   ASPx.SetStyles(element, { width: element.offsetWidth, height: element.offsetHeight });
  ASPx.SetStyles(element, { left: x, top: y });
 },
 InitAnimationDivCore: function (element) {
  ASPx.SetStyles(element, {
   overflow: "hidden",
   position: "absolute"
  });
 },
 StartSlideAnimation: function (animationDivElement, element, iframeElement, duration, preventChangingWidth, preventChangingHeight) {
  if(iframeElement) {
   var endLeft = ASPx.PxToInt(iframeElement.style.left);
   var endTop = ASPx.PxToInt(iframeElement.style.top);
   var startLeft = ASPx.PxToInt(element.style.left) < 0 ? endLeft : animationDivElement.offsetLeft + animationDivElement.offsetWidth;
   var startTop = ASPx.PxToInt(element.style.top) < 0 ? endTop : animationDivElement.offsetTop + animationDivElement.offsetHeight;
   var properties = {
    left: { from: startLeft, to: endLeft, unit: "px" },
    top: { from: startTop, to: endTop, unit: "px" }
   };
   if(!preventChangingWidth)
    properties["width"] = { to: element.offsetWidth, unit: "px" };
   if(!preventChangingHeight)
    properties["height"] = { to: element.offsetHeight, unit: "px" };
   ASPx.AnimationHelper.createMultipleAnimationTransition(iframeElement, {
    duration: duration
   }).Start(properties);
  }
  ASPx.AnimationHelper.createMultipleAnimationTransition(element, {
   duration: duration,
   onComplete: function () { PopupUtils.AnimationFinished(animationDivElement, element); }
  }).Start({
   left: { to: 0, unit: "px" },
   top: { to: 0, unit: "px" }
  });
 },
 AnimationFinished: function (animationDivElement, element) {
  if(PopupUtils.StopAnimation(animationDivElement, element) && ASPx.IsExists(animationDivElement.onAnimStopCallString) &&
   animationDivElement.onAnimStopCallString !== "") {
   window.setTimeout(animationDivElement.onAnimStopCallString, 0);
  }
 },
 StopAnimation: function (animationDivElement, element) {
  if(animationDivElement.popuping) {
   ASPx.AnimationHelper.cancelAnimation(element);
   animationDivElement.popuping = false;
   animationDivElement.style.overflow = "visible";
   return true;
  }
  return false;
 },
 GetAnimationHorizontalDirection: function (popupPosition, horizontalAlign, verticalAlign, rtl) {
  if(PopupUtils.IsInnerAlign(horizontalAlign)
   && !PopupUtils.IsInnerAlign(verticalAlign)
   && !PopupUtils.IsAlignNotSet(verticalAlign))
   return 0;
  var toTheLeft = (horizontalAlign == PopupUtils.OutsideLeftAlignIndicator || horizontalAlign == PopupUtils.RightSidesAlignIndicator || (horizontalAlign == PopupUtils.NotSetAlignIndicator && rtl)) ^ popupPosition.isInverted;
  return toTheLeft ? 1 : -1;
 },
 GetAnimationVerticalDirection: function (popupPosition, horizontalAlign, verticalAlign) {
  if(PopupUtils.IsInnerAlign(verticalAlign)
   && !PopupUtils.IsInnerAlign(horizontalAlign)
   && !PopupUtils.IsAlignNotSet(horizontalAlign))
   return 0;
  var toTheTop = (verticalAlign == PopupUtils.AboveAlignIndicator || verticalAlign == PopupUtils.BottomSidesAlignIndicator) ^ popupPosition.isInverted;
  return toTheTop ? 1 : -1;
 },
 IsVerticalScrollExists: function () {
  var scrollIsNotHidden = ASPx.GetCurrentStyle(document.body).overflowY !== "hidden" && ASPx.GetCurrentStyle(document.documentElement).overflowY !== "hidden";
  return (scrollIsNotHidden && ASPx.GetDocumentHeight() > ASPx.GetDocumentClientHeight());
 },
 CoordinatesInDocumentRect: function (x, y) {
  var docScrollLeft = ASPx.GetDocumentScrollLeft();
  var docScrollTop = ASPx.GetDocumentScrollTop();
  return (x > docScrollLeft && y > docScrollTop &&
   x < ASPx.GetDocumentClientWidth() + docScrollLeft &&
   y < ASPx.GetDocumentClientHeight() + docScrollTop);
 },
 GetElementZIndexArray: function (element) {
  var currentElement = element;
  var zIndexesArray = [0];
  while(currentElement && currentElement.tagName != "BODY") {
   if(currentElement.style) {
    if(typeof (currentElement.style.zIndex) != "undefined" && currentElement.style.zIndex != "")
     zIndexesArray.unshift(currentElement.style.zIndex);
   }
   currentElement = currentElement.parentNode;
  }
  return zIndexesArray;
 },
 IsHigher: function (higherZIndexArrat, zIndexArray) {
  if(zIndexArray == null) return true;
  var count = (higherZIndexArrat.length >= zIndexArray.length) ? higherZIndexArrat.length : zIndexArray.length;
  for(var i = 0; i < count; i++)
   if(typeof (higherZIndexArrat[i]) != "undefined" && typeof (zIndexArray[i]) != "undefined") {
    var higherZIndexArrayCurrentElement = parseInt(higherZIndexArrat[i].toString());
    var zIndexArrayCurrentElement = parseInt(zIndexArray[i].toString());
    if(higherZIndexArrayCurrentElement != zIndexArrayCurrentElement)
     return higherZIndexArrayCurrentElement > zIndexArrayCurrentElement;
   } else return typeof (zIndexArray[i]) == "undefined";
  return true;
 },
 TestIsPopupElement: function (element) {
  return !!element.DXPopupElementControl;
 }
}
PopupUtils.OverControl = {
 GetPopupElementByEvt: function (evt) {
  return PopupUtils.FindEventSourceParentByTestFunc(evt, PopupUtils.TestIsPopupElement);
 },
 OnMouseEvent: function (evt, mouseOver) {
  var popupElement = PopupUtils.OverControl.GetPopupElementByEvt(evt);
  if(mouseOver)
   popupElement.DXPopupElementControl.OnPopupElementMouseOver(evt, popupElement);
  else
   popupElement.DXPopupElementControl.OnPopupElementMouseOut(evt, popupElement);
 },
 OnMouseOut: function (evt) {
  PopupUtils.OverControl.OnMouseEvent(evt, false);
 },
 OnMouseOver: function (evt) {
  PopupUtils.OverControl.OnMouseEvent(evt, true);
 }
}
PopupUtils.BodyScrollHelper = (function () {
 var windowScrollLock = {};
 function lockWindowScroll(windowId) {
  windowScrollLock[windowId] = true;
 }
 function unlockWindowScroll(windowId) {
  windowScrollLock[windowId] = false;
 }
 function isAnyWindowScrollLocked() {
  for(var key in windowScrollLock) 
   if(windowScrollLock[key])
    return true;
  return false;
 }
 function fixScrollsBug() {
  var scrollTop = document.body.scrollTop;
  var scrollLeft = document.body.scrollLeft;
  document.body.scrollTop++;
  document.body.scrollTop--;
  document.body.scrollLeft++;
  document.body.scrollLeft--;
  document.body.scrollLeft = scrollLeft;
  document.body.scrollTop = scrollTop;
 }
 return {
  HideBodyScroll: function(windowId) {
   if(ASPx.Browser.WebKitTouchUI)
    return;
   if(isAnyWindowScrollLocked()) { 
    lockWindowScroll(windowId);
    return;
   }
   lockWindowScroll(windowId);
   var verticalScrollMustBeReplacedByMargin = PopupUtils.IsVerticalScrollExists();
   if(ASPx.Browser.IE) {
    ASPx.Attr.ChangeAttribute(document.body, "scroll", "no");
    ASPx.Attr.ChangeStyleAttribute(document.documentElement, "overflow", "hidden");
   } else if(ASPx.Browser.Firefox && ASPx.Browser.Version < 3) { 
    var scrollTop = document.documentElement.scrollTop;
    ASPx.Attr.ChangeStyleAttribute(document.body, "overflow", "hidden");
    document.documentElement.scrollTop = scrollTop;
   } else {
    ASPx.Attr.ChangeStyleAttribute(document.documentElement, "overflow", "hidden");
    var documentHeight = ASPx.GetDocumentHeight();
    var documentWidth = ASPx.GetDocumentWidth();
    if(window.pageYOffset > 0 && ASPx.PxToInt(window.getComputedStyle(document.body, null)) != documentHeight)
     ASPx.Attr.ChangeStyleAttribute(document.body, "height", documentHeight + "px");
    if(window.pageXOffset > 0 && ASPx.PxToInt(window.getComputedStyle(document.body, null)) != documentWidth)
     ASPx.Attr.ChangeStyleAttribute(document.body, "width", documentWidth + "px");
    if(ASPx.Browser.Chrome) {
     fixScrollsBug();
    }
   }
   if(verticalScrollMustBeReplacedByMargin) {
    var currentBodyStyle = ASPx.GetCurrentStyle(document.body),
     marginWidth = ASPx.GetVerticalScrollBarWidth() + ASPx.PxToInt(currentBodyStyle.marginRight);
    ASPx.Attr.ChangeStyleAttribute(document.body, "margin-right", marginWidth + "px");
   }
  },
  RestoreBodyScroll: function (windowId) {
   if(ASPx.Browser.WebKitTouchUI)
    return;
   unlockWindowScroll(windowId);
   if(isAnyWindowScrollLocked())
    return;
   if(ASPx.Browser.IE) {
    ASPx.Attr.RestoreAttribute(document.body, "scroll");
    ASPx.Attr.RestoreStyleAttribute(document.documentElement, "overflow");
   } else {
    ASPx.Attr.RestoreStyleAttribute(document.documentElement, "overflow");
   }
   ASPx.Attr.RestoreStyleAttribute(document.body, "margin-right");
   ASPx.Attr.RestoreStyleAttribute(document.body, "height");
   ASPx.Attr.RestoreStyleAttribute(document.body, "width");
   if(ASPx.Browser.WebKitFamily) { 
    fixScrollsBug();
   }
  }
 }
})();
ASPx.PopupPosition = function(position, isInverted) {
 this.position = position;
 this.isInverted = isInverted;
}
ASPx.PopupSize = function(width, height) {
 this.width = width;
 this.height = height;
}
ASPx.PopupUtils = PopupUtils;
})();
