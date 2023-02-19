// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import {Test} from "forge-std/Test.sol";

import {BlurExchange} from "../src/BlurExchange.sol";

contract BlurExchangeTest is Test {
    BlurExchange exchange;
    address proxy = 0x000000000000Ad05Ccc4F10045630fb830B95127;

    function setUp() public {
        exchange = BlurExchange(proxy);
    }

    function testFunc1() public {
        sampleContract.func1(1337);
    }

    function testFunc2() public {
        sampleContract.func2(1337);
    }
}
