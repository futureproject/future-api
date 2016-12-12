module.exports = Backbone.View.extend({
  events: {
    "click .module-header": "toggle"
  },

  toggle: function(event) {
    event.preventDefault();
    this.$el.siblings().removeClass("is-expanded");
    $("html, body").animate({
      "scrollTop": this.$el.offset().top
      })
    this.$el.toggleClass("is-expanded");
  }
})

