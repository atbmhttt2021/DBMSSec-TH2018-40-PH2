const express = require('express');
const router = express.Router();
const conn = require('../utils/db');

// List all table
router.get('/tables', async function (req, res) {
  const db = conn(req.session.user);
  const username = req.session.user.username;
  const search = req.query.q;
  const list = await db.raw(`SELECT * FROM (SELECT DISTINCT table_name, owner
      FROM dba_tab_privs
      WHERE grantable = 'YES' AND (grantee='${username}' OR OWNER='${username}')
    UNION
      SELECT table_name, owner
      FROM all_tables 
      WHERE owner ='${username}')
    ${search ? `AND UPPER(table_name) LIKE UPPER('%${search}%')` : ''}
  `);
  res.json(list)
})
router.get('/tables/:table/cols', async function (req, res) {
  const db = conn(req.session.user);
  const table = req.params.table;
  const search = req.query.q;
  const list = await db.raw(`
      SELECT COLUMN_NAME
      FROM ALL_COL_COMMENTS
      WHERE TABLE_NAME = '${table}'
    ${search ? `AND UPPER(column_name) LIKE UPPER('%${search}%')` : ''}`);
  res.json(list)
})

module.exports = router;