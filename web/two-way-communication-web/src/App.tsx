import React from 'react';
import { Fragment } from 'react';
import './App.css';
import Login from './Login';

import { BrowserRouter, Routes, Route } from 'react-router-dom';

function App() {
  return (
    <div className='App'>
      <BrowserRouter>
        <Fragment>
          <Routes>
            <Route path="/login" element={<Login />} />
          </Routes>
        </Fragment>
      </BrowserRouter>
    </div>
  );
}

export default App;
