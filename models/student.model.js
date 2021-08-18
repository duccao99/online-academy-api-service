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
const tbl_orders = `orders`;

const tbl_student_favorites = `student_favorites`;

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

  getPurchasedCoursesId(user_id) {
    const sql = `select course_id
    from spa_online_academy.orders_details odd
    inner join spa_online_academy.orders od
    on od.order_id = odd.order_id and od.user_id = ${user_id}`;

    return db.load(sql);
  },

  getPurchasedCourses(email) {
    const sql = `select c.course_id, c.course_name, c.course_title, c.course_avatar_url, 
    c.is_finished ,sj.subject_name,
    c.course_fee, c.views, u.user_name as ins_name , u.user_id, ste.num_stu_enroll, rt.avg_rate, rt.total_review
    from ${tbl_orders} od
    inner join ${tbl_orders_details} odd
    on od.order_id = odd.order_id
    inner join ${tbl_courses} c
    on c.course_id = odd.course_id and c.is_banned = 0
    inner join ${tbl_users} u
    on u.user_id = od.user_id 
    inner join ${tbl_subjects} sj
    on sj.subject_id = c.subject_id
    left join (
    select *, count(*) as total_review, avg(star) as avg_rate
    from course_reviews crw 
    group by crw.course_id
    ) rt
    on rt.course_id = c.course_id
    left join (
    select *,count(*) as num_stu_enroll
    from ${tbl_student_enrolls} ste
    group by ste.course_id
    ) ste
    on ste.course_id = c.course_id
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
   on c.course_id = odd.course_id  and c.is_banned = 0
   inner join ${tbl_subjects} sj 
   on sj.subject_id = c.subject_id
   select *, avg(star) as avg_rate
  from course_reviews crw 
  group by crw.course_id
  ) rt
  on rt.course_id = c.course_id
  left join (
  select *,count(*) as num_stu_enroll
  from ${tbl_student_enrolls} ste
  group by ste.course_id
  ) ste
  on ste.course_id = c.course_id
   where u.email = '${email}' ;`;
    return db.load(sql);
  },
  getFavoriteCourse(user_id) {
    const sql = `select sf.fav_id, sf.user_id, sf.course_id, sf.is_favorite,
    u.user_name as stu_name, c.course_name, c.course_fee, ins.user_name as ins_name,
    c.course_avatar_url, c.course_fee, c.views
     from ${tbl_student_favorites} sf
     left join ${tbl_users} u
     on u.user_id = sf.user_id
     left join ${tbl_courses} c
     on c.course_id = sf.course_id and c.is_banned = 0
     left join (
     select u.user_name, ins.user_id, c.course_id
     from ${tbl_instructor_courses_uploaded} ins
     inner join ${tbl_courses} c
     on ins.course_id = c.course_id and c.is_banned = 0
     inner join ${tbl_users} u
     on u.user_id = ins.user_id
     ) ins
     on ins.course_id = c.course_id
     where sf.user_id = ${user_id}
     and sf.is_favorite= true
     group by c.course_id
     ;`;
    return db.load(sql);
  },
  async isFavorite(course_id, user_id) {
    const sql = `select sf.is_favorite
    from ${tbl_student_favorites} sf 
    where  sf.user_id = ${user_id}
    and sf.course_id = ${course_id};
    `;
    const ret = await db.load(sql);

    if (ret.length > 0) {
      return ret[0].is_favorite;
    }

    return false;
  },
  toggleFavorite(user_id, course_id, is_favorite) {
    const sql = `update  ${tbl_student_favorites} sf
    set sf.is_favorite = ${is_favorite}
    where sf.user_id = ${user_id}
    and sf.course_id = ${course_id} ;`;

    return db.load(sql);
  },
  async isExistsFavorite(user_id, course_id) {
    const sql = `select *
    from ${tbl_student_favorites} sf 
    where  sf.user_id = ${user_id}
    and sf.course_id = ${course_id};
    `;
    const ret = await db.load(sql);

    if (ret.length > 0) {
      return true;
    } else {
      return false;
    }
  },

  addToFavorite(user_id, course_id, is_favorite) {
    const sql = `insert 
    into ${tbl_student_favorites}
    (user_id,course_id,is_favorite) 
    values (${user_id},${course_id},true);`;
    return db.load(sql);
  }
};

module.exports = studentModel;
