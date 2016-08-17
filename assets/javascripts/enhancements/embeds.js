window.tfp = window.tfp || {}

tfp.Embed = function(elem) {
  var $elem = $(elem);
  $elem.one("click", ".module-header", function(){
    var url = $(this).find("a").attr("href");
    var extension = url.split("/").pop();
    var embed = extension.match(/jpg|jpeg|png|gif/i) ? document.createElement("img") : document.createElement("iframe");
    embed.src = url;
    $elem.find(".module-content").prepend(embed);
  })
}

$(function(){
  $(".embed").each(function(){
    new tfp.Embed(this)
  })
})
