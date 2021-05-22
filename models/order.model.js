const db = require("../config/db");
const tbl_courses = `courses`;
const tbl_subjects = `subjects`;
const tbl_categories = `categories`;
const tbl_instructor_courses_uploaded = `instructor_courses_uploaded`;
const tbl_users = `users`;
const tbl_chapters = `chapters`;
const tbl_lessons = `lessons`;
const tbl_course_reviews = `course_reviews`;
const tbl_roles = `roles`;
const tbl_student_enrolls = `student_enrolls`;
const tbl_sales = `sales`;
const tbl_carts = `carts`;
const tbl_orders = `orders`;
const tbl_orders_details = `orders_details`;

const orderModel = {
  add(user_id, order_day) {
    const sql = `insert into
     ${tbl_orders} (user_id,order_day) 
     values (${user_id},str_to_date('${order_day}','%d-%m-%Y'));`;

    return db.load(sql);
  },
  addOrderDetail(entity) {
    return db.add(entity, tbl_orders_details);
  },
};

module.exports = orderModel;
