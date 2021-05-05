const express = require('express');
const router = express.Router();
const conn = require('../utils/db');
const list = require('../mock/hosodichvu.json');

// List all
router.get('/',  function (req, res) {
  const data = {
    path: 'service-records',
    pageTitle: "Hồ sơ dịch vụ",
  }
  try {
    const db = conn(req.session.user);
    data.list = list;
  } catch (error) {
    console.log(error);
    data.error = {
      message: "Không có quyền xem danh sách hồ sơ dịch vụ"
    };
  }
  finally {
    res.render('service-records', data);
  }
})

module.exports = router;