window.tfp = window.tfp || {}

tfp.Embed = function(elem) {
  var $elem = $(elem);
  $elem.one("click", ".module-header", function(){
    var url = $(this).find("a").attr("href");
    var extension = url.split("/").pop();
    if (extension.match(/jpg|jpeg|png|gif/i)) {
      var embed = document.createElement("img");
      var $target = $(elem).find(".module-content");
      var $loader = $("<div class='loading' />");
      $target.prepend($loader);
      embed.src = url;
      $(embed).one('load', function(){
        $loader.replaceWith(embed);
      }).each(function(){
        if (this.complete) {
          $(this).trigger('load')
        }
      })
    } else {
      var embed = document.createElement("iframe");
      embed.src = url;
      $elem.find(".module-content").prepend(embed);
    }
  })
}

$(function(){
  $(".embed").each(function(){
    new tfp.Embed(this)
  })
})
