let Backbone = require("backbone");

let AirtableFormWidget = Backbone.View.extend({
  events: {
    "click a": "loadForm",
    "click label": "closeForms"
  },
  loadForm: function(event) {
    event.preventDefault();
    this.$el.addClass('is-active');
    var link = $(event.currentTarget);
    if (!link.hasClass('is-active')) {
      link.addClass('is-active').siblings().removeClass('is-active');
      var frame = document.createElement('iframe');
      frame.setAttribute('src', link.attr('href'));
      this.$el.find(".form-target").html(frame);
    }
  },
  closeForms: function(){
    this.$el.removeClass('is-active');
    this.$el.find(".form-target").empty();
    this.$el.find('a').removeClass('is-active');
  }
})

module.exports = AirtableFormWidget;
