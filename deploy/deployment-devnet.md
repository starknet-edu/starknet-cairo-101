### Export ENV
``` bash
export STARKNET_NETWORK=alpha-goerli
export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount
```

### Setup accounts
```bash
starknet new_account --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050
starknet deploy_account --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet new_account --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050
starknet deploy_account --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050
```

### Export Account
```bash
export ACCT_ADMIN=0x707d687d44fbe083b43a1c17d0f66615bcfbe73b645c933065bf43f68d47979
export ACCT_TEST=0x06f249480e59dbf016c0696ae1904218931f764857b9f4871c3284ec3ffe78ad
export TDERC20=0x05e8e1c965d59bc44f109f72b9e67cedfa069352c4704723e123271827c49196
export PLAYER_REGISTRY=0x0643c0eb6cd5b848de6b653e621b4e550e11921908d324df623ee4dcc9cd5809
```

### Check txn status
``` bash
starknet tx_status --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --hash 0x75afca7b8eda9750065ce7a8c4816bc3797d9ec9698d335dc2680bb12f061e5
```

### Declare contracts on dev-net
``` bash
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
starknet deploy --salt 0x1234 --class_hash 0x2de7e654139db6c8c05d7c456b953e8feba7055a25d6dc0ab5d538314d96a6 --inputs 10057515165931654559836545801321088512241713 357609582641 18 0 0 $ACCT_ADMIN $ACCT_ADMIN --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## PlayerRegistry
starknet deploy --salt 0x1234 --class_hash 0x25f0f9beb3c3bf0c01678aa830ff96fad5f2bd05b23a8f4c0a2bce92ec5f25d --inputs $ACCT_ADMIN --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex01
starknet deploy --salt 0x1234 --class_hash 0x27956db0c99ea0959280a6b3b14bdd1615a96bcf318e2d0826ed90abbd399a9 --inputs $TDERC20 $PLAYER_REGISTRY 1 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex02
starknet deploy --salt 0x1234 --class_hash 0x5acbc7548d1fc3f189427ce2c7480e4f7e4bda2844833cd8e57f5b918eadfdc --inputs $TDERC20 $PLAYER_REGISTRY 1 2 107101107 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex03
starknet deploy --salt 0x1234 --class_hash  0x5df061a4185d402e0b211ea6a7c772f837a028444c03e376b4dc066be5a40ec --inputs $TDERC20 $PLAYER_REGISTRY 1 3 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex04
starknet deploy --salt 0x1234 --class_hash  0x58b738875c8805fb19f993d01e844c7482fe2bbad28ab572f2e5bd2849383c7 --inputs $TDERC20 $PLAYER_REGISTRY 1 4 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex05
starknet deploy --salt 0x1234 --class_hash  0x8dce186e78c149c968f89a5e93ccd3b3ed07c2e06fccd737231f0b006ab735 --inputs $TDERC20 $PLAYER_REGISTRY 1 5 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex06
starknet deploy --salt 0x1234 --class_hash  0x4b9979b805cea3ddcc032d443e6ff8d9c924353a6af1fb6ad759370f9b8a550 --inputs $TDERC20 $PLAYER_REGISTRY 1 6 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex07
starknet deploy --salt 0x1234 --class_hash  0x25dbaec22271885e5329a359537668c28c7474a3c4c92cf8b9f5efdfdb9f4b --inputs $TDERC20 $PLAYER_REGISTRY 1 7 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex08
starknet deploy --salt 0x1234 --class_hash  0x18c34d459b1a86f1e7579692e989a8cde55448f39f506d00ad69731c857e481 --inputs $TDERC20 $PLAYER_REGISTRY 1 8 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex09
starknet deploy --salt 0x1234 --class_hash  0x61b96695fcf0f72c4c59e9f5e7ced3296cbf2049240fa0ee8f65232e7435233 --inputs $TDERC20 $PLAYER_REGISTRY 1 9 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex10
starknet deploy --salt 0x1234 --class_hash  0x8edcf59bd290228cb979894b9a8700f2afd1069404c464a5166640d13f5562 --inputs $TDERC20 $PLAYER_REGISTRY 1 10 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex10b
starknet deploy --salt 0x1234 --class_hash  0x32a35c4bf9c8148689002ca501c973a135a30457c6507e28261bed0c3a1f35 --inputs 0x03ade0da876b44f353e3ecc962aa5a1c01e4ac26014c60f41285035364070621 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex11
starknet deploy --salt 0x1234 --class_hash  0x7373764393f1307fa9730f2a3deabf8505826bddb162d3f9051b8d449669a5 --inputs $TDERC20 $PLAYER_REGISTRY 1 11 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex12
starknet deploy --salt 0x1234 --class_hash  0x3174b379c0dae73d2ea25bd6d3546e67b859b710bcd7a92eaf8bda068c0f484 --inputs $TDERC20 $PLAYER_REGISTRY 1 12 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex13
starknet deploy --salt 0x1234 --class_hash  0x5d4af31df1011e23e90bccf721f8dd7040c468d3f9df8eb4a175c0002c339ca --inputs $TDERC20 $PLAYER_REGISTRY 1 13 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000

## Ex14
starknet deploy --salt 0x1234 --class_hash  0x5aa8563e722c9f77db09981f94dd24a2d63611692fee9d421b50cb5460f45a0 --inputs $TDERC20 $PLAYER_REGISTRY 1 14 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050 --max_fee 100000000000000000000
```

