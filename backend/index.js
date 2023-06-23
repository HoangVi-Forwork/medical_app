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
        }else{
            res.status(201).json(result);
        }
    })
});

app.get("/Khoabenh", (req, res) => {
    db.query("SELECT * FROM tbl_khoabenh", (err, result) => {
        if (err) {
            res.status(422).json("Kong")
        }else{
            res.status(201).json(result);
        }
    })
});

app.get("/Loaibenh", (req, res) => {
    db.query("SELECT * FROM tbl_loaibenh", (err, result) => {
        if (err) {
            res.status(422).json("Kong")
        }else{
            res.status(201).json(result);
        }
    })
});

app.listen(port, () => {
    console.log("Server is");
})