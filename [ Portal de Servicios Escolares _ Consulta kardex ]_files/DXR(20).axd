(function () {
 if (typeof ASPx == "undefined") {
  window.ASPx = {};
 }
 ASPx.ASPxImageLoad = {};
 ASPx.ASPxImageLoad.dxDefaultLoadingImageCssClass = "dxe-loadingImage";
 ASPx.ASPxImageLoad.OnLoad = function (image, customLoadingImage, isOldIE, customBackgroundImageUrl) {
  image.dxCustomBackgroundImageUrl = "";
  image.dxShowLoadingImage = true;
  image.dxCustomLoadingImage = customLoadingImage;
  if (customBackgroundImageUrl != "")
   image.dxCustomBackgroundImageUrl = "url('" + customBackgroundImageUrl + "')";
  ASPx.ASPxImageLoad.prepareImageBackground(image, isOldIE);
  ASPx.ASPxImageLoad.removeHandlers(image);
  image.className = image.className.replace(ASPx.ASPxImageLoad.dxDefaultLoadingImageCssClass, "");
 };
 ASPx.ASPxImageLoad.removeASPxImageBackground = function (image, isOldIE) {
  if (isOldIE) 
   image.style.removeAttribute("background-image");
  else 
   image.style.backgroundImage = "";
 };
 ASPx.ASPxImageLoad.prepareImageBackground = function (image, isOldIE) {
  ASPx.ASPxImageLoad.removeASPxImageBackground(image, isOldIE);
  if (image.dxCustomBackgroundImageUrl != "")
   image.style.backgroundImage = image.dxCustomBackgroundImageUrl;
 };
 ASPx.ASPxImageLoad.removeHandlers = function (image) {
  image.removeAttribute("onload");
  image.removeAttribute("onabort");
  image.removeAttribute("onerror");
 };
})();
