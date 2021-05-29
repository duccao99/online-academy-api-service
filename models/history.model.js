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
const tbl_student_watching = `student_watching`;

const historyModel = {
  add(entity) {
    return db.add(entity, tbl_student_watching);
  },
  edit(entity, condition_1, condition_2) {
    return db.editTwoCons(
      entity,
      condition_1,
      condition_2,
      tbl_student_watching
    );
  },
  async isExists(user_id, lesson_id) {
    const sql = `select *
        from ${tbl_student_watching} as h
        where h.user_id = ${user_id}
        and h.lesson_id = ${lesson_id}`;
    const ret = await db.load(sql);
    return ret.length > 0 ? true : false;
  },
  async getHistoryTime(user_id, lesson_id) {
    const sql = `select h.start_time 
    from ${tbl_student_watching} h
    where h.user_id = ${user_id}
    and h.lesson_id = ${lesson_id}`;
    const ret = await db.load(sql);
    if (ret.length === 0) {
      return undefined;
    }
    return ret[0].start_time;
  }
};

module.exports = historyModel;
