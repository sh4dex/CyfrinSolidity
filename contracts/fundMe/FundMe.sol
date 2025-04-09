//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe{
    /*
    This conract has the Following functions:
    1. Get found from users.
    2. Withdraw found.
    3. Set a minimun funding amount (in this case is = 1ETH).
    */
    using PriceConverter for uint256;

    uint256 public minimunUsdAmount = 5e18;

    address[] public funders;
    mapping(address funder=> uint256 amountFunded) public addressToAmountFunded;

    address public owner;

    constructor (){
        owner = msg.sender;
    }

    //The payable keyword indicate that the function can revice ETH.
    function fund() public payable{
        require(msg.value.getConversionRate() >= minimunUsdAmount, "Not enough ETH avaible to be sent.");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }
    
    function withdra() public {

        for(uint256 funderIndex =0; funderIndex<funders.length ;funderIndex++){
            addressToAmountFunded[funders[funderIndex]] = 0;
        }
        //new blank
        funders = new address[](0);

        //- transfer
        //payable(msg.sender).transfer(address(this).balance);
        
        //- send (no auto revert)
        //bool success = payable (msg.sender).send(address(this).balance);
        //require(success, "Send has failed.");
        
        //-call
        (bool callSuccess, /*bytes memory dataReturned*/) = payable(msg.sender).call{value: address(this).balance}(""); 
        require(callSuccess, "Call has failed.");
    }
    
}