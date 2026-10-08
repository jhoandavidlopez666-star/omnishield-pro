// Inicializador principal del sistema OmniShield P2P
document.addEventListener("DOMContentLoaded", () => {
    console.log("OmniShield P2P // Módulo de inicialización cargado correctamente.");
    
    // Verificación de compatibilidad con Web3 en el entorno del navegador
    if (typeof window.ethereum !== 'undefined') {
        console.log("Proveedor Web3 detectado en el navegador.");
    } else {
        console.warn("No se detectó Web3. Se recomienda instalar MetaMask para la funcionalidad completa.");
    }
});
