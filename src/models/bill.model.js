const moment = require('moment');
const conn = require('../utils/db');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('HOADON');
    },

    async single(id) {
      const bills = await db('HOADON')
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
        .insert({
          ...bill,
          NGAYHD: db.raw(`TO_DATE('${today}', 'yyyy/mm/dd')`)
        })
        .returning('ID_HOADON', 'ID_KHAMBENH');
    },

    update(id, bill) {
      return db('HOADON')
        .where('ID_HOADON', id)
        .update(bill);
    },

    delete(id) {
      return db('HOADON')
        .where('ID_HOADON', id)
        .del();
    },
  }
};