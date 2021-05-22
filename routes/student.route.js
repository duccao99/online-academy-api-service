const router = require("express").Router();
const db = require("../config/db");
const studentModel = require("../models/student.model");

router.get("/", async function (req, res) {
  const student_data = await studentModel.all();

  if (student_data.length === 0) {
    return res.status(204).json({
      message: "No content",
    });
  }

  return res.json({
    all_students: student_data,
  });
});

router.get("/:id", async function (req, res) {
  const user_id = +req.params.id;

  const user_detail = await studentModel.detail(user_id);

  if (user_detail === undefined) {
    return res.status(204).json({
      message: "No content",
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

    return res.status(204).json({
      message: "No content",
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

router.get("/purchased-courses/:email", async function (req, res) {
  const email = req.params.email;

  const ret = await studentModel.getPurchasedCourses(email);

  if (ret.length === 0) {
    return res.status(204).json({ message: "No content" });
  }

  return res.json({
    purchased_courses: ret,
  });
});

module.exports = router;
