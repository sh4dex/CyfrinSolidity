//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract UserAdmin{
    
    //Struct of Users
    struct User{
        string name;
        uint256 age;
    }

    User[] public listOfUsers;

    mapping(string => uint256) public usersBalances;

    function storeNewUser(string memory _name, uint256 _age) public {
        User memory myNewUser = User(_name, _age);
        listOfUsers.push(myNewUser);
        usersBalances[_name] = _age*123;
    }

    function retrive(string memory _name) public view returns( uint256){
        return(usersBalances[_name]);
    }
    
}