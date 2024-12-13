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
                    (salt, bytecodeHash, inputData)
                )
            );

        if (!success) {
            revert Create2FailedDeployment();
        }

        create2Address = abi.decode(returnData, (address));
        console.log("Contract deployed at:", create2Address);
    }
}
