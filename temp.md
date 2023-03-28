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
| Ex04 | 0x371a4c938207f35345caed7b4ee411a5d1e891addf0ef6b1ca4c08ff06ad2b7 | 0x0486558e921a07bae6c688995c1f6097cfd0a870b22812d270fc571af1a10626 | Ok, need rand value store | 
| Ex05 | 0x514aa2c7131db6e742689d2c89a2c1e2073227a0caac00dd39c4ab44fed28c | 0x0652b8c31e6c35ef8573fa78ff65deb6aa252c55e122d8392f630c5f72d48757 | Ok, need rand value store | 
| Ex06 | 0x444297f4b671700e6d4b970ed75ddda1b9c38b2ac89099a7affbbf8ef764f61 | 0x0690c84f71416eee8b98ae6fb2187d09ff5918985643520141292a4c9de4d271 | Ok, need rand value store | 
| Ex07 | 0x076c22e5d4c10804d28506e4c14f470fc48d168af5fcbb31472ab48bc31d610f | 0x0418fb3f6c8ca579875a354b97a397400ddea5eb7dcccf3401b0c2574eab9a3b | Ok | 
| Ex08 | 0x6ba4fbc0462425ff3f3d66da3d125d803f68ef29a3e32942866db726003b29c | 0x0006dac4a1e842b0415855241d555b2c207c939d12e64226fa87c8032fdb7519 | Ok | 
| Ex09 | 0x10581227a879aa9a02d90319c6e9ca33448c7f73fa9d99b03087e273d55a2ec | 0x056aa19afb0e5c621ae369edc08a20f36a5dfaaf6e7ebc63338303e06ab8aff1 | Ok | 
| Ex10 | 0x334e1e4d148a789fb44367eff869a6330693037983ba6fd2291b2be1249e15a | 0x0307dbe1012a45617af8a708266eb3c300ab3bf9efe3d6e5a2a5693999daa962 | Ok | 
| Ex10b | 0x32a35c4bf9c8148689002ca501c973a135a30457c6507e28261bed0c3a1f35 | 0x05f16f4b1c41dedd693f161cbeb10f16f8adc189982c5d33991d232afb2c49ad | Ok | 
| Ex11 | 0x06eb622294fbf3e7e3d10abdd51565a5fd75a3a41a95f7f34e4f560687b9b6d6 |  |  | 
| Ex12 | 0x49c061584d80522c8b09967250366f0196b6d3b45d8bba66ea67be5f167ee61 | 0x042b34fe6f5e03d25c0adfdf7149ce21942f725f94dbfe4454e9ea793ff99cb8 |  | 
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
starknet deploy --class_hash 0x371a4c938207f35345caed7b4ee411a5d1e891addf0ef6b1ca4c08ff06ad2b7 --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 4 --account version_11 --max_fee 100000000000000000
# Ex 05
starknet deploy --class_hash 0x514aa2c7131db6e742689d2c89a2c1e2073227a0caac00dd39c4ab44fed28c --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 5 --account version_11 --max_fee 100000000000000000
# Ex06
starknet deploy --class_hash 0x444297f4b671700e6d4b970ed75ddda1b9c38b2ac89099a7affbbf8ef764f61 --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 6 --account version_11 --max_fee 100000000000000000
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
starknet deploy --class_hash 0x49c061584d80522c8b09967250366f0196b6d3b45d8bba66ea67be5f167ee61 --inputs 0x021a7050c83b4282d9194bb70d302673c00845a3ccfe8d9608e6a55f4a429b11 0x0726c21564e9666d0957c6e2a6b63056c9fa280cf05f01b690b3acc7c974a5ba 1 12 --account version_11 --max_fee 100000000000000000
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
starknet invoke --function set_random_values --address 0x0486558e921a07bae6c688995c1f6097cfd0a870b22812d270fc571af1a10626 --input 100 509 7151 5476 3518 3472 1072 2672 1522 2451 4950 9493 6340 6911 3571 7159 111 5431 3695 1758 4928 5139 6549 2252 1068 1624 480 6659 7521 9588 8679 1091 4111 5113 5727 4376 5287 5718 7204 8537 7240 3457 455 685 3467 9279 7243 1571 5229 3683 9881 622 4622 7388 4811 2961 7321 2199 3362 7477 9380 4547 8696 5393 3719 1001 699 646 824 3133 1946 89 2980 8677 6857 2800 8920 1224 2189 6094 2932 5363 4795 192 2695 853 6569 6941 7967 5070 2585 4675 3048 444 2487 5451 6121 945 9343 5757 9193 --account version_11
================================================================================================================================================

