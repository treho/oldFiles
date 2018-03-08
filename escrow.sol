pragma solidity ^0.4.0;

contract Escrow {
  address public buyer;
  address public seller;
  uint public deposit;
  uint public contractStartTime;
  uint public contractRuntime;

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


  // Seller can cancel escrow and return all funds to buyer
  function sellerCancel() {
    if (msg.sender == seller){
      suicide(buyer); 
    }
    else{
      revert();
    }
  }
  
  //buyer releases deposit to seller
  function buyerReleaseToSeller() {
    if (msg.sender == buyer){
      suicide(seller); //finish the contract and send all funds to seller 
    }
    else{
      revert();
    }
  }
}
