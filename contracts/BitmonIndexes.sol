pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "./BitmonBase.sol";

// BitmonIndexes contains information about Bitmon storage indexes with safe access functions
contract BitmonIndexes is BitmonBase {

    // _bitmons is used to get the specific information of a Bitmon based on its tokenID.
    Bitmon[] _bitmons;

    // _bitmonIndexOwner is used to get the specific ownership of a Bitmon using its tokenID
    mapping (uint256 => address) _bitmonIndexOwner;

    // _bitmonOwnershipIndex is used to get all bitmons of a specific account.
    mapping (address => uint256[]) _bitmonOwnershipIndex;

    // _exists is a safe use function to check if a bitmon exists.
    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _bitmonIndexOwner[tokenId];
        return owner != address(0);
    }

    // totalSupply returns all the bitmons on the network
    function totalSupply() public view returns (uint256) {
        return _bitmons.length;
    }

    // _addBitmonIndex is a safe entry function to fill all indexes with a new minted bitmon
    function _addBitmonIndex(Bitmon memory bitmon, uint256 _tokenID, address _owner) internal {
        _bitmons.push(bitmon);
        _bitmonIndexOwner[_tokenID] = _owner;
        _addTokenToAddressIndex(_tokenID, _owner);
    }

    // _transferIndex is a function to remove an owner to the index and add the new owner information without minting privileges
    function _transferIndex(uint256 _tokenID, address _to) public {
        _bitmonIndexOwner[_tokenID] = _to;
        _removeTokenFromAddressIndex(_tokenID, msg.sender);
        _addTokenToAddressIndex(_tokenID, _to);
    }

    // _transferIndex is a function to remove an owner to the index and add the new owner information with minting privileges
    function _transferFromIndex(uint256 _tokenID, address _from, address _to) public {
        _bitmonIndexOwner[_tokenID] = _to;
        _removeTokenFromAddressIndex(_tokenID, _from);
        _addTokenToAddressIndex(_tokenID, _to);
    }

    // _removeTokenFromAddressIndex removes the token from the _bitmonOwnershipIndex
    function _removeTokenFromAddressIndex(uint256 _tokenID, address _owner) private returns(bool) {
        for ( uint256 i = 0; i < _bitmonOwnershipIndex[_owner].length; i++) {
            if (_bitmonOwnershipIndex[_owner][i] == _tokenID) {
                delete _bitmonOwnershipIndex[_owner][i];
                return true;
            }
        }
        return false;
    }

    // _addTokenToAddressIndex adds the token to the _bitmonOwnershipIndex
    function _addTokenToAddressIndex(uint256 _tokenID, address _owner) private {
        _bitmonOwnershipIndex[_owner].push(_tokenID);
    }

}
