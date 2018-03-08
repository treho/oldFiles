pragma solidity ^0.4.0;

contract Transfer {
    
    // returns the current balance of the contract 
    function getContractFunds() constant returns (uint) {
        return this.balance;
    }
    
    // returns the current balance of an account
    function getAddressFunds (address theAddress) constant returns (uint) {
        return theAddress.balance;
    }
    
    // allows you to send money to the contract
    function() payable {
    } 

    
    // allows you to send money from one account to the other
    function transferFunds (address receiver, uint amountInWei) returns (uint) {
        receiver.transfer(amountInWei);
    }
}