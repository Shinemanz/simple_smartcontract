//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC20 {

    constructor(uint256 _initialSupply) ERC20("AirdropToken", "ATN") {
        _mint(msg.sender, _initialSupply);
    }
}

contract Airdrop is Ownable {
    IERC20 IERCToken;
    address[] public whitelistAddresses;

    constructor(IERC20 _tokenAddress) {
        IERCToken = _tokenAddress;
    }

    function airdropToken(uint _amount) public onlyOwner payable {
        for (uint i = 0; i < whitelistAddresses.length; i++) {
            IERCToken.transferFrom(msg.sender, whitelistAddresses[i], _amount);
        }
    }

    function addWhitelist(address[] memory _whitelistAddresses) public onlyOwner {
        for (uint256 i = 0; i < _whitelistAddresses.length; i ++) {
            whitelistAddresses.push(_whitelistAddresses[i]);
        }
    }
}