const devConfig = require('./webpack.dev.config');
const WebpackDevServer = require('webpack-dev-server');
const webpack = require('webpack');

const HOST = 'localhost';
const PORT = '8080';

const contentBase = `http://${HOST}:${PORT}`;
const compiler = webpack(devConfig);

console.info('Starting development server. Please wait...'); // eslint-disable-line no-console

const server = new WebpackDevServer(compiler, {
  // Configure hot replacement
  hot: true,

  // The rest is terminal configurations
  quiet: false,
  noInfo: false,
  lazy: false,
  publicPath: `${contentBase}/build`,
  stats: { colors: true },
});

server.listen(PORT, HOST);

// Exit on end of STDIN
process.stdin.resume()
process.stdin.on('end', function () {
  process.exit(0)
})
