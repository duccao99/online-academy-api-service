const router = require("express").Router();
const subCatModel = require("../models/subCategory.model");
const validate = require("../middlewares/validate.mdw");
const subCatSchema = require("../schema/subCat.schema.json");

router.get("/", async function (req, res) {
  const data = await subCatModel.all();

  if (data.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }

  return res.json({
    all_sub_cats: data,
  });
});

router.get("/count-course-in-sub-cat", async function (req, res) {
  const ret = await subCatModel.getCountCourseInSubCat();

  if (ret.length === 0) {
    return res.status(204).json({ message: "No content!" });
  }

  return res.json({
    count_course: ret,
  });
});

router.get("/:id", async function (req, res) {
  const id = +req.params.id;
  const sub_cat_detail = await subCatModel.detail(id);

  if (sub_cat_detail === undefined) {
    return res.status(400).json({ message: "Sub cat not found!" });
  }

  return res.json({
    sub_cat_detail: sub_cat_detail,
  });
});

router.post("/", validate(subCatSchema), async function (req, res) {
  const subCat = req.body;

  const check_subCat_name = await subCatModel.singleByName(subCat.subject_name);

  if (check_subCat_name !== undefined) {
    return res.status(400).json({ message: "Sub category already have!" });
  }

  const entity = {
    ...subCat,
  };
  const ret = await subCatModel.add(entity);

  if (+ret.affectedRows === 1) {
    return res.json({
      message: "Sub category was created!",
      info: entity,
    });
  }
  return res.status(500).json({ error_message: "Something broke!" });
});

router.delete("/:id", async function (req, res) {
  const id = +req.params.id;
  const check_id = await subCatModel.detail(id);

  if (check_id === undefined) {
    return res.status(400).json({ error_message: "Sub category not found!" });
  }
  const condition = {
    subject_id: id,
  };

  const ret = await subCatModel.del(condition);
  if (+ret.affectedRows === 1) {
    return res.json({
      message: "Sub category was deleted!",
      info: check_id,
    });
  }
  return res.status(500).json({ error_message: "Something broke!" });
});

router.patch("/:id", async function (req, res) {
  const id = +req.params.id;
  const sub_cat = req.body;
  const check_sub_cat = await subCatModel.detail(id);

  if (check_sub_cat === undefined) {
    return res.status(400).json({ error_message: "Sub category not found!" });
  }

  const entity = {
    ...sub_cat,
  };
  const condition = {
    subject_id: id,
  };

  const ret = await subCatModel.edit(entity, condition);

  if (+ret.affectedRows === 1) {
    return res.json({
      message: "Sub category was updated!",
      info: entity,
    });
  }
  return res.status(500).json({ error_message: "Something broke!" });
});

module.exports = router;
