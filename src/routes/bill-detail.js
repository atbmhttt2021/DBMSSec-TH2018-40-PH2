const express = require('express');
const router = express.Router();
const billDetailModel = require('../models/bill-detail.model');

// List by bill id
router.get('/:id', async function (req, res) {
  const id = +req.params.id;
  const model = billDetailModel(req.session.passport.user)
  const list = await model.listByBill(id);
  res.status(200).json(list);
})

// Add
router.post('/', async function (req, res) {
  try {
    const model = billDetailModel(req.session.passport.user)
    const id = await model.add(req.body);
    res.status(200).json({ id })
  } catch (error) {
    res.status(500).json({ message: 'Lỗi' })
  }
})

// Delete
router.delete('/:id', async function (req, res) {
  const id = req.params.id;
  try {
    const model = billDetailModel(req.session.passport.user)
    await model.delete(id);
    res.status(200).json({ status: 'ok' })
  } catch (error) {
    res.status(400).json({ message: 'Lỗi' })
  }
})


module.exports = router;