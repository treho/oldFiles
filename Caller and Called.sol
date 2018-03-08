pragma solidity ^0.4.0;

contract CallerContract{
    
    // in the constructor we are not creating a new instance
    // if contract is already on the Blockchain simply insert the address into the constructor
    // the address will change every time the contract is newly created!
   // by using the button "At Address" the CalledContract is not compiled again
   
    CalledContract toBeCalled =  CalledContract(0x100eee74459cb95583212869f9c0304e7ce11eaa);
    
    function getNumber() constant returns(uint){
        return toBeCalled.getNumber();
    }
    
   function getWords() constant returns(bytes32){
       return toBeCalled.getWords();
   }
    
}


contract CalledContract{
    uint number = 42;
    bytes32 words = "Hello";
    
    function getNumber() constant returns(uint){
        return number;
        
    }
    
    function setNumber(uint _number){
        number = _number;
    }
    
    // Strings cannot be sent to another contract
    // bytes32 is the correct datatype
    // converter: https://codebeautify.org/string-hex-converter
   function getWords() constant returns(bytes32){
        return words;
    }
}

