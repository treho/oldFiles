pragma solidity ^0.4.13;
contract HelloWorldContract_3 {
    
    // state variables
    string word ="Hello World";
    address public issuer;
    
    // this is the constructor
    // msg.sender is a reserved keyword in solidity
    function HelloWorldContract_3() {
        issuer = msg.sender;
    } 
    
    modifier ifIssuer() {
           if(issuer != msg.sender) {
            throw;
         }
         else {
             // the underscore signals to continue with what is in the function
             _;
         }
    }
    
     function getWord() constant returns(string) {
         return word;
     }
     
     // the ifIssuer in the method declaration calls this method
     function setWord(string newWord) ifIssuer returns(string) {
            word = newWord;
            return "This is the creator";
     }
    
}
