window.tfp = window.tfp || {};

tfp.FlashView = Backbone.View.extend({
  initialize: function(){
    this.listenTo(Backbone, "flash", this.flash);
  },
  flash: function(msg) {
    $notice = $("<div class='flash'>" + msg + "</div>");
    $('body').append($notice.hide().fadeIn());
    window.setTimeout(function(){
      $notice.fadeOut(function(){
        $(this).remove();
      })
    }, 2000)
  }
})
$(function(){
  tfp.flasher = new tfp.FlashView()
})
