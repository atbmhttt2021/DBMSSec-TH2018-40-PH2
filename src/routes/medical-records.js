const express = require('express');
const router = express.Router();
const medicalRecordModel = require('../models/medical-record.model');

// Load page
router.get('/', async function (req, res) {
  const data = {
    user: req.user,
    path: 'medical-records',
    pageTitle: "Quản lý bệnh viện|Hồ sơ khám bệnh",
  }
  try {
    const model = medicalRecordModel(req.session.passport.user)
    data.list = await model.all();
    console.log('data.list  :>> ', data.list );
  } catch (error) {
    console.log(error);
    data.error = {
      message: "Không có quyền xem danh sách hồ sơ bệnh án"
    };
  }
  finally {
    res.render('medical-records', data);
  }
})

// List all
router.get('/list', async function (req, res) {
  const model = medicalRecordModel(req.session.passport.user)
  const list = await model.all();
  res.status(200).json(list);
})

// Get one
router.get('/:id', async function (req, res) {
  const id = req.params.id;
  try {
    const model = medicalRecordModel(req.session.passport.user)
    info = await model.single(id);;
    res.status(200).json(info)
  } catch (error) {
    console.log(error);
    res.status(403).json({ message: `Không có quyền xem hồ sơ bênh án ${id}` })
  }
})

// Add
router.post('/', async function (req, res) {
  const { oldid } = req.query;
  const MATT = req.user.ID_NHANVIEN;
  const data = { ...req.body, MATT };
  try {
    const model = medicalRecordModel(req.session.passport.user)
    let id;
    if (oldid) {
      id = await model.addByOldId(oldid, data);
    }
    if (!oldid) {
      id = await model.add(data);
    }
    res.status(200).json({ id })
  } catch (error) {
    res.status(500).json({ message: 'Lỗi' })
  }
})

// Update
router.put('/:id', async function (req, res) {
  const id = req.params.id;
  const data = req.body;
  try {
    const model = medicalRecordModel(req.session.passport.user)
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
    const model = medicalRecordModel(req.session.passport.user)
    await model.delete(id);
    res.status(200).json({ status: 'ok' })
  } catch (error) {
    res.status(400).json({ message: 'Lỗi' })
  }
})


module.exports = router;