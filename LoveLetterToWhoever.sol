pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/cryptography/Sha256.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract LoveLetterToWhoever is Ownable {

string private encryptedMessage;
uint private pin;

function setMessage(string memory message) public onlyOwner {
encryptedMessage = Sha256(abi.encodePacked(message)).toHex();
}

function setPin(uint _pin) public onlyOwner {
pin = _pin;
}

function openLoveLetter(uint _pin) public view returns (string memory) {
require(_pin == pin, "Incorrect pin");
return abi.decode(encryptedMessage, (string));
}

}
