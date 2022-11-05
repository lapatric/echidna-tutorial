// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./token.sol";

contract MintableToken is Token{

    int totalMinted;
    int totalMintable;

    constructor(int _totalMintable) {
        totalMintable = _totalMintable;
    }

    function mint(uint value) isOwner() public {

        require(int(value) + totalMinted < totalMintable);
        totalMinted += int(value);

        balances[msg.sender] += value;
     
    }

}