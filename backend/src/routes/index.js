var express = require('express');
var router = express.Router();

const usersRouter = require('./users.routes');
const screeningsRouter = require('./screenings.routes');
const websocketRouter = require('./websocket.routes');

router.use('/', websocketRouter);
router.use('/users', usersRouter);
router.use('/screenings', screeningsRouter);

module.exports = router;