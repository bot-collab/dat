(function() {
ASPx.currentDragHelper = null;
var currentCursorTargets = null;
var DragHelper = ASPx.CreateClass(null, {
 constructor: function(e, root, clone){
  if(ASPx.currentDragHelper != null) ASPx.currentDragHelper.cancelDrag();
  this.dragArea = 5;
  this.clickX = ASPx.Evt.GetEventX(e);
  this.clickY = ASPx.Evt.GetEventY(e);
  this.centerClone = false;
  this.cachedCloneWidth = -1;
  this.cachedCloneHeight = -1;
  this.cachedOriginalX = -1;
  this.cachedOriginalY = -1;
  this.canDrag = true; 
  if(typeof(root) == "string") 
   root = ASPx.GetParentByTagName(ASPx.Evt.GetEventSource(e), root);
  this.obj = root && root != null ? root : ASPx.Evt.GetEventSource(e);
  this.clone = clone;
  this.dragObj = null; 
  this.additionalObj = null;
  this.onDoClick = null;
  this.onEndDrag = null;
  this.onCancelDrag = null;
  this.onDragDivCreating = null;
  this.onCloneCreating = null;
  this.onCloneCreated = null;
  this.dragDiv = null;
  ASPx.currentDragHelper = this;
  this.clearSelectionOnce = false;
 }, 
 drag: function(e) {
  if(!this.canDrag) return;
  ASPx.Selection.Clear();
  if(!this.isDragging()) {
   if(!this.isOutOfDragArea(e)) 
    return;
   this.startDragCore(e);
  }
  if(ASPx.Browser.IE && !ASPx.Evt.IsLeftButtonPressed(e)) {
   this.cancelDrag(e);
   return;
  }
  if(!ASPx.Browser.IE)
   ASPx.Selection.SetElementSelectionEnabled(document.body, false);
  this.dragCore(e);
 },
 startDragCore: function(e) {  
  this.dragObj = this.clone != true ? this.obj : this.createClone(e);
 },
 dragCore: function(e) { 
  this.updateDragDivPosition(e);
 },
 endDrag: function(e) { 
  if(!this.isDragging() && !this.isOutOfDragArea(e)) {
   if(this.onDoClick)
    this.onDoClick(this, e);
  } else {
   if(this.onEndDrag)
    this.onEndDrag(this, e);
  }
  this.cancelDrag();
 },
 cancel: function(){
  this.cancelDrag();
 },
 cancelDrag: function() {
  if(this.dragDiv != null) {
   document.body.removeChild(this.dragDiv);
   this.dragDiv = null;
  }
  if(this.onCancelDrag)
   this.onCancelDrag(this);
  ASPx.currentDragHelper = null;
  if(!ASPx.Browser.IE)
   ASPx.Selection.SetElementSelectionEnabled(document.body, true);
 },
 isDragging: function() {    
  return this.dragObj != null;
 },
 updateDragDivPosition: function(e) {
  if(this.centerClone) {
   this.dragDiv.style.left = ASPx.Evt.GetEventX(e) - this.cachedCloneWidth / 2 + "px";
   this.dragDiv.style.top = ASPx.Evt.GetEventY(e) - this.cachedCloneHeight / 2 + "px";
  } else {
   this.dragDiv.style.left = this.cachedOriginalX + ASPx.Evt.GetEventX(e) - this.clickX + "px";
   this.dragDiv.style.top = this.cachedOriginalY + ASPx.Evt.GetEventY(e) - this.clickY + "px";
  }
 },
 createClone: function(e) {
  this.dragDiv = document.createElement("div");
  if(this.onDragDivCreating)
   this.onDragDivCreating(this, this.dragDiv);
  var clone = this.creatingClone();  
  this.dragDiv.appendChild(clone);
  document.body.appendChild(this.dragDiv);
  this.dragDiv.style.position = "absolute";    
  this.dragDiv.style.cursor = "move";
  this.dragDiv.style.borderStyle = "none";
  this.dragDiv.style.padding = "0";
  this.dragDiv.style.margin = "0";
  this.dragDiv.style.backgroundColor = "transparent";
  this.dragDiv.style.zIndex = 20000; 
  if(this.onCloneCreated)
   this.onCloneCreated(clone);
  this.cachedCloneWidth = clone.offsetWidth;
  this.cachedCloneHeight = clone.offsetHeight;
  if(!this.centerClone) {  
   this.cachedOriginalX = ASPx.GetAbsoluteX(this.obj);
   this.cachedOriginalY = ASPx.GetAbsoluteY(this.obj);
  }
  this.dragDiv.style.width = this.cachedCloneWidth + "px";
  this.dragDiv.style.height = this.cachedCloneHeight + "px";
  this.updateDragDivPosition(e);
  return this.dragDiv;
 },
 creatingClone: function() {
  var clone = this.obj.cloneNode(true);
  var scripts = ASPx.GetNodesByTagName(clone, "SCRIPT");
  for(var i = scripts.length - 1; i >= 0; i--)
   ASPx.RemoveElement(scripts[i]);
  if(!this.onCloneCreating) return clone;
  return this.onCloneCreating(clone);
 },
 addElementToDragDiv: function(element) {
  if(this.dragDiv == null) return;
  this.additionalObj = element.cloneNode(true);
  this.additionalObj.style.visibility = "visible";
  this.additionalObj.style.display = "";
  this.additionalObj.style.top = "";
  this.dragDiv.appendChild(this.additionalObj);
 },
 removeElementFromDragDiv: function() {
  if(this.additionalObj == null || this.dragDiv == null) return;
  this.dragDiv.removeChild(this.additionalObj);
  this.additionalObj = null;
 },
 isOutOfDragArea: function(e) {
  return Math.max(
   Math.abs(ASPx.Evt.GetEventX(e) - this.clickX), 
   Math.abs(ASPx.Evt.GetEventY(e) - this.clickY)
  ) >= this.dragArea;
 }
});
var CursorTargets = ASPx.CreateClass(null, {
 constructor: function() {
  this.list = [];
  this.oldtargetElement = null;
  this.oldtargetTag = 0;
  this.targetElement = null;
  this.targetTag = 0;
  this.x = 0;
  this.y = 0;
  this.removedX = 0;
  this.removedY = 0;
  this.removedWidth = 0;
  this.removedHeight = 0;
  this.onTargetCreated = null;
  this.onTargetChanging = null;
  this.onTargetChanged = null;
  this.onTargetAdding = null;
  this.onTargetAllowed = null;
  currentCursorTargets = this;
 },
 addElement: function(element) {
  if(!this.canAddElement(element)) return null;
  var target = new CursorTarget(element);
  this.onTargetCreated && this.onTargetCreated(this, target);
  this.list.push(target);
  return target;
 },
 removeElement: function(element) {
  for(var i = 0; i < this.list.length; i++) {
   if(this.list[i].element == element) {
    this.list.splice(i, 1);
    return;
   }
  }
 },
 addParentElement: function(parent, child) {
  var target = this.addElement(parent);
  if(target != null) {
   target.targetElement = child;
  }
  return target;
 },
 RegisterTargets: function(element, idPrefixArray) {
  this.addFunc = this.addElement;
  this.RegisterTargetsCore(element, idPrefixArray);
 },
 UnregisterTargets: function(element, idPrefixArray) {
  this.addFunc = this.removeElement;
  this.RegisterTargetsCore(element, idPrefixArray);
 },
 RegisterTargetsCore: function(element, idPrefixArray) {
  if(element == null) return;
  for(var i = 0; i < idPrefixArray.length; i++)
   this.RegisterTargetCore(element, idPrefixArray[i]);
 },
 RegisterTargetCore: function(element, idPrefix) {
  if(!ASPx.IsExists(element.id)) return;
  if(element.id.indexOf(idPrefix) > -1)
   this.addFunc(element);
  for(var i = 0; i < element.childNodes.length; i++)
   this.RegisterTargetCore(element.childNodes[i], idPrefix);
 },
 canAddElement: function(element) {
  if(element == null || !ASPx.GetElementDisplay(element))
   return false;
  for(var i = 0; i < this.list.length; i++) {
   if(this.list[i].targetElement == element) return false;
  }
  if(this.onTargetAdding != null && !this.onTargetAdding(this, element)) return false;
  return element.style.visibility != "hidden";
 },
 removeInitialTarget: function(x, y) {
  var el = this.getTarget(x + ASPx.GetDocumentScrollLeft(), y + ASPx.GetDocumentScrollTop());
  if(el == null) return;
  this.removedX = ASPx.GetAbsoluteX(el);
  this.removedY = ASPx.GetAbsoluteY(el);
  this.removedWidth = el.offsetWidth;
  this.removedHeight = el.offsetHeight;
 },
 getTarget: function(x, y) {
  for(var i = 0; i < this.list.length; i++) {
   var record = this.list[i];
   if(record.contains(x, y)) {
    if(!this.onTargetAllowed || this.onTargetAllowed(record.targetElement, x, y))
     return record.targetElement;
   }
  }
  return null;
 },
 targetChanged: function(element, tag) {
  this.targetElement = element;
  this.targetTag = tag;
  if(this.onTargetChanging)
   this.onTargetChanging(this);
  if(this.oldtargetElement != this.targetElement || this.oldtargetTag != this.targetTag) {
   if(this.onTargetChanged)
    this.onTargetChanged(this);
   this.oldtargetElement = this.targetElement;
   this.oldtargetTag = this.targetTag;
  }
 },
 cancelChanging: function() {
  this.targetElement = this.oldtargetElement;
  this.targetTag = this.oldtargetTag;
 },
 isLeftPartOfElement: function() {
  if(this.targetElement == null) return true;
  var left = this.x - this.targetElementX();
  return left < this.targetElement.offsetWidth / 2;
 },
 isTopPartOfElement: function() {
  if(this.targetElement == null) return true;
  var top = this.y - this.targetElementY();
  return top < this.targetElement.offsetHeight / 2;
 },
 targetElementX: function() {
  return this.targetElement != null ? ASPx.GetAbsoluteX(this.targetElement) : 0;
 },
 targetElementY: function() {
  return this.targetElement != null ? ASPx.GetAbsoluteY(this.targetElement) : 0;
 },
 onmousemove: function(e) {
  this.doTargetChanged(e);
 },
 onmouseup: function(e) {
  this.doTargetChanged(e);
  currentCursorTargets = null;
 },
 doTargetChanged: function(e) {
  this.x = ASPx.Evt.GetEventX(e);
  this.y = ASPx.Evt.GetEventY(e);
  if(this.inRemovedBounds(this.x, this.y)) return;
  this.targetChanged(this.getTarget(this.x, this.y), 0);
 },
 inRemovedBounds: function(x, y) {
  if(this.removedWidth == 0) return false;
  return x > this.removedX && x < (this.removedX + this.removedWidth) &&
   y > this.removedY && y < (this.removedY + this.removedHeight);
 }
});
var CursorTarget = ASPx.CreateClass(null, {
 constructor: function(element) {
  this.element = element;
  this.targetElement = element;
  this.UpdatePosition();
 },
 contains: function(x, y) {
  return x >= this.absoluteX && x <= this.absoluteX + this.GetElementWidth() &&
   y >= this.absoluteY && y <= this.absoluteY + this.GetElementHeight();
 },
 GetElementWidth: function() {
  return this.element.offsetWidth;
 },
 GetElementHeight: function() {
  return this.element.offsetHeight;
 },
 UpdatePosition: function() {
  this.absoluteX = ASPx.GetAbsoluteX(this.element);
  this.absoluteY = ASPx.GetAbsoluteY(this.element);
 }
});
if(ASPx.Browser.MSTouchUI)
 ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.pointerCancelEventName, function(e) {
  if(ASPx.currentDragHelper != null) {
   ASPx.currentDragHelper.cancel(e);
   return true;
  }
 });
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseUpEventName, function(e) {
  if(ASPx.currentDragHelper != null) {
   ASPx.currentDragHelper.endDrag(e);
   return true;
  }
});
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseMoveEventName, function(e) {
 if(ASPx.currentDragHelper != null && !(ASPx.Browser.WebKitTouchUI && ASPx.TouchUIHelper.isGesture)) {
  ASPx.currentDragHelper.drag(e);
  if(ASPx.TouchUIHelper.isTouchEvent(e) && ASPx.currentDragHelper.canDrag) {
   e.preventDefault();
   ASPx.TouchUIHelper.preventScrollOnEvent(e);
  }
  return true;
 }
});
ASPx.Evt.AttachEventToDocument("keydown", function(e) {
 if(!ASPx.currentDragHelper) return;
 if(e.keyCode == ASPx.Key.Esc)
  ASPx.currentDragHelper.cancelDrag();
 return true;
});
ASPx.Evt.AttachEventToDocument("keyup", function(e) {
 if (!ASPx.currentDragHelper) return;
 if(e.keyCode == ASPx.Key.Esc && ASPx.Browser.WebKitFamily)
  ASPx.currentDragHelper.cancelDrag();
 return true;
});
ASPx.Evt.AttachEventToDocument("selectstart", function(e) {
 var drag = ASPx.currentDragHelper;
 if(drag && (drag.canDrag || drag.clearSelectionOnce)) {
  ASPx.Selection.Clear();
  drag.clearSelectionOnce = false;
  return false;
 }
});
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseUpEventName, function(e) { 
 if(currentCursorTargets != null) {
  currentCursorTargets.onmouseup(e);
  return true;
 }
});
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseMoveEventName, function(e) {
 if(currentCursorTargets != null) {
  currentCursorTargets.onmousemove(e);
  return true;
 }
});
ASPx.DragHelper = DragHelper;
ASPx.CursorTargets = CursorTargets;
ASPx.CursorTarget = CursorTarget;
})();
