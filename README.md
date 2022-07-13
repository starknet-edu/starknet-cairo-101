# StarkNet Cairo 101

**Get started with Cairo with this simple tutorial.
Complete the puzzles/exercises, get tokens and learn about StarkNet smart contracts!**

## Introduction​

### Disclaimer

​Don't expect any benefit from using this other than learning some cool stuff about StarkNet, the first general-purpose validity rollup on the Ethereum Mainnnet.

​StarkNet is still in Alpha. This means that development is ongoing, and the paint is not dry everywhere. Things will get better, and in the meanwhile, we make things work with a bit of duct tape here and there!​

### How it works

​
**Complete the exercises and get tokens!**
This workshop is a set of smart contracts deployed on StarkNet Alpha on testnet. Each smart contract is an exercise/puzzle - which outlines a feature of the Cairo Smart contract language.

Completing the exercise will credit you with points in the form of an [ERC20 token](contracts/token/TDERC20.cairo).

​
This workshop focuses on *reading* Cairo code and StarkNet smart contracts to understand its syntax. You do not need to code or install anything on your machine to follow and complete it.​

​
It will take you some time in order to get started (doing the first two exercises) into the tutorial. Hang on! Once there, things will flow more easily. You're learning!​

### Where am I?

This workshop is the first in a series aimed at teaching how to build on StarkNet. Checkout out the following:

