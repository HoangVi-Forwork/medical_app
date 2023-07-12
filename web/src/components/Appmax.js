import { BrowserRouter as Router, Routes, Route, Link, useLocation } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { Breadcrumb, Layout, Menu, theme } from 'antd';
import { InboxOutlined, UserOutlined,ContainerOutlined, AppstoreOutlined, DeliveredProcedureOutlined, ClusterOutlined, LogoutOutlined, LoginOutlined } from '@ant-design/icons';
import { useNavigate } from 'react-router-dom';
import axios from "axios";
// import '../App.css'
// import Login from './/login/login';
// import Blog from './blog/Blog.js';
// import Blogdetail from './blog/Blog_detail.js';
// import Addblog from './blog/Add_blog';
// import Editblog from './blog/Edit.js';
// import Edit from './blog/Edit.js';

const { Content, Sider } = Layout;
function App() {
  const [collapsed, setCollapsed] = useState(false);
  const { token: { colorBgContainer } } = theme.useToken();

  const rootSubmenuKeys = ['sub1', 'sub2', 'sub4', 'sub5'];
  const [openKeys, setOpenKeys] = useState(['sub1']);

  const onOpenChange = (keys) => {
    const latestOpenKey = keys.find((key) => openKeys.indexOf(key) === -1);
    if (rootSubmenuKeys.indexOf(latestOpenKey) === -1) {
      setOpenKeys(keys);
    } else {
      setOpenKeys(latestOpenKey ? [latestOpenKey] : []);
    }
  };
  const location = useLocation();
  const history = useNavigate();
  const [user, setUser] = useState('');
  useEffect(() => {
    const userData = localStorage.getItem('user');
    if (userData) {
      const parsedUser = JSON.parse(userData);
      setUser(parsedUser);
    } else {
      setUser(null);
      localStorage.removeItem('user');
      history('/User')
    }
  }, [history]);
  const handleLogout = () => {
    localStorage.removeItem('user');
    setUser(null);
    history('/');
  };  
  // 
  // const [userto, setUserto] = useState(null);
  // const [message, setMessage] = useState('');

  // useEffect(() => {
  //   const fetchUser = async () => {
  //     const response = await fetch('http://localhost:5090/userlog', {
  //       method: 'GET',
  //       credentials: 'include',
  //     });
  //     const data = await response.json();
  //     if (data.user) {
  //       setUserto(data.user);
  //       setMessage('Đã đăng nhập');
  //     } else {
  //       setMessage(data.message);
  //     }
  //   };

  //   fetchUser();
  // }, []);
  return (
    <div>
      <Layout>
        <Sider collapsible collapsed={collapsed} onCollapse={(value) => setCollapsed(value)} style={{
          position: 'fixed',
          height: '100%',
          zIndex: 1,
          overflow: 'auto', // Added overflow property
          left: 0,
        }}>
  
          {user && 
          <div>
          <img className="menu-item avatar bg-primary text-white w-10 h-10 mb-2" src={user.avatar} alt='' />
                <p className='span-item'>{user.name}</p>
          </div> }
          <Menu theme="dark" defaultSelectedKeys={['']} mode="inline" openKeys={openKeys} onOpenChange={onOpenChange}>
            <Menu.SubMenu key="sub2" icon={<AppstoreOutlined style={{fontSize: '19px',}}/>} title="Blog New" >
              <Menu.Item key="1" icon={<ContainerOutlined />}>
                <Link style={{ textDecoration: 'none' }} to="blog">Blog</Link>
              </Menu.Item>
              <Menu.Item key="2" icon={<InboxOutlined />}>
                <Link style={{ textDecoration: 'none' }} to="app_blog">Add Blog</Link>
              </Menu.Item>
            </Menu.SubMenu>
          </Menu>
          {user !== null && 
          <Menu theme="dark" defaultSelectedKeys={['0']} mode="inline" openKeys={openKeys} onOpenChange={onOpenChange} style={{fontSize: '15px',}} title="Đang xuat">
            <Menu.Item key="sub1" icon={<LogoutOutlined style={{fontSize: '19px',}}/> }>
            <Link onClick={handleLogout} style={{ textDecoration: 'none' }} to="/">Account transfer</Link>
            </Menu.Item>
          </Menu>
            }
            {user === null && 
          <Menu theme="dark" defaultSelectedKeys={['0']} mode="inline" openKeys={openKeys} onOpenChange={onOpenChange} style={{fontSize: '15px',}}>
            <Menu.Item key="sub1" icon={<LoginOutlined style={{fontSize: '19px',}}/> }>
            <Link style={{ textDecoration: 'none' }} to="/">Log In </Link>
            </Menu.Item>
          </Menu>
            }
        </Sider>
        <Layout style={{ marginLeft: collapsed ? 80 : 200 }}>
          <Content style={{ margin: '0 16px', }} >
            <Breadcrumb style={{ margin: '16px 0' }}>
              <Breadcrumb.Item><ClusterOutlined /></Breadcrumb.Item>
              <Breadcrumb.Item>{window.location.pathname.substring(1)}</Breadcrumb.Item>
            </Breadcrumb>
            <div style={{ padding: 24, minHeight: 500, background: colorBgContainer }}>
              <Routes location={location}>
                {/* <Route path="/login" element={<Login />} />
                <Route path="/blog" element={<Blog />} />
                <Route path="/blog/:id" element={<Blogdetail />} />
                <Route path="/app_blog" element={<Addblog />} />
                <Route path="/edit_blog" element={<Editblog />} />
                <Route path="/edit/:id" element={<Edit />} /> */}
              </Routes>
            </div>
          </Content>
        </Layout>
      </Layout>
    </div>
  );
}

export default App;
