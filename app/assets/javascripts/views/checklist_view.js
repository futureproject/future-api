var toggler = require("./toggler_view");

module.exports = Backbone.View.extend({
  events: {
    "click .toggler-form-toggle": "toggleForm"
  },
  initialize: function(){
    this.views = {
      checklist: new toggler({
        el: this.el.querySelector(".toggler-checklist")
      }),
    }
    this.views.form.$el.hide();
  },
})
