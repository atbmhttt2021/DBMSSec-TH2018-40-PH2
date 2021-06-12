const withAuth = (req, res, next) => {
  if (req.isAuthenticated()) {
    return next();
  }
  if (req.isUnauthenticated()) {
    req.logout();
    return res.redirect('/auth/login');
  }
};

const withNoAuth = (req, res, next) => {
  if (req.isUnauthenticated()) {
    return next();
  }
  if (req.isAuthenticated()) {
    return res.redirect('/');
  }
};

module.exports = {
  withAuth,
  withNoAuth
};