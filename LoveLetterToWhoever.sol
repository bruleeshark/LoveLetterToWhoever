pragma solidity ^0.8.0;

import "https://github.com/ethereum/solidity/blob/master/stdlib/keccak256.sol";

contract LoveLetterToWhoever {
    using keccak256 for bytes32;

    address public owner;
    uint256 public pin;
    bytes32 public hash;
    string public message;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action.");
        _;
    }

    function setPin(uint256 _pin) public onlyOwner {
        pin = _pin;
    }

    function setMessage(string memory _message) public onlyOwner {
        message = _message;
        hash = keccak256(abi.encodePacked(message));
    }

    function revealMessage(uint256 _pin) public view returns (string memory) {
        require(_pin == pin, "Incorrect PIN.");
        return message;
    }
}
