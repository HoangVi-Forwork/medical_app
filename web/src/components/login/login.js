import React, { useState } from 'react'
import { Link } from 'react-router-dom';
import { EyeOutlined, EyeInvisibleOutlined } from '@ant-design/icons';
import '../../assets/css/login.css'
import 'bootstrap/dist/css/bootstrap.min.css';
function Home() {
    const [showPassword, setShowPassword] = useState(false);
    const [password, setPassword] = useState('');
    const togglePasswordVisibility = () => { setShowPassword(!showPassword) };
    const passwordInputType = showPassword ? 'text' : 'password';
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
                                        <p className="text-muted mb-4">Create a login split page using Reactjs & Bootstrap 5.</p>
                                        <form>
                                            <div className="mb-3">
                                                <input type="email" placeholder="Email address" className="form-control input_login rounded-pill border-0 shadow-sm px-4" />
                                            </div>
                                            <div className="mb-3">
                                                <input type={passwordInputType} name="password" className="input_login form-control rounded-pill border-0 shadow-sm px-4 text-primary form-control-pass" />
                                                <p className='password-toggle-icon' onClick={togglePasswordVisibility}>
                                                    {showPassword ? <EyeOutlined /> : <EyeInvisibleOutlined />}
                                                </p>
                                            </div>
                                            <div className="form-check">
                                                {/* <input id="customCheck1" type="checkbox" checked className="form-check-input" /> */}
                                                {/* <label for="customCheck1" className="form-check-label">Remember password</label> */}
                                            </div>
                                            <div className="d-grid gap-2 mt-2">
                                                <button type="submit" className="btn btn-primary btn-block text-uppercase mb-2 rounded-pill shadow-sm">Sign in</button>
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

export default Home;
