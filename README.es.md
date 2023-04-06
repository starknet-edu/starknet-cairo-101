# Taller automatizado Starknet Cairo 101

![banner](assets/banner.png)

¡Bienvenido!

Este tutorial está hecho para desarrolladores que estén interesados en aprender a leer código Cairo 1 y contratos inteligentes en Starknet. Siguiéndolo, serás capaz de empezar en poco tiempo. ¡Diviértete!

## Introducción

Bienvenido a Starknet, un Validity Rollup de propósito general sobre Ethereum mainnet. Starknet es una solución de escalado de capa 2 que permite a los desarrolladores construir aplicaciones descentralizadas sin comprometer la seguridad, escalabilidad y descentralización.

Este taller está diseñado para ayudarte a leer el código de Cairo 1 y los contratos inteligentes de Starknet, y entender su sintaxis. No te preocupes, no necesitas codificar ni instalar nada en tu máquina para seguirlo y completarlo. **Puedes hacerlo todo desde tu navegador**.

Los ejercicios son un conjunto de contratos inteligentes desplegados en Starknet Alpha en testnet. Cada contrato inteligente es un ejercicio/puzzle que describe una característica del lenguaje de contratos inteligentes de Cairo.

Completando los ejercicios ganarás puntos en forma de un [token ERC20](contracts/token/TDERC20.cairo). El token no tiene ningún valor monetario, pero es una forma divertida de seguir tus progresos en el aprendizaje.

¡Esperamos que te diviertas participando en este taller!

## Qué aprenderá

- Cómo leer el código de Cairo 1.
- Cómo leer los contratos inteligentes de Starknet.
- Cómo interactuar con los contratos inteligentes de Starknet utilizando un monedero de navegador y un explorador de bloques.

### Atención

No esperes ningún beneficio de usar esto aparte de aprender algunas cosas interesantes sobre Starknet, el primer Validity Rollup de propósito general en la mainnnet de Ethereum.

## Pasos

![Steps](assets/steps.png)

### 1. Crear un monedero de contrato inteligente y conectarlo a un Explorador de Bloques

**Para completar el tutorial, necesitas reunir puntos.** Poseerás estos puntos a través de tu monedero Starknet.

