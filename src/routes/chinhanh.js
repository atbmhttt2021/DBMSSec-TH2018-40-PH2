const express = require('express');
const router = express.Router();
const chinhanhModel = require('../models/chinhanh.model');

// List all
router.get('/list', async function (req, res) {
  const model = chinhanhModel(req.session.passport.user)
  const list = await model.all();
  res.status(200).json(list);
})

// Get one
router.get('/:id', async function (req, res) {
  const id = req.params.id;
  try {
    const model = chinhanhModel(req.session.passport.user)
    info = await model.single(id);;
    res.status(200).json(info)
  } catch (error) {
    console.log(error);
    res.status(403).json({ message: `Không có quyền xem chi nhánh  ${id}` })
  }
})


module.exports = router;