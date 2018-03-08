pragma solidity ^0.4.0;
contract HelloWorldContract {
    
    string  myWord = "Hello World";

    function  word() returns (string) {
        return myWord;
    }

}