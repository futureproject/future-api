window.tfp = window.tfp || {};
tfp.msnry = {}
window.addEventListener('load', function(event) {
  var elem = document.querySelector('.dashboard-modules');
  if (window.matchMedia("(min-width: 768px)").matches) {
    tfp.msnry = new Masonry( elem, {
      percentPosition: true
    });
  }
})
