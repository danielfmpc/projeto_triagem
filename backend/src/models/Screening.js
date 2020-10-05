const { Model, DataTypes } = require("sequelize");

class Screening extends Model {
  static init(sequelize){
    super.init(
      {
        screening: DataTypes.INTEGER,
        status: DataTypes.TINYINT,
        ip: DataTypes.STRING
      },
      {
        sequelize
      }
    )
  }
}

module.exports = Screening;