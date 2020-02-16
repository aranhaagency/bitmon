pragma solidity ^0.6.0;

import "./BitmonIndexes.sol";

// BitmonOwnable contains information about Bitmon owners.
contract BitmonOwnable is BitmonIndexes {

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    // balanceOf returns the amount of tokenIDs owned by an address
    function balanceOf(address _owner) external view returns (uint256) {
        require(_owner != address(0), "ERC721: owner query for zero account");
        return bitmonOwnerCount[_owner];
    }

    // ownerOf returns the address owner of a tokenID
    function ownerOf(uint256 _tokenId) external view returns (address) {
        address owner = bitmonIndexOwner[_tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
        return owner;
    }

    // tokensOfOwner returns all the bitmons owned by an address
    function tokensOfOwner(address owner) external view returns (uint256[] memory) {
        require(_owner != address(0), "ERC721: owner query for zero account");
        return _bitmonOwnershipIndex[owner];
    }

    // transfer moves ownership from tokenID to a new address without minting privileges.
    function transfer(uint256 _tokenID, address _to) external  {
        require(bitmonIndexOwner[_tokenID] == msg.sender, "ERC721: the sender is not owner of the token");
        _transferIndex(_tokenID, _to);
        emit Transfer(msg.sender, _to, _tokenID);
    }
}
