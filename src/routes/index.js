const express = require('express');
const router = express.Router();

const authRoutes = require('./auth');
const departmentRoutes = require('./departments');
const employeeRoutes = require('./employees');
const timekeeperRoutes = require('./timekeeper');
const serviceRoutes = require('./services');
const medicineRoutes = require('./medicines');
const serviceRecordRoutes = require('./service-records');
const medicalRecordRoutes = require('./medical-records');
const patientRoutes = require('./patients');
const prescriptionRoutes = require('./prescriptions');
const billsRoutes = require('./bills');
const medicineDetailRoutes = require('./medicine-detail');
const billDetailRoutes = require('./bill-detail');
const privilegeRoutes = require('./privileges');

const { withAuth } = require('../middlewares/withAuth');

router
  .use('/auth', authRoutes)
  .use('/departments', withAuth, departmentRoutes)
  .use('/employees', withAuth, employeeRoutes)
  .use('/timekeeper', withAuth, timekeeperRoutes)
  .use('/services', withAuth, serviceRoutes)
  .use('/medicines', withAuth, medicineRoutes)
  .use('/service-records', withAuth, serviceRecordRoutes)
  .use('/medical-records', withAuth, medicalRecordRoutes)
  .use('/patients', withAuth, patientRoutes)
  .use('/prescriptions', withAuth, prescriptionRoutes)
  .use('/bills', withAuth, billsRoutes)
  .use('/medicine-details', withAuth, medicineDetailRoutes)
  .use('/bill-details', withAuth, billDetailRoutes)
  .use('/privileges', withAuth, privilegeRoutes)

  .get('/', function (req, res) {
    res.redirect('/employees');
  })

module.exports = router;