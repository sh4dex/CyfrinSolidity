//SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

//including  the AggregatorV3Interface 
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{

   /*Function to get the price of ETH in USD*/
    function getPrice() internal view returns (uint256){
        //ABI
        //Adddress : 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306); 
        (/*uint80 roundId*/, 
        int256 price,
        /*uint256 startedAt*/,
        /*uint256 updatedAt*/,
        /*uint80 answeredInRound*/) = priceFeed.latestRoundData();
        return uint256(price  * 1e10);
    }

    function decimals() internal  view returns(uint8){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306); 
        return priceFeed.decimals();
    }
    
    function getConversionRate(uint256 ethAmount) internal  view returns (uint256){
        uint256 ethPriceInUsd = getPrice();
        /*From 18 decimals places to 0 decimals
          (We were using the Wei scale to be precise).
        */
        return (ethPriceInUsd * ethAmount) / 1e18; 
    }

    function getVersion() public view returns (uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}