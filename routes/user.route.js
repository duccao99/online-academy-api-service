const router = require("express").Router();
const bcryptjs = require("bcryptjs");
const validate = require("../middlewares/validate.mdw");
const userModel = require("../models/user.model");
const userSchema = require("../schema/user.schema.json");
const randomstring = require("randomstring");
const { sendOTP } = require("../config/nodemailer");

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

router.post("/sign-up", validate(userSchema), async function (req, res) {
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

  // send otp
  const link_otp = `${process.env.DEV_URL}/${randomstring.generate(80)}`;

  const ret_add_link_otp = await userModel.addLinkOTP(link_otp, user_add.email);

  sendOTP(user_add.email, link_otp);

  if (+ret.affectedRows === 1) {
    return res.json({
      message: "User was created!",
      user_created_info: user_add,
      ret_add_link_otp: ret_add_link_otp.message,
      link_otp,
    });
  }

  return res.status(500).json({ error_message: "Something broke!" });
});

router.post("/sign-in", async function (req, res) {
  const user = req.body;

  const check_user = await userModel.singleByEmail(user.email);

  if (check_user === undefined) {
    return res.status(400).json({
      error_message: "Email not found!",
    });
  }

  if (+check_user.role_id === 4) {
    // if admin
    const check_pass = await userModel.checkPass(
      check_user.email,
      user.password
    );
    if (check_pass === true) {
      req.session.authUser = user;
      return res.json({
        message: "Sign in success!",
        href: "/admin",
        user_info: check_user,
      });
    } else {
      return res.status(400).json({
        check_pass,
      });
    }
  }

  const check_pass = await bcryptjs.compareSync(
    user.password,
    check_user.password
  );

  if (check_pass === true) {
    req.session.authUser = user;
    return res.json({
      message: "Sign in success!",
      href: "/",
      user_info: check_user,
    });
  }

  return res.status(400).json({
    check_pass,
  });
});

router.post("/facebook/sign-in", async function (req, res) {
  const user = req.body;

  const check_email = await userModel.singleByEmail(user.email);

  if (check_email === undefined) {
    user.password = "123123";
    const hashed_pass = await bcryptjs.hashSync(user.password, 10);
    const new_user = {
      ...user,
      role_id: 2,
      is_verified: false,
      otp_verify_url: "",
      password: hashed_pass,
    };
    const check_register = await userModel.add(new_user);

    // send otp
    const link_otp = `${process.env.DEV_URL}/${randomstring.generate(80)}`;

    const ret_add_link_otp = await userModel.addLinkOTP(link_otp, user.email);

    sendOTP(user.email, link_otp);

    if (+check_register.affectedRows === 1) {
      return res.json({
        message: "User was created!",
        user_info: {
          user_id: check_register.insertId,
          user_name: user["user_name"],
          email: user["email"],
          role_id: 2,
        },
        href: "/",
        ret_add_link_otp: ret_add_link_otp.message,
        link_otp,
      });
    } else {
      return res.status(500).json({ error_message: "Something broke!" });
    }
  }

  req.session.authUser = user;

  return res.json({
    message: "Sign in success!",
    href: "/",
    user_info: {
      user_id: check_email["user_id"],
      user_name: check_email["user_name"],
      email: check_email["email"],
      role_id: 2,
    },
  });
});

router.get("/check-verify-account/:email", async function (req, res) {
  const email = req.params.email;
  const ret = await userModel.getVerifyAccountStatus(email);

  if (ret === null) {
    return res.status(400).json({
      message: "User is not a student!",
    });
  }

  if (ret === true) {
    return res.json({
      isVerified: true,
    });
  }
  return res.json({
    isVerified: false,
  });
});

router.get("/link-otp/:email", async function (req, res) {
  const email = req.params.email;

  const ret = await userModel.getLinkOTP(email);

  return res.json({
    link_otp: ret,
  });
});

router.get("/access-link-otp/:link", async function (req, res) {
  const link = req.params.link;

  const ret = await userModel.verifyAccount(link);

  return res.json({
    verify_status: ret,
  });
});

module.exports = router;
