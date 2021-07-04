const moment = require('moment');
const conn = require('../utils/db');
const { schema } = require('../utils/config');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      const listRecord=db('HOSOBENHNHAN').withSchema(schema);
      
      return listRecord;
    },

    async single(id) {
      const records = await db('HOSOBENHNHAN').withSchema(schema)
        .join('NHANVIEN', 'NHANVIEN.ID_NHANVIEN', '=', 'HOSOBENHNHAN.MABS')
        .select('HOSOBENHNHAN.*', { 'TENBS': 'NHANVIEN.TENNV' })
        .where('ID_KHAMBENH', id);
      if (records.length === 0) {
        return null;
      }
      return records[0];
    },

    async add(record) {
      const today = moment(new Date()).format('YYYY-MM-DD');
      const ids = await db('HOSOBENHNHAN').withSchema(schema)
        .insert({
          ...record,
          NGAYKB: db.raw(`TO_DATE('${today}', 'yyyy/mm/dd')`)
        })
        .returning('ID_KHAMBENH');
      if (ids.length === 0) {
        return null;
      }
      return ids[0];
    },

    async addByOldId(id, record) {
      const today = moment(new Date()).format('YYYY-MM-DD');
      const patients = await db('HOSOBENHNHAN').withSchema(schema)
        .select('ID_BENHNHAN')
        .where('ID_KHAMBENH', id);
      if (patients.length === 0) {
        return null;
      }
      const patientId = patients[0].ID_BENHNHAN;
      const ids = await db('HOSOBENHNHAN').withSchema(schema)
        .insert({
          ...record,
          NGAYKB: db.raw(`TO_DATE('${today}', 'yyyy/mm/dd')`),
          ID_BENHNHAN: patientId
        })
        .returning('ID_KHAMBENH');
      if (ids.length === 0) {
        return null;
      }
      return ids[0];
    },

    update(id, record) {
      return db('HOSOBENHNHAN')
        .where('ID_KHAMBENH', id)
        .update(record);
    },
  }
};