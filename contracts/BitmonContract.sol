pragma solidity ^0.5.0;

import "./ERC721.sol";
import "./BitmonBase.sol";
import "./BitmonMinting.sol";
import "./BitmonBurning.sol";

contract BitmonContract is ERC721, BitmonMinting, BitmonBurning {
    /// @notice Name and symbol of the non fungible token, as defined in ERC721.
    string public constant name = "Bitmon";
    string public constant symbol = "BM";

}
