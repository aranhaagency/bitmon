pragma solidity ^0.5.0;

import "./BitmonBase.sol";

// BitmonIndexes contains information about Bitmon storage indexes with safe access functions
contract BitmonIndexes is BitmonBase {

    // bitmonsCount is a uint256 number to make sure there are no duplicated tokenID.
    uint256 bitmonsCount;

    // This index is used to get the specific information of a Bitmon based on its tokenID.
    mapping (uint256 => Bitmon) bitmonMetaDataIndex;

    // This index is used to get the specific ownership of a Bitmon using its tokenID
    mapping (uint256 => address) bitmonIndexOwner;

    // This index is used to get all bitmons of a specific account.
    mapping (address => uint256[]) bitmonOwnerShipIndex;

    // totalSupply returns all the bitmons on the network
    function totalSupply() public view returns (uint256) {
        return bitmonsCount;
    }
}
