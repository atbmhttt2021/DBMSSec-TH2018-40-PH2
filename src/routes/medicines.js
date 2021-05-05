const express = require('express');
const router = express.Router();
const conn = require('../utils/db');
const list = require('../mock/thuoc.json');

// List all
router.get('/',  function (req, res) {
  const data = {
    path: 'medicines',
    pageTitle: "Thuốc",
  }
  try {
    const db = conn(req.session.user);
    data.list = list;
  } catch (error) {
    console.log(error);
    data.error = {
      message: "Không có quyền xem danh sách thuốc"
    };
  }
  finally {
    res.render('medicines', data);
  }
})

module.exports = router;