window.tfp = window.tfp || {}

tfp.Embed = function(elem) {
  var self = this;
  self.contentBox = elem.querySelector("section");
  self.toggle = function(event) {
    event.preventDefault();
    if (!!elem.getAttribute("data-loaded")) {
      elem.classList.toggle("is-expanded");
    } else {
      elem.setAttribute("data-loaded", true);
      elem.classList.add("is-expanded");
      self.frame = document.createElement("iframe");
      self.frame.src = elem.getAttribute("data-link");
      self.contentBox.insertBefore(self.frame, self.contentBox.firstChild)
    }
  }
  elem.querySelector("a").addEventListener("click", self.toggle, false);
}
document.addEventListener("DOMContentLoaded", function(event) {
  embed = document.querySelectorAll('.embed');
  tfp.embed = [];
  for (i=0; i < embed.length; i++) {
    tfp.embed.push(new tfp.Embed(embed[i]));
  }
}, false)
