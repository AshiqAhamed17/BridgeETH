// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { console } from "forge-std/console.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract WAUR is ERC20, Ownable {
    constructor() ERC20("WAuraCoin", "WAUR") Ownable(msg.sender) {

    }

    function mint(address _to, uint256 _amount) public onlyOwner {
        require(_amount <= 100000e18);
        _mint(_to, _amount);
    }

    function burn(address _from, uint256 _amount) public onlyOwner {
        require(_amount >= 0, "Amount must be greater than 0");
        _burn(_from, _amount);
    }
}