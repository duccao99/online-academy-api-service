const salesModel = require("../models/sales.model");

const router = require("express").Router();

router.patch("/", async function (req, res) {
  const { sale_percent, add_new, course_id } = req.body;

  let ret;

  if (add_new) {
    ret = await salesModel.add({
      sale_percent,
      course_id,
    });
  } else {
    ret = await salesModel.edit(
      {
        sale_percent,
        course_id,
      },
      { course_id }
    );
  }

  if (+ret.affectedRows === 1) {
    return res.json({
      message: "Course sales was updated/added!",
    });
  }
  return res.status(500).json({ error_message: "Something broke!" });
});

module.exports = router;
