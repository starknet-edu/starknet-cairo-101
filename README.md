# StarkNet Cairo 101
Get started with Cairo with this simple tutorial. Complete the puzzles, get points and learn about StarkNet smart contracts!

## Introduction
### Disclaimer
Don't expect any kind of benefit from using this, other than learning a bunch of cool stuff about StarNet, the first general purpose validity rollup on the Ethereum Mainnnet. 

StarkNet is still in Alpha. This means that develpment is ongoing, and the paint is not dry everywhere. Things will get better, and in the meanwhile, we make things work with a bit of duct tape here and there!

### How it works
This workshop is a set of smart contracts deployed on StarkNet Alpha on testnet. Each smart contract is an exercice/puzzle; each one outlines a feature of the Cairo Smart contract language. Completing the exercice will credit you with points, in the form of an [ERC20 token](contracts/token/TDERC20.cairo).

This workshop focuses on *reading* Cairo code and StarkNet smart contracts, in order to understand its syntax. You don't need to code or install anything on your machine in order to follow and complete it.

This workshop is the first in a serie that will cover broad smart contract concepts (writing and deploying ERC20/ERC721, bridging assets, L1 <-> L2 messaging...). 
Interested in helping writing those? [Reach out](https://twitter.com/HenriLieutaud)!

## Getting started
As of 05/01/2021, transactions in StarkNet can still be done without an account contract. This tutorial currently leverages this possibility. Once account contracts become more widespread and usable, it will change to reflect that.

However, you still need an account contract to collect your points!

### Creating an account contract
In order to complete the tutorial you need to collect points. These points will be owned by a smart contract wallet, that you need to deploy.
- The easiest way to set one up is currently to use Argent X([download the chrome extension](https://chrome.google.com/webstore/detail/argent-x-starknet-wallet/dlcobpjiigpikoobohmabehhmhfoodbb/) or [check their repo](https://github.com/argentlabs/argent-x). 
- Follow the instructions to install the extension and deploy an account contract 
- Make sure you are on the Goerli testnet network
- The tutorial's points are held in contract `0x057dfbf3ec0011e30745ba93981e78b083988d3595db722b0f0140fc04cdf1ff`. Click on "add token" in Argent X to get your points balance to show up there!

### Using voyager
For this tutorial we'll interact with our contracts through [Voyager](https://goerli.voyager.online/), StarkNet's block explorer. When looking for a contract / transaction, always make sure you are on the Goerli version of Voyager!
- Access your transactions with URL https://goerli.voyager.online/tx/your-tx-hash
- Access a contract with URL https://goerli.voyager.online/contract/your-contract-address
- Access read/write functions of the contract with the "read/write contract" tab in voyager

### Using decimals instead of hexadecimal
Voyager currently has issues dealing with hexadecimal values when writing values to contracts. 

For example, reading your points balance [through voyager](https://goerli.voyager.online/contract/0x057dfbf3ec0011e30745ba93981e78b083988d3595db722b0f0140fc04cdf1ff#readContract) currently does not work if you input your Argent X address as hexadecimal.

To overcome this limitation, always convert your hexadecimal value to decimal. I use [this website](https://www.rapidtables.com/convert/number/hex-to-decimal.html).

### Getting points
Each exercice is a separate smart contract. It contains code that, when executed properly, will distribute points to your address. Since there is no way currently to send a transaction easily through your account contract, you'll have to specify your address for each call.

Points are distributed by the function `distribute_points()` while the function `validate_exercice` records that you completed the exercice (you can get points only once). Your goal is to: 
- Read the code of the exercices in the current repo
- Find where the calls to `distribute_points()` are in the code
- Read the comments of the code to get further instructions if needed
- Manage to call the functions correctly to trigger it.

### Contract addresses 
- [Points counter ERC20](contracts/token/TDERC20.cairo):  [0x057dfbf3ec0011e30745ba93981e78b083988d3595db722b0f0140fc04cdf1ff](https://goerli.voyager.online/contract/0x057dfbf3ec0011e30745ba93981e78b083988d3595db722b0f0140fc04cdf1ff)
- [Ex01](contracts/ex01.cairo) : [0x015884be0178d84bcba488ce5f4eb8e1c5be5218e4b7effd4ff62c78d8a2c10e](https://goerli.voyager.online/contract/0x015884be0178d84bcba488ce5f4eb8e1c5be5218e4b7effd4ff62c78d8a2c10e)
- [Ex02](contracts/ex02.cairo) : [0x004586f9d8397381661f284e9c8f5633265414f71c59f05b41d51cad79613474](https://goerli.voyager.online/contract/0x004586f9d8397381661f284e9c8f5633265414f71c59f05b41d51cad79613474)
- [Ex03](contracts/ex03.cairo) : [0x0112f6c1e24f86aab303909faffe6e26958188b401edbb33ec0931c5345538c4](https://goerli.voyager.online/contract/0x0112f6c1e24f86aab303909faffe6e26958188b401edbb33ec0931c5345538c4)
- [Ex04](contracts/ex04.cairo) : [0x00b3bca0e2055e2b7337902b41f1b94ef0274471283a70483729f73487cb4597](https://goerli.voyager.online/contract/0x00b3bca0e2055e2b7337902b41f1b94ef0274471283a70483729f73487cb4597)
- [Ex05](contracts/ex05.cairo) : [0x01a3bbe62dab562076e2784bd86cb76e3887ffbea5d320352b919f836f1b2b1f](https://goerli.voyager.online/contract/0x01a3bbe62dab562076e2784bd86cb76e3887ffbea5d320352b919f836f1b2b1f)
- [Ex06](contracts/ex06.cairo) : [0x06e9bfcdbbb9c96e9a294701918ebb36386778a246e96b24c17bd4e17fe68208](https://goerli.voyager.online/contract/0x06e9bfcdbbb9c96e9a294701918ebb36386778a246e96b24c17bd4e17fe68208)
- [Ex07](contracts/ex07.cairo) : [0x06c9420f32d063b06a4159079eb2a0c73333ca20ea22da99cda39fb3a69d6860](https://goerli.voyager.online/contract/0x06c9420f32d063b06a4159079eb2a0c73333ca20ea22da99cda39fb3a69d6860)
- [Ex08](contracts/ex08.cairo) : [0x00f663c3019345a40f0b6ff20a56fe54e39c020ba9f318626be51e69422688a6](https://goerli.voyager.online/contract/0x00f663c3019345a40f0b6ff20a56fe54e39c020ba9f318626be51e69422688a6)
- [Ex09](contracts/ex09.cairo) : [0x06cdff0bfa7d3bcb1538dde7ac200fbba645cd2234fd314aa77df5c6f6ddf060](https://goerli.voyager.online/contract/0x06cdff0bfa7d3bcb1538dde7ac200fbba645cd2234fd314aa77df5c6f6ddf060)
- [Ex10](contracts/ex10.cairo) : [0x03851333cf0e864e3c9783095ca366cf8680b5bcb661364616531e7a391c30b3](https://goerli.voyager.online/contract/0x03851333cf0e864e3c9783095ca366cf8680b5bcb661364616531e7a391c30b3)
- [Ex11](contracts/ex11.cairo) : [0x07bab6962016ab0b510056eb3745e5f3cd0fd08ac625ebac5cb90f9e89ef946b](https://goerli.voyager.online/contract/0x07bab6962016ab0b510056eb3745e5f3cd0fd08ac625ebac5cb90f9e89ef946b)


## Contributing
### Help is welcome!
This project can be made better, and will evolve in the coming weeks. Your contributions are welcome! Here are things that you can do to help:
- Correct bugs if you find some
- Add explanation in the comments of the exercice if you feel it needs more explanation
- Add exercices showcasing your favorite Cairo feature

### Reusing this project
This project uses [Nile](https://github.com/OpenZeppelin/nile).
```
git clone https://github.com/l-henri/starknet-cairo-101
cd starknet-cairo-101
python3 -m venv env
source env/bin/activate
pip install cairo-nile
nile compile
```