### Setup permissions and datas
```bash
## Ex01
starknet invoke --address 0x0643c0eb6cd5b848de6b653e621b4e550e11921908d324df623ee4dcc9cd5809 --function set_exercise_or_admin --inputs 0x066ac578cb51a1b96e2f6be5c7d046461db19827270cd598f232647189114fc6 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --address 0x05e8e1c965d59bc44f109f72b9e67cedfa069352c4704723e123271827c49196 --function set_teacher --inputs 0x066ac578cb51a1b96e2f6be5c7d046461db19827270cd598f232647189114fc6 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex02
starknet invoke --address 0x0643c0eb6cd5b848de6b653e621b4e550e11921908d324df623ee4dcc9cd5809 --function set_exercise_or_admin --inputs 0x068b861f9b3cfb260b77582526211f241321340000a346025e82c13744ce00a5 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --address 0x05e8e1c965d59bc44f109f72b9e67cedfa069352c4704723e123271827c49196 --function set_teacher --inputs 0x068b861f9b3cfb260b77582526211f241321340000a346025e82c13744ce00a5 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex03
starknet invoke --address 0x0643c0eb6cd5b848de6b653e621b4e550e11921908d324df623ee4dcc9cd5809 --function set_exercise_or_admin --inputs 0x015b87d0975321ede377f4e2cfcef8941ece3c3d77e7f4c435ad5dff258f5c47 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --address 0x05e8e1c965d59bc44f109f72b9e67cedfa069352c4704723e123271827c49196 --function set_teacher --inputs 0x015b87d0975321ede377f4e2cfcef8941ece3c3d77e7f4c435ad5dff258f5c47 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex04
starknet invoke --address 0x0643c0eb6cd5b848de6b653e621b4e550e11921908d324df623ee4dcc9cd5809 --function set_exercise_or_admin --inputs 0x07a6bab4b1d66d1a58f9648de86e1a485a33fda5f4170a74cda7679d4f9c733c 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --address 0x05e8e1c965d59bc44f109f72b9e67cedfa069352c4704723e123271827c49196 --function set_teacher --inputs 0x07a6bab4b1d66d1a58f9648de86e1a485a33fda5f4170a74cda7679d4f9c733c 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex05
starknet invoke --address 0x0643c0eb6cd5b848de6b653e621b4e550e11921908d324df623ee4dcc9cd5809 --function set_exercise_or_admin --inputs 0x0300eba992a5f5b246e31e2cc62f1829c9d082e897f431025a6c38ec884a20cd 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --address 0x05e8e1c965d59bc44f109f72b9e67cedfa069352c4704723e123271827c49196 --function set_teacher --inputs 0x0300eba992a5f5b246e31e2cc62f1829c9d082e897f431025a6c38ec884a20cd 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex06
starknet invoke --address 0x0643c0eb6cd5b848de6b653e621b4e550e11921908d324df623ee4dcc9cd5809 --function set_exercise_or_admin --inputs 0x042598856dbb33e76a4828ec18f4acf88f5cfc2e5b4df1ce486f201b802e8ce2 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --address 0x05e8e1c965d59bc44f109f72b9e67cedfa069352c4704723e123271827c49196 --function set_teacher --inputs 0x042598856dbb33e76a4828ec18f4acf88f5cfc2e5b4df1ce486f201b802e8ce2 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex07
starknet invoke --address 0x0643c0eb6cd5b848de6b653e621b4e550e11921908d324df623ee4dcc9cd5809 --function set_exercise_or_admin --inputs 0x0518281f2678aa97c854687d26777d58eb291d797d2882ec00299c1ea087daed 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --address 0x05e8e1c965d59bc44f109f72b9e67cedfa069352c4704723e123271827c49196 --function set_teacher --inputs 0x0518281f2678aa97c854687d26777d58eb291d797d2882ec00299c1ea087daed 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex08
starknet invoke --address 0x0643c0eb6cd5b848de6b653e621b4e550e11921908d324df623ee4dcc9cd5809 --function set_exercise_or_admin --inputs 0x0582ae40e0ae7de3a35986ab5fd415a637ffc43cc6fe3470a9eab7e0fe2b7c79 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --address 0x05e8e1c965d59bc44f109f72b9e67cedfa069352c4704723e123271827c49196 --function set_teacher --inputs 0x0582ae40e0ae7de3a35986ab5fd415a637ffc43cc6fe3470a9eab7e0fe2b7c79 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex09
starknet invoke --address 0x0643c0eb6cd5b848de6b653e621b4e550e11921908d324df623ee4dcc9cd5809 --function set_exercise_or_admin --inputs 0x044f88574c82e073c594af4179e9b2b66586da81d8a70d93d87d145f19613c90 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --address 0x05e8e1c965d59bc44f109f72b9e67cedfa069352c4704723e123271827c49196 --function set_teacher --inputs 0x044f88574c82e073c594af4179e9b2b66586da81d8a70d93d87d145f19613c90 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex10
starknet invoke --address 0x0643c0eb6cd5b848de6b653e621b4e550e11921908d324df623ee4dcc9cd5809 --function set_exercise_or_admin --inputs 0x03ade0da876b44f353e3ecc962aa5a1c01e4ac26014c60f41285035364070621 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --address 0x05e8e1c965d59bc44f109f72b9e67cedfa069352c4704723e123271827c49196 --function set_teacher --inputs 0x03ade0da876b44f353e3ecc962aa5a1c01e4ac26014c60f41285035364070621 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex11
starknet invoke --address 0x0643c0eb6cd5b848de6b653e621b4e550e11921908d324df623ee4dcc9cd5809 --function set_exercise_or_admin --inputs 0x0434d98af59a0bdc1f93612ab381278bc51d9903eb335827086e697d9e45fd61 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --address 0x05e8e1c965d59bc44f109f72b9e67cedfa069352c4704723e123271827c49196 --function set_teacher --inputs 0x0434d98af59a0bdc1f93612ab381278bc51d9903eb335827086e697d9e45fd61 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex12
starknet invoke --address 0x0643c0eb6cd5b848de6b653e621b4e550e11921908d324df623ee4dcc9cd5809 --function set_exercise_or_admin --inputs 0x02d0e25abe31cebb145aa9cc4bf776825babc727f2b8588c5c7530ee943ff867 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --address 0x05e8e1c965d59bc44f109f72b9e67cedfa069352c4704723e123271827c49196 --function set_teacher --inputs 0x02d0e25abe31cebb145aa9cc4bf776825babc727f2b8588c5c7530ee943ff867 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex13
starknet invoke --address 0x0643c0eb6cd5b848de6b653e621b4e550e11921908d324df623ee4dcc9cd5809 --function set_exercise_or_admin --inputs 0x066162f43d2c27e93377b84bef716fd8a0e52e00bc9c6758c17e107a669f8896 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --address 0x05e8e1c965d59bc44f109f72b9e67cedfa069352c4704723e123271827c49196 --function set_teacher --inputs 0x066162f43d2c27e93377b84bef716fd8a0e52e00bc9c6758c17e107a669f8896 1 --account admin --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050
```


