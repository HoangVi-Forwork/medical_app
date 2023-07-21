import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
import { List, Card, Input, Popconfirm, Pagination } from 'antd';
import { PlusOutlined, SearchOutlined, EditOutlined, DeleteOutlined } from '@ant-design/icons';

const MyComponent = () => {
  const [data, setData] = useState([]);
  const [page, setPage] = useState(1);
  const [searchName, setSearchName] = useState('');
  const [searchType, setSearchType] = useState('');
  const [totalCount, setTotalCount] = useState(0);

  const limit = 8; // Số bệnh trên mỗi trang
  const pageCount = Math.ceil(totalCount / limit); // Tính tổng số trang

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get('http://localhost:5090/api/danhsachbenhweb', {
          params: {
            name: searchName,
            type: searchType,
            page: page
          }
        });

        setData(response.data.data);
        setTotalCount(response.data.totalCount);
      } catch (error) {
        console.error('Đã xảy ra lỗi:', error);
      }
    };

    fetchData();
  }, [page, searchName, searchType]);

  const handleLoadMore = () => {
    setPage(page + 1); // Tăng số trang lên 1 để tải thêm dữ liệu
  };

  const handlePageChange = (newPage) => {
    setPage(newPage); // Thay đổi số trang khi người dùng chọn trang mới
  };

  return (
    <div>
      <section className="wrapper bg-light">
        <div className="">
          <Link to="/User/app_blog" className="btn_blog btn btn-blue rounded-pill"><PlusOutlined /><span>Blog</span></Link><br />
          <div className='mb-2' style={{ height: '10px' }}></div>
          <div className="">
            <Input placeholder="input search text" value={searchName}
         onChange={(e) => setSearchName(e.target.value)} prefix={<SearchOutlined />} style={{ marginTop: 5, marginRight: 5 }} className='input_timkiem' />
            <Input placeholder="input search date" type="date" prefix={<SearchOutlined />} style={{ marginTop: 5, }} className='input_timkiem_ngay' />
          </div>
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
          <Pagination
            showSizeChanger={false}
            showQuickJumper={false}
            current={page}
            total={totalCount}
            pageSize={limit}
            onChange={handlePageChange}
          />
        </div>
      </section>
    </div>
  );
};

export default MyComponent;
