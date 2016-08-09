window.tfp = window.tfp || {};

tfp.Widget = function(elem){
  var self = this;
  self.contentBox = elem.querySelector("section");
  self.url = elem.getAttribute("data-link");
  self.xhr = new XMLHttpRequest();
  self.xhr.open("GET", this.url);
  self.xhr.setRequestHeader("Content-Type", "text/html");
  self.xhr.onload = function() {
    self.contentBox.innerHTML = self.xhr.responseText;
    callback_name = self.url.split("/").pop()
    callback = tfp.widgets[callback_name]
    if(callback) { callback.call(self) }
  }
  self.xhr.send()
}

tfp.widgets = {
  // intercept clicks on City Dashboard checkboxes, use them
  // to toggle the status of individual tasks
  tasks: function(){
    this.contentBox.addEventListener("click", function(event) {
      if(event.target.nodeName == "INPUT") {
        event.target.setAttribute('disabled', true)
        xhr = new XMLHttpRequest();
        url = "/api/tasks/" + event.target.getAttribute('data-id') + "/toggle"
        xhr.open("POST", url);
        xhr.setRequestHeader("Content-Type", "application/json");
        xhr.onload = function() {
          event.target.removeAttribute('disabled')
        }
        xhr.send()
      }
    }, true)
  }
}

document.addEventListener("DOMContentLoaded", function(event) {
  widgets = document.querySelectorAll('.widget');
  for (i=0; i < widgets.length; i++) {
    new tfp.Widget(widgets[i]);
  }
})
