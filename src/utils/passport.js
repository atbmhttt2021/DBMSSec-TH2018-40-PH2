const passport = require('passport');
const localStrategy = require('passport-local').Strategy;
const conn = require('./db');

module.exports = _ => {

  passport.use(new localStrategy(
    (username, password, done) => {
      console.log('.use(new localStrategy');
      (async _ => {
        const db = conn({ username, password });
        try {
          await db.raw('SELECT 1 FROM DUAL');
          // const session = require('express-session');
          // const knexSessionStore = require('connect-session-knex')(session);
          // // const store = new knexSessionStore({
          // //   knex: db,
          // //   createtable: false
          // // });
          const user = {
            username,
            password
          }
          return done(null, user)
        } catch (error) {
          console.log('error :>> ', error);
          return done(null, false)
        }
      })();
    }));

  passport.serializeUser((user, done) => {
    console.log('serializeUser');
    done(null, user)
  });

  passport.deserializeUser((user, done) => {
    console.log('deserializeUser');
    const { username } = user;
    (async _ => {
      const db = conn(user);
      const userDetail = await db('nhanvien').withSchema('SYSADMIN')
        .where('vaitro', username.toUpperCase());
      if (userDetail.length === 0) {
        // Nhanvien with vaitro: <username> not found
        return done(null, false);
      }
      return done(null, userDetail[0])

    })();
  });

}
