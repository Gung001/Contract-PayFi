// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import "../src/PayFiNFTBadge.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract PayFiNFTBadgeDeploy is Script {
    
    function run() external {

        vm.startBroadcast();

        address OWNER_ADDRESS = 0x5c36567f0bb44d5c64b589C185c69c43558FA26a;

        address uupsProxy = Upgrades.deployUUPSProxy(
            "PayFiNFTBadge.sol",
            abi.encodeCall(PayFiNFTBadge.initialize, OWNER_ADDRESS)
        );

        console.log("uupsProxy deploy at %s", uupsProxy);

        vm.stopBroadcast();
    }
}
