pragma solidity ^0.4.0;

contract Escrow {
  address public buyer;
  address public seller;
  uint public deposit;
  uint public contractStartTime;
  uint public contractRuntime;
  uint public receivedTime;
  uint public timeToReturn;
  string public status;

  //buyer sets up the escrow contract and pays the deposit
  function Escrow(address _seller, uint _contractRuntime) payable {
    buyer = msg.sender;
    seller = _seller;
    deposit = msg.value;
    contractRuntime = _contractRuntime;
    //block.timestamp is a uint256 value in seconds since the epoch
    contractStartTime = now; // the same as block.timestamp 
  }
  
  //returns the current time 
  function currentTime () constant returns (uint256) {
    return now;
  }
  
  //returns the remaining time in seconds
  function remainingTimeInSeconds() constant returns (uint256) {
      if (now < contractStartTime + contractRuntime) {
        return (contractStartTime + contractRuntime) - now;
      }
        else{
            return 0;
        }
  }

  //returns the expiration time
  function expirationTime() constant returns (uint256) {
        return (contractStartTime + contractRuntime);
  }

  //checks if the contract is expired
  function isExpired() constant returns (bool) {
    if (now > contractStartTime + contractRuntime){
      return true;
    }
    else{
      return false;
    }
  }
  
  // check the buyers balance
  function buyerCheckBalance() constant returns (uint) {
      return buyer.balance;
  }
  
    // check the sellers balance
  function sellerCheckBalance() constant returns (uint) {
      return seller.balance;
  }
  
  //buyer releases 20% deposit to seller
  function buyerItemReceived(string _status) {
    if(msg.sender == buyer) {
        status = _status;
        receivedTime = now;
      
        // pay 20% deposit
        if (!seller.send(deposit/5)) {
            revert();
        }
        else {
            deposit = deposit *4/5;
        }
    }
    
    else{
        revert();
    }
  }
    
  //buyer releases balance to seller
  function buyerReleaseToSeller() {
    if (msg.sender == buyer) {
        seller.transfer(deposit);
        deposit = 0;
      //suicide(seller); //finish the contract and send all funds to seller 
    }
    else{
      revert();
    }
  }
  
  //buyer returns the item
  function returnItemToSeller(string _status) {
      if(msg.sender == buyer) {
          revert();
      }
      
      if(now>receivedTime + timeToReturn) {
          revert();
      }
      
      status = _status;
  }
  
  //buyer can withdraw deposit if escrow is expired
  function buyerWithdraw() {
    if (!isExpired()) {
      revert();
    }

    if (msg.sender == buyer){
      suicide(buyer); // finish the contract and send all funds to buyer
    }
    else{
      revert();
    }
  }

  //seller announces the shipment of items
  function itemShipped(string _status) {
      if(msg.sender == seller) {
        status = _status;
      }
      else {
          revert();
      }
  }
  
  // seller can cancel escrow and return all funds to buyer
  function sellerCancel() {
    if (msg.sender == seller){
      suicide(buyer); 
    }
    else{
      revert();
    }
  }
  
  // seller releases balance to buyer 
  function releaseBalanceToBuyer() {
      if (msg.sender != seller) {
          revert();
      }
      
      // finish the constrac and send funds to buyer minus
      // 20% deposit paid by the buyers
      suicide(buyer);
  }
  
}
