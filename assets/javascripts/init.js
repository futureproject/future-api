var tfp = window.tfp || {}
tfp.widgets = tfp.widgets || {};

$(function(){
  tfp.widgets.commitments = tfp.checklistView.extend()
  tfp.widgets.tasks = tfp.checklistView.extend()
  // initialize all dashboard modules
  $(".module").each(function(){
    new tfp.ModuleView({
      el: this
    })
  })

  // activate EMBEDS
  $(".embed").each(function(){
    new tfp.EmbedView({
      el: this
    })
  })

  // activate WIDGETS
  $(".widget").each(function(){
    new tfp.WidgetView({
      el: this
    })
  })
  tfp.flasher = new tfp.FlashView()
})
