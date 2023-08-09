import React, { useState, useEffect } from 'react';
import JoditEditor from 'jodit-react';
import 'bootstrap/dist/css/bootstrap.min.css';
import Axios from 'axios';
import { PlusOutlined } from '@ant-design/icons';
import { Modal, Form, Input, Select, Upload, message } from 'antd';
import { editorConfig } from './EdittorConfig';
import '../../assets/css/blog.css';
import { Link } from 'react-router-dom';
const { TextArea } = Input;
const { Option } = Select;
const getBase64 = (file) =>
  new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => resolve(reader.result);
    reader.onerror = (error) => reject(error);
  });

const App_blog = () => {
  const [editorContent, setEditorContent] = useState('');
  const [previewOpen, setPreviewOpen] = useState(false);
  const [tenbenh, settenbenh] = useState('');
  const [previewTitle, setPreviewTitle] = useState('');
  const [previewImage, setPreviewImage] = useState('');
  const [hinhanh, sethinhanh] = useState('');
  const [trieuchung, settrieuchung] = useState('');
  const [nguyennhan, setnguyennhan] = useState('');
  const [phongngua, setphongngua] = useState('');
  const [noidung, setnoidung] = useState('');
  const [idLoaibenh, setidLoaibenh] = useState('');
  const [imageUrl, setImageUrl] = useState('');
  const [tenrieng, settenrieng] = useState('');


  const handleImageUpload2 = async (file) => {
    const formData = new FormData();
    formData.append('file', file);
    formData.append('upload_preset', 'aoxxeyys');
    try {
      const response = await Axios.post(
        'https://api.cloudinary.com/v1_1/drhcszyj0/image/upload',
        formData
      );
      if (response.status === 200) {
        const imgBlog = response.data.secure_url;
        sethinhanh(imgBlog);
      }
    } catch (error) {
      console.log(error);
    }
  };
  const handleEditorChange = (newContent) => {
    setEditorContent(newContent);
  };
  const normFile = (e) => {
    if (Array.isArray(e)) {
      return e;
    }
    return e && e.fileList;
  };
  const handleFileChange02 = (e) => {
    const file = e.target.files[0];
    handleImageUpload2(file);
  };
  const handleCancel = () => setPreviewOpen(false);
  const handlePreview = async (file) => {
    if (!file.url && !file.preview) {
      file.preview = await getBase64(file.originFileObj);
    }
    setPreviewImage(file.url || file.preview);
    setPreviewOpen(true);
    setPreviewTitle(file.name || file.url.substring(file.url.lastIndexOf('/') + 1));
  };
  // 
  const handleFileChange = (e) => {
    const file = e.target.files[0];
    handleImageUpload(file);
  };
  const handleImageUpload = async (file) => {
    const formData = new FormData();
    formData.append('file', file);
    formData.append('upload_preset', 'aoxxeyys');
    try {
      const response = await Axios.post(
        'https://api.cloudinary.com/v1_1/drhcszyj0/image/upload',
        formData
      );
      if (response.status === 200) {
        const imageUrl = response.data.secure_url;
        const imageTag = `<img src="${imageUrl}" alt="" />`;
        const newContent = editorContent + imageTag;
        setEditorContent(newContent);
      }
    } catch (error) {
      console.log(error);
    }
  };
  const handleVideoUpload = async (file) => {
    const formData = new FormData();
    formData.append('file', file);
    formData.append('upload_preset', 'aoxxeyys');
    try {
      const response = await Axios.post(
        'https://api.cloudinary.com/v1_1/drhcszyj0/video/upload',
        formData
      );
      if (response.status === 200) {
        const videoUrl = response.data.secure_url;
        const videoTag = `<video style="width: 700px"; src="${videoUrl}" controls/>`;
        const newContent = editorContent + videoTag;
        setEditorContent(newContent);
      }
    } catch (error) {
      console.log(error);
    }
  };

  const handleVideoChange = (e) => {
    const file = e.target.files[0];
    handleVideoUpload(file);
  };
  const handleSubmit = async () => {
    try {
      // Send data to the Node.js server
      const response = await Axios.post('http://localhost:5090/api/thembenh', {
        tenbenh,
        hinhanh,
        trieuchung,
        nguyennhan,
        phongngua,
        noidung: editorContent,
        idLoaibenh,
        tenrieng, // You can set the value of tenrieng here if needed.
      });

      // Handle success response
      if (response.status === 200) {
        message.success('Data inserted successfully.');
        // Clear the form after successful submission
        settenbenh('');
        sethinhanh('');
        settrieuchung('');
        setnguyennhan('');
        setphongngua('');
        setnoidung('');
        setidLoaibenh('');
        settenrieng('');
        setEditorContent('');
      }
    } catch (error) {
      // Handle error response
      console.error('Error inserting data:', error);
      message.error('An error occurred while inserting data.');
    }
  };

  const [selectOptions, setSelectOptions] = useState([]);

  // Fetch the data for the <Select> options from the server
  // useEffect(() => {
  //   const fetchSelectOptions = async () => {
  //     try {
  //       const response = await Axios.get('http://localhost:5090/api/loaibenhs'); // Replace with the appropriate API endpoint to get the options
  //       if (response.status === 200) {
  //         setSelectOptions(response.data); // Assuming the response data is an array of objects with `value` and `label` properties
  //       }
  //     } catch (error) {
  //       console.error('Error fetching select options:', error);
  //     }
  //   };
  //   fetchSelectOptions();
  // }, []);

  useEffect(() => {
    Axios.get('http://localhost:5090/api/loaibenhs')
      .then((response) => {
        setSelectOptions(response.data);
      })
      .catch((error) => console.error(error));
  }, []);

  const handState = (value) => {
    setidLoaibenh(value);
  };

  const handngyennhan = (value) => {
    setnguyennhan(value);
  };

  const handphongngua = (value) => {
    setphongngua(value);
  };

  return (
    <div className="container-fluid">
      <div className="row">
        <div className="col-md-10 m-auto">
          <div className="card card-body mt-5">
            <h2 className="text-center">Create a Blog</h2>
            <div className="form-group">
              <label>Title Blog</label>
              <Form.Item>
                <Input type="text" placeholder="Blog title" value={tenbenh} onChange={(e) => settenbenh(e.target.value)} required />
              </Form.Item>
            </div>
            <div className="form-group">
              <label>ten reigng</label>
              <Form.Item>
                <Input type="text" placeholder="Blog title" value={tenrieng} onChange={(e) => settenrieng(e.target.value)} required />
              </Form.Item>
            </div>
            <div className="form-group">
              <label>Trạng thái</label>
              <Form.Item>
                <Select onChange={handState} value={idLoaibenh} placeholder="Chọn trạng thái">
                  {selectOptions.map((option) => (
                    <Option key={option.idLoaibenh} value={option.idLoaibenh}>
                      {option.tenloaibenh}
                    </Option>
                  ))}
                </Select>
              </Form.Item>
            </div>
            <div className="form-group">
              <label>Img Blog</label>
              <Form.Item valuePropName="fileList" getValueFromEvent={normFile} onChange={handleFileChange02}>
                <Upload src={hinhanh} listType="picture-card" className="avatar-uploader" maxCount={1} beforeUpload={handleFileChange02} onPreview={handlePreview}>
                  <div>
                    <PlusOutlined />
                    <div style={{ marginTop: 8, }} > Img Blog </div>
                  </div>
                </Upload>
                <Modal open={previewOpen} title={previewTitle} footer={null} onCancel={handleCancel}>
                  <img alt="example" style={{ width: '100%', }} src={previewImage} />
                </Modal>
              </Form.Item>
            </div>
            <div className="form-group">
              <label>Triệu chứng</label>
              <TextArea rows={4} className="form-control" placeholder="Enter description" value={trieuchung} onChange={(e) => settrieuchung(e.target.value)} required />
            </div>
            <div className="form-group">
              <label>Nguyên nhân</label>
              <JoditEditor rows={4} className="form-control" placeholder="Enter description" value={nguyennhan} onChange={handngyennhan} required />
            </div>
            <div className="form-group">
              <label>Phòng ngừa</label>
              <JoditEditor rows={4} className="form-control" placeholder="Enter description" value={phongngua} onChange={handphongngua} required />
            </div>
            <div className="form-group">
              <label>Nội dung</label>
              <Form.Item onChange={handleFileChange} valuePropName="fileList" getValueFromEvent={normFile}>
                <Upload src={imageUrl} listType="picture-card" className="avatar-uploader" beforeUpload={handleFileChange} onPreview={handlePreview}>
                  <div>
                    <PlusOutlined />
                    <div style={{ marginTop: 8, }} >
                      <label>Img</label>
                    </div>
                  </div>
                </Upload>
                <Modal open={previewOpen} title={previewTitle} footer={null} onCancel={handleCancel}>
                  <img alt="example" style={{ width: '100%', }} src={previewImage} />
                </Modal>
              </Form.Item>
              <Form.Item valuePropName="fileList" getValueFromEvent={normFile} onChange={handleVideoChange}>
                <Upload className="avatar-uploader" listType="picture-card" beforeUpload={handleVideoChange}>
                  <div>
                    <PlusOutlined />
                    <div style={{ marginTop: 8 }}>Video</div>
                  </div>
                </Upload>
              </Form.Item>
              <JoditEditor value={editorContent} config={editorConfig} onChange={handleEditorChange} />
            </div>
            <div className="form-group">
              <button className="btn btn-primary" onClick={handleSubmit}>
                Create Blog
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

export default App_blog