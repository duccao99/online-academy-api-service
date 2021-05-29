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

const feedbackModel = {
  all() {
    const sql = `select * from ${tbl_course_reviews}`;
    return db.load(sql);
  },
  add(entity) {
    return db.add(entity, tbl_course_reviews);
  },
  async isExists(course_id, user_id) {
    const sql = `select * 
    from ${tbl_course_reviews} c
    where c.course_id = ${course_id}
    and c.user_id = ${user_id}`;
    const ret = await db.load(sql);

    return ret.length > 0 ? true : false;
  },

  async yourFeedback(user_id, course_id) {
    const sql = `select *
    from ${tbl_course_reviews} c
    where c.course_id = ${course_id}
    and c.user_id = ${user_id}`;

    const ret = await db.load(sql);

    if (ret.length > 0) {
      return ret[0];
    }
    return undefined;
  }
};

module.exports = feedbackModel;
