const db = require("../config/db");
const table_name = `users`;

const studentModel = {
  all() {
    const sql = `select *
    from ${table_name} u
    ;
    `;
    return db.load(sql);
  },
  async detail(user_id) {
    const sql = `select *
      from ${table_name} u

      and u.user_id = ${user_id};`;
    const data = await db.load(sql);

    return data[0];
  },

  add(entity) {
    return db.add(entity, table_name);
  },
  del(condition) {
    return db.del(condition, table_name);
  },
  edit(entity, condition) {
    return db.edit(entity, condition, table_name);
  },

  async detailByUserName(username) {
    const sql = `select * from ${table_name} u where u.user_name = '${username}'`;
    const ret = await db.load(sql);
    return ret[0];
  },
  patchRFToken(id, rfToken) {
    const entity = {
      rfToken: rfToken,
    };
    const condition = {
      user_id: id,
    };
    return db.edit(entity, condition, table_name);
  },
  async isValidRFToken(userId, rfToken) {
    const sql = `select * from ${table_name} 
      where user_id = ${userId}
       and rfToken = '${rfToken}' `;
    const list = await db.load(sql);

    if (list.length > 0) return true;
    return false;
  },

  async singleByEmail(email) {
    const sql = `select * from ${table_name} u where u.email = '${email}'`;
    const ret = await db.load(sql);
    return ret[0];
  },
};

module.exports = studentModel;
