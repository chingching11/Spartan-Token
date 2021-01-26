pragma solidity ^0.7;

import "./ERC20Interface.sol";

contract SpartanERC20 is ERC20Interface {
    string public constant tokenSymbol = "STT";
    string public constant tokenName = "Spartan Token";
    uint256 private totalSupplies;

   // mapping of address - tokens 
    mapping (address => uint256) private balances;
    //mapping of address - (address - available tokens )
    mapping (address => mapping (address => uint256)) private allowances;
    // mapping if address is frozen or not 
    mapping (address => bool) private frozen;
    
    constructor(uint256 total) {
        totalSupplies = total;
        balances[msg.sender] = totalSupplies;
    }

    /** Reutrns the token name */
    function name() public pure returns (string memory){
        return tokenName;
    }   

    /** Returns the token symbol */
    function symbol() public pure returns (string memory) {
        return tokenSymbol;
    }
    /** Returns total token supply */
    function totalSupply() public view override returns (uint){
        return totalSupplies;
    }

    /** Return balance of token owner */
    function balanceOf(address tokenOwner) public view override returns (uint balance){
        return balances[tokenOwner];
    }

    /** Returns the amount which spender is still allowed to withdraw from owner */
    function allowance(address tokenOwner, address spender) public view override returns (uint remaining){
        return allowances[tokenOwner][spender];
    }

    /** Transfer tokens to the assigned address and fire Transfer event */
    function transfer(address to, uint tokens) public override returns (bool success){
        // check if the sender account is frozen 
        require(frozen[msg.sender] == false, "The sender account is frozen");
        //sender has enough tokens to transfer
        require(balances[msg.sender] >= tokens, "The sender doesn't have enough token to transfer");
        // token is positive
        require(balances[to] + tokens >= balances[to]);
        // transfer tokens
        balances[msg.sender] -= tokens;
        balances[to] += tokens;
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    /** Allows spender to withdraw from owner's account multiple times, up to the tokens amount. */
    function approve(address spender, uint tokens) public override returns (bool success){
        //check the owner has enough tokens
        require(balances[msg.sender] >= tokens);
        allowances[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    } 

    /** 
        This function allows contracts to transfer tokens on tokenOwner's behalf
        Transfer tokens to "from" address to the "to" address and fire Transfer event 
        from is the owner in this case
    */
    function transferFrom(address from, address to, uint tokens) public override returns (bool success){
        // check if the sender account is frozen 
        require(frozen[msg.sender] == false, "The sender account is frozen");
         //from has enough tokens to transfer
        require(balances[from] >= tokens);
        // check if msg.sender is authorized to transfer by checking token amount is not greater than the allowed tokens 
        require(allowances[from][msg.sender] >= tokens);
        balances[from] -= tokens;
        balances[to] += tokens;
        allowances[from][msg.sender] -= tokens;
        emit Transfer(from, to, tokens);
        return true;
    }

    /** Freeze the account */
    function freeze(address freezeAcc) public {
        frozen[freezeAcc] = true;
    }

    /** Unfreeze the account */
    function thaw(address unfreezeAcc) public {
        frozen[unfreezeAcc] = false;
    }

    /** Burn the caller's tokens */
    function burn(uint tokens) public {
        // check if the caller has enough tokens to burn
        require(balances[msg.sender] >= tokens);
        balances[msg.sender] -= tokens;
        totalSupplies -= tokens;
    }
    
}