(function () {
 ASPx.EnableCssAnimation = true;
 var AnimationUtils = {
  CanUseCssTransition: function () { return ASPx.EnableCssAnimation && this.CurrentTransition },
  CanUseCssTransform: function () { return this.CanUseCssTransition() && this.CurrentTransform },
  CurrentTransition: (function () {
   if(ASPx.Browser.IE) 
    return null;
   var transitions = [
    { property: "webkitTransition", event: "webkitTransitionEnd" },
    { property: "MozTransition", event: "transitionend" },
    { property: "OTransition", event: "oTransitionEnd" },
    { property: "transition", event: "transitionend" }
   ]
   var fakeElement = document.createElement("DIV");
   for(var i = 0; i < transitions.length; i++)
    if(transitions[i].property in fakeElement.style)
     return transitions[i];
  })(),
  CurrentTransform: (function () {
   var transforms = ["transform", "MozTransform", "-webkit-transform", "msTransform", "OTransform"];
   var fakeElement = document.createElement("DIV");
   for(var i = 0; i < transforms.length; i++)
    if(transforms[i] in fakeElement.style)
     return transforms[i];
  })(),
  SetTransformValue: function (element, position, isTop) {
   if(this.CanUseCssTransform())
    element.style[this.CurrentTransform] = this.GetTransformCssText(position, isTop);
   else
    element.style[!isTop ? "left" : "top"] = position + "px";
  },
  GetTransformValue: function (element, isTop) {
   if(this.CanUseCssTransform()) {
    var cssValue = element.style[this.CurrentTransform];
    return cssValue ? Number(cssValue.replace('matrix(1, 0, 0, 1,', '').replace(')', '').split(',')[!isTop ? 0 : 1]) : 0;
   }
   else
    return !isTop ? element.offsetLeft : element.offsetTop;
  },
  GetTransformCssText: function (position, isTop) {
   return "matrix(1, 0, 0, 1," + (!isTop ? position : 0) + ", " + (!isTop ? 0 : position) + ")";
  }
 };
 var AnimationTransitionBase = ASPx.CreateClass(null, {
  constructor: function (element, options) {
   if(element) {
    AnimationTransitionBase.Cancel(element);
    this.element = element;
    this.element.aspxTransition = this;
   }
   this.duration = options.duration || AnimationConstants.Durations.DEFAULT;
   this.transition = options.transition || AnimationConstants.Transitions.SINE;
   this.property = options.property;
   this.unit = options.unit || "";
   this.onComplete = options.onComplete;
   this.to = null;
   this.from = null;
  },
  Start: function (from, to) {
   if(to != undefined) {
    this.to = to;
    this.from = from;
    this.SetValue(this.from);
   }
   else
    this.to = from;
  },
  Cancel: function () {
   if(!this.element)
    return;
   try {
    delete this.element.aspxTransition;
   } catch (e) {
    this.element.aspxTransition = undefined;
   }
  },
  GetValue: function () {
   return this.getValueInternal(this.element, this.property);
  },
  SetValue: function (value) {
   this.setValueInternal(this.element, this.property, this.unit, value);
  },
  setValueInternal: function (element, property, unit, value) {
   if(property == "opacity")
    AnimationHelper.setOpacity(element, value);
   else
    element.style[property] = value + unit;
  },
  getValueInternal: function (element, property) {
   if(property == "opacity")
    return ASPx.GetElementOpacity(element);
   var value = parseFloat(element.style[property]);
   return isNaN(value) ? 0 : value;
  },
  performOnComplete: function () {
   if(this.onComplete)
    this.onComplete(this.element);
  },
  getTransition: function () {
   return this.transition;
  }
 });
 AnimationTransitionBase.Cancel = function (element) {
  if(element.aspxTransition)
   element.aspxTransition.Cancel();
 };
 var AnimationConstants = { };
 AnimationConstants.Durations = {
  SHORT: 200,
  DEFAULT: 400,
  LONG: 600
 };
 AnimationConstants.Transitions = {
  LINER: {
   Css: "cubic-bezier(0.250, 0.250, 0.750, 0.750)",
   Js: function (progress) { return progress; }
  },
  SINE: {
   Css: "cubic-bezier(0.470, 0.000, 0.745, 0.715)",
   Js: function (progress) { return Math.sin(progress * 1.57); }
  },
  POW: {
   Css: "cubic-bezier(0.755, 0.050, 0.855, 0.060)",
   Js: function (progress) { return Math.pow(progress, 4); }
  },
  POW_EASE_OUT: {
   Css: "cubic-bezier(0.165, 0.840, 0.440, 1.000)",
   Js: function (progress) { return 1 - AnimationConstants.Transitions.POW.Js(1 - progress); }
  }
 };
 var JsAnimationTransition = ASPx.CreateClass(AnimationTransitionBase, {
  constructor: function (element, options) {
   this.constructor.prototype.constructor.call(this, element, options);
   this.onStep = options.onStep;
   this.fps = 60;
   this.startTime = null;
  },
  Start: function (from, to) {
   AnimationTransitionBase.prototype.Start.call(this, from, to);
   this.initTimer();
  },
  Cancel: function () {
   AnimationTransitionBase.prototype.Cancel.call(this);
   if(this.timerId)
    clearInterval(this.timerId);
  },
  initTimer: function () {
   this.startTime = new Date();
   this.timerId = window.setInterval(function () { this.onTick(); }.aspxBind(this), 1000 / this.fps);
  },
  onTick: function () {
   var progress = (new Date() - this.startTime) / this.duration;
   if(progress >= 1)
    this.complete();
   else{
    this.update(progress);
    if(this.onStep)
     this.onStep();
   }
  },
  update: function (progress) {
   this.SetValue(this.gatCalculatedValue(this.from, this.to, progress));
  },
  complete: function () {
   this.Cancel();
   this.update(1);
   this.performOnComplete();
  },
  gatCalculatedValue: function (from, to, progress) {
   if(progress == 1)
    return to;
   return from + (to - from) * this.getTransition()(progress);
  },
  getTransition: function () {
   return this.transition.Js;
  }
 });
 var SimpleAnimationTransition = ASPx.CreateClass(JsAnimationTransition, {
  constructor: function (options) {
   this.constructor.prototype.constructor.call(this, null, options);
   this.transition = options.transition || AnimationConstants.Transitions.POW_EASE_OUT;
   this.onUpdate = options.onUpdate;
   this.lastValue = 0;
  },
  SetValue: function (value) {
   this.onUpdate(value - this.lastValue);
   this.lastValue = value;
  },
  performOnComplete: function () {
   if(this.onComplete)
    this.onComplete();
  }
 });
 var MultipleJsAnimationTransition = ASPx.CreateClass(JsAnimationTransition, {
  constructor: function (element, options) {
   this.constructor.prototype.constructor.call(this, element, options);
   this.properties = {};
  },
  Start: function (properties) {
   this.initProperties(properties);
   this.initTimer();
  },
  initProperties: function (properties) {
   this.properties = properties;
   for(var propName in this.properties)
    if(properties[propName].from == undefined)
     properties[propName].from = this.getValueInternal(this.element, propName);
  },
  update: function (progress) {
   for(var propName in this.properties) {
    var property = this.properties[propName];
    if(property.from != property.to)
     this.setValueInternal(this.element, propName, property.unit, this.gatCalculatedValue(property.from, property.to, progress));
   }
  }
 });
 var CssAnimationTransition = ASPx.CreateClass(AnimationTransitionBase, {
  constructor: function (element, options) {
   this.constructor.prototype.constructor.call(this, element, options);
   this.transitionPropertyName = AnimationUtils.CurrentTransition.property;
   this.eventName = AnimationUtils.CurrentTransition.event;
  },
  Start: function (from, to) {
   AnimationTransitionBase.prototype.Start.call(this, from, to);
   this.startTimerId = window.setTimeout(function () {
    var isHidden = this.element.offsetHeight == 0 && this.element.offsetWidth == 0; 
    if(!isHidden)
     this.prepareElementBeforeAnimation();
    this.SetValue(this.to);
    if(isHidden)
     this.onTransitionEnd();
   }.aspxBind(this), 0);
  },
  Cancel: function () {
   window.clearTimeout(this.startTimerId);
   AnimationTransitionBase.prototype.Cancel.call(this);
   ASPx.Evt.DetachEventFromElement(this.element, this.eventName, CssAnimationTransition.transitionEnd);
   this.stopAnimation();
   this.setValueInternal(this.element, this.transitionPropertyName, "", "");
  },
  prepareElementBeforeAnimation: function () {
   ASPx.Evt.AttachEventToElement(this.element, this.eventName, CssAnimationTransition.transitionEnd);
   var tmpH = this.element.offsetHeight; 
   this.element.style[this.transitionPropertyName] = this.getTransitionCssString();
   if(ASPx.Browser.Safari && ASPx.Browser.MacOSMobilePlatform && ASPx.Browser.MajorVersion >= 8) 
    setTimeout(function() {
     if(this.element && this.element.aspxTransition) {
      this.element.style[this.transitionPropertyName] = "";
      this.element.aspxTransition.onTransitionEnd();
     }
    }.aspxBind(this) , this.duration + 100);
  },
  stopAnimation: function () {
   this.SetValue(ASPx.GetCurrentStyle(this.element)[this.property]);
  },
  onTransitionEnd: function () {
   this.Cancel();
   this.performOnComplete();
  },
  getTransition: function () {
   return this.transition.Css;
  },
  getTransitionCssString: function () {
   return this.getTransitionCssStringInternal(this.getCssName(this.property));
  },
  getTransitionCssStringInternal: function (cssProperty) {
   return cssProperty + " " + this.duration + "ms " + this.getTransition();
  },
  getCssName: function (property) {
   switch (property) {
    case "marginLeft":
     return "margin-left";
    case "marginTop":
     return "margin-top"
   }
   return property;
  }
 });
 var MultipleCssAnimationTransition = ASPx.CreateClass(CssAnimationTransition, {
  constructor: function (element, options) {
   this.constructor.prototype.constructor.call(this, element, options);
   this.properties = null;
  },
  Start: function (properties) {
   this.properties = properties;
   this.forEachProperties(function (property, propName) {
    if(property.from !== undefined)
     this.setValueInternal(this.element, propName, property.unit, property.from);
   }.aspxBind(this));
   this.prepareElementBeforeAnimation();
   this.forEachProperties(function (property, propName) {
    this.setValueInternal(this.element, propName, property.unit, property.to);
   }.aspxBind(this));
  },
  stopAnimation: function () {
   var style = ASPx.GetCurrentStyle(this.element);
   this.forEachProperties(function (property, propName) {
    this.setValueInternal(this.element, propName, "", style[propName]);
   }.aspxBind(this));
  },
  getTransitionCssString: function () {
   var str = "";
   this.forEachProperties(function (property, propName) {
    str += this.getTransitionCssStringInternal(this.getCssName(propName)) + ",";
   }.aspxBind(this));
   str = str.substring(0, str.length - 1);
   return str;
  },
  forEachProperties: function (func) {
   for(var propName in this.properties) {
    var property = this.properties[propName];
    if(property.from == undefined)
     property.from = this.getValueInternal(this.element, propName);
    if(property.from != property.to)
     func(property, propName);
   }
  }
 });
 CssAnimationTransition.transitionEnd = function (evt) {
  var element = evt.target;
  if(element && element.aspxTransition)
   element.aspxTransition.onTransitionEnd();
 }
 var PositionAnimationTransition = ASPx.CreateClass(AnimationTransitionBase, {
  constructor: function (element, options) {
   this.constructor.prototype.constructor.call(this, element, options);
   this.direction = options.direction;
   this.animationTransition = this.createAnimationTransition();
   AnimationHelper.appendWKAnimationClassNameIfRequired(this.element);
  },
  Start: function (to) {
   var from = this.GetValue();
   if(AnimationUtils.CanUseCssTransform()) {
    from = this.convertPosToCssTransformPos(from);
    to = this.convertPosToCssTransformPos(to);
   }
   this.animationTransition.Start(from, to);
  },
  SetValue: function (value) {
   AnimationUtils.SetTransformValue(this.element, value, this.direction == AnimationHelper.SLIDE_VERTICAL_DIRECTION);
  },
  GetValue: function () {
   return AnimationUtils.GetTransformValue(this.element, this.direction == AnimationHelper.SLIDE_VERTICAL_DIRECTION);
  },
  createAnimationTransition: function () {
   var transition = AnimationUtils.CanUseCssTransform() ? this.createTransformAnimationTransition() : this.createPositionAnimationTransition();
   transition.transition = AnimationConstants.Transitions.POW_EASE_OUT;
   return transition;
  },
  createTransformAnimationTransition: function () {
   return new CssAnimationTransition(this.element, {
    property: AnimationUtils.CanUseCssTransform(),
    duration: this.duration,
    onComplete: this.onComplete
   });
  },
  createPositionAnimationTransition: function () {
   return AnimationHelper.createAnimationTransition(this.element, {
    property: this.direction == AnimationHelper.SLIDE_VERTICAL_DIRECTION ? "top" : "left",
    unit: "px",
    duration: this.duration,
    onComplete: this.onComplete
   });
  },
  convertPosToCssTransformPos: function (position) {
   return AnimationUtils.GetTransformCssText(position, this.direction == AnimationHelper.SLIDE_VERTICAL_DIRECTION);
  }
 });
 var AnimationHelper = {
  SLIDE_HORIZONTAL_DIRECTION: 0,
  SLIDE_VERTICAL_DIRECTION: 1,
  SLIDE_TOP_DIRECTION: 0,
  SLIDE_RIGHT_DIRECTION: 1,
  SLIDE_BOTTOM_DIRECTION: 2,
  SLIDE_LEFT_DIRECTION: 3,
  SLIDE_CONTAINER_CLASS: "dxAC",
  MAXIMUM_DEPTH: 3,
  createAnimationTransition: function (element, options) {
   if(options.onStep) 
    options.animationEngine = "js";
   switch (options.animationEngine) {
    case "js":
     return new JsAnimationTransition(element, options);
    case "css":
     return new CssAnimationTransition(element, options);
    default:
     return AnimationUtils.CanUseCssTransition() ? new CssAnimationTransition(element, options) : new JsAnimationTransition(element, options);
   }
  },
  createMultipleAnimationTransition: function (element, options) {
   return AnimationUtils.CanUseCssTransition() && !options.onStep ? new MultipleCssAnimationTransition(element, options) : new MultipleJsAnimationTransition(element, options);
  },
  createSimpleAnimationTransition: function (options) {
   return new SimpleAnimationTransition(options);
  },
  cancelAnimation: function (element) {
   AnimationTransitionBase.Cancel(element);
  },
  fadeIn: function (element, onComplete, duration) {
   AnimationHelper.fadeTo(element, {
    from: 0, to: 1,
    onComplete: onComplete,
    duration: duration || AnimationConstants.Durations.DEFAULT
   });
  },
  fadeOut: function (element, onComplete, duration) {
   AnimationHelper.fadeTo(element, {
    from: ASPx.GetElementOpacity(element), to: 0,
    onComplete: onComplete,
    duration: duration || AnimationConstants.Durations.DEFAULT
   });
  },
  fadeTo: function (element, options) {
   options.property = "opacity";
   if(!options.duration)
    options.duration = AnimationConstants.Durations.SHORT;
   var transition = AnimationHelper.createAnimationTransition(element, options);
   if(!ASPx.IsExists(options.from))
    options.from = transition.GetValue();
   transition.Start(options.from, options.to);
  },
  slideIn: function (element, direction, onComplete, animationEngineType) {
   AnimationHelper.setOpacity(element, 1);
   var animationContainer = AnimationHelper.getSlideAnimationContainer(element, true, true);
   var pos = AnimationHelper.getSlideInStartPos(animationContainer, direction);
   var transition = AnimationHelper.createSlideTransition(animationContainer, direction,
    function (el) {
     AnimationHelper.resetSlideAnimationContainerSize(animationContainer);
     if(onComplete)
      onComplete(el);
    }, animationEngineType);
   transition.Start(pos, 0);
  },
  slideOut: function (element, direction, onComplete, animationEngineType) {
   var animationContainer = AnimationHelper.getSlideAnimationContainer(element, true, true);
   var pos = AnimationHelper.getSlideOutFinishPos(animationContainer, direction);
   var transition = AnimationHelper.createSlideTransition(animationContainer, direction,
    function (el) {
     AnimationHelper.setOpacity(el.firstChild, 0);
     if(onComplete)
      onComplete(el);
    }, animationEngineType);
   transition.Start(pos);
  },
  slideTo: function (element, options) {
   if(!ASPx.IsExists(options.direction))
    options.direction = AnimationHelper.SLIDE_HORIZONTAL_DIRECTION;
   var transition = new PositionAnimationTransition(element, options);
   transition.Start(options.to);
  },
  setOpacity: function (element, value) {
   ASPx.SetElementOpacity(element, value);
  },
  appendWKAnimationClassNameIfRequired: function (element) {
   if(AnimationUtils.CanUseCssTransform() && ASPx.Browser.WebKitFamily && !ASPx.ElementHasCssClass(element, "dx-wbv"))
    element.className += " dx-wbv";
  },
  findSlideAnimationContainer: function (element) {
   var container = element
   for(var i = 0; i < AnimationHelper.MAXIMUM_DEPTH; i++) {
    if(container.tagName == "BODY")
     return null;
    if(ASPx.ElementHasCssClass(container, AnimationHelper.SLIDE_CONTAINER_CLASS))
     return container;
    container = container.parentNode;
   }
   return null;
  },
  createSlideAnimationContainer: function (element) {
   var rootContainer = document.createElement("DIV");
   ASPx.SetStyles(rootContainer, {
    className: AnimationHelper.SLIDE_CONTAINER_CLASS,
    overflow: "hidden"
   });
   var elementContainer = document.createElement("DIV");
   rootContainer.appendChild(elementContainer);
   var parentNode = element.parentNode;
   parentNode.insertBefore(rootContainer, element);
   elementContainer.appendChild(element);
   return rootContainer;
  },
  getSlideAnimationContainer: function (element, create, fixSize) {
   if(!element) return;
   var width = element.offsetWidth;
   var height = element.offsetHeight;
   var container;
   if(element.className == AnimationHelper.SLIDE_CONTAINER_CLASS)
    container = element;
   if(!container)
    container = AnimationHelper.findSlideAnimationContainer(element);
   if(!container && create)
    container = AnimationHelper.createSlideAnimationContainer(element);
   if(container && fixSize) {
    ASPx.SetStyles(container, {
     width: width, height: height
    });
    ASPx.SetStyles(container.firstChild, {
     width: width, height: height
    });
   }
   return container;
  },
  resetSlideAnimationContainerSize: function (container) {
   ASPx.SetStyles(container, {
    width: "", height: ""
   });
   ASPx.SetStyles(container.firstChild, {
    width: "", height: ""
   });
  },
  getModifyProperty: function (direction) {
   if(direction == AnimationHelper.SLIDE_TOP_DIRECTION || direction == AnimationHelper.SLIDE_BOTTOM_DIRECTION)
    return "marginTop";
   return "marginLeft";
  },
  createSlideTransition: function (animationContainer, direction, complete, animationEngineType) {
   var animationEngine = "";
   switch(animationEngineType) {
    case AnimationEngineType.JS:
     animationEngine = "js";
     break;
    case AnimationEngineType.CSS:
     animationEngine = "css";
     break;
   }
   return AnimationHelper.createAnimationTransition(animationContainer.firstChild, {
    unit: "px",
    property: AnimationHelper.getModifyProperty(direction),
    onComplete: complete,
    animationEngine: animationEngine
   });
  },
  getSlideInStartPos: function (animationContainer, direction) {
   switch (direction) {
    case AnimationHelper.SLIDE_TOP_DIRECTION:
     return animationContainer.offsetHeight;
    case AnimationHelper.SLIDE_LEFT_DIRECTION:
     return animationContainer.offsetWidth;
    case AnimationHelper.SLIDE_RIGHT_DIRECTION:
     return -animationContainer.offsetWidth;
    case AnimationHelper.SLIDE_BOTTOM_DIRECTION:
     return -animationContainer.offsetHeight;
   }
  },
  getSlideOutFinishPos: function (animationContainer, direction) {
   switch (direction) {
    case AnimationHelper.SLIDE_TOP_DIRECTION:
     return -animationContainer.offsetHeight;
    case AnimationHelper.SLIDE_LEFT_DIRECTION:
     return -animationContainer.offsetWidth;
    case AnimationHelper.SLIDE_RIGHT_DIRECTION:
     return animationContainer.offsetWidth;
    case AnimationHelper.SLIDE_BOTTOM_DIRECTION:
     return animationContainer.offsetHeight;
   }
  }
 };
 var GestureHandler = ASPx.CreateClass(null, {
  constructor: function (getAnimationElement, canHandle, allowStart) {
   this.getAnimationElement = getAnimationElement;
   this.canHandle = canHandle;
   this.allowStart = allowStart;
   this.startMousePosX = 0;
   this.startMousePosY = 0;
   this.startTime = null;
   this.isEventsPrevented = false;
   this.savedElements = [];
  },
  OnSelectStart: function(evt) {
   ASPx.Evt.PreventEvent(evt); 
  },
  OnMouseDown: function (evt) {
   this.startMousePosX = ASPx.Evt.GetEventX(evt);
   this.startMousePosY = ASPx.Evt.GetEventY(evt);
   this.startTime = new Date();
  },
  OnMouseMove: function(evt) {
   if(!ASPx.Browser.MobileUI)
    ASPx.Selection.Clear();
   if(Math.abs(this.GetCurrentDistanceX(evt)) < GestureHandler.SLIDER_MIN_START_DISTANCE && Math.abs(this.GetCurrentDistanceY(evt)) < GestureHandler.SLIDER_MIN_START_DISTANCE)
    GesturesHelper.isExecutedGesture = false;
  },
  OnMouseUp: function (evt) {
  },
  CanHandleEvent: function (evt) {
   return !this.canHandle || this.canHandle(evt);
  },
  IsStartAllowed: function (value) {
   return !this.allowStart || this.allowStart(value);
  },
  RollbackGesture: function () {
  },
  GetRubberPosition: function (position) {
   return position / GestureHandler.FACTOR_RUBBER;
  },
  GetCurrentDistanceX: function (evt) {
   return ASPx.Evt.GetEventX(evt) - this.startMousePosX;
  },
  GetCurrentDistanceY: function (evt) {
   return ASPx.Evt.GetEventY(evt) - this.startMousePosY;
  },
  GetDistanceLimit: function () {
   return (new Date() - this.startTime) < GestureHandler.MAX_TIME_SPAN ? GestureHandler.MIN_DISTANCE_LIMIT : GestureHandler.MAX_DISTANCE_LIMIT;
  },
  GetContainerElement: function () {
  },
  AttachPreventEvents: function (evt) {
   if(!this.isEventsPrevented) {
    var element = ASPx.Evt.GetEventSource(evt);
    var container = this.GetContainerElement();
    while(element && element != container) {
     ASPx.Evt.AttachEventToElement(element, "mouseup", ASPx.Evt.PreventEvent);
     ASPx.Evt.AttachEventToElement(element, "click", ASPx.Evt.PreventEvent);
     this.savedElements.push(element);
     element = element.parentNode;
    }
    this.isEventsPrevented = true;
   }
  },
  DetachPreventEvents: function () {
   if(this.isEventsPrevented) {
    window.setTimeout(function () {
     while(this.savedElements.length > 0) {
      var element = this.savedElements.pop();
      ASPx.Evt.DetachEventFromElement(element, "mouseup", ASPx.Evt.PreventEvent);
      ASPx.Evt.DetachEventFromElement(element, "click", ASPx.Evt.PreventEvent);
     }
    }.aspxBind(this), 0);
    this.isEventsPrevented = false;
   }
  }
 });
 GestureHandler.MAX_DISTANCE_LIMIT = 70;
 GestureHandler.MIN_DISTANCE_LIMIT = 10;
 GestureHandler.MIN_START_DISTANCE = 0;
 GestureHandler.SLIDER_MIN_START_DISTANCE = 5;
 GestureHandler.MAX_TIME_SPAN = 300;
 GestureHandler.FACTOR_RUBBER = 4;
 GestureHandler.RETURN_ANIMATION_DURATION = 150;
 var SwipeSlideGestureHandler = ASPx.CreateClass(GestureHandler, {
  constructor: function (getAnimationElement, direction, canHandle, backward, forward, rollback, move) {
   this.constructor.prototype.constructor.call(this, getAnimationElement, canHandle);
   this.slideElement = this.getAnimationElement();
   this.container = this.slideElement.parentNode;
   this.direction = direction;
   this.backward = backward;
   this.forward = forward;
   this.rollback = rollback;
   this.slideElementSize = 0;
   this.containerElementSize = 0;
   this.startSliderElementPosition = 0;
   this.centeredSlideElementPosition = 0;
  },
  OnMouseDown: function (evt) {
   GestureHandler.prototype.OnMouseDown.call(this, evt);
   this.slideElementSize = this.GetElementSize();
   this.startSliderElementPosition = this.GetElementPosition();
   this.containerElementSize = this.GetContainerElementSize();
   if(this.slideElementSize <= this.containerElementSize)
    this.centeredSlideElementPosition = (this.containerElementSize - this.slideElementSize) / 2;
  },
  OnMouseMove: function (evt) {
   GestureHandler.prototype.OnMouseMove.call(this, evt);
   if(!ASPx.Browser.TouchUI && !ASPx.GetIsParent(this.container, ASPx.Evt.GetEventSource(evt))) {
    GesturesHelper.OnDocumentMouseUp(evt);
    return;
   }
   var distance = this.GetCurrentDistance(evt);
   if(Math.abs(distance) < GestureHandler.SLIDER_MIN_START_DISTANCE || ASPx.TouchUIHelper.isGesture)
    return;
   this.SetElementPosition(this.GetCalculatedPosition(distance));
   this.AttachPreventEvents(evt);
   ASPx.Evt.PreventEvent(evt);
  },
  GetCalculatedPosition: function (distance) {
   AnimationTransitionBase.Cancel(this.slideElement);
   var position = this.startSliderElementPosition + distance,
    maxPosition = -(this.slideElementSize - this.containerElementSize),
    minPosition = 0;
   if(this.centeredSlideElementPosition > 0)
    position = this.GetRubberPosition(distance) + this.centeredSlideElementPosition;
   else if(position > minPosition)
    position = this.GetRubberPosition(distance);
   else if(position < maxPosition)
    position = this.GetRubberPosition(distance) + maxPosition;
   return position;
  },
  OnMouseUp: function (evt) {
   this.DetachPreventEvents();
   if(this.GetCurrentDistance(evt) != 0)
    this.OnMouseUpCore(evt);
  },
  OnMouseUpCore: function (evt) {
   var distance = this.GetCurrentDistance(evt);
   if(this.centeredSlideElementPosition > 0 || this.CheckSlidePanelIsOutOfBounds())
    this.PerformRollback();
   else
    this.PerformAction(distance);
  },
  PerformAction: function (distance) {
   if(Math.abs(distance) < this.GetDistanceLimit())
    this.PerformRollback();
   else if(distance < 0)
    this.PerformForward();
   else
    this.PerformBackward();
  },
  PerformBackward: function () {
   this.backward();
  },
  PerformForward: function () {
   this.forward();
  },
  PerformRollback: function () {
   this.rollback();
  },
  CheckSlidePanelIsOutOfBounds: function () {
   var minOffset = -(this.slideElementSize - this.containerElementSize), maxOffset = 0;
   var position = null, slideElementPos = this.GetElementPosition();
   if(slideElementPos > maxOffset || slideElementPos < minOffset)
    return true;
   return false;
  },
  GetContainerElement: function () {
   return this.container;
  },
  GetElementSize: function () {
   return this.IsHorizontalDirection() ? this.slideElement.offsetWidth : this.slideElement.offsetHeight;
  },
  GetContainerElementSize: function () {
   return this.IsHorizontalDirection() ? ASPx.GetClearClientWidth(this.container) : ASPx.GetClearClientHeight(this.container);
  },
  GetCurrentDistance: function (evt) {
   return this.IsHorizontalDirection() ? this.GetCurrentDistanceX(evt) : this.GetCurrentDistanceY(evt);
  },
  GetElementPosition: function () {
   return AnimationUtils.GetTransformValue(this.slideElement, !this.IsHorizontalDirection());
  },
  SetElementPosition: function (position) {
   AnimationUtils.SetTransformValue(this.slideElement, position, !this.IsHorizontalDirection());
  },
  IsHorizontalDirection: function () {
   return this.direction == AnimationHelper.SLIDE_HORIZONTAL_DIRECTION;
  }
 });
 var SwipeSimpleSlideGestureHandler = ASPx.CreateClass(SwipeSlideGestureHandler, {
  constructor: function (getAnimationElement, direction, canHandle, backward, forward, rollback, updatePosition) {
   this.constructor.prototype.constructor.call(this, getAnimationElement, direction, canHandle, backward, forward, rollback);
   this.container = this.slideElement;
   this.updatePosition = updatePosition;
   this.prevDistance = 0;
  },
  OnMouseDown: function (evt) {
   GestureHandler.prototype.OnMouseDown.call(this, evt);
   this.prevDistance = 0;
  },
  OnMouseUpCore: function (evt) {
   this.PerformAction(this.GetCurrentDistance(evt));
  },
  PerformAction: function (distance) {
   if(Math.abs(distance) < this.GetDistanceLimit())
    this.PerformRollback();
   else if(distance < 0)
    this.PerformForward();
   else
    this.PerformBackward();
  },
  GetCalculatedPosition: function (distance) {
   var position = distance - this.prevDistance;
   this.prevDistance = distance;
   return position;
  },
  SetElementPosition: function (position) {
   this.updatePosition(position);
  }
 });
 var SwipeGestureHandler = ASPx.CreateClass(GestureHandler, {
  constructor: function (getAnimationElement, canHandle, allowStart, start, allowComplete, complete, cancel, animationEngineType) {
   this.constructor.prototype.constructor.call(this, getAnimationElement, canHandle, allowStart);
   this.start = start;
   this.allowComplete = allowComplete;
   this.complete = complete;
   this.cancel = cancel;
   this.animationTween = null;
   this.currentDistanceX = 0;
   this.currentDistanceY = 0;
   this.tryStartGesture = false;
   this.tryStartScrolling = false;
   this.animationEngineType = animationEngineType;
   this.UpdateAnimationContainer();
  },
  UpdateAnimationContainer: function () {
   this.animationContainer = AnimationHelper.getSlideAnimationContainer(this.getAnimationElement(), true, false);
  },
  CanHandleEvent: function (evt) {
   if(GestureHandler.prototype.CanHandleEvent.call(this, evt))
    return true;
   return this.animationTween && this.animationContainer && ASPx.GetIsParent(this.animationContainer, ASPx.Evt.GetEventSource(evt));
  },
  OnMouseDown: function (evt) {
   GestureHandler.prototype.OnMouseDown.call(this, evt);
   if(this.animationTween)
    this.animationTween.Cancel();
   this.currentDistanceX = 0;
   this.currentDistanceY = 0;
   this.tryStartGesture = false;
   this.tryStartScrolling = false;
  },
  OnMouseMove: function (evt) {
   GestureHandler.prototype.OnMouseMove.call(this, evt);
   this.currentDistanceX = this.GetCurrentDistanceX(evt);
   this.currentDistanceY = this.GetCurrentDistanceY(evt);
   if(!this.animationTween && !this.tryStartScrolling && (Math.abs(this.currentDistanceX) > GestureHandler.MIN_START_DISTANCE || Math.abs(this.currentDistanceY) > GestureHandler.MIN_START_DISTANCE)) {
    if(Math.abs(this.currentDistanceY) < Math.abs(this.currentDistanceX)) {
     this.tryStartGesture = true;
     if(this.IsStartAllowed(this.currentDistanceX)) {
      this.animationContainer = AnimationHelper.getSlideAnimationContainer(this.getAnimationElement(), true, true);
      this.animationTween = AnimationHelper.createSlideTransition(this.animationContainer, AnimationHelper.SLIDE_LEFT_DIRECTION,
       function () {
        AnimationHelper.resetSlideAnimationContainerSize(this.animationContainer);
        this.animationContainer = null;
        this.animationTween = null;
       }.aspxBind(this), this.animationEngineType);
      this.PerformStart(this.currentDistanceX);
      this.AttachPreventEvents(evt);
     }
    }
    else
     this.tryStartScrolling = true;
   }
   if(this.animationTween) {
    if(this.allowComplete && !this.allowComplete(this.currentDistanceX))
     this.currentDistanceX = this.GetRubberPosition(this.currentDistanceX);
    this.animationTween.SetValue(this.currentDistanceX);
   }
   if(!this.tryStartScrolling && !ASPx.TouchUIHelper.isGesture && evt.touches && evt.touches.length < 2)
    ASPx.Evt.PreventEvent(evt);
  },
  OnMouseUp: function (evt) {
   if(!this.animationTween) {
    if(this.tryStartGesture)
     this.PerformCancel(this.currentDistanceX);
   }
   else {
    if(Math.abs(this.currentDistanceX) < this.GetDistanceLimit())
     this.RollbackGesture();
    else {
     if(this.IsCompleteAllowed(this.currentDistanceX)) {
      this.PerformComplete(this.currentDistanceX);
      this.animationContainer = null;
      this.animationTween = null;
     }
     else
      this.RollbackGesture();
    }
   }
   this.DetachPreventEvents();
   this.tryStartGesture = false;
   this.tryStartScrolling = false;
  },
  PerformStart: function (value) {
   if(this.start)
    this.start(value);
  },
  IsCompleteAllowed: function (value) {
   return !this.allowComplete || this.allowComplete(value);
  },
  PerformComplete: function (value) {
   if(this.complete)
    this.complete(value);
  },
  PerformCancel: function (value) {
   if(this.cancel)
    this.cancel(value);
  },
  RollbackGesture: function () {
   this.animationTween.Start(this.currentDistanceX, 0);
  },
  GetContainerElement: function () {
   return this.animationContainer;
  }
 });
 var GesturesHelper = {
  handlers: {},
  activeHandler: null,
  isAttachedEvents: false,
  isExecutedGesture: false,
  AddSwipeGestureHandler: function (id, getAnimationElement, canHandle, allowStart, start, allowComplete, complete, cancel, animationEngineType) {
   this.handlers[id] = new SwipeGestureHandler(getAnimationElement, canHandle, allowStart, start, allowComplete, complete, cancel, animationEngineType);
  },
  UpdateSwipeAnimationContainer: function (id) {
   if(this.handlers[id])
    this.handlers[id].UpdateAnimationContainer();
  },
  AddSwipeSlideGestureHandler: function (id, getAnimationElement, direction, canHandle, backward, forward, rollback, updatePosition) {
   if(updatePosition)
    this.handlers[id] = new SwipeSimpleSlideGestureHandler(getAnimationElement, direction, canHandle, backward, forward, rollback, updatePosition);
   else
    this.handlers[id] = new SwipeSlideGestureHandler(getAnimationElement, direction, canHandle, backward, forward, rollback);
  },
  canHandleMouseDown: function(evt) {
   if(!ASPx.Evt.IsLeftButtonPressed(evt))
    return false;
   var element = ASPx.Evt.GetEventSource(evt);
   var dxFocusedEditor = (typeof(ASPxClientEdit) != "undefined") && ASPxClientEdit.GetFocusedEditor();
   if(dxFocusedEditor && dxFocusedEditor.IsEditorElement(element))
    return false;
   var isTextEditor = element.tagName == "TEXTAREA" || element.tagName == "INPUT" && ASPx.Attr.GetAttribute(element, "type") == "text";
   if(isTextEditor && document.activeElement == element)
    return false;
   return true;  
  },
  OnDocumentSelectStart: function(evt) {
   if(GesturesHelper.activeHandler && GesturesHelper.isExecutedGesture)
    GesturesHelper.activeHandler.OnSelectStart(evt);
  },
  OnDocumentMouseDown: function (evt) {
   if(!GesturesHelper.canHandleMouseDown(evt))
    return;
   GesturesHelper.activeHandler = GesturesHelper.FindHandler(evt);
   if(GesturesHelper.activeHandler)
    GesturesHelper.activeHandler.OnMouseDown(evt);
  },
  OnDocumentMouseMove: function (evt) {
   if(GesturesHelper.activeHandler) {
    GesturesHelper.isExecutedGesture = true;
    GesturesHelper.activeHandler.OnMouseMove(evt);
   }
  },
  OnDocumentMouseUp: function (evt) {
   if(GesturesHelper.activeHandler) {
    GesturesHelper.activeHandler.OnMouseUp(evt);
    GesturesHelper.activeHandler = null;
    window.setTimeout(function () { GesturesHelper.isExecutedGesture = false; }, 0);
   }
  },
  AttachEvents: function () {
   if(!GesturesHelper.isAttachedEvents) {
    GesturesHelper.Attach(ASPx.Evt.AttachEventToElement);
    GesturesHelper.isAttachedEvents = true;
   }
  },
  DetachEvents: function () {
   if(GesturesHelper.isAttachedEvents) {
    GesturesHelper.Attach(ASPx.Evt.DetachEventFromElement);
    GesturesHelper.isAttachedEvents = false;
   }
  },
  Attach: function (changeEventsMethod) {
   var doc = window.document;
   changeEventsMethod(doc, ASPx.TouchUIHelper.touchMouseDownEventName, GesturesHelper.OnDocumentMouseDown);
   changeEventsMethod(doc, ASPx.TouchUIHelper.touchMouseMoveEventName, GesturesHelper.OnDocumentMouseMove);
   changeEventsMethod(doc, ASPx.TouchUIHelper.touchMouseUpEventName, GesturesHelper.OnDocumentMouseUp);
   if(!ASPx.Browser.MobileUI)
    changeEventsMethod(doc, "selectstart", GesturesHelper.OnDocumentSelectStart);
  },
  FindHandler: function (evt) {
   var handlers = [];
   for(var id in GesturesHelper.handlers) {
    var handler = GesturesHelper.handlers[id];
    if(handler.CanHandleEvent && handler.CanHandleEvent(evt))
     handlers.push(handler);
   }
   if(!handlers.length)
    return null;
   handlers.sort(function (a, b) {
    return ASPx.GetIsParent(a.getAnimationElement(), b.getAnimationElement()) ? 1 : -1;
   });
   return handlers[0];
  },
  IsExecutedGesture: function () {
   return GesturesHelper.isExecutedGesture;
  }
 };
 GesturesHelper.AttachEvents();
 var AnimationEngineType = {
  "JS": 0,
  "CSS": 1,
  "DEFAULT" : 2
 }
 ASPx.AnimationEngineType = AnimationEngineType;
 ASPx.AnimationUtils = AnimationUtils;
 ASPx.AnimationConstants = AnimationConstants;
 ASPx.AnimationHelper = AnimationHelper;
 ASPx.GesturesHelper = GesturesHelper;
})();
