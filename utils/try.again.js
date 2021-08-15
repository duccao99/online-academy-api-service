const userModel = require('./../models/user.model');
const { sendOTPWithThirdPartySignIn } = require('../config/nodemailer');
const router = require('express').Router();

/*
 ** sign in with third party flow
 */
router.post('/google/sign-in', async function (req, res) {
  const user = {
    user_name: req.body.user_name,
    email: req.body.email
  };

  if (!user.email || !user.user_name) {
    return res.status(400);
  }

  const check_email = await userModel.singleByEmail(user.email);

  if (check_email !== undefined) {
    return res.status(400);
  }

  const new_user = {
    ...user,
    ...properties
  };

  const ret_add_new = await userModel.add(new_user);

  // send otp

  // add otp to database
  // ret
});

/*
 ** Upload file
 */
const saveImagePath = path.join(__dirname, '../public/images');

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, saveImagePath);
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname);
  }
});

// const upload = multer({ storage }).array("ava", 3);
const upload = multer({ storage }).single('ava');

upload(req, res, async function (er) {
  try {
    if (er) {
      return res.status(500).json({ er });
    } else {
      const lesson = req.body;

      console.log('video file: ', req.file);
    }
  } catch (er) {
    return res.status(500).json({ er });
  }
});
