const conn = require('../utils/db');
const schema = 'SYSADMIN';

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('DONVI').withSchema(schema);
    },

    async single(id) {
      const departments = await db('DONVI')
        .withSchema(schema)
        .where('ID_DONVI', id);
      if (departments.length === 0) {
        return null;
      }

      return departments[0];
    },

    add(department) {
      return db('DONVI')
        .withSchema(schema)
        .insert(department);
    },

    update(id, department) {
      return db('DONVI')
        .withSchema(schema)
        .where('ID_DONVI', id)
        .update(department);
    },

    delete(id) {
      return db('DONVI')
        .withSchema(schema)
        .where('ID_DONVI', id)
        .del();
    },
  }
};