const express = require('express');
const router = express.Router();
const timekeeperModel = require('../models/timekeeper.model');

// Load page
router.get('/', async function (req, res) {
  const data = {
    user: req.user,
    path: 'timekeeper',
    pageTitle: "Quản lý bệnh viện|Chấm công",
  }
  try {
    const model = timekeeperModel(req.session.passport.user)
    data.list = await model.all();
  } catch (error) {
    console.log(error);
    data.error = {
      message: "Không có quyền xem danh sách chấm công"
    };
  }
  finally {
    res.render('timekeeper', data);
  }
})


module.exports = router;