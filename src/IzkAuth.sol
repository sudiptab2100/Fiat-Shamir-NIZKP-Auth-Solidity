// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IzkAuth {
    function getP() external view returns(uint256 P);
    function getQ() external view returns(uint256 Q);
    function getG() external view returns(uint256 G);
    function get_k(address user) external view returns(uint256 k); // valid authentication count
    function set_commitment(uint256 y) external; // set commitment of a user (Set Password)
    function get_commitment(address user) external view returns(uint256 y); // get commitment of a user
    function authenticate(address user, uint256 t, uint256 r) external returns(bool verified); // {t, r} is the proof
}