const mysql = require('mysql');
const util = require('util');

const pool = mysql.createPool({
  host: 'localhost',
  port: '3306',
  user: 'root',
  password: 'Ctz@011243',
  database: 'SPA_ONLINE_ACADEMY',
  connectionLimit: 50
});

// const herokuClearDB = mysql.createPool({
//   host: process.env.DB_HOST || 'localhost',
//   // port: process.env.DB_PORT || '3306',
//   user: process.env.DB_USERNAME || 'root',
//   password: process.env.DB_PASSWORD || 'root',
//   database: process.env.DB_DATABASE_NAME || 'SPA_ONLINE_ACADEMY',
//   connectionLimit: 50
// });

// local
const pool_query = util.promisify(pool.query).bind(pool);

// development
// const pool_query = util.promisify(herokuClearDB.query).bind(herokuClearDB);

module.exports = {
  load: (sql) => {
    return pool_query(sql);
  },
  add: (entity, table_name) => {
    return pool_query(`insert into ${table_name} set ?`, entity);
  },
  edit: (entity, condition, table_name) => {
    return pool_query(`update ${table_name} set ? where ?`, [
      entity,
      condition
    ]);
  },
  editTwoCons: (entity, condition, andCondition, table_name) => {
    return pool_query(`update ${table_name} set ? where ? and ?`, [
      entity,
      condition,
      andCondition
    ]);
  },
  del: (condition, table_name) => {
    return pool_query(`delete from ${table_name} where ?`, condition);
  }
};
