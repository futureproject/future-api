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
  }
  self.xhr.send()
}

document.addEventListener("DOMContentLoaded", function(event) {
  widgets = document.querySelectorAll('.widget');
  tfp.widgets = [];
  for (i=0; i < widgets.length; i++) {
    tfp.widgets.push(new tfp.Widget(widgets[i]));
  }
})
