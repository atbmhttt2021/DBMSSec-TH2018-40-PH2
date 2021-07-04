const conn = require('../utils/db');
const { schema } = require('../utils/config');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    listByPrescription(id) {
      return db('CHITIETDONTHUOC').withSchema(schema)
        .join('THUOC', 'THUOC.ID_THUOC', '=', 'CHITIETDONTHUOC.ID_THUOC')
        .where('CHITIETDONTHUOC.ID_DONTHUOC', id)
        .select('CHITIETDONTHUOC.*', 'THUOC.TENTHUOC');
    },

    add(detail) {
      return db('CHITIETDONTHUOC').withSchema(schema)
        .insert(detail);
    },

    delete(prescriptionId, medicineId) {
      return db('CHITIETDONTHUOC').withSchema(schema)
        .where('ID_DONTHUOC', prescriptionId)
        .andWhere('ID_THUOC', medicineId)
        .del();
    },
  }
};