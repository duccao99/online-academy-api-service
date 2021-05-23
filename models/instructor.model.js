const db = require("../config/db");
const tbl_courses = `courses`;
const tbl_subjects = `subjects`;
const tbl_categories = `categories`;
const tbl_orders_details = `orders_details`;
const tbl_instructor_courses_uploaded = `instructor_courses_uploaded`;
const tbl_users = `users`;
const tbl_chapters = `chapters`;
const tbl_lessons = `lessons`;
const tbl_course_reviews = `course_reviews`;
const tbl_roles = `roles`;
const tbl_student_enrolls = `student_enrolls`;
const tbl_sales = `sales`;
const tbl_orders = `orders`;

const instructorModel = {
  all() {
    const sql = `select *
        from ${tbl_users} u 
        where u.role_id = 3`;
    return db.load(sql);
  },

  detail(id) {
    const sql = `select *
    from ${tbl_users} u 
    where u.role_id = 3
    and u.user_id = ${id}`;

    return db.load(sql);
  },
  edit(user_id, name, email) {
    const sql = `update ${tbl_users} u
      set u.user_name='${name}', u.email = '${email}' 
      where u.role_id = 3
      and u.user_id = ${user_id};`;

    return db.load(sql);
  },
  del(id) {
    const sql = `delete
      from ${tbl_users} u
      where u.role_id = 3
      and u.user_id = ${id}`;
    return db.load(sql);
  },

  async checkEmail(email) {
    const sql = `select *
    from ${tbl_users} u
    where u.email = '${email}'`;
    const ret = await db.load(sql);
    if (ret.length === 0) {
      return undefined;
    }
    return ret[0];
  },
  addLinkOTP(link_otp, email) {
    const sql = `update ${tbl_users} u
    set u.otp_verify_url = '${link_otp}'
    where u.email = '${email}';
    `;
    return db.load(sql);
  },

  add(entity) {
    return db.add(entity, tbl_users);
  },
};

module.exports = instructorModel;
