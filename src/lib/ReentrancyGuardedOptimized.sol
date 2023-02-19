// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/**
 * @title ReentrancyGuarded
 * @dev Protections for reentrancy attacks
 */
contract ReentrancyGuardedOptimized {
    // internal to be able to be set by the parent class
    uint256 internal reentrancyLock = 1;

    /* Prevent a contract function from being reentrant-called. */
    modifier reentrancyGuard() {
        require(reentrancyLock == 1, "Reentrancy detected");
        reentrancyLock = 2;
        _;
        reentrancyLock = 1;
    }

    uint256[49] private __gap;
}
