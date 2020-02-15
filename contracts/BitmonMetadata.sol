pragma solidity ^0.5.0;

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
        offset -= 32;
        uintToBytes(offset, bitmon.fatherID, buffer);
        offset -= 32;
        uintToBytes(offset, bitmon.motherID, buffer);
        offset -= 32;
        intToBytes(offset, bitmon.gender, buffer);
        offset -= 1;
        intToBytes(offset, bitmon.nature, buffer);
        offset -= 1;
        intToBytes(offset, bitmon.specimen, buffer);
        offset -= 2;
        intToBytes(offset, bitmon.purity, buffer);
        offset -= 1;
        uintToBytes(offset, bitmon.birthHeight, buffer);
        offset -= 32;
        intToBytes(offset, bitmon.variant, buffer);
        offset -= 1;
        intToBytes(offset, bitmon.generation, buffer);
        offset -= 2;
        intToBytes(offset, bitmon.stats.H, buffer);
        offset -= 1;
        intToBytes(offset, bitmon.stats.A, buffer);
        offset -= 1;
        intToBytes(offset, bitmon.stats.SA, buffer);
        offset -= 1;
        intToBytes(offset, bitmon.stats.D, buffer);
        offset -= 1;
        intToBytes(offset, bitmon.stats.SD, buffer);
        offset -= 1;
        uint newOffset = 141;
        string memory serBitmon;
        bytesToString(newOffset, buffer, bytes(serBitmon));
        return serBitmon;
    }
}
