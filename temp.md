# Deploying the tutorial
## Deployed addresses and class hashes
starknet call --function balanceOf --address 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 --input 0x0360C4F27Bd9af2a05b416ff573738E8587883862A90965A1716DfA9D17F3E79

| Contract | Class hash | Deployed contract | Permissions |
| ------------------------------------- | ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| Players registry | 0x7a6e514bb54d60ac1cfe8c53a872fbc23ebf25137d093c23c3bf01a6ae5b1c6 | 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba | Ok |
| TDERC20 | 0x14f38e5454fbdec31b41ac5d36641cdfdc6d8ac6a33226c3416a968972e55b0 | 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 | Ok |
| Ex01 | 0xe200aa0be9e2ff98cb8f3922f82b9508c24017207cc637f2f1193e79ca803e | 0x07d3f3dce413a97c500b7af5f5010b230d85feafcda0590bd4dd388f65853161 | Ok |
| Ex02 | 0x4070836bc88356c93b78ff9abf295986543c48cae1aecb5d222d1a8b6092c0a | 0x04293bfdeb6716f44b7a510265c5bbfae68c2f9bc164aa88c02cf05e284325a2 | Ok |
| Ex03 | 0x2deedb948926e551309bed476ca866b56dc7849760b02ef9ce31356a0ea4e4f | 0x01d96c6de16807d5ecc441c335bb8603391dc13e36c253bd4f219d38997ba4c2 | Ok |
| Ex04 | 0x9d9b18fda9d397eaa886bcbdb53a384199246bf2510893c1c403c673b44b1c | 0x065483dffa95f87f25db83948b2d70c62ca0a7ac8895492d354c52ba5a1c8dd0 | Ok |
| Ex05 | 0x696efe990401c8457a60a32519253a13c2c58427f2e1ce6d42add395c4e13e8 | 0x0323ee29762f8165ecf299134ba775431b86fd426495a3202abbe6534711648d | Ok |
| Ex06 | 0x46f788c1295093b700a745fef0a4fc7da1348d5208435b715ab20a3400eb1e3 | 0x040315f6d0f98ed2a9826772b7744bd0294c842bfd3823bad4f12c19a71fe1e6 | Ok |
| Ex07 | 0x076c22e5d4c10804d28506e4c14f470fc48d168af5fcbb31472ab48bc31d610f | 0x0418fb3f6c8ca579875a354b97a397400ddea5eb7dcccf3401b0c2574eab9a3b | Ok |
| Ex08 | 0x6ba4fbc0462425ff3f3d66da3d125d803f68ef29a3e32942866db726003b29c | 0x0006dac4a1e842b0415855241d555b2c207c939d12e64226fa87c8032fdb7519 | Ok |
| Ex09 | 0x10581227a879aa9a02d90319c6e9ca33448c7f73fa9d99b03087e273d55a2ec | 0x056aa19afb0e5c621ae369edc08a20f36a5dfaaf6e7ebc63338303e06ab8aff1 | Ok |
| Ex10 | 0x334e1e4d148a789fb44367eff869a6330693037983ba6fd2291b2be1249e15a | 0x0307dbe1012a45617af8a708266eb3c300ab3bf9efe3d6e5a2a5693999daa962 | Ok |
| Ex10b | 0x32a35c4bf9c8148689002ca501c973a135a30457c6507e28261bed0c3a1f35 | 0x05f16f4b1c41dedd693f161cbeb10f16f8adc189982c5d33991d232afb2c49ad | Ok |
| Ex11 | 0x06eb622294fbf3e7e3d10abdd51565a5fd75a3a41a95f7f34e4f560687b9b6d6 |  |  |
| Ex12 | 0x5d22220dc9cdb39480fe641b0dd5cdc6c7662db73c3935a43bffe8f100cf240 |  |  |
| Ex13 | 0x6ce1d974d285a624411d17c0fa0184a9d018feb23a24d386d5b4f93b7cbe047 |  |  |
| Ex14 | 0x03c1872bae0e57d9a9bd087ac87eebcf8153d1b0ef66d12a9fb42075fd9c2c4e |  |  |


