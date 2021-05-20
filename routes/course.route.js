const router = require("express").Router();
const courseModel = require("../models/course.model");
const subCatModel = require("../models/subCategory.model");

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
  const ret = await courseModel.allWithNoPagi();

  if (ret.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }

  if (req.query.pagi === undefined) {
    req.query.pagi = 1;
  }

  let curr_pagi = +req.query.pagi;

  const limit = 9;
  const offset = limit * (curr_pagi - 1);

  const total_courses = ret.length;

  const total_num_pagi_stuff = Math.ceil(total_courses / limit);

  const ret_pagi = await courseModel.allWithPagi(limit, offset);

  return res.json({
    all_courses_finished: ret_pagi,
    total_num_pagi_stuff,
    curr_pagi,
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

router.get("/byCat/:sub_cat_name", async function (req, res) {
  const sub_cat_name = req.params.sub_cat_name;

  const check_cat = await subCatModel.detailByName(sub_cat_name);

  if (check_cat === undefined) {
    return res.status(400).json({
      message: "Sub category not found!",
    });
  }

  let curr_pagi = 1;

  if (req.query.pagi !== undefined) {
    curr_pagi = +req.query.pagi;
  }

  const limit = 9;
  const offset = limit * (curr_pagi - 1);

  const len_course = await courseModel.allCourseBySubCatNoPagi(
    sub_cat_name,
    limit,
    offset
  );
  const ret = await courseModel.allCourseBySubCatPagi(
    sub_cat_name,
    limit,
    offset
  );

  const total_num_pagi_stuff = Math.ceil(len_course.length / limit);

  return res.json({
    course_by_sub_cat: ret,
    curr_pagi,
    total_num_pagi_stuff,
  });
});

router.get("/by-full-text-search/:text", async function (req, res) {
  const text = req.params.text;

  let curr_pagi = 1;

  if (req.query.pagi !== undefined) {
    curr_pagi = +req.query.pagi;
  }

  const limit = 9;
  const offset = limit * (curr_pagi - 1);

  const check_len = await courseModel.fullTextSearchNoPagi(text);
  const total_num_pagi_stuff = Math.ceil(check_len.length / limit);
  const ret = await courseModel.fullTextSearchPagi(text, limit, offset);

  if (ret.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }

  return res.json({
    all_courses: ret,
    total_num_pagi_stuff,
    curr_pagi,
  });
});

router.get("/by-full-text-search-name/:text", async function (req, res) {
  const text = req.params.text;

  let curr_pagi = 1;

  if (req.query.pagi !== undefined) {
    curr_pagi = +req.query.pagi;
  }

  const limit = 9;
  const offset = limit * (curr_pagi - 1);

  const ret = await courseModel.fullTextByName(text, limit, offset);
  const total_num_pagi_stuff = Math.ceil(ret.length / limit);

  if (ret.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }

  return res.json({
    all_courses: ret,
    total_num_pagi_stuff,
    curr_pagi,
  });
});

router.get("/by-full-text-search-subcat/:text", async function (req, res) {
  const text = req.params.text;

  let curr_pagi = 1;

  if (req.query.pagi !== undefined) {
    curr_pagi = +req.query.pagi;
  }

  const limit = 9;
  const offset = limit * (curr_pagi - 1);

  const ret = await courseModel.fullTextBySubcat(text, limit, offset);
  const total_num_pagi_stuff = Math.ceil(ret.length / limit);

  if (ret.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }

  return res.json({
    all_courses: ret,
    total_num_pagi_stuff,
    curr_pagi,
  });
});

router.get("/byRate/asc", async function (req, res) {
  const all_courses = await courseModel.byRateASCNoPagi();

  if (all_courses.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }

  let curr_pagi = 1;
  if (req.query.pagi !== undefined) {
    curr_pagi = +req.query.pagi;
  }

  const limit = 9;
  const offset = limit * (curr_pagi - 1);

  const total_num_pagi_stuff = Math.ceil(all_courses.length / limit);
  const course_by_rate_asc = await courseModel.byRateASCPagi(limit, offset);

  return res.json({
    course_by_rate: course_by_rate_asc,
    total_num_pagi_stuff,
    curr_pagi,
  });
});

router.get("/byRate/desc", async function (req, res) {
  const all_courses = await courseModel.byRateDESCNoPagi();

  if (all_courses.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }

  let curr_pagi = 1;
  if (req.query.pagi !== undefined) {
    curr_pagi = +req.query.pagi;
  }

  const limit = 9;
  const offset = limit * (curr_pagi - 1);

  const total_num_pagi_stuff = Math.ceil(all_courses.length / limit);
  const course_by_rate_desc = await courseModel.byRateDESCPagi(limit, offset);

  return res.json({
    course_by_rate: course_by_rate_desc,
    total_num_pagi_stuff,
    curr_pagi,
  });
});

router.get("/byPrice/asc", async function (req, res) {
  const all_courses = await courseModel.byPriceASCNoPagi();

  if (all_courses.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }

  let curr_pagi = 1;
  if (req.query.pagi !== undefined) {
    curr_pagi = +req.query.pagi;
  }

  const limit = 9;
  const offset = limit * (curr_pagi - 1);

  const total_num_pagi_stuff = Math.ceil(all_courses.length / limit);
  const byprice = await courseModel.byPriceASCPagi(limit, offset);

  return res.json({
    course_by_price: byprice,
    total_num_pagi_stuff,
    curr_pagi,
  });
});

router.get("/byPrice/desc", async function (req, res) {
  const all_courses = await courseModel.byPriceDESCNoPagi();

  if (all_courses.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }

  let curr_pagi = 1;
  if (req.query.pagi !== undefined) {
    curr_pagi = +req.query.pagi;
  }

  const limit = 9;
  const offset = limit * (curr_pagi - 1);

  const total_num_pagi_stuff = Math.ceil(all_courses.length / limit);
  const byprice = await courseModel.byPriceDESCPagi(limit, offset);

  return res.json({
    course_by_price: byprice,
    total_num_pagi_stuff,
    curr_pagi,
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
router.get("/detail/cat-price-num/:id", async function (req, res) {
  const id = +req.params.id;
  const ret = await courseModel.detailCatPriceNum(id);

  if (ret === undefined) {
    return res.status(400).json({
      message: "Course not found!",
    });
  }

  return res.json({
    cat_price_num: ret,
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
