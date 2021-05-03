const express = require('express');
const router = express.Router();
const conn = require('../utils/db');
const list = require('../mock/donvi.json');

// List all
router.get('/',  function (req, res) {
  const data = {
    path: 'departments',
    pageTitle: "Phòng ban/Đơn vị",
  }
  try {
    const db = conn(req.session.user);
    data.list = list;
  } catch (error) {
    console.log(error);
    data.error = {
      message: "Không có quyền xem danh sách phòng ban"
    };
  }
  finally {
    res.render('departments', data);
  }
})

module.exports = router;