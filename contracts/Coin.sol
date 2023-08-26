// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;

contract Coin {

    // The public makes the address accessible in other contracts
    address public minter;

    mapping (address => uint) public balances;

    event Sent(address from, address to,uint amount);

    // Constructor code is only run when the contract
    // is created
    constructor(){
        minter = msg.sender;
    }

    
    function mint(address receiver,uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    // Errors allow you to provide information about
    // why an operation failed. They are returned
    // to the caller of the function.
    error InsufficientBalance(uint requested,uint available);


    function send(address receiver,uint amount)  public {
        
        if (amount > balances[msg.sender])
            revert InsufficientBalance({requested:amount,available:balances[msg.sender]});

        balances[msg.sender] -= amount;
        balances[receiver] += amount;


        emit Sent(msg.sender,receiver,amount);
    }

}