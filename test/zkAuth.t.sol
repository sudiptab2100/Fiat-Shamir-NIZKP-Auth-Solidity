// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {zkAuth} from "../src/zkAuth.sol";

contract zkAuthTest is Test {
    zkAuth public zk;

    function setUp() public {
        zk = new zkAuth();
    }
}
