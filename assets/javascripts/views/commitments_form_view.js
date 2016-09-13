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
    }
  }
})

