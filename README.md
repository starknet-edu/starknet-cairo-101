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

|Topic|GitHub repo|
|---|---|
|Learn how to read Cairo code (you are here)|[Cairo 101](https://github.com/starknet-edu/starknet-cairo-101)|
|Deploy and customize an ERC721 NFT|[StarkNet ERC721](https://github.com/starknet-edu/starknet-erc721)|
|Deploy and customize an ERC20 token|[StarkNet ERC20](https://github.com/starknet-edu/starknet-erc20)|
|Build a cross layer application|[StarkNet messaging bridge](https://github.com/starknet-edu/starknet-messaging-bridge)|
|Debug your Cairo contracts easily|[StarkNet debug](https://github.com/starknet-edu/starknet-debug)|
|Design your own account contract|[StarkNet account abstraction](https://github.com/starknet-edu/starknet-accounts)|


### Providing feedback & getting help

Once you are done working on this tutorial, your feedback would be greatly appreciated!

**Please fill out [this form](https://forms.reform.app/starkware/untitled-form-4/kaes2e) to let us know what we can do to make it better.**

​
And if you struggle to move forward, do let us know! This workshop is meant to be as accessible as possible; we want to know if it's not the case.

​
Do you have a question? Join our [Discord server](https://discord.gg/79fS9UcxHZ), register, and join channel #tutorials-support
​

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
- The tutorial's points are held in contract  `[0x074002c7df47096f490a1a89b086b8a468f2e7c686e04a024d93b7c59f934f83](https://goerli.voyager.online/contract/0x074002c7df47096f490a1a89b086b8a468f2e7c686e04a024d93b7c59f934f83)`. Click on "Add Token" in your installed wallet and the contract address to get your points balance to show up there! A new token called SC101 (starknet-cairo-101) will appear in your wallet.
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


|Topic|Contract code|Contract on Voyager|
|---|---|---|
|Points counter ERC20|[Points counter ERC20](contracts/token/TDERC20.cairo)|[Link](https://goerli.voyager.online/contract/0x074002c7df47096f490a1a89b086b8a468f2e7c686e04a024d93b7c59f934f83)|
|General syntax|[Ex01](contracts/ex01.cairo)|[Link](https://goerli.voyager.online/contract/0x04b9b3cea3d4b21f7f272a26cf0d54f40348a9d8509f951b217e33d4e9c80af2)|
|Storage variables, getters, asserts|[Ex02](contracts/ex02.cairo)|[Link](https://goerli.voyager.online/contract/0x06511a41c0620d756ff9e3c6b27d5aea2d9b65e162abdec72c4d746c0a1aca05)|
|Reading and writing storage variables|[Ex03](contracts/ex03.cairo)|[Link](https://goerli.voyager.online/contract/0x044a68c9052a5208a46aee5d0af6f6a3e30686ab9ce3e852c4b817d0a76f2f09)|
|Mappings|[Ex04](contracts/ex04.cairo)|[Link](https://goerli.voyager.online/contract/0x04e701814214c5d82215a134c31029986b0d05a2592c0c977fe2330263dc7304)|
|Variable visibility|[Ex05](contracts/ex05.cairo)|[Link](https://goerli.voyager.online/contract/0x01e7285636d7d147df6e2eacb044611e13ce79048c4ac21d0209c8c923108975)|
|Functions visibility|[Ex06](contracts/ex06.cairo)|[Link](https://goerli.voyager.online/contract/0x02abaa69541bd4630225cd69fa87d08a6e8fb80f4c7c2e8d3568fa59e71eec26)|
|Comparing values|[Ex07](contracts/ex07.cairo)|[Link](https://goerli.voyager.online/contract/0x07d9f4f818592b7a97f2c7e5915733ed022f96313cb61bde2c27a9fbd729a5a4)|
|Recursions level 1|[Ex08](contracts/ex08.cairo)|[Link](https://goerli.voyager.online/contract/0x072d42eb599c9ec14d1f7209223226cb1436898c6930480c6a2f6998c6ceb9fe)|
|Recursions level 2|[Ex09](contracts/ex09.cairo)|[Link](https://goerli.voyager.online/contract/0x035203b6c0b68ef87127a7d77f36de4279ceb79ea2d8099f854f51fc28074de4)|
|Composability|[Ex10](contracts/ex10.cairo)|[Link](https://goerli.voyager.online/contract/0x071e59fbd7e724b94ad1f6d4bba1ff7161a834c6b19c4b88719ad640d5a6105c)|
|Importing functions|[Ex11](contracts/ex11.cairo)|[Link](https://goerli.voyager.online/contract/0x06e124eba8dcf1ebe207d6adb366193511373801b49742b39ace5c868b795e68)|
|Events|[Ex12](contracts/ex12.cairo)|[Link](https://goerli.voyager.online/contract/0x0658e159d61d4428b6d5fa90aa20083786674c49a645fe416fc4c35b145f8a83)|
|Privacy on StarkNet|[Ex13](contracts/ex13.cairo)|[Link](https://goerli.voyager.online/contract/0x07b271402ce18e1bcc1b64f555cdc23693b0eb091d71644f72b6c220814c1425)|

### Counting your points

​
Your points will get credited in your installed wallet; though this may take some time. If you want to monitor your points count in real time, you can also see your balance in voyager!
​

- Go to the  [ERC20 counter](https://goerli.voyager.online/contract/0x074002c7df47096f490a1a89b086b8a468f2e7c686e04a024d93b7c59f934f83#readContract) in Voyager, in the "read contract" tab.
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
