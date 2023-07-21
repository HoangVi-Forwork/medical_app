const express = require('express');
const app = express();
const cors = require("cors");
const session = require("express-session");
const bodyParser = require("body-parser");
const db = require("../../data/data.js");
const mysql = require('mysql2');
const cookieParser = require("cookie-parser");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
// const mysql_jwt_secret = 'hvdvay6ert72839289()aiyg8t87qt72393293kmkm883uhefiuh78ttq3ifi78272jbkj?[]]pou89ywe';


app.use(cors());
app.use(express.json());
app.use(
  cors({
    origin: ["http://localhost:3000"],
    methods: ["GET", "POST"],
    credentials: true,
  })
);
app.use(cookieParser());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'));
app.use(session({
  key: "userId",
  secret: "subscribe",
  resave: true,
  saveUninitialized: true,
  cookie: {
    express: 60 * 60 * 24,
  }
}));

app.post('/loginto', (req, res) => {
  const { email, password } = req.body;

  // Kiểm tra thông tin đăng nhập trong cơ sở dữ liệu
  db.query(
    'SELECT * FROM tbl_taikhoan WHERE email = ?',
    [email],
    (err, results) => {
      if (err) {
        res.status(500).json({ message: 'Internal server error' });
      } else if (results.length === 0) {
        res.status(401).json({ message: 'Invalid credentials v' });
      } else {
        const user = results[0];

        // So sánh mật khẩu đã mã hóa với mật khẩu người dùng nhập vào
        bcrypt.compare(password, user.password, (err, isMatch) => {
          if (err) {
            res.status(500).json({ message: 'Internal server error' });
          } else if (!isMatch) {
            res.status(401).json({ message: 'Invalid credentials' });
          } else {
            // Tạo token JWT
            const token = jwt.sign({ id_taikhoan: user.id_taikhoan }, 'your_jwt_secret');
            console.log(token);
            res.json({ token });
          }
        });
      }
    }
  );
});

app.get('/profile', (req, res) => {
  const token = req.headers.authorization;
  console.log(token);
  if (!token) {
    res.status(401).json({ message: 'Missing token' });
  } else {
    // Xác thực token JWT
    jwt.verify(token, 'your_jwt_secret', (err, decoded) => {
      if (err) {
        res.status(401).json({ message: 'Invalid token' });
      } else {
        const userId = decoded.id_taikhoan;

        // Lấy thông tin tài khoản từ cơ sở dữ liệu
        db.query(
          'SELECT id_taikhoan, email FROM tbl_taikhoan WHERE id_taikhoan = ?',
          [userId],
          (err, results) => {
            if (err) {
              console.log(results)
              res.status(500).json({ message: 'Internal server error' });
            } else if (results.length === 0) {
              console.log(results)
              res.status(404).json({ message: 'User not found' });
            } else {
              const user = results[0];
              console.log(user);
              res.json({ user });
            }
          }
        );
      }
    });
  }
});


module.exports = app;


