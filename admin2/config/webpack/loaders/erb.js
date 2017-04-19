module.exports = {
  test: /\.erb$/,
  enforce: 'pre',
  exclude: /node_modules/,
  loader: 'rails-erb-loader',
  options: {
    runner: 'DISABLE_SPRING=1 ruby -r bundler/setup -r rails/all -r ./lib/push_type_admin.rb'
  }
}