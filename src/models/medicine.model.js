const conn = require('../utils/db');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('THUOC');
    },

    async single(id) {
      const medicines = await db('THUOC')
        .where('ID_THUOC', id);
      if (medicines.length === 0) {
        return null;
      }

      return medicines[0];
    },

    add(medicine) {
      return db('THUOC')
        .insert(medicine);
    },

    update(id, medicine) {
      return db('THUOC')
        .where('ID_THUOC', id)
        .update(medicine);
    },

    delete(id) {
      return db('THUOC')
        .where('ID_THUOC', id)
        .del();
    },
  }
};