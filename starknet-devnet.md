export STARKNET_NETWORK=alpha-goerli
export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount

### Setup accounts
```
starknet new_account --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050
starknet deploy_account --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet new_account --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050
starknet deploy_account --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050
```

### Export Account
export ACCT_ADMIN=0xba6d6e71004d209cd3d6e2216706d3e661b0254832035f46e74445865853e2
export ACCT_TEST=0xdff1eff8d1331deb4b6c1bd162233f684503ed7dc097088a5aa77d09a8db59
export TDERC20=0x06905d4f8391f7a74c86b072b8340ecf8b223cb5c1f135f76e33f8a46daed33e
export PLAYER_REGISTRY=0x05a39bbf0681239035cbf3ee677a2dafc62acdc8b6a563d15e9e32afc7637969

### Check txn status
```
starknet tx_status --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --hash 0x2fa65faed08945ed796e1c078384a298f985a2108816a928c21552560d730a3
```

### Declare contracts on dev-net
``` bash
starknet declare --contract target/release/starknet_cairo_101_EX00Base.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_EX11Base.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_ERC20Base.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_TDERC20.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_PlayersRegistry.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_ex01.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_ex02.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_ex03.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_ex04.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_ex05.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_ex06.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_ex07.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_ex08.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_ex09.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_ex10.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_ex10b.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_ex11.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_ex12.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_ex13.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
starknet declare --contract target/release/starknet_cairo_101_ex14.json --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
```

### Deploy contracts on dev-net
``` bash
## TDERC20
starknet deploy --salt 0x1234 --class_hash 0x6b1cea5c54aef607edc926dec33a205d3da187ad8c1514706ab1e28db425138 --inputs 10057515165931654559836545801321088512241713 357609582641 18 0 0 $ACCT_ADMIN $ACCT_ADMIN --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## PlayerRegistry
starknet deploy --salt 0x1234 --class_hash 0x7a6e514bb54d60ac1cfe8c53a872fbc23ebf25137d093c23c3bf01a6ae5b1c6 --inputs $ACCT_ADMIN --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex01
starknet deploy --salt 0x1234 --class_hash 0xe200aa0be9e2ff98cb8f3922f82b9508c24017207cc637f2f1193e79ca803e --inputs $TDERC20 $PLAYER_REGISTRY 1 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex02
starknet deploy --salt 0x1234 --class_hash 0x4070836bc88356c93b78ff9abf295986543c48cae1aecb5d222d1a8b6092c0a --inputs $TDERC20 $PLAYER_REGISTRY 1 2 107101107 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex03
starknet deploy --salt 0x1234 --class_hash  0x2deedb948926e551309bed476ca866b56dc7849760b02ef9ce31356a0ea4e4f --inputs $TDERC20 $PLAYER_REGISTRY 1 3 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex04
starknet deploy --salt 0x1234 --class_hash  0x9d9b18fda9d397eaa886bcbdb53a384199246bf2510893c1c403c673b44b1c --inputs $TDERC20 $PLAYER_REGISTRY 1 4 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex05
starknet deploy --salt 0x1234 --class_hash  0x696efe990401c8457a60a32519253a13c2c58427f2e1ce6d42add395c4e13e8 --inputs $TDERC20 $PLAYER_REGISTRY 1 5 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex06
starknet deploy --salt 0x1234 --class_hash  0x46f788c1295093b700a745fef0a4fc7da1348d5208435b715ab20a3400eb1e3 --inputs $TDERC20 $PLAYER_REGISTRY 1 6 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex07
starknet deploy --salt 0x1234 --class_hash  0x76c22e5d4c10804d28506e4c14f470fc48d168af5fcbb31472ab48bc31d610f --inputs $TDERC20 $PLAYER_REGISTRY 1 7 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex08
starknet deploy --salt 0x1234 --class_hash  0x6ba4fbc0462425ff3f3d66da3d125d803f68ef29a3e32942866db726003b29c --inputs $TDERC20 $PLAYER_REGISTRY 1 8 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex09
starknet deploy --salt 0x1234 --class_hash  0x10581227a879aa9a02d90319c6e9ca33448c7f73fa9d99b03087e273d55a2ec --inputs $TDERC20 $PLAYER_REGISTRY 1 9 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex10
starknet deploy --salt 0x1234 --class_hash  0x334e1e4d148a789fb44367eff869a6330693037983ba6fd2291b2be1249e15a --inputs $TDERC20 $PLAYER_REGISTRY 1 10 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex10b
starknet deploy --salt 0x1234 --class_hash  0x32a35c4bf9c8148689002ca501c973a135a30457c6507e28261bed0c3a1f35 --inputs 0x07b9842cd51a0ca05b706a257ba17807f011c8d61cf6182443711d4232b66ab7 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex11
starknet deploy --salt 0x1234 --class_hash  0xb10d8c36f68c73317a0539d11dd001ed88a9445cc0cc90ef5812782c837d3f --inputs $TDERC20 $PLAYER_REGISTRY 1 11 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex12
starknet deploy --salt 0x1234 --class_hash  0x5d22220dc9cdb39480fe641b0dd5cdc6c7662db73c3935a43bffe8f100cf240 --inputs $TDERC20 $PLAYER_REGISTRY 1 12 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex13
starknet deploy --salt 0x1234 --class_hash  0x2dd0f9e18a2fab96119d14e5e0f323d17a5539a2b9bb093b219abdf9b72657 --inputs $TDERC20 $PLAYER_REGISTRY 1 13 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex14
starknet deploy --salt 0x1234 --class_hash  0x180c3fd6eaa00892a38b5713531acb3a1b7feca3f78ff4bdaa707fcc3545d27 --inputs $TDERC20 $PLAYER_REGISTRY 1 14 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
```

