// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title OmniShield Institutional Escrow Protocol
 * @author David Lopez / OmniShield Core
 * @notice Protocolo descentralizado de custodia P2P sin intermediarios institucionales.
 */
contract OmniShieldEscrow {
    
    struct Escrow {
        uint256 id;
        address payable buyer;
        address payable seller;
        uint256 amount;
        bool isCompleted;
        bool isDisputed;
        bool exists;
    }

    mapping(uint256 => Escrow) public escrows;
    uint256 public escrowCounter;
    address public immutable protocolOwner;

    event EscrowCreated(uint256 indexed id, address indexed buyer, address indexed seller, uint256 amount);
    event EscrowCompleted(uint256 indexed id, address recipient, uint256 amount);
    event EscrowDisputed(uint256 indexed id);

    modifier onlyOwner() {
        require(msg.sender == protocolOwner, "Acceso no autorizado: Solo el owner del nodo.");
        _;
    }

    constructor() {
        protocolOwner = msg.sender;
    }

    /**
     * @notice Crea una nueva orden de custodia bloqueando fondos en el contrato.
     * @param _seller Dirección del vendedor que recibirá los fondos al liberar.
     */
    function createEscrow(address payable _seller) external payable returns (uint256) {
        require(msg.value > 0, "El monto de custodia debe ser mayor a cero.");
        require(_seller != address(msg.sender), "El comprador y el vendedor no pueden ser la misma direccion.");

        escrowCounter++;
        uint256 newId = escrowCounter;

        escrows[newId] = Escrow({
            id: newId,
            buyer: payable(msg.sender),
            seller: _seller,
            amount: msg.value,
            isCompleted: false,
            isDisputed: false,
            exists: true
        });

        emit EscrowCreated(newId, msg.sender, _seller, msg.value);
        return newId;
    }

    /**
     * @notice Libera los fondos retenidos en el escrow hacia el vendedor.
     */
    function releaseEscrow(uint256 _id) external {
        Escrow storage escrow = escrows[_id];
        require(escrow.exists, "El contrato de custodia no existe.");
        require(msg.sender == escrow.buyer || msg.sender == protocolOwner, "Solo el comprador o el protocolo pueden liberar los fondos.");
        require(!escrow.isCompleted, "La custodia ya fue completada.");
        require(!escrow.isDisputed, "La custodia se encuentra bajo disputa activa.");

        escrow.isCompleted = true;
        escrow.seller.transfer(escrow.amount);

        emit EscrowCompleted(_id, escrow.seller, escrow.amount);
    }

    /**
     * @notice Marca una custodia bajo disputa para revisión institucional.
     */
    function raiseDispute(uint256 _id) external {
        Escrow storage escrow = escrows[_id];
        require(escrow.exists, "El contrato no existe.");
        require(msg.sender == escrow.buyer || msg.sender == escrow.seller, "No tienes permisos sobre esta custodia.");
        require(!escrow.isCompleted, "No se puede disputar una custodia ya finalizada.");

        escrow.isDisputed = true;
        emit EscrowDisputed(_id);
    }
}
