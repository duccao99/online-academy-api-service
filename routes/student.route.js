const router = require("express").Router();
const db = require("../config/db");
const studentModel = require("../models/student.model");
const feedbackModel = require("../models/feedback.model");
const historyModel = require("../models/history.model");
const enrollModel = require("../models/enroll.model");

router.get("/", async function (req, res) {
  const student_data = await studentModel.all();

  if (student_data.length === 0) {
    return res.status(404).json({
      message: "Student not found",
    });
  }

  return res.json({
    all_students: student_data,
  });
});

router.post("/enroll", async function (req, res) {
  if (!req.body.user_id || !req.body.course_id) {
    return res.status(400).json({
      message: "Cannot empty!",
    });
  }
  // check if exists then not add
  const isExists = await enrollModel.isExists(
    +req.body.user_id,
    +req.body.course_id
  );

  if (isExists) {
    return res.status(400).json({
      message: "Student enrolled this course!",
    });
  }
  // if not exists then add
  const entity = {
    user_id: +req.body.user_id,
    course_id: +req.body.course_id,
  };
  const ret = await enrollModel.add(entity);

  return res.json({
    ret_add_enroll: ret,
    entity_added: entity,
  });
});

router.get("/is-favorite", async function (req, res) {
  const course_id = +req.query.course_id;
  const user_id = +req.query.user_id;

  const ret = await studentModel.isFavorite(course_id, user_id);

  return res.json({
    is_favorite: ret,
  });
});
router.get("/favorite-courses/:user_id", async function (req, res) {
  const user_id = +req.params.user_id;
  const ret = await studentModel.getFavoriteCourse(user_id);

  if (ret.length === 0) {
    return res.status(404).json({ message: "Course not found!" });
  }

  return res.json({
    favorite_courses: ret,
  });
});

router.patch("/toggle-favorite", async function (req, res) {
  const data = {
    user_id: +req.body.user_id,
    course_id: +req.body.course_id,
    is_favorite: !req.body.is_favorite,
  };

  // check if exists
  const is_exists = await studentModel.isExistsFavorite(
    data.user_id,
    data.course_id
  );

  if (is_exists === true) {
    const ret = await studentModel.toggleFavorite(
      data.user_id,
      data.course_id,
      data.is_favorite
    );
    return res.json({
      ret_toggle_favorite: ret,
    });
  } else {
    // if the course is not favorite before
    const ret_add_to_favorite = await studentModel.addToFavorite(
      data.user_id,
      data.course_id,
      true
    );
    return res.json({
      ret_add_to_favorite,
    });
  }
});

router.get("/purchases-course-id/:user_id", async function (req, res) {
  const user_id = req.params.user_id;

  const ret = await studentModel.getPurchasedCoursesId(user_id);

  if (ret.length === 0) {
    return res.status(404).json({ message: "Course not found!" });
  }

  purchased_courses_id_list = ret.map((course) => course.course_id);

  return res.json({
    purchased_courses_id_list,
  });
});

router.get("/purchased-courses/:email", async function (req, res) {
  const email = req.params.email;

  const ret = await studentModel.getPurchasedCourses(email);

  if (ret.length === 0) {
    return res.status(404).json({ message: "Course not found!" });
  }

  return res.json({
    purchased_courses: ret,
  });
});

router.post("/upload-feedback", async function (req, res) {
  if (
    !req.body.user_id ||
    !req.body.course_id ||
    !req.body.review_content ||
    !req.body.star
  ) {
    return res.status(400).json({
      message: "Cannot empty!",
    });
  }

  const isExists = await feedbackModel.isExists(
    +req.body.course_id,
    +req.body.user_id
  );

  if (isExists === true) {
    return res.status(400).json({
      message: "Feedback already exists!",
    });
  }

  const feedback = {
    user_id: +req.body.user_id,
    course_id: +req.body.course_id,
    review_content: req.body.review_content,
    star: +req.body.star,
  };

  const ret = await feedbackModel.add(feedback);

  if (+ret.affectedRows) {
    return res.json({
      message: "Added new feedback!",
      ret_add_feedback: ret,
    });
  }
});

router.get("/your-feedback", async function (req, res) {
  if (!req.query.user_id || !req.query.course_id) {
    return res.status(400).json({
      message: "Cannot empty!",
    });
  }

  const data = {
    user_id: +req.query.user_id,
    course_id: +req.query.course_id,
  };

  const ret = await feedbackModel.yourFeedback(data.user_id, data.course_id);

  if (ret === undefined) {
    return res.status(404).json({
      message: "Do not have feedback!",
    });
  }

  return res.json({
    your_feedback: ret,
  });
});

router.post("/history-watching", async function (req, res) {
  if (!req.body.user_id || !req.body.start_time) {
    return res.status(400).json({
      message: "Cannot empty!",
    });
  }

  const ret_check_exist_history = await historyModel.isExists(
    +req.body.user_id,
    +req.body.lesson_id
  );

  if (ret_check_exist_history === true) {
    // if exists then update it
    const entity_update = {
      start_time: +req.body.start_time,
    };

    const condition_1 = {
      user_id: +req.body.user_id,
    };

    const condition_2 = {
      lesson_id: +req.body.lesson_id,
    };

    const ret_update = await historyModel.edit(
      entity_update,
      condition_1,
      condition_2
    );

    return res.json({
      ret_update: ret_update,
    });
  }
  // if not then add it
  const entity = {
    user_id: +req.body.user_id,
    lesson_id: +req.body.lesson_id,
    start_time: +req.body.start_time,
  };

  const ret_add = await historyModel.add(entity);

  return res.json({
    ret_add_history: ret_add,
  });
});

router.get("/history", async function (req, res) {
  if (!req.query.user_id || !req.query.lesson_id) {
    return res.status(400).json({
      message: "Cannot empty!",
    });
  }

  const entity = {
    user_id: +req.query.user_id,
    lesson_id: +req.query.lesson_id,
  };

  const history_time = await historyModel.getHistoryTime(
    entity.user_id,
    entity.lesson_id
  );

  if (history_time === undefined) {
    return res.status(404).json({
      message: "History not found!",
    });
  }

  return res.json({
    history_time: +history_time,
  });
});

router.get("/:id", async function (req, res) {
  const user_id = +req.params.id;

  const user_detail = await studentModel.detail(user_id);

  if (user_detail === undefined) {
    return res.status(404).json({
      message: "Student not found",
    });
  }

  return res.json({
    student_detail: user_detail,
  });
});

router.delete("/:id", async function (req, res) {
  const student_id = req.params.id;

  // check if student id is in db
  const student_detail = await studentModel.detail(student_id);

  if (student_detail === undefined) {
    // if does not in

    return res.status(404).json({
      message: "Student not found",
    });
  }

  // if in then delete
  const condition = {
    user_id: student_id,
  };

  const ret = await studentModel.del(condition);

  if (+ret.affectedRows === 1) {
    return res.json({
      message: "Deleted",
    });
  }

  return res.status(500);
});

router.patch("/:id", async function (req, res) {
  const student_edit_info = req.body;
  const student_id = +req.params.id;
  // check curr user id is a student

  const student_detail = await studentModel.detail(student_id);

  if (student_detail === undefined) {
    return res.status(204).json({
      message: "No content",
    });
  }

  const entity = {
    ...student_edit_info,
  };

  const condition = {
    user_id: student_id,
  };
  const ret = await studentModel.edit(entity, condition);

  if (+ret.affectedRows === 1) {
    return res.json({
      message: "Edited",
    });
  }

  return res.status(500);
});

module.exports = router;
