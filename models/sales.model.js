const db = require("../config/db");

const tbl_sales = `sales`;

const salesModel = {
  add(entity) {
    return db.add(entity, tbl_sales);
  },
  del(condition) {
    return db.del(condition, tbl_sales);
  },
  edit(entity, condition) {
    return db.edit(entity, condition, tbl_sales);
  },
  all() {
    const sql = `select * from ${tbl_sales}; `;
    return db.load(sql);
  },
};

module.exports = salesModel;
