// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {zkAuth} from "../src/zkAuth.sol";

contract zkAuthTest is Test {
    zkAuth public zk;

    function setUp() public {
        zk = new zkAuth();
        uint256 y = 47456373209371720487288017416491987723894412596016602859744255950016639482067;
        zk.set_commitment(address(this), y);
    }

    function test_isVerified() public {
        uint256 t = 31999244837229886041859472275612479311922807138805369873636319802045319005817;
        uint256 r = 34839680033690003325609027323699848585153485562000555714953104993669737116239;
        bool verified = zk.authenticate(address(this), t, r);
        assertEq(verified, true);
    }
}
