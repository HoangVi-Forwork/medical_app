import React, { useState, useEffect } from 'react'
import { Link } from 'react-router-dom';
import axios from "axios";
import { EyeOutlined, EyeInvisibleOutlined } from '@ant-design/icons';
import '../../assets/css/login.css'
import 'bootstrap/dist/css/bootstrap.min.css';


function Login() {
    const [showPassword, setShowPassword] = useState(false);
    const [loginStatus, setLoginStatus] = useState("");
    const togglePasswordVisibility = () => { setShowPassword(!showPassword) };
    const passwordInputType = showPassword ? 'text' : 'password';
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [errorMessage, setErrorMessage] = useState('');
    const [token, setToken] = useState('');
      const handleLogin = async (e) => {
    e.preventDefault();

    try {
      // Gửi yêu cầu đăng nhập tới server
      const response = await axios.post('http://localhost:5090/loginto', {
        email,
        password,
      });
      const { token } = response.data;
      // Lưu token vào state và localStorage
      setToken(token);
      localStorage.setItem('token', token);
      window.location.href = '/User/blog';
    } catch (error) {
      console.error(error.response.data.message);
      setErrorMessage(error.response.data.message);
    }
  };
    return (
        <div className="maincontainer ">
            <div className="container-fluid">
                <div className="row no-gutter">
                    {/* <div className="col-md-6 d-none d-md-flex bg-image"></div> */}
                    <div className="col-md-0 bg-image">
                        <div className="login d-flex align-items-center py-5">
                            <div className="container ">
                                <div className="row">
                                    <div className="col-lg-10 col-xl-7 mx-auto">
                                        <h3 className="display-8 text-primary log_in_text">Split login page!</h3>
                                        <h5 className="display-8 text-primary log_in_text">{errorMessage && <p style={{ color: 'red' }}>{errorMessage}</p>}</h5>
                                        <form>
                                            <div className="mb-3">
                                            <label className='test'>Email</label>
                                                <input onChange={(e) => { setEmail(e.target.value)}} type="email" placeholder="Email address" className="form-control input_login rounded-pill border-0 shadow-sm px-4" />
                                            </div>
                                            <div className="mb-3">
                                            <label className='test'>Password</label>
                                                <input type={passwordInputType} name="password" value={password} className="input_login form-control rounded-pill border-0 shadow-sm px-4 text-primary form-control-pass" onChange={(e) => { setPassword(e.target.value)}} />
                                                <p className='password-toggle-icon' onClick={togglePasswordVisibility}>
                                                    {showPassword ? <EyeOutlined /> : <EyeInvisibleOutlined />}
                                                </p>
                                            </div>
                                            <div className="form-check">
                                                {/* <input id="customCheck1" type="checkbox" checked className="form-check-input" /> */}
                                                {/* <label for="customCheck1" className="form-check-label">Remember password</label> */}
                                            </div>
                                            <div className="d-grid gap-2 mt-2">
                                                <button onClick={handleLogin} className="btn btn-primary">Sign in</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    )
};

export default Login;

