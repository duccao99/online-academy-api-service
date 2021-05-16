const db = require("../config/db");
const table_name = `categories`;
const catModel = {
  all() {
    const sql = `select * from ${table_name} `;
    return db.load(sql);
  },
};
module.exports = catModel;
