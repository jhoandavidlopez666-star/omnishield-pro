// Módulo de sincronización en tiempo real para OmniShield
const socket = io();

socket.on('connect', () => {
    console.log("[Conectado al Nodo Central de OmniShield]: ID ->", socket.id);
});

socket.on('sync_trades', (trades) => {
    console.log("Órdenes de custodia sincronizadas:", trades);
});

function enviarOrdenP2P(monto, vendedor) {
    const tradeData = {
        amount: monto,
        seller: vendedor,
        timestamp: Date.now()
    };
    socket.emit('new_trade_signal', tradeData);
}
