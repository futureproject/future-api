$(function(){
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
