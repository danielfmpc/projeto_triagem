'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {

    return await queryInterface.createTable(
      'screenings', 
      { 
        id: {
          type: Sequelize.INTEGER,
          primaryKey: true,
          autoIncrement: true,
          allowNull: false
        },
        screening: {
          type: Sequelize.INTEGER,
          allowNull: false,
          unique: true
        },
        status: {
          type: Sequelize.BOOLEAN,
          defaultValue: false,
          allowNull: false
        },
        ip: {
          type: Sequelize.STRING,
          allowNull: false
        }, 
        created_at: {
          type: Sequelize.DATE,
          allowNull: false
        },
        updated_at: {
          type: Sequelize.DATE,
          allowNull: false
        }
      }
    );
     
  },

  down: async (queryInterface, Sequelize) => {
    
    return await queryInterface.dropTable('screenings');
     
  }
};
