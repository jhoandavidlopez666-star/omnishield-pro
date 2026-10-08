const express = require('express');
const http = require('http');
const { Server } = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
    cors: {
        origin: "*",
        methods: ["GET", "POST"]
    }
});

app.use(express.json());

// Estado de nodos y operaciones P2P en tiempo real
let activeTrades = [];

io.on('connection', (socket) => {
    console.log(`[Nodo Conectado]: ${socket.id}`);

    // Sincronizar estado actual al conectar
    socket.emit('sync_trades', activeTrades);

    socket.on('new_trade_signal', (data) => {
        activeTrades.push(data);
        io.emit('sync_trades', activeTrades);
        console.log(`[Operación Registrada]: Monto ${data.amount} ETH`);
    });

    socket.on('disconnect', () => {
        console.log(`[Nodo Desconectado]: ${socket.id}`);
    });
});

const PORT = 4000;
server.listen(PORT, () => {
    console.log(`Servidor de OmniShield operando en el puerto ${PORT}`);
});
