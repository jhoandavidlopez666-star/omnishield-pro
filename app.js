// Lógica principal y pasarela Web3 para OmniShield P2P
async function connectWallet() {
    if (window.ethereum) {
        try {
            const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
            const btn = document.getElementById('walletBtn');
            const shortAddr = accounts[0].substring(0, 6) + '...' + accounts[0].substring(38);
            
            btn.innerText = 'Conectado: ' + shortAddr;
            btn.style.backgroundColor = '#10b981';
            btn.style.color = '#ffffff';
            
            console.log("[Billetera Conectada Exitosamente]:", accounts[0]);
        } catch (error) {
            console.error("Error al conectar la billetera:", error);
        }
    } else {
        alert("Por favor, instala MetaMask para operar en el protocolo OmniShield.");
    }
}
