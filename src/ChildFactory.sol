// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {SystemContractsCaller} from "era-contracts/system-contracts/contracts/libraries/SystemContractsCaller.sol";
import {DEPLOYER_SYSTEM_CONTRACT} from "era-contracts/system-contracts/contracts/Constants.sol";

contract ChildFactory {
    bytes32 public childBytecodeHash;

    // Store the bytecode hash of the Child contract at deployment time
    constructor(bytes32 _childBytecodeHash) {
        childBytecodeHash = _childBytecodeHash;
    }

    // Deploy a new Child contract using the known bytecode hash
    function deployChild(
        bytes32 salt,
        string calldata greeting
    ) external returns (address childAddress) {
        // The input here is the constructor arguments for the Child contract
        bytes memory input = abi.encode(greeting);

        (bool success, bytes memory returnData) = SystemContractsCaller
            .systemCallWithReturndata(
                uint32(gasleft()),
                address(DEPLOYER_SYSTEM_CONTRACT),
                uint128(0),
                abi.encodeCall(
                    DEPLOYER_SYSTEM_CONTRACT.create2,
                    (salt, childBytecodeHash, input)
                )
            );

        require(success, "Deployment failed");

        childAddress = abi.decode(returnData, (address));
    }
}
