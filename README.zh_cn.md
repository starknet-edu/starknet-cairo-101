# StarkNet Cairo 101

**通过这个简单的教程开始使用 Cairo 语言。
完成下面的练习，获得代币并学习StarkNet智能合约！**

## 介绍​

### 免责声明

​除了学习一些关于 StarkNet 的很酷的东西之外，不要指望使用它有任何好处，StarkNet 是以太坊主网上的第一个通用有效的rollup网络。

​StarkNet 仍处于 Alpha 阶段。这意味着开发正在进行中，并且油漆并非处处干燥。事情会变得更好，与此同时，我们在这里和那里使用一些胶带来让事情正常进行！​

### 这个练习是如何进行的

​
**完成练习并获得代币奖励!**
这些课程是一组部署在测试网上 StarkNet Alpha 上的智能合约。每个智能合约都是一个练习/谜题——它概述了 Cairo 智能合约语言的一个特征。
完成练习将以[ERC20 代币](contracts/token/TDERC20.cairo) 的形式给你积分。

​
本次研讨会的重点是*阅读* Cairo 代码和 StarkNet 智能合约以了解其语法。您不需要在您的机器上编写代码或安装任何东西来跟随并完成它。​

​
您需要一些时间才能开始（完成前两个练习）进入教程。不挂断！一旦到了那里，事情就会更容易流动。你在学习！​

### 我在哪里?

本次课程是旨在教授如何在 StarkNet 上构建的系列中的第一个。检查以下内容：

