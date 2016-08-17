window.tfp = window.tfp || {};

tfp.PortalModule = function(elem){
  var $elem = $(elem);
  $elem.on("click", ".module-header", function(event) {
    event.preventDefault();
    $elem.siblings().removeClass("is-expanded");
    $("html, body").animate({
      "scrollTop": $elem.offset().top
      })
    $elem.toggleClass("is-expanded");
  });
}


$(function(){
  $(".module").each(function(){
    new tfp.PortalModule(this);
  })
})
