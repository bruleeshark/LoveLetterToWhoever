// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract LoveLetterToWhoever {
    bytes32 private hash;
    string private message;
    address payable private owner;
    address payable private _deployer;
    uint256 private pin;

    constructor(address payable _deployer) public {
        owner = _deployer;
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

    function emergencyWithdraw() public onlyOwner payable {
        require(address(this).balance > 0, "No funds to withdraw.");
        owner.transfer(address(this).balance);
    }
}

