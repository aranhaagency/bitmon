pragma solidity ^0.5.0;

import "../seriality/Seriality.sol";

contract Randomizer is Seriality {

    // A storage array to store previous used seeds. This helps on randomness because we use all users data.
    uint256[] prevSeeds;

    // _addSeed is an auxiliary function to make sure the prevSeeds array always have a total of 50 pseudorandom seeds
    // while adding a new one.
    function _addSeed(uint256 seed) private {
        // If the array has more than 49 seeds (50 or more)
        // We remove the first element and move all the elements one place back
        if (prevSeeds.length > 49) {
            uint256[] memory copySeeds = prevSeeds;
            for (uint256 i = 1; i < 50; i++) {
                prevSeeds.push(copySeeds[i]);
            }
            prevSeeds[50] = seed;
            return;
        } else {
            prevSeeds.push(seed);
            return;
        }
    }

    // _getSeedFromSeeds is an auxiliary function to get the a pseudorandom seed from a prevSeeds;
    function _getSeedFromSeeds() private view returns(uint256) {
        uint256 sumSeeds;
        for (uint256 i; i < prevSeeds.length; i++) {
            sumSeeds += prevSeeds[i];
        }
        return sumSeeds / prevSeeds.length;
    }


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
    function random() private returns (int8) {
        uint256 newSeed = _getSeedFromSeeds();
        uint256 hashSeed = uint256(keccak256(abi.encode(block.timestamp, block.difficulty, block.number, newSeed)));
        _addSeed(hashSeed);
        bytes memory buffer = new bytes(32);
        assembly { mstore(add(buffer, 32), hashSeed) }
        int8 randomN = bytesToInt8(uint(0), buffer);
        while (randomN > 30) {
            randomN /= 3;
        }
        return randomN;
    }
}
