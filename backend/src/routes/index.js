var express = require('express');
var router = express.Router();

const usersRouter = require('./users.routes');
const screeningsRouter = require('./screenings.routes');
const testeRouter = require('./teste.routes');

router.use('/', testeRouter);
router.use('/users', usersRouter);
router.use('/screenings', screeningsRouter);

module.exports = router;