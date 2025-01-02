// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { console } from "forge-std/console.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";


contract BridgeETH { 
    uint256 public balance;
    address tokenAddress;
    mapping(address => uint256) pendingBalance;

    event Deposit(address indexed depositor, uint _amount);

    constructor(address _tokenAddress) Ownable(msg.sender) 
        tokenAddress = _tokenAddress;
    }

    function lock(IERC20 _tokenAddress, uint256 _amount) public {
        require(address(_tokenAddress) == tokenAddress);
        require(_tokenAddress.allowance(msg.sender, address(this)) >= _amount);
        require(_tokenAddress.transferFrom(msg.sender, address(this), _amount));
        emit Deposit(msg.sender, _amount);
    }

    function unlock(IERC20 _tokenAddress, uint256 _amount) public {
        require(pendingBalance[msg.sender] >= _amount);
        pendingBalance[msg.sender] -= _amount;
        _tokenAddress.transfer(msg.sender, _amount);
    }

    function burnOnOtherSide(address userAmount, uint _amount) public onlyOwner {
        pendingBalance[userAmount] += _amount;
    }
}
