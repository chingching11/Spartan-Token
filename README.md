# Spartan Token

### Overview

The Spartan Token is an ERC-20 Token Contract which implements the ERC-20, a standard for Fungilbe Token. Utilizes the [Remix](https://remix.ethereum.org/) enviornment to test, deploy and debug the smart contract. 

[ERC-20 Token](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/):
> "It provides functionalities like to transfer tokens from one account to another, to get the current token balance of an account and also the total supply of the token available on the network. Besides these it also has some other functionalities like to approve that an amount of token from an account can be spent by a third party account."

--- 

#### Implemented ERC-20 Methods 
```
//returns the name of the token
function name() public view returns (string)

//returns the symbol of the token
function symbol() public view returns (string)

//returns the token total supply
function totalSupply() public view returns (uint256)

//returns the balance of token owner
function balanceOf(address _owner) public view returns (uint256 balance)

//transfer tokens to the assigned '_to' address 
function transfer(address _to, uint256 _value) public returns (bool success)

//transfer tokens on tokenOwner's behalf
function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)

//approve '_spender' to withdraw from owner, up to the '_value' amount
function approve(address _spender, uint256 _value) public returns (bool success)

//returns the amount which '_spender' is still allowed to withdraw from '_owner'
function allowance(address _owner, address _spender) public view returns (uint256 remaining)

```
#### Additional Implemented Methods

```
//freeze the given address account
function freeze(address freezeAcc) public 

//unfreeze the given address account
function thaw(address unfreezeAcc) public

// destroy the specified number of tokens
function burn(uint tokens) public {
```

---

### Useful Resources
* [EIP-20: ERC-20 Token Standard](https://eips.ethereum.org/EIPS/eip-20)
* [About Tokens](https://docs.openzeppelin.com/contracts/3.x/tokens#ERC20)
* [OpenZeppelin: ERC-20 Implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol)
* [ERC-721 Non-Fungible Token Standard](https://ethereum.org/en/developers/docs/standards/tokens/erc-721/)
* [Fungible vs Non-Fungible Tokens](https://blockgeeks.com/guides/fungible-vs-non-fungible-tokens-what-is-the-difference/)