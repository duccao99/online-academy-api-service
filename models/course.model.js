const db = require("../config/db");
const table_courses = `courses`;
const tbl_subjects = `subjects`;
const tbl_categories = `categories`;
const tbl_orders_details = `orders_details`;
const tbl_instructor_courses_uploaded = `instructor_courses_uploaded`;
const tbl_users = `users`;
const tbl_chapters = `chapters`;
const tbl_lessons = `lessons`;
const tbl_course_reviews = `course_reviews`;
const tbl_roles = `roles`;

const courseModel = {
  all() {
    const sql = `select * from ${table_courses} `;
    return db.load(sql);
  },

  async detail(course_id) {
    const sql = `select c.course_id, c.course_name, c.course_title, 
    c.course_thumbnail, c.course_avatar_url, c.course_fee ,
    c.course_full_description, c.course_short_description,
    c.course_last_updated, c.is_finished, c.subject_id,c.views ,
    sj.subject_name,  u.user_name
    from ${table_courses} c 
    inner join ${tbl_subjects} sj 
    on sj.subject_id = c.subject_id
    inner join ${tbl_instructor_courses_uploaded} i
    on i.course_id = c.course_id
    inner join ${tbl_users} u
    on u.user_id = i.user_id
    where c.course_id = ${course_id}
    and c.is_finished = true ;`;
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
    const sql = `select c.course_id, c.course_name, c.course_title, c.course_avatar_url, 
    c.course_fee,sj.subject_id, sj.subject_name, c.views, u.user_name,  rt.avg_rate
    from ${table_courses} c
    inner join ${tbl_orders_details} od
    on od.course_id = c.course_id
    inner join ${tbl_subjects} sj
    on sj.subject_id = c.subject_id
    inner join ${tbl_instructor_courses_uploaded} ins
    on ins.course_id = c.course_id
    inner join ${tbl_users} u
    on u.user_id = ins.user_id
    inner join (
      select *, avg(star) as avg_rate
      from course_reviews as crw
      group by crw.course_id
      ) rt
    on rt.course_id = c.course_id
    group by c.course_id
    having count(od.course_id) >= 3
    and rt.avg_rate >= 4
    limit 3;`;

    return db.load(sql);
  },
  tenNewestCourses() {
    const sql = `select *
    from ${table_courses} c
    inner join ${tbl_subjects} s
    on s.subject_id = c.subject_id
    inner join ${tbl_categories} cat 
    on cat.cat_id = s.cat_id
    and c.is_finished = 1
    order by c.course_last_updated desc
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
  detailCourseSyllabus(course_id) {
    const sql = `select l.lesson_id, l.lesson_name, l.lesson_content,
     l.flag_reviewable, l.duration
    , ct.chap_id, ct.chap_name
    from ${table_courses} c
    inner join ${tbl_chapters} ct
    on ct.course_id = c.course_id
    inner join ${tbl_lessons} l
    on l.chap_id = ct.chap_id 
    where c.course_id = ${course_id};
    `;
    return db.load(sql);
  },
  allChapters(course_id) {
    const sql = `select *
    from ${tbl_chapters} c
    where c.course_id = ${course_id} ;`;
    return db.load(sql);
  },
  allLessons(course_id) {
    const sql = `select l.lesson_id, l.lesson_name, l.lesson_content, l.flag_reviewable
    , l.duration, l.chap_id, c.chap_name, c.course_id
    from ${tbl_lessons} l
    inner join ${tbl_chapters} c 
    on c.chap_id = l.chap_id
    where c.course_id =${course_id};
    `;
    return db.load(sql);
  },

  detailCourseInstructor(course_id) {
    const sql = `select ic.course_id, ic.uploaded_day, u.user_name,
     u.email, u.role_id, u.user_avatar_url, r.role_name
    from ${table_courses} c
    inner join ${tbl_instructor_courses_uploaded} ic
    on ic.course_id = c.course_id
    inner join ${tbl_users} u
    on u.user_id = ic.user_id
    inner join ${tbl_roles} r
    on r.role_id = u.role_id
    where c.course_id = ${course_id};
    `;
    return db.load(sql);
  },
  detailFiveRelativeCourseBoughtTheMost(course_id, subject_id) {
    const sql = `select c.course_id, c.course_name, c.course_title
    , c.course_thumbnail, c.course_avatar_url, c.course_fee ,
    c.course_full_description, c.course_short_description
    ,c.course_last_updated, c.is_finished, c.subject_id,c.views 
    ,sj.subject_name, scb.num_stu_bought
    from ${table_courses} c
    inner join ${tbl_subjects} sj
    on sj.subject_id = c.subject_id
    inner join (
    select * , count(*) num_stu_bought
    from ${tbl_orders_details} scb 
    group by scb.course_id
    having count(scb.course_id) > 0
    order by count(scb.course_id) desc
    ) scb
    on scb.course_id = c.course_id
    where sj.subject_id = ${subject_id}
    and c.is_finished = true
    and c.course_id != ${course_id}
    order by c.course_id
    limit 5;
    `;
    return db.load(sql);
  },

  detailCourseReviews(course_id) {
    const sql = `select cr.course_id,c.course_name, cr.star, cr.review_content
    ,u.user_id, u.user_name, u.user_avatar_url, u.role_id, r.role_name
    from ${table_courses} c
    inner join ${tbl_course_reviews} cr
    on cr.course_id = c.course_id
    inner join ${tbl_users} u
    on u.user_id = cr.user_id
    inner join ${tbl_roles} r
    on u.role_id = r.role_id
    where c.course_id = ${course_id};`;
    return db.load(sql);
  },
};

module.exports = courseModel;
