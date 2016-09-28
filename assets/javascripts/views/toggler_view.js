window.tfp = window.tfp || {};

tfp.togglerView = Backbone.View.extend({
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

