module.exports = {
  views: {
    checklist: require('./views/checklist_view'),
    module: require('./views/modules'),
    widget: require('./views/widgets'),
    widget_manager: require('./views/widget_manager'),
    flash: require('./views/flash'),
    commitments_form: require('./views/commitments_form'),
    people_picker: require('./views/people_picker_view'),
    toggler: require('./views/toggler_view'),
    flash: require('./views/flash'),
    embed: require('./views/embeds'),
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
    self.widgetManager = new self.views.widget_manager({
      widgets: self.widgets
    });
    self.flasher = new self.views.flash()
  }
}
