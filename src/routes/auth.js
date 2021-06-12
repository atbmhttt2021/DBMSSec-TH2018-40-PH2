const express = require('express');
const router = express.Router();
const passport = require('passport');
const { withNoAuth } = require('../middlewares/withAuth');

// Load login page
router.get('/login', withNoAuth, function (req, res) {
  res.render('login', {
    path: 'login',
    pageTitle: "Đăng nhập"
  });
})

// Login action
router.post('/login', (req, res, next) => passport.authenticate('local', (error, user, info) => {
  if (error) {
    return res.status(500).json(error);
  }
  if (!user) {
    return res.status(401).json(info.message);
  }
  req.logIn(user, function (err) {
    if (err) {
      return next(err);
    }
    return res.status(200).json({ status: 'OK' });
  })

})(req, res, next))

// Logout action
router.get('/logout', function (req, res) {
  req.logout();
  req.session.destroy(function (err) {
    res.redirect('/auth/login');
  });
})

module.exports = router;