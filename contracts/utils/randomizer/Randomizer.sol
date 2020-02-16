pragma solidity ^0.6.0;

contract Randomizer  {

    // A storage to store previous used seed.
    uint256 prevSeed;

    // Pseudorandom function to generate a int8 between 0 and 30 for Bitmon stats
    // This function is pseudorandom because it is not possible to have randomization on a distributed
    // network.
    // The only purpose is to make impossible to the users to determine the probability and calculate
    // scenarios prior to the generation.
    // How does it works:
    //  1. The function takes the block timestamp, the difficulty, height and the average seed of all
    //     the other used previous seeds.
    //  2. All this information is hashed, once the new seed is generated and added to the used seeds.
    //  3. Once we have the seed use the first byte and divide it by 3 until is lower then 30.
    function random() public returns (uint8) {
        uint256 hashSeed = uint256(keccak256(abi.encode(block.timestamp, block.difficulty, block.number, prevSeed)));
        prevSeed += hashSeed;
        bytes memory buffer = new bytes(32);
        assembly {
            mstore(add(buffer, 32), hashSeed)
        }
        uint8 randomN = bytesToUint8(uint(10), buffer);
        while (randomN > 30) {
            randomN /= 3;
        }
        return randomN;
    }

    function bytesToUint8(uint _offst, bytes memory _input) internal pure returns (uint8 _output) {
        assembly {
            _output := mload(add(_input, _offst))
        }
    }
}
