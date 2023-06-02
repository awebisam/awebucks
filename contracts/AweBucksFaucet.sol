// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

import "./AweBucks.sol";

contract AweBucksFaucet {
    AweBucks private token;
    uint256 public faucetAmount;
    uint256 public cooldownPeriod;
    mapping(address => uint256) private lastClaimedTime;

    event TokensClaimed(address indexed recipient, uint256 amount);

    constructor(address _tokenAddress, uint256 _faucetAmount, uint256 _cooldownPeriod) {
        token = AweBucks(_tokenAddress);
        faucetAmount = _faucetAmount;
        cooldownPeriod = _cooldownPeriod;
    }

    function claimTokens() external {
        require(canClaimTokens(msg.sender), "Cooldown period has not elapsed");

        require(token.balanceOf(address(this)) >= faucetAmount, "Insufficient tokens in faucet");

        token.transfer(msg.sender, faucetAmount);
        lastClaimedTime[msg.sender] = block.timestamp;
        emit TokensClaimed(msg.sender, faucetAmount);
    }

    function canClaimTokens(address user) public view returns (bool) {
        return block.timestamp >= lastClaimedTime[user] + cooldownPeriod;
    }
}
