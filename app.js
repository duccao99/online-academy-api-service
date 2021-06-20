require('dotenv').config();
require('./config/cleardb');
const express = require('express');
require('express-async-errors');

const cors = require('cors');
const chalk = require('chalk');
const auth = require('./middlewares/auth.mdw');
const bodyParser = require('body-parser');
const { check_fb_signature } = require('./utils/utils.func.js');
const expressSession = require('express-session');
const passport = require('passport');

const app = express();

app.use(cors());
app.use(express.json());

app.set('trust proxy', 1); // trust first proxy
app.use(
  expressSession({
    secret: 'secret_key_session',
    resave: false,
    saveUninitialized: true,
    cookie: { secure: true }
  })
);

// Initialize Passport and restore authentication state, if any, from the
// session.
// app.use(passport.initialize());
// app.use(passport.session());

app.get('/', function (req, res) {
  res.json({
    data: 'Hi !'
  });
});
app.get('/api/hello-world', function (req, res) {
  res.json({
    data: 'Hello World!'
  });
});
// Check Facebook Signature
app.use(
  bodyParser.json({
    verify: check_fb_signature
  })
);

// API Service
app.use('/api/auth', require('./routes/auth.route'));
app.use('/api/user', require('./routes/user.route'));
app.use('/api/student', require('./routes/student.route'));
app.use('/api/instructor', require('./routes/instructor.route'));
app.use('/api/category', require('./routes/category.route'));
app.use('/api/sub-category', require('./routes/subCategory.route'));
app.use('/api/course', require('./routes/course.route'));
app.use('/api/webhook', require('./routes/webhook.route'));
app.use('/api/chatbot', require('./routes/chatbot.route'));
app.use('/api/order', require('./routes/order.route'));

require('./config/passport')(app);
app.get('/api/facebook/callback', function (req, res) {
  console.log('cb');
});
app.get('/auth/facebook', passport.authenticate('facebook'));

// Handle async errors
app.use(async function (er, req, res, next) {
  console.log('Error:', er.stack);

  return res.status(500).json({
    error: er
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
