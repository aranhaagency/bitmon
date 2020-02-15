pragma solidity ^0.5.0;

import "./BitmonBase.sol";
import "./BitmonMinting.sol";

// BitmonCore is the main input of the contract.
contract BitmonCore is BitmonMinting {
    string public constant name = "Bitmon TEST";
    string public constant symbol = "BMT";
}
