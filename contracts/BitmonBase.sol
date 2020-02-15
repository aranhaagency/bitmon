pragma solidity ^0.5.0;

import "./utils/seriality/Seriality.sol";

contract BitmonBase is Seriality {

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    // The Stats struct is the generated modifiers to the base properties of a Bitmon,
    // all the elements are numbers between 0 and 30.
    // Stats serialized size is 5 bytes.
    struct Stats  {
        uint8 H;
        uint8 A;
        uint8 SA;
        uint8 D;
        uint8 SD;
    }


    // The Bitmon struct is the ADN information defined at the born of a Bitmon.
    // This variables affect in-game experience and are used to fill the Breeding algorithm.
    // Bitmon serialized size 141 bytes.
    struct Bitmon {
        uint256     bitmonID;       // Unique ID to identify this Bitmon
        uint256     fatherID;       // Father unique ID to trace parent line
        uint256     motherID;       // Mother unique ID to trace mother line
        uint8       gender;         // Gender definition (female 1 or male 0)
        uint8       nature;         // Characteristics of the behaviour (between 1 to 30)
        uint16      specimen;       // Specie identifier
        uint8       purity;         // Speciment purity (Between 0 and 100)
        uint256     birthHeight;    // BlockHeight of the network at Bitmon born.
        uint8       variant;        // Color variants
        uint16      generation;     // Generation
        Stats       stats;          // Stats are modifiers to the Bitmon main attributes.
    }

    // bitmonsCount is a uint256 number to make sure there are no duplicated bitmons ID's
    uint256 bitmonsCount;

    // This index is used to get the specific information of a Bitmon based on its particular ADN ID
    mapping (uint256 => Bitmon) bitmonMetaDataIndex;

    // This index is used to get the specific ownership of a Bitmon using its tokenID
    mapping (uint256 => address) bitmonIndexOwner;

    // This index is used to get multiple bitmons of a specific account.
    mapping (address => uint256[]) bitmonOwnerShipIndex;

    // totalSupply returns all the bitmons on the network
    function totalSupply() public view returns (uint256) {
        return bitmonsCount;
    }

    // tokensOfOwner returns all the bitmons owned by an address
    function tokensOfOwner(address owner) public view returns (uint256[] memory) {
        return bitmonOwnerShipIndex[owner];
    }

    // tokenMetadata returns the ADN information for a specific bitmon
    function tokenMetadata(uint256 tokenID) public view returns (string memory) {
        Bitmon memory bitmon = bitmonMetaDataIndex[tokenID];
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
        uintToBytes(offset, bitmon.gender, buffer);
        offset -= 1;
        uintToBytes(offset, bitmon.nature, buffer);
        offset -= 1;
        uintToBytes(offset, bitmon.specimen, buffer);
        offset -= 2;
        uintToBytes(offset, bitmon.purity, buffer);
        offset -= 1;
        uintToBytes(offset, bitmon.birthHeight, buffer);
        offset -= 32;
        uintToBytes(offset, bitmon.variant, buffer);
        offset -= 1;
        uintToBytes(offset, bitmon.generation, buffer);
        offset -= 2;
        uintToBytes(offset, bitmon.stats.H, buffer);
        offset -= 1;
        uintToBytes(offset, bitmon.stats.A, buffer);
        offset -= 1;
        uintToBytes(offset, bitmon.stats.SA, buffer);
        offset -= 1;
        uintToBytes(offset, bitmon.stats.D, buffer);
        offset -= 1;
        uintToBytes(offset, bitmon.stats.SD, buffer);
        offset -= 1;
        uint newOffset = 141;
        string memory serBitmon;
        bytesToString(newOffset, buffer, bytes(serBitmon));
        return serBitmon;
    }


}
