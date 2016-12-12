module.exports = Backbone.View.extend({
  events: {
    "click input": "toggle"
  },
  toggle: function(event){
    var checkbox = event.currentTarget
    checkbox.setAttribute('disabled', 'disabled')
    var form = $(checkbox).closest("form").get(0);
    var data = new FormData(form);
    data.append("record[Complete?]", checkbox.checked);

    // send data to the server
    var xhr = new XMLHttpRequest();
    var url = form.action;
    xhr.open(form.method, url);
    xhr.onload = function() {
      checkbox.removeAttribute('disabled');
    }
    xhr.send(data);
  }
})

