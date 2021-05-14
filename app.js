const express = require("express");
const cors = require("cors");
const chalk = require("chalk");
require("dotenv").config();
const app = express();

app.use(cors());
app.use(express.json());

app.get("/api/hello-world", function (req, res) {
  res.json({
    data: "Hello World!",
  });
});
// API Service
app.use("/api/webhook", require("./routes/webhook.route"));

const PORT = process.env.PORT || 1212;
app.listen(PORT, function () {
  console.log(
    chalk.yellowBright(
      `App is listening at ${PORT}\nURL: http://localhost:1212/`
    )
  );
});
