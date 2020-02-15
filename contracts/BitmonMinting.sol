pragma solidity ^0.5.0;

import "@openzeppelin/contracts/GSN/Context.sol";
import "./BitmonMetadata.sol";
import "./utils/randomizer/Randomizer.sol";
import "./BitmonOwnable.sol";

// BitmonMinting contract has all the required information to generate Bitmons.
contract BitmonMinting is Context, BitmonMetadata, Randomizer, BitmonOwnable {

    // Init the constructor and add the contract address as a minter
    constructor () internal {
        Bitmon memory baseBitmon = createGen0Bitmon(0,0,0,0,0);
        _addBitmonIndex(baseBitmon, 0, _msgSender());
        _addMinter(_msgSender());
    }

    // The map for addresses and minting capabilities
    mapping (address => bool) private _minters;

    event MinterAdded(address indexed account);

    // Modifier for secure usage for functions that require minting privileges
    modifier onlyMinter() {
        require(isMinter(_msgSender()), "MinterRole: caller does not have the Minter role");
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
    function mint(address to, uint256 _bitmonID, int8 _gender, int8 _nature, int8 _specimen, int8 _variant) public onlyMinter returns (bool) {
        _mint(to, _bitmonID, _gender, _nature, _specimen, _variant);
        return true;
    }

    // Internal function to mint
    function _mint(address to, uint256 _bitmonID, int8 _gender, int8 _nature, int8 _specimen, int8 _variant) internal {
        require(to != address(0), "ERC721: mint to the zero address");
        uint256 tokenId = bitmonsCount + 1;
        Bitmon memory bitmon = createGen0Bitmon(_bitmonID, _gender, _nature, _specimen, _variant);
        _addBitmonIndex(bitmon, tokenId, to);
        emit Transfer(address(0), to, tokenId);
    }

    // Internal function to create a Gen0 Bitmon.
    function createGen0Bitmon(uint256 _bitmonID, int8 _gender, int8 _nature, int8 _specimen, int8 _variant) internal returns (Bitmon memory) {
        Stats memory bitmonStats = Stats(random(),random(),random(),random(),random());
        Bitmon memory _bitmon = Bitmon({
            bitmonID: _bitmonID,
            fatherID: 0,
            motherID: 0,
            gender: _gender,
            nature: _nature,
            specimen: _specimen,
            purity: 100,
            birthHeight: block.number,
            variant: _variant,
            generation: 0,
            stats: bitmonStats
         });
        return _bitmon;
    }

}
