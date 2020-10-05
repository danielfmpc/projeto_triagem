const Sequelize = require('sequelize');
const dbConfig = require('../config/database');
const Screening = require('../models/Screening');
const User = require('../models/User');

const connection = new Sequelize(dbConfig);

User.init(connection);
Screening.init(connection);

module.exports = connection;