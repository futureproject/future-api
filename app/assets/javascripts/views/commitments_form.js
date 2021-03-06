var peoplePicker = require('./people_picker_view');
var datePicker = require('./datepicker_view');

module.exports = Backbone.View.extend({
  initialize: function(){
    this.views = {
      $form: this.$el.find('form'),
      $button: this.$el.find("form input[type=submit]"),
      selector: new peoplePicker({
        el: this.el.querySelector('select[multiple]')
      }),
      datePicker: new datePicker({
        el: this.el.querySelector('input[type=date]')
      })
    };
    this.listenTo(Backbone, "commitments_form:hide", this.hide)
    this.listenTo(Backbone, "commitments_form:show", this.show)
  },
  hide: function(){
    this.views.$form.get(0).reset()
    this.views.selector.clear();
    this.views.$button.removeAttr('disabled')
    this.$el.slideUp()
  },
  show: function(){
    this.$el.slideDown();
  },
  events: {
    "submit": "sendForm"
  },
  sendForm: function(event) {
    var button = this.views.$button;
    event.preventDefault()
    button.attr('disabled','disabled')
    var data = new FormData(this.views.$form.get(0))
    //send data to the server
    var xhr = new XMLHttpRequest();
    var url = this.views.$form.attr('action');
    var method = this.views.$form.attr('method');
    xhr.open(method, url);
    xhr.onload = function(event){
      button.removeAttr('disabled')
      if (xhr.status < 300) {
        Backbone.trigger("flash", "Commitment added!");
        Backbone.trigger("commitments_form:hide");
      } else {
        Backbone.trigger("flash", xhr.responseText)
      }
    }
    xhr.send(data);
  },
})

