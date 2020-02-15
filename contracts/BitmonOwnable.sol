pragma solidity ^0.5.0;

import "./BitmonIndexes.sol";

// BitmonOwnable contains information about Bitmon owners.
contract BitmonOwnable is BitmonIndexes {

    // balanceOf the amount of ids owned by an address
    function balanceOf(address _owner) public view returns (uint256) {
        uint256[] memory ownerIDs = bitmonOwnerShipIndex[_owner];
        return ownerIDs.length;
    }

    // ownerOf returns the address owner of a tokenID
    function ownerOf(uint256 _tokenId) external view returns (address) {
        address owner = bitmonIndexOwner[_tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
        return owner;
    }

    // tokensOfOwner returns all the bitmons owned by an address
    function tokensOfOwner(address owner) public view returns (uint256[] memory) {
        return bitmonOwnerShipIndex[owner];
    }

    function transfer(address _to, uint256 _tokenId) external;
    function transferFrom(address _from, address _to, uint256 _tokenId) external;
}