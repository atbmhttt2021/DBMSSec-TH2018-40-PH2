const express = require('express');
const router = express.Router();
const employeeModel = require('../models/employee.model');

// Load page
router.get('/', async function (req, res) {
  const data = {
    user: req.user,
    path: 'employees',
    pageTitle: "Quản lý bệnh viện|Nhân viên",
  }
  try {
    const model = employeeModel(req.session.passport.user)
    data.list = await model.all();
  } catch (error) {
    console.log(error);
    data.error = {
      message: "Không có quyền xem danh sách nhân viên"
    };
  }
  finally {
    res.render('employees', data);
  }
})

// List doctors
router.get('/doctors', async function (req, res) {
  const model = employeeModel(req.session.passport.user)
  const list = await model.doctors();
  res.status(200).json(list);
})
// List salemen
router.get('/salemen', async function (req, res) {
  const model = employeeModel(req.session.passport.user)
  const list = await model.salemen();
  res.status(200).json(list);
})
// List cashiers
router.get('/cashiers', async function (req, res) {
  const model = employeeModel(req.session.passport.user)
  const list = await model.cashiers();
  res.status(200).json(list);
})

// Get one
router.get('/:id', async function (req, res) {
  const id = req.params.id;
  try {
    const model = employeeModel(req.session.passport.user)
    info = await model.single(id);;
    res.status(200).json(info)
  } catch (error) {
    console.log(error);
    res.status(403).json({ message: `Không có quyền xem nhân viên ${id}` })
  }
})

// Add
router.post('/', async function (req, res) {
  try {
    const model = employeeModel(req.session.passport.user)
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
    const model = employeeModel(req.session.passport.user)
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
    const model = employeeModel(req.session.passport.user)
    await model.delete(id);
    res.status(200).json({ status: 'ok' })
  } catch (error) {
    res.status(400).json({ message: 'Lỗi' })
  }
})

module.exports = router;