// Note: You must restart bin/webpack-watcher for changes to take effect
/* eslint global-require: 0 */
/* eslint import/no-dynamic-require: 0 */

const webpack           = require('webpack')
const { join, resolve, relative } = require('path')
const { readdirSync, readFileSync } = require('fs')
const { env }           = require('process')
const { safeLoad }      = require('js-yaml')

const ExtractTextPlugin = require('extract-text-webpack-plugin')
const ManifestPlugin    = require('webpack-manifest-plugin')

const configPath        = resolve('config', 'webpack')
const loadersDir        = join(__dirname, 'loaders')
const config            = safeLoad(readFileSync(join(configPath, 'config.yml'), 'utf8'))[env.NODE_ENV]
const publicPath        = env.NODE_ENV === 'development' && config.dev_server.enabled ?
      `http://${config.dev_server.host}:${config.dev_server.port}/` : `/${config.output}/`;

module.exports = {
  entry: {
    'admin': resolve(config.source, config.entry, 'js', 'admin.js'),
  },

  output: {
    filename: '[name].js', path: resolve(config.output, config.entry)
  },

  module: {
    rules: readdirSync(loadersDir).map(file => (
      require(join(loadersDir, file))
    ))
  },

  plugins: [
    new webpack.EnvironmentPlugin(JSON.parse(JSON.stringify(env))),
    new ExtractTextPlugin(env.NODE_ENV === 'production' ? '[name]-[hash].css' : '[name].css'),
    new ManifestPlugin({ fileName: config.manifest, publicPath, writeToFileEmit: true })
  ],

  resolve: {
    extensions: config.extensions,
    modules: [
      resolve(config.source, config.entry),
      resolve(config.node_modules)
    ]
  },

  resolveLoader: {
    modules: [config.node_modules]
  }

};
