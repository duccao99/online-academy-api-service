const db = require('../config/db');
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

const enrollModel = {
  add(entity) {
    return db.add(entity, tbl_student_enrolls);
  },
  async isExists(user_id, course_id) {
    const sql = `select * 
  from ${tbl_student_enrolls} s
  where s.user_id = ${user_id}
  and s.course_id = ${course_id}`;
    const ret = await db.load(sql);
    return ret.length > 0 ? true : false;
  }
};

module.exports = enrollModel;
