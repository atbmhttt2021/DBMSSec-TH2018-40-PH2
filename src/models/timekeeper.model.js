const conn = require('../utils/db');
const { schema } = require('../utils/config');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('CHAMCONG')
        .withSchema(schema)
        .orderBy('THOIGIAN', 'desc');
    },

    async checkIn(username) {
      // Find id by username
      const employee = await db('NHANVIEN')
        .withSchema(schema)
        .where('VAITRO', username.toUpperCase())
        .first('ID_NHANVIEN')
      if (!employee) return null;
      const { ID_NHANVIEN } = employee;
      if (!ID_NHANVIEN) return null;

      // Count existing Check in to day
      const existCheckinCounter = await db('CHAMCONG')
        .withSchema(schema)
        .where('ID_NHANVIEN', ID_NHANVIEN)
        .whereRaw('trunc(THOIGIAN) = trunc(CURRENT_TIMESTAMP)')
        .count('*', { as: 'COUNT' });
      if (!existCheckinCounter) return null;

      // If count > 0
      const { COUNT } = existCheckinCounter[0];
      if (COUNT !== 0) return null;

      // If count = 0
      return db('CHAMCONG')
        .withSchema(schema)
        .insert({
          ID_NHANVIEN,
          THOIGIAN: db.raw('CURRENT_TIMESTAMP')
        })
        .returning('THOIGIAN');
    },
  }
};