import React, { useState } from 'react';

import { notifyApp } from './communicator';

const Login = (props: any) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  return (
    <div>
      <h1 style={{ color: 'white' }}>WebView Login</h1>
      <div
        style={{
          display: 'flex',
          flexDirection: 'column',
          justifyContent: 'center',
          alignItems: 'center',
        }}
      >
        <p style={{ color: 'white' }}>Type any email and password</p>
        <input
          placeholder="Email"
          type={'email'}
          style={{ marginBottom: '10px', fontSize: 20 }}
          onChange={(e) => setEmail(e.target.value)}
          value={email}
        />
        <input
          placeholder="Password"
          type={'password'}
          style={{ fontSize: 20 }}
          onChange={(e) => setPassword(e.target.value)}
          value={password}
        />
        <button
          disabled={!email || !password}
          style={{ marginTop: 20, fontWeight: 'bold', fontSize: 18 }}
          onClick={() => {
            notifyApp(
              'ios',
              'onLogin',
              JSON.stringify({ token: 'bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ' })
            );
          }}
        >
          Sign In
        </button>
      </div>
    </div>
  );
};

export default Login;
