// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract storagefactory{
    simplestorage[] public Simplestoragearray;
    function createsimplestoragecontract() public{
        simplestorage SimpleStorage = new simplestorage();
        Simplestoragearray.push(SimpleStorage);

    }
    function sfstore(uint256 _simplestorageindex,uint256 _simplestoragenumber) public{
        // address
        // ABI
        simplestorage simpleStorage = Simplestoragearray[_simplestorageindex];
        simpleStorage.store(_simplestoragenumber);
    }
    function read(uint256 _simplestorageindex) public view returns(uint256){
        return  Simplestoragearray[_simplestorageindex].retrieve();
    }


}
