const express = require('express');
const router = express.Router();
const db = require("../../data/data.js");
const mysql = require('mysql2');
const session = require("express-session");
const bcrypt = require('bcrypt');

const saltRounds = 10;

router.use(session({
    key: "userId",
    secret: "subscribe",
    resave: true,
    saveUninitialized: true,
    cookie: {
        express: 60 * 60 * 24,
    }
}));

router.post('/api/register', (req, res) => {
    const email = req.body.email;
    const password = req.body.password;
    const setpassword = req.body.setpassword;
    const quyenhan = req.body.powers;

    // Kiểm tra xem password và setpassword giống nhau hay không
    if (password !== setpassword) {
        return res.status(400).json({ message: "Mật khẩu không khớp." });
    }

    // Kiểm tra xem email đã tồn tại trong CSDL hay chưa
    db.query("SELECT * FROM tbl_taikhoan WHERE email = ?", [email], (err, result) => {
        if(result.length){
            res.send({ message: "Tài khoản đã có" });
          }else {
            // Email chưa tồn tại trong CSDL và mật khẩu khớp, tiến hành mã hóa mật khẩu và setpassword, sau đó thêm mới tài khoản
            bcrypt.hash(password, saltRounds, (err, passwordHash) => {
                if (err) {
                    console.log(err);
                    return res.status(500).json({ message: "Đã xảy ra lỗi. Vui lòng thử lại sau." });
                }
                bcrypt.hash(setpassword, saltRounds, (err, setpasswordHash) => {
                    if (err) {
                        console.log(err);
                        return res.status(500).json({ message: "Đã xảy ra lỗi. Vui lòng thử lại sau." });
                    }
                    db.query("INSERT INTO tbl_taikhoan (email, password, setpassword, quyenhan) VALUES (?, ?, ?, ?)",
                        [email, passwordHash, setpasswordHash, quyenhan],
                        (err, result) => {
                            if (err) {
                                console.log(err);
                                return res.status(500).json({ message: "Đã xảy ra lỗi. Vui thử lại sau." });
                            }
                            return res.status(200).json({ message: "Tạo tài khoản thành công." });
                        }
                    );
                });
            });
        }
    });
});

module.exports = router;