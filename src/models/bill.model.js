const moment = require('moment');
const conn = require('../utils/db');
const { schema } = require('../utils/config');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('HOADON').withSchema(schema);
    },

    async single(id) {
      const bills = await db('HOADON')
        .withSchema(schema)
        .join('NHANVIEN', 'NHANVIEN.ID_NHANVIEN', '=', 'HOADON.NGUOIPT')
        .where('ID_HOADON', id)
        .select('HOADON.*', 'NHANVIEN.TENNV');
      if (bills.length === 0) {
        return null;
      }

      return bills[0];
    },

    add(bill) {
      const today = moment(new Date()).format('YYYY-MM-DD');
      return db('HOADON')
        .withSchema(schema)
        .insert({
          ...bill,
          NGAYHD: db.raw(`TO_DATE('${today}', 'yyyy/mm/dd')`)
        })
        .returning('ID_HOADON', 'ID_KHAMBENH');
    },

    update(id, bill) {
      return db('HOADON')
        .withSchema(schema)
        .where('ID_HOADON', id)
        .update(bill);
    },

    delete(id) {
      return db('HOADON')
        .withSchema(schema)
        .where('ID_HOADON', id)
        .del();
    },
  }
};