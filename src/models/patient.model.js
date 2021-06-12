const conn = require('../utils/db');
const schema = 'SYSADMIN';
const moment = require('moment');

module.exports = credenticals => {
  const db = conn(credenticals);
  return {

    all() {
      return db('BENHNHAN').withSchema(schema);
    },

    async single(id) {
      const patients = await db('BENHNHAN')
        .withSchema(schema)
        .where('ID_BENHNHAN', id);
      if (patients.length === 0) {
        return null;
      }
      return patients[0];
    },

    async add(patient) {
      const ids = await db('BENHNHAN')
        .withSchema(schema)
        .insert({
          ...patient,
          NGAYSINH: db.raw(`TO_DATE('${patient.NGAYSINH}', 'yyyy/mm/dd')`)
        })
        .returning('ID_BENHNHAN');
      if (ids.length === 0) {
        return null;
      }
      return ids[0];
    },

    update(id, patient) {
      console.log('id :>> ', id);
      console.log('patient :>> ', patient);
      return db('BENHNHAN')
        .withSchema(schema)
        .where('ID_BENHNHAN', id)
        .update({
          ...patient,
          NGAYSINH: db.raw(`TO_DATE('${patient.NGAYSINH}', 'yyyy/mm/dd')`)
        });
    },

    delete(id) {
      return db('BENHNHAN')
        .withSchema(schema).where('ID_BENHNHAN', id).del();
    },
  }
};