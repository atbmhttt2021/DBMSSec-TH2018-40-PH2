const express = require('express');
const router = express.Router();
const employeeModel = require('../models/employee.model');


// Toggle login privilege
router.put('/login', async function (req, res) {
  try {
    const { VAITRO, allow } = req.body;
    const model = employeeModel(req.session.passport.user)
    await model.toggleLoginRole(VAITRO, allow);
    res.status(200).json({ status: 'ok' })
  } catch (error) {
    res.status(500).json({ message: 'Lỗi' })
  }
})

// Toggle grant/revoke update service price 
router.put('/update-service-price', async function (req, res) {
  try {
    const { id, allow } = req.body;
    const model = employeeModel(req.session.passport.user)
    const info = await model.single(id);
    if (info) {
      const { VAITRO } = info;
      await model.toggleUpdateServicePriceRole(VAITRO, allow);
    }
    res.status(200).json({ status: 'ok' })
  } catch (error) {
    res.status(500).json({ message: 'Lỗi' })
  }
})

// Get one
router.get('/has-update-service-price-role/:id', async function (req, res) {
  try {
    const id = +req.params.id;
    let result = {};
    const model = employeeModel(req.session.passport.user)
    const info = await model.single(id);
    if (info) {
      const { VAITRO } = info;
      if (VAITRO) {
        result.isTaiVu = await model.hasTaiVuRole(VAITRO);
        result.hasRole = await model.hasUpdateServicePriceRole(VAITRO);
      }
    }
    res.status(200).json(result);
  } catch (error) {
    console.log(error);
    res.status(403).json({ message: 'Lỗi' })
  }
})


module.exports = router;