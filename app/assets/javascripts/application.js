//= require_tree ./lib
//= require ./bower_components/underscore/underscore-min
//= require ./bower_components/backbone/backbone-min
//= require_tree ./views
//= require ./init
//
var Backbone = require("backbone");
var tfp = require("./init");

$(function(){
  tfp.init();
})

