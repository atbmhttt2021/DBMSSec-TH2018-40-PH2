const moment = require('moment');
const conn = require('../utils/db');

module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      return db('THONGBAO');
    },

    async single(id) {
      const notifications = await db('THONGBAO')
        .where('ID_VANBAN', id)
      if (notifications.length === 0) {
        return null;
      }

      return notifications[0];
    },

    add(notification) {
      return db('THONGBAO')
        .insert(notification)
    },

    update(id, notification) {
      return db('THONGBAO')
        .where('ID_VANBAN', id)
        .update(notification);
    },

    delete(id) {
      return db('THONGBAO')
        .where('ID_VANBAN', id)
        .del();
    },
  }
};