// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";

import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {DeployBox} from "../script/DeployBox.s.sol";

contract DeployAndUpgrade is Test {
    DeployBox public deployBox;
    UpgradeBox public upgradeBox;
    address public owner = makeAddr("owner");

    address public proxy;

    function setUp() public {
        deployBox = new DeployBox();
        upgradeBox = new UpgradeBox();
        proxy = deployBox.run();
    }

    function testProxyStartsAsBoxV1() public {
        vm.expectRevert();
        BoxV2(proxy).setNumber(12);
    }

    function testUpgradesToBoxV2() public {
        BoxV2 newBox = new BoxV2();
        upgradeBox.upgradeBox(proxy, address(newBox));
        BoxV2(proxy).setNumber(12);
        assertEq(BoxV2(proxy).getNumber(), 12);
    }
}
