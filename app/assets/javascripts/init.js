module.exports = {
  views: {
    checklist: require('./views/checklist_view'),
    module: require('./views/modules'),
    widget: require('./views/widgets'),
    widget_manager: require('./views/widget_manager'),
    flash: require('./views/flash'),
    commitments_form: require('./views/commitments_form'),
    toggler: require('./views/toggler_view'),
    embed: require('./views/embeds'),
    airtable_form_view: require('./views/airtable_forms'),
  },
  widgets: {
  },
  init: function(){
    var self = this;
    self.widgets.commitments = self.views.checklist.extend()
    self.widgets.tasks = self.views.checklist.extend()

    // initialize all dashboard modules
    $(".module").each(function(){
      new self.views.module({
        el: this
      })
    })

    // activate EMBEDS
    $(".embed").each(function(){
      new self.views.embed({
        el: this
      })
    })

    // activate WIDGETS
    $(".widget").each(function(){
      new self.views.widget({
        el: this
      })
    })

    self.airtableFormView = new self.views.airtable_form_view({
      el: '#airtable-forms'
    })

    self.widgetManager = new self.views.widget_manager({
      widgets: self.widgets
    });

    self.flasher = new self.views.flash()
  }
}
