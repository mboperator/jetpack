import React from 'react';
import { render } from 'react-dom';
import App from './App';

const node = document.querySelector('#root');
render(<App />, node);

if (module.hot) {
  module.hot.accept('./App', () => {
    const HotLoadedApp = require('./App').default;
    render(<App />, node);
  });
}
