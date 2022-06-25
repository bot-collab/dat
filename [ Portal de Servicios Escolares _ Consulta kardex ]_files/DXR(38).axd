(function () {
var Constants = {
 Name: "ASPxGlobalEvents"
}
var ASPxClientGlobalEvents = ASPx.CreateClass(ASPxClientComponent, {
 constructor: function () {
  this.constructor.prototype.constructor.call(this, Constants.Name);
  this.ControlsInitialized = new ASPxClientEvent();
  this.BrowserWindowResized = new ASPxClientEvent();
  this.BeginCallback = new ASPxClientEvent();
  this.EndCallback = new ASPxClientEvent();
  this.CallbackError = new ASPxClientEvent();
  this.ValidationCompleted = new ASPxClientEvent();
 },
 OnGlobalControlsInitialized: function(args) { 
  this.ControlsInitialized.FireEvent(this, args);
 },
 OnGlobalBrowserWindowResized: function(args) { 
  this.BrowserWindowResized.FireEvent(this, args);
 },
 OnGlobalBeginCallback: function(args) { 
  this.BeginCallback.FireEvent(this, args);
 },
 OnGlobalEndCallback: function(args) { 
  this.EndCallback.FireEvent(this, args);
 },
 OnGlobalCallbackError: function(args) { 
  this.CallbackError.FireEvent(this, args);
 },
 OnGlobalValidationCompleted: function(args) { 
  this.ValidationCompleted.FireEvent(this, args);
 }
});
var globalEvents = null;
function aspxGetGlobalEvents() {
 if(globalEvents == null)
  globalEvents = new ASPxClientGlobalEvents();
 return globalEvents;
}
ASPx.GetGlobalEvents = aspxGetGlobalEvents;
window.ASPxClientGlobalEvents = ASPxClientGlobalEvents;
})();
