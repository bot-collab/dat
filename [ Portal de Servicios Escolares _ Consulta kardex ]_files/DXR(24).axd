(function () {
ASPxClientCallbackPanel = ASPx.CreateClass(ASPxClientPanel, {
 constructor: function (name) {
  this.constructor.prototype.constructor.call(this, name);
  this.hideContentOnCallback = true;
  this.isLoadingPanelTextEmpty = false;
 },
 OnCallback: function (result) {
  ASPx.SetInnerHtml(this.getContentElement(), result);
  if(this.touchUIScroller)
   this.touchUIScroller.ChangeElement(this.getContentElement());
 },
 ShowLoadingPanel: function () {
  var element = this.getContentElement();
  var mainElement = (element.tagName == "TD") ? this.GetMainElement() : element;
  if(!this.hideContentOnCallback)
   this.CreateLoadingPanelWithAbsolutePosition(this.GetMainElement().parentNode, mainElement);
  else
   this.CreateLoadingPanelInsideContainer(element, true, true, false);
 },
 ShowLoadingDiv: function () {
  this.CreateLoadingDiv(this.GetMainElement().parentNode, this.getContentElement());
 },
 GetCallbackAnimationElement: function() {
  return this.getContentElement();
 },
 PerformCallback: function (parameter) {
  this.CreateCallback(parameter);
 },
 CreateCallback: function (arg, command, callbackInfo) {
  this.ShowLoadingElements();
  ASPxClientControl.prototype.CreateCallback.call(this, arg, command);
 },
 GetLoadingPanelTextLabelID: function () {
  return this.name + "_TL";
 },
 GetLoadingPanelTextLabel: function () {
  return ASPx.GetElementById(this.GetLoadingPanelTextLabelID());
 },
 GetLoadingPanelText: function () {
  var textLabel = this.GetLoadingPanelTextLabel();
  if(textLabel && !this.isLoadingPanelTextEmpty)
   return textLabel.innerHTML;
  return "";
 },
 SetLoadingPanelText: function (text) {
  this.isLoadingPanelTextEmpty = text == null || text == "";
  var textLabel = this.GetLoadingPanelTextLabel();
  if(textLabel)
   textLabel.innerHTML = this.isLoadingPanelTextEmpty ? "&nbsp;" : text;
 },
 SetContentHtml: function (html, useAnimation) {
  ASPxClientPanel.prototype.SetContentHtml.call(this, html);
  if(useAnimation && typeof(ASPx.AnimationHelper) != "undefined")
   ASPx.AnimationHelper.fadeIn(this.getContentElement());
 }
});
ASPxClientCallbackPanel.Cast = ASPxClientControl.Cast;
window.ASPxClientCallbackPanel = ASPxClientCallbackPanel;
})();
