const express = require('express');
const router = express.Router();
const conn = require('../utils/db');
const list = require('../mock/dichvu.json');

// List all
router.get('/',  function (req, res) {
  const data = {
    path: 'services',
    pageTitle: "Dịch vụ",
  }
  try {
    const db = conn(req.session.user);
    data.list = list;
  } catch (error) {
    console.log(error);
    data.error = {
      message: "Không có quyền xem danh sách dịch vụ"
    };
  }
  finally {
    res.render('services', data);
  }
})

module.exports = router;