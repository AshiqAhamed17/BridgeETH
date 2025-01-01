pragma solidity ^0.8.13;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LockUSDT {
    address private usdtAddr;
    mapping (address => uint256) public pendingBalance;


    constructor(address _usdtAddr) {
        usdtAddr = _usdtAddr;
    }

    function deposit(uint256 _amount) public  {
        require(IERC20(usdtAddr).allowance(msg.sender, address(this)) >= _amount);
        IERC20(usdtAddr).transferFrom(msg.sender, address(this), _amount);
        pendingBalance[msg.sender] += _amount;
    }

    function withdraw() public {
        uint256 remainingAmount = pendingBalance[msg.sender];
        IERC20(usdtAddr).transfer(msg.sender, remainingAmount);
        pendingBalance[msg.sender] = 0;
    }
}