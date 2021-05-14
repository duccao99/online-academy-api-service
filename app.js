const express = require("express");
const cors = require("cors");
const chalk = require("chalk");
const app = express();
const auth = require("./middlewares/auth.mdw");
const bodyParser = require("body-parser");
const { check_fb_signature } = require("./utils/utils.func.js");

require("dotenv").config();
require("express-async-errors");

app.use(cors());
app.use(express.json());

app.get("/", function (req, res) {
  res.json({
    data: "Hi !",
  });
});
app.get("/api/hello-world", function (req, res) {
  res.json({
    data: "Hello World!",
  });
});
// Check Facebook Signature
app.use(
  bodyParser.json({
    verify: check_fb_signature,
  })
);

// API Service
app.use("/api/webhook", require("./routes/webhook.route"));

// Handle async errors
app.use(function (er, req, res, next) {
  console.log("Error:", er.stack);
  res.json({
    error: er,
  });
});

const PORT = process.env.PORT || 1212;
app.listen(PORT, function () {
  console.log(
    chalk.yellowBright(
      `App is listening at ${PORT}\nURL: http://localhost:1212/`
    )
  );
});
