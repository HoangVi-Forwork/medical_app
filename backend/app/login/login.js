const express = require("express");
const app = express();
const cors = require("cors");
const session = require("express-session");
const bodyParser = require("body-parser");
const db = require("../../data/data.js");
const mysql = require("mysql2");
const cookieParser = require("cookie-parser");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

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
app.use(express.static("public"));
app.use(
  session({
    key: "userId",
    secret: "subscribe",
    resave: true,
    saveUninitialized: true,
    cookie: {
      express: 60 * 60 * 24,
    },
  })
);

app.post("/login", (req, res) => {
  const email = req.body.email;
  const password = req.body.password;

  db.query(
    "SELECT * FROM tbl_taikhoan WHERE email = ?",
    email,
    (err, results) => {
      if (err) {
        res.send({ err: err });
      } else if (results.length > 0) {
        // So sánh mật khẩu với mật khẩu được lưu trữ trong cơ sở dữ liệu
        bcrypt.compare(
          password,
          results[0].password,
          (bcryptErr, bcryptResult) => {
            if (bcryptErr) {
              res.send({ err: bcryptErr });
            } else if (bcryptResult) {
              // Nếu mật khẩu khớp, lưu thông tin người dùng vào session và trả về thông báo
              req.session.user = results;
              console.log(req.session.user);
              res.send({
                message: "Tài khoản mật khẩu chính xác",
                id_taikhoan: results[0].id_taikhoan,
              });
              console.log({ message: email });
            } else {
              // Nếu mật khẩu không khớp, trả về thông báo tương ứng
              res.send({ message: "Tài khoản mật khẩu không chính xác" });
              console.log({ message: email });
            }
          }
        );
      } else {
        res.send({ message: "Tài khoản không tồn tại" });
      }
    }
  );
});

app.post("/logout", (req, res) => {
  req.session.destroy((err) => {
    if (err) {
      res.status(500).json({ message: "Đã xảy ra lỗi khi đăng xuất" });
    } else {
      console.log("Đăng xuất thành công");
      res.status(200).json({ message: "Đăng xuất thành công" });
    }
  });
});

app.get("/api/user/", (req, res) => {
  const query = req.query.id; // Lấy userId từ URL parameter
  db.query(
    // "SELECT * FROM tbl_taikhoan WHERE id_taikhoan LIKE ?",
    "SELECT tk.*, tt.sdt, tt.diachi, tt.avata, tt.gioitinh FROM tbl_taikhoan tk INNER JOIN tbl_thongtin tt ON tk.id_taikhoan = tt.id_taikhoan WHERE tk.id_taikhoan LIKE ?",
    [
      // "SELECT tk.*, tt.sdt, tt.diachi, tt.avata, tt.gioitinh FROM tbl_taikhoan tk INNER JOIN tbl_thongtin tt ON tk.id_taikhoan = tt.id_taikhoan WHERE tk.email LIKE ?",
      `%${query}%`,
    ],
    (err, result) => {
      if (err) {
        console.error("Không thực hiện được", err);
        res
          .status(500)
          .send("An error occurred while fetching user information.");
      } else {
        console.log("Thông tin người dùng: ", result);
        res.status(201).json(result);
      }
    }
  );
});

app.put("/api/user/:userId", (req, res) => {
  const userId = req.params.userId; // Lấy userId từ URL parameter
  const { ten, email, password, setpassword, sdt, diachi, avata, gioitinh } =
    req.body;

  db.query(
    "UPDATE tbl_taikhoan tk, tbl_thongtin tt SET tk.ten = ?, tk.email = ?, tk.password = ?, tk.setpassword = ?, tt.sdt = ?, tt.diachi = ?, tt.avata = ?, tt.gioitinh = ? WHERE tk.id_taikhoan = ? AND tk.id_taikhoan = tt.id_taikhoan",
    [ten, email, password, setpassword, sdt, diachi, avata, gioitinh, userId],
    (err, result) => {
      if (err) {
        console.error("Không thực hiện được", err);
        res
          .status(500)
          .send("An error occurred while updating user information.");
      } else {
        console.log("Thông tin người dùng đã được cập nhật: ", result);
        res.status(200).send("User information updated successfully.");
      }
    }
  );
});

