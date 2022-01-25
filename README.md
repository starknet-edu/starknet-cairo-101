# StarkNet Cairo 101
**Get started with Cairo with this simple tutorial. 
Complete the puzzles/exercises, get tokens and learn about StarkNet smart contracts!**
​
## Introduction
### Disclaimer
​
Don't expect any kind of benefit from using this, other than learning a bunch of cool stuff about StarkNet, the first general purpose validity rollup on the Ethereum Mainnnet.
​
StarkNet is still in Alpha. This means that development is ongoing, and the paint is not dry everywhere. Things will get better, and in the meanwhile, we make things work with a bit of duct tape here and there!
​
## How it works
​
**Complete the exercises and get tokens!**
This workshop is a set of smart contracts deployed on StarkNet Alpha on testnet. 
Each smart contract is an exercice/puzzle - which outlines a feature of the Cairo Smart contract language. 
Completing the exercice will credit you with points, in the form of an [ERC20 token](contracts/token/TDERC20.cairo).
​
This workshop focuses on *reading* Cairo code and StarkNet smart contracts, in order to understand its syntax. 
You do not need to code or install anything on your machine in order to follow and complete it. 
​
Getting started (doing the first two exercises) will take you some time, in order to get into the tutorial. Hang on! Once there, things will flow more easily. You're learning!
​
This workshop is the first in a serie that will cover broad smart contract concepts (writing and deploying ERC20/ERC721, bridging assets, L1 <-> L2 messaging...). 
Interested in helping writing those? [Reach out](https://twitter.com/HenriLieutaud)!
​
### Providing feedback
Once you are done working on this tutorial, your feedback would be greatly appreciated! 
**Please fill [this form](https://forms.reform.app/starkware/untitled-form-4/kaes2e) to let us know what we can do to make it better.** 
​
And if you struggle to move forward, do let us know! This workshop is meant to be as accessible as possible; we want to know if it's not the case.
​
Do you have a question? Join our [Discord server](https://discord.gg/YHz7drT3), register and join channel #tutorials-support
​
## Getting started
​
### Creating an account contract
**In order to complete the tutorial you need to collect points.** These points will be owned by a smart contract wallet, that you need to deploy.
-   The easiest way to set one up is currently to use Argent X ([download the chrome extension](https://chrome.google.com/webstore/detail/argent-x-starknet-wallet/dlcobpjiigpikoobohmabehhmhfoodbb/)  or  [check their repo](https://github.com/argentlabs/argent-x)).
-   Follow the instructions to install the extension and deploy an account contract
-   Make sure you are on the Goerli testnet network
-   The tutorial's points are held in contract  `0x07e8ddf3b76d9ed6367ad73bdfceb9f1ea242c26ed9f531af86e18fdd97febf7`. Click on "add token" in Argent X to get your points balance to show up there!
​
### Using voyager
For this tutorial we'll interact with our contracts through [Voyager](https://goerli.voyager.online/), StarkNet's block explorer. 
When looking for a contract / transaction, always make sure you are on the Goerli version of Voyager!
-   Access your transactions with URL  [https://goerli.voyager.online/tx/your-tx-hash](https://goerli.voyager.online/tx/your-tx-hash)
-   Access a contract with URL  [https://goerli.voyager.online/contract/your-contract-address](https://goerli.voyager.online/contract/your-contract-address)
-   Access read/write functions of the contract with the "read/write contract" tab in voyager
​
### Getting points
​
​
**Each exercice is a separate smart contract.** It contains code that, when executed properly, will distribute points to your address. Since there is no way currently to send a transaction easily through your account contract, you'll have to specify your address for each call.
​
Points are distributed by the function `distribute_points()` while the function `validate_exercice` records that you completed the exercice (you can get points only once). Your goal is to: 

![Graph](assets/diagram.png)
​
​
​
### Checking your progress
​
#### Counting your points
​
Your points will get credited in Argent X; though this may take some time. If you want to monitor your points count in real time, you can also see your balance in voyager!
​
-   Go to the  [ERC20 counter](https://goerli.voyager.online/contract/0x07e8ddf3b76d9ed6367ad73bdfceb9f1ea242c26ed9f531af86e18fdd97febf7#readContract)  in voyager, in the "read contract" tab
-   Enter your address in decimal in the "balanceOf" function
​
#### Transaction status
​
You sent a transaction, and it is shown as "undetected" in voyager? This can mean two things:
​
-   Your transaction is pending, and will be included in a block shortly. It will then be visible in voyager.
-   Your transaction was invalid, and will NOT be included in a block (there is no such thing as a failed transaction in StarkNet).
​
You can (and should) check the status of your transaction with the following URL  [https://alpha4.starknet.io/feeder_gateway/get_transaction_receipt?transactionHash=](https://alpha4.starknet.io/feeder_gateway/get_transaction_receipt?transactionHash=)  , where you can append your transaction hash.
​
### Exercises & Contract addresses 
### Contract addresses 
|Topic|Contract code|Contract on voyager|
|---|---|---|
|Points counter ERC20|[Points counter ERC20](contracts/token/TDERC20.cairo)|[Link](https://goerli.voyager.online/contract/0x07e8ddf3b76d9ed6367ad73bdfceb9f1ea242c26ed9f531af86e18fdd97febf7)|
|General syntax|[Ex01](contracts/ex01.cairo)|[Link](https://goerli.voyager.online/contract/0x000e49f618cfe176bb495ca17152d8b8817582f5b60bc0434381922ab34dd326)|
|Storage variables, getters, asserts|[Ex02](contracts/ex02.cairo)|[Link](https://goerli.voyager.online/contract/0x03675817f3e5c3eeaefba6e64276da3287800921cd06764e331a6ce66c8fc3fa)|
|Reading and writing storage variables|[Ex03](contracts/ex03.cairo)|[Link](https://goerli.voyager.online/contract/0x051e98b40301139204f5411706c222a65512dcb7f61880520e65d0fe6e87ec26)|
|Mappings|[Ex04](contracts/ex04.cairo)|[Link](https://goerli.voyager.online/contract/0x0037c28654a4b27a19520643e4fef1d7cf1f0ed5e1359dc51830807ffb0a7bc8)|
|Variable visibility|[Ex05](contracts/ex05.cairo)|[Link](https://goerli.voyager.online/contract/0x03b51051fe054a3a16cacbdc1f8abb15c222d99f8ff7b4cca0313eaae7d70583)|
|Functions visibility|[Ex06](contracts/ex06.cairo)|[Link](https://goerli.voyager.online/contract/0x0504bb1ab12a068071c2502d6e9f3e186a42a9267a9a09898feca7874b61123f)|
|Comparing values|[Ex07](contracts/ex07.cairo)|[Link](https://goerli.voyager.online/contract/0x0304ddd8c3c86ffe83d01673139b7ba637c6190e2a341630bbeda2e387c86474)|
|Recursions level 1|[Ex08](contracts/ex08.cairo)|[Link](https://goerli.voyager.online/contract/0x0621856bf10e84e7234ed3dca758bc160ba5784fd95db179f50d40402d02552e)|
|Recursions level 2|[Ex09](contracts/ex09.cairo)|[Link](https://goerli.voyager.online/contract/0x04805edfa65f6cc1fc26d92f3fb09969c739605235a8540f3a5f58045415fe3e)|
|Composability|[Ex10](contracts/ex10.cairo)|[Link](https://goerli.voyager.online/contract/0x00faa4d8ca3505e58a12b36f84b0df79157dc1d00a440fa062279ef43c6ce388)|
|Importing functions|[Ex11](contracts/ex11.cairo)|[Link](https://goerli.voyager.online/contract/0x058aae6966b49a3d947a94d81d55a1fb56a62c0874df4b737944c0e42c81af55)|

​
​
## Contributing
### Help is welcome!
This project can be made better, and will evolve in the coming weeks. Your contributions are welcome! Here are things that you can do to help:
- Correct bugs if you find some
- Add explanation in the comments of the exercice if you feel it needs more explanation
- Add exercices showcasing your favorite Cairo feature
​
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