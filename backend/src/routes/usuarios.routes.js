var express = require('express');

const UserController = require('../controllers/UserController');
var usuariosRouter = express.Router();



usuariosRouter.get('/', UserController.index);
usuariosRouter.post('/', UserController.store);

module.exports = usuariosRouter;