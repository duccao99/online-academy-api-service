const router = require("express").Router();
const courseModel = require("../models/course.model");

router.get("/", async function (req, res) {
  const courses = await courseModel.all();

  if (courses.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }

  return res.json({
    courses,
  });
});

router.post("/", async function (req, res) {
  return res.json({ message: "Update later!" });
});

router.get("/outstanding-courses", async function (req, res) {
  const ret = await courseModel.getOutstandingCourse();

  if (ret.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }
  return res.json({
    outstanding_courses: ret,
  });
});

router.get("/ten-newest-courses", async function (req, res) {
  const ret = await courseModel.tenNewestCourses();

  if (ret.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }
  return res.json({
    ten_newest_courses: ret,
  });
});
router.get("/ten-most-viewed-courses", async function (req, res) {
  const ret = await courseModel.tenMostViewedCourses();

  if (ret.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }
  return res.json({
    ten_most_viewed_courses: ret,
  });
});

router.get("/:id", async function (req, res) {
  const id = +req.params.id;

  const course_detail = await courseModel.detail(id);

  if (course_detail === undefined) {
    return res.status(400).json({ message: "Course not found!" });
  }

  return res.json({
    course_detail,
  });
});

router.delete("/:id", async function (req, res) {
  const id = +req.params.id;

  const course_detail = await courseModel.detail(id);

  if (course_detail === undefined) {
    return res.status(400).json({ message: "Course not found!" });
  }
  const condition = {
    course_id: id,
  };

  const ret = await courseModel.del(condition);

  if (+ret.affectedRows === 1) {
    return res.json({
      message: "Course was deleted!",
      info: course_detail,
    });
  }
  return res.status(500).json({ error_message: "Something broke!" });
});

module.exports = router;
