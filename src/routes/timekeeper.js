const express = require('express');
const router = express.Router();
const conn = require('../utils/db');
const list = require('../mock/chamcong.json');

// List all
router.get('/',  function (req, res) {
  const data = {
    path: 'timekeeper',
    pageTitle: "Chấm công",
  }
  try {
    const db = conn(req.session.user);
    data.list = list;
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