### Do Exercies on dev-net
``` bash
## Ex01
starknet invoke --function claim_points --address 0x066ac578cb51a1b96e2f6be5c7d046461db19827270cd598f232647189114fc6 --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex02
starknet invoke --function claim_points --address 0x068b861f9b3cfb260b77582526211f241321340000a346025e82c13744ce00a5 --account test --inputs 107101107 --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex03
starknet invoke --function increment_counter --address 0x015b87d0975321ede377f4e2cfcef8941ece3c3d77e7f4c435ad5dff258f5c47 --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function increment_counter --address 0x015b87d0975321ede377f4e2cfcef8941ece3c3d77e7f4c435ad5dff258f5c47 --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function decrement_counter --address 0x015b87d0975321ede377f4e2cfcef8941ece3c3d77e7f4c435ad5dff258f5c47 --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function claim_points --address 0x015b87d0975321ede377f4e2cfcef8941ece3c3d77e7f4c435ad5dff258f5c47 --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex04
starknet invoke --function assign_user_slot --address 0x07a6bab4b1d66d1a58f9648de86e1a485a33fda5f4170a74cda7679d4f9c733c --account test  --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function claim_points --address 0x07a6bab4b1d66d1a58f9648de86e1a485a33fda5f4170a74cda7679d4f9c733c --account test  --inputs 7119 --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex05
starknet invoke --function assign_user_slot --address 0x0300eba992a5f5b246e31e2cc62f1829c9d082e897f431025a6c38ec884a20cd --account test  --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function copy_secret_value_to_readable_mapping --address 0x0300eba992a5f5b246e31e2cc62f1829c9d082e897f431025a6c38ec884a20cd --account test --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet call --function get_user_values --address 0x0300eba992a5f5b246e31e2cc62f1829c9d082e897f431025a6c38ec884a20cd --input $ACCT_TEST --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function claim_points --address 0x0300eba992a5f5b246e31e2cc62f1829c9d082e897f431025a6c38ec884a20cd --account test  --inputs 8861 --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex06
starknet invoke --function assign_user_slot --address 0x042598856dbb33e76a4828ec18f4acf88f5cfc2e5b4df1ce486f201b802e8ce2 --account test  --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function external_handler_for_internal_function --address 0x042598856dbb33e76a4828ec18f4acf88f5cfc2e5b4df1ce486f201b802e8ce2 --account test --inputs 1 --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet call --function get_user_values --address 0x042598856dbb33e76a4828ec18f4acf88f5cfc2e5b4df1ce486f201b802e8ce2 --input $ACCT_TEST --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function claim_points --address 0x042598856dbb33e76a4828ec18f4acf88f5cfc2e5b4df1ce486f201b802e8ce2 --account test  --inputs 5970 --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex07
starknet invoke --function claim_points --address 0x0518281f2678aa97c854687d26777d58eb291d797d2882ec00299c1ea087daed --account test  --inputs 50 0 --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex08
starknet invoke --function set_user_values --address 0x0582ae40e0ae7de3a35986ab5fd415a637ffc43cc6fe3470a9eab7e0fe2b7c79 --account test  --inputs $ACCT_TEST 11 0 1 2 3 4 5 6 7 8 9 10 --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function claim_points --address 0x0582ae40e0ae7de3a35986ab5fd415a637ffc43cc6fe3470a9eab7e0fe2b7c79 --account test  --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex09
starknet invoke --function claim_points --address 0x044f88574c82e073c594af4179e9b2b66586da81d8a70d93d87d145f19613c90 --account test --inputs 4 10 20 30 40  --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex10
starknet call --function get_ex10b_address --address 0x03ade0da876b44f353e3ecc962aa5a1c01e4ac26014c60f41285035364070621 --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function claim_points --address 0x03ade0da876b44f353e3ecc962aa5a1c01e4ac26014c60f41285035364070621 --account test --inputs 0 10  --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex11
starknet invoke --function claim_points --address 0x0434d98af59a0bdc1f93612ab381278bc51d9903eb335827086e697d9e45fd61 --account test --inputs 9811398123 9811398124  --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex12
starknet invoke --function assign_user_slot --address 0x02d0e25abe31cebb145aa9cc4bf776825babc727f2b8588c5c7530ee943ff867 --account test  --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function claim_points --address 0x02d0e25abe31cebb145aa9cc4bf776825babc727f2b8588c5c7530ee943ff867 --account test --inputs 5970  --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

## Ex13
starknet invoke --function assign_user_slot --address 0x066162f43d2c27e93377b84bef716fd8a0e52e00bc9c6758c17e107a669f8896 --account test  --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function claim_points --address 0x066162f43d2c27e93377b84bef716fd8a0e52e00bc9c6758c17e107a669f8896 --account test --inputs 5970  --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050
```

