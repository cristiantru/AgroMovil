const express = require('express');
const http = require('http');
const socketIo = require('socket.io');
const mysql = require('mysql2/promise');
const bcrypt = require('bcrypt');
const cors = require('cors');
require('dotenv').config();

const app = express();
const server = http.createServer(app);
const io = socketIo(server, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"]
  }
});

// Middleware
app.use(cors());
app.use(express.json());

// Configuración de MySQL
const dbConfig = {
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'agromarket',
  port: 3306
};

const pool = mysql.createPool(dbConfig);

app.post('/api/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    
    const [rows] = await pool.execute(
      'SELECT id, nombre, email, password FROM usuarios WHERE email = ?',
      [email]
    );

    if (rows.length === 0) {
      return res.json({ success: false, message: 'Usuario no encontrado' });
    }

    const user = rows[0];
    //contraseña encriptada
    const isValidPassword = await bcrypt.compare(password, user.password);
    
    if (isValidPassword) {
      res.json({
        success: true,
        user: {
          id: user.id,
          nombre: user.nombre,
          email: user.email
        }
      });
    } else {
      res.json({ success: false, message: 'Contraseña incorrecta' });
    }
  } catch (error) {
    console.error('Error en login:', error);
    res.json({ success: false, message: 'Error del servidor' });
  }
});

app.post('/api/create-test-user', async (req, res) => {
  try {
    const { nombre, email, password } = req.body;
    
    const hashedPassword = await bcrypt.hash(password, 10);

    const [result] = await pool.execute(
      'INSERT INTO usuarios (nombre, email, password) VALUES (?, ?, ?)',
      [nombre, email, hashedPassword]
    );

    res.json({
      success: true,
      message: 'Usuario de prueba creado',
      user: {
        id: result.insertId,
        nombre: nombre,
        email: email
      }
    });
  } catch (error) {
    console.error('Error creando usuario de prueba:', error);
    res.json({ success: false, message: 'Error del servidor' });
  }
});

app.post('/api/register', async (req, res) => {
  try {
    const { nombre, email, password } = req.body;
    
    // Verificar si el email ya existe
    const [existingUser] = await pool.execute(
      'SELECT id FROM usuarios WHERE email = ?',
      [email]
    );

    if (existingUser.length > 0) {
      return res.json({ success: false, message: 'El email ya está registrado' });
    }

    // Hash de la contraseña
    const hashedPassword = await bcrypt.hash(password, 10);

    const [result] = await pool.execute(
      'INSERT INTO usuarios (nombre, email, password) VALUES (?, ?, ?)',
      [nombre, email, hashedPassword]
    );

    res.json({
      success: true,
      user: {
        id: result.insertId,
        nombre: nombre,
        email: email
      }
    });
  } catch (error) {
    console.error('Error en registro:', error);
    res.json({ success: false, message: 'Error del servidor' });
  }
});

// Socket.IO para conexiones en tiempo real (esto es para Mac lo del socket)
io.on('connection', (socket) => {
  console.log('Usuario conectado:', socket.id);

  socket.on('disconnect', () => {
    console.log('Usuario desconectado:', socket.id);
  });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Servidor corriendo en puerto ${PORT}`);
  console.log(`📱 Accesible desde: http://192.168.1.70:${PORT}`);
});