## Useful commands
Setting venv and env variables
```bash
source ~/cairo_venv_v11/bin/activate
export STARKNET_NETWORK=alpha-goerli
export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount
```
Declaring ex 1
```bash
starknet declare --contract target/release/starknet_cairo_101_Ex14.json --account version_11
```
Deploying players registry and ERC20 and checking admin is registered
```bash
# Players registry
starknet deploy --class_hash 0x07a6e514bb54d60ac1cfe8c53a872fbc23ebf25137d093c23c3bf01a6ae5b1c6 --inputs 0x0360C4F27Bd9af2a05b416ff573738E8587883862A90965A1716DfA9D17F3E79 --account version_11 --max_fee 100000000000000000
#ERC20
starknet deploy --class_hash 0x14f38e5454fbdec31b41ac5d36641cdfdc6d8ac6a33226c3416a968972e55b0 --inputs 67657382794945494849 67657382794945494849 18 0 0 0x0360C4F27Bd9af2a05b416ff573738E8587883862A90965A1716DfA9D17F3E79 0x0360C4F27Bd9af2a05b416ff573738E8587883862A90965A1716DfA9D17F3E79 --account version_11 --max_fee 100000000000000000
starknet call --function is_exercise_or_admin --address 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba --input 0x01d96c6de16807d5ecc441c335bb8603391dc13e36c253bd4f219d38997ba4c2
starknet call --function is_teacher_or_exercise --address 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 --input 0x01d96c6de16807d5ecc441c335bb8603391dc13e36c253bd4f219d38997ba4c2
```
Declaring exercices
```bash
# Ex01
starknet deploy --class_hash 0xe200aa0be9e2ff98cb8f3922f82b9508c24017207cc637f2f1193e79ca803e --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 1 --account version_11 --max_fee 100000000000000000
# Ex02
starknet deploy --class_hash 0x4070836bc88356c93b78ff9abf295986543c48cae1aecb5d222d1a8b6092c0a --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 2 107101107 --account version_11 --max_fee 100000000000000000
# Ex03
starknet deploy --class_hash 0x2deedb948926e551309bed476ca866b56dc7849760b02ef9ce31356a0ea4e4f --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 3 --account version_11 --max_fee 100000000000000000
# Ex04
starknet deploy --class_hash 0x9d9b18fda9d397eaa886bcbdb53a384199246bf2510893c1c403c673b44b1c --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 4 --account version_11 --max_fee 100000000000000000
# Ex 05
starknet deploy --class_hash 0x696efe990401c8457a60a32519253a13c2c58427f2e1ce6d42add395c4e13e8 --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 5 --account version_11 --max_fee 100000000000000000
# Ex06
starknet deploy --class_hash 0x46f788c1295093b700a745fef0a4fc7da1348d5208435b715ab20a3400eb1e3 --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 6 --account version_11 --max_fee 100000000000000000
# Ex07
starknet deploy --class_hash 0x076c22e5d4c10804d28506e4c14f470fc48d168af5fcbb31472ab48bc31d610f --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 7 --account version_11 --max_fee 100000000000000000
# Ex08
starknet deploy --class_hash 0x6ba4fbc0462425ff3f3d66da3d125d803f68ef29a3e32942866db726003b29c --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 8 --account version_11 --max_fee 100000000000000000
# Ex09
starknet deploy --class_hash 0x10581227a879aa9a02d90319c6e9ca33448c7f73fa9d99b03087e273d55a2ec --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 9 --account version_11 --max_fee 100000000000000000
# Ex10
starknet deploy --class_hash 0x334e1e4d148a789fb44367eff869a6330693037983ba6fd2291b2be1249e15a --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 10 --account version_11 --max_fee 100000000000000000
# Ex10b
starknet deploy --class_hash 0x32a35c4bf9c8148689002ca501c973a135a30457c6507e28261bed0c3a1f35 --inputs 0x0307dbe1012a45617af8a708266eb3c300ab3bf9efe3d6e5a2a5693999daa962 --account version_11 --max_fee 100000000000000000
# Ex11
starknet deploy --class_hash 0x06eb622294fbf3e7e3d10abdd51565a5fd75a3a41a95f7f34e4f560687b9b6d6 --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 11 --account version_11 --max_fee 100000000000000000
# Ex 12
starknet deploy --class_hash 0x5d22220dc9cdb39480fe641b0dd5cdc6c7662db73c3935a43bffe8f100cf240 --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 12 --account version_11 --max_fee 100000000000000000
# Ex 14
starknet deploy --class_hash 0x3c1872bae0e57d9a9bd087ac87eebcf8153d1b0ef66d12a9fb42075fd9c2c4e --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 14 --account version_11 --max_fee 100000000000000000
```
Adding exercices as admin in ERC20 and players registry. Added things through a block explorer. To check the status:
```bash
# ERC20
starknet call --function is_exercise_or_admin --address 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba --input 0x042b34fe6f5e03d25c0adfdf7149ce21942f725f94dbfe4454e9ea793ff99cb8
starknet call --function is_teacher_or_exercise --address 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 --input 0x042b34fe6f5e03d25c0adfdf7149ce21942f725f94dbfe4454e9ea793ff99cb8

```
Setting random values
```bash
starknet invoke --function set_random_values --address 0x065483dffa95f87f25db83948b2d70c62ca0a7ac8895492d354c52ba5a1c8dd0 --input 100 509 7151 5476 3518 3472 1072 2672 1522 2451 4950 9493 6340 6911 3571 7159 111 5431 3695 1758 4928 5139 6549 2252 1068 1624 480 6659 7521 9588 8679 1091 4111 5113 5727 4376 5287 5718 7204 8537 7240 3457 455 685 3467 9279 7243 1571 5229 3683 9881 622 4622 7388 4811 2961 7321 2199 3362 7477 9380 4547 8696 5393 3719 1001 699 646 824 3133 1946 89 2980 8677 6857 2800 8920 1224 2189 6094 2932 5363 4795 192 2695 853 6569 6941 7967 5070 2585 4675 3048 444 2487 5451 6121 945 9343 5757 9193 --account version_11 --max_fee 100000000000000000

starknet invoke --function set_random_values --address 0x0323ee29762f8165ecf299134ba775431b86fd426495a3202abbe6534711648d --input 100 9760 8893 9155 1504 3558 5806 3145 8537 9798 1834 7969 8581 2448 9523 2435 9242 5081 8715 4195 6467 1218 8174 2955 9996 4129 8850 512 3215 7527 2373 9350 2872 9705 4779 2068 7184 5795 4942 8624 1927 4821 5234 9554 1503 1963 2490 925 8189 4138 9562 8507 5719 2976 131 7059 6648 4584 6839 9692 8072 2047 4929 9464 4557 8502 173 4404 1511 1958 2814 7708 3867 7408 114 1805 5990 4761 1797 8443 8075 4903 597 5980 7592 9607 3224 7164 8408 6744 6689 6120 3494 6485 519 3526 9327 2334 9125 4709 9798 --account version_11 --max_fee 100000000000000000

starknet invoke --function set_random_values --address 0x040315f6d0f98ed2a9826772b7744bd0294c842bfd3823bad4f12c19a71fe1e6 --input 100 8308 5970 1409 7875 8633 6802 4987 2249 8843 3546 2519 5738 214 5185 6229 4843 8604 5121 4495 40 8045 3028 1327 8160 9376 6845 5219 6010 2220 253 5913 8682 1031 6173 690 1235 8918 5215 2276 1228 4315 9814 4099 9322 9672 5389 5795 9779 4535 5385 3787 6393 5306 7019 5447 7366 9283 7893 5210 2696 323 1824 2665 6720 7457 2627 1784 2730 2100 7622 8957 3193 8833 6583 428 5015 9026 6353 8905 5935 3224 7475 5910 5129 8137 9669 5646 4841 2318 7741 2280 9086 5248 7178 4496 1003 934 2803 9022 8656 --account version_11 --max_fee 100000000000000000



```


