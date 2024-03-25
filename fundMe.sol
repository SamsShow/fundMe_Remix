//get funds from user
// withdraw fun
// set a minimum funding value in usd

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

contract fundme{

    using PriceConverter for uint256;

    uint256 public minusd = 50;
    address[] public funder;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        //1. How do we send eth to this contract
        require (msg.value.getConversionRate() >= minusd, "Didn't send enough tokens");
        //18 decimal places
        funder.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

 
    //function withdraw(){}

    
}