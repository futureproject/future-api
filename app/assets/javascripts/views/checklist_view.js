var toggler = require("./toggler_view");

module.exports = Backbone.View.extend({
  initialize: function(){
    this.views = {
      checklist: new toggler({
        el: this.el.querySelector(".toggler-checklist")
      }),
    }
  },
})
