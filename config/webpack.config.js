'use strict';

const fs = require('fs');
const webpack = require("webpack");
const ExtractTextPlugin = require("extract-text-webpack-plugin");

const prod = process.argv.indexOf('-p') !== -1;
const css_output_template = prod ? "[name]-[hash].css" : "[name].css";
const js_output_template = prod ? "[name]-[hash].js" : "[name].js";

module.exports = {
  context: __dirname + "/../app/assets",

  entry: {
    application: ["./javascripts/application.js", "./stylesheets/screen.scss"],
  },

  output: {
    path: __dirname + "/../public/assets",
    filename: js_output_template,
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel',
        query: {
          presets: ['es2015']
        }
      },
      {
        test: /\.scss$|\.css$/,
        loader: ExtractTextPlugin.extract("css!sass")
      },
    ]
  },

  plugins: [

    new webpack.ProvidePlugin({
      $: "jquery",
      jQuery: "jquery",
      "window.jQuery": "jquery"
    }),

    new ExtractTextPlugin(css_output_template),

    function() {
      // output the fingerprint
      this.plugin("done", function(stats) {
        let output = stats.hash;
        fs.writeFileSync("public/assets/fingerprint.txt", output, "utf8");
      });
    }
  ],
};
