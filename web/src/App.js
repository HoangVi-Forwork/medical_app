import React, { useState } from 'react';
import { Route, Routes } from "react-router-dom";
import Login from './components/login/login';
import LoginComponent from './components/login/Signup.jsx'
import AppBlog from './components/Appmax.js';
import './App.css';

function App() {
  const [loggedIn, setLoggedIn] = useState(false);
  return (
    <div>
      <Routes>
        <Route path="/" element={<Login />}/>  
        <Route path='/User/*' element={<AppBlog />}/>
        <Route path="/Dangky" element={<LoginComponent />} />
      </Routes>
    </div>
  );
}

export default App;

