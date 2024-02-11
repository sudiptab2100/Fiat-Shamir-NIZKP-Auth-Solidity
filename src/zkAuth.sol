// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./IzkAuth.sol";

contract zkAuth is IzkAuth {
    uint256 public constant P = 59554163256907165153446763043998072043134381653816695709167604088273509765359;
    uint256 public constant G = 46911934683666321610648872124611214888225321372527319709261011007488291925481;
    uint256 public constant Q = 59554163256907165153446763043998072043134381653816695709167604088273509765358;
    mapping(address => uint256) public userKs;
    mapping(address => uint256) public userCommitments;

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

    function set_commitment(uint256 y) public {
        userCommitments[msg.sender] = y;
    }

    function get_commitment(address user) public view returns(uint256) {
        return userCommitments[user];
    }

    function _modExp(uint256 _b, uint256 _e, uint256 _m) internal view returns (uint256 _o) {
        assembly {
            // define pointer
            let p := mload(0x40)
            // store data assembly-favouring ways
            mstore(p, 0x20)             // Length of Base
            mstore(add(p, 0x20), 0x20)  // Length of Exponent
            mstore(add(p, 0x40), 0x20)  // Length of Modulus
            mstore(add(p, 0x60), _b)    // Base
            mstore(add(p, 0x80), _e)    // Exponent
            mstore(add(p, 0xa0), _m)    // Modulus
            if iszero(staticcall(not(0), 0x05, p, 0xc0, p, 0x20)) {
                revert(0, 0)
            }
            // data
            _o := mload(p)
        }
    }

    function isAuthentic(uint256 y, uint256 k, uint256 t, uint256 r) public view returns(bool verified) {
        uint256 x1 = _modExp(G, r, P); // x1 = G^r % P
        uint256 c = uint256(sha256(abi.encodePacked(G, y, t, k))); // c = hash(G || y || t || k)
        uint256 x2 = _modExp(y, c, P); // x2 = y^c % P
        uint256 _t = mulmod(x1, x2, P); // (g * h) % P;
        verified = (_t == t);
    }

    function authenticate(address user, uint256 t, uint256 r) public returns(bool verified) {
        uint256 y = userCommitments[user];
        uint256 k = userKs[user];
        verified = isAuthentic(y, k, t, r);
        require(verified, "Invalid proof");
        userKs[user]++; // k++ to prevent replay attack
    }
}
