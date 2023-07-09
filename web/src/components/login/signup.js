// import React, { useState } from 'react'
// import { Link } from 'react-router-dom';
// import { EyeOutlined, EyeInvisibleOutlined } from '@ant-design/icons';
// import { PlusOutlined } from '@ant-design/icons';
// import { Modal, Form, Input, Select, Upload, message } from 'antd';

// import '../../assets/css/login.css'
// import 'bootstrap/dist/css/bootstrap.min.css';

// const { TextArea } = Input;
// const { Option } = Select;

// function Signup() {
//     const [showPassword, setShowPassword] = useState(false);
//     const [password, setPassword] = useState('');
//     const [Enterpassword, setEnterpassword] = useState('');
//     const [email, setEmauil] = useState('');
//     const [powers, setpowers] = useState('');
//     const togglePasswordVisibility = () => { setShowPassword(!showPassword) };
//     const passwordInputType = showPassword ? 'text' : 'password';


//     const handState = (value) => {
//         setpowers(value);
//     };
//     return (
//         <div className="maincontainer ">
//             <div className="container-fluid">
//                 <div className="row no-gutter">
//                     {/* <div className="col-md-6 d-none d-md-flex bg-image"></div> */}
//                     <div className="col-md-0 bg-image">
//                         <div className="login d-flex align-items-center py-5">
//                             <div className="container ">
//                                 <div className="row">
//                                     <div className="col-lg-10 col-xl-7 mx-auto">
//                                         <h3 className="display-8 text-primary log_in_text">Split login page!</h3>
//                                         <p className="text-muted mb-4">Create a login split page using Reactjs & Bootstrap 5.</p>
//                                         <form>
//                                             <div className="mb-3">
//                                             <label className='test'>State</label>

//                                                 <input type="email" placeholder="Email address" className="form-control input_login border-0 shadow-sm px-4" name='email' value={email} onChange={(e) => setEmauil(e.target.value)} />
//                                             </div>
//                                             <div className="mb-3">
//                                             <label className='test'>State</label>
//                                                 <input type={passwordInputType} name="password" className="input_login form-control  border-0 shadow-sm px-4 text-primary form-control-pass" value={password} onChange={(e) => setPassword(e.target.value)} />
//                                                 <p className='password-toggle-icon' onClick={togglePasswordVisibility}>
//                                                     {showPassword ? <EyeOutlined /> : <EyeInvisibleOutlined />}
//                                                 </p>
//                                             </div>
//                                             <div className="mb-3">
//                                             <label className='test'>State</label>
//                                                 <input type={passwordInputType} name="Enterpassword" className="input_login form-control border-0 shadow-sm px-4 text-primary form-control-pass" value={Enterpassword} onChange={(e) => setEnterpassword(e.target.value)} />
//                                                 <p className='password-toggle-icon' onClick={togglePasswordVisibility}>
//                                                     {showPassword ? <EyeOutlined /> : <EyeInvisibleOutlined />}
//                                                 </p>
//                                             </div>
//                                             <div className="mb-3">
//                                                 <label className='test'>State</label>
//                                                 <Form.Item >
//                                                     <Select
//                                                         onChange={handState}
//                                                         value={powers}
//                                                         placeholder="Storage location"
//                                                         defaultValue="Study"
//                                                         size="large"
//                                                     >
//                                                         <Option value="Study" className="custom-option">Study</Option>
//                                                         <Option value="Travel" className="custom-option">Travel</Option>
//                                                         <Option value="Offshore" className="custom-option">Offshore</Option>
//                                                         <Option value="Outsourcing" className="custom-option">Outsourcing</Option>
//                                                     </Select>
//                                                 </Form.Item>
//                                             </div>
//                                             <div className="d-grid gap-2 mt-2">
//                                                 <button type="submit" className="btn btn-primary btn-block text-uppercase mb-2 rounded-pill shadow-sm">Sign in</button>
//                                             </div>
//                                         </form>
//                                     </div>
//                                 </div>
//                             </div>
//                         </div>
//                     </div>
//                 </div>
//             </div>
//         </div>

//     )
// };

// export default Signup;

import React, { useState } from 'react';
import axios from 'axios';

const RegisterForm = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [setpassword, setSetPassword] = useState('');
    const [quyenhan, setQuyenhan] = useState('');
    const [message, setMessage] = useState('');
      const handleSubmit = async (e) => {
        e.preventDefault();
    
        // Kiểm tra password và setpassword giống nhau
        if (password !== setpassword) {
          setMessage('Mật khẩu không khớp.');
          return;
        }
    
        try {
          // Gửi yêu cầu POST đăng ký đến server
          const response = await axios.post('http://localhost:5090/api/register', {
            email,
            password,
            setpassword,
            quyenhan
          });
    
          // Xử lý phản hồi từ server
          if (response.status === 200) {
            setMessage(response.data.message);
          } else if (response.status === 409) {
            setMessage(response.data.message);
            console.log('chao2')
          } else {
            setMessage('Đã xảy ra lỗi. Vui lòng lại sau.');
          }
        } catch (error) {
          console.error(error);
          setMessage('Đã xảy ra lỗi. Vui lòng thử sau.');
        }
      };

    return (
        <div>
           {message && <p>{message}</p>}
            <form >

                <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} placeholder="Email" />
                <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} placeholder="Password" />
                <input type="password" value={setpassword} onChange={(e) => setSetPassword(e.target.value)} placeholder="Confirm Password" />
                <input type="text" value={quyenhan} onChange={(e) => setQuyenhan(e.target.value)} placeholder="Quyền hạn" />
                <button onClick={handleSubmit} type="submit">Đăng ký</button>
            </form>
        </div>
    );
};

export default RegisterForm;
