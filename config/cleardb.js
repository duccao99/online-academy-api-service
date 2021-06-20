const { Prohairesis } = require('prohairesis');
const path = require('path');

const database = new Prohairesis(process.env.CLEARDB_DATABASE_URL);
database
  .queryFromFile(path.join(__dirname, '../sql/ClearDBScriptDB.sql'))
  .then((ret) => {
    // console.log(ret);
  })
  .catch((er) => {
    console.log(er);
  });

// const sql =  'CREATE TABLE `roles`( role_id INT(10) PRIMARY KEY NOT NULL auto_increment, role_name varchar(200));';

// database
//   .query(sql)
//   .then((ret) => {})
//   .catch((er) => {
//     console.log(er);
//   });