# Earlier notes

================================================================================================================================================
starknet declare --contract target/release/starknet_cairo_101_Ex11.json --account version_11 --max_fee 100000000000000000
Declare transaction was sent.
Contract class hash: 0x06eb622294fbf3e7e3d10abdd51565a5fd75a3a41a95f7f34e4f560687b9b6d6
Transaction hash: 0x03b9a3e0d9f3020c9fea9289005ef4f371e87ce0c60a330dbf929dea935972ed

starknet deploy --class_hash 0x06eb622294fbf3e7e3d10abdd51565a5fd75a3a41a95f7f34e4f560687b9b6d6 --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 11 --account version_11 --max_fee 100000000000000000


Error in the called contract (0x498a667ab7cff4bd5cefd8d1676759ddd265be5aef3b94ecf7a9dfe616b933d):
Error at pc=0:45:
Got an exception while executing a hint.
Cairo traceback (most recent call last):
Unknown location (pc=0:597)
Unknown location (pc=0:568)

Error in the called contract (0x636341d4c65fb0d94dd24acbaf2defa7f495458e4a66fa756a15fe4aae208f8):
Execution was reverted; failure reason: [0x753132385f66726f6d204f46].

Text: u128_from OF

================================================================================================================================================
starknet declare --contract target/release/starknet_cairo_101_Ex12.json --account version_11 --max_fee 99999999999999
Declare transaction was sent.
Contract class hash: 0x49c061584d80522c8b09967250366f0196b6d3b45d8bba66ea67be5f167ee61
Transaction hash: 0x10bc5101651e2fcdc316610bf2b9e750c9eea672bba5976ab69de7d7b6dff50

