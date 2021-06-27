const express = require('express');
const router = express.Router();
const serviceModel = require('../models/service.model');

// Load page
router.get('/', async function (req, res) {
  const data = {
    user: req.user,
    path: 'services',
    pageTitle: "Quản lý bệnh viện|Dich vụ",
  }
  try {
    const model = serviceModel(req.session.passport.user)
    data.list = await model.all();
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

// List all
router.get('/list', async function (req, res) {
  const model = serviceModel(req.session.passport.user)
  const list = await model.all();
  res.status(200).json(list);
})


// Get one
router.get('/:id', async function (req, res) {
  const id = req.params.id;
  try {
    const model = serviceModel(req.session.passport.user)
    info = await model.single(id);;
    res.status(200).json(info)
  } catch (error) {
    console.log(error);
    res.status(403).json({ message: `Không có quyền xem dịch vụ ${id}` })
  }
})

// Add
router.post('/', async function (req, res) {
  try {
    console.log('req.body :>> ', req.body);
    const model = serviceModel(req.session.passport.user)
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
    const model = serviceModel(req.session.passport.user)
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
    const model = serviceModel(req.session.passport.user)
    await model.delete(id);
    res.status(200).json({ status: 'ok' })
  } catch (error) {
    res.status(400).json({ message: 'Lỗi' })
  }
})


module.exports = router;