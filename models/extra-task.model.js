const db = require('../config/db');
const courses = `courses`;
const subjects = `subjects`;
const categories = `categories`;
const orders_details = `orders_details`;
const instructor_courses_uploaded = `instructor_courses_uploaded`;
const users = `users`;
const chapters = `chapters`;
const lessons = `lessons`;
const course_reviews = `course_reviews`;
const roles = `roles`;
const student_enrolls = `student_enrolls`;
const sales = `sales`;
const orders = 'orders';

const extraTaskModel = {
  filterCourseByInstructor(instructor_id) {
    const sql = `select ins.user_id , u.user_name, c.course_id,c.course_name,c.course_fee
    ,c.views, s.sale_percent
    from ${courses} c
    left join ${instructor_courses_uploaded} ins
    on ins.course_id = c.course_id
    left join ${users} u
    on u.user_id = ins.user_id
    left join ${sales} s 
    on s.course_id = c.course_id
    where ins.user_id = ${instructor_id}
    group by c.course_id
    order by c.course_id asc;
    `;

    return db.load(sql);
  },
  filterCourseByCat(subject_id) {
    const sql = `select ins.user_id , u.user_name, c.course_id,c.course_name,c.course_fee
    ,c.views, s.sale_percent, subj.subject_id,subj.subject_name
    from ${courses} c
    left join ${instructor_courses_uploaded} ins
    on ins.course_id = c.course_id
    left join ${users} u
    on u.user_id = ins.user_id
    left join ${sales} s 
    on s.course_id = c.course_id
    left join ${subjects} subj
    on subj.subject_id = c.subject_id
    where c.subject_id = ${subject_id}
    group by c.course_id
    order by c.course_id asc;`;
    return db.load(sql);
  },
  async checkIsCourseBestSeller() {
    const sql = ``;
  }
};

module.exports = extraTaskModel;
