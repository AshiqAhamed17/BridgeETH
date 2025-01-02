// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/BridgeETH.sol";
import "src/USDT.sol";

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract BridgeETHTest is Test {
    event Transfer(address indexed from, address indexed to, uint256 value);

    BridgeETH bridge;
    USDT usdt;

    function setUp() public {
        usdt = new USDT();
        bridge = new BridgeETH(address(usdt));
    }

    function testTokenName() public {
        assertEq(usdt.name(), "USDT", "Token name mismatch");
    }

    function test_Deposit() public {
        address testAddr = vm.addr(1);
        usdt.mint(testAddr, 200);

        vm.startPrank(testAddr);
        usdt.approve(address(bridge), 200);
        bridge.deposit(usdt, 200);

        assertEq(usdt.balanceOf(testAddr), 0);
        assertEq(usdt.balanceOf(address(bridge)), 200);

        bridge.withdraw(usdt, 100);

        assertEq(usdt.balanceOf(testAddr), 100);
        assertEq(usdt.balanceOf(address(bridge)), 100);
    }

}
