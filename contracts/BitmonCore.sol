pragma solidity ^0.6.0;

import "./BitmonBase.sol";
import "./BitmonMinting.sol";

// BitmonCore is the main input of the contract.
contract BitmonCore is BitmonMinting {
    string public constant name = "Bitmon TEST";
    string public constant symbol = "BMT";

    function transfer(uint256 _tokenID, address _to) external  {
        _transferIndex(_tokenID, _to);
        emit Transfer(msg.sender, _to, _tokenID);
    }

    function transferFrom(uint256 _tokenID, address _from, address _to) external onlyMinter {
        _transferFromIndex(_tokenID, _from, _to);
        emit Transfer(_from, _to, _tokenID);
    }

    // DEBUG functions

    function debugSetMaxSeed(uint256 newMaxSeedN) external onlyMinter returns(uint256) {
        return _setMaxSeeds(newMaxSeedN);
    }

    function debugMaxSeeds() external view onlyMinter returns(uint256) {
        return maxSeedsToStore;
    }

    function debugSeeds() external view onlyMinter returns(uint256[] memory) {
        return prevSeeds;
    }

    function debugRandom() external onlyMinter returns(int8) {
        return random();
    }

    function debugMetadata(uint256 tokenID) external view onlyMinter returns(string memory) {
        return tokenMetadata(tokenID);
    }

}
