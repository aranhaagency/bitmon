pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

// BitmonBase contains the base structs for a Bitmon
contract BitmonBase  {

    // The Bitmon struct is the ADN information defined at the born of a Bitmon.
    // This variables affect in-game experience and are used to fill the Breeding algorithm.
    struct Bitmon {
        uint256    bitmonID;        // Unique ID to identify this Bitmon
        uint256    fatherID;        // Father unique ID to trace parent line
        uint256    motherID;        // Mother unique ID to trace mother line
        uint8      gender;          // Gender definition (female 1 or male 0)
        uint8      nature;          // Characteristics of the behaviour (between 1 to 30)
        uint16     specimen;        // Specie identifier
        uint8      purity;          // Speciment purity (Between 0 and 100)
        uint256    birthHeight;     // BlockHeight of the network at Bitmon born.
        uint8      variant;         // Color variants
        uint16     generation;      // Generation
        uint8      H;               // Health
        uint8      A;               // Attack
        uint8      SA;              // Special attack
        uint8      D;               // Defense
        uint8      SD;              // Special defense
    }

}
