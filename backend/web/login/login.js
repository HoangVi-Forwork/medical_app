const express = require('express');
const app = express();
const cors = require("cors");
const session = require("express-session");
const bodyParser = require("body-parser");
const db = require("../../data/data.js");
const mysql = require('mysql2');
const cookieParser = require("cookie-parser");
const bcrypt = require('bcrypt');


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

app.use(
  session({
    secret: 'your-secret-key',
    resave: false,
    saveUninitialized: true,
    cookie: {
      secure: false, // Set to true if using HTTPS
      maxAge: 60 * 60 * 1000, // Session expiration time (in milliseconds)
    },
  })
);


app.post('/api/logint', (req, res) => {
  const { email, password } = req.body;
  // Kiểm tra xem tài khoản có tồn tại trong cơ sở dữ liệu không
  db.query(
    'SELECT * FROM tbl_taikhoan WHERE email = ?',
    [email],
    (err, results) => {
      if (err) {
        res.send({ message: 'Đã xảy ra lỗi' });
      } else if (results.length === 0) {
        res.send({ message: 'Tài khoản không tồn tại' });
      } else {
        // So sánh mật khẩu đã mã hoá với mật khẩu người dùng nhập vào
        bcrypt.compare(password, results[0].password, (error, isMatch) => {
          if (isMatch) {
            const user = results[0];
            // Lưu thông tin người dùng vào session
            req.session.user = user;
            console.log(user);
            res.send({ message: 'Đăng nhập thành công' });
          } else {
            res.send({ message: 'Mật khẩu không chính xác' });
          }
        });
      }
    }
  );
});



module.exports = app;