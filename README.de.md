# HAFTUNGSAUSSCHLUSS
Hallo Starknet-Community,
Dieses Repository ist nicht aktualisiert mit der neuesten Cairo-Syntax und daher empfehlen wir, dieses Tutorial nicht zu versuchen. Wenn Sie daran interessiert sind, zur Aktualisierung des Tutorials beizutragen, kommentieren Sie bitte das untenstehende Issue, um eine Aufgabe zu übernehmen.
Mehr Details über das Issue und die Aufschlüsselung der Übungen finden Sie hier:
https://github.com/starknet-edu/starknet-cairo-101/issues/61

Sie können mich auch (@gyanlakshmi) oder Omar (@omarespejel) auf Telegram anschreiben, um Sie bei den richtigen Aufgaben zu unterstützen.

# Starknet Cairo 101 Automatisierter Workshop

![banner](assets/banner.png)

- Eine vereinfachte chinesische Version ist verfügbar [hier](./README.zh.md).
- Eine vereinfachte spanische Version ist verfügbar [hier](./README.es.md).
- (nicht aktualisiert) Eine vereinfachte portugiesische Version ist verfügbare [hier](./README.pt.md).
- (nicht aktualisiert) Eine vereinfachte koreanische Version ist verfügbar [hier](./README.kr.md).
- (nicht aktualisiert) Eine vereinfachte deutsche Version ist verfügbar [hier](./README.de.md).


Einführung
Willkommen bei Starknet, einem allgemein nutzbaren Validity Rollup auf dem Ethereum-Hauptnetz. Starknet ist eine Layer-2-Skalierungslösung, die es Entwicklern ermöglicht, dezentrale Anwendungen zu entwickeln, ohne bei Sicherheit, Skalierbarkeit und Dezentralisierung Kompromisse einzugehen.

Dieser Workshop soll Ihnen helfen, Cairo 1 Code und Starknet Smart Contracts zu lesen und ihre Syntax zu verstehen. Keine Sorge, Sie müssen nichts auf Ihrem Computer installieren oder programmieren, um ihn zu verfolgen und abzuschließen. Sie können alles in Ihrem Browser machen.

Die Übungen sind eine Reihe von Smart Contracts, die auf Starknet Alpha im Testnetz bereitgestellt sind. Jeder Smart Contract ist eine Übung/Rätsel, die ein Merkmal der Cairo Smart Contract-Sprache darstellt.

Das Abschließen der Übungen bringt Ihnen Punkte in Form eines ERC20-Tokens. Das Token hat keinen monetären Wert, aber es ist eine lustige Art, Ihren Lernfortschritt zu verfolgen.

Wir hoffen, Sie haben Spaß an diesem Workshop!

Was Sie lernen werden
Wie man Cairo 1 Code liest
Wie man Starknet Smart Contracts liest
Wie man mit Starknet Smart Contracts interagiert, indem man ein Browser-Wallet und einen Block-Explorer verwendet.
Haftungsausschluss
Erwarten Sie keinen anderen Nutzen von der Verwendung dieses, außer etwas Cooles über Starknet, den ersten allgemein nutzbaren Validity Rollup im Ethereum-Hauptnetz, zu lernen.

Schritte

![Steps](assets/steps.png)

1. Erstellen einer Smart Contract-Wallet und Verbinden mit einem Block Explorer
2. 
Um das Tutorial abzuschließen, müssen Sie Punkte sammeln. Diese Punkte besitzen Sie durch Ihre Starknet-Wallet.