// app.post("/login", (req, res) => {
//   const email = req.body.email;
//   const password = req.body.password;

//   // Kiểm tra xem email có tồn tại trong CSDL hay không
//   db.query(
//     "SELECT * FROM tbl_taikhoan WHERE email = ?",
//     [email],
//     (err, results) => {
//       if (err) {
//         // Trả về lỗi nếu có vấn đề trong truy vấn CSDL
//         res
//           .status(500)
//           .json({ message: "Đã xảy ra lỗi. Vui lòng thử lại sau." });
//       } else if (results.length > 0) {
//         // So sánh mật khẩu với mật khẩu được lưu trữ trong CSDL
//         bcrypt.compare(
//           password,
//           results[0].password,
//           (bcryptErr, bcryptResult) => {
//             if (bcryptErr) {
//               // Trả về lỗi nếu có vấn đề trong quá trình so sánh mật khẩu
//               res
//                 .status(500)
//                 .json({ message: "Đã xảy ra lỗi. Vui lòng thử lại sau." });
//             } else if (bcryptResult) {
//               // Nếu mật khẩu khớp, lưu thông tin người dùng vào session và trả về thông báo thành công
//               req.session.user = results[0];
//               console.log(req.session.user);
//               res.status(200).json({ message: "Tài khoản mật khẩu chính xác" });
//             } else {
//               // Nếu mật khẩu không khớp, trả về thông báo tài khoản mật khẩu không chính xác
//               res
//                 .status(401)
//                 .json({ message: "Tài khoản mật khẩu không chính xác" });
//             }
//           }
//         );
//       } else {
//         // Nếu email không tồn tại trong CSDL, trả về thông báo tài khoản không tồn tại
//         res.status(404).json({ message: "Tài khoản không tồn tại" });
//       }
//     }
//   );
// });

// app.get("/api/user/", (req, res) => {
//   const query = req.query.email;
//   // print("ĐÂy là query: ", query);
//   console.log("bắt query nè:", query);
//   db.query(
//     "SELECT * FROM tbl_taikhoan WHERE email LIKE ?",
//     [`%${query}%`],
//     (err, result) => {
//       if (err) {
//         console.error("Không thực hiện được", err);
//         res.status(500).send("An error occurred while searching for disease.");
//       } else {
//         console.log("Danh sách user: ", result);
//         res.status(201).json(result);
//       }
//     }
//   );
// });

// app.get("/api/user/", (req, res) => {
//   const query = req.query.id;
//   // print("ĐÂy là query: ", query);
//   console.log("bắt query nè:", query);
//   db.query(
//     "SELECT * FROM tbl_taikhoan WHERE id_taikhoan LIKE ?",
//     [`%${query}%`],
//     (err, result) => {
//       if (err) {
//         console.error("Không thực hiện được", err);
//         res.status(500).send("An error occurred while searching for disease.");
//       } else {
//         console.log("Danh sách user: ", result);
//         res.status(201).json(result);
//       }
//     }
//   );
// });

// app.put("/api/user/update/", (req, res) => {
//   const query = req.query.email; // Lấy userId từ URL parameter
//   const { ten, email, password, setpassword, sdt, diachi, avata, gioitinh } =
//     req.body;

//   db.query(
//     "UPDATE tbl_taikhoan tk, tbl_thongtin tt SET tk.ten = ?, tk.email = ?, tk.password = ?, tk.setpassword = ?, tt.sdt = ?, tt.diachi = ?, tt.avata = ?, tt.gioitinh = ? WHERE tk.email LIKE ?",
//     [ten, email, password, setpassword, sdt, diachi, avata, gioitinh, query],
//     (err, result) => {
//       if (err) {
//         console.error("Không thực hiện được", err);
//         res
//           .status(500)
//           .send("An error occurred while updating user information.");
//       } else {
//         console.log("Thông tin người dùng đã được cập nhật: ", result);
//         res.status(200).send("User information updated successfully.");
//       }
//     }
//   );
// });

module.exports = app;
