import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
import { List, Card, Input, Popconfirm, Pagination, Option } from 'antd';
import { PlusOutlined, SearchOutlined, EditOutlined, DeleteOutlined } from '@ant-design/icons';


// const { Meta } = Card;

function App() {
  const [data, setData] = useState([]);
  const [searchName, setSearchName] = useState('');
  const [searchType, setSearchType] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);

  useEffect(() => {
    const apiUrl = `http://localhost:5090/api/danhsachbenhweb?name=${searchName}&type=${searchType}&page=${currentPage}`;
    axios.get(apiUrl)
      .then((response) => {
        const { data, page, totalCount } = response.data;
        setData(data);
        setCurrentPage(page);
        setTotalPages(Math.ceil(totalCount / 8)); // Số trang dựa trên số bệnh trên mỗi trang
      })
      .catch((error) => {
        console.error('Error fetching data:', error);
      });
  }, [searchName, searchType, currentPage]);

  const handleSearchNameChange = (e) => {
    setSearchName(e.target.value);
    setCurrentPage(1); // Reset trang về 1 khi thay đổi tên tìm kiếm
  };

  const handleSearchTypeChange = (value) => {
    setSearchType(value);
    setCurrentPage(1); // Reset trang về 1 khi thay đổi loại tìm kiếm
  };

  const handlePageChange = (page) => {
    setCurrentPage(page);
  };

  return (
    <div>
    <section className="wrapper bg-light">
        <div className="">
          <Link to="/User/app_blog" className="btn_blog btn btn-blue rounded-pill"><PlusOutlined /><span>Blog</span></Link><br />
          <div className='mb-2' style={{ height: '10px' }}></div>
          <Input
          placeholder="Tìm kiếm theo tên bệnh"
          value={searchName}
          onChange={handleSearchNameChange}
        />
          <Input
          placeholder="Tìm kiếm theo tên bệnh"
          value={searchType}
          onChange={handleSearchTypeChange}
        />
          <div className='mb-2' style={{ height: '20px' }}></div>
          <div className="">
            <List
              grid={{ gutter: 16, xs: 1, sm: 2, md: 2, lg: 2, xl: 3, xxl: 4 }}
              dataSource={data}
              renderItem={(item, index) => (
                <List.Item key={item.idBenh}>
                  <Card
                    style={{}}
                    cover={<img className='img-responsive img' alt="example" style={{ height: "260px", padding: "5px" }} src={item.hinhanh} />}
                    actions={[
                      <Link to={`/User/edit/${item.idBenh}`}><EditOutlined key="edit" /></Link>,
                      <Popconfirm title={`Bạn có muốn xoá Blog không?`} okText="Xoá" cancelText="Không">
                        <DeleteOutlined />
                      </Popconfirm>,
                    ]}
                  >
                    <List.Item.Meta className='text' style={{ height: "30px" }} title={<Link to={`${item.idBenh}`}>{item.tenbenh}</Link>} /><br />
                    <Card.Meta title={item.tenrieng} description={item.tenloaibenh} />
                  </Card>
                </List.Item>
              )}
            />
          </div>
        </div>
        <div>
        {Array.from({ length: totalPages }, (_, index) => (
          <button
            key={index + 1}
            onClick={() => handlePageChange(index + 1)}
            style={{
              background: currentPage === index + 1 ? '#1890ff' : '#f0f2f5',
              color: currentPage === index + 1 ? '#fff' : '#000',
              border: '1px solid #ccc',
              margin: '5px',
              cursor: 'pointer',
            }}
          >
            {index + 1}
          </button>
        ))}
      </div>
      <Pagination
        current={currentPage}
        total={totalPages * 10} // Tổng số bệnh, mỗi trang có 10 bệnh
        onChange={handlePageChange}
        style={{ marginTop: '10px' }}
      />
      </section>
    </div>
  );
}

export default App;
