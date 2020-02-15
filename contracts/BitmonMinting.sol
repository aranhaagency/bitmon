pragma solidity ^0.5.0;

import "@openzeppelin/contracts/GSN/Context.sol";
import "./BitmonMetadata.sol";
import "./utils/randomizer/Randomizer.sol";

// BitmonMinting contract has all the required information to generate Bitmons.
contract BitmonMinting is Context, BitmonMetadata, Randomizer {

    // Init the constructor and add the contract address as a minter
    constructor () internal {
        _addMinter(_msgSender());
    }

    // The map for addresses and minting capabilities
    mapping (address => bool) private _minters;

    event MinterAdded(address indexed account);
    event Transfer(address from, address to, uint256 tokenId);

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
    function mint(address to) public onlyMinter returns (bool) {
        _mint(to);
        return true;
    }

    // Internal function to mint
    function _mint(address to) internal {
        require(to != address(0), "ERC721: mint to the zero address");
        uint256 tokenId = bitmonsCount + 1;
        // TODO here we generate a new ADN and a Bitmon, add to indexes, address ownership and bitmons count
        emit Transfer(address(0), to, tokenId);
    }

}
