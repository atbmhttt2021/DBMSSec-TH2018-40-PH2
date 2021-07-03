const express = require('express');
const morgan = require('morgan');
const path = require('path');
const session = require('express-session');
const passport = require('passport');
require('express-async-errors');
require('dotenv').config()
const routes = require('./routes/index');
const passportConfig = require('./utils/passport')

const app = express();

// use middlewares
app.use(express.json());
app.use(morgan('dev'));
app.use(express.static('assets'))

app.use(session({
  resave: true,
  saveUninitialized: true,
  secret: '1612647',
  cookie: { maxAge: 60 * 60 * 1000 }, // 1 hour session
  // store
}));
app.use(passport.initialize());
app.use(passport.session());
passportConfig();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// use routes
app.use('/', routes);

// hanle errors
app.use((req, res, next) => {
  res.status(404).json({
    error_message: "Endpoint not found"
  })
})
app.use((err, req, res, next) => {
  console.error(err.stack)
  res.status(500).json({
    error_message: "Something broke!",
    error: err.stack
  })
})

const PORT = 4000;
app.listen(PORT, function () {
  console.log(`App is running at http://localhost:${PORT}`);
})
