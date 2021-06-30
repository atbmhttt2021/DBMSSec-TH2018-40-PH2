const conn = require('../utils/db');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('NHANVIEN')
      .join('DONVI', 'DONVI.ID_DONVI', '=', 'NHANVIEN.DONVI')
      .select('NHANVIEN.*', 'DONVI.TENDV');
    },

    async single(id) {
      const employees = await db('NHANVIEN')
        .join('DONVI', 'DONVI.ID_DONVI', '=', 'NHANVIEN.DONVI')
        .select('NHANVIEN.*', 'DONVI.TENDV')
        .where('ID_NHANVIEN', id);
      if (employees.length === 0) {
        return null;
      }

      return employees[0];
    },

    add(employee) {
      return db('NHANVIEN')
        .insert({
          ...employee,
          NGAYSINH: db.raw(`TO_DATE('${employee.NGAYSINH}', 'yyyy/mm/dd')`)
        });
    },

    update(id, employee) {
      return db('NHANVIEN')
        .where('ID_NHANVIEN', id)
        .update({
          ...employee,
          NGAYSINH: db.raw(`TO_DATE('${employee.NGAYSINH}', 'yyyy/mm/dd')`)
        });
    },

    delete(id) {
      return db('NHANVIEN')
        .where('ID_NHANVIEN', id)
        .del();
    },

    doctors() {
      return db('NHANVIEN')
      .join('DONVI', 'DONVI.ID_DONVI', '=', 'NHANVIEN.DONVI')
      .select('NHANVIEN.ID_NHANVIEN', 'NHANVIEN.TENNV')
      .where('DONVI.TENDV', 'like', 'Khoa%');
    },
    salemen() {
      return db('NHANVIEN')
      .join('DONVI', 'DONVI.ID_DONVI', '=', 'NHANVIEN.DONVI')
      .select('NHANVIEN.ID_NHANVIEN', 'NHANVIEN.TENNV')
      .where('DONVI.TENDV', 'like', '%bán thuốc%');
    },
    cashiers() {
      return db('NHANVIEN')
      .join('DONVI', 'DONVI.ID_DONVI', '=', 'NHANVIEN.DONVI')
      .select('NHANVIEN.ID_NHANVIEN', 'NHANVIEN.TENNV')
      .where('DONVI.TENDV', 'like', '%tài vụ%');
    },
  }
};