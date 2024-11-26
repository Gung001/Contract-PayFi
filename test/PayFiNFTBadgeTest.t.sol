// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {PayFiNFTBadge} from "../src/PayFiNFTBadge.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract PayFiNFTBadgeTest is Test {

    address constant OWNER_ADDRESS = 0x5c36567f0bb44d5c64b589C185c69c43558FA26a;

    address private proxy;
    PayFiNFTBadge private instance;

    function setUp() public {

        console.log("start");
        proxy = Upgrades.deployUUPSProxy(
            "PayFiNFTBadge.sol",
            abi.encodeCall(PayFiNFTBadge.initialize, (OWNER_ADDRESS))
        );

        console.log("uups proxy -> %s", proxy);

        instance = PayFiNFTBadge(proxy);
        assertEq(instance.owner(), OWNER_ADDRESS);

        address implAddressV1 = Upgrades.getImplementationAddress(proxy);

        console.log("impl -> %s", implAddressV1);

        vm.startPrank(OWNER_ADDRESS);
        console.log("setDefaultURI");
        instance.setDefaultURI("https://static.mintchain.io/airdrop/task-detail-redotpay.jpeg");
        vm.stopPrank();
    }

    function testMint() public {
        vm.prank(OWNER_ADDRESS);
        instance.mint(OWNER_ADDRESS, 1);
        assertEq(instance.ownerOf(1), OWNER_ADDRESS);
    }
}
