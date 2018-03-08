pragma solidity ^0.4.0;

contract HelloWorld {
    
	uint256 counter = 0;
	string myString = "Ois Wappler";

	function increase() {
		counter++;
	}
    
	function decrease() {
		counter--;
	}

	function getCounter() constant returns(uint256){
		return counter;
	}
	
	function setString(string _myString) {
	    myString = _myString;
	}
	
	function getString() constant returns(string){
	    return myString;
	}

}