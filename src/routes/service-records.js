const express = require('express');
const router = express.Router();
const serviceRecordModel = require('../models/service-record.model');

// Load page
router.get('/', async function (req, res) {
  const data = {
    path: 'service-records',
    pageTitle: "Quản lý bệnh viện|Hồ sơ dịch vụ",
  }
  try {
    const model = serviceRecordModel(req.session.passport.user)
    data.list = await model.all();
  } catch (error) {
    console.log(error);
    data.error = {
      message: "Không có quyền xem danh sách hồ sơ dịch vụ"
    };
  }
  finally {
    res.render('service-records', data);
  }
})

// List all
router.get('/list', async function (req, res) {
  const model = serviceRecordModel(req.session.passport.user)
  const list = await model.all();
  res.status(200).json(list);
})

// List by medical record id
router.get('/:id', async function (req, res) {
  const id = +req.params.id;
  const model = serviceRecordModel(req.session.passport.user)
  const list = await model.listByMedicalRecord(id);
  res.status(200).json(list);
})

// Get one
router.get('/:medialRecordId/:serviceId', async function (req, res) {
  const medialRecordId = +req.params.medialRecordId;
  const serviceId = +req.params.serviceId;
  try {
    const model = serviceRecordModel(req.session.passport.user)
    info = await model.single(medialRecordId, serviceId);;
    res.status(200).json(info)
  } catch (error) {
    console.log(error);
    res.status(403).json({ message: `Không có quyền xem hồ sơ dịch vụ có mã khám bênh ${medialRecordId} mã dịch vụ ${serviceId}` })
  }
})

// Add
router.post('/', async function (req, res) {
  const NGUOITHUCHIEN = req.user.ID_NHANVIEN;
  const data = { ...req.body, NGUOITHUCHIEN };
  try {
    const model = serviceRecordModel(req.session.passport.user)
    await model.add(data);
    res.status(200).json({ status: 'OK' })
  } catch (error) {
    res.status(500).json({ message: 'Lỗi' })
  }
})

// Update
router.put('/', async function (req, res) {
  const { ID_KHAMBENH, ID_DICHVU, ...data } = req.body;
  try {
    const model = serviceRecordModel(req.session.passport.user)
    await model.update(+ID_KHAMBENH, +ID_DICHVU, data);
    res.status(200).json({ status: 'ok' })
  } catch (error) {
    res.status(500).json({ message: 'Lỗi' })
  }
})


module.exports = router;