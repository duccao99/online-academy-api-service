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

const subCatModel = {
  all() {
    const sql = `select * from ${tbl_subjects} `;
    return db.load(sql);
  },
  async detail(sub_id) {
    const sql = `select  sj.subject_id, sj.subject_name, c.cat_id, c.cat_name
    from ${tbl_subjects} sj
    inner join ${tbl_categories} c
    on c.cat_id = sj.cat_id 
    where sj.subject_id = ${sub_id} ;`;

    const data = await db.load(sql);

    return data[0];
  },
  async detailByName(name) {
    const sql = `select *
    from ${tbl_subjects} s
    where s.subject_name = '${name}';`;

    const data = await db.load(sql);

    return data[0];
  },
  add(entity) {
    return db.add(entity, tbl_subjects);
  },
  del(condition) {
    return db.del(condition, tbl_subjects);
  },
  edit(entity, condition) {
    return db.edit(entity, condition, tbl_subjects);
  },
  async singleByName(name) {
    const sql = `select *
    from ${tbl_subjects} s
    where s.subject_name = '${name}';`;

    const data = await db.load(sql);

    return data[0];
  },

  getCountCourseInSubCat() {
    const sql = `select sj.subject_id, sj.subject_name, cat.cat_name , 
    count(*) as count_course
    from ${tbl_subjects} sj
    inner join ${tbl_categories} cat
    on cat.cat_id = sj.cat_id 
    inner join ${tbl_courses} c
    on c.subject_id = sj.subject_id
    group by  sj.subject_id
    order by count_course desc;`;
    return db.load(sql);
  },
};
module.exports = subCatModel;
