window.tfp = window.tfp || {};
tfp.widgets = {};

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

// intercept clicks on City Dashboard checkboxes, use them
// to toggle the status of individual tasks
tfp.widgets.tasks = Backbone.View.extend({
  initialize: function(){
    // append undone tasks to header
    var todos = this.$el.find(".task").length;
    var $badge = $("<div class='module-badge length-" + todos + "'>" +  todos + "</div>")
    this.$el.find(".module-header").append($badge);
  },
  events: {
    "click input": "toggle"
  },
  toggle: function(event){
    var checkbox = event.currentTarget
    checkbox.setAttribute('disabled', 'disabled')
    form = $(checkbox).closest("form").get(0);
    data = new FormData(form);
    data.append("record[Complete?]", checkbox.checked);

    // send data to the server
    xhr = new XMLHttpRequest();
    url = form.action;
    xhr.open(form.method, url);
    xhr.onload = function() {
      checkbox.removeAttribute('disabled');
    }
    xhr.send(data);
  }
})

tfp.widgets.commitments = Backbone.View.extend({
  initialize: function(){
    this.views = {
      checklist: new tfp.widgets.tasks({
        el: this.el.querySelector("#commitments-checklist")
      }),
      form: new tfp.CommitmentsFormView({
        el: this.el.querySelector("#new-commitment")
      })
    }
  }
})
