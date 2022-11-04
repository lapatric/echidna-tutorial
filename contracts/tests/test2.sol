// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "../token.sol";

contract TestToken is Token {

    constructor() {
        paused(); // pause the contract
        owner = address(0x0); // lose ownership
    }

    // add the property
    function echidna_cannot_be_unpaused() public view returns (bool) {
        return is_paused == true;
    }
}