const passport = require('passport');
const localStrategy = require('passport-local').Strategy;
const conn = require('./db');

module.exports = _ => {

  passport.use(new localStrategy(
    (username, password, done) => {
      (async _ => {
        try {
          const db = conn({ username, password });
          await db.raw('SELECT 1 FROM DUAL');
          const user = {
            username,
            password
          }
          console.log('user :>> ', user);
          return done(null, user)
        } catch (error) {
          console.log('error :>> ', error);
          return done(null, false)
        }
      })();
    }));

  passport.serializeUser((user, done) => {
    done(null, user)
  });

  passport.deserializeUser((user, done) => {
    const { username } = user;
    console.log('deserializeUser user :>> ', user);
    (async _ => {
      const db = conn(user);
      const userDetail = await db('nhanvien')
        .where('vaitro', username.toUpperCase());
      console.log('userDetail :>> ', userDetail);
      if (userDetail.length === 0) {
        // Nhanvien with vaitro: <username> not found
        return done(null, false);
      }
      return done(null, userDetail[0])

    })();
  });

}
