const { Sequelize, DataTypes } = require('sequelize');
const sequelize = require('../database'); // Conexión a la base de datos

const User = sequelize.define('User', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4, // Genera un UUID automáticamente
    primaryKey: true,
  },
  username: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true, // Asegura que el nombre de usuario sea único
  },
  email: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true, 
    validate: {
      isEmail: true, 
    },
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  avatar: {
    type: DataTypes.STRING,
    allowNull: true, // El avatar es opcional
  },
  role: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'user', // Valor por defecto de role
  },
  createdAt: {
    type: DataTypes.DATE,
    allowNull: false,
    defaultValue: Sequelize.NOW, 
  },
  updatedAt: {
    type: DataTypes.DATE,
    allowNull: false,
    defaultValue: Sequelize.NOW, 
  },
  points: {
    type: DataTypes.INTEGER,
    defaultValue: 0, 
  },
});

sequelize.sync({ force: true })
  .then(() => console.log('Modelo de Usuario sincronizado'))
  .catch((err) => console.error('Error al sincronizar:', err));

module.exports = User;
