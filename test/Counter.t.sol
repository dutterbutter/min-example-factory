// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Counter.sol";

contract CounterTest is Test {
    Counter counter;

    function setUp() public {
        counter = new Counter();
    }

    function testInitialCountIsZero() public {
        assertEq(counter.count(), 0);
    }

    function testIncrement() public {
        counter.increment();
        assertEq(counter.count(), 1);
    }

    function testDecrement() public {
        counter.increment();
        counter.decrement();
        assertEq(counter.count(), 0);
    }

    function testReset() public {
        counter.increment();
        counter.increment();
        counter.reset();
        assertEq(counter.count(), 0);
    }

    function testDecrementRevertsWhenZero() public {
        vm.expectRevert(); // underflow revert in Solidity ^0.8.x
        counter.decrement();
    }
}
