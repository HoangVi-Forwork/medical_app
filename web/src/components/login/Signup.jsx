import React, { useState } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
import { EyeOutlined, EyeInvisibleOutlined } from '@ant-design/icons';

import { PlusOutlined } from '@ant-design/icons';
import { Modal, Form, Input, Select, Upload, message } from 'antd';
import '../../assets/css/login.css'
import 'bootstrap/dist/css/bootstrap.min.css';

const { TextArea } = Input;
const { Option } = Select;
const getBase64 = (file) =>
  new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => resolve(reader.result);
    reader.onerror = (error) => reject(error);
  });

const Sinup = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [setpassword, setSetPassword] = useState('');
  const [message, setMessage] = useState('');
  const [Enterpassword, setEnterpassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [showPasswordset, sohwShowPassword] = useState(false);
  const [powers, setpowers] = useState('');
  const togglePasswordVisibility = () => { setShowPassword(!showPassword) };
  const passwordInputType = showPassword ? 'text' : 'password';
  const togglePasswordVisibilit = () => { sohwShowPassword(!showPasswordset) };
  const passwordInput = showPasswordset ? 'text' : 'password';
  const [avatar, setAvatar] = useState('');
  const [previewOpen, setPreviewOpen] = useState(false);
  const [previewImage, setPreviewImage] = useState('');
  const [previewTitle, setPreviewTitle] = useState('');
  const [name, setName] = useState('');
  const [phone, setphone] = useState('');
  const [address, setaddress] = useState('');
  const [gioitinh, setgiotinh] = useState('');

  const handState = (value) => {
    setpowers(value);
  };

  const handgiotinh = (value) => {
    setgiotinh(value);
  }

  const normFile = (e) => {
    if (Array.isArray(e)) {
      return e;
    }
    return e && e.fileList;
  };

  const handleImageUpload2 = async (file) => {
    const formData = new FormData();
    formData.append('file', file);
    formData.append('upload_preset', 'pbby1fhc');
    try {
      const response = await axios.post(
        'https://api.cloudinary.com/v1_1/dpe65cn71/image/upload',
        formData
      );
      if (response.status === 200) {
        const avatar = response.data.secure_url;
        setAvatar(avatar);
      }
    } catch (error) {
      console.log(error);
    }
  };

  const handleCancel = () => setPreviewOpen(false);

  const handleFileChange02 = (e) => {
    const file = e.target.files[0];
    handleImageUpload2(file);
  };

  const handlePreview = async (file) => {
    if (!file.url && !file.preview) {
      file.preview = await getBase64(file.originFileObj);
    }
    setPreviewImage(file.url || file.preview);
    setPreviewOpen(true);
    setPreviewTitle(file.name || file.url.substring(file.url.lastIndexOf('/') + 1));
  };
  const handleSubmit = async (e) => {
    e.preventDefault();

    // Kiểm tra password và setpassword giống nhau
    if (email === "") {
      setMessage('Email trống');
      return;
    } else if (!email.match(/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$/)) {
      setMessage('Email không hợp lệ');
      return;
    } else if (!password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/)) {
      setMessage('Mật khẩu phải chứa ít nhất một chữ cái thường, một chữ cái hoa và có độ dài tối thiểu là 8 ký tự.');
      return;
    } else if (password !== setpassword) {
      setMessage('Mật khẩu không khớp.');
      return;
    }

    try {
      // Gửi yêu cầu POST đăng ký đến server
      const response = await axios.post('http://localhost:5090/api/register', {
        email,
        password,
        setpassword,
        powers,
        name,
        phone,
        address,
        gioitinh,
        avatar,
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
    // <div>
    //    {message && <p>{message}</p>}
    //     <form >
    //         <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} placeholder="Email" />
    //         <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} placeholder="Password" />
    //         <input type="password" value={setpassword} onChange={(e) => setSetPassword(e.target.value)} placeholder="Confirm Password" />
    //         <input type="text" value={quyenhan} onChange={(e) => setQuyenhan(e.target.value)} placeholder="Quyền hạn" />
    //         <button onClick={handleSubmit} type="submit">Đăng ký</button>
    //     </form>

    // </div>
    <div className="maincontainer ">
      <div className="container-fluid">
        <div className="row no-gutter">
          {/* <div className="col-md-6 d-none d-md-flex bg-image"></div> */}
          <div className="col-md-0 bg-image">
            <div className="login d-flex align-items-center py-5">
              <div className="container ">
                <div className="row">
                  <div className="col-lg-10 col-xl-7 mx-auto">
                    <h3 className="display-8 text-primary log_in_text">Register an account !</h3>
                    <h6 className="display-8 log_in_text">{message && <p>{message}</p>}</h6>
                    <form>
                      <div className="mb-3">
                        <label className='test'>Email</label>
                        <input type="email" placeholder="Email address" className="form-control input_login border-0 shadow-sm px-4" value={email} onChange={(e) => setEmail(e.target.value)} />
                      </div>
                      {/*  */}
                      <div className="mb-3">
                        <label className='test'>Name</label>
                        <input type="name" placeholder="Name address" className="form-control input_login border-0 shadow-sm px-4" value={name} onChange={(e) => setName(e.target.value)} />
                      </div>
                      <div className="mb-3">
                        <label className='test'>Phone Number</label>
                        <input type="phone" placeholder="Phone address" className="form-control input_login border-0 shadow-sm px-4" value={phone} onChange={(e) => setphone(e.target.value)} />
                      </div>
                      <div className="mb-3">
                        <label className='test'>Address</label>
                        <input type="address" placeholder="Address address" className="form-control input_login border-0 shadow-sm px-4" value={address} onChange={(e) => setaddress(e.target.value)} />
                      </div>

                      {/*  */}
                      <div className="mb-3">
                        <label className='test'>Password</label>
                        <input type={passwordInputType} name="password" className="input_login form-control  border-0 shadow-sm px-4 text-primary form-control-pass" value={password} onChange={(e) => setPassword(e.target.value)} />
                        <p className='password-toggle-icon' onClick={togglePasswordVisibility}>
                          {showPassword ? <EyeOutlined /> : <EyeInvisibleOutlined />}
                        </p>
                      </div>
                      <div className="mb-3">
                        <label className='test'>Confirm Password</label>
                        <input type={passwordInput} name="Enterpassword" className="input_login form-control border-0 shadow-sm px-4 text-primary form-control-pass" value={setpassword} onChange={(e) => setSetPassword(e.target.value)} placeholder="Confirm Password" />
                      </div>
                      <div className="form-group">
                        <label>Avatar</label>
                        <Form.Item
                          valuePropName="fileList"
                          getValueFromEvent={normFile}
                          onChange={handleFileChange02}
                        >
                          <Upload
                            name="avatar"
                            src={avatar}
                            listType="picture-card"
                            className="avatar-uploader"
                            maxCount={1}
                            beforeUpload={handleFileChange02}
                            onPreview={handlePreview}
                          >
                            <div>
                              <PlusOutlined />
                              <div style={{ marginTop: 8 }}>Img Blog</div>
                            </div>
                          </Upload>
                          <Modal
                            open={previewOpen}
                            title={previewTitle}
                            footer={null}
                            onCancel={handleCancel}
                          >
                            <img alt="example" style={{ width: '100%' }} src={previewImage} />
                          </Modal>
                        </Form.Item>
                      </div>
                      <div className="mb-3">
                        <label className='test'>Gender</label>
                        <Form.Item >
                          <Select
                            onChange={handgiotinh}
                            value={gioitinh}
                            placeholder="Storage location"
                            defaultValue="Study"
                            size="large"
                          >
                            <Option value="1" className="custom-option">Nam</Option>
                            <Option value="2" className="custom-option">Nữ</Option>
                          </Select>
                        </Form.Item>
                      </div>
                      <div className="mb-3">
                        <label className='test'>Powers</label>
                        <Form.Item >
                          <Select
                            onChange={handState}
                            value={powers}
                            placeholder="Storage location"
                            defaultValue="Study"
                            size="large"
                          >
                            <Option value="1" className="custom-option">Admin</Option>
                            <Option value="2" className="custom-option">User</Option>
                          </Select>
                        </Form.Item>
                      </div>
                      <div className="d-grid gap-2 mt-2">
                        <button onClick={handleSubmit} type="submit" className="btn btn-primary">Sign in</button>
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
  );
};

export default Sinup;
