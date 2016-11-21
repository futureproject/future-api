module.exports = Backbone.View.extend({
  initialize: function(){
    var endpoint = this.$el.attr("data-endpoint");
    this.$el.selectize({
      plugins: ['remove_button'],
      valueField: 'id',
      labelField: 'name',
      searchField: 'name',
      create: false,
      closeAfterSelect: true,
      load: function(query, callback) {
        if (!query.length) return callback();
        $.ajax({
          url: endpoint + '?q=' + encodeURIComponent(query),
          type: 'GET',
          error: function() {
            callback();
          },
          success: function(res) {
            callback(res.slice(0, 10));
          }
        });
      },
      render: {
        option: function(item, escape) {
          return '<div>' +
              '<span class="title">' + escape(item.name) + '</span>' +
              '<span class="description"> - ' + escape(item.school_tfpid) + '</span>'
          '</div>';
        }
      }
    })
  },
  clear: function(){
    this.el.selectize.clear()
  },
})
