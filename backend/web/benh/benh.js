const express = require('express');
const app = express();
const cors = require("cors");
const session = require("express-session");
const bodyParser = require("body-parser");
const db = require("../../data/data.js");
const mysql = require('mysql2');
const cookieParser = require("cookie-parser");
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

app.get("/api/danhsachbenhweb", (req, res) => {
    const searchName = req.query.name || ''; // Giá trị tìm kiếm theo tên bệnh
    const searchType = req.query.type || ''; // Giá trị tìm kiếm theo loại bệnh
    const page = parseInt(req.query.page) || 1; // Số trang hiện tại
  
    const limit = 8; // Số bệnh trên mỗi trang
    const offset = (page - 1) * limit; // Offset cho truy vấn phân trang
  
    // Xây dựng câu truy vấn SQL dựa trên giá trị tìm kiếm và phân trang
    let query = `SELECT * FROM tbl_benh JOIN tbl_loaibenh ON tbl_benh.idloaibenh = tbl_loaibenh.idloaibenh`;
    // Xử lý tìm kiếm theo tên bệnh
    if (searchName) {
      query += ` WHERE tbl_benh.tenbenh LIKE '%${searchName}%'`;
    }
    // Xử lý tìm kiếm theo loại bệnh
    if (searchType) {
      if (searchName) {
        query += ` AND tbl_loaibenh.tenloaibenh LIKE '%${searchType}%'`;
      } else {
        query += ` WHERE tbl_loaibenh.tenloaibenh LIKE '%${searchType}%'`;
      }
    }
    query += ` LIMIT ${limit} OFFSET ${offset}`;
    db.query(query, (err, result) => {
      if (err) {
        res.status(422).json("Không thực hiện được truy vấn");
      } else {
        let countQuery = `SELECT COUNT(*) AS totalCount FROM tbl_benh JOIN tbl_loaibenh ON tbl_benh.idloaibenh = tbl_loaibenh.idloaibenh`;
        if (searchName) {
          countQuery += ` WHERE tbl_benh.tenbenh LIKE '%${searchName}%'`;
        }
        if (searchType) {
          if (searchName) {
            countQuery += ` AND tbl_loaibenh.tenloaibenh LIKE '%${searchType}%'`;
          } else {
            countQuery += ` WHERE tbl_loaibenh.tenloaibenh LIKE '%${searchType}%'`;
          }
        }
        db.query(countQuery, (countErr, countResult) => {
          if (countErr) {
            res.status(422).json("Không thực hiện được truy vấn");
          } else {
            const totalCount = countResult[0].totalCount;
            res.status(200).json({
              data: result,
              page: page,
              totalCount: totalCount,
            });
          }
        });
      }
    });
  });
  

  app.post("/api/thembenh", (req, res) => {
    const tenbenh = req.body.tenbenh;
    const hinhanh = req.body.hinhanh;
    const trieuchung = req.body.trieuchung;
    const nguyennhan = req.body.nguyennhan;
    const phongngua = req.body.phongngua;
    const noidung = req.body.noidung;
    const idLoaibenh = req.body.idLoaibenh;
    const tenrieng = req.body.tenrieng;

    db.query(
        "INSERT INTO tbl_benh (tenbenh, hinhanh, trieuchung, nguyennhan, phongngua, noidung, idLoaibenh, tenrieng) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
        [tenbenh, hinhanh, trieuchung, nguyennhan, phongngua, noidung, idLoaibenh, tenrieng],
        (err, result) => {
            if (err) {
                console.error("Error inserting data:", err);
                res.status(500).send("An error occurred while inserting data.");
            } else {
                res.status(200).send("Data inserted successfully.");
            }
        }
    );
  })

  app.get("/api/timkiembenh", (req, res) => {
  const searchName = req.query.tenbenh; 
  db.query(
    "SELECT * FROM tbl_benh WHERE tenbenh LIKE ?",
    [`%${searchName}%`],
    (err, result) => {
      if (err) {
        console.error("Error searching for disease:", err);
        res.status(500).send("An error occurred while searching for disease.");
      } else {
        res.status(200).json(result);
      }
    }
  );
});
module.exports = app;
