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

const studentModel = {
  all() {
    const sql = `select *
    from ${tbl_users} u
    where role_id =2 ;
    `;
    return db.load(sql);
  },

  async detail(student_id) {
    const sql = `select *
      from ${tbl_users} u
      where role_id =2 
      and u.user_id = ${student_id};`;

    const data = await db.load(sql);

    return data[0];
  },
  add(entity) {
    return db.add(entity, tbl_users);
  },
  del(condition) {
    return db.del(condition, tbl_users);
  },
  edit(entity, condition) {
    return db.edit(entity, condition, tbl_users);
  },
  async getVerifyAccountStatus(user_id) {
    const sql = `select u.is_verified 
    from ${tbl_users} u
    where u.user_id = ${user_id};`;
    const ret = await db.load(sql);

    if (ret.length === 0) {
      return null;
    }

    if (ret[0] === 1) {
      return true;
    } else {
      return false;
    }
  },

  getPurchasedCourses(email) {
    const sql = `select c.course_id, c.course_name, c.course_title, c.course_avatar_url,
    c.course_fee, c.views, u.user_name as ins_name , u.user_id, sj.subject_name, sj.subject_id
    from ${tbl_orders} od
    inner join ${tbl_orders_details} odd
    on od.order_id = odd.order_id
    inner join ${tbl_courses} c
    on c.course_id = odd.course_id 
    inner join ${tbl_users} u
    on u.user_id = od.user_id 
    inner join ${tbl_subjects} sj
    on sj.subject_id = c.subject_id
    where u.email = '${email}'
    group by c.course_id ;`;

    return db.load(sql);
  },

  getPurchasedCourses2(email) {
    const sql = `select od.order_id, od.user_id, od.order_day, odd.course_id,
   odd.total_money, c.course_name, c.course_avatar_url ,sj.subject_id,
   sj.subject_name
   from ${tbl_orders} od
   inner join ${tbl_orders_details} odd
   on od.order_id = odd.order_id
   inner join ${tbl_users} u 
   on u.user_id = od.user_id 
   inner join ${tbl_courses} c
   on c.course_id = odd.course_id
   inner join ${tbl_subjects} sj 
    on sj.subject_id = c.subject_id
   where u.email = '${email}' ;`;
    return db.load(sql);
  },
};

module.exports = studentModel;
