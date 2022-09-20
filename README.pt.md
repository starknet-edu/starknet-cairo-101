
# StarkNet Cairo 101

**Comece a aprender Cairo com esse simples tutorial.
Complete puzzles/exercícios, receba tokens e aprenda sobre contratos inteligentes da StarkNet!**


## Introdução

### Aviso legal

Não espere nenhuma benefício em usar esse material além de aprender algumas coisas sobre StarkNet, o primeiro rollup de validez de uso geral da rede principal da Ethereum (Mainnet).

​A StarkNet ainda está em Alpha. Isso significa que o desenvolvimento está em andamento e a tinta não está seca em todos os lugares. As coisas vão melhorar e, enquanto isso, fazemos as coisas funcionarem com um pouco de fita adesiva aqui e ali!

### Como funciona

​
**Complete os exercícios e ganhe tokens!**
Este workshop é um conjunto de contratos inteligentes implantados na testnet StarkNet Alpha. Cada contrato inteligente é um exercício/puzzle - que descreve um recurso da linguagem Cairo.

Completar os exercícios lhe dará pontos em forma de [tokens ERC20](contracts/token/TDERC20.cairo).

​
Este workshop se concentra na *leitura* de código em Cairo e nos contratos inteligentes da StarkNet para entender sua sintaxe. Você não precisa programar ou instalar nada em sua máquina para segui-lo e completá-lo.

​
Você levará algum tempo para começar (fazendo os dois primeiros exercícios) no tutorial. Espere! Uma vez lá, as coisas fluirão mais facilmente. Você está aprendendo!

### Onde estou?

Este workshop é o primeiro de uma série com o objetivo de ensinar como programar na StarkNet. Confira a seguir:

