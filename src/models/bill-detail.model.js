const conn = require('../utils/db');
const { schema } = require('../utils/config');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    listByBill(id) {
      return db('CTHOADON').withSchema(schema)
        .join('DICHVU', 'DICHVU.ID_DICHVU', '=', 'CTHOADON.ID_DICHVU')
        .where('CTHOADON.ID_HOADON', id)
        .select('CTHOADON.*', 'DICHVU.TENDV');
    },

    add(billdetail) {
      return db('CTHOADON').withSchema(schema)
        .insert(billdetail);
    },
  }
};