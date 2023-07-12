// import React, { useState, useEffect } from 'react'
// import { Link } from 'react-router-dom';
// import Axios from "axios";
// import { EyeOutlined, EyeInvisibleOutlined } from '@ant-design/icons';
// import '../../assets/css/login.css'
// import 'bootstrap/dist/css/bootstrap.min.css';


// function Login() {
//     const [showPassword, setShowPassword] = useState(false);
//     const [email, setemail] = useState("");
//     const [password, setPassword] = useState("");
//     const [loginStatus, setLoginStatus] = useState("");

//     const togglePasswordVisibility = () => { setShowPassword(!showPassword) };
//     const passwordInputType = showPassword ? 'text' : 'password';

//     const login = () => {
//         Axios.post("http://localhost:5090/api/login", {
//         email: email,
//         password: password,
//         }).then((response) => {
//           if (response.data.message) {
//             setLoginStatus(response.data.message);
//           } else {
//             setLoginStatus(response.data[0].email);
//           }
//         });
//       };
    
//       useEffect(() => {
//         Axios.get("http://localhost:5090/api/login").then((response) => {
//           if (response.data.loggedIn === true) {
//             setLoginStatus(response.data.user[0].email);
//           }
//         });
//       }, []);
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
//                                         <h1>{loginStatus}</h1>
//                                         <p className="text-muted mb-4">Create a login split page using Reactjs & Bootstrap 5.</p>
//                                         <form>
//                                             <div className="mb-3">
//                                                 <input onChange={(e) => { setemail(e.target.value)}} type="email" placeholder="Email address" className="form-control input_login rounded-pill border-0 shadow-sm px-4" />
//                                             </div>
//                                             <div className="mb-3">
//                                                 <input type={passwordInputType} name="password" value={password} className="input_login form-control rounded-pill border-0 shadow-sm px-4 text-primary form-control-pass" onChange={(e) => { setPassword(e.target.value)}} />
//                                                 <p className='password-toggle-icon' onClick={togglePasswordVisibility}>
//                                                     {showPassword ? <EyeOutlined /> : <EyeInvisibleOutlined />}
//                                                 </p>
//                                             </div>
//                                             <div className="form-check">
//                                                 {/* <input id="customCheck1" type="checkbox" checked className="form-check-input" /> */}
//                                                 {/* <label for="customCheck1" className="form-check-label">Remember password</label> */}
//                                             </div>
//                                             <div className="d-grid gap-2 mt-2">
//                                                 <button onClick={login} className="btn btn-primary btn-block text-uppercase mb-2 rounded-pill shadow-sm">Sign in</button>
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

// export default Login;


// import React, { useState, useEffect } from 'react';
// import axios from 'axios';
// import { useNavigate } from 'react-router-dom';

// function Login() {
//   const [email, setEmail] = useState('');
//   const [password, setPassword] = useState('');
//   const [message, setMessage] = useState('');
//   const history = useNavigate();
//   const handleLogin = async () => {
//     axios.post("http://localhost:5090/api/login", {
//       email: email,
//       password: password,
      
//     }).then((response) => {
//       if(response.data.message){
//         setMessage(response.data.message);
//         history('/User')
//         window.location.reload(true);
//       }else{
//         // history('/User')
//         setMessage(response.data.message);
//         // window.location.reload(true);
//         // setLoginStatus(response.data[0].email);
//       }
//     })
//   };
  
//   return (
//     <div>
//       <input
//         type="text"
//         value={email}
//         onChange={e => setEmail(e.target.value)}
//         placeholder="Email"
//       />
//       <input
//         type="password"
//         value={password}
//         onChange={e => setPassword(e.target.value)}
//         placeholder="Password"
//       />
//       <button onClick={handleLogin}>Đăng nhập</button>
//       {message && <p>{message}</p>}
//     </div>
//   );
// }

// export default Login;

// client/src/components/Login.js
// import React, { useState } from 'react';

// const Login = () => {
//   const [email, setEmail] = useState('');
//   const [password, setPassword] = useState('');
//   const [message, setMessage] = useState('');
//   const handleLogin = () => {
//     // Gửi yêu cầu đăng nhập đến API Node.js
//     fetch('http://localhost:5090/api/logint', {
//       method: 'POST',
//       headers: { 'Content-Type': 'application/json' },
//       body: JSON.stringify({ email, password }),
//     })
//       .then((response) => response.json())
//       .then((data) => {
//         console.log(data.message);
//         // Kiểm tra kết quả từ API và chuyển hướng người dùng đến trang User
//         if (data.message === 'Đăng nhập thành công') {
//           window.location.href = '/User';
//         }
//       })
//       .catch((error) => console.error('Đã xảy ra lỗi:', error));
//   };

//   return (
//     <div>
//       <h2>Đăng nhập</h2>
//       <input
//         type="email"
//         placeholder="Email"
//         value={email}
//         onChange={(e) => setEmail(e.target.value)}
//       />
//       <input
//         type="password"
//         placeholder="Mật khẩu"
//         value={password}
//         onChange={(e) => setPassword(e.target.value)}
//       />
//       <button onClick={handleLogin}>Đăng nhập</button>
//     </div>
//   );
// };

// export default Login;

// client/src/components/Login.js
import React, { useState } from 'react';

const Login = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [message, setMessage] = useState('');

  const handleLogin = () => {
    // Gửi yêu cầu đăng nhập đến API Node.js
    fetch('http://localhost:5090/api/logint', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email, password }),
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.message === 'Tài khoản không tồn tại') {
          setMessage('Tài khoản không tồn tại. Vui lòng kiểm tra lại.');
        } else if (data.message === 'Mật khẩu không chính xác') {
          setMessage('Mật khẩu không chính xác. Vui lòng kiểm tra lại.');
        } else {
          setMessage('Đã xảy ra lỗi. Vui lòng thử lại sau.');
        }
        // Kiểm tra kết quả từ API và chuyển hướng người dùng đến trang User
        if (data.message === 'Đăng nhập thành công') {
          window.location.href = '/user';
        }
      })
      .catch((error) => console.error('Đã xảy ra lỗi:', error));
  };

  return (
    <div>
      <h2>Đăng nhập</h2>
      <input
        type="email"
        placeholder="Email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
      />
      <input
        type="password"
        placeholder="Mật khẩu"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
      />
      <button onClick={handleLogin}>Đăng nhập</button>
      <p>{message}</p> {/* Hiển thị thông báo */}
    </div>
  );
};

export default Login;
