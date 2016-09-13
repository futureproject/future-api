window.tfp = window.tfp || {}

tfp.DatePickerView = Backbone.View.extend({
  initialize: function(){
    test = document.createElement('input');
    test.type = "date";
    if (test.type === "date") {
      return true;
    } else {
      this.pika = new Pikaday({
        field: this.el,
        firstDay: 1,
        yearRange: 5,
        defaultDate: new Date()
      })
    }
  }
})

