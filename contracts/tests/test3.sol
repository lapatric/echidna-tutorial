// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "../mintable.sol";

contract TestToken is MintableToken {
    address echidna_caller = msg.sender;

    // update the constructor
    constructor() MintableToken(10000) {
        owner = echidna_caller;
    }

    // add the property
    function echidna_test_balance() public view returns (bool) {
        return balances[msg.sender] <= 10000;
    }
}