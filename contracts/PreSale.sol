// SPDX-License-Identifier: BoomerTeam
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
// import "./SafeERC20.sol";

import "@openzeppelin/contracts/math/SafeMath.sol";
// import "./SafeMath.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
// import "./Ownable.sol";

import "./PhoneToken.sol";


contract PreSale is Ownable {
    using SafeMath for uint256;
    using SafeERC20 for PhoneToken;
    
    // The PHONE token!
    PhoneToken public phone;
    // Price of token
    uint256 price;
    
    // Constructor 
    constructor(PhoneToken _phone) public {
        phone = _phone;
        price = 1e16;
    }
   
   
    // Functions
    
    /** 
     * @dev change price of token PHONE
     * @param _priceNew is new price of token PHONE - unit is Wei
    */
    function changePrice(uint256 _priceNew) public onlyOwner {
        require(_priceNew > 0, "_priceNew must be greater than 0 ");
        price = _priceNew;
    }
    
    
    event buyToken(address buyer, uint256 amountToken, uint256 price);
    /** 
     * @dev function buy token PHONE 
     * @param _amountToken is amount token will buy
    */
    function buyTokenPhone(uint256 _amountToken) public payable {
        require(_amountToken > 0, "_amountToken must be greater than 0 ");
        uint256 value  = _amountToken.mul(price);
        require(value == msg.value, "value must equal msg.value");
        phone.safeTransfer(msg.sender, value);
        emit buyToken(msg.sender, _amountToken, price);
    }
    
    
    /** 
     * @dev get balance ETH of contract
    */
    function getBalanceETH() public view returns( uint256 ) {
        return address(this).balance;
    }
    
    /** 
     * @dev get balanceOf PHONE token of contract
    */
    function getBalancePHONE() public view returns( uint256 ) {
        return phone.balanceOf(address(this));
    }
    
    /** 
     * @dev function withdraw ETH to account owner
     * @param _amount is amount withdraw
    */
    function withdrawETH(uint256 _amount) public onlyOwner {
        require(_amount > 0 , "_amount must be greater than 0");
        require( address(this).balance >= _amount ,"_amount must be less than the ETH balance of the contract");
        msg.sender.transfer(_amount);
    }
    
    /** 
     * @dev function withdraw PHONE token to account owner
     * @param _amount is amount withdraw
    */
    function withdrawPHONE(uint256 _amount) public onlyOwner {
        require(_amount > 0 , "_amount must be greater than 0");
        require(phone.balanceOf(address(this)) >= _amount , "_amount must be less than the PHONE token balanceOf the contract");
        phone.safeTransfer(msg.sender, _amount);
    }
    
    event Received(address, uint);
    receive () external payable {
        emit Received(msg.sender, msg.value);
    } 
}