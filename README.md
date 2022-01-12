# StarkNet Cairo 101
Get started with Cairo with this simple tutorial. Complete the puzzles, get points and learn about StarkNet smart contracts!

## Introduction
### Disclaimer
Don't expect any kind of benefit from using this, other than learning a bunch of cool stuff about StarNet, the first general purpose validity rollup on the Ethereum Mainnnet. 

StarkNet is still in Alpha. This means that develpment is ongoing, and the paint is not dry everywhere. Things will get better, and in the meanwhile, we make things work with a bit of duct tape here and there!

### How it works
This workshop is a set of smart contracts deployed on StarkNet Alpha on testnet. Each smart contract is an exercice/puzzle; each one outlines a feature of the Cairo Smart contract language. Completing the exercice will credit you with points, in the form of an [ERC20 token](contracts/token/TDERC20.cairo).

This workshop focuses on *reading* Cairo code and StarkNet smart contracts, in order to understand its syntax. You don't need to code or install anything on your machine in order to follow and complete it. Getting started (doing the first two exercises) will take you some time, in order to get into the tutorial. Hang on! Once there, things will flow more easily. You're learning!

This workshop is the first in a serie that will cover broad smart contract concepts (writing and deploying ERC20/ERC721, bridging assets, L1 <-> L2 messaging...). 
Interested in helping writing those? [Reach out](https://twitter.com/HenriLieutaud)!

### Providing feedback
Once you are done working on this tutorial, your feedback would be greatly appreciated! Please fill [this form](https://forms.reform.app/starkware/untitled-form-4/kaes2e) to let us know what we can do to make it better. And if you struggle to move forward, do let us know! This workshop is meant to be as accessible as possible; we want to know if it's not the case.

## Getting started
### What will change soon
- As of 05/01/2021, transactions in StarkNet can still be done without an account contract. This tutorial currently leverages this possibility. Once account contracts become more widespread and usable, it will change to reflect that.
- Voyager struggles with hexadecimal / decimal conversion. For now, you should input all your value in voyager in the decimal format

### Creating an account contract
In order to complete the tutorial you need to collect points. These points will be owned by a smart contract wallet, that you need to deploy.
- The easiest way to set one up is currently to use Argent X([download the chrome extension](https://chrome.google.com/webstore/detail/argent-x-starknet-wallet/dlcobpjiigpikoobohmabehhmhfoodbb/) or [check their repo](https://github.com/argentlabs/argent-x). 
- Follow the instructions to install the extension and deploy an account contract 
- Make sure you are on the Goerli testnet network
- The tutorial's points are held in contract `0x0555750f277a7abd2d7abf4c16806554bd750eb26d87ce58c6cb13b2158dcbc1`. Click on "add token" in Argent X to get your points balance to show up there!

### Using voyager
For this tutorial we'll interact with our contracts through [Voyager](https://goerli.voyager.online/), StarkNet's block explorer. When looking for a contract / transaction, always make sure you are on the Goerli version of Voyager!
- Access your transactions with URL https://goerli.voyager.online/tx/your-tx-hash
- Access a contract with URL https://goerli.voyager.online/contract/your-contract-address
- Access read/write functions of the contract with the "read/write contract" tab in voyager

### Using decimals instead of hexadecimal
Voyager currently has issues dealing with hexadecimal values when writing values to contracts. 

For example, reading your points balance [through voyager](https://goerli.voyager.online/contract/0x0555750f277a7abd2d7abf4c16806554bd750eb26d87ce58c6cb13b2158dcbc1#readContract) currently does not work if you input your Argent X address as hexadecimal.

To overcome this limitation, always convert your hexadecimal value to decimal. I use [this website](https://www.rapidtables.com/convert/number/hex-to-decimal.html).

### Getting points
Each exercice is a separate smart contract. It contains code that, when executed properly, will distribute points to your address. Since there is no way currently to send a transaction easily through your account contract, you'll have to specify your address for each call.

Points are distributed by the function `distribute_points()` while the function `validate_exercice` records that you completed the exercice (you can get points only once). Your goal is to: 
- Read the code of the exercices in the current repo
- Find where the calls to `distribute_points()` are in the code
- Read the comments of the code to get further instructions if needed
- Manage to call the functions correctly through voyager to trigger it.

### Checking your progress
#### Counting your points
Your points will get credited in Argent X; though this make take so time. If you want to monitor your points count in real time, you can also see your balance in voyager!
- Go to the [ERC20 counter](https://goerli.voyager.online/contract/0x0555750f277a7abd2d7abf4c16806554bd750eb26d87ce58c6cb13b2158dcbc1#readContract) in voyager, in the "read contract" tab 
- Enter your address in decimal in the "balanceOf" function

#### Transaction status
You sent a transaction, and it is shown as "undected" in voyager? This can mean two things:
- Your transaction is pending, and will be included in a block shortly. It will then be visible in voyager.
- Your transaction was invalid, and will NOT be included in a block (there is no such thing as a failed transaction in StarkNet). 

You can (and should) check the status of your transaction with the following URL [https://alpha4.starknet.io/feeder_gateway/get_transaction_receipt?transactionHash=](https://alpha4.starknet.io/feeder_gateway/get_transaction_receipt?transactionHash=) , where you can append your transaction hash.

### Contract addresses 
|Topic|Contract code|Contract on voyager|
|---|---|---|
|Points counter ERC20|[Points counter ERC20](contracts/token/TDERC20.cairo)|[Link](https://goerli.voyager.online/contract/0x0555750f277a7abd2d7abf4c16806554bd750eb26d87ce58c6cb13b2158dcbc1)|
|General syntax|[Ex01](contracts/ex01.cairo)|[Link](https://goerli.voyager.online/contract/0x00e51aba7c075e73fb8c62d02e6bd084ecc5162b70316707b6bc4fbd7de84d26)|
|Storage variables, getters, asserts|[Ex02](contracts/ex02.cairo)|[Link](https://goerli.voyager.online/contract/0x045603e670f950536042455059aa88c0f117d70091335e5bd18fbda42e9a27f2)|
|Reading and writing storage variables|[Ex03](contracts/ex03.cairo)|[Link](https://goerli.voyager.online/contract/0x079deb261ed19741ee0d87133ffcebcb4cd4d3f49ebcaa530f5d950d0aecd26d)|
|Mappings|[Ex04](contracts/ex04.cairo)|[Link](https://goerli.voyager.online/contract/0x05e0140f480598a50fb8746011f64c25445098f2b5de359f28fe0acd764702de)|
|Variable visibility|[Ex05](contracts/ex05.cairo)|[Link](https://goerli.voyager.online/contract/0x03c13f6e459c1b8a1bbc66ed2ba2d8b1f921e108a9125fb758147dca2e6caf0d)|
|Functions visibility|[Ex06](contracts/ex06.cairo)|[Link](https://goerli.voyager.online/contract/0x039e0f58dbde8402613a722e57991378b4017c836b5410d4c1c7056f6150c8d6)|
|Comparing values|[Ex07](contracts/ex07.cairo)|[Link](https://goerli.voyager.online/contract/0x052641f456d11695af61ad9e87330c058dafeb6964ba10e2cb2ba60c55eaf80b)|
|Recursions level 1|[Ex08](contracts/ex08.cairo)|[Link](https://goerli.voyager.online/contract/0x02e70ac39b319829fd3012cd6e78106be820c3dd248ea1c04b4be6017c83f455)|
|Recursions level 2|[Ex09](contracts/ex09.cairo)|[Link](https://goerli.voyager.online/contract/0x070be3bf6ff173ed0f5eb1e606a2741e6ac0ad6e8097cad314a0f875232c6fcc)|
|Composability|[Ex10](contracts/ex10.cairo)|[Link](https://goerli.voyager.online/contract/0x062387032afe8d919c3f616b2efbf4cba1939daf2fccf349cc9a8df51c1a6063)|
|Importing functions|[Ex11](contracts/ex11.cairo)|[Link](https://goerli.voyager.online/contract/0x04fb9a9ec6b45c165d86e8861f653728b5dafec809ed248496e4074ec08c3f93)|


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

