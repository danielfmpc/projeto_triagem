const { Model, DataTypes } = require('sequelize');

class User extends Model {
  static init(sequelize) {
    super.init(
      {
        name: DataTypes.STRING,
        cpf: DataTypes.STRING,
        birth: DataTypes.DATE
      },
      {
        sequelize
      }
    )
  }
}

module.exports = User;