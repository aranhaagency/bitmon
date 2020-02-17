# Bitmon World ERC721

Bitmon (BM) is a non-fungible contract based on OpenZeppelin used to store Bitmons information, issuance and owners.

## Contract functions

The Bitmon contract is used to store on-chain data about Bitmon ADN and ownership.

### User information functions

* `balanceOf(address):` returns the amount of bitmons assigned.
* `tokensOfOwner(address):` returns an array of ID's of bitmons owned.
* `totalSupply():` returns the total amount of bitmons in supply.

## Bitmon information functions

* `ownerOf(uint256):` returns the owner account of the tokenID.

## Minting functions

* `isMinter(address):` returns a boolean to know if the account can mint tokens.
* `mint(address, uint256, uint8, uint8, uint8, uint8):` generate a new bitmon based on provided properties.

## Transfer functions

* `transfer():` transfers the ownership of a bitmon to another account without privileges.
* `transferFrom():` transfers the ownership of a bitmon from one account to another with privileges.

## Events

* `Transfer`
* `MinterAdded`
* `MintedBitmon`
