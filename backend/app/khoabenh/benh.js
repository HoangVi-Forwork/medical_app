const express = require("express");
const app = express();
const session = require("express-session");
const db = require("../../data/data.js");
const mysql = require("mysql2");

app.get("/api/danhsachbenh", (req, res) => {
  db.query("SELECT * FROM tbl_benh", (err, result) => {
    if (err) {
      res.status(422).json("không thực hiện được");
    } else {
      res.status(201).json(result);
    }
  });
});


app.get("/api/loaibenh/:idLoaibenh", (req, res) => {

    const {idLoaibenh} = req.params;
        const sql = "SELECT * FROM tbl_loaibenh WHERE idLoaibenh = ?";
        db.query(sql, idLoaibenh, (err, result) => {
            if (err) {
                console.log(err);
            }
            res.send(result);
        });
})


app.get("/api/loaibenh/:idLoaibenh", (req, res) => {});

module.exports = app;
