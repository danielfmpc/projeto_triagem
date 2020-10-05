var express = require('express');
var router = express.Router();

var usuariosRouter = require('./usuarios.routes');
var triagensRouter = require('./triagens.routes');


router.use('/usuarios', usuariosRouter);
router.use('/triagens', triagensRouter);

module.exports = router;