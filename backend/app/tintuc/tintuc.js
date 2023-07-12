const express = require("express");
const app = express();
const session = require("express-session");
const db = require("../../data/data.js");
const mysql = require("mysql2");

app.get("/api/tintuc", (req, res) => {
  const { tentintuc } = req.params;
  const sql = "SELECT * FROM tbl_tintuc WHERE tentintuc = ?";
  db.query(sql, tentintuc, (err, result) => {
    if (err) {
      console.log(err);
    }
    res.send(result);
  });
});

module.exports = app;
