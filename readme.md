# AweBucks Smart Contracts
NOTE: Frontend Under Development :speech_balloon:

This repository contains the smart contracts for AweBucks Token, AweBucks Lottery, and Faucet deployed on the Sepolia network.

## Contract Addresses

- AweBucks Token: [0x9b3DE377e205e5984bC27C4E8ac3969d7797D6Da](https://sepolia.ethereum.eth/blocks/0x9b3DE377e205e5984bC27C4E8ac3969d7797D6Da) (Verified on Etherscan)
- AweBucks Lottery: [0x3C181aB4cA968b96314A1792d34841FE895374E1](https://sepolia.ethereum.eth/blocks/0x3C181aB4cA968b96314A1792d34841FE895374E1) (Verified on Etherscan)
- Faucet: [0x14Cd80B494Ab86b23b7d40bcF0501F830067A066](https://sepolia.ethereum.eth/blocks/0x14Cd80B494Ab86b23b7d40bcF0501F830067A066) (Verified on Etherscan)

## AweBucks Token

AweBucks Token is an ERC20-compliant token on the Sepolia network. It has the following features:

- Name: AweBucks
- Symbol: AWB
- Decimals: 2
- Total Supply: 100,000,000 AWB [10 Billion * 0.01 AWB]

Holding AweBucks tokens entitles you to a dividend of 1% for every 24 hours. :shushing_face:

## AweBucks Lottery

AweBucks Lottery is a decentralized lottery platform built on the Sepolia network. It offers a chance to win the accumulated AweBucks tokens. The lottery operates as follows:
- Entry Fee: 10 AWB
    - You need to approve the lottery contract to spend 10 AWB from your address. You can do this by calling the `approve()` function with the lottery contract address on the AweBucks token contract. This is needed by ERC20 standard.
    - Users can participate in the lottery by calling the `enter()` function.
    - The lottery contract will automatically transfer 10 AWB from the caller's address to the lottery contract.
- 0.5 AWB from each entry fee is sent to the contract owner as a fee.
- At the end of the lottery, a random winner is selected using Chainlink VRF.
- The entire balance of the lottery contract, minus the owner's fee, is automatically transferred to the winner's address.

## Faucet

The Faucet contract allows users to request AweBucks tokens. It has the following characteristics:

- Drip Rate: 10 AWB per minute
- Users can request AweBucks tokens from the faucet by calling the `claimTokens()` function.
- The faucet will distribute 10 AWB tokens per minute to the caller's address.

## Usage

To interact with the AweBucks Token, AweBucks Lottery, or Faucet contracts on the Sepolia network, follow these steps:

1. Connect to the Sepolia network using your preferred Ethereum client or wallet.

2. Use the respective contract addresses mentioned above to interact with the contracts:

   - AweBucks Token: Use the contract address [0x9b3DE377e205e5984bC27C4E8ac3969d7797D6Da](https://sepolia.ethereum.eth/blocks/0x9b3DE377e205e5984bC27C4E8ac3969d7797D6Da) to access the AweBucks token functionality.

   - AweBucks Lottery: Use the contract address [0x3C181aB4cA968b96314A1792d34841FE895374E1](https://sepolia.ethereum.eth/blocks/0x3C181aB4cA968b96314A1792d34841FE895374E1) to participate in the lottery and interact with the lottery functionalities.

   - Faucet: Use the contract address [0x14Cd80B494Ab86b23b7d40bcF0501F830067A066](https://sepolia.ethereum.eth/blocks/0x14Cd80B494Ab86b23b7d40bcF0501F830067A066) to request AweBucks tokens from the faucet.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvement, please feel free to submit a pull request or open an issue in this repository.

## License

This project is licensed under the [MIT License](LICENSE).
