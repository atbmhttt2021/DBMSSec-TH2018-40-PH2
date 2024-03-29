const conn = require('../utils/db');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('DONVI');
    },

    async single(id) {
      const departments = await db('DONVI')
        .where('ID_DONVI', id);
      if (departments.length === 0) {
        return null;
      }

      return departments[0];
    },

    async add(department) {
      await db('DONVI')
        .insert(department);
      const { VAITRO } = department;
      return await db.raw(`BEGIN create_role('${VAITRO}'); END;`);
    },

    async update(id, department) {
      await db('DONVI')
        .where('ID_DONVI', id)
        .update(department);
      const { VAITRO } = department;
      return await db.raw(`BEGIN create_role('${VAITRO}'); END;`);
    },

    delete(id) {
      return db('DONVI')
        .where('ID_DONVI', id)
        .del();
    },
  }
};