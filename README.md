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
- The tutorial's points are held in contract `0x014d8d1062be7fcee39931bc36678981e19ab4376ddb90b65f7a1b0768bf8457`. Click on "add token" in Argent X to get your points balance to show up there!

### Using voyager
For this tutorial we'll interact with our contracts through [Voyager](https://goerli.voyager.online/), StarkNet's block explorer. When looking for a contract / transaction, always make sure you are on the Goerli version of Voyager!
- Access your transactions with URL https://goerli.voyager.online/tx/<your tx hash>
- Access a contract with URL https://goerli.voyager.online/contract/<your contract address>
- Access read/write functions of the contract with the "read/write contract" tab in voyager

### Using decimals instead of hexadecimal
Voyager currently has issues dealing with hexadecimal values when writing values to contracts. 

For example, reading your points balance [through voyager](https://goerli.voyager.online/contract/0x014d8d1062be7fcee39931bc36678981e19ab4376ddb90b65f7a1b0768bf8457#readContract) currently does not work if you input your Argent X address as hexadecimal.

To overcome this limitation, always convert your hexadecimal value to decimal. I use [this website](https://www.rapidtables.com/convert/number/hex-to-decimal.html).

### Getting points
Each exercice is a separate smart contract. It contains code that, when executed properly, will distribute points to your address. Since there is no way currently to send a transaction easily through your account contract, you'll have to specify your address for each call.

Points are distributed by the function `distribute_points()` while the function `validate_exercice` records that you completed the exercice (you can get points only once). Your goal is to: 
- Read the code of the exercices in the current repo
- Find where the calls to `distribute_points()` are in the code
- Read the comments of the code to get further instructions if needed
- Manage to call the functions correctly to trigger it.

### Contract addresses 
[Points counter ERC20](contracts/token/TDERC20.cairo):  [0x014d8d1062be7fcee39931bc36678981e19ab4376ddb90b65f7a1b0768bf8457](https://goerli.voyager.online/contract/0x014d8d1062be7fcee39931bc36678981e19ab4376ddb90b65f7a1b0768bf8457)
[Ex01](contracts/ex01.cairo) : [0x00474e9eba95864f9a2745bc49c11b8c3c46a15d4c44934032aab796ca77eff7](https://goerli.voyager.online/contract/0x00474e9eba95864f9a2745bc49c11b8c3c46a15d4c44934032aab796ca77eff7)
[Ex02](contracts/ex02.cairo) : [0x0413333a44f4566f2fc9b771402dd283e7362b4c5ce8912dddc2f472564b96c2](https://goerli.voyager.online/contract/0x0413333a44f4566f2fc9b771402dd283e7362b4c5ce8912dddc2f472564b96c2)
[Ex03](contracts/ex03.cairo) : [0x07bca8f4f947a5e933026a41b7810bf395cd233310b5daefa834158c78bdd06f](https://goerli.voyager.online/contract/0x07bca8f4f947a5e933026a41b7810bf395cd233310b5daefa834158c78bdd06f)
[Ex04](contracts/ex04.cairo) : [0x020793c7a7f3800e86ed781a91b52bf54d57fbb994727ff9e3d5a83877fcea85](https://goerli.voyager.online/contract/0x020793c7a7f3800e86ed781a91b52bf54d57fbb994727ff9e3d5a83877fcea85)
[Ex05](contracts/ex05.cairo) : [0x01469176d66b0c2231e245457844774e4ea450878f405fd5462499200e206f1b](https://goerli.voyager.online/contract/0x01469176d66b0c2231e245457844774e4ea450878f405fd5462499200e206f1b)
[Ex06](contracts/ex06.cairo) : [0x01867f305fda8f77c99125203c3b3b60af55876259c52a09730f3b9735151ff8](https://goerli.voyager.online/contract/0x01867f305fda8f77c99125203c3b3b60af55876259c52a09730f3b9735151ff8)
[Ex07](contracts/ex07.cairo) : [0x065954cb7f21e1c54bef36d4f7e75a4812a56ef33b1976e647cdea183a816a96](https://goerli.voyager.online/contract/0x065954cb7f21e1c54bef36d4f7e75a4812a56ef33b1976e647cdea183a816a96)
[Ex08](contracts/ex08.cairo) : [0x06baca2e4a5f08bf534138eb6fd8eea26c91886b5192c93db5a0cf256af9f611](https://goerli.voyager.online/contract/0x06baca2e4a5f08bf534138eb6fd8eea26c91886b5192c93db5a0cf256af9f611)


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

