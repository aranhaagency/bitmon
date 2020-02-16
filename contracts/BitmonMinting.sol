pragma solidity ^0.6.0;

import "./utils/randomizer/Randomizer.sol";
import "./BitmonOwnable.sol";

// BitmonMinting contract has all the required information to generate Bitmons.
contract BitmonMinting is Randomizer, BitmonOwnable {

    // Add the contract account as minter and create the base bitmon.
    constructor () internal {
        _mint(0, msg.sender, 0,0,0,0,0);
        _addMinter(msg.sender);
    }

    // The map for addresses and minting capabilities
    mapping (address => bool) private _minters;

    event MinterAdded(address indexed account);
    event MintedBitmon(address indexed account, uint256 indexed tokenID);

    // Modifier for secure usage for functions that require minting privileges
    modifier onlyMinter() {
        require(isMinter(msg.sender), "MinterRole: caller does not have the Minter role");
        _;
    }

    // Public function to check if an account is capable of minting
    function isMinter(address account) public view returns (bool) {
        return _minters[account];
    }

    // Internal function to add a new minter address
    function _addMinter(address account) internal {
        _minters[account] = true;
        emit MinterAdded(account);
    }

    // Public function to call a mint
    function mint(address to, uint256 _bitmonID, uint8 _gender, uint8 _nature, uint8 _specimen, uint8 _variant) public onlyMinter returns (bool) {
        uint256 tokenId = bitmons.length + 1;
        _mint(tokenId, to, _bitmonID, _gender, _nature, _specimen, _variant);
        return true;
    }

    // Internal function to mint
    function _mint(uint256 _tokenId, address _to, uint256 _bitmonID, uint8 _gender, uint8 _nature, uint8 _specimen, uint8 _variant) internal {
        require(_to != address(0), "ERC721: mint to the zero address");
        Bitmon memory bitmon = createGen0Bitmon(_bitmonID, _gender, _nature, _specimen, _variant);
        _addBitmonIndex(bitmon, _tokenId, _to);
        emit Transfer(address(0), _to, _tokenId);

    }

    // Internal function to create a Gen0 Bitmon.
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
