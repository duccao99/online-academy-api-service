const router = require("express").Router();
const bcryptjs = require("bcryptjs");
const jsonwebtoken = require("jsonwebtoken");
const randomstring = require("randomstring");
const userModel = require("../models/user.model");
const SECRET_KEY = process.env.SECRET_KEY_AUTH_ACCESS_TOKEN;

router.post("/", async function (req, res) {
  const user = await userModel.detailByUserName(req.body.user_name);
  if (user === undefined) {
    return res.json({
      authenticated: false,
    });
  }

  if (!bcryptjs.compareSync(req.body.password, user.password)) {
    return res.json({
      authenticated: false,
    });
  }

  const payload = {
    userId: user.user_id,
  };
  const options = {
    expiresIn: 10 * 60, // seconds
  };
  const accessToken = jsonwebtoken.sign(payload, SECRET_KEY, options);
  const refreshToken = randomstring.generate(80);
  await userModel.patchRFToken(user.user_id, refreshToken);

  return res.json({
    authenticated: true,
    accessToken,
    refreshToken,
  });
});

router.post("/refresh", async function (req, res) {
  const { accessToken, refreshToken } = req.body;
  const { userId } = jsonwebtoken.verify(accessToken, SECRET_KEY, {
    ignoreExpiration: true,
  });

  console.log(userId);

  const ret = await userModel.isValidRFToken(userId, refreshToken);

  if (ret === true) {
    const newAccessToken = jsonwebtoken.sign({ userId }, SECRET_KEY, {
      expiresIn: 10 * 60,
    });
    return res.json({
      accessToken: newAccessToken,
    });
  }

  return res.status(404).json({
    message: "Refresh token is revoked!",
  });
});

module.exports = router;
