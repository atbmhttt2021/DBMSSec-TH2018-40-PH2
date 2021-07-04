const conn = require('../utils/db');
const { schema } = require('../utils/config');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('THUOC').withSchema(schema);
    },

    async single(id) {
      const medicines = await db('THUOC').withSchema(schema)
        .where('ID_THUOC', id);
      if (medicines.length === 0) {
        return null;
      }

      return medicines[0];
    },

    add(medicine) {
      return db('THUOC').withSchema(schema)
        .insert(medicine);
    },

    update(id, medicine) {
      return db('THUOC').withSchema(schema)
        .where('ID_THUOC', id)
        .update(medicine);
    },

    delete(id) {
      return db('THUOC').withSchema(schema)
        .where('ID_THUOC', id)
        .del();
    },
  }
};