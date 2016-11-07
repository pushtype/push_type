// ./node_modules/.bin/webpack --config config/webpack.config.js

var path = require('path');
var webpack = require('webpack');

module.exports = {
  entry: {
    admin:      './app/webpack/javascripts/admin.es6'
  },

  output: {
    path:       path.join(__dirname, '..', 'app', 'assets', 'javascripts', 'push_type', 'webpack'),
    publicPath: '/webpack/',
    filename:   '[name].bundle.js'
  },

  resolve: {
    root:       path.join(__dirname, '..', 'app', 'webpack')
  },

  module: {
    loaders: [
      { test: /\.es6$/, loader: 'babel', query: { presets: ['es2015'] } },
      { test: /\.vue$/, loader: 'vue' }
    ]
  },

  plugins: [
    new webpack.IgnorePlugin(/unicode\/category\/So$/)
  ]
};