### Set random values
```bash
starknet invoke --function set_random_values --address 0x07a6bab4b1d66d1a58f9648de86e1a485a33fda5f4170a74cda7679d4f9c733c --input 100 509 7151 5476 3518 3472 1072 2672 1522 2451 4950 9493 6340 6911 3571 7159 111 5431 3695 1758 4928 5139 6549 2252 1068 1624 480 6659 7521 9588 8679 1091 4111 5113 5727 4376 5287 5718 7204 8537 7240 3457 455 685 3467 9279 7243 1571 5229 3683 9881 622 4622 7388 4811 2961 7321 2199 3362 7477 9380 4547 8696 5393 3719 1001 699 646 824 3133 1946 89 2980 8677 6857 2800 8920 1224 2189 6094 2932 5363 4795 192 2695 853 6569 6941 7967 5070 2585 4675 3048 444 2487 5451 6121 945 9343 5757 9193 --account admin --max_fee 100000000000000000 --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function set_random_values --address 0x0300eba992a5f5b246e31e2cc62f1829c9d082e897f431025a6c38ec884a20cd --input 100 9760 8893 9155 1504 3558 5806 3145 8537 9798 1834 7969 8581 2448 9523 2435 9242 5081 8715 4195 6467 1218 8174 2955 9996 4129 8850 512 3215 7527 2373 9350 2872 9705 4779 2068 7184 5795 4942 8624 1927 4821 5234 9554 1503 1963 2490 925 8189 4138 9562 8507 5719 2976 131 7059 6648 4584 6839 9692 8072 2047 4929 9464 4557 8502 173 4404 1511 1958 2814 7708 3867 7408 114 1805 5990 4761 1797 8443 8075 4903 597 5980 7592 9607 3224 7164 8408 6744 6689 6120 3494 6485 519 3526 9327 2334 9125 4709 9798 --account admin --max_fee 100000000000000000 --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function set_random_values --address 0x042598856dbb33e76a4828ec18f4acf88f5cfc2e5b4df1ce486f201b802e8ce2 --input 100 8308 5970 1409 7875 8633 6802 4987 2249 8843 3546 2519 5738 214 5185 6229 4843 8604 5121 4495 40 8045 3028 1327 8160 9376 6845 5219 6010 2220 253 5913 8682 1031 6173 690 1235 8918 5215 2276 1228 4315 9814 4099 9322 9672 5389 5795 9779 4535 5385 3787 6393 5306 7019 5447 7366 9283 7893 5210 2696 323 1824 2665 6720 7457 2627 1784 2730 2100 7622 8957 3193 8833 6583 428 5015 9026 6353 8905 5935 3224 7475 5910 5129 8137 9669 5646 4841 2318 7741 2280 9086 5248 7178 4496 1003 934 2803 9022 8656 --account admin --max_fee 100000000000000000 --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function set_random_values --address 0x02d0e25abe31cebb145aa9cc4bf776825babc727f2b8588c5c7530ee943ff867 --input 100 8308 5970 1409 7875 8633 6802 4987 2249 8843 3546 2519 5738 214 5185 6229 4843 8604 5121 4495 40 8045 3028 1327 8160 9376 6845 5219 6010 2220 253 5913 8682 1031 6173 690 1235 8918 5215 2276 1228 4315 9814 4099 9322 9672 5389 5795 9779 4535 5385 3787 6393 5306 7019 5447 7366 9283 7893 5210 2696 323 1824 2665 6720 7457 2627 1784 2730 2100 7622 8957 3193 8833 6583 428 5015 9026 6353 8905 5935 3224 7475 5910 5129 8137 9669 5646 4841 2318 7741 2280 9086 5248 7178 4496 1003 934 2803 9022 8656 --account admin --max_fee 100000000000000000 --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050

starknet invoke --function set_random_values --address 0x066162f43d2c27e93377b84bef716fd8a0e52e00bc9c6758c17e107a669f8896 --input 100 8308 5970 1409 7875 8633 6802 4987 2249 8843 3546 2519 5738 214 5185 6229 4843 8604 5121 4495 40 8045 3028 1327 8160 9376 6845 5219 6010 2220 253 5913 8682 1031 6173 690 1235 8918 5215 2276 1228 4315 9814 4099 9322 9672 5389 5795 9779 4535 5385 3787 6393 5306 7019 5447 7366 9283 7893 5210 2696 323 1824 2665 6720 7457 2627 1784 2730 2100 7622 8957 3193 8833 6583 428 5015 9026 6353 8905 5935 3224 7475 5910 5129 8137 9669 5646 4841 2318 7741 2280 9086 5248 7178 4496 1003 934 2803 9022 8656 --account admin --max_fee 100000000000000000 --gateway_url http://localhost:5050 --feeder_gateway_url http://localhost:5050
```

### Run starknet-devnet locally
```
docker run -p 127.0.0.1:5050:5050 --name starknet-devnet --mount type=bind,source=/Users/seabookchen/.starknet-devnet/dumpdir,target=/dumpdir shardlabs/starknet-devnet:latest-arm --seed 1234 --timeout 10000  --dump-on exit --dump-path /dumpdir/dump.pkl --load-path /dumpdir/dump.pkl
```
