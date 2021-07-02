const conn = require('../utils/db');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('DICHVU');
    },

    async single(id) {
      const services = await db('DICHVU')
        .where('ID_DICHVU', id);
      if (services.length === 0) {
        return null;
      }

      return services[0];
    },

    add(service) {
      return db('DICHVU')
        .insert(service);
    },

    update(id, service) {
      return db('DICHVU')
        .where('ID_DICHVU', id)
        .update(service);
    },

    delete(id) {
      return db('DICHVU')
        .where('ID_DICHVU', id)
        .del();
    },
  }
};