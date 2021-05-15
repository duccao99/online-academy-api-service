const router = require("express").Router();

const userModel = require("../models/user.model");

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

module.exports = router;