starknet declare --contract target/release/starknet_cairo_101_PlayersRegistry.json --account version_11
Declare transaction was sent.
Contract class hash: 0x07a6e514bb54d60ac1cfe8c53a872fbc23ebf25137d093c23c3bf01a6ae5b1c6
Transaction hash: 0x06e3c0e562502c1d3a0a17b5875f6d083214555a4bb13d3fb00b37d20da1afb0

starknet deploy --class_hash 0x07a6e514bb54d60ac1cfe8c53a872fbc23ebf25137d093c23c3bf01a6ae5b1c6 --inputs 0x0360C4F27Bd9af2a05b416ff573738E8587883862A90965A1716DfA9D17F3E79 --account version_11 --max_fee 100000000000000000
Sending the transaction with max_fee: 0.000000 ETH (318891749831 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba
Transaction hash: 0x347c6d3227214ae1894d9b1dc1193a0c07e812a407b91e1ab1000ea094a01e7

starknet invoke \
    --address 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba \
    --function set_exercise_or_admin \
    --inputs 0x0360C4F27Bd9af2a05b416ff573738E8587883862A90965A1716DfA9D17F3E79 1 \
    --account seabook \
    --max_fee 99999999999999

starknet call \
    --address 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba \
    --function is_exercise_or_admin \
    --inputs 0x0360C4F27Bd9af2a05b416ff573738E8587883862A90965A1716DfA9D17F3E79

================================================================================================================================================

starknet declare --contract target/release/starknet_cairo_101_TDERC20.json --account version_11
Declare transaction was sent.
Contract class hash: 0x3cb11b63613e69bda2df91d82ae52690336888489611faac5a0eecf6ca710ed
Transaction hash: 0x11b4733c8d48073c6bad1b374e2816124caf7850b1310f8553993c1721379c5

starknet deploy --class_hash 0x03cb11b63613e69bda2df91d82ae52690336888489611faac5a0eecf6ca710ed --inputs 10057515165931654559836545801321088512241713 357609582641 18 1000000000000000000 0 0x04b22f492ade0853a8586e003978976ed19e4bcbc8df133b0f98ea768c80dd10 0x04b22f492ade0853a8586e003978976ed19e4bcbc8df133b0f98ea768c80dd10 --account version_11
Sending the transaction with max_fee: 0.000020 ETH (19599750527527 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86
Transaction hash: 0x508bc547e15b8a4aaf7fef68f4056b377ea2cfb73575c1d16e4abddd2b23068

starknet invoke \
    --address 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 \
    --function set_teacher \
    --inputs 0x0360C4F27Bd9af2a05b416ff573738E8587883862A90965A1716DfA9D17F3E79 1 \
    --account seabook \
    --max_fee 99999999999999

starknet call \
    --address 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 \
    --function is_teacher_or_exercise \
    --inputs 0x0360C4F27Bd9af2a05b416ff573738E8587883862A90965A1716DfA9D17F3E79

starknet call \
    --address 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 \
    --function balanceOf \
    --inputs 0x04b22f492ade0853a8586e003978976ed19e4bcbc8df133b0f98ea768c80dd10

================================================================================================================================================

starknet declare --contract target/release/starknet_cairo_101_Ex01.json --account version_11 --max_fee 99999999999999
Declare transaction was sent.
Contract class hash: 0xe200aa0be9e2ff98cb8f3922f82b9508c24017207cc637f2f1193e79ca803e
Transaction hash: 0x720d8b1a00da9e7701fde07043c690f60198c6f5286c8275920f30320bdb89

starknet deploy --class_hash 0xe200aa0be9e2ff98cb8f3922f82b9508c24017207cc637f2f1193e79ca803e --inputs 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba 1 1 --account version_11
Sending the transaction with max_fee: 0.000462 ETH (461960137007331 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x01e6f43dc65874c5a97d32077e5ad07bbaff788a52209f66e1d9d7f3559998be
Transaction hash: 0x7ca6be937f27d09c183cffb47ab6216ad0fc8b9523d4b6be5819ae8f789cd41

starknet invoke \
    --address 0x01e6f43dc65874c5a97d32077e5ad07bbaff788a52209f66e1d9d7f3559998be \
    --function update_class_hash \
    --inputs 0x0360C4F27Bd9af2a05b416ff573738E8587883862A90965A1716DfA9D17F3E79 \
    --account version_11 \
    --max_fee 99999999999999

================================================================================================================================================

starknet declare --contract target/release/starknet_cairo_101_Ex02.json --account version_11 --max_fee 99999999999999
Declare transaction was sent.
Contract class hash: 0x4070836bc88356c93b78ff9abf295986543c48cae1aecb5d222d1a8b6092c0a
Transaction hash: 0x970a79160bad7c51753cb514571f14422fdfd913bc94a00d47bda8ee8319ba

starknet deploy --class_hash 0x4070836bc88356c93b78ff9abf295986543c48cae1aecb5d222d1a8b6092c0a --inputs 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba 1 2 031020 --account version_11
Sending the transaction with max_fee: 0.000149 ETH (148526940013175 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x00ca56b5bca3334e57be34470457db090ea113b0aa61583daca6ac03b760be83
Transaction hash: 0x13f436e757b6c29830812632fa75cd34d7253c62af64608f6527eb2e03efdde

================================================================================================================================================
starknet declare --contract target/release/starknet_cairo_101_Ex03.json --account version_11 --max_fee 99999999999999
Declare transaction was sent.
Contract class hash: 0x2deedb948926e551309bed476ca866b56dc7849760b02ef9ce31356a0ea4e4f
Transaction hash: 0x18ea70b5c1b9ca4447d75969c24528bfe40789144ed2d8d48f139b4c6f04f06

starknet deploy --class_hash 0x2deedb948926e551309bed476ca866b56dc7849760b02ef9ce31356a0ea4e4f --inputs 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba 1 3 --account version_11
Sending the transaction with max_fee: 0.000129 ETH (128563861877375 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x04ef05502d3af27c0bfa0eab55f3dc6aaad36524bcc65d024e662323d103598f
Transaction hash: 0x3998aeb34f7b47b2ada2c4772faddec988d55ba91e52d5abf8a30d25fa422d5

================================================================================================================================================
starknet declare --contract target/release/starknet_cairo_101_Ex04.json --account version_11 --max_fee 99999999999999
Declare transaction was sent.
Contract class hash: 0x371a4c938207f35345caed7b4ee411a5d1e891addf0ef6b1ca4c08ff06ad2b7
Transaction hash: 0xf8690e7f38d3334674b9051a23225f4013c5af12fbfb27c26f78410eb5965c

starknet deploy --class_hash 0x371a4c938207f35345caed7b4ee411a5d1e891addf0ef6b1ca4c08ff06ad2b7 --inputs 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba 1 4 --account version_11
Sending the transaction with max_fee: 0.000129 ETH (128563861877375 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x05a429c52a2b333018634f6cb3dae5293898c442eded4a72605e0b4e6eaa18d2
Transaction hash: 0x06e3428e9ef035483cc1c75ba33b2bd854b67820bb70d37c88ffb5d9042bfe32

================================================================================================================================================
starknet declare --contract target/release/starknet_cairo_101_Ex05.json --account version_11 --max_fee 99999999999999
Declare transaction was sent.
Contract class hash: 0x514aa2c7131db6e742689d2c89a2c1e2073227a0caac00dd39c4ab44fed28c
Transaction hash: 0x4b44a4be2b34119d535e7ac835e51ceca1e51efff46b4523fe54af6b34d0c41

starknet deploy --class_hash 0x514aa2c7131db6e742689d2c89a2c1e2073227a0caac00dd39c4ab44fed28c --inputs 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba 1 5 --account version_11 --max_fee 99999999999999
Invoke transaction for contract deployment was sent.
Contract address: 0x0414b4deeae93e4114b4292daed85e53bd0da51f6a804d1dcf1830c8fd79a0cb
Transaction hash: 0x3da3989993243dc10984b9ab7460000597d3287758c5c606c20a1b858cc2a19

================================================================================================================================================
starknet declare --contract target/release/starknet_cairo_101_Ex06.json --account version_11 --max_fee 99999999999999
Declare transaction was sent.
Contract class hash: 0x444297f4b671700e6d4b970ed75ddda1b9c38b2ac89099a7affbbf8ef764f61
Transaction hash: 0x25b7578902a17ded115f11fa76656836975a54e155f7b19f561266e5f75a358


starknet deploy --class_hash 0x444297f4b671700e6d4b970ed75ddda1b9c38b2ac89099a7affbbf8ef764f61 --inputs 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba 1 6 --account version_11 --max_fee 99999999999999
Invoke transaction for contract deployment was sent.
Contract address: 0x07b051ce0a6d22545232867baf280c0fb494d743b2099689b381025963744a46
Transaction hash: 0x344140f0381369ff280d59f878ed60c7878a4e4f1bd8876cfd62f2380460223

================================================================================================================================================
starknet declare --contract target/release/starknet_cairo_101_Ex07.json --account version_11 --max_fee 99999999999999
Declare transaction was sent.
Contract class hash: 0x076c22e5d4c10804d28506e4c14f470fc48d168af5fcbb31472ab48bc31d610f
Transaction hash: 0x056522845795ee42a76aeca6b6a4676cccf481c2d329fa098df71b7fcbd54fbc

starknet deploy --class_hash 0x076c22e5d4c10804d28506e4c14f470fc48d168af5fcbb31472ab48bc31d610f --inputs 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba 1 7 --account version_11
Sending the transaction with max_fee: 0.000209 ETH (209057754706494 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x011a9cb48c4d0914a703ba35fd3df6025e9da184d152b93c4f9f1ee2ea23dc1a
Transaction hash: 0x7cd1653a232e50d3792f0fbb669e917a1c4ebb4982ba0b6fbf2b0e16f0d61d3

================================================================================================================================================
starknet declare --contract target/release/starknet_cairo_101_Ex08.json --account version_11 --max_fee 99999999999999
Declare transaction was sent.
Contract class hash: 0x6ba4fbc0462425ff3f3d66da3d125d803f68ef29a3e32942866db726003b29c
Transaction hash: 0x31940e2b857d6908429a11b922206aa0e24a25086012dbfdcdb3824c09423b4


starknet deploy --class_hash 0x6ba4fbc0462425ff3f3d66da3d125d803f68ef29a3e32942866db726003b29c --inputs 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba 1 8 --account version_11 --max_fee 99999999999999
Invoke transaction for contract deployment was sent.
Contract address: 0x00959b5c51ec313a5ea7fb7e7481562ec717c8234a1525cd1d037a855fecc667
Transaction hash: 0x2d042427e8be72854b989ba537f3e5535d3efcdb3651e1cd77dc31bf9980fbe

================================================================================================================================================
starknet declare --contract target/release/starknet_cairo_101_Ex09.json --account version_11 --max_fee 99999999999999
Declare transaction was sent.
Contract class hash: 0x10581227a879aa9a02d90319c6e9ca33448c7f73fa9d99b03087e273d55a2ec
Transaction hash: 0x403a4399fe979b1ed411a81c6c4a0c308f1ab43c98d792f90717125c9c96d55


starknet deploy --class_hash 0x10581227a879aa9a02d90319c6e9ca33448c7f73fa9d99b03087e273d55a2ec --inputs 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba 1 9 --account version_11 --max_fee 99999999999999
Invoke transaction for contract deployment was sent.
Contract address: 0x034a266212353f67c3f437a3636ca8b8bc7e0958e7fc07757c7af1c100c99e69
Transaction hash: 0x73a0a4f4b654d1ee08a7864f055990af725f468c5e3b2ddd9f356908e1b0096


================================================================================================================================================
starknet declare --contract target/release/starknet_cairo_101_Ex10.json --account version_11 --max_fee 99999999999999
Declare transaction was sent.
Contract class hash: 0x334e1e4d148a789fb44367eff869a6330693037983ba6fd2291b2be1249e15a
Transaction hash: 0x77d039448b0e01a6d30e85707b372ed5d459ba1c1fd3506152b62aea26e0d68

starknet deploy --class_hash 0x334e1e4d148a789fb44367eff869a6330693037983ba6fd2291b2be1249e15a --inputs 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba 1 10 --account version_11 --max_fee 99999999999999
Invoke transaction for contract deployment was sent.
Contract address: 0x041c9a96074cbed24922e3119a3c958351b2810e3bcbfd0b7f184de8d55647ce
Transaction hash: 0x24fc64ca8ae498f28727f5d782a57f3f635a6f6ce5d44a103d9b583bcd0ff91

================================================================================================================================================
starknet declare --contract target/release/starknet_cairo_101_Ex10b.json --account version_11 --max_fee 99999999999999
Declare transaction was sent.
Contract class hash: 0x32a35c4bf9c8148689002ca501c973a135a30457c6507e28261bed0c3a1f35
Transaction hash: 0x584436ada97b436f13df39faf26cfbc09cf53a7226ae28cdced35ef80ea54ad

starknet deploy --class_hash 0x32a35c4bf9c8148689002ca501c973a135a30457c6507e28261bed0c3a1f35 --inputs 0x041c9a96074cbed24922e3119a3c958351b2810e3bcbfd0b7f184de8d55647ce --account version_11 --max_fee 99999999999999
Invoke transaction for contract deployment was sent.
Contract address: 0x076410c53faac350e111e974bd020f8b2014088ac3551dc531297cdeadec10d7
Transaction hash: 0x20f1e7a2db9d19fc7fdbf1cf265c3ba5064aced2a6ba3f54a0ed5e8c02a4ea9


================================================================================================================================================
starknet declare --contract target/release/starknet_cairo_101_Ex11.json --account version_11 --max_fee 99999999999999
Declare transaction was sent.
Contract class hash: 0x06eb622294fbf3e7e3d10abdd51565a5fd75a3a41a95f7f34e4f560687b9b6d6
Transaction hash: 0x03b9a3e0d9f3020c9fea9289005ef4f371e87ce0c60a330dbf929dea935972ed

starknet deploy --class_hash 0x06eb622294fbf3e7e3d10abdd51565a5fd75a3a41a95f7f34e4f560687b9b6d6 --inputs 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba 1 11 --account version_11 --max_fee 99999999999999


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

starknet deploy --class_hash 0x03c1872bae0e57d9a9bd087ac87eebcf8153d1b0ef66d12a9fb42075fd9c2c4e --inputs 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba 1 14 --account version_11 --max_fee 99999999999999
Invoke transaction for contract deployment was sent.
Contract address: 0x0228a48ec35c161a70e417f54145d9a9dc0ad274dd83750041ef5d22a677bc75
Transaction hash: 0x57007de85ea8cc61e4fc41ce9d92a9042cabe1c4d8366dbf7829cde2f63caea
