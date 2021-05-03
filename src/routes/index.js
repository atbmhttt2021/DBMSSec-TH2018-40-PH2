const express = require('express');
const router = express.Router();

const authRoutes = require('./auth');
const departmentRoutes = require('./departments');
const employeeRoutes = require('./employees');
const privilegeRoutes = require('./privileges');
const otherRoutes = require('./others');
const {withAuth} = require('../middlewares/withAuth');

router
.use('/auth', authRoutes)
.use('/departments', withAuth, departmentRoutes)
.use('/employees', withAuth, employeeRoutes)
.use('/privileges', withAuth, privilegeRoutes)
.use('/others', withAuth, otherRoutes)
.get('/', function (req, res) {
  res.redirect('/employees');
})

// .get('/logs', withAuth, function (req, res) {
//   res.render('logs', {
//     path: 'logs',
//     pageTitle: "Nhật ký",
//     allow: false
//   });
// })
module.exports = router;