| Topic                                       | GitHub repo                                                                            |
| ------------------------------------------- | -------------------------------------------------------------------------------------- |
| 学习如何阅读开罗代码（你在这里）              | [Cairo 101](https://github.com/starknet-edu/starknet-cairo-101)                        |
| 部署和定制 ERC721 NFT                        | [StarkNet ERC721](https://github.com/starknet-edu/starknet-erc721)                     |
| 部署和自定义 ERC20 令牌                      | [StarkNet ERC20](https://github.com/starknet-edu/starknet-erc20)                       |
| 构建跨层应用                                 | [StarkNet messaging bridge](https://github.com/starknet-edu/starknet-messaging-bridge) |
| 轻松调试您的 cairo合约                       | [StarkNet debug](https://github.com/starknet-edu/starknet-debug)                       |
| 设计您自己的账户合约                         | [StarkNet account abstraction](https://github.com/starknet-edu/starknet-accounts)      |

### 提供反馈并获得帮助

完成本教程后，我们将不胜感激您的反馈！

**请填写[此表格](https://forms.reform.app/starkware/untitled-form-4/kaes2e) 让我们知道我们可以做些什么来让它变得更好。**

​
如果您努力前进，请告诉我们！该研讨会旨在尽可能方便；我们想知道情况是否如此。

​
你有问题吗？加入我们的 [Discord 服务器](https://starknet.io/discord)，注册并加入频道#tutorials-support。

您是否有兴趣参加有关学习如何在 StarkNet 上进行开发的在线研讨会？ [在这里订阅](http://eepurl.com/hFnpQ5)。

### 贡献项目

这个项目可以做得更好，并将随着 StarkNet 的成熟而发展。欢迎您的贡献！以下是您可以提供帮助的事情：

- 创建一个翻译成您的语言的分支。
- 如果发现一些错误，请更正错误。
- 如果您觉得需要更多解释，请在练习的评论中添加解释。
- 添加练习以展示您最喜欢的开罗功能。

### 语言

- [此处](https://github.com/starknet-edu/starknet-cairo-101/tree/spanish) 提供西班牙语版本。
- [此处](./README.pt.md) 提供葡萄牙语版本。
- [此处](./README.kr.md) 提供韩语版本。

## 让我们开始

### 创建一个智能合约钱包

**要完成本教程，您需要收集积分。** 这些积分将由您需要部署的智能合约钱包拥有。

- 最简单的设置方法是使用 Argent X（[下载 chrome 扩展](https://chrome.google.com/webstore/detail/argent-x-starknet-wallet/dlcobpjiigpikoobohmabehhmhfoodbb/) 或 [检查他们的回购协议](https://github.com/argentlabs/argent-x)) 或 Braavos（[下载 chrome 扩展程序](https://chrome.google.com/webstore/detail/braavos-wallet/jnlgamecbpmbbajjfhmmmlhejkemejdma)）。这些钱包解决方案类似于 Ethereum 的 Metamask，允许用户发起交易并与 StarkNet 上的应用程序交互。
- 按照说明安装扩展并部署智能合约帐户（部署大约需要 5 分钟）。请注意，在 StarkNet 中只有一种类型的账户——智能合约账户（这称为账户抽象），而以太坊则有钱包和智能合约。也就是说，StarkNet 上的每一个钱包都是一个智能合约，与其他智能合约没有区别。因此，要创建一个新钱包，您需要部署一个将您的智能合约钱包发布到网络的交易。
- 确保你在 Goerli testnet 网络上。
- 教程的积分代币使用这个合约  `0x5c6b1379f1d4c8a4f5db781a706b63a885f3f9570f7863629e99e2342ac344c` ([Starkscan link](https://testnet.starkscan.co/contract/0x05c6b1379f1d4c8a4f5db781a706b63a885f3f9570f7863629e99e2342ac344c), [Voyager link](https://goerli.voyager.online/contract/0x5c6b1379f1d4c8a4f5db781a706b63a885f3f9570f7863629e99e2342ac344c)).
- 在您安装的钱包和合约地址中点击“添加令牌”，让您的积分余额显示在那里！一个名为 SC101 (starknet-cairo-101) 的新代币将出现在您的钱包中。
- 将区块浏览器（[Starkscan](https://testnet.starkscan.co/) 或 [Voyager](https://goerli.voyager.online/)）连接到您的账户智能合约。这些是 StarkNet 的区块浏览器（相当于以太坊的 Etherscan），允许您浏览区块链的状态，查看所有交易及其状态。通过将区块浏览器连接到您的钱包，您将能够通过您的钱包广播您的交易。
- 要在 Goerli StarkNet 测试网上执行交易**您需要测试网 ETH 来支付 gas**。要获得一些，请转到 [水龙头](https://faucet.goerli.starknet.io/) 并按照说明进行操作。这可能需要几分钟时间，但您的钱包中应该会收到一些 L2 Goerli ETH，您可以使用它们在测试网上执行交易。
### 解答练习和获得积分​

​
**每个练习都是一个单独的智能合约。**它包含的代码在正确执行时会将积分分配到您的地址。
​
积分由函数 distribute_points() 分配，而函数 validate_exercise 记录你完成了练习（你只能获得一次积分）。
​
你的目标是：阅读练习的内容-->跟随说明-->阅读注释-->调用指定的函数。

![Graph](assets/diagram.png)
​
​

### 使用区块链浏览器

在本教程中，我们将通过 StarkNet 的区块浏览器 [Starkscan](https://testnet.starkscan.co/) 或 [Voyager](https://goerli.voyager.online/) 与我们的合约进行交互。请确保将区块浏览器连接到您的账户合约！这将允许您通过钱包广播您的交易。

在查找合约/交易时，请始终确保您使用的是 Goerli 版本的区块浏览器！

- 使用以下格式的 URL 访问您的交易：
  - [https://testnet.starkscan.co/tx/你的交易哈希](https://testnet.starkscan.co/tx/你的交易哈希)
  - [https://goerli.voyager.online/tx/你的交易哈希](https://goerli.voyager.online/tx/你的交易哈希)
- 使用以下格式的 URL 访问您的合约：
  - [https://testnet.starkscan.co/contract/你的合约地址](https://testnet.starkscan.co/contract/你的合约地址)
  - [https://goerli.voyager.online/contract/你的合约地址](https://goerli.voyager.online/contract/你的合约地址)
- 使用区块浏览器中的“读/写合约”选项卡访问合约的读/写功能。

​
​

## 练习和合约的地址

| 题目                                 | 合约的代码                                         | 使用 Starkscan 查看合约                                                                                            | 使用Voyager 查看合约                                                                                              |
| ------------------------------------- | ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| 积分计数的 ERC20 代币合约                 | [Points counter ERC20](contracts/token/TDERC20.cairo) | [Link](https://testnet.starkscan.co/contract/0x5c6b1379f1d4c8a4f5db781a706b63a885f3f9570f7863629e99e2342ac344c) | [Link](https://goerli.voyager.online/contract/0x5c6b1379f1d4c8a4f5db781a706b63a885f3f9570f7863629e99e2342ac344c) |
| 一般语法                        | [Ex01](contracts/ex01.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x29e2801df18d7333da856467c79aa3eb305724db57f386e3456f85d66cbd58b) | [Link](https://goerli.voyager.online/contract/0x29e2801df18d7333da856467c79aa3eb305724db57f386e3456f85d66cbd58b) |
| 存储变量, getters, 断言   | [Ex02](contracts/ex02.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x18ef3fa8b5938a0059fa35ee6a04e314281a3e64724fe094c80e3720931f83f) | [Link](https://goerli.voyager.online/contract/0x18ef3fa8b5938a0059fa35ee6a04e314281a3e64724fe094c80e3720931f83f) |
| 读写存储变量 | [Ex03](contracts/ex03.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x79275e734d50d7122ef37bb939220a44d0b1ad5d8e92be9cdb043d85ec85e24) | [Link](https://goerli.voyager.online/contract/0x79275e734d50d7122ef37bb939220a44d0b1ad5d8e92be9cdb043d85ec85e24) |
| 映射                              | [Ex04](contracts/ex04.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x2cca27cae57e70721d0869327cee5cb58098af4c74c7d046ce69485cd061df1) | [Link](https://goerli.voyager.online/contract/0x2cca27cae57e70721d0869327cee5cb58098af4c74c7d046ce69485cd061df1) |
| 变量可见性                   | [Ex05](contracts/ex05.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x399a3fdd57cad7ed2193bdbb00d84553cd449abbdfb62ccd4119eae96f827ad) | [Link](https://goerli.voyager.online/contract/0x399a3fdd57cad7ed2193bdbb00d84553cd449abbdfb62ccd4119eae96f827ad) |
| 函数可见性                  | [Ex06](contracts/ex06.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x718ece7af4fb1d9c82f78b7a356910d8c2a8d47d4ac357db27e2c34c2424582) | [Link](https://goerli.voyager.online/contract/0x718ece7af4fb1d9c82f78b7a356910d8c2a8d47d4ac357db27e2c34c2424582) |
| 比较数值                      | [Ex07](contracts/ex07.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x3a1ad1cde69c9e7b87d70d2ea910522640063ccfb4875c3e33665f6f41d354a) | [Link](https://goerli.voyager.online/contract/0x3a1ad1cde69c9e7b87d70d2ea910522640063ccfb4875c3e33665f6f41d354a) |
| 递归 级别 1                    | [Ex08](contracts/ex08.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x15fa754c386aed6f0472674559b75358cde49db8b2aba8da31697c62001146c) | [Link](https://goerli.voyager.online/contract/0x15fa754c386aed6f0472674559b75358cde49db8b2aba8da31697c62001146c) |
| 递归 级别 2                    | [Ex09](contracts/ex09.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x2b9fcc1cfcb1ddf4663c8e7ac48fc87f84c91a8c2b99414c646900bf7ef5549) | [Link](https://goerli.voyager.online/contract/0x2b9fcc1cfcb1ddf4663c8e7ac48fc87f84c91a8c2b99414c646900bf7ef5549) |
| 可组合性                         | [Ex10](contracts/ex10.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x8415762f4b0b0f44e42ac1d103ac93c3ea94450a15bb65b99bbcc816a9388)   | [Link](https://goerli.voyager.online/contract/0x8415762f4b0b0f44e42ac1d103ac93c3ea94450a15bb65b99bbcc816a9388)   |
| 导入函数                   | [Ex11](contracts/ex11.cairo)                          | [Link](https://testnet.starkscan.co/contract/0xab5577b9be8948d89dbdba63370a3de92e72a23c4cacaea38b3a74eec3a872)  | [Link](https://goerli.voyager.online/contract/0xab5577b9be8948d89dbdba63370a3de92e72a23c4cacaea38b3a74eec3a872)  |
| 事件                                | [Ex12](contracts/ex12.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x24d15e02ddaa19d7ecd77204d35ed9bfff00a0cabc62eb3da5ba7680e44baf9) | [Link](https://goerli.voyager.online/contract/0x24d15e02ddaa19d7ecd77204d35ed9bfff00a0cabc62eb3da5ba7680e44baf9) |
| StarkNet的隐私                   | [Ex13](contracts/ex13.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x2bae9190076c4252289b8a8671277cef57318192cff20c736808b0c71095895) | [Link](https://goerli.voyager.online/contract/0x2bae9190076c4252289b8a8671277cef57318192cff20c736808b0c71095895) |
| 多调用                             | [Ex14](contracts/ex14.cairo)                          | [Link](https://testnet.starkscan.co/contract/0xed7ddffe1370fbbc1974ab8122d1d9bd7e3da8d829ead9177ea4249b4caef1)  | [Link](https://goerli.voyager.online/contract/0xed7ddffe1370fbbc1974ab8122d1d9bd7e3da8d829ead9177ea4249b4caef1)  |

### 查看你的积分

​
你的积分将计入您安装的钱包；虽然这可能需要一些时间。如果您想实时监控您的积分数量，您还可以在区块浏览器中查看您的余额！
​

- 进入ERC20积分合约 [Voyager](https://goerli.voyager.online/contract/0x5c6b1379f1d4c8a4f5db781a706b63a885f3f9570f7863629e99e2342ac344c#readContract) 或者 [Starkscan](https://testnet.starkscan.co/contract/0x5c6b1379f1d4c8a4f5db781a706b63a885f3f9570f7863629e99e2342ac344c#read-contract), 在 "read contract" 选项卡中。
- 在"balanceOf" 函数中输入你的地址。

您还可以在 [此处](https://starknet-tutorials.vercel.app) 查看您的整体进度。
​

### 交易状态

​
您也可以通过以下网址查看您的交易状态  [https://alpha4.starknet.io/feeder_gateway/get_transaction_receipt?transactionHash=](https://alpha4.starknet.io/feeder_gateway/get_transaction_receipt?transactionHash=) 或者 [https://alpha4.starknet.io/feeder_gateway/get_transaction?transactionHash=](https://alpha4.starknet.io/feeder_gateway/get_transaction?transactionHash=), URL后面添加你的交易哈希。
​
​

## 复用这个工程

- 在你的机器上克隆仓库。
- 按照 [这些说明](https://starknet.io/docs/quickstart.html#quickstart) 设置环境。
- 测试您是否可以编译该项目。

```bash
protostar build
```