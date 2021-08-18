const router = require('express').Router();
const extraTaskModel = require('./../models/extra-task.model');
const courseModel = require('../models/course.model');
const auth = require('../middlewares/auth.mdw');

router.get('/filter-course-by-instructor', auth, async function (req, res) {
  const instructor_id = req.query.instructor_id;
  const data = await extraTaskModel.filterCourseByInstructor(instructor_id);

  return res.json(data);
});

router.get(
  '/filter-course-by-category/:subject_id',
  auth,
  async function (req, res) {
    const subject_id = +req.params.subject_id;
    const data = await extraTaskModel.filterCourseByCat(subject_id);

    return res.json(data);
  }
);

router.get('/is-best-seller/:course_id', async function (req, res) {
  const course_id = +req.params.course_id;

  const outstanding_courses = await courseModel.getOutstandingCourse();

  let flag = false;
  for (let i = 0; i < outstanding_courses.length; ++i) {
    if (course_id === +outstanding_courses[i].course_id) {
      flag = true;
      break;
    }
  }

  return res.json(flag);
});

router.get('/is-newest/:course_id', async function (req, res) {
  const course_id = +req.params.course_id;
  let flag = false;

  const ten_new_courses = await courseModel.tenNewestCourses();

  for (let i = 0; i < ten_new_courses.length; ++i) {
    if (course_id === +ten_new_courses[i].course_id) {
      flag = true;
      break;
    }
  }

  return res.json(flag);
});

module.exports = router;
