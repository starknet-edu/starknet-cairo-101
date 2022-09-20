간단한 튜토리얼로 Cairo를 시작하세요. 퍼즐/과제를 완료하고, 토큰을 받고, StarkNet 스마트 컨트랙트에 대해 알아보세요!

[https://github.com/starknet-edu/starknet-cairo-101](https://github.com/starknet-edu/starknet-cairo-101)

## 개요

### 면책조항

이더리움 메인넷의 첫 번째 범용 유효성 롤업인 StarkNet을 배우는 것 외에는 이것을 사용함으로써 얻을 수 있는 혜택을 기대하지 마세요.

StarkNet은 여전히 알파 버전입니다. 개발이 진행 중이고, 곳곳에 페인트가 마르지 않았다는 의미입니다. 지속적으로 나아질 것이며, 동시에 조금씩 박스 테이프로 수정해 나갈 겁니다!

### 진행방식

**과제를 완료하고 토큰을 받으세요!** 이 워크샵은 테스트넷에서 StarkNet 알파에 배포된 일련의 스마트 컨트랙트입니다. 각 스마트 컨트랙트는 카이로 스마트 컨트랙트 언어의 특징을 요약한 과제/퍼즐입니다.

과제를 완료하면 ERC20 토큰 형태의 포인트가 적립됩니다.

이 워크샵은 카이로 코드와 StarkNet 스마트 컨트랙트를 읽고 구문을 이해하는 데 중점을 둡니다. 이것을 수행하고 완료하기 위해 코딩을 하거나 컴퓨터에 어떤 것도 설치할 필요가 없습니다.

튜토리얼을 시작하는 데(처음 두 가지 과제) 시간이 걸립니다. 잠깐 기다리세요! 일단 하다 보면, 더 쉽게 진행될 것입니다. 당신은 배우고 있는 단계니까요!

### 여기가 어디죠?

이 워크샵은 StarkNet에 빌드하는 방법을 가르치는 것을 목표로 한 시리즈 중 첫 번째 워크샵입니다.

다음을 확인하세요:

| 주제 | GitHub repo |
| --- | --- |
| 카이로 코드 읽는 방법 배우기
(당신은 여기 있습니다). | Cairo 101 |
| ERC721 NFT 배포 및 사용자 지정하기 | StarkNet ERC721 |
| ERC20 토큰 배포 및 사용자 지정하기 | StarkNet ERC20 |
| 교차 레이어 애플리케이션 구축하기 | StarkNet messaging bridge |
| 카이로 컨트랙트 쉽게 오류 검출하기 | StarkNet debug |
| 자신만의 계정 컨트랙트 디자인하기 | StarkNet account abstraction |

### 피드백 제공 및 도움 받기

이 튜토리얼을 완료하고 피드백을 주시면 감사하겠습니다.

[이 양식](https://forms.reform.app/starkware/untitled-form-4/kaes2e)을 작성하여 더 나은 서비스를 제공하기 위해 저희가 무엇을 할 수 있는지 알려주세요.

그리고 어려운 부분이 있다면, 꼭 저희에게 알려주세요! 이 워크샵은 가능한 한 쉽게 접근할 수 있도록 되어 있습니다. 

질문이 있으신가요? [Disord 서버](https://starknet.io/discord)에 가입하고 채널 #tutorials-support에 등록 및 가입하세요. 

StarkNet을 개발하는 방법에 대한 온라인 워크샵을 구독하는 것에 관심이 있나요? [여기서 구독](https://starkware.us12.list-manage.com/subscribe?u=b7a3c9f392572e89e8529da3c&id=6ed3eedc96)

### 기여

이 프로젝트는 더 나아질 수 있고 StarkNet이 고도화 될 겁니다. 당신의 기여를 환영해요! 당신이 줄 수 있는 도움은 아래와 같습니다:

- 여러분의 언어로 번역된 브랜치를 생성하세요.
- 버그를 발견하면 수정하세요.
- 더 많은 설명이 필요하다고 생각되면 연습의 코멘트에 설명을 추가하세요.
- 당신이 가장 좋아하는 카이로의 특징을 보여주는 과제를 추가하세요.

### 언어

중국어 버전은 [여기](https://github.com/starknet-edu/starknet-cairo-101/tree/mandarin)에서 이용 가능합니다.

스페인어 버전은 [여기](https://github.com/starknet-edu/starknet-cairo-101/blob/main/README.es.md)에서 이용 가능합니다.

## 시작하기

### 스마트 컨트랙트 지갑 만들기

튜토리얼을 완료 하려면 포인트를 모아야 합니다. 이 포인트는 당신이 배포해야 하는 스마트 컨트랙트 지갑이 소유합니다.

- 가장 쉬운 설정 방법은 Argent X([크롬 확장 다운로드](https://chrome.google.com/webstore/detail/argent-x/dlcobpjiigpikoobohmabehhmhfoodbb) 또는 [repo 확인](https://github.com/argentlabs/argent-x)) 또는 Braavos([크롬 확장 다운로드](https://chrome.google.com/webstore/detail/braavos-wallet/jnlgamecbpmbajjfhmmmlhejkemejdma))를 사용하는 것입니다. 이러한 지갑 솔루션은 메타마스크가 이더리움을 위한 것과 유사하며 사용자가 거래를 시작하고 StarkNet의 애플리케이션과 상호 작용할 수 있도록 합니다.
- 지침에 따라 확장을 설치하고 스마트 컨트랙트 계정을 배포합니다(배포하는 데 약 5분 정도 걸릴 수 있음). StarkNet에는 지갑과 스마트 컨트랙트가 있는 이더리움과 달리 스마트 컨트랙트 계정(이것을 계정 추상화라고 합니다)이라는 한 가지 유형의 계정만 있습니다. 다시 말해, StarkNet의 모든 지갑은 스마트 컨트랙트이며 다른 스마트 컨트랙트과 구별이 없습니다. 따라서 새 지갑을 만들려면 스마트 컨트랙트 지갑을 네트워크에 게시하는 트랜잭션을 배포해야 합니다.
- 사용자가 Goerli testnet 네트워크에 있는지 확인합니다.
- 튜토리얼의 포인트는 컨트랙트에 있습니다.[0x5c6b1379f1d4c8a4f5db781a706b63a885f3f9570f7863629e99e2342ac344c]`(https://goerli.voyager.online/contract/0x5c6b1379f1d4c8a4f5db781a706b63a885f3f9570f7863629e99e2342ac344c)`. 
설치된 지갑과 컨트랙트 주소에서 "토큰 추가"를 클릭하면 포인트 잔액이 표시됩니다! SC101(스타크넷-카이로-101)이라는 새로운 토큰이 지갑에 나타날 것입니다.
- [Voyager](https://voyager.online/)를 계정 스마트 컨트랙트에 연결합니다. Voyager는 StarkNet(Ethereum의 Etherscan과 동일)의 블록 탐색기로, 블록체인의 상태를 탐색하고, 모든 트랜잭션과 상태를 볼 수 있습니다. Voyager를 지갑에 연결하면 지갑을 통해 거래를 브로드캐스트할 수 있습니다.
- Goerli StarkNet 테스트넷에서 트랜잭션을 실행하려면 가스 비용을 지불할 테스트넷 ETH가 필요합니다. 몇 개를 사기 위해, [수도꼭지](https://faucet.goerli.starknet.io/)로 가서 지시를 따르세요. 몇 분 정도 걸릴 수 있지만, 테스트넷에서 트랜잭션을 실행하는 데 사용할 수 있는 L2 Goerli ETH를 지갑에 넣을 수 있습니다.

### 과제 해결하기&점수 얻기

**각 과제는 별도의 스마트 컨트랙트입니다.** 이 스마트 컨트랙트에는 올바르게 실행되면 당신의 주소로 포인트가 분배되는 코드가 포함되어 있습니다. 포인트는 `distribute_points()` 함수에 의해 분배되며 `validate_exercise` 함수는 과제가 완료 되었음을 기록합니다(포인트는 단 한 번만 받을 수 있습니다). 당신의 목표는 다음과 같습니다:

![Screenshot 2022-09-14 at 20.30.20.JPG](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e80b3855-4d50-42a2-ae2a-cf4de0f55bd6/Screenshot_2022-09-14_at_20.30.20.jpg)

### Voyager 이용하기

이 튜토리얼에서는 StarkNet의 블록 탐색기인 Voyager를 통해 컨트랙트와 상호 작용할 것입니다. Voyager를 계정 컨트랙트에 연결해야 합니다! 이렇게 하면 지갑을 통해 거래를 브로드캐스트할 수 있습니다.

컨트랙트/트랜잭션를 찾을 때 항상 Goerli 버전의 Voyager에 있는지 확인하십시오!

- 아래 형식의 URL로 트랜잭션에 액세스 하세요:
    
    [https://goerli.voyager.online/tx/your-tx-hash](https://goerli.voyager.online/tx/your-tx-hash).
    
- 아래 형식의 URL로 컨트랙트에 액세스 하세요:
    
    [https://goerli.voyager.online/contract/your-contract-address](https://goerli.voyager.online/contract/your-contract-address). 
    
- Voyager의 "읽기/쓰기 컨트랙트" 탭을 통해 컨트랙트의 읽기/쓰기 기능에 액세스 하세요.

## 과제 및 컨트랙트의 주소

| 주제 | 컨트랙트 코드 | Voyager의 컨트랙트 |
| --- | --- | --- |
| Points counter ERC20 | Points counter ERC20 | Link |
| General syntax | Ex01 | Link |
| Storage variables, getters, asserts | Ex02 | Link |
| Reading and writing storage variables | Ex03 | Link |
| Mappings | Ex04 | Link |
| Variable visibility | Ex05 | Link |
| Functions visibility | Ex06 | Link |
| Comparing values | Ex07 | Link |
| Recursions level 1 | Ex08 | Link |
| Recursions level 2 | Ex09 | Link |
| Composability | Ex10 | Link |
| Importing functions | Ex11 | Link |
| Events | Ex12 | Link |
| Privacy on StarkNet | Ex13 | Link |
| Multicall | Ex14 | Link |

### 포인트 집계

포인트는 설치된 지갑에 적립됩니다; 하지만 시간이 좀 걸릴 수 있습니다. 포인트 집계를 실시간으로 모니터링하고 싶다면, Voyager에서 잔액을 볼 수 있습니다!

- Voyager의 "읽기 컨트랙트" 탭에 있는 [ERC20 counter](https://goerli.voyager.online/contract/0x5c6b1379f1d4c8a4f5db781a706b63a885f3f9570f7863629e99e2342ac344c#readContract)로 이동합니다.
- "balanceOf" 기능에 주소를 입력합니다.

또한 [여기](https://starknet-tutorials.vercel.app/)에서 전반적인 진행 상황을 확인할 수 있습니다.

### 거래현황

거래를 보냈는데 Voyager에 "undetected: 탐지되지 않음"으로 표시되어 있나요? 이는 다음 두 가지를 의미합니다.

- 트랜잭션이 보류 중이며 곧 블록에 포함됩니다. 그러면 Voyager에서 볼 수 있습니다.
- 트랜잭션이 잘못되었으므로 블록에 포함되지 않습니다(StarkNet에는 실패한 트랜잭션이 없습니다). 다음 URL을 사용하여 트랜잭션 상태를 확인할 수 있습니다 (꼭 확인하는 걸 권장합니다). [https://alpha4.starknet.io/feeder_gateway/get_transaction_receipt?transactionHash=](https://alpha4.starknet.io/feeder_gateway/get_transaction_receipt?transactionHash=), 트랜잭션 해시를 추가할 수 있습니다.

## 프로젝트 재사용

- repo를 여러분의 기기에 clone합니다.
- [다음 지침](https://starknet.io/docs/quickstart.html#quickstart)에 따라 환경을 설정합니다.
- [Nile](https://github.com/OpenZeppelin/nile)을 설치합니다.
- 프로젝트를 편집할 수 있는지 테스트합니다.

```jsx
nile compile
```
