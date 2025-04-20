//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {PriceConverter} from "./PriceConverter.sol";

error notOwner();
error callHasFailed();
error notEnoughtETH();

//gas: 743,506
contract FundMe{
    /*
    This conract has the Following functions:
    1. Get found from users.
    2. Withdraw found.
    3. Set a minimun funding amount (in this case is = 1ETH).
    */
    using PriceConverter for uint256;

    uint256 public constant MINIMUN_USD_AMOUNT = 1e18;

    address[] public funders;
    mapping(address funder=> uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;

    constructor (){
        i_owner = msg.sender;
    }

    //The payable keyword indicate that the function can revice ETH.
    function fund() public payable{
        //require(PriceConverter.getConversionRate(msg.value) >= MINIMUN_USD_AMOUNT, "You need to spend more ETH!");
        if(msg.value.getConversionRate() <= MINIMUN_USD_AMOUNT){revert notEnoughtETH();}
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }
    
    function withdraw() public onlyOwner {
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
        require(callSuccess, "Error while wihdraw");
        if (!callSuccess){ revert callHasFailed();}
    }
    

    modifier onlyOwner() {
        //require(msg.sender == i_owner); 
        if(msg.sender != i_owner){revert notOwner();}
        _; // Executes first the require and then the code of the function.
    }

    //TODO: fallback
}