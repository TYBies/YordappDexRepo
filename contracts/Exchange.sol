//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

import "hardhat/console.sol";

contract Exchange {
	//Deposit Tokens	
	//Withdraw Tokens
	//Check Balance
	//Make Orders
	//Cancel Orders
	// Fill Orders
	//Charge fees
	// Track fees
	address public feeAccount;
	uint256 public feePercent;

	constructor(address _feeAccount, uint256 _feePercent){
		feeAccount = _feeAccount;
		feePercent = _feePercent;
	}

}