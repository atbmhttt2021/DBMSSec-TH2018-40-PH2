const express = require('express');
const router = express.Router();
const conn = require('../utils/db');
const list = require('../mock/benhnhan.json');

// List all
router.get('/',  function (req, res) {
  const data = {
    path: 'patients',
    pageTitle: "Bệnh nhân",
  }
  try {
    const db = conn(req.session.user);
    data.list = list;
  } catch (error) {
    console.log(error);
    data.error = {
      message: "Không có quyền xem danh sách bệnh nhân"
    };
  }
  finally {
    res.render('patients', data);
  }
})

module.exports = router;