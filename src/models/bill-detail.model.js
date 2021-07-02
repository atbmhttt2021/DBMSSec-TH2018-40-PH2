const conn = require('../utils/db');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    listByBill(id) {
      return db('CTHOADON')
        .join('DICHVU', 'DICHVU.ID_DICHVU', '=', 'CTHOADON.ID_DICHVU')
        .where('CTHOADON.ID_HOADON', id)
        .select('CTHOADON.*', 'DICHVU.TENDV');
    },

    add(billdetail) {
      return db('CTHOADON')
        .insert(billdetail);
    },
  }
};