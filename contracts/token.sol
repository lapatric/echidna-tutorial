// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Ownership{
    address owner = msg.sender;
    // Fails test1.sol -> Fix: Make constructor
    function Owner() public {
        owner = msg.sender;
    }
    // constructor() {
    //     owner = msg.sender;
    // }
    modifier isOwner(){
        require(owner == msg.sender);
        _;
    }
}

contract Pausable is Ownership{
    bool is_paused;
    modifier ifNotPaused(){
        require(!is_paused);
        _;
    }

    function paused() isOwner public{
        is_paused = true;
    }

    function resume() isOwner public{
        is_paused = false;
    }
}

contract Token is Pausable{
    mapping(address => uint) public balances;
    function transfer(address to, uint value) ifNotPaused public{
        // require(balances[msg.sender] >= value);
        uint256 initial_balance_from = balances[msg.sender];
        uint256 initial_balance_to = balances[to];

        balances[msg.sender] -= value;
        balances[to] += value;

        assert(balances[msg.sender] <= initial_balance_from);
        assert(balances[to] >= initial_balance_to);
    }
}