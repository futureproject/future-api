window.tfp = window.tfp || {};
tfp.widgets = tfp.widgets || {};

tfp.WidgetView = Backbone.View.extend({
  initialize: function(){
    var self = this;
    this.$box = self.$el.find(".module-content");
    self.url = self.$el.find(".module-header a").attr('href');
    self.xhr = new XMLHttpRequest();
    self.xhr.open("GET", self.url);
    self.xhr.setRequestHeader("Content-Type", "text/html");
    self.xhr.onload = function() {
      self.$box.html(self.xhr.responseText);
      widgetName = self.url.split("/").pop()
      widgetView = tfp.widgets[widgetName]
      if(!!widgetView) {
        v = new widgetView({ el: self.el })
      }
    }
    self.$el.one('click', function(event) {
      self.xhr.send();
    })
  }
})

