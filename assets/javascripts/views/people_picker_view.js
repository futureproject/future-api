window.tfp = window.tfp || {}
tfp.PeoplePickerView = Backbone.View.extend({
  initialize: function(){
    this.$el.selectize({
      valueField: 'id',
      labelField: 'name',
      searchField: 'name',
      create: false,
      closeAfterSelect: !!navigator.userAgent.match(/ipad|iphone|ipod/i),
      load: function(query, callback) {
        if (!query.length) return callback();
        console.log(callback)
        $.ajax({
          url: '/api/students?q=' + encodeURIComponent(query),
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
  }
})
