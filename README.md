# Overview 
Gas optimization suggestion to save on writing to cold storage on each `execute` and `bulkExecute` calls, in essence, the current mainnet version, it uses the reentrancyGuards that relies on a boolean to lock and unlock the function call, which has an overhead of cold storage writing on each transaction, when it assigns the variables from default value (i.e: false) to true, which would consume quite a lot of gas fee. by revising the appraoch and using 1 and 2 as false and true consequitavely, we would be able to save 36139 (36139/245744 = 14.7%) gas for `execute` and 54969 (54969/423,495 = 13%) gas for `bulkExecute with 2 Executions`. note that files ending with `Optimized`, are files that have the suggested optimization.

There is another optimization that i did not included, i would like to highlight it here separately, which is remainingETH variable can be set after each transaction to 1 instead of 0:

instances:
BlurExchangeOptimized.sol
```solidity
    modifier setupExecution() {
        require(!isInternal, "Unsafe call"); // add redundant re-entrancy check for clarity
        remainingETH = msg.value;
        isInternal = true;
        _;
        remainingETH = 1;  // changed
        isInternal = false;
    }
    
    // used to be called once to initialize storage variables
    function initializeV2() external {
        require(isInternal == 0, "Initialized internal");
        require(reentrancyLock == 0, "Initialized lock");
        isInternal = 1;
        remainingETH = 1; // added
        reentrancyLock = 1;
    }
```

### Setup

install the dependencies:
```sh
forge install
```

### Run Tests

run the following to view the console log
```sh
forge test -vv
```

run the following to view the console log + internal calls
```sh
forge test -vvvvv
```

### Note

the following are transactions that were used in the gas profiling:

execute:
txHash: [0xa0c7742713c3de84d117309abb892ed22c7da0cf21463be73f14a9bf041cbe56](https://etherscan.io/tx/0xa0c7742713c3de84d117309abb892ed22c7da0cf21463be73f14a9bf041cbe56)

bulkExecute:
txHash: [0xc16f67ce5dd5b1048be2f197779b0950d1c6a14c41313dffb0f9d0498c4b0cf4](https://etherscan.io/tx/0xc16f67ce5dd5b1048be2f197779b0950d1c6a14c41313dffb0f9d0498c4b0cf4)
