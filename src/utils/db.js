const knex = require('knex');

const conn = ({ username, password }) => knex({
  client: 'oracledb',
  connection: {
    host: '127.0.0.1',
    user: username,
    password,
    database: 'orcl',
    port: 1521
  },
  wrapIdentifier: (value, origImpl, queryContext) => {
    return value.toUpperCase();
  },
  pool: {
    min: 0,
    max: 50
  },
});

module.exports = conn;
