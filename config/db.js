const mysql = require("mysql");
const util = require("util");

const pool = mysql.createPool({
  host: process.env.DB_HOST || "localhost",
  port: process.env.DB_PORT || "3306",
  user: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "root",
  database: process.env.DB_NAME || "SPA_ONLINE_ACADEMY",
  connectionLimit: 50,
});

const pool_query = util.promisify(pool.query).bind(pool);

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
      condition,
    ]);
  },
  del: (condition, table_name) => {
    return pool_query(`delete from ${table_name} where ?`, condition);
  },
};
