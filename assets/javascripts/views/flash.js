window.tfp = window.tfp || {};

tfp.FlashView = Backbone.View.extend({
  initialize: function(){
    this.listenTo(Backbone, "flash", this.flash);
  },
  flash: function(msg) {
    var msg = msg.replace("\n", "<br>")
    var $notice = $("<div class='flash'>" + msg + "</div>");
    if (!!msg.match(/required|error/i)) {
      $notice.addClass('error')
    }
    $('body').append($notice.hide().fadeIn());
    window.setTimeout(function(){
      $notice.fadeOut(function(){
        $(this).remove();
      })
    }, 2000)
  }
})
