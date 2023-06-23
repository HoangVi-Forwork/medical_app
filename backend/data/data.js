const mysql = require('mysql2');

const db = mysql.createConnection({
    host    : 'bh3l8pri7cywrzdu0gmh-mysql.services.clever-cloud.com',
    user    : 'ubu2bbyorxxwlgj7',
    password: '6AsnKiVg0XPmP89phbK',
    database: 'bh3l8pri7cywrzdu0gmh',
    port: 20819,
});

db.connect(function (err){
    //nếu có nỗi thì in ra
    if (err) throw err.stack;
    //nếu thành công
    console.log('ket noi thanh cong');
    
});

module.exports = db;