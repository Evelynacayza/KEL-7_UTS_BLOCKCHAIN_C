// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TenderJalanJawa {
    address public pokja;
    bool public isBiddingOpen = true;
    address public winner;
    
    // Menyimpan hash penawaran setiap vendor
    mapping(address => bytes32) public vendorBids;

    constructor() {
        pokja = msg.sender; // Orang yang deploy kontrak adalah Pokja
    }

    // 1. Fungsi Daftar & Kirim Hash (On-Chain)
    function submitBid(bytes32 _hashDokumen) public {
        require(isBiddingOpen, "Lelang sudah ditutup!");
        vendorBids[msg.sender] = _hashDokumen;
    }

    // 2. Fungsi Tutup Lelang (Mencegah Post-Bidding)
    function closeBidding() public {
        require(msg.sender == pokja, "Hanya Pokja yang bisa menutup!");
        isBiddingOpen = false;
    }

    // 3. Fungsi Set Pemenang (Logika Sederhana)
    function setWinner(address _pemenang) public {
        require(!isBiddingOpen, "Tutup lelang dulu!");
        winner = _pemenang;
    }
}