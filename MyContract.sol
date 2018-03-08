pragma solidity ^0.4.13;

import "github.com/ethereum/solidity/std/mortal.sol";

contract MyContract is mortal {
    
    uint myVariable;
    
    mapping(address => Permission) myAddressMapping;
    
    struct Permission {
        bool isAllowed;
        uint maxTransferAmount;
    }

    function MyContract() payable {
        myVariable = 5;
        
        myAddressMapping[msg.sender] = Permission(true, 5);
    }
    
    function setMyVariable(uint myNewVariable) onlyowner {
        myVariable = myNewVariable;
    }
    
    function getMyVariable() constant returns(uint){
        return myVariable;
    }
    
    function getMyContractBalance() constant returns(uint) {
        return this.balance;
    }
    
    function() payable {
        
    }
    
}
