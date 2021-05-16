const router = require("express").Router();
const catModel = require("../models/category.model");

router.get("/", async function (req, res) {
  const data = await catModel.all();

  if (data.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }

  return res.json({
    data,
  });
});

module.exports = router;
