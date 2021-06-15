const express = require('express');
const router = express.Router();
const billModel = require('../models/bill.model');

// Load page
router.get('/', async function (req, res) {
  const data = {
    path: 'bills',
    pageTitle: "Quản lý bệnh viện|Hóa đơn",
  }
  try {
    const model = billModel(req.session.passport.user)
    data.list = await model.all();
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

// Get one
router.get('/:id', async function (req, res) {
  const id = req.params.id;
  try {
    const model = billModel(req.session.passport.user)
    info = await model.single(id);;
    res.status(200).json(info)
  } catch (error) {
    console.log(error);
    res.status(403).json({ message: `Không có quyền xem hóa đơn ${id}` })
  }
})

// Add
router.post('/', async function (req, res) {
  try {
    console.log('req.body :>> ', req.body);
    const model = billModel(req.session.passport.user)
    const result = await model.add(req.body);
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
    const model = billModel(req.session.passport.user)
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
    const model = billModel(req.session.passport.user)
    await model.delete(id);
    res.status(200).json({ status: 'ok' })
  } catch (error) {
    res.status(400).json({ message: 'Lỗi' })
  }
})

module.exports = router;