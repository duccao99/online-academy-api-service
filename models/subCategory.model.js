const db = require("../config/db");
const table_name = `subjects`;
const subCatModel = {
  all() {
    const sql = `select * from ${table_name} `;
    return db.load(sql);
  },
  async detail(cat_id) {
    const sql = `select *
    from ${table_name} s
    where s.subject_id = ${cat_id};`;

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
  async singleByName(name) {
    const sql = `select *
    from ${table_name} s
    where s.subject_name = '${name}';`;

    const data = await db.load(sql);

    return data[0];
  },
};
module.exports = subCatModel;
