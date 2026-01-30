// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Counter {
    uint256 public count;

    // Increment the counter by 1
    function increment() external {
        count += 1;
    }

    // Decrement the counter by 1 (will revert on underflow)
    function decrement() external {
        count -= 1;
    }

    // Reset the counter to zero
    function reset() external {
        count = 0;
    }
}
