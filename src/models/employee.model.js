const conn = require('../utils/db');
const schema = 'SYSADMIN';

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('NHANVIEN')
      .join('DONVI', 'DONVI.ID_DONVI', '=', 'NHANVIEN.DONVI')
      .select('NHANVIEN.*', 'DONVI.TENDV')
      .withSchema(schema);
    },

    async single(id) {
      const employees = await db('NHANVIEN')
        .join('DONVI', 'DONVI.ID_DONVI', '=', 'NHANVIEN.DONVI')
        .withSchema(schema)
        .select('NHANVIEN.*', 'DONVI.TENDV')
        .where('ID_NHANVIEN', id);
      if (employees.length === 0) {
        return null;
      }

      return employees[0];
    },

    add(employee) {
      return db('NHANVIEN')
        .withSchema(schema)
        .insert({
          ...employee,
          NGAYSINH: db.raw(`TO_DATE('${employee.NGAYSINH}', 'yyyy/mm/dd')`)
        });
    },

    update(id, employee) {
      return db('NHANVIEN')
        .withSchema(schema)
        .where('ID_NHANVIEN', id)
        .update({
          ...employee,
          NGAYSINH: db.raw(`TO_DATE('${employee.NGAYSINH}', 'yyyy/mm/dd')`)
        });
    },

    delete(id) {
      return db('NHANVIEN')
        .withSchema(schema)
        .where('ID_NHANVIEN', id)
        .del();
    },

    doctors() {
      return db('NHANVIEN')
      .join('DONVI', 'DONVI.ID_DONVI', '=', 'NHANVIEN.DONVI')
      .select('NHANVIEN.ID_NHANVIEN', 'NHANVIEN.TENNV')
      .withSchema(schema)
      .where('DONVI.TENDV', 'like', 'Khoa%');
    },
  }
};