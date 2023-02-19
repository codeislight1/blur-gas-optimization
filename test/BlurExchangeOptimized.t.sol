// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {Test} from "forge-std/Test.sol";
import "./Common.sol";
import {BlurExchange} from "../src/BlurExchange.sol";
import {BlurExchangeOptimized} from "../src/BlurExchangeOptimized.sol";
import "forge-std/console.sol";

contract BlurExchangeOptimizedTest is Test, Common {
    BlurExchangeOptimized exchange;

    function setUp() public {
        // setup mainnet fork
        uint256 forkId = vm.createFork("https://eth-mainnet.g.alchemy.com/v2/PIJ-XWn0szDM65qMpM2SZsfi3GlIWPbo");
        vm.rollFork(forkId, blocknumber);
        vm.selectFork(forkId);
        // check block number
        assertEq(block.number, blocknumber);
        exchange = BlurExchangeOptimized(proxy);
        // deploy new implementation
        address newImplementation = address(new BlurExchangeOptimized());
        // use proxy owner
        vm.startPrank(owner);
        // upgrade to new implementation
        exchange.upgradeTo(newImplementation);
        // initialize the reentrancyGuards
        exchange.initializeV2();
        vm.stopPrank();
    }

    function testExecuteOptimized() public {
        callBlurExchange(executeCaller, executeValue, executeCalldata);
    }

    function testBulkExecuteOptimized() public {
        callBlurExchange(bulkExecuteCaller, bulkExecuteValue, bulkExecuteCalldata);
    }
}
