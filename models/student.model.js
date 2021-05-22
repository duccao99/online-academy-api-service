const db = require("../config/db");
const tbl_users = `users`;

const studentModel = {
  all() {
    const sql = `select *
    from ${tbl_users} u
    where role_id =2 ;
    `;
    return db.load(sql);
  },

  async detail(student_id) {
    const sql = `select *
      from ${tbl_users} u
      where role_id =2 
      and u.user_id = ${student_id};`;

    const data = await db.load(sql);

    return data[0];
  },
  add(entity) {
    return db.add(entity, tbl_users);
  },
  del(condition) {
    return db.del(condition, tbl_users);
  },
  edit(entity, condition) {
    return db.edit(entity, condition, tbl_users);
  },
  async getVerifyAccountStatus(user_id) {
    const sql = `select u.is_verified 
    from ${tbl_users} u
    where u.user_id = ${user_id};`;
    const ret = await db.load(sql);

    if (ret.length === 0) {
      return null;
    }

    if (ret[0] === 1) {
      return true;
    } else {
      return false;
    }
  },
};

module.exports = studentModel;
