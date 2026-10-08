# OmniShield // Protocolo P2P de Custodia Descentralizada

Plataforma institucional de liquidación automatizada y custodia de activos digitales diseñada para operar sin intermediarios ni fricción operativa.

## Estructura del Sistema
- `index.html`: Interfaz visual institucional con pasarela de conexión Web3.
- `server.js`: Servidor de nodos centralizado para la sincronización de órdenes en tiempo real mediante WebSockets.
- `package.json`: Configuración de dependencias y scripts de ejecución.
- `contracts/OmniShieldEscrow.sol`: Contrato inteligente en Solidity que gobierna las garantías y disputas en la blockchain.

## Instrucciones de Arranque
1. Instalar dependencias del servidor:
   ```bash
   npm install
