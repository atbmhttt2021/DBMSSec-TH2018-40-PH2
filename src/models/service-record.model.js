const conn = require('../utils/db');
const billModel = require('./bill.model');
const billDetailModel = require('./bill-detail.model');
const { schema } = require('../utils/config');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('HOSO_DICHVU')
        .withSchema(schema);
    },

    async single(medicalRecordId, serviceId) {
      const records = await db('HOSO_DICHVU')
        .withSchema(schema)
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
        .withSchema(schema)
        .insert({
          ...record,
          NGAYGIO: db.raw('CURRENT_TIMESTAMP')
        })
        .returning('ID_KHAMBENH, ID_DICHVU');
      // const billDetail = {
      //   ID_KHAMBENH: response.ID_KHAMBENH
      // }
      // const billRes = billModel.add();
    },

    update(medicalRecordId, serviceId, record) {
      return db('HOSO_DICHVU')
        .withSchema(schema)
        .where('ID_KHAMBENH', medicalRecordId)
        .andWhere('ID_DICHVU', serviceId)
        .update(record);
    },

    listByMedicalRecord(medicalRecordId) {
      return db('HOSO_DICHVU')
        .join('DICHVU', 'DICHVU.ID_DICHVU', '=', 'HOSO_DICHVU.ID_DICHVU')
        .withSchema(schema)
        .where('ID_KHAMBENH', medicalRecordId)
        .select('HOSO_DICHVU.*', { 'TENDV': 'DICHVU.TENDV' })
        .orderBy('HOSO_DICHVU.NGAYGIO', 'desc');
    },
  }
};