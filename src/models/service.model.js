const conn = require('../utils/db');
const { schema } = require('../utils/config');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('DICHVU').withSchema(schema);
    },

    async single(id) {
      const services = await db('DICHVU')
        .withSchema(schema)
        .where('ID_DICHVU', id);
      if (services.length === 0) {
        return null;
      }

      return services[0];
    },

    add(service) {
      return db('DICHVU')
        .withSchema(schema)
        .insert(service);
    },

    update(id, service) {
      return db('DICHVU')
        .withSchema(schema)
        .where('ID_DICHVU', id)
        .update(service);
    },

    delete(id) {
      return db('DICHVU')
        .withSchema(schema)
        .where('ID_DICHVU', id)
        .del();
    },
  }
};