- La forma más sencilla de crear uno es utilizar Argent X ([descargar la extensión de chrome](https://chrome.google.com/webstore/detail/argent-x-starknet-wallet/dlcobpjiigpikoobohmabehhmhfoodbb/) o [consultar su repo](https://github.com/argentlabs/argent-x)) o Braavos ([descargar la extensión de chrome](https://chrome.google.com/webstore/detail/braavos-wallet/jnlgamecbpmbajjfhmmmlhejkemejdma)).
Estas soluciones de monedero son para Starknet lo que Metamask es para Ethereum. Permiten a los usuarios iniciar transacciones e interactuar con aplicaciones en Starknet.
- Sigue las instrucciones de la aplicación de tu monedero para instalar la extensión. La cuenta puede tardar aproximadamente 5 minutos en desplegarse. Ten en cuenta que en Starknet sólo existe un tipo de cuenta: las cuentas de contratos inteligentes. Para crear un nuevo monedero, necesitas enviar una transacción que publique tu monedero de contrato inteligente en la red.
- Asegúrate de que estás en la red Goerli testnet.
- Los puntos del tutorial se mantienen en el contrato `0x044f65adbdb59bf1db71e8b69efb7c9d0b810db94c1730a05fa5751b02d396de` ([Starkscan link](https://testnet.starkscan.co/contract/0x044f65adbdb59bf1db71e8b69efb7c9d0b810db94c1730a05fa5751b02d396de), [Voyager link](https://goerli.voyager.online/contract/0x044f65adbdb59bf1db71e8b69efb7c9d0b810db94c1730a05fa5751b02d396de)). Haz clic en "Añadir Token" en tu monedero instalado y añade la dirección del contrato tutorial para que tu saldo de puntos aparezca allí. Un nuevo token llamado `SC101` (starknet-cairo-101) aparecerá en tu monedero.
- Para ejecutar transacciones en la testnet de Goerli Starknet, necesitarás ETH de testnet para pagar la gasolina. Tienes dos opciones:
    - Ir al [faucet](https://faucet.goerli.starknet.io/) y seguir las instrucciones. Puede tardar unos minutos.
    - Ir a [Starkgate](https://goerli.starkgate.starknet.io/) y puentear Goerli Eth de Ethereum a Starknet.

### 2. Utiliza un explorador de bloques para interactuar con los contratos

Para finalizar este taller, tienes que interactuar con los ejercicios/contratos inteligentes a través de un explorador de bloques.

Puedes utilizar [Starkscan](https://testnet.starkscan.co/) o [Voyager](https://goerli.voyager.online/). Estos son para Starknet lo que Etherscan es para Ethereum. Te permiten navegar por el estado del blockchain y ver todas las transacciones y su estado.

Al conectar tu cartera al explorador de bloques, podrás enviar tus transacciones a la red e interactuar con los ejercicios del tutorial.

Cuando busques un contrato/transacción, asegúrate siempre de que estás en la versión Goerli del Explorador de Bloques. Para resolver los ejercicios, accede a las funciones del contrato utilizando la pestaña `read`/`write` del explorador.

### 3. Resolución de ejercicios y obtención de puntos

**Cada ejercicio es un contrato inteligente independiente.** Contiene código que, cuando se ejecuta correctamente, distribuirá puntos a tu dirección.

Para resolver un ejercicio, sigue el siguiente enlace para leer su código. Lee los comentarios y sigue las instrucciones para entender el código. Su objetivo es conseguir que cada ejercicio llame correctamente a la función `distribute_points()`, que le enviará puntos ERC20.

Durante la validación, los ejercicios también suelen llamar a `validate_exercise()`, que registra que has completado un ejercicio y te prohíbe recoger puntos varias veces.

Cada ejercicio está desplegado en la red de pruebas Goerli, y tendrás que interactuar con ellos a través de un Explorador de Bloques. Puede encontrar las direcciones de los contratos en la siguiente tabla.

| Tema                                  | Código del contrato                                   | Contrato en Starkscan                                                                                              | Contrato en Voyager                                                                                              |
| ------------------------------------- | ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| Sintáxis general                                   | [Ex01](src/ex01.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x031d1866cb827c4e27bbca9ffee59fa2158b679413ffb58c3f90af56e1140e85) | [Link](https://goerli.voyager.online/contract/0x031d1866cb827c4e27bbca9ffee59fa2158b679413ffb58c3f90af56e1140e85) |
| Variables de almacenamiento, getters, asserts      | [Ex02](src/ex02.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x0600f8fe0752e598b4e6b27839f00ad65215d129f385e12931323c487b6f9b36) | [Link](https://goerli.voyager.online/contract/0x0600f8fe0752e598b4e6b27839f00ad65215d129f385e12931323c487b6f9b36) |
| Lectura y escritura de variables de almacenamiento | [Ex03](src/ex03.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x033d5fc40c0e262612528a9a652ada70be854d98241fb7548745262b5273c9d1) | [Link](https://goerli.voyager.online/contract/0x033d5fc40c0e262612528a9a652ada70be854d98241fb7548745262b5273c9d1) |
| Mappings                                           | [Ex04](src/ex04.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x06967cd33c6e064087123958e239c98f0de5e6d663660fa16a2526e8b115688a) | [Link](https://goerli.voyager.online/contract/0x06967cd33c6e064087123958e239c98f0de5e6d663660fa16a2526e8b115688a) |
| Visibilidad de variables                          | [Ex05](src/ex05.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x076c32e000f7112724bba3c5f51fb1290217a1010ae555e6ecbdb2bfe6613e33) | [Link](https://goerli.voyager.online/contract/0x076c32e000f7112724bba3c5f51fb1290217a1010ae555e6ecbdb2bfe6613e33) |
| Visibilidad de funciones                          | [Ex06](src/ex06.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x060987aea322cd12657588b6cdb0892db79322ab4533f7d74838ff2e2614a015) | [Link](https://goerli.voyager.online/contract/0x060987aea322cd12657588b6cdb0892db79322ab4533f7d74838ff2e2614a015) |
| Comparación de valores                            | [Ex07](src/ex07.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x006051096480f375894eebb99948bce14a84c25093636c4b4e8222cc32a67cf0) | [Link](https://goerli.voyager.online/contract/0x006051096480f375894eebb99948bce14a84c25093636c4b4e8222cc32a67cf0) |
| Nivel de recursión 1                              | [Ex08](src/ex08.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x01ec8e981b1b6a7256a71f21790dd07cafeb15d02c18534a2bd4a6c8551860aa) | [Link](https://goerli.voyager.online/contract/0x01ec8e981b1b6a7256a71f21790dd07cafeb15d02c18534a2bd4a6c8551860aa) |
| Nivel de recursión 2                              | [Ex09](src/ex09.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x053b96c4ee027c53ea001479f24c10b543063e3c26d037c600e5bd31f0b21e5c) | [Link](https://goerli.voyager.online/contract/0x053b96c4ee027c53ea001479f24c10b543063e3c26d037c600e5bd31f0b21e5c) |
| Composibilidad                                    | [Ex10](src/ex10.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x04c7a011779c00c2dec5da1e4a70c2db9b9dcf55c9fde991d7e2be00a9a42198) | [Link](https://goerli.voyager.online/contract/0x04c7a011779c00c2dec5da1e4a70c2db9b9dcf55c9fde991d7e2be00a9a42198) |
|  Importación de funciones                         | [Ex11](src/ex11.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x029a9a484d22a6353eff0d60ea56c6ffabaaac5e4889182287ef1d261578b197) | [Link](https://goerli.voyager.online/contract/0x029a9a484d22a6353eff0d60ea56c6ffabaaac5e4889182287ef1d261578b197) |
| Eventos                                          | [Ex12](src/ex12.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x04a221a8e3155fb03d1708881213a2ecdb05a41cf0ae6de83ddcf8f12bb04282) | [Link](https://goerli.voyager.online/contract/0x04a221a8e3155fb03d1708881213a2ecdb05a41cf0ae6de83ddcf8f12bb04282) |
| Privacidad en Starknet                           | [Ex13](src/ex13.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x067ed1d23c5cc3a34fb86edd4f8415250c79a374e87bcf2e6870321261ca9b0f) | [Link](https://goerli.voyager.online/contract/0x067ed1d23c5cc3a34fb86edd4f8415250c79a374e87bcf2e6870321261ca9b0f) |
| Multillamada                                      | [Ex14](src/ex14.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x031e9a701a24c1d2ecd576208087dfa52f1025072cf11e54407300f64f95ce5f) | [Link](https://goerli.voyager.online/contract/0x031e9a701a24c1d2ecd576208087dfa52f1025072cf11e54407300f64f95ce5f) |


### 4. Contar tus puntos y verificar tu progreso

Tus puntos se acreditarán en tu billetera, aunque esto puede llevar algún tiempo. Si deseas monitorear tu cantidad de puntos en tiempo real, también puedes verificar tu saldo en un explorador de bloques.
- Ve al contador ERC20 en [Voyager](https://goerli.voyager.online/contract/0x044f65adbdb59bf1db71e8b69efb7c9d0b810db94c1730a05fa5751b02d396de) o [Starkscan](https://testnet.starkscan.co/contract/0x044f65adbdb59bf1db71e8b69efb7c9d0b810db94c1730a05fa5751b02d396de) en la pestaña "read contract".
- Ingresa tu dirección en la función `balanceOf`.​

¡Disfruta del taller! Si tienes alguna pregunta, no dudes en contactarnos en [Discord](https://starknet.io/discord). ¡Estamos felices de ayudarte!

---

## Contribuir a mejorar este taller

Este proyecto puede mejorarse y evolucionará. Tus contribuciones son bienvenidas. Vaya al archivo [CONTRIBUTING](CONTRIBUTING.md) para obtener más información sobre cómo configurar su entorno y contribuir al proyecto.

Aquí tienes **algunas** cosas que puedes hacer para ayudar:

- Crear una rama con una traducción a tu idioma.
- Corregir errores si los encuentras.
- Añade una explicación en los comentarios del ejercicio si crees que necesita más explicación.
- Añade ejercicios que muestren tu característica favorita de Cairo.
- Añade un nuevo tutorial a la serie.


## Otros talleres automatizados

Este taller es el primero de una serie destinada a enseñar cómo construir en Starknet. Echa un vistazo a otros talleres de la serie:

| Temas                                       | GitHub repo                                                                                |
| ------------------------------------------- | ------------------------------------------------------------------------------------------ |
| Aprende a leer código Cairo (Estás aquí)    | [Cairo 101](https://github.com/starknet-edu/starknet-cairo-101)                            |
| Despliega y edita un NFT ERC721             | [Starknet ERC721](https://github.com/starknet-edu/starknet-erc721)                         |
| Despliega y edita un token ERC20            | [Starknet ERC20](https://github.com/starknet-edu/starknet-erc20)                           |
| Construye una aplicacion multi-capa         | [Puente de mensajes de Starknet](https://github.com/starknet-edu/starknet-messaging-bridge)|
| Debugea tus contratos Cairo fácilmente      | [Starknet debug](https://github.com/starknet-edu/starknet-debug)                           |
| Diseña tu propio contrato de cuenta         | [Abstracción de cuenta de Starknet](https://github.com/starknet-edu/starknet-accounts)     |

### Feedback y ayuda

Una vez que hayas terminado con este tutorial, tu feedback será muy apreciado!

**Por favor llena [este formulario](https://forms.reform.app/starkware/untitled-form-4/kaes2e) para dejarnos saber qué podemos mejorar.**


Y si se te complica seguir adelante, ¡déjanos saber! La idea de este workshop es que sea lo más accesible posible; queremos saber si no es el caso.

¿Tienes alguna pregunta? Visita nuestro [Server de Discord](https://starknet.io/discord), regístrate, y visita el canal #tutorials-support.

¿Estás interesado/a en seguir workshops online sobre aprender cómo desarrollar en Starknet? [Subscríbete aquí](https://starknet.substack.com/)


## Idiomas

- (no actualizado) Existe una versión en español [aquí](https://github.com/starknet-edu/starknet-cairo-101/tree/spanish).
- (sin actualizar) Existe una versión en portugués [aquí](./README.pt.md).
- (no actualizado) Existe una versión en coreano [aquí](./README.kr.md).
