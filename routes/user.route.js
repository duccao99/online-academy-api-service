const router = require("express").Router();
const bcryptjs = require("bcryptjs");
const validate = require("../middlewares/validate.mdw");
const userModel = require("../models/user.model");
const userSchema = require("../schema/user.schema.json");

router.get("/", async function (req, res) {
  const user_data = await userModel.all();

  if (user_data.length === 0) {
    return res.status(204).json({
      message: "No content",
    });
  }

  return res.json({
    data: user_data,
  });
});

router.post("/register", validate(userSchema), async function (req, res) {
  const user = req.body;

  const check_email = await userModel.singleByEmail(user.email);

  if (check_email !== undefined) {
    return res.status(400).json({
      error_message: "Email has been used!",
    });
  }

  const hashed_pass = await bcryptjs.hashSync(user.password, 10);

  const user_add = {
    ...req.body,
    role_id: 2,
    is_verified: false,
    otp_verify_url: "",
    password: hashed_pass,
  };
  const ret = await userModel.add(user_add);

  console.log(ret);

  if (+ret.affectedRows === 1) {
    return res.json({
      message: "User was created!",
      user_created_info: user_add,
    });
  }
  return res.status(500).json({ error_message: "Something broke!" });
});

module.exports = router;
