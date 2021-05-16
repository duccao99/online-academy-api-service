const db = require("../config/db");
const table_courses = `courses`;
const tbl_subjects = `subjects`;
const tbl_categories = `categories`;
const tbl_orders_details = `orders_details`;
const courseModel = {
  all() {
    const sql = `select * from ${table_courses} `;
    return db.load(sql);
  },

  async detail(course_id) {
    const sql = `select * from ${table_courses}
       where course_id = ${course_id}`;
    const ret = await db.load(sql);
    return ret[0];
  },

  async singleByCourseName(course_name) {
    const sql = `select * from ${table_courses} as c
    where c.course_name = '${course_name}'`;
    const ret = await db.load(sql);
    return ret[0];
  },

  del(condition) {
    return db.del(condition, table_courses);
  },
  edit(entity, condition) {
    return db.edit(entity, condition, table_courses);
  },

  getOutstandingCourse() {
    const sql = `select *
    from ${table_courses} c
    inner join ${tbl_orders_details} od
    on od.course_id = c.course_id
    having count(c.course_id) > 10;`;

    return db.load(sql);
  },
  tenNewestCourses() {
    const sql = `select *
    from ${table_courses} c
    inner join ${tbl_subjects} s
    on s.subject_id = c.subject_id
    inner join ${tbl_categories} cat 
    on cat.cat_id = s.cat_id
    where datediff(curdate(),c.course_last_updated) <7 
    and c.is_finished = 1
    limit 10;
      `;

    return db.load(sql);
  },
  tenMostViewedCourses() {
    const sql = `select *
      from ${table_courses} c 
      order by c.views desc 
      limit 10;
      `;
    return db.load(sql);
  },
};

module.exports = courseModel;
