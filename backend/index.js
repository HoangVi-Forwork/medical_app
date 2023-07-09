const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const cors = require("cors");
const mysql = require("mysql2");
const db = require("./data/data.js");
require("./data/data.js");
const session = require("express-session");
const Login = require('../backend/web/login/login.js');
const Logout = require('./web/login/signup.js');
const Benh = require('../backend/app/khoabenh/benh.js');
const port = 5090;

app.use(express.json());

app.use(
  cors({
    origin: ["http://localhost:3000"],
    methods: ["GET", "POST"],
    credentials: true,
  })
);

app.use(
  session({
    key: "userId",
    secret: "subscribe",
    resave: false,
    saveUninitialized: false,
    cookie: {
      expires: 60 * 60 * 24,
    },
  })
);

app.use(Login);
app.use(Logout);
app.use(Benh);


app.use(bodyParser.urlencoded({ extended: true }));



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
          console.log({ message: email });
        } else {
          res.send({ message: "Tài khoản mật không chính sác" });
          console.log({ message: password });
          console.log({ message: email });
        }
      } else {
        res.send({ message: "Tài khoản không có" });
      }
    }
  );
});


app.listen(port, () => {
  console.log(`Server is localhost::${port}`);
});
