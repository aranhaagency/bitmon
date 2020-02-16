pragma solidity ^0.6.0;

import "./BitmonOwnable.sol";

// BitmonMinting contract has all the required information to generate Bitmons.
contract BitmonMinting is BitmonOwnable {

    address public randomContract;

    function setRandomContractAddr(address _addr) external onlyMinter {
        randomContract = _addr;
    }

    function getRandomUint8() internal returns (uint8) {
        address randomizerContract = randomContract;
        bool success = randomizerContract.call(abi.encodeWithSignature("randomUint8()"));
        return 0;
    }

    function random() internal returns (uint8) {
        require(randomContract != address(0), "ERC721: there is not random number contract address");
        return getRandomUint8();
    }

    // constructor is a deploy called function to add a first bitmon and add the deployment address as minter
    constructor () internal {
        _mint(0, msg.sender, 0,0,0,0,0);
        _addMinter(msg.sender);
    }

    // _minters is a map of addresses capable of minting
    mapping (address => bool) private _minters;

    event MinterAdded(address indexed account);
    event MintedBitmon(address indexed account, uint256 indexed tokenID);

    // onlyMinter is a modifier for secure check against the index of addresses to see minting habilities.
    modifier onlyMinter() {
        require(isMinter(msg.sender), "MinterRole: caller does not have the Minter role");
        _;
    }

    // isMinter checks if the user can mint
    function isMinter(address account) public view returns (bool) {
        return _minters[account];
    }

    // _addMinter is an internal function to add a new minter address
    function _addMinter(address account) internal {
        _minters[account] = true;
        emit MinterAdded(account);
    }

    // mint is a public function to call a mint
    function mint(address to, uint256 _bitmonID, uint8 _gender, uint8 _nature, uint8 _specimen, uint8 _variant) public onlyMinter returns (bool) {
        uint256 tokenId = _bitmons.length + 1;
        _mint(tokenId, to, _bitmonID, _gender, _nature, _specimen, _variant);
        return true;
    }

    // _mint is the internal function to mint
    function _mint(uint256 _tokenId, address _to, uint256 _bitmonID, uint8 _gender, uint8 _nature, uint8 _specimen, uint8 _variant) internal {
        require(_to != address(0), "ERC721: mint to the zero address");
        Bitmon memory bitmon = createGen0Bitmon(_bitmonID, _gender, _nature, _specimen, _variant);
        _addBitmonIndex(bitmon, _tokenId, _to);
        emit Transfer(address(0), _to, _tokenId);

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
