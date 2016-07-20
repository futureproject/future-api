window.tfp = window.tfp || {}

tfp.Embed = function(elem) {
  var self = this;
  self.contentBox = elem.querySelector("section");
  self.toggle = function(event) {
    event.preventDefault();
    if (!!elem.getAttribute("data-loaded")) {
      elem.classList.toggle("is-expanded");
      var shouldScroll = elem.getBoundingClientRect().top != 0 && elem.classList.contains('is-expanded');
      if (shouldScroll) {
        self.scrollToElement();
      }
    } else {
        self.scrollToElement(function(elems){
          elem.setAttribute("data-loaded", true);
          elem.classList.add("is-expanded");
          self.frame = document.createElement("iframe");
          self.frame.src = elem.getAttribute("data-link");
          self.contentBox.appendChild(self.frame);
        });
    }
  }
  self.scrollToElement = function(callback){
    Velocity(elem, "scroll", {
      duration: 300,
      complete: callback
    });
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
