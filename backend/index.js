const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const cors = require('cors');
const mysql = require('mysql2');
const db = require("./data/data.js");
require("./data/data.js");
const session = require("express-session");
const multiparty = require('connect-multiparty');
const port = 5090
const bcrypt = require('bcrypt');
const saltRounds = 10;

const multer = require('multer');
var path = require('path');

app.use(cors({
    origin: ["http://localhost:3000"],
    method: ["POST", "GET"],
    credentials: true
}));
app.use(express.json());
app.use(bodyParser.json());
app.use(session({
    key: "userId",
    secret: "subscribe",
    resave: true,
    saveUninitialized: true,
    cookie: {
        express: 60 * 60 * 24,
    }
}));
app.use(bodyParser.urlencoded({ extended: true }));

// app.get('/sanpham', function (req, res) {
//      db.query("SELECT `name` FROM users", function (error, results, fields) {
//          if (error) throw error;
//          return res.send({ error: false, data: results, message: 'users list.' });
//      });
//  });

// app.post('/uploads', MultipartyMiddleware, (req, res) => {
//     console.log(req.files.upload)
// })

app.get("/Danhsachbenh", (req, res) => {
    db.query("SELECT * FROM tbl_benh", (err, result) => {
        if (err) {
            res.status(422).json("Kong")
        } else {
            res.status(201).json(result);
        }
    })
});

app.get("/Khoabenh", (req, res) => {
    db.query("SELECT * FROM tbl_khoabenh", (err, result) => {
        if (err) {
            res.status(422).json("Kong")
        } else {
            res.status(201).json(result);
        }
    })
});

app.get("/Loaibenh", (req, res) => {
    db.query("SELECT * FROM tbl_loaibenh", (err, result) => {
        if (err) {
            res.status(422).json("Kong")
        } else {
            res.status(201).json(result);
        }
    })
});

// app.post('/login', (req, res) => {
//     const { email, password } = req.body;

//     connection.query('SELECT * FROM tbl_taikhoan WHERE email = ?', [email], (error, results) => {
//       if (error) throw error;

//       if (results.length > 0) {
//         if (results[0].password === password) {
//           res.status(200).json({ message: 'Đăng nhập thành công' });
//           console.log('Sai mật khẩu');
//         } else {
//           res.status(401).json({ message: 'Sai mật khẩu' });
//           console.log('Sai mật khẩu');
//         }
//       } else {
//         res.status(404).json({ message: 'Người dùng không tồn tại' });
//         console.log('Sai mật khẩu');
//       }
//     });
//   });

app.post("/login", (req, res) => {
    const email = req.body.email;
    const password = req.body.password;

    db.query(
        "SELECT * FROM tbl_taikhoan WHERE email = ?",
        email,
        (err, results) => {
            if (err) {
                res.send({ err: err });
            }
            if (results.length > 0) {
                    if (results[0].password === password) {
                        req.session.user = results;
                        console.log(req.session.user);
                        res.send({ message: "Tài khoản mật chính sác" });
                        console.log({ message: email })
                    } else {
                        res.send({ message: "Tài khoản mật không chính sác" });
                        console.log({ message: password })
                        console.log({ message: email })
                    }
            } else {
                res.send({ message: "Tài khoản không có" });
            }
        }
    )
})

app.get("/login", (req, res) => {
    if (req.session.user) {
      res.send({ loggedIn: true, user: req.session.user });
    } else {
      res.send({ loggedIn: false });
    }
});


app.listen(port, () => {
    console.log("Server is");
})