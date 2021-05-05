const express = require('express');
const router = express.Router();
const conn = require('../utils/db');
const list = require('../mock/donthuoc.json');

// List all
router.get('/',  function (req, res) {
  const data = {
    path: 'prescriptions',
    pageTitle: "Đơn thuốc",
  }
  try {
    const db = conn(req.session.user);
    data.list = list;
  } catch (error) {
    console.log(error);
    data.error = {
      message: "Không có quyền xem danh sách đơn thuốc"
    };
  }
  finally {
    res.render('prescriptions', data);
  }
})

module.exports = router;