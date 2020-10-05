var express = require('express');
const ScreeningController = require('../controllers/ScreeningController');
var screeningsRouter = express.Router();

screeningsRouter.get('/', ScreeningController.index);
screeningsRouter.post('/', ScreeningController.store);

module.exports = screeningsRouter;
