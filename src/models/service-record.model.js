const conn = require('../utils/db');
const billModel = require('./bill.model');
const billDetailModel = require('./bill-detail.model');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('HOSO_DICHVU');
    },

    async single(medicalRecordId, serviceId) {
      const records = await db('HOSO_DICHVU')
        .join('DICHVU', 'DICHVU.ID_DICHVU', '=', 'HOSO_DICHVU.ID_DICHVU')
        .where('HOSO_DICHVU.ID_KHAMBENH', medicalRecordId)
        .andWhere('DICHVU.ID_DICHVU', serviceId)
        .select('HOSO_DICHVU.*', { 'TENDV': 'DICHVU.TENDV' });
      if (records.length === 0) {
        return null;
      }
      return records[0];
    },

    async add(record) {
      const recordRes = await db('HOSO_DICHVU')
        .insert({
          ...record,
          NGAYGIO: db.raw('CURRENT_TIMESTAMP')
        })
        .returning('ID_KHAMBENH, ID_DICHVU');
    },

    update(medicalRecordId, serviceId, record) {
      return db('HOSO_DICHVU')
        .where('ID_KHAMBENH', medicalRecordId)
        .andWhere('ID_DICHVU', serviceId)
        .update(record);
    },

    listByMedicalRecord(medicalRecordId) {
      return db('HOSO_DICHVU')
        .join('DICHVU', 'DICHVU.ID_DICHVU', '=', 'HOSO_DICHVU.ID_DICHVU')
        .where('ID_KHAMBENH', medicalRecordId)
        .select('HOSO_DICHVU.*', { 'TENDV': 'DICHVU.TENDV' })
        .orderBy('HOSO_DICHVU.NGAYGIO', 'desc');
    },
  }
};