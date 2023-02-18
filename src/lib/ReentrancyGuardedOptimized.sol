// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/**
 * @title ReentrancyGuarded
 * @dev Protections for reentrancy attacks
 */
contract ReentrancyGuardedOptimized {
    uint256 private reentrancyLock = 1;

    /* Prevent a contract function from being reentrant-called. */
    modifier reentrancyGuard() {
        require(reentrancyLock == 1, "Reentrancy detected");
        reentrancyLock = 2;
        _;
        reentrancyLock = 1;
    }

    uint256[49] private __gap;
}
