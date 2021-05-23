const router = require("express").Router();
const instructorModel = require("./../models/instructor.model");
const insUploadModel = require("../models/insUpload.model");
const bcryptjs = require("bcryptjs");
const randomstring = require("randomstring");
const { sendOTP } = require("../config/nodemailer");

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