Der einfachste Weg, eine einzurichten, ist die Verwendung von Argent X ([download the chrome extension](https://chrome.google.com/webstore/detail/argent-x-starknet-wallet/dlcobpjiigpikoobohmabehhmhfoodbb/)  oder  [check their repo](https://github.com/argentlabs/argent-x)) oder Braavos ([download the chrome extension](https://chrome.google.com/webstore/detail/braavos-wallet/jnlgamecbpmbajjfhmmmlhejkemejdma)).

Diese Wallet-Lösungen sind für Starknet das, was Metamask für Ethereum ist. Sie ermöglichen es Benutzern, Transaktionen zu initiieren und mit Anwendungen auf Starknet zu interagieren.
Befolgen Sie die Anweisungen in Ihrer Wallet-App, um die Erweiterung zu installieren. Es kann etwa 5 Minuten dauern, bis das Konto eingerichtet ist. Beachten Sie, dass es in Starknet nur einen Typ von Konto gibt: Smart-Contract-Konten. Um eine neue Wallet zu erstellen, müssen Sie eine Transaktion senden, die Ihre Smart-Contract-Wallet im Netzwerk veröffentlicht.
Stellen Sie sicher, dass Sie sich im Goerli-Testnetz-Netzwerk befinden.
Die Punkte des Tutorials werden im Vertrag gehalten `0x044f65adbdb59bf1db71e8b69efb7c9d0b810db94c1730a05fa5751b02d396de` ([Starkscan link](https://testnet.starkscan.co/contract/0x044f65adbdb59bf1db71e8b69efb7c9d0b810db94c1730a05fa5751b02d396de), [Voyager link](https://goerli.voyager.online/contract/0x044f65adbdb59bf1db71e8b69efb7c9d0b810db94c1730a05fa5751b02d396de)). Klicken Sie auf "Token hinzufügen" in Ihrer installierten Wallet und fügen Sie die Adresse des Tutorial-Vertrags hinzu, damit Ihr Punktestand dort erscheint. Ein neuer Token namens SC101 (starknet-cairo-101) wird in Ihrer Wallet erscheinen.
Um Transaktionen im Goerli Starknet-Testnetz auszuführen, benötigen Sie Testnetz-ETH, um für Gas zu bezahlen. Sie haben zwei Möglichkeiten:
Gehen Sie zum [faucet](https://faucet.goerli.starknet.io/) und folgen Sie den Anweisungen. Es kann einige Minuten dauern.
Gehen Sie zu [Starkgate](https://goerli.starkgate.starknet.io/) übertragen Sie Goerli Eth von Ethereum zu Starknet.


Verwenden Sie einen Block Explorer, um mit den Verträgen zu interagieren

Um diesen Workshop abzuschließen, müssen Sie mit den Übungen/Smart Contracts über einen Block Explorer interagieren.

Sie können entweder [Starkscan](https://testnet.starkscan.co/) oder [Voyager](https://goerli.voyager.online/) verwenden. Diese sind für Starknet das, was Etherscan für Ethereum ist. Sie ermöglichen es Ihnen, den Zustand der Blockchain zu durchsuchen und alle Transaktionen sowie deren Status anzusehen.

Indem Sie Ihre Wallet mit dem Block Explorer verbinden, können Sie Ihre Transaktionen ins Netzwerk senden und mit den Übungen im Tutorial interagieren.

Achten Sie immer darauf, dass Sie sich auf der Goerli-Version des Block Explorers befinden, wenn Sie nach einem Vertrag/Transaktion suchen. Um die Übungen zu lösen, greifen Sie auf die Funktionen des Vertrags zu, indem Sie den Reiter lesen/schreiben im Explorer verwenden.

3. Übungen lösen und Punkte sammeln
Jede Übung ist ein separater Smart Contract. Sie enthält Code, der, wenn er korrekt ausgeführt wird, Punkte an Ihre Adresse verteilt.

Um eine Übung zu lösen, folgen Sie dem untenstehenden Link, um ihren Code zu lesen. Lesen Sie die Kommentare und befolgen Sie die Anweisungen, um den Code zu verstehen. Ihr Ziel ist es, jede Übung erfolgreich dazu zu bringen, die Funktion distribute_points() aufzurufen, die Ihnen ERC20-Punkte sendet.

Während der Validierung rufen Übungen oft auch validate_exercise() auf, was aufzeichnet, dass Sie eine Übung abgeschlossen haben, und Sie daran hindert, mehrmals Punkte zu sammeln.

Jede Übung ist im Goerli-Testnetz bereitgestellt, und Sie müssen über einen Block Explorer mit ihnen interagieren. Die Adressen der Verträge finden Sie in der untenstehenden Tabelle.

| Topic                                 | Contract code                                         | Contract on Starkscan                                                                                              | Contract on Voyager                                                                                              |
| ------------------------------------- | ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| General syntax                        | [Ex01](src/ex01.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x031d1866cb827c4e27bbca9ffee59fa2158b679413ffb58c3f90af56e1140e85) | [Link](https://goerli.voyager.online/contract/0x031d1866cb827c4e27bbca9ffee59fa2158b679413ffb58c3f90af56e1140e85) |
| Storage variables, getters, asserts   | [Ex02](src/ex02.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x0600f8fe0752e598b4e6b27839f00ad65215d129f385e12931323c487b6f9b36) | [Link](https://goerli.voyager.online/contract/0x0600f8fe0752e598b4e6b27839f00ad65215d129f385e12931323c487b6f9b36) |
| Reading and writing storage variables | [Ex03](src/ex03.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x033d5fc40c0e262612528a9a652ada70be854d98241fb7548745262b5273c9d1) | [Link](https://goerli.voyager.online/contract/0x033d5fc40c0e262612528a9a652ada70be854d98241fb7548745262b5273c9d1) |
| Mappings                              | [Ex04](src/ex04.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x06967cd33c6e064087123958e239c98f0de5e6d663660fa16a2526e8b115688a) | [Link](https://goerli.voyager.online/contract/0x06967cd33c6e064087123958e239c98f0de5e6d663660fa16a2526e8b115688a) |
| Variable visibility                   | [Ex05](src/ex05.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x076c32e000f7112724bba3c5f51fb1290217a1010ae555e6ecbdb2bfe6613e33) | [Link](https://goerli.voyager.online/contract/0x076c32e000f7112724bba3c5f51fb1290217a1010ae555e6ecbdb2bfe6613e33) |
| Functions visibility                  | [Ex06](src/ex06.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x060987aea322cd12657588b6cdb0892db79322ab4533f7d74838ff2e2614a015) | [Link](https://goerli.voyager.online/contract/0x060987aea322cd12657588b6cdb0892db79322ab4533f7d74838ff2e2614a015) |
| Comparing values                      | [Ex07](src/ex07.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x006051096480f375894eebb99948bce14a84c25093636c4b4e8222cc32a67cf0) | [Link](https://goerli.voyager.online/contract/0x006051096480f375894eebb99948bce14a84c25093636c4b4e8222cc32a67cf0) |
| Recursions level 1                    | [Ex08](src/ex08.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x01ec8e981b1b6a7256a71f21790dd07cafeb15d02c18534a2bd4a6c8551860aa) | [Link](https://goerli.voyager.online/contract/0x01ec8e981b1b6a7256a71f21790dd07cafeb15d02c18534a2bd4a6c8551860aa) |
| Recursions level 2                    | [Ex09](src/ex09.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x053b96c4ee027c53ea001479f24c10b543063e3c26d037c600e5bd31f0b21e5c) | [Link](https://goerli.voyager.online/contract/0x053b96c4ee027c53ea001479f24c10b543063e3c26d037c600e5bd31f0b21e5c) |
| Composability                         | [Ex10](src/ex10.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x0763e89551900eba82d757a9f3862935cc7f7e47538f01ddba514f23d9a5f6e0) | [Link](https://goerli.voyager.online/contract/0x0763e89551900eba82d757a9f3862935cc7f7e47538f01ddba514f23d9a5f6e0) |
| Importing functions                   | [Ex11](src/ex11.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x029a9a484d22a6353eff0d60ea56c6ffabaaac5e4889182287ef1d261578b197) | [Link](https://goerli.voyager.online/contract/0x029a9a484d22a6353eff0d60ea56c6ffabaaac5e4889182287ef1d261578b197) |
| Events                                | [Ex12](src/ex12.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x04a221a8e3155fb03d1708881213a2ecdb05a41cf0ae6de83ddcf8f12bb04282) | [Link](https://goerli.voyager.online/contract/0x04a221a8e3155fb03d1708881213a2ecdb05a41cf0ae6de83ddcf8f12bb04282) |
| Privacy on Starknet                   | [Ex13](src/ex13.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x067ed1d23c5cc3a34fb86edd4f8415250c79a374e87bcf2e6870321261ca9b0f) | [Link](https://goerli.voyager.online/contract/0x067ed1d23c5cc3a34fb86edd4f8415250c79a374e87bcf2e6870321261ca9b0f) |
| Multicall                             | [Ex14](src/ex14.cairo)                          | [Link](https://testnet.starkscan.co/contract/0x031e9a701a24c1d2ecd576208087dfa52f1025072cf11e54407300f64f95ce5f) | [Link](https://goerli.voyager.online/contract/0x031e9a701a24c1d2ecd576208087dfa52f1025072cf11e54407300f64f95ce5f) |

### 4. Ihre Punkte zählen und Ihren Fortschritt überprüfen

Ihre Punkte werden Ihrem Wallet gutgeschrieben, dies kann jedoch einige Zeit dauern. Wenn Sie Ihren Punktestand in Echtzeit verfolgen möchten, können Sie auch Ihr Guthaben in einem Block Explorer überprüfen!
Gehen Sie zum ERC20-Zähler auf Voyager  [Voyager](https://goerli.voyager.online/contract/0x044f65adbdb59bf1db71e8b69efb7c9d0b810db94c1730a05fa5751b02d396de) oder [Starkscan]

(https://testnet.starkscan.co/contract/0x044f65adbdb59bf1db71e8b69efb7c9d0b810db94c1730a05fa5751b02d396de) im Tab "Vertrag lesen".
Geben Sie Ihre Adresse in die Funktion balanceOf ein.
Viel Spaß beim Workshop! Wenn Sie Fragen haben, können Sie uns gerne auf Discord [Discord](https://starknet.io/discord) kontaktieren. Wir helfen Ihnen gerne weiter!

---

Beitrag zur Verbesserung dieses Workshops
Dieses Projekt kann verbessert und weiterentwickelt werden. Ihre Beiträge sind willkommen! Gehen Sie zur CONTRIBUTING-Datei [CONTRIBUTING](CONTRIBUTING.md) , um mehr darüber zu erfahren, wie Sie Ihre Umgebung einrichten und zum Projekt beitragen können.

 file for more information on how to setup your environment and contribute to the project.

Hier sind einige Dinge, die Sie tun können, um zu helfen:

Erstellen Sie einen Branch mit einer Übersetzung in Ihre Sprache
Korrigieren Sie Fehler, wenn Sie welche finden
Fügen Sie eine Erklärung in den Kommentaren der Übung hinzu, wenn Sie denken, dass sie mehr Erklärung benötigt
Fügen Sie Übungen hinzu, die Ihr Lieblingsmerkmal von Cairo zeigen
Fügen Sie der Serie ein neues Tutorial hinzu
Andere Automatisierte Workshops
Dieser Workshop ist der erste einer Reihe, die darauf abzielt, zu lehren, wie man auf Starknet aufbaut. Schauen Sie sich andere Workshops in der Reihe an:

| Topic                                       | GitHub repo                                                                            |
| ------------------------------------------- | -------------------------------------------------------------------------------------- |
| Learn how to read Cairo code (you are here) | [Cairo 101](https://github.com/starknet-edu/starknet-cairo-101)                        |
| Deploy and customize an ERC721 NFT          | [Starknet ERC721](https://github.com/starknet-edu/starknet-erc721)                     |
| Deploy and customize an ERC20 token         | [Starknet ERC20](https://github.com/starknet-edu/starknet-erc20)                       |
| Build a cross-layer application             | [Starknet messaging bridge](https://github.com/starknet-edu/starknet-messaging-bridge) |
| Debug your Cairo contracts easily           | [Starknet debug](https://github.com/starknet-edu/starknet-debug)                       |
| Design your own account contract            | [Starknet account abstraction](https://github.com/starknet-edu/starknet-accounts)      |


# Rückmeldung geben & Hilfe erhalten

Sobald Sie mit diesem Tutorial fertig sind, wird Ihre Rückmeldung sehr geschätzt!

Bitte füllen Sie dieses Formular [this form](https://forms.reform.app/starkware/untitled-form-4/kaes2e) aus, um uns mitzuteilen, was wir tun können, um es besser zu machen.

Und wenn Sie Schwierigkeiten haben, voranzukommen, lassen Sie es uns wissen! Dieser Workshop soll so zugänglich wie möglich sein; wir möchten sehen, ob dies nicht der Fall ist.

Haben Sie eine Frage? Treten Sie unserem Discord-Server bei [Discord server](https://starknet.io/discord), registrieren Sie sich und treten Sie dem Kanal #tutorials-support bei.

Interessieren Sie sich für die Teilnahme an Online-Workshops über die Entwicklung auf Starknet? Abonnieren Sie hier [Subscribe here](https://starknet.substack.com/)
