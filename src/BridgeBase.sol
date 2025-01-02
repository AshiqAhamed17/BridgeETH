// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { console } from "forge-std/console.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract BridgeBase is Ownable {
    constructor() Ownable(msg.sender) {

    }

    function mint(address _to, uint _amount) public {
        _mint(_to, _amount);

    function burn() public {

    }

    function depositHappendOnOtherSide() public {

    }
}