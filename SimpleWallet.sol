pragma solidity ^0.4.0;

import"github.com/ethereum/solidity/std/mortal.sol";

contract SimpleWallet3 is mortal {
    
    mapping(address => Permission) permittedAddresses;
    
    event someoneAddedSomeoneToTheSendersList(address thePersonWhoAdded, address thePersonWhoIsAllowedNow, uint thisMuchHeCanSend);
    
    struct Permission {
        bool isAllowed;
        uint maxTransferAmount;
    }
    
    function addAddressToSendersList(address permitted, uint maxTransferAmount) onlyowner {
        permittedAddresses[permitted] = Permission(true, maxTransferAmount);
        someoneAddedSomeoneToTheSendersList(msg.sender, permitted, maxTransferAmount);
    }
    
    function sendFunds(address receiver, uint amountInWei) {
        if(permittedAddresses[msg.sender].isAllowed) {
            if(permittedAddresses[msg.sender].maxTransferAmount >= amountInWei) {
                bool isTheAmountReallySent = receiver.send(amountInWei);
                if(!isTheAmountReallySent) {
                    throw;
                }
            }
        }
    }
    
   function getFunds(address theAddress) constant returns(uint) {
        return theAddress.balance;
    } 
    
    function removeAddressfromSendersList(address theAddress) {
        delete permittedAddresses[theAddress];
    }
    
    function() payable {
    }
}