| Topic                                       | GitHub repo                                                                            |
| ------------------------------------------- | -------------------------------------------------------------------------------------- |
| Learn how to read Cairo code (you are here) | [Cairo 101](https://github.com/starknet-edu/starknet-cairo-101)                        |
| Deploy and customize an ERC721 NFT          | [StarkNet ERC721](https://github.com/starknet-edu/starknet-erc721)                     |
| Deploy and customize an ERC20 token         | [StarkNet ERC20](https://github.com/starknet-edu/starknet-erc20)                       |
| Build a cross layer application             | [StarkNet messaging bridge](https://github.com/starknet-edu/starknet-messaging-bridge) |
| Debug your Cairo contracts easily           | [StarkNet debug](https://github.com/starknet-edu/starknet-debug)                       |
| Design your own account contract            | [StarkNet account abstraction](https://github.com/starknet-edu/starknet-accounts)      |

### Providing feedback & getting help

Once you are done working on this tutorial, your feedback would be greatly appreciated!

**Please fill out [this form](https://forms.reform.app/starkware/untitled-form-4/kaes2e) to let us know what we can do to make it better.**

​
And if you struggle to move forward, do let us know! This workshop is meant to be as accessible as possible; we want to know if it's not the case.

​
Do you have a question? Join our [Discord server](https://discord.gg/5QetpWWPE5), register, and join channel #tutorials-support
​
Are you interested in following online workshops about learning how to dev on StarkNet? [Subscribe here](http://eepurl.com/hFnpQ5)

### Contributing

This project can be made better and will evolve as StarkNet matures. Your contributions are welcome! Here are things that you can do to help:

- Create a branch with a translation to your language
- Correct bugs if you find some
- Add an explanation in the comments of the exercise if you feel it needs more explanation
- Add exercises showcasing your favorite Cairo feature

### Languages

A mandarin version is available 中文版本请查看这里[here](https://github.com/starknet-edu/starknet-cairo-101/tree/mandarin).
​

## Getting started

### Creating a smart contract wallet

**To complete the tutorial you need to collect points.** These points will be owned by a smart contract wallet you need to deploy.

- The easiest way to set one up is to use Argent X ([download the chrome extension](https://chrome.google.com/webstore/detail/argent-x-starknet-wallet/dlcobpjiigpikoobohmabehhmhfoodbb/)  or  [check their repo](https://github.com/argentlabs/argent-x)) or Braavos ([download the chrome extension](https://chrome.google.com/webstore/detail/braavos-wallet/jnlgamecbpmbajjfhmmmlhejkemejdma)). These wallet solutions are similar to what Metamask is for Ethereum and allow users to initiate transactions and interact with applications on StarkNet.
- Follow the instructions to install the extension and deploy a smart contract account (it could take about 5 minutes to be deployed). Please note that in StarkNet there is only one type of accounts - smart contract accounts (this is called Account Abstraction), in contrast to Ethereum where there are wallets and smart contracts. In other words, every wallet on StarkNet is a smart contract and there is no distinction between them and other smart contracts. Therefore, to create a new wallet, you need to deploy a transaction that publishes your smart contract wallet to the network.
- Make sure you are on the Goerli testnet network.
- The tutorial's points are held in contract  `[0x61cc0eb883afd4e33b127b2443d2ea6dd5afb1d3584223f0017332296539d5b](https://goerli.voyager.online/contract/0x61cc0eb883afd4e33b127b2443d2ea6dd5afb1d3584223f0017332296539d5b)`. Click on "Add Token" in your installed wallet and the contract address to get your points balance to show up there! A new token called SC101 (starknet-cairo-101) will appear in your wallet.
- Connect [Voyager](https://voyager.online/) to your account smart contract. Voyager is the block explorer for StarkNet (the equivalent of Etherscan for Ethereum) and allows you to browse the state of the blockchain, view all transactions and their status. By connecting Voyager to your wallet, you will be able to broadcast your transactions through your wallet.
- To execute transactions on the Goerli StarkNet testnet **you'll need testnet ETH to pay for gas**. To get some, go to the [faucet](https://faucet.goerli.starknet.io/) and follow the instructions. It could take several minutes, but you should receive some L2 Goerli ETH in your wallet that you can use to execute transactions on the testnet.

### Solving exercices & Getting points​

​
**Each exercise is a separate smart contract.** It contains code that, when executed correctly, will distribute points to your address.
​
Points are distributed by the function `distribute_points()` while the function `validate_exercise` records that you completed the exercise (you can get points only once). Your goal is to:

![Graph](assets/diagram.png)
​
​

### Using Voyager

For this tutorial, we'll interact with our contracts through [Voyager](https://goerli.voyager.online/), StarkNet's block explorer. Please make sure to connect Voyager to your account contract! This will allow you to broadcast your transactions through your wallet.

When looking for a contract/transaction, always ensure you are on the Goerli version of Voyager!

- Access your transactions with a URL of the format: [https://goerli.voyager.online/tx/your-tx-hash](https://goerli.voyager.online/tx/your-tx-hash).
- Access a contract with a URL of the format: [https://goerli.voyager.online/contract/your-contract-address](https://goerli.voyager.online/contract/your-contract-address)
- Access read/write functions of the contract with the "read/write contract" tab in Voyager.

​
​

## Addresses of the exercises and contracts

| Topic                                 | Contract code                                         | Contract on Voyager                                                                                              |
| ------------------------------------- | ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| Points counter ERC20                  | [Points counter ERC20](contracts/token/TDERC20.cairo) | [Link](https://goerli.voyager.online/contract/0x61cc0eb883afd4e33b127b2443d2ea6dd5afb1d3584223f0017332296539d5b) |
| General syntax                        | [Ex01](contracts/ex01.cairo)                          | [Link](https://goerli.voyager.online/contract/0x384c3281df7a720cea37e211d7f23ed7d1b12a11f0c8921034ed3033c1b1676) |
| Storage variables, getters, asserts   | [Ex02](contracts/ex02.cairo)                          | [Link](https://goerli.voyager.online/contract/0x25c318c0ad58b30f6af6c7fa30d4a947c8d7a230fe163612a25f212024a0b9c) |
| Reading and writing storage variables | [Ex03](contracts/ex03.cairo)                          | [Link](https://goerli.voyager.online/contract/0x266e635b5e1a719c109da8c6812c758e0e92552f9667bbe9c9f7176024eb3b4) |
| Mappings                              | [Ex04](contracts/ex04.cairo)                          | [Link](https://goerli.voyager.online/contract/0x77d1f63c1fbaecb1e33a9863621d0433a49eb5812033f8d304f07f7efa799bd) |
| Variable visibility                   | [Ex05](contracts/ex05.cairo)                          | [Link](https://goerli.voyager.online/contract/0x3e548649388c31876036b67ac53c7241194c7f40d64b3d73e1b50565f21f3e6) |
| Functions visibility                  | [Ex06](contracts/ex06.cairo)                          | [Link](https://goerli.voyager.online/contract/0xb5a9527c0a633f974da1ea8762accbd483a5b983bbd07cdd78b695801edc4)   |
| Comparing values                      | [Ex07](contracts/ex07.cairo)                          | [Link](https://goerli.voyager.online/contract/0x82654cabc769e476af6b054c2d47998d932aa22ae0a0375d67bb8f5203b000)  |
| Recursions level 1                    | [Ex08](contracts/ex08.cairo)                          | [Link](https://goerli.voyager.online/contract/0x2c270b9e503e0713163a9931d4ea897d7ce04d8d43197c9af9de99673aa172f) |
| Recursions level 2                    | [Ex09](contracts/ex09.cairo)                          | [Link](https://goerli.voyager.online/contract/0xca4dcf8fc0660f946a47defac47d813aece0f988722db7f5c84caf88802fb1)  |
| Composability                         | [Ex10](contracts/ex10.cairo)                          | [Link](https://goerli.voyager.online/contract/0x18eb78aeff91b985f2404c80c1bfebef70aa553766492c098a7953b8527e38d) |
| Importing functions                   | [Ex11](contracts/ex11.cairo)                          | [Link](https://goerli.voyager.online/contract/0x1f3e5e931a62d73d214bb67007278d90778a6b70bddb03b16aa2191c5de9806) |
| Events                                | [Ex12](contracts/ex12.cairo)                          | [Link](https://goerli.voyager.online/contract/0x7538058548728450c04a305f6930d9145a18a4214463a12584769fc2b27dfed) |
| Privacy on StarkNet                   | [Ex13](contracts/ex13.cairo)                          | [Link](https://goerli.voyager.online/contract/0x120d24f5404b09262df3de09d46119beaf1a9ad2b35f7bfe674d8b61bd37447) |
| Multicall                             | [Ex14](contracts/ex14.cairo)                          | [Link](https://goerli.voyager.online/contract/0x4605d00942bfcae73f9841526440a47415ff0e5aa0aa58587055452d21d7e5f) |

### Counting your points

​
Your points will get credited in your installed wallet; though this may take some time. If you want to monitor your points count in real time, you can also see your balance in voyager!
​

- Go to the  [ERC20 counter](https://goerli.voyager.online/contract/0x61cc0eb883afd4e33b127b2443d2ea6dd5afb1d3584223f0017332296539d5b#readContract) in Voyager, in the "read contract" tab.
- Enter your address in the "balanceOf" function.

You can also check your overall progress [here](https://starknet-tutorials.vercel.app).
​

### Transaction status

​
You sent a transaction, and it is shown as "undetected" in Voyager? This can mean two things:
​

- Your transaction is pending and will be included in a block shortly. It will then be visible in Voyager.
- Your transaction was invalid and will NOT be included in a block (there is no such thing as a failed transaction in StarkNet).
​
You can (and should) check the status of your transaction with the following URL  [https://alpha4.starknet.io/feeder_gateway/get_transaction_receipt?transactionHash=](https://alpha4.starknet.io/feeder_gateway/get_transaction_receipt?transactionHash=), where you can append your transaction hash.
​
​

## Reusing this project

- Clone the repo on your machine.
- Set up the environment following [these instructions](https://starknet.io/docs/quickstart.html#quickstart).
- Install [Nile](https://github.com/OpenZeppelin/nile).
- Test that you can compile the project.

```
nile compile
```
