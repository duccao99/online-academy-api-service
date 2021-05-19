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

router.get("/all-with-finished", async function (req, res) {
  const ret = await courseModel.all();

  if (ret.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }

  if (req.query.pagi === undefined) {
    req.query.pagi = 1;
  }

  let curr_page = +req.query.pagi;

  if (curr_page === 0) {
    curr_page = 1;
  }

  const limit = 9;
  const offset = limit * (curr_page - 1);

  const total_courses = ret.length;
  const total_num_pagi_stuff = Math.ceil(total_courses / limit);

  const ret_pagi = await courseModel.allWithPagi(limit, offset);

  return res.json({
    all_courses_finished: ret_pagi,
    total_num_pagi_stuff,
    curr_page,
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

router.get("/top-sub-cat", async function (req, res) {
  const ret = await courseModel.topSubCat();

  if (ret.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }
  return res.json({
    top_sub_cat: ret,
  });
});

router.get("/detail/syllabus/:id", async function (req, res) {
  const id = +req.params.id;

  const course_detail = await courseModel.detail(id);

  if (course_detail === undefined) {
    return res.status(400).json({ message: "Course not found!" });
  }

  const all_chapters = await courseModel.allChapters(id);
  const all_lessons = await courseModel.allLessons(id);

  return res.json({
    course_syllabus: {
      all_chapters,
      all_lessons,
    },
  });
});

router.get("/detail/instructor/:id", async function (req, res) {
  const id = +req.params.id;

  const course_detail = await courseModel.detail(id);

  if (course_detail === undefined) {
    return res.status(400).json({ message: "Course not found!" });
  }

  const ret = await courseModel.detailCourseInstructor(id);

  return res.json({
    course_instructor: ret,
  });
});

router.get("/detail/five-relative-bought-most/:id", async function (req, res) {
  const id = +req.params.id;

  const course_detail = await courseModel.detail(id);

  if (course_detail === undefined) {
    return res.status(400).json({ message: "Course not found!" });
  }

  const ret = await courseModel.detailFiveRelativeCourseBoughtTheMost(
    course_detail.course_id,
    course_detail.subject_id
  );

  return res.json({
    five_relative_cat_course: ret,
  });
});

router.get("/detail/course-review/:id", async function (req, res) {
  const id = +req.params.id;

  const course_detail = await courseModel.detail(id);

  if (course_detail === undefined) {
    return res.status(400).json({ message: "Course not found!" });
  }

  const ret = await courseModel.detailCourseReviews(course_detail.course_id);

  return res.json({
    course_reviews: ret,
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
