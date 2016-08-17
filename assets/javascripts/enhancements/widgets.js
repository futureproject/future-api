window.tfp = window.tfp || {};

tfp.Widget = function(elem){
  var self = this;
  self.$elem = $(elem);
  self.$box = self.$elem.find(".module-content");
  self.url = self.$elem.find(".module-header a").attr('href');
  self.xhr = new XMLHttpRequest();
  self.xhr.open("GET", self.url);
  self.xhr.setRequestHeader("Content-Type", "text/html");
  self.xhr.onload = function() {
    self.$box.html(self.xhr.responseText);
    callback_name = self.url.split("/").pop()
    callback = tfp.widgets[callback_name]
    if(callback) { callback.call(self) }
  }
  self.xhr.send();
}

tfp.widgets = {
  // intercept clicks on City Dashboard checkboxes, use them
  // to toggle the status of individual tasks
  tasks: function(){
    // append undone tasks to header
    var todos = this.$elem.find(".task").length;
    var $badge = $("<div class='module-badge length-" + todos + "'>" +  todos + "</div>")
    this.$elem.find(".module-header").append($badge);
    // intercept input clicks
    this.$box.on("click", "input", function(event) {
      var $t = $(this);
      $t.attr('disabled','disabled');
      form = $t.closest("form").get(0);
      data = new FormData(form);
      data.append("task[Complete?]", this.checked);

      // send data to the server
      xhr = new XMLHttpRequest();
      url = form.action;
      xhr.open(form.method, url);
      xhr.onload = function() {
        $t.get(0).removeAttribute('disabled');
      }
      xhr.send(data);
    });
  }
}

$(function(){
  $(".widget").each(function(){
    new tfp.Widget(this);
  })
})
