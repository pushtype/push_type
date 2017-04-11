const { join, resolve } = require('path')
const { readFileSync }  = require('fs')
const { env }           = require('process')
const { safeLoad }      = require('js-yaml')

const configPath        = resolve('config', 'webpack')
const config            = safeLoad(readFileSync(join(configPath, 'config.yml'), 'utf8'))[env.NODE_ENV]
const publicPath        = env.NODE_ENV === 'development' && config.dev_server.enabled ?
      `http://${config.dev_server.host}:${config.dev_server.port}/` : `/${config.output}/`;

module.exports = {
  test: /\.(jpeg|png|gif|svg|eot|ttf|woff|woff2)$/i,
  use: [{
    loader: 'file-loader',
    options: {
      publicPath,
      name: env.NODE_ENV === 'production' ? '[name]-[hash].[ext]' : '[name].[ext]'
    }
  }]
}