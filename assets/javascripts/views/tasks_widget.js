window.tfp = window.tfp || {};
tfp.widgets = tfp.widgets || {};

// intercept clicks on City Dashboard checkboxes, use them
// to toggle the status of individual tasks
tfp.widgets.tasks = Backbone.View.extend({
  initialize: function(){
    // append undone tasks to header
    var todos = this.$el.find(".task").length;
    var $badge = $("<div class='module-badge length-" + todos + "'>" +  todos + "</div>")
    var $header = this.$el.find(".module-header")
    $header.append($badge);
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

