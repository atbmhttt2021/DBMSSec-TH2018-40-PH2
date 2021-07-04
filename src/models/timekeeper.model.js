const conn = require('../utils/db');
const { schema } = require('../utils/config');
module.exports = credenticals => {
  const db = conn(credenticals);

  return {

    all() {
      // const numberCheck=db('CHAMCONG').withSchema(schema).count('*', { as: 'COUNT' });
      var checked,list=null;
      var listCheck=  db('CHAMCONG').withSchema(schema).orderBy('THOIGIAN', 'desc').catch(function (error){
        list=db('NHANVIEN_CHAMCONG').withSchema(schema).orderBy('THOIGIAN', 'desc'); 
        return list;
      });
 
        // if(error)  listCheck= db('NHANVIEN_CHAMCONG').withSchema(schema).orderBy('THOIGIAN', 'desc'); 
        console.log(checked);
        return listCheck;
    },

    async checkIn(username) {
      // Find id by username
      const employee = await db('CHECK_ACCOUNT').withSchema(schema)
        .where('VAITRO', username.toUpperCase())
        .first('ID_NHANVIEN')
      if (!employee) return null;
      const { ID_NHANVIEN } = employee;
      if (!ID_NHANVIEN) return null;

      // Count existing Check in to day
      const existCheckinCounter = await db('NHANVIEN_CHAMCONG').withSchema(schema)
        // .where('ID_NHANVIEN', ID_NHANVIEN)
        .whereRaw('TRUNC(THOIGIAN)IN(SELECT TRUNC(SYSDATE)FROM DUAL)')
        .count('*', { as: 'COUNT' });
      if (!existCheckinCounter) return null;

      // If count > 0
      const { COUNT } = existCheckinCounter[0];
      if (COUNT !== 0) return null;
          var timeNow= db.raw('CURRENT_TIMESTAMP');
      // If count = 0
      return db.raw('EXECUTE '+schema+'.insert_cham_cong('+ID_NHANVIEN+','+timeNow+')');
    },
  }
};