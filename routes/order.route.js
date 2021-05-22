const router = require("express").Router();
const orderModel = require("../models/order.model");
const moment = require("moment");

router.post("/add", async function (req, res) {
  const body = req.body;
  const toDay = Date.now();
  const order = {
    user_id: body.user_id,
    order_day: moment(toDay).format("DD-MM-YYYY"),
  };

  const ret = await orderModel.add(order.user_id, order.order_day);

  const order_id = ret.insertId;

  const course_ids = req.body.course_ids;

  let order_detail_arr = [];

  for (let i = 0; i < course_ids.length; ++i) {
    const order_detail = {
      order_id,
      course_id: course_ids[i],
      total_money: body.total_money,
    };
    const ret_order_detail = await orderModel.addOrderDetail(order_detail);
    order_detail_arr.push(ret_order_detail);
  }

  return res.json({
    order: ret,
    order_detail_arr,
  });
});

module.exports = router;
