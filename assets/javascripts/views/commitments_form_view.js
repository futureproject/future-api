window.tfp = window.tfp || {};

tfp.CommitmentsFormView = Backbone.View.extend({
  initialize: function(){
    this.views = {
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
    this.el.querySelector('form').reset()
    this.views.selector.clear();
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
    console.log(event)
  }
})

