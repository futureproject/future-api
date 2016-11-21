var pikaday = require("pikaday");

module.exports = Backbone.View.extend({
  initialize: function(){
    var test = document.createElement('input');
    test.type = "date";
    if (test.type === "date") {
      return true;
    } else {
      this.pika = new pikaday({
        field: this.el,
        firstDay: 1,
        yearRange: 5,
        defaultDate: new Date()
      })
    }
  }
})

