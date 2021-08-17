const router = require('express').Router();
const extraTaskModel = require('./../models/extra-task.model');

router.get('/filter-course-by-instructor', async function (req, res) {
  const instructor_id = req.query.instructor_id;
  const data = await extraTaskModel.filterCourseByInstructor(instructor_id);

  return res.json(data);
});

module.exports = router;
