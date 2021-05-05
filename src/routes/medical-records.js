const express = require('express');
const router = express.Router();
const conn = require('../utils/db');
const list = require('../mock/hosokhambenh.json');

// List all
router.get('/',  function (req, res) {
  const data = {
    path: 'medical-records',
    pageTitle: "Hồ sơ khám bệnh",
  }
  try {
    const db = conn(req.session.user);
    data.list = list;
  } catch (error) {
    console.log(error);
    data.error = {
      message: "Không có quyền xem danh sách hồ sơ khám bệnh"
    };
  }
  finally {
    res.render('medical-records', data);
  }
})

module.exports = router;