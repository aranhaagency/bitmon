pragma solidity ^0.5.0;

import "./BitmonBase.sol";
import "./BitmonMinting.sol";

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

    // TODO we need to make sure addition to the index doesn't collide with already generated mons
    function _addBitmonIndex(Bitmon memory bitmon, uint256 _tokenID, address _owner) internal {
        // Add a new bitmon to total supply
        bitmonsCount += bitmonsCount + 1;
        // Add metadata to the index
        bitmonMetaDataIndex[_tokenID] = bitmon;
        bitmonIndexOwner[_tokenID] = _owner;
        bitmonOwnerShipIndex[_owner].push(_tokenID);
    }

    function _transferIndex(uint256 _tokenID, address _to) public {
        require(bitmonIndexOwner[_tokenID] == msg.sender, "ERC721: the sender is not owner of the token");
        bitmonIndexOwner[_tokenID] = _to;
        _removeTokenFromAddressIndex(_tokenID, msg.sender);
        _addTokenToAddressIndex(_tokenID, _to);
    }

    function _transferFromIndex(uint256 _tokenID, address _from, address _to) public {
        bitmonIndexOwner[_tokenID] = _to;
        _removeTokenFromAddressIndex(_tokenID, _from);
        _addTokenToAddressIndex(_tokenID, _to);
    }

    function _removeTokenFromAddressIndex(uint256 _tokenID, address _owner) private returns(bool) {
        for ( uint256 i = 0; i < bitmonOwnerShipIndex[_owner].length; i++) {
            if (bitmonOwnerShipIndex[_owner][i] == _tokenID) {
                delete bitmonOwnerShipIndex[_owner][i];
                return true;
            }
        }
        return false;
    }

    function _addTokenToAddressIndex(uint256 _tokenID, address _owner) private {
        bitmonOwnerShipIndex[_owner].push(_tokenID);
    }
}
