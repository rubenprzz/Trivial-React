const { Sequelize } = require('sequelize');

// Conexión a PostgreSQL
const sequelize = new Sequelize('trivial_db', 'trivial_user', 'trivial_password', {
  host: 'postgres', // Cambia si usas Docker o un servidor remoto
  dialect: 'postgres', // Especifica PostgreSQL como dialecto
  logging: false, // Opcional: desactiva el log de consultas SQL en la consola
});

// Verificar conexión
sequelize.authenticate()
  .then(() => console.log('Conexión exitosa a PostgreSQL con Sequelize'))
  .catch((err) => console.error('Error al conectar:', err));
