const express = require('express');
const app = express();
const session = require("express-session");
const db = require("../../data/data.js");
const mysql = require('mysql2');


// app.post("/login", (req, res) => {
//     const email = req.body.email;
//     const password = req.body.password;
//     db.query(
//         "SELECT * FROM tbl_taikhoan WHERE email = ?",
//         email,
//         (err, results) => {
//             if (err) {
//                 res.send({ err: err });
//             }
//             if (results.length > 0) {
//                 if (results[0].password === password) {
//                     req.session.user = results;
//                     console.log(req.session.user);
//                     res.send({ message: "Tài khoản mật chính sác" });
//                     console.log({ message: email });
//                 } else {
//                     res.send({ message: "Tài khoản mật không chính sác" });
//                     console.log({ message: password });
//                     console.log({ message: email });
//                 }
//             } else {
//                 res.send({ message: "Tài khoản không có" });
//             }
//         }
//     );
// });

app.use(session({
    key: "userId",
    secret: "subscribe",
    resave: true,
    saveUninitialized: true,
    cookie: {
        express: 60 * 60 * 24,
    }
}));

// Xử lý yêu cầu đăng nhập
app.get('/web/login', (req, res) => {
      const email = req.body.email;
    const password = req.body.password;
    db.query(
      'SELECT * FROM tbl_taikhoan WHERE email = ?',
      [email],
      (error, results) => {
        if (error) {
          res.status(500).json({ message: 'Đã xảy ra lỗi!' });
        } else if (results.length === 0) {
          res.status(401).json({ message: 'Tên người dùng không hợp lệ!' });
        } else {
          const user = results[0];
  
          bcrypt.compare(password, user.password, (err, isMatch) => {
            if (err) {
              res.status(500).json({ message: 'Đã xảy ra lỗi!' });
            } else if (isMatch) {
              res.status(200).json({ message: 'Đăng nhập thành công!' });
            } else {
              res.status(401).json({ message: 'Mật khẩu không hợp lệ!' });
            }
          });
        }
      }
    );
  });
  

// Kiểm tra xem người dùng đã đăng nhập hay chưa
const requireLogin = (req, res, next) => {
    if (req.session.userId) { // Nếu đăng nhập thành công, cho phép tiếp tục thực hiện
        next();
    } else { // Nếu chưa đăng nhập, trả về lỗi 401 Unauthorized
        res.status(401).send("Unauthorized");
    }
}

module.exports = app;