pragma solidity ^0.4.13;

contract Escrow {
  address public buyer;
  address public seller;
  uint public deposit;
  uint public timeToExpiry;
  uint public startTime;


  //Buyer sets up the escrow contract and pays the deposit
  function Escrow(address _seller, uint _timeToExpiry) {
    buyer = msg.sender;
    seller = _seller;
    deposit = msg.value;
    timeToExpiry = _timeToExpiry;
    startTime = now;
  }


  //Buyer releases deposit to seller
  function releaseToSeller() {
    if (msg.sender == buyer){
      suicide(seller); //Finish the contract and send all funds to seller 
    }
    else{
      throw;
    }
  }


  //Buyer can withdraw deposit if escrow is expired
  function withdraw() {
    if (!isExpired()) {
      throw;
    }

    if (msg.sender == buyer){
      suicide(buyer); // Finish the contract and send all funds to buyer
    }
    else{
      throw;
    }
  }


  // Seller can cancel escrow and return all funds to buyer
  function cancel() {
    if (msg.sender == seller){
      suicide(buyer); 
    }
    else{
      throw;
    }
  }

  function isExpired() constant returns (bool) {
    if (now > startTime + timeToExpiry){
      return true;
    }
    else{
      return false;
    }
  }
}
