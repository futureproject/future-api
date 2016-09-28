window.tfp = window.tfp || {};

tfp.checklistView = Backbone.View.extend({
  events: {
    "click .toggler-form-toggle": "toggleForm"
  },
  initialize: function(){
    this.views = {
      checklist: new tfp.togglerView({
        el: this.el.querySelector(".toggler-checklist")
      }),
      form: new tfp.CommitmentsFormView({
        el: this.el.querySelector(".toggler-form")
      }),
      $toggle: this.$el.find(".toggler-form-toggle")
    }
    this.listenTo(Backbone, "commitments_form:hide", this.hideForm);
    this.listenTo(Backbone, "commitments_form:show", this.showForm);
    Backbone.trigger("commitments_form:hide");
    this.views.form.$el.hide();
  },
  toggleForm: function(event) {
    event.preventDefault();
    if (this.visible) {
      Backbone.trigger("commitments_form:hide")
    } else {
      Backbone.trigger("commitments_form:show")
    }
  },
  showForm: function(event) {
    this.visible = true;
    this.views.$toggle.text("Cancel").addClass("cancel")
  },
  hideForm: function(event) {
    this.visible = false;
    this.views.$toggle.text("Add New").removeClass("cancel")
  }
})