starknet deploy --class_hash 0x49c061584d80522c8b09967250366f0196b6d3b45d8bba66ea67be5f167ee61 --inputs 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba 1 12 --account version_11 --max_fee 99999999999999
Invoke transaction for contract deployment was sent.
Contract address: 0x0405aefc0cae97e11a70173bdff1b373e37c1fb01422383e18b9fef1c2d3a456
Transaction hash: 0x3ae53a49d5e329d8679830cdadbfd6e7797deed78783508a20fec646bd8029e

================================================================================================================================================
starknet declare --contract target/release/starknet_cairo_101_Ex13.json --account version_11 --max_fee 99999999999999
Declare transaction was sent.
Contract class hash: 0x250ad5f71e40b47fcc2afe41a0ce454de09b7d54e69374cd743aa68e12ae3b4
Transaction hash: 0x2a946c963bba5d5d731e4b314b74707fb144b4b7a666194631ebbb749b982de

starknet deploy --class_hash 0x250ad5f71e40b47fcc2afe41a0ce454de09b7d54e69374cd743aa68e12ae3b4 --inputs 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba 1 13 9346 7890 2346 6748 --account version_11 --max_fee 99999999999999
Invoke transaction for contract deployment was sent.
Contract address: 0x0181f3c6519d3ebd5bf0af2f42edf4cb007645b663f3a0f938bc6cca6e0a4be6
Transaction hash: 0x374d86507d3ffb21801e71e7e1c452934946ba3e568c5cc413a820956d226e8

tx_failure_reason": {
        "code": "TRANSACTION_FAILED",
        "error_message": "Error at pc=0:32:\nGot an exception while executing a hint.\nCairo traceback (most recent call last):\nUnknown location (pc=0:557)\nUnknown location (pc=0:519)\nUnknown location (pc=0:625)\n\nError in the called contract (0x498a667ab7cff4bd5cefd8d1676759ddd265be5aef3b94ecf7a9dfe616b933d):\nError at pc=0:45:\nGot an exception while executing a hint.\nCairo traceback (most recent call last):\nUnknown location (pc=0:597)\nUnknown location (pc=0:568)\n\nError in the called contract (0x181f3c6519d3ebd5bf0af2f42edf4cb007645b663f3a0f938bc6cca6e0a4be6):\nExecution was reverted; failure reason: [0x496e70757420746f6f2073686f727420666f7220617267756d656e7473]."
    },



================================================================================================================================================
starknet declare --contract target/release/starknet_cairo_101_Ex14.json --account version_11 --max_fee 100000000000000000
Declare transaction was sent.
Contract class hash: 0x03c1872bae0e57d9a9bd087ac87eebcf8153d1b0ef66d12a9fb42075fd9c2c4e
Transaction hash: 0x025342247b18e95bb344316e72c81e1e380e78446fdccd3cedd7cf8d1b49b2c0

starknet deploy --class_hash 0x03c1872bae0e57d9a9bd087ac87eebcf8153d1b0ef66d12a9fb42075fd9c2c4e --inputs 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 14 --account version_11 --max_fee 100000000000000000
Invoke transaction for contract deployment was sent.
Contract address: 0x0228a48ec35c161a70e417f54145d9a9dc0ad274dd83750041ef5d22a677bc75
Transaction hash: 0x57007de85ea8cc61e4fc41ce9d92a9042cabe1c4d8366dbf7829cde2f63caea
