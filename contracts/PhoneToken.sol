// SPDX-License-Identifier: BoomerTeam
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "./ERC20.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
// import "./Ownable.sol";

contract PhoneToken is ERC20("PhoneToken", "PHONE"), Ownable {
    
     /// @notice Creates `_amount` token to `_to`. Must only be called by the owner.
    function mint(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
    }
    
     function burn(address _account, uint256 _amount) public onlyOwner {
        _burn(_account, _amount);
    }
    
}