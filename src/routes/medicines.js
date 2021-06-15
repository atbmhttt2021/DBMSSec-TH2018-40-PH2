const express = require('express');
const router = express.Router();
const medicineModel = require('../models/medicine.model');

// Load page
router.get('/', async function (req, res) {
  const data = {
    path: 'medicines',
    pageTitle: "Quản lý bệnh viện|Thuốc",
  }
  try {
    const model = medicineModel(req.session.passport.user)
    data.list = await model.all();
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

// List all
router.get('/list', async function (req, res) {
  const model = medicineModel(req.session.passport.user)
  const list = await model.all();
  res.status(200).json(list);
})

// Get one
router.get('/:id', async function (req, res) {
  const id = req.params.id;
  try {
    const model = medicineModel(req.session.passport.user)
    info = await model.single(id);;
    res.status(200).json(info)
  } catch (error) {
    console.log(error);
    res.status(403).json({ message: `Không có quyền xem thuốc ${id}` })
  }
})

// Add
router.post('/', async function (req, res) {
  try {
    const model = medicineModel(req.session.passport.user)
    await model.add(req.body);
    res.status(200).json({ status: 'ok' })
  } catch (error) {
    res.status(500).json({ message: 'Lỗi' })
  }
})

// Update
router.put('/:id', async function (req, res) {
  const id = req.params.id;
  const data = req.body;
  try {
    const model = medicineModel(req.session.passport.user)
    await model.update(id, data);
    res.status(200).json({ status: 'ok' })
  } catch (error) {
    res.status(500).json({ message: 'Lỗi' })
  }
})

// Delete
router.delete('/:id', async function (req, res) {
  const id = req.params.id;
  try {
    const model = medicineModel(req.session.passport.user)
    await model.delete(id);
    res.status(200).json({ status: 'ok' })
  } catch (error) {
    res.status(400).json({ message: 'Lỗi' })
  }
})


module.exports = router;