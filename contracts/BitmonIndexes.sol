pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "./BitmonBase.sol";

// BitmonIndexes contains information about Bitmon storage indexes with safe access functions
contract BitmonIndexes is BitmonBase {

    // This index is used to get the specific information of a Bitmon based on its tokenID.
    Bitmon[] _bitmons;

    // This index is used to get the count of a Bitmon owned by an address;
    mapping (address => uint256) _bitmonOwnerCount;

    // This index is used to get the specific ownership of a Bitmon using its tokenID
    mapping (uint256 => address) _bitmonIndexOwner;

    // This index is used to get all bitmons of a specific account.
    mapping (address => uint256[]) _bitmonOwnerShipIndex;

    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = bitmonIndexOwner[tokenId];
        return owner != address(0);
    }

    // totalSupply returns all the bitmons on the network
    function totalSupply() public view returns (uint256) {
        return bitmons.length;
    }

    function _addBitmonIndex(Bitmon memory bitmon, uint256 _tokenID, address _owner) internal {
        bitmonOwnerCount[_owner] += 1;
        bitmons.push(bitmon);
        bitmonIndexOwner[_tokenID] = _owner;
        _addTokenToAddressIndex(_tokenID, _owner);
    }

    function _transferIndex(uint256 _tokenID, address _to) public {
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
