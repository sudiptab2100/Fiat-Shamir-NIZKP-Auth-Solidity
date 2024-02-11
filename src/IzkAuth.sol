// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IzkAuth {
    function getP() external view returns(uint256 P);
    function getQ() external view returns(uint256 Q);
    function getG() external view returns(uint256 G);
    function get_k(address user) external view returns(uint256 k); // valid authentication count
    function get_commitment(address user) external view returns(uint256 y); // get commitment of a user
    function isVerified(address user, uint256 t, uint256 r) external view returns(bool verified); // {t, r} is the proof
}