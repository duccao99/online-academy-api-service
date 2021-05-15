const db = require("../config/db");
const table_name = `users`;

const studentModel = {
  all() {
    const sql = `select *
    from ${table_name} u
    where role_id =2 ;
    `;
    return db.load(sql);
  },

  async detail(student_id) {
    const sql = `select *
      from ${table_name} u
      where role_id =2 
      and u.user_id = ${student_id};`;

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
};

module.exports = studentModel;
