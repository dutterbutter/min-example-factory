// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Child {
    string public greeting;

    constructor(string memory _greeting) {
        greeting = _greeting;
    }
}
