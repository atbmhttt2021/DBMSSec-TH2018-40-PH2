const conn = require('../utils/db');
const { schema } = require('../utils/config');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('DONTHUOC')
      .withSchema(schema)
      .orderBy('ID_DONTHUOC', 'desc');
    },

    listByMedicalRecord(recordId) {
      return db('DONTHUOC')
        .withSchema(schema)
        .where('ID_KHAMBENH', recordId)
        .orderBy('ID_DONTHUOC', 'desc');
    },

    async single(id) {
      const prescriptions = await db('DONTHUOC')
        .withSchema(schema)
        .join('NHANVIEN', 'NHANVIEN.ID_NHANVIEN', '=', 'DONTHUOC.NVPT')
        .select('DONTHUOC.*', 'NHANVIEN.TENNV')
        .where('DONTHUOC.ID_DONTHUOC', id);
      if (prescriptions.length === 0) {
        return null;
      }

      return prescriptions[0];
    },

    add(prescription) {
      return db('DONTHUOC')
        .withSchema(schema)
        .insert(prescription)
        .returning('ID_DONTHUOC');
    },

    update(id, prescription) {
      return db('DONTHUOC')
        .withSchema(schema)
        .where('ID_DONTHUOC', id)
        .update(prescription);
    },

    delete(id) {
      return db('DONTHUOC')
        .withSchema(schema)
        .where('ID_DONTHUOC', id)
        .del();
    },
  }
};