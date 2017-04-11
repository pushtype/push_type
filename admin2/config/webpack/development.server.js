// Note: You must restart bin/webpack-dev-server for changes to take effect

const merge             = require('webpack-merge')
const { join, resolve } = require('path')
const { readFileSync }  = require('fs')
const { env }           = require('process')
const { safeLoad }      = require('js-yaml')

const devConfig         = require('./development.js')
const configPath        = resolve('config', 'webpack')
const config            = safeLoad(readFileSync(join(configPath, 'config.yml'), 'utf8'))[env.NODE_ENV]
const publicPath        = `http://${config.dev_server.host}:${config.dev_server.port}/`;

module.exports = merge(devConfig, {
  devServer: {
    host: 'localhost',
    port: '8088',
    compress: true,
    historyApiFallback: true,
    contentBase: resolve(config.output, config.entry),
    publicPath
  }
})