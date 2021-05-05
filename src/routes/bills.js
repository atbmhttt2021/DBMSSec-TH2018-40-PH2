const express = require('express');
const router = express.Router();
const conn = require('../utils/db');
const list = require('../mock/hoadon.json');

// List all
router.get('/',  function (req, res) {
  const data = {
    path: 'bills',
    pageTitle: "Hóa đơn",
  }
  try {
    const db = conn(req.session.user);
    data.list = list;
  } catch (error) {
    console.log(error);
    data.error = {
      message: "Không có quyền xem danh sách hóa đơn"
    };
  }
  finally {
    res.render('bills', data);
  }
})

module.exports = router;