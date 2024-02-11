// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./IzkAuth.sol";

contract zkAuth is IzkAuth {
    uint256 public number;
    uint256 public constant P = 59554163256907165153446763043998072043134381653816695709167604088273509765359;
    uint256 public constant G = 46911934683666321610648872124611214888225321372527319709261011007488291925481;
    uint256 public constant Q = 59554163256907165153446763043998072043134381653816695709167604088273509765358;
    mapping(address => uint256) public userKs;
    mapping(address => uint256) public userCommitments;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }

    function getP() public pure returns(uint256) {
        return P;
    }

    function getQ() public pure returns(uint256) {
        return Q;
    }

    function getG() public pure returns(uint256) {
        return G;
    }

    function get_k(address user) public view returns(uint256) {
        return userKs[user];
    }

    function get_commitment(address user) public view returns(uint256) {
        return userCommitments[user];
    }

    function isVerified(address user, uint256 t, uint256 r) public view returns(bool verified) {
        
    }
}
