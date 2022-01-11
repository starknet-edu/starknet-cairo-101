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
- The tutorial's points are held in contract `0x00430530c613f9dd6aaf049ccee9f4a70b22b7de3515ed096cb6256e63f73090`. Click on "add token" in Argent X to get your points balance to show up there!

### Using voyager
For this tutorial we'll interact with our contracts through [Voyager](https://goerli.voyager.online/), StarkNet's block explorer. When looking for a contract / transaction, always make sure you are on the Goerli version of Voyager!
- Access your transactions with URL https://goerli.voyager.online/tx/your-tx-hash
- Access a contract with URL https://goerli.voyager.online/contract/your-contract-address
- Access read/write functions of the contract with the "read/write contract" tab in voyager

### Using decimals instead of hexadecimal
Voyager currently has issues dealing with hexadecimal values when writing values to contracts. 

For example, reading your points balance [through voyager](https://goerli.voyager.online/contract/0x00430530c613f9dd6aaf049ccee9f4a70b22b7de3515ed096cb6256e63f73090#readContract) currently does not work if you input your Argent X address as hexadecimal.

To overcome this limitation, always convert your hexadecimal value to decimal. I use [this website](https://www.rapidtables.com/convert/number/hex-to-decimal.html).

### Getting points
Each exercice is a separate smart contract. It contains code that, when executed properly, will distribute points to your address. Since there is no way currently to send a transaction easily through your account contract, you'll have to specify your address for each call.

Points are distributed by the function `distribute_points()` while the function `validate_exercice` records that you completed the exercice (you can get points only once). Your goal is to: 
- Read the code of the exercices in the current repo
- Find where the calls to `distribute_points()` are in the code
- Read the comments of the code to get further instructions if needed
- Manage to call the functions correctly through voyager to trigger it.

### Contract addresses 
- [Points counter ERC20](contracts/token/TDERC20.cairo):  [0x00430530c613f9dd6aaf049ccee9f4a70b22b7de3515ed096cb6256e63f73090](https://goerli.voyager.online/contract/0x00430530c613f9dd6aaf049ccee9f4a70b22b7de3515ed096cb6256e63f73090)
- [Ex01](contracts/ex01.cairo) : [0x000a03988e934a49d038c79bfb125a7560534790668da59004dfbe1e830c0ccc](https://goerli.voyager.online/contract/0x000a03988e934a49d038c79bfb125a7560534790668da59004dfbe1e830c0ccc)
- [Ex02](contracts/ex02.cairo) : [0x07178cfba3e5dfd3e017fefb0cefd900cfe41856a2ded4292bff0863c2ceb94a](https://goerli.voyager.online/contract/0x07178cfba3e5dfd3e017fefb0cefd900cfe41856a2ded4292bff0863c2ceb94a)
- [Ex03](contracts/ex03.cairo) : [0x01c061063d9c80a7a56512a1d7f321aab34d386ffaa99894e9785a93c1c5ee92](https://goerli.voyager.online/contract/0x01c061063d9c80a7a56512a1d7f321aab34d386ffaa99894e9785a93c1c5ee92)
- [Ex04](contracts/ex04.cairo) : [0x0558314dcae606ddab639461bfd02a69dfa44e0c0311190bf8e88199bcd151fd](https://goerli.voyager.online/contract/0x0558314dcae606ddab639461bfd02a69dfa44e0c0311190bf8e88199bcd151fd)
- [Ex05](contracts/ex05.cairo) : [0x02ef1e96d824e987b1159f3913fd4cd3ef915ddb771613a9ebf5b1fdc84c57f4](https://goerli.voyager.online/contract/0x02ef1e96d824e987b1159f3913fd4cd3ef915ddb771613a9ebf5b1fdc84c57f4)
- [Ex06](contracts/ex06.cairo) : [0x07528758a0335df21360103e220b3f032e2b5972c8db77606b6000da38042eef](https://goerli.voyager.online/contract/0x07528758a0335df21360103e220b3f032e2b5972c8db77606b6000da38042eef)
- [Ex07](contracts/ex07.cairo) : [0x070d10bc8cda284c76b19e5082f53dfc4edb44a07200c6acec3717d535b91d7b](https://goerli.voyager.online/contract/0x070d10bc8cda284c76b19e5082f53dfc4edb44a07200c6acec3717d535b91d7b)
- [Ex08](contracts/ex08.cairo) : [0x0314ead3158f33292d6eb2ddd01d444b7a145dcd6fa6074ae41dc712dec31c81](https://goerli.voyager.online/contract/0x0314ead3158f33292d6eb2ddd01d444b7a145dcd6fa6074ae41dc712dec31c81)
- [Ex09](contracts/ex09.cairo) : [0x071fc45e5e9fcd79414b480440cd6d4cb42d04a35bf519e575599987d28083e7](https://goerli.voyager.online/contract/0x071fc45e5e9fcd79414b480440cd6d4cb42d04a35bf519e575599987d28083e7)
- [Ex10](contracts/ex10.cairo) : [0x02d36957f8134e754ee26c3279497224a52a3abe5192ff44b71b50bcd8d24df6](https://goerli.voyager.online/contract/0x02d36957f8134e754ee26c3279497224a52a3abe5192ff44b71b50bcd8d24df6)
- [Ex11](contracts/ex11.cairo) : [0x05431a51559c425b82c1737afafc195da4d4686b66370e340ff812e25500e5b1](https://goerli.voyager.online/contract/0x05431a51559c425b82c1737afafc195da4d4686b66370e340ff812e25500e5b1)


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

