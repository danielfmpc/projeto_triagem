var express = require('express');

const UserController = require('../controllers/UserController');
var userRouter = express.Router();



userRouter.get('/', UserController.index);
userRouter.post('/', UserController.store);

module.exports = userRouter;