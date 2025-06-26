// get funds from user
// withdraw funds

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./priceconverter.sol";
error notowner();
//minimmumUsd gives the no in dollars not ether
contract fundme{
    using priceconverter for uint256;
    uint256 public constant MINIMMUM_USD=50 * 1e18;
    

    address[] public funders;
    mapping(address => uint256) public addresstobefunded;
    address public immutable owner;
    constructor(){
        owner=msg.sender;
    }

    function Fund() public payable {
        // want to be able to fund a minimmum amount in usd
        // 1. how to send eth to the contract

        require(msg.value.getconversionrate() >= MINIMMUM_USD,"didnt send enough!"); // 1e18 is in wei equal to 1 ether
        funders.push(msg.sender);
        addresstobefunded[msg.sender] += msg.value;

    }
  
    function withdraw() public onlyowner{
       
        for(uint256 fundersindex = 0; fundersindex < funders.length; fundersindex++){
            address funder = funders[fundersindex];
            addresstobefunded[funder] = 0;


        }
        funders = new address[](0);
        /*
        // transfer
        payable(msg.sender).transfer(address(this).balance);
        //send
        bool success = payable(msg.sender).send(address(this).balance);
        require(success,"failed");
        */

        //call
        (bool calls,) = payable(msg.sender).call{value:address(this).balance}("");
        require(calls,"failed");


    }
    // if we put the dash above it means that we have instructed to run code first and then selection latee
    modifier onlyowner{
        //require(msg.sender == owner,"sender not owner");
        if(msg.sender!=owner){ revert notowner(); }
        _; 

    }
    receive() external payable{
        Fund();

    }
    fallback() external payable{
        Fund();

    }

    
}