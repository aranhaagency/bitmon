pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

import "./BitmonBase.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/roles/MinterRole.sol";


// BitmonCore is the main input of the contract.
contract BitmonCore is BitmonBase, ERC721Enumerable, MinterRole {

    address public randomContractAddr;

    function setRandomContractAddr(address _addr) external onlyMinter returns (bool) {
        randomContractAddr = _addr;
        return true;
    }

    function random() internal returns (uint8) {
        require(randomContractAddr != address(0), "contract address is not defined");
        (bool success, bytes memory data) = randomContractAddr.call(abi.encodeWithSignature("randomUint8()"));
        require(success, "contract call failed");
        uint8 randomN = _bytesToUint8(data.length, data);
        while (randomN > 30) {
            randomN /= 2;
        }
        return randomN;
    }

    function _bytesToUint8(uint _offst, bytes memory _input) internal pure returns (uint8 _output) {
        assembly {
            _output := mload(add(_input, _offst))
        }
    }

    mapping (uint256 => Bitmon) bitmons;

    function mintBitmon(address _to, uint256 _bitmonId, uint8 _gender, uint8 _nature, uint8 _specimen, uint8 _variant) external onlyMinter returns (bool) {
        uint256 tokenId = totalSupply() + 1;
        _safeMint(_to, tokenId, "");
        Bitmon memory _bitmon = createGen0Bitmon(_bitmonId, _gender, _nature, _specimen, _variant);
        bitmons[tokenId] = _bitmon;
        return true;
    }

    function bitmonData(uint256 tokenId) external view returns (Bitmon memory) {
        require(_exists(tokenId), "ERC721: Bitmon doesn't exists");
        return bitmons[tokenId];
    }

    // createGen0Bitmon is a function to create a Gen0 Bitmon.
    function createGen0Bitmon(uint256 _bitmonID, uint8 _gender, uint8 _nature, uint8 _specimen, uint8 _variant) internal returns (Bitmon memory) {
        Bitmon memory _bitmon = Bitmon({
            bitmonID: _bitmonID,
            fatherID: uint256(0),
            motherID: uint256(0),
            gender: _gender,
            nature: _nature,
            specimen: _specimen,
            purity: 100,
            birthHeight: block.number,
            variant: _variant,
            generation: 0,
            H: random(),
            A: random(),
            SA: random(),
            D: random(),
            SD: random()
            });
        return _bitmon;
    }

}
