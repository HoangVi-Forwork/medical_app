import React, { useState } from 'react';
import { Route, Routes } from "react-router-dom";
import Login from './components/login/login';
import Signup from './components/login/Signup';
import AppBlog from './components/Appmax.js';
import './App.css';

function App() {
  const [loggedIn, setLoggedIn] = useState(false);
  return (
    <div>
      <Routes>
        <Route path="/" element={<Login />} setLoggedIn={setLoggedIn} />
        <Route path="/Dangky" element={<Signup />} />
        <Route path="/User/*" element={<AppBlog />} loggedIn={loggedIn} />
      </Routes>
    </div>
  );
}

export default App;