const express = require("express");
const cors = require("cors");
const chalk = require("chalk");

const app = express();

app.use(cors());

app.get("/api/hello-world", function (req, res) {
  res.json({
    data: "Hello World!",
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
