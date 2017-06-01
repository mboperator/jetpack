const path = require('path');
const webpack = require('webpack');
const FriendlyErrorsWebpackPlugin = require('friendly-errors-webpack-plugin');
const WebpackNotifierPlugin = require('webpack-notifier');

module.exports = {
  entry: [
    'react-hot-loader/patch',
    // activate HMR for React

    'webpack-dev-server/client?http://localhost:8080',
    // bundle the client for webpack-dev-server
    // and connect to the provided endpoint

    'webpack/hot/only-dev-server',
    // bundle the client for hot reloading
    // only- means to only hot reload for successful updates

    './index.js'
    // the entry point of our app
  ],

  devServer: {
    hot: true,
    host: '0.0.0.0',
    headers: { 'Access-Control-Allow-Origin': '*' },
  },

  module: {
    rules: [
      {
        test: /\.jsx?$/,
        loader: 'babel-loader',
        exclude: /node_modules/,
        query: {
          plugins: [
            'transform-decorators-legacy',
            'transform-runtime',
            'react-hot-loader/babel',
          ],
          presets: [
            'latest',
            'react',
            ['es2015', { modules: false }],
            'stage-0',
          ]
        }
      },
      {
        test: /\.s?[ca]ss$/,
        exclude: /node_modules/,
        use: [{
          loader: 'style-loader'
        }, {
          loader: 'css-loader',
          options: {
            modules: true,
            importLoaders: 1,
            localIdentName: '[local]__[path][name]__[hash:base64:5]'
          }
        }, {
          loader: 'autoprefixer-loader',
          options: {
            browsers: 'last 2 versions'
          }
        }, {
          loader: 'sass-loader'
        }]
      }
    ]
  },

  output: {
    path: path.join(__dirname, 'dist'),
    publicPath: 'http://localhost:8080/build/',
    filename: 'app.js',
  },

  plugins: [
    new FriendlyErrorsWebpackPlugin(),

    new WebpackNotifierPlugin({ alwaysNotify: false }),

    new webpack.HotModuleReplacementPlugin(),

    new webpack.NamedModulesPlugin(),
  ],

  resolve: {
    extensions: ['.js', '.jsx'],
    alias: {
      react: path.resolve('./node_modules/react'),
      'react-dom': path.resolve('./node_modules/react-dom')
    }
  },

  devtool: 'eval-cheap-module-source-map',
};
