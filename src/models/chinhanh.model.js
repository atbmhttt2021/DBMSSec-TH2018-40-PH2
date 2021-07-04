const conn = require('../utils/db');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('CHINHANHBV');
    },

    async single(id) {
      const chinhanh = await db('CHINHANHBV')
        .where('ID_CHINHANH', id);
      if (chinhanh.length === 0) {
        return null;
      }

      return chinhanh[0];
    },
  }
};