//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

import "hardhat/console.sol";

contract Token {
	string public name;
	string public symbol;
	uint256 public decimals = 18;
	uint256 public totalSupply ;//1,000000*10^18
	
	mapping(address => uint256) public balanceOf;
	mapping(address => mapping(address => uint256)) public allowance; 
	
	event Transfer(
		address indexed from,
		address indexed to, 
		uint256 value
		 );
	event Approval(
		address indexed owner, 
		address indexed spender,
		uint256 value
		);

	constructor(
		string memory _name, 
		string memory _symbol,
		uint256 _totalSupply
		){
		name = _name;
		symbol = _symbol;
		totalSupply = _totalSupply * (10**decimals);
		balanceOf[msg.sender] = totalSupply;
	}

	function transfer(address _to, uint256 _value) 
		public 
		returns (bool success)
		{
		//Require that sender has enough Token
		require(balanceOf[msg.sender] >= _value);
		_transfer(msg.sender, _to, _value);

		return true;
	}

	function transferFrom(address _from, address _to, uint256 _value) 
		public
		returns (bool success){

			//check Approval
			require(_value <= balanceOf[_from])	;
			require(_value <= allowance[_from][msg.sender]); //value has to be less than the approved amount b4 transfer

			//Reset Allowance to avoid double spend till the go through approval again			
			allowance[_from][msg.sender] -= _value;

			//spend Tokens		
			_transfer(_from, _to, _value);		
			
			return true;
		}

		function _transfer(
			address  _from,
			address  _to, 
			uint256 _value
		)internal{
			require(_to != address(0));
			//Deduct Token form Spender
			balanceOf[_from] = balanceOf[_from] - _value;
			//credit token to receiver
			balanceOf[_to]= balanceOf[_to] + _value;

			//Emit Event
			emit Transfer(_from, _to, _value);
	}

	function approve(address _spender,uint256 _value) 
		public 
		returns (bool success){

		require(_spender != address(0));	
		allowance[msg.sender][_spender] = _value;

		emit Approval(msg.sender, _spender, _value);
		return true;
	}

	//function allowance(address _owner,address _spender) public 	returns (uint256 remaining){}
}