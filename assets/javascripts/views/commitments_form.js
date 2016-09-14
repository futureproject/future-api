window.tfp = window.tfp || {};

tfp.CommitmentsFormView = Backbone.View.extend({
  initialize: function(){
    this.views = {
      $form: this.$el.find('form'),
      selector: new tfp.PeoplePickerView({
        el: this.el.querySelector('select[multiple]')
      }),
      datePicker: new tfp.DatePickerView({
        el: this.el.querySelector('input[type=date]')
      })
    };
    this.listenTo(Backbone, "commitments_form:hide", this.hide)
    this.listenTo(Backbone, "commitments_form:show", this.show)
  },
  hide: function(){
    this.views.$form.get(0).reset()
    this.views.selector.clear();
    this.views.$form.find("input[type=submit]").removeAttr('disabled')
    this.$el.slideUp()
  },
  show: function(){
    this.$el.slideDown();
  },
  events: {
    "submit": "sendForm"
  },
  sendForm: function(event) {
    event.preventDefault()
    data = new FormData(this.views.$form.get(0))
    errors = this.getErrors(data)
    if (errors.length > 0) {
      msg = "These fields are required:\n\n" + errors.join("\n");
      Backbone.trigger("flash", msg);
    }
    else {
      $button = this.views.$form.find("input[type=submit]").attr('disabled','disabled')
      //send data to the server
      xhr = new XMLHttpRequest();
      url = this.views.$form.attr('action');
      method = this.views.$form.attr('method');
      xhr.open(method, url);
      xhr.onload = function(event){
        $button.removeAttr('disabled')
        if (xhr.status < 300) {
          Backbone.trigger("flash", "Commitment added!");
          Backbone.trigger("commitments_form:hide");
        } else {
          console.log(xhr.status)
        }
      }
      xhr.send(data);
    }
  },
  getErrors: function(data) {
    fields = ["record[By Whom][]", "record[Commitment]", "record[By When]"];
    errors = _.filter(fields, function(key) {
      x = !data.get(key) ? true : false;
      return x;
    })
    return errors
  }
})