### Setup permissions and datas
```bash
## Ex01
starknet invoke --address 0x0239cea68a458a1f74dd59b377d39a82d5319e0dce9e8e2c7936666851d58e12 --function set_exercise_or_admin --inputs 0x0719194252ce4c40d1f49ef25b39c4c7bb607bb3edab4504c47f83fa9a374d6f 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --address 0x0577633dd856cea9a21adff6d698cff5e488ab7e56d48f41dfe1551502620117 --function set_teacher --inputs 0x0719194252ce4c40d1f49ef25b39c4c7bb607bb3edab4504c47f83fa9a374d6f 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050


## Ex02
starknet invoke --address 0x0239cea68a458a1f74dd59b377d39a82d5319e0dce9e8e2c7936666851d58e12 --function set_exercise_or_admin --inputs 0x0018d465f4732fc6e665e3e953e53bc1bfa1a424fbb7fead4370f8b6b944ba8a 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --address 0x0577633dd856cea9a21adff6d698cff5e488ab7e56d48f41dfe1551502620117 --function set_teacher --inputs 0x0018d465f4732fc6e665e3e953e53bc1bfa1a424fbb7fead4370f8b6b944ba8a 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex03
starknet invoke --address 0x0239cea68a458a1f74dd59b377d39a82d5319e0dce9e8e2c7936666851d58e12 --function set_exercise_or_admin --inputs 0x008a057550284f3e8e06d571bb1863bf41245dcdcca109bb496229e2cb9e09ed 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --address 0x0577633dd856cea9a21adff6d698cff5e488ab7e56d48f41dfe1551502620117 --function set_teacher --inputs 0x008a057550284f3e8e06d571bb1863bf41245dcdcca109bb496229e2cb9e09ed 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050
```


### Do Exercies on dev-net
``` bash

starknet invoke --function claim_points --address 0x0719194252ce4c40d1f49ef25b39c4c7bb607bb3edab4504c47f83fa9a374d6f --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function claim_points --address 0x0018d465f4732fc6e665e3e953e53bc1bfa1a424fbb7fead4370f8b6b944ba8a --account test --inputs 107101107 --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function increment_counter --address 0x008a057550284f3e8e06d571bb1863bf41245dcdcca109bb496229e2cb9e09ed --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function increment_counter --address 0x008a057550284f3e8e06d571bb1863bf41245dcdcca109bb496229e2cb9e09ed --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function decrement_counter --address 0x008a057550284f3e8e06d571bb1863bf41245dcdcca109bb496229e2cb9e09ed --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function claim_points --address 0x008a057550284f3e8e06d571bb1863bf41245dcdcca109bb496229e2cb9e09ed --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050
```





name, contract_class_hash, contract_addr
TDERC20, 0x14f38e5454fbdec31b41ac5d36641cdfdc6d8ac6a33226c3416a968972e55b0, 0x0577633dd856cea9a21adff6d698cff5e488ab7e56d48f41dfe1551502620117
PlayersRegistry, 0x7a6e514bb54d60ac1cfe8c53a872fbc23ebf25137d093c23c3bf01a6ae5b1c6, 0x0239cea68a458a1f74dd59b377d39a82d5319e0dce9e8e2c7936666851d58e12
ex01, 0xe200aa0be9e2ff98cb8f3922f82b9508c24017207cc637f2f1193e79ca803e, 0x0719194252ce4c40d1f49ef25b39c4c7bb607bb3edab4504c47f83fa9a374d6f
ex02, 0x4070836bc88356c93b78ff9abf295986543c48cae1aecb5d222d1a8b6092c0a, 0x0018d465f4732fc6e665e3e953e53bc1bfa1a424fbb7fead4370f8b6b944ba8a
ex03, 0x2deedb948926e551309bed476ca866b56dc7849760b02ef9ce31356a0ea4e4f, 0x008a057550284f3e8e06d571bb1863bf41245dcdcca109bb496229e2cb9e09ed
ex11, 0x6eb622294fbf3e7e3d10abdd51565a5fd75a3a41a95f7f34e4f560687b9b6d6,






starknet call --function is_teacher_or_exercise --address 0x03f5a8e43a4660b2c3dc467645a2457a78ded80d63980079c5c1131e1acad3da --input $ACCT_ADMIN --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet call --function balanceOf --address 0x0577633dd856cea9a21adff6d698cff5e488ab7e56d48f41dfe1551502620117 --inputs 0x2c3e03cacac109396754f70ba9445b987bebb7b843474fc1f00b4bbde32e901 --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050


starknet invoke --function set_transferable --address 0x03f5a8e43a4660b2c3dc467645a2457a78ded80d63980079c5c1131e1acad3da --inputs 1 --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function distribute_points --address 0x03f5a8e43a4660b2c3dc467645a2457a78ded80d63980079c5c1131e1acad3da --inputs 0x01517435681b37f79838374367af59e2302c5500853f9ffcd9bc25ffcc7bc9fa 999000000000000000000 0 --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000






``` bash
docker run -p 127.0.0.1:5050:5050 --name devnet1 --mount type=bind,source=/Users/seabookchen/.starknet-devnet/dumpdir,target=/dumpdir devnet-1 --seed 1234 --timeout 10000  --dump-on exit --dump-path /dumpdir/dump.pkl
```