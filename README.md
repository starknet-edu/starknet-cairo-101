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
- The tutorial's points are held in contract `0x0787863b321f439cd1f6b477540cc3b5611905842843649d79d7fd3f2031704c`. Click on "add token" in Argent X to get your points balance to show up there!

### Using voyager
For this tutorial we'll interact with our contracts through [Voyager](https://goerli.voyager.online/), StarkNet's block explorer. When looking for a contract / transaction, always make sure you are on the Goerli version of Voyager!
- Access your transactions with URL https://goerli.voyager.online/tx/your-tx-hash
- Access a contract with URL https://goerli.voyager.online/contract/your-contract-address
- Access read/write functions of the contract with the "read/write contract" tab in voyager

### Using decimals instead of hexadecimal
Voyager currently has issues dealing with hexadecimal values when writing values to contracts. 

For example, reading your points balance [through voyager](https://goerli.voyager.online/contract/0x0787863b321f439cd1f6b477540cc3b5611905842843649d79d7fd3f2031704c#readContract) currently does not work if you input your Argent X address as hexadecimal.

To overcome this limitation, always convert your hexadecimal value to decimal. I use [this website](https://www.rapidtables.com/convert/number/hex-to-decimal.html).

### Getting points
Each exercice is a separate smart contract. It contains code that, when executed properly, will distribute points to your address. Since there is no way currently to send a transaction easily through your account contract, you'll have to specify your address for each call.

Points are distributed by the function `distribute_points()` while the function `validate_exercice` records that you completed the exercice (you can get points only once). Your goal is to: 
- Read the code of the exercices in the current repo
- Find where the calls to `distribute_points()` are in the code
- Read the comments of the code to get further instructions if needed
- Manage to call the functions correctly to trigger it.

### Contract addresses 
[Points counter ERC20](contracts/token/TDERC20.cairo):  [0x0787863b321f439cd1f6b477540cc3b5611905842843649d79d7fd3f2031704c](https://goerli.voyager.online/contract/0x0787863b321f439cd1f6b477540cc3b5611905842843649d79d7fd3f2031704c)
[Ex01](contracts/ex01.cairo) : [0x055f2b023cd75378fa31dc9be3069724ecb9c68901f2adf96548343e7d9b0a37](https://goerli.voyager.online/contract/0x055f2b023cd75378fa31dc9be3069724ecb9c68901f2adf96548343e7d9b0a37)
[Ex02](contracts/ex02.cairo) : [0x020aeb6768fd9f41af0f8a5a9ab0b37cc196ea94db981c9ed9bc4dadc70f1361](https://goerli.voyager.online/contract/0x020aeb6768fd9f41af0f8a5a9ab0b37cc196ea94db981c9ed9bc4dadc70f1361)
[Ex03](contracts/ex03.cairo) : [0x014864bb0bfdf3ec097f5a10d7c3757dda9badd07d882dbdaf0326c059deeb86](https://goerli.voyager.online/contract/0x014864bb0bfdf3ec097f5a10d7c3757dda9badd07d882dbdaf0326c059deeb86)
[Ex04](contracts/ex04.cairo) : [0x01d2e241f121e517f8c61d3d3cc57921169a5648077c1f8eb1562eb09994e1a5](https://goerli.voyager.online/contract/0x01d2e241f121e517f8c61d3d3cc57921169a5648077c1f8eb1562eb09994e1a5)
[Ex05](contracts/ex05.cairo) : [0x036479a8fcb4013cef302c9d9570f568a0d6da76ed40e2e3a1dc7ec4d1572af1](https://goerli.voyager.online/contract/0x036479a8fcb4013cef302c9d9570f568a0d6da76ed40e2e3a1dc7ec4d1572af1)
[Ex06](contracts/ex06.cairo) : [0x03417923cfc61dc399c45330c2637f9cc1bd427669c1515d0b0d6129cac87e48](https://goerli.voyager.online/contract/0x03417923cfc61dc399c45330c2637f9cc1bd427669c1515d0b0d6129cac87e48)
[Ex07](contracts/ex07.cairo) : [0x0473f4831661b995db03f9a43eb91937a0e26c41ad134a1f64a31ccf7b9891a8](https://goerli.voyager.online/contract/0x0473f4831661b995db03f9a43eb91937a0e26c41ad134a1f64a31ccf7b9891a8)
[Ex08](contracts/ex08.cairo) : [0x03ddefd7c3109a0de4c270054ea40d5b51a96347284bab35c1d4957c58f8d458](https://goerli.voyager.online/contract/0x03ddefd7c3109a0de4c270054ea40d5b51a96347284bab35c1d4957c58f8d458)


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

