pragma solidity ^0.5.0;

import "./utils/seriality/Seriality.sol";


contract BitmonBase  {

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    // The Stats struct is the generated modifiers to the base properties of a Bitmon,
    // all the elements are numbers between 0 and 30.
    // Stats serialized size is 5 bytes.
    struct Stats  {
        int8 H;
        int8 A;
        int8 SA;
        int8 D;
        int8 SD;
    }

    // The Bitmon struct is the ADN information defined at the born of a Bitmon.
    // This variables affect in-game experience and are used to fill the Breeding algorithm.
    // Bitmon serialized size is 141 bytes.
    struct Bitmon {
        uint256    bitmonID;       // Unique ID to identify this Bitmon
        uint256    fatherID;       // Father unique ID to trace parent line
        uint256    motherID;       // Mother unique ID to trace mother line
        int8       gender;         // Gender definition (female 1 or male 0)
        int8       nature;         // Characteristics of the behaviour (between 1 to 30)
        int16      specimen;       // Specie identifier
        int8       purity;         // Speciment purity (Between 0 and 100)
        uint256    birthHeight;    // BlockHeight of the network at Bitmon born.
        int8       variant;        // Color variants
        int16      generation;     // Generation
        Stats      stats;          // Stats are modifiers to the Bitmon main attributes.
    }

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

    // tokensOfOwner returns all the bitmons owned by an address
    function tokensOfOwner(address owner) public view returns (uint256[] memory) {
        return bitmonOwnerShipIndex[owner];
    }
}
