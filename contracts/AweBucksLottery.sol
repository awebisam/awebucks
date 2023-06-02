// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AweBucks.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract AweBucksLottery is VRFConsumerBase {
    enum LotteryStatus {
        OPEN,
        CLOSED
    }

    AweBucks private token;
    address public contractOwner;
    uint256 public entryFee;
    uint256 public contractBalance;
    bytes32 private requestId;
    uint256 private randomResult;
    uint256 public fee;
    bytes32 public keyHash;
    uint256 private constant MAX_RANDOM_NUMBER = 1000000;
    LotteryStatus public lotteryStatus;
    address[] private participants;

    event LotteryEntered(address indexed participant, uint256 amount);
    event LotteryWinner(address indexed winner, uint256 prize);
    event LotteryRestarted();

    constructor(
        address _tokenAddress,
        address _vrfCoordinator,
        address _linkToken,
        bytes32 _keyHash,
        uint256 _fee,
        uint256 _entryFee
    ) VRFConsumerBase(_vrfCoordinator, _linkToken) {
        token = AweBucks(_tokenAddress);
        contractOwner = msg.sender;
        entryFee = _entryFee;
        keyHash = _keyHash;
        fee = _fee;
        lotteryStatus = LotteryStatus.CLOSED;
    }

    modifier onlyOwner() {
        require(
            msg.sender == contractOwner,
            "Only the contract owner can call this function"
        );
        _;
    }
    modifier needOpen() {
        require(
            lotteryStatus == LotteryStatus.OPEN,
            "Lottery is not currently open"
        );
        _;
    }

    function enterLottery() external needOpen {
        require(
            token.balanceOf(msg.sender) >= entryFee,
            "Insufficient token balance"
        );
        // can't reapply
        for (uint256 i = 0; i < participants.length; i++) {
            require(
                participants[i] != msg.sender,
                "You have already entered the lottery"
            );
        }
        token.transferFrom(msg.sender, address(this), entryFee);
        uint256 tax = entryFee / 10;
        token.transfer(contractOwner, tax);
        contractBalance += entryFee - tax;
        participants.push(msg.sender);
        emit LotteryEntered(msg.sender, entryFee);
    }

    function startLottery() public onlyOwner {
        require(
            lotteryStatus == LotteryStatus.CLOSED,
            "Lottery is already open"
        );

        lotteryStatus = LotteryStatus.OPEN;
    }

    function endLottery(bool restart) external onlyOwner needOpen{

        lotteryStatus = LotteryStatus.CLOSED;
        requestId = requestRandomness(keyHash, fee);
        if (restart) {
            startLottery();
        }

    }

    function fulfillRandomness(
        bytes32 _requestId,
        uint256 _randomness
    ) internal override {
        require(requestId == _requestId, "Invalid request ID");
        randomResult = _randomness % MAX_RANDOM_NUMBER;

        address winner = getRandomParticipant();
        uint256 prize = contractBalance;

        token.transfer(winner, prize);
        emit LotteryWinner(winner, prize);
        contractBalance = 0;
    }

    function getRandomParticipant() private view returns (address) {
        uint256 participantCount = contractBalance / entryFee;
        uint256 randomIndex = randomResult % participantCount;

        return participants[randomIndex];
    }
}
