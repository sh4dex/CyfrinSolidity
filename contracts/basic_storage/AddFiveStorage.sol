//SPDX-License-Identifier: MIT
pragma solidity  ^0.8.24;

import {SimpleStorage} from "./SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage{
    //Override
    //Virtual
    function store(uint256 _number) public override{
        myFavoriteNumber = _number+5;
    }
}
