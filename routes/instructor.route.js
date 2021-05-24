const router = require("express").Router();
const instructorModel = require("./../models/instructor.model");
const insUploadModel = require("../models/insUpload.model");
const bcryptjs = require("bcryptjs");
const randomstring = require("randomstring");
const { sendOTP } = require("../config/nodemailer");
const multer = require("multer");
const fs = require("fs");
const path = require("path");
const moment = require("moment");
const courseModel = require("../models/course.model");

router.get("/", async function (req, res) {
  const ret = await instructorModel.all();

  if (ret.length === 0) {
    return res.status(404).json({
      message: "Instructor not found!",
    });
  }

  return res.json({
    instructors: ret,
  });
});

router.get("/:id", async function (req, res) {
  const id = +req.params.id;

  const ret = await instructorModel.detail(id);

  if (ret.length === 0) {
    return res.status(404).json({ message: "Instructor not found!" });
  }
  return res.json({
    instructor_detail: ret[0],
  });
});

router.post("/upload-course", async function (req, res) {
  try {
    const saveImagePath = path.join(__dirname, "../public/images");

    const storage = multer.diskStorage({
      destination: function (req, file, cb) {
        cb(null, saveImagePath);
      },
      filename: function (req, file, cb) {
        cb(null, file.originalname);
      },
    });

    const upload = multer({ storage }).single("ava");

    upload(req, res, async function (err) {
      try {
        if (err) {
          console.log(err);
          throw new Error(err);
        } else {
          const course = req.body;

          // check name
          const isNameExists = await instructorModel.isCourseNameExists(
            course.course_name
          );

          if (isNameExists === true) {
            return res.status(400).json({
              message: "Course name exists!",
            });
          }
          const toDay = Date.now();

          const course_tobe_add = {
            course_name: course.course_name,
            course_title: course.course_title,
            course_fee: +course.course_fee,
            course_full_description: course.course_full_description,
            course_short_description: course.course_short_description,
            subject_id: course.subject_id,
            is_finished: false,
            views: 0,
            course_last_updated: moment(toDay).format("YYYY/MM/DD HH:mm:ss"),
            course_avatar_url: saveImagePath,
          };
          // add to `courses`
          const ret = await courseModel.add(course_tobe_add);

          // add to `instructor_courses_uploaded`

          const insUp_entity = {
            user_id: course.user_id,
            course_id: ret.insertId,
            lesson_id: null,
            chap_id: null,
            uploaded_day: moment(toDay).format("YYYY/MM/DD HH:mm:ss"),
          };
          const ret_ins_up = await insUploadModel.add(insUp_entity);

          return res.json({
            message: "Upload course success!",
            ret_add: ret,
            ret_ins_up: ret_ins_up,
          });
        }
      } catch (er) {
        return res.status(500).json({
          message: er,
        });
      }
    });
  } catch (er) {
    return res.status(500).json({
      message: "Something broke!",
    });
  }
});

router.post("/", async function (req, res) {
  const ins = req.body;

  const ret_check_mail = await instructorModel.checkEmail(ins.email);

  if (ret_check_mail !== undefined) {
    return res.status(400).json({
      message: "Email has been use!",
    });
  }

  const hashed_pass = await bcryptjs.hashSync(ins.password, 10);

  const ins_add = {
    ...ins,
    role_id: 3,
    is_verified: false,
    otp_verify_url: "",
    password: hashed_pass,
  };

  const ret = await instructorModel.add(ins_add);

  // send otp
  const link_otp = `${process.env.DEV_URL}/${randomstring.generate(80)}`;

  const ret_add_link_otp = await instructorModel.addLinkOTP(
    link_otp,
    ins_add.email
  );

  sendOTP(ins_add.email, link_otp);

  if (+ret.affectedRows === 1) {
    return res.json({
      message: "Instructor was created!",
      ins_info: ins_add,
      ret_add_link_otp: ret_add_link_otp.message,
      link_otp,
    });
  }

  return res.status(500).json({ error_message: "Something broke!" });
});

router.patch("/:id", async function (req, res) {
  const ret = await instructorModel.edit(
    +req.params.id,
    req.body.user_name,
    req.body.email
  );

  if (+ret.affectedRows === 1) {
    return res.json({
      message: "Edited!",
      ret_update_ins: ret,
    });
  }
  return res.status(500).json({
    message: "Something broke!",
  });
});

router.delete("/:id", async function (req, res) {
  const id = +req.params.id;

  // del ins upload first
  const condition = {
    user_id: id,
  };
  const ret_del_insUpload = await insUploadModel.del(condition);

  const ret = await instructorModel.del(id);

  return res.json({
    del_ins_detail: ret,
    ret_del_insUpload,
  });
});

module.exports = router;
