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

const insUploadModel = {
  add(entity) {
    return db.add(entity, tbl_instructor_courses_uploaded);
  },
  del(condition) {
    return db.del(condition, tbl_instructor_courses_uploaded);
  },
  addChapToInsUp(entity, condition1, condition2) {
    return db.add(entity, tbl_instructor_courses_uploaded);
  },
  getChapterExists(course_id) {
    const sql = `select c.chap_id, c.chap_name,
     ins_up.course_id, ins_up.user_id, cou.course_name
    from ${tbl_instructor_courses_uploaded} ins_up
    inner join ${tbl_chapters} c
    on c.chap_id = ins_up.chap_id
    inner join ${tbl_courses} cou 
    on cou.course_id = ins_up.course_id
    where ins_up.course_id = ${course_id}
    group by c.chap_name;
    `;
    return db.load(sql);
  },
  getLessonExists(chap_id) {
    const sql = `select ls.lesson_id, ls.lesson_name, chap.chap_id,
    chap.chap_name
    from ${tbl_lessons} ls
    inner join ${tbl_chapters} chap
    on chap.chap_id = ls.chap_id
    where ls.chap_id = ${chap_id}
    group by ls.lesson_name;
    `;
    return db.load(sql);
  },
};

module.exports = insUploadModel;
