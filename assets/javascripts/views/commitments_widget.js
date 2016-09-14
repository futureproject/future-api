window.tfp = window.tfp || {};
tfp.widgets = tfp.widgets || {};

tfp.widgets.commitments = Backbone.View.extend({
  events: {
    "click .toggle-form": "toggleForm"
  },
  initialize: function(){
    this.views = {
      checklist: new tfp.widgets.tasks({
        el: this.el.querySelector("#commitments-checklist")
      }),
      form: new tfp.CommitmentsFormView({
        el: this.el.querySelector("#new-commitment")
      }),
      $toggle: this.$el.find(".toggle-form")
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
