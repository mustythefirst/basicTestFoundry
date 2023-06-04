// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "../lib/forge-std/src/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    // Invoked before each test
    function setUp() public {
        counter = new Counter();
    }

    // a new counter contract get invovoked before each test

    // Test must be external or public
    function testInc() public {
        counter.inc();
        assertEq(counter.count(), 1);
    }
    // Testing for the function below, the inc(increment functino is called testInc (testIncrement))
    // assertEq
    //<Foundry doc> function assertEq(<type> a, <type> b) internal;
    // Where <type> can be address, bytes32, int, uint
    // Asserts a is equal to b <Foundry doc>
    // Therefore, if count is incrementing by 1 each time. When the contract is newly created it's value should be 1
    // Hence assert the it is equal to 1. The test should pass
    // Passing in the number 2 should fail as 2 != 1. 

    // function inc() external {
    //    count += 1;
    // }


    

    function testFailDec() public {
        // This will fail with underflow
        // count = 0 --> count -= 1
        counter.dec();
    }
    // The above test is testing for this function

    // function dec() external {
    //    count -= 1;
    // }

    // As it is expected that the test will fail,
    // it logs as test past.


    // Same as testFailDec
    function testDecUnderflow() public {
        vm.expectRevert(stdError.arithmeticError);
        counter.dec();
    }
    // The above test is testing for this function

    // function dec() external {
    //    count -= 1;
    // }

    // This time the reason for the test failing is being stated
    // More explicity which is an arithmetic overflow/underflow error
    // vm allows you to easily access cheatcodes
    // expectRevert is a cheat code that states a fail is expected, this 
    // will log as a pass to the console
    // An example of when this is applied is when a user attempts to 
    // withdraw more than they deposit in say, a liquidity pool.
    // catching the error is important and this is testing to make sure
    // That the arithmetic error does occur. As a result it will log as test passed
    // in the console 
    // because once the contract is instantiated count is at zero. Calling
    // dec (decrement) will put count at -1. This is an underflow. 
    // An auditor may suspect the function dec will result in artithmetic
    // overflow/underflow error so will use Foundry cheatcodes to confirm this.
    // Test
}



// forge test --match-path test/Counter.t.sol -vvv --gas-report