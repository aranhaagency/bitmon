pragma solidity ^0.6.0;

import "./utils/seriality/Seriality.sol";
import "./BitmonIndexes.sol";

contract BitmonMetadata is BitmonIndexes, Seriality {

    // tokenMetadata returns the ADN information for a specific bitmon
    function tokenMetadata(uint256 tokenID) public view returns (string memory) {
        Bitmon memory bitmon = bitmonMetaDataIndex[tokenID];
        require(bitmon.bitmonID != 0, "ERC721: bitmon data doesn't exists");
        return _bitmonToString(bitmon);
    }

    // _bitmonToString serialize the bitmon metadata into a hex string
    function  _bitmonToString(Bitmon memory bitmon) private pure returns (string memory) {
        bytes memory buffer = new bytes(141);
        uint offset = 141;
        uintToBytes(offset, bitmon.bitmonID, buffer);
        offset -= sizeOfUint(256);
        uintToBytes(offset, bitmon.fatherID, buffer);
        offset -= sizeOfUint(256);
        uintToBytes(offset, bitmon.motherID, buffer);
        offset -= sizeOfUint(256);
        intToBytes(offset, bitmon.gender, buffer);
        offset -= sizeOfInt(8);
        intToBytes(offset, bitmon.nature, buffer);
        offset -= sizeOfInt(8);
        intToBytes(offset, bitmon.specimen, buffer);
        offset -= sizeOfInt(16);
        intToBytes(offset, bitmon.purity, buffer);
        offset -= sizeOfInt(8);
        uintToBytes(offset, bitmon.birthHeight, buffer);
        offset -= sizeOfUint(256);
        intToBytes(offset, bitmon.variant, buffer);
        offset -= sizeOfInt(8);
        intToBytes(offset, bitmon.generation, buffer);
        offset -= sizeOfInt(16);
        intToBytes(offset, bitmon.stats.H, buffer);
        offset -= sizeOfInt(8);
        intToBytes(offset, bitmon.stats.A, buffer);
        offset -= sizeOfInt(8);
        intToBytes(offset, bitmon.stats.SA, buffer);
        offset -= sizeOfInt(8);
        intToBytes(offset, bitmon.stats.D, buffer);
        offset -= sizeOfInt(8);
        intToBytes(offset, bitmon.stats.SD, buffer);
        offset -= sizeOfInt(8);
        string memory serBitmon = new string (141);
        bytesToString(0, buffer, bytes(serBitmon));
        return serBitmon;
    }
}
