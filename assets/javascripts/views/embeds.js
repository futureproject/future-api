module.exports = Backbone.View.extend({
  events: {
    "click .module-header": "load"
  },
  load: function(event) {
    if (this.loaded) {
      return true;
    }
    var url = this.$el.find("a").attr("href");
    var extension = url.split("/").pop();
    if (extension.match(/jpg|jpeg|png|gif/i)) {
      var embed = document.createElement("img");
      var $target = this.$el.find(".module-content");
      var $loader = $("<div class='tfp-loading' />");
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
      this.$el.find(".module-content").prepend(embed);
    }
    this.loaded = true;
  }
})

