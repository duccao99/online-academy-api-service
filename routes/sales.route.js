const salesModel = require('../models/sales.model');
const bodySchemaValidate = require('../middlewares/validate.mdw');
const auth = require('../middlewares/auth.mdw');
const router = require('express').Router();

router.patch(
  '/',
  auth,
  bodySchemaValidate(require('../schema/saleEdit.schema.json')),
  async function (req, res) {
    const { sale_percent, add_new, course_id } = req.body;

    let ret;

    if (add_new) {
      ret = await salesModel.add({
        sale_percent,
        course_id
      });
    } else {
      ret = await salesModel.edit(
        {
          sale_percent,
          course_id
        },
        { course_id }
      );
    }

    if (+ret.affectedRows === 1) {
      return res.json({
        message: 'Course sales was updated/added!'
      });
    }
    return res.status(500).json({ error_message: 'Something broke!' });
  }
);

module.exports = router;
