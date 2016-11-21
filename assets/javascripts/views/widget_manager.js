module.exports = Backbone.View.extend({
  initialize: function(args){
    this.widgets = args.widgets;
    this.listenTo(Backbone, "widget:ready", this.activateWidget);
  },
  activateWidget: function(args) {
    var widgetView = this.widgets[args.widget]
    if(!!widgetView) {
      new widgetView({ el: args.element });
    }
  }

})
