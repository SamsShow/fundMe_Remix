//get funds from user
// withdraw fun
// set a minimum funding value in usd

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract fundme{

    uint256 public minusd = 50;
    address[] public funder;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        //1. How do we send eth to this contract
        require (msg.value > minusd, "Didn't send enough tokens");
        //18 decimal places
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function getPrice() public view returns(uint256) {
        //ABI
        //Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 answer,,,) = priceFeed.latestRoundData();

        return uint256(answer* 1e10);
        //ETH in terms of USD
        //3000.00000000
        
    }

    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed= AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18; //otherwise 36 zeros
        return ethAmountInUSD;
    }
    //function withdraw(){}

    
}