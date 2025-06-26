//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library priceconverter{
    function getprice() internal view returns(uint256){
        //ABI
        //ADDRESS 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface Pricefeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        
        (,int256 price,,,)=Pricefeed.latestRoundData();
        // eth in termsof usd
        return uint256(price * 1e10);

    }
    function getversion() internal view returns(uint256){
        AggregatorV3Interface Pricefeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return Pricefeed.version();
    }
    function getconversionrate(uint256 ethamount) internal view returns(uint256){
        uint256 ethprice=getprice();
        uint256 ethamountinUsd = (ethprice * ethamount) / 1e18;
        return ethamountinUsd;


    } 


}