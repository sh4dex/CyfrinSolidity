//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory{
    SimpleStorage[] public listOfSimpleSorage;
    
    function createSimpleSorageContract() public {
        listOfSimpleSorage.push(new SimpleStorage());
    }

    function sfStorage(uint256 _simpleStorageIndex, uint256 _newSimpleStoragenumber) public {
        listOfSimpleSorage[_simpleStorageIndex].store(_newSimpleStoragenumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        return listOfSimpleSorage[_simpleStorageIndex].retrieve();
    }
}