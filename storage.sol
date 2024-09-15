// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Storage {
    
    uint x;
    
    constructor() {
        x = 20;
    }

    function setint(uint a) public  {
        x = a;
    }

    function getint() public view  returns (uint) {
        return x;
    }
}