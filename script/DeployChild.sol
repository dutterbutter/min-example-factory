// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import {ChildFactory} from "../src/ChildFactory.sol";

contract DeployChild is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        // The greeting we want the Child contract to have
        string memory greeting = "Hello, zkSync!";

        // Read the artifact file that contains Child's bytecode hash
        string memory artifact = vm.readFile("zkout/Child.sol/Child.json");
        bytes32 childBytecodeHash = vm.parseJsonBytes32(artifact, ".hash");

        bytes32 salt = keccak256("my_salt");

        vm.startBroadcast(deployerPrivateKey);

        // Deploy the factory with the child's bytecode hash
        ChildFactory factory = new ChildFactory(childBytecodeHash);
        console.log("Factory deployed at:", address(factory));

        // Mark the child's bytecode as a factory dependency so it’s available on first deployment
        vmExt.zkUseFactoryDep("Child");

        // Now deploy the child
        address deployedChild = factory.deployChild(salt, greeting);
        console.log("Child deployed at:", deployedChild);

        vm.stopBroadcast();
    }
}