| Topic                                       | GitHub repo                                                                            |
| ------------------------------------------- | -------------------------------------------------------------------------------------- |
| Aprenda a ler código Cairo (você está aqui) | [Cairo 101](https://github.com/starknet-edu/starknet-cairo-101)                        |
| Implemente e personalize um NFT ERC721          | [StarkNet ERC721](https://github.com/starknet-edu/starknet-erc721)                     |
| Implemente e personalize um token ERC20         | [StarkNet ERC20](https://github.com/starknet-edu/starknet-erc20)                       |
| Crie um aplicativo de camada cruzada (cross layer)             | [StarkNet ponte de mensagens](https://github.com/starknet-edu/starknet-messaging-bridge) |
| Depure seus contratos do Cairo facilmente           | [StarkNet debug](https://github.com/starknet-edu/starknet-debug)                       |
| Crie seu próprio contrato           | [StarkNet abstração de conta](https://github.com/starknet-edu/starknet-accounts)      |

### Fornecer feedback e obter ajuda

Quando terminar este tutorial, deixe seu feedback, será bem apreciado!

**Por favor preencha [esse formulário](https://forms.reform.app/starkware/untitled-form-4/kaes2e) para sabermos em que podemos melhorar.**

​
E se você tiver dificuldades para progredir no tutorial, fale conosco! Este workshop pretende ser o mais acessível possível; queremos saber caso não seja.

​
Você tem alguma pergunta? Entre no nosso [servidor no Discord](https://discord.gg/QypNMzkHbc), registre-se e participe do canal #tutorials-support.

Você está interessado em acompanhar workshops online sobre como desenvolver na StarkNet? [Se inscreva aqui](http://eepurl.com/hFnpQ5)

### Contribuindo

Este projeto pode ser melhorado e evoluirá à medida que a StarkNet amadurece. Suas contribuições são bem-vindas! Aqui estão algumas coisas que você pode fazer para ajudar:

- Criar uma branch com a tradução para sua língua
- Corrigir bugs se você achar algum
- Adicionar uma explicação nos comentários do exercício se achar que precisa de mais explicações
- Adicione exercícios mostrando seu recurso favorito de Cairo

### Línguas

A versão original em inglês está disponível [aqui](https://github.com/starknet-edu/starknet-cairo-101).
​

## Começando

### Criando uma carteira de contrato inteligente

**Para concluir o tutorial, você precisa coletar pontos.** Esses pontos serão enviados para uma carteira de contrato inteligente que você precisa criar.

- A maneira mais fácil de configurar uma é usar o Argent X ([baixe a extensão do chrome](https://chrome.google.com/webstore/detail/argent-x-starknet-wallet/dlcobpjiigpikoobohmabehhmhfoodbb/)  ou [confira o repositório](https://github.com/argentlabs/argent-x)) ou Braavos ([baixe a extensão do chrome](https://chrome.google.com/webstore/detail/braavos-wallet/jnlgamecbpmbajjfhmmmlhejkemejdma)). Essas soluções de carteira são semelhantes ao que o Metamask é para o Ethereum e permitem que os usuários iniciem transações e interajam com aplicativos no StarkNet.
- Siga as instruções para instalar a extensão e criar uma carteira de contrato inteligente (pode levar cerca de 5 minutos para ser criada). Observe que na StarkNet há apenas um tipo de conta - contratos inteligentes, chamadas Abstração de conta (Account Abstraction), diferente da rede Ethereum, onde há carteiras e contratos inteligentes. Em outras palavras, cada carteira no StarkNet é um contrato inteligente e não há distinção entre eles e outros contratos inteligentes. Portanto, para criar uma nova carteira, você precisa efetuar uma transação que publique sua carteira de contrato inteligente na rede.
- Certifique-se de estar na rede testnet Goerli.
- Os pontos do tutorial são mantidos em contrato `[0x5c6b1379f1d4c8a4f5db781a706b63a885f3f9570f7863629e99e2342ac344c](https://goerli.voyager.online/contract/0x5c6b1379f1d4c8a4f5db781a706b63a885f3f9570f7863629e99e2342ac344c)`. Clique em "Adicionar Token" na sua carteira e ponha endereço do contrato para que seus pontos apareça lá! Um novo token chamado SC101 (starknet-cairo-101) aparecerá em sua carteira.
- Conecte [Voyager](https://voyager.online/) a sua carteira. Voyager é o explorador de blocos para StarkNet (o equivalente de Etherscan para Ethereum) e permite que você navegue na blockchain, visualize todas as transações e seus status. Ao conectar o Voyager à sua carteira, você poderá transmitir suas transações por meio de sua carteira.
- Para executar transações no testnet Goerli StarkNet **você precisará de ETH da testnet para pagar pelo gás**. Para obter alguns, vá para o [faucet](https://faucet.goerli.starknet.io/) e siga as instruções. Pode levar alguns minutos, mas você receberá L2 Goerli ETH em sua carteira que você pode usar para executar transações na testnet.

### Resolvendo exercícios e ganhando pontos

​
**Cada exercício é um contrato inteligente.** Contém código que, quando executado corretamente, distribuirá pontos para seu endereço.
​
Pontos são distribuidos pela função `distribute_points()` enquanto a função `validate_exercise` grava que você concluiu o exercício (você só pode receber os pontos uma vez). Seu objetivo é:

![Graph](assets/diagram.png)
​
​

### Usando Voyager

Para este tutorial, vamos interagir com nossos contratos por meio do [Voyager](https://goerli.voyager.online/), Explorador de blocos da StarkNet. Certifique-se de conectar o Voyager a sua carteira! Isso permitirá que você realize suas transações.

Ao procurar um contrato/transação, certifique-se sempre de estar na versão Goerli do Voyager!

- Acesse suas transações com uma URL do formato: [https://goerli.voyager.online/tx/your-tx-hash](https://goerli.voyager.online/tx/your-tx-hash).
- Acesse um contrato com uma URL do formato: [https://goerli.voyager.online/contract/your-contract-address](https://goerli.voyager.online/contract/your-contract-address)
- Acesse as funções de leitura/gravação do contrato com a guia "Read/Write Contract" no Voyager.

​
​

## Exercícios e seus contratos

| Tópico                                 | Código do contrato                                         | Contrato no Voyager                                                                                              |
| ------------------------------------- | ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| Contador de pontos                  | [Contador de pontos](contracts/token/TDERC20.cairo) | [Link](https://goerli.voyager.online/contract/0x5c6b1379f1d4c8a4f5db781a706b63a885f3f9570f7863629e99e2342ac344c) |
| Sintaxe geral                        | [Ex01](contracts/ex01.cairo)                          | [Link](https://goerli.voyager.online/contract/0x29e2801df18d7333da856467c79aa3eb305724db57f386e3456f85d66cbd58b) |
| Variáveis ​​de armazenamento, getters, asserts  | [Ex02](contracts/ex02.cairo)                          | [Link](https://goerli.voyager.online/contract/0x18ef3fa8b5938a0059fa35ee6a04e314281a3e64724fe094c80e3720931f83f) |
| Lendo e armazenando variáveis ​​de armazenamento | [Ex03](contracts/ex03.cairo)                          | [Link](https://goerli.voyager.online/contract/0x79275e734d50d7122ef37bb939220a44d0b1ad5d8e92be9cdb043d85ec85e24) |
| Mapeamentos                              | [Ex04](contracts/ex04.cairo)                          | [Link](https://goerli.voyager.online/contract/0x2cca27cae57e70721d0869327cee5cb58098af4c74c7d046ce69485cd061df1) |
| Variável de visibilidade                  | [Ex05](contracts/ex05.cairo)                          | [Link](https://goerli.voyager.online/contract/0x399a3fdd57cad7ed2193bdbb00d84553cd449abbdfb62ccd4119eae96f827ad) |
| Visibilidade das funções                 | [Ex06](contracts/ex06.cairo)                          | [Link](https://goerli.voyager.online/contract/0x718ece7af4fb1d9c82f78b7a356910d8c2a8d47d4ac357db27e2c34c2424582)   |
| Comparando valores                     | [Ex07](contracts/ex07.cairo)                          | [Link](https://goerli.voyager.online/contract/0x3a1ad1cde69c9e7b87d70d2ea910522640063ccfb4875c3e33665f6f41d354a)  |
| Recursões nível 1                    | [Ex08](contracts/ex08.cairo)                          | [Link](https://goerli.voyager.online/contract/0x15fa754c386aed6f0472674559b75358cde49db8b2aba8da31697c62001146c) |
| Recursões nível 2                    | [Ex09](contracts/ex09.cairo)                          | [Link](https://goerli.voyager.online/contract/0x2b9fcc1cfcb1ddf4663c8e7ac48fc87f84c91a8c2b99414c646900bf7ef5549)  |
| Componibilidade                         | [Ex10](contracts/ex10.cairo)                          | [Link](https://goerli.voyager.online/contract/0x8415762f4b0b0f44e42ac1d103ac93c3ea94450a15bb65b99bbcc816a9388) |
| Importando funções                   | [Ex11](contracts/ex11.cairo)                          | [Link](https://goerli.voyager.online/contract/0xab5577b9be8948d89dbdba63370a3de92e72a23c4cacaea38b3a74eec3a872) |
| Eventos                                | [Ex12](contracts/ex12.cairo)                          | [Link](https://goerli.voyager.online/contract/0x24d15e02ddaa19d7ecd77204d35ed9bfff00a0cabc62eb3da5ba7680e44baf9) |
| Privacidade na StarkNet                   | [Ex13](contracts/ex13.cairo)                          | [Link](https://goerli.voyager.online/contract/0x2bae9190076c4252289b8a8671277cef57318192cff20c736808b0c71095895) |
| Multichamada                             | [Ex14](contracts/ex14.cairo)                          | [Link](https://goerli.voyager.online/contract/0xed7ddffe1370fbbc1974ab8122d1d9bd7e3da8d829ead9177ea4249b4caef1) |

### Contando seus pontos

​
Seus pontos serão creditados na sua carteira; embora isso possa levar algum tempo. Se você deseja monitorar sua contagem de pontos em tempo real, também pode ver seu saldo no Voyager!
​

- Vá para  [Contador de pontos](https://goerli.voyager.online/contract/0x5c6b1379f1d4c8a4f5db781a706b63a885f3f9570f7863629e99e2342ac344c#readContract) no Voyager, na aba de "read contract".
- Coloque o endereço da sua carteira na função "balanceOf".

Você também pode ver seu progresso geral [aqui](https://starknet-tutorials.vercel.app).
​

### Status da transação

​
Você enviou uma transação e ela é mostrada como "não detectada" na Voyager? Isso pode significar duas coisas:
​

- Sua transação está pendente e será incluída em um bloco em breve e então será visível na Voyager.
- Sua transação era inválida e NÃO será incluída em um bloco (não existe uma transação com falha no StarkNet).
​
Você pode (e deve) verificar o status de sua transação com a seguinte URL [https://alpha4.starknet.io/feeder_gateway/get_transaction_receipt?transactionHash=](https://alpha4.starknet.io/feeder_gateway/get_transaction_receipt?transactionHash=), onde você pode anexar seu hash de transação.
​
​

## Reproduzindo esse projeto

- Clone o repositório na sua máquina
- Configure o ambiente seguindo [essas instruções](https://starknet.io/docs/quickstart.html#quickstart).
- Instale [Nile](https://github.com/OpenZeppelin/nile).
- Teste se você pode compilar o projeto.

```bash
nile compile
```
