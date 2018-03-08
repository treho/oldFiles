pragma solidity ^0.4.0;
contract HelloWorldContract {
    
    string word = "Hello World";
    address issuer;

    // constructor
    function HelloWorldContract() {
        
        //sender = address of the issuer
        issuer = msg.sender;
    }
    
    // modifier checks if a person is eligible
    modifier eligCheck() {
        if (issuer!=msg.sender) {
            revert();
        }
        else {
            _;
        }
    }
    
    function getWord() constant returns(string){
        return word;
    }
   
    function setWord(string myWord) public eligCheck {
       word = myWord;
    }
    
    function killme() {
        suicide(msg.sender);
    }

}
