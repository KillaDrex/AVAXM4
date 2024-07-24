# Degen Token

This is a Solidity smart contract that provides operations for the Degen Token (DGN), such as minting, transferring, burning, checking balance, and even exchanging tokens for items for an in-game store.

## Description

It is a Solidity smart contract deployed to the Avalanche Fuji Testnet. It has been verified using snowtrace and as said before it is an ERC20 Token whose use is for supporting a currency for games, where players can redeem items using their Degen tokens.

## Getting Started

### Installing

* You can download the files here: https://github.com/KillaDrex/AVAXM4
* Afterwards, update the hardhat config file and put in your private keys for the fuji & mainnet network.

### Executing program

1. Open a terminal
2. Run npm install for dependencies
2. Run npx hardhat run --network fuji scripts/deploy.js to deploy to testnet (make sure you have enough tokens)
3. Run npx hardhat flatten > FlattenedDegen.sol (flatten sol file for verifying on snowtrace)
4. Make sure that the flattened file is in the contracts folder
5. npx hardhat verify [contract address] Degen DGN 100 --network fuji for verification


## Help

1. If you don't have enough tokens, you can search online for the Avalanche testnet faucet and get some there.
2. If the verify command doesn't work, there is a UI option in snowtrace, that's why we flattened the file. Just go to the verify option in snowtrace, provide the contract address; compiler version; and upload the flattened file.


## Authors

Andre Aquino
