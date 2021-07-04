const passport = require('passport');
const localStrategy = require('passport-local').Strategy;
const conn = require('./db');
const { schema } = require('../utils/config');

module.exports = _ => {

  passport.use(new localStrategy(
    (username, password, done) => {
      (async _ => {
        const db = conn({ username, password });
        await db.raw('SELECT 1 FROM DUAL');
        try {
          const test = await db.raw('SELECT 1 FROM DUAL');
          console.log('test', test);
          const user = {
            username,
            password
          }
         
          return done(null, user)
        } catch (error) {
          console.log('error :>> ', error);
          return done(null,false)
        }
      })();
    }));

  passport.serializeUser((user, done) => {
    done(null, user)
  });

  passport.deserializeUser((user, done) => {
    const { username } = user;
    (async _ => {
      
      const db = conn(user);
      // const userDetail = await db('TAIKHOAN').withSchema(schema)
      //   .where('USERNAME','NVADMIN01');
      const userDetail = await db.raw(`SELECT * FROM ${schema}.CHECK_ACCOUNT `)
      
      if (userDetail.length === 0) {
        // Nhanvien with vaitro: <username> not found
        return done(null, false);
      }
      return done(null, userDetail[0])

    })();
  });

}
