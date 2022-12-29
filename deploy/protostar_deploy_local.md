# Local Deployment using ProtoStar

## Set up local environment
```
nile node
```
## Build contracts
```
protostar build
```
## Set private key for local network
```
touch .pkey_local
```

## Deploy TDERC20
```
protostar -p devnet declare ./build/TDERC20.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto

protostar -p devnet deploy 0x01a0dd8f59b59746a7636b15a95eb09dc8160a0c186140e97cfae3d5bcd87b3c --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 10057515165931654559836545801321088512241713 357609582641 0 0 840684583409848155090139159631415205493949005563877468026570772574410479336 840684583409848155090139159631415205493949005563877468026570772574410479336

protostar -p devnet call --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "name"
```

## Deploy Players Registry
```
protostar -p devnet declare ./build/players_registry.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto

protostar -p devnet deploy 0x00decb0616dede1597bf429da5ea4ec72eab500fa825bcc876dd6f4612c66c2d --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 840684583409848155090139159631415205493949005563877468026570772574410479336
```

## Deploy EX01
```
protostar -p devnet declare ./build/ex01.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto

protostar -p devnet deploy 0x010e2af892917b1d130c7b885393250a458c712c83fe811e31eb6a9059f6fed6 --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 1182650070130573435193028845990660031073426562100538112561262125938226576593 961180306726768256007213141751957493112749470679826243697583243652066956019 1 1
```

## Set Admin for EX01
```
protostar -p devnet invoke --contract-address 0x0220023f0e6a09b79b986e385dc3173f1bcfdeb144af7aaa8af1db104e17d2f3 --function "set_exercise_or_admin" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x03bba00008dae870eadba249f812e27ecefe9fb1968231fbade21acfce94fa79 1 --max-fee auto --private-key-path ./.pkey_local

protostar -p devnet invoke --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "set_teacher" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x03bba00008dae870eadba249f812e27ecefe9fb1968231fbade21acfce94fa79 1 --max-fee auto --private-key-path ./.pkey_local
```

## Claim points for EX01
```
protostar -p devnet invoke --contract-address 0x03bba00008dae870eadba249f812e27ecefe9fb1968231fbade21acfce94fa79 --function "claim_points" --account-address 0x40598585725ed95c5c316423a05565f95ef2b8de586356ee082c33e1a0ecf44 --max-fee auto --private-key-path ./.pkey_p1
```

## validate points should have 2 points
```
protostar -p devnet call --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "balanceOf" --inputs 0x40598585725ed95c5c316423a05565f95ef2b8de586356ee082c33e1a0ecf44
```

## Deploy EX02
```
protostar -p devnet declare ./build/ex02.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto

protostar -p devnet deploy 0x00140ef6253b78f5ee81526b3e29c2eed6f3b9c57cea90df61a007f87267bdad --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 1182650070130573435193028845990660031073426562100538112561262125938226576593 961180306726768256007213141751957493112749470679826243697583243652066956019 1 2 31020
```

## Set Admin for EX02
```
protostar -p devnet invoke --contract-address 0x0220023f0e6a09b79b986e385dc3173f1bcfdeb144af7aaa8af1db104e17d2f3 --function "set_exercise_or_admin" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x001e4d3b7c566ed09a38f6cc6fb759c6e8ac31a8ed7ea581960a67607cf442f6 1 --max-fee auto --private-key-path ./.pkey_local

protostar -p devnet invoke --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "set_teacher" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x001e4d3b7c566ed09a38f6cc6fb759c6e8ac31a8ed7ea581960a67607cf442f6 1 --max-fee auto --private-key-path ./.pkey_local
```

## Claim points for EX02
```
protostar -p devnet invoke --contract-address 0x001e4d3b7c566ed09a38f6cc6fb759c6e8ac31a8ed7ea581960a67607cf442f6 --function "claim_points" --account-address 0x40598585725ed95c5c316423a05565f95ef2b8de586356ee082c33e1a0ecf44 --max-fee auto --inputs 31020 --private-key-path ./.pkey_p1
```

## validate points should have 4 points
```
protostar -p devnet call --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "balanceOf" --inputs 0x40598585725ed95c5c316423a05565f95ef2b8de586356ee082c33e1a0ecf44
```

## Deploy Ex03
```
protostar -p devnet declare ./build/ex03.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto

protostar -p devnet deploy 0x07dfb404526f4a1c2cbfa86b6078e99b0feaa33b945d3690bb6d7b127fe4ca00 --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 1182650070130573435193028845990660031073426562100538112561262125938226576593 961180306726768256007213141751957493112749470679826243697583243652066956019 1 3
```

## Set Admin for EX03
```
protostar -p devnet invoke --contract-address 0x0220023f0e6a09b79b986e385dc3173f1bcfdeb144af7aaa8af1db104e17d2f3 --function "set_exercise_or_admin" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x049a2606c07fe72eb359a03ad55706ee2606186bf30c0df0e30bc44ceca63f24 1 --max-fee auto --private-key-path ./.pkey_local

protostar -p devnet invoke --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "set_teacher" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x049a2606c07fe72eb359a03ad55706ee2606186bf30c0df0e30bc44ceca63f24 1 --max-fee auto --private-key-path ./.pkey_local
```

## Claim points for EX03
```
protostar -p devnet invoke --contract-address 0x049a2606c07fe72eb359a03ad55706ee2606186bf30c0df0e30bc44ceca63f24 --function "increment_counter" --account-address 0x40598585725ed95c5c316423a05565f95ef2b8de586356ee082c33e1a0ecf44 --max-fee auto --private-key-path ./.pkey_p1

protostar -p devnet invoke --contract-address 0x049a2606c07fe72eb359a03ad55706ee2606186bf30c0df0e30bc44ceca63f24 --function "decrement_counter" --account-address 0x40598585725ed95c5c316423a05565f95ef2b8de586356ee082c33e1a0ecf44 --max-fee auto --private-key-path ./.pkey_p1

protostar -p devnet invoke --contract-address 0x049a2606c07fe72eb359a03ad55706ee2606186bf30c0df0e30bc44ceca63f24 --function "claim_points" --account-address 0x40598585725ed95c5c316423a05565f95ef2b8de586356ee082c33e1a0ecf44 --max-fee auto --private-key-path ./.pkey_p1
```

## validate points should have 6 points
```
protostar -p devnet call --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "balanceOf" --inputs 0x40598585725ed95c5c316423a05565f95ef2b8de586356ee082c33e1a0ecf44
```

## Deploy Ex04
```
protostar -p devnet declare ./build/ex04.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto
protostar -p devnet deploy 0x01fe242458977d5f1cf830200969c7d3687568c1ec27fcb139fb874d4bfffc82 --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 1182650070130573435193028845990660031073426562100538112561262125938226576593 961180306726768256007213141751957493112749470679826243697583243652066956019 1 4
```

## Set Admin for EX04
```
protostar -p devnet invoke --contract-address 0x0220023f0e6a09b79b986e385dc3173f1bcfdeb144af7aaa8af1db104e17d2f3 --function "set_exercise_or_admin" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x0408364676184e2de781f5fa46764a5a1e578b370b58887a88ebf937752819d7 1 --max-fee auto --private-key-path ./.pkey_local

protostar -p devnet invoke --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "set_teacher" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x0408364676184e2de781f5fa46764a5a1e578b370b58887a88ebf937752819d7 1 --max-fee auto --private-key-path ./.pkey_local
```

## Set Random Values for EX04
#### Due to the current bug of protostar, we have to use starknet command to invoke felt* inputs
```
starknet invoke --address 0x0408364676184e2de781f5fa46764a5a1e578b370b58887a88ebf937752819d7 --function set_random_values --abi ./build/ex04_abi.json  --inputs 100 8003 5046 4552 1465 683 1178 8813 3285 8477 7562 9182 5595 1091 7930 8572 9931 1370 2021 3736 4921 4359 6054 6777 122 8886 6327 3601 5967 6498 8063 6299 1803 3916 6167 7056 6125 4158 631 3104 1649 7215 8433 4444 4906 8256 3958 126 1105 4471 3828 1280 6794 3270 1513 7649 3356 3309 4153 7750 8136 3346 4585 3075 501 3377 7077 2615 8131 69 4464 5283 5319 2313 6254 1939 9484 7907 4817 3339 5026 5567 1115 2029 5418 9037 8074 6215 3154 9159 3327 7672 3258 2039 9777 768 1170 5934 6529 8160 1275 --feeder_gateway_url http://127.0.0.1:5050  --gateway_url http://127.0.0.1:5050
```

## Claim points for EX04
```
protostar -p devnet invoke --contract-address 0x0408364676184e2de781f5fa46764a5a1e578b370b58887a88ebf937752819d7 --function "assign_user_slot" --account-address 0x40598585725ed95c5c316423a05565f95ef2b8de586356ee082c33e1a0ecf44 --max-fee auto --private-key-path ./.pkey_p1

protostar -p devnet call --contract-address 0x0408364676184e2de781f5fa46764a5a1e578b370b58887a88ebf937752819d7 --function "user_slots" --inputs 0x40598585725ed95c5c316423a05565f95ef2b8de586356ee082c33e1a0ecf44

protostar -p devnet call --contract-address 0x0408364676184e2de781f5fa46764a5a1e578b370b58887a88ebf937752819d7 --function "values_mapped" --inputs 1

protostar -p devnet invoke --contract-address 0x0408364676184e2de781f5fa46764a5a1e578b370b58887a88ebf937752819d7 --function "claim_points" --account-address 0x40598585725ed95c5c316423a05565f95ef2b8de586356ee082c33e1a0ecf44 --max-fee auto --private-key-path ./.pkey_p1 --inputs 8128
```

## validate points should have 8 points
```
protostar -p devnet call --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "balanceOf" --inputs 0x40598585725ed95c5c316423a05565f95ef2b8de586356ee082c33e1a0ecf44
```

## Deploy EX05
```
protostar -p devnet declare ./build/ex05.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto

protostar -p devnet deploy 0x01984a15f4284bd4147a17d8228e6d6955e7cb42dfe0814fd96e630a7edf2b05 --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 1182650070130573435193028845990660031073426562100538112561262125938226576593 961180306726768256007213141751957493112749470679826243697583243652066956019 1 5
```

## Set Admin for EX05
```
protostar -p devnet invoke --contract-address 0x0220023f0e6a09b79b986e385dc3173f1bcfdeb144af7aaa8af1db104e17d2f3 --function "set_exercise_or_admin" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x060361ca11aca492aad086210c4e56fadf917da12b4e963cb0a2625fcae9b3d7 1 --max-fee auto --private-key-path ./.pkey_local

protostar -p devnet invoke --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "set_teacher" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x060361ca11aca492aad086210c4e56fadf917da12b4e963cb0a2625fcae9b3d7 1 --max-fee auto --private-key-path ./.pkey_local
```

## Set Random Values for EX05
```
starknet invoke --address 0x060361ca11aca492aad086210c4e56fadf917da12b4e963cb0a2625fcae9b3d7 --function set_random_values --abi ./build/ex05_abi.json  --inputs 100 9680 3502 1249 9711 4841 185 9222 6477 9849 4935 3552 9346 9668 9375 7223 8620 9654 9427 897 5185 3016 7306 6530 9854 3861 8992 9167 6993 9986 2327 8183 1762 1306 6779 8732 2920 8075 8862 287 1147 5577 9929 9250 7796 5380 9556 2088 6483 9422 6333 7178 4634 2654 6972 4553 4375 489 2367 2992 3747 2874 2791 906 4452 4858 155 4160 1327 6462 8720 6159 3506 1037 7361 5500 2205 548 3512 3050 1475 532 3750 9655 7143 148 7806 9750 1314 9764 1051 9410 2215 8653 3582 8078 1167 8309 7600 8476 5976 --feeder_gateway_url http://127.0.0.1:5050  --gateway_url http://127.0.0.1:5050
```

## Deploy EX06
```
protostar -p devnet declare ./build/ex06.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto

protostar -p devnet deploy 0x0069ce45376e406eeeef0937dd49b5157cb379a5b1227b85e702ae9989d946a8 --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 1182650070130573435193028845990660031073426562100538112561262125938226576593 961180306726768256007213141751957493112749470679826243697583243652066956019 1 6
```

## Set Admin for EX06
```
protostar -p devnet invoke --contract-address 0x0220023f0e6a09b79b986e385dc3173f1bcfdeb144af7aaa8af1db104e17d2f3 --function "set_exercise_or_admin" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x005586c4a89f927fb12eef617e770ec3434026eb62a78075333cd8c78f15843d 1 --max-fee auto --private-key-path ./.pkey_local

protostar -p devnet invoke --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "set_teacher" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x005586c4a89f927fb12eef617e770ec3434026eb62a78075333cd8c78f15843d 1 --max-fee auto --private-key-path ./.pkey_local
```

## Set Random Values for EX06
```
starknet invoke --address 0x005586c4a89f927fb12eef617e770ec3434026eb62a78075333cd8c78f15843d --function set_random_values --abi ./build/ex06_abi.json  --inputs 100 5096 5996 6373 9285 8973 3013 2108 7300 9387 165 4148 5651 5860 2415 3115 2378 162 8791 112 1420 3967 640 5048 4119 6191 1545 186 5704 2897 4394 3630 6475 5996 1339 7756 223 167 9274 4643 4017 8229 3457 1036 9401 489 5931 1970 446 6681 6733 3980 9457 9432 2972 1363 2637 4369 4859 3345 4394 6653 3710 5850 9677 1137 25 4427 5105 4128 7722 6329 745 2918 8689 3239 7571 7443 9725 5734 1181 6792 9518 1292 3985 7084 3956 2230 6128 164 8310 4320 171 7756 4853 2331 8397 5910 2311 5941 8786 --feeder_gateway_url http://127.0.0.1:5050  --gateway_url http://127.0.0.1:5050
```

## Deploy EX07
```
protostar -p devnet declare ./build/ex07.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto

protostar -p devnet deploy 0x03c0ac60a44f3311a8c1c0765399b44c0caab8868d824338a025418858066a1a --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 1182650070130573435193028845990660031073426562100538112561262125938226576593 961180306726768256007213141751957493112749470679826243697583243652066956019 1 7
```

## Set Admin for EX07
```
protostar -p devnet invoke --contract-address 0x0220023f0e6a09b79b986e385dc3173f1bcfdeb144af7aaa8af1db104e17d2f3 --function "set_exercise_or_admin" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x02fbd11ba8d79005ecfab7840730cb0525ef2abb5408d1bb805def656cdbd8ba 1 --max-fee auto --private-key-path ./.pkey_local

protostar -p devnet invoke --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "set_teacher" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x02fbd11ba8d79005ecfab7840730cb0525ef2abb5408d1bb805def656cdbd8ba 1 --max-fee auto --private-key-path ./.pkey_local
```

## Deploy EX08
```
protostar -p devnet declare ./build/ex08.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto

protostar -p devnet deploy 0x01c8b6245ae4606b91fbc2e7d6d4c6abd72f730e4edfcf393915291e9e2d47e2 --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 1182650070130573435193028845990660031073426562100538112561262125938226576593 961180306726768256007213141751957493112749470679826243697583243652066956019 1 8
```

## Set Admin for EX08
```
protostar -p devnet invoke --contract-address 0x0220023f0e6a09b79b986e385dc3173f1bcfdeb144af7aaa8af1db104e17d2f3 --function "set_exercise_or_admin" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x07ba7fcf8b8406ce0a657965f42e10d4973ec9a93526ef6d2210b1fcbeddeef5 1 --max-fee auto --private-key-path ./.pkey_local

protostar -p devnet invoke --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "set_teacher" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x07ba7fcf8b8406ce0a657965f42e10d4973ec9a93526ef6d2210b1fcbeddeef5 1 --max-fee auto --private-key-path ./.pkey_local
```

## Deploy EX09
```
protostar -p devnet declare ./build/ex09.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto

protostar -p devnet deploy 0x05ccd05daadde40913c066e40cd3101500699f7e276c72f668f2de0b1d637c3b --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 1182650070130573435193028845990660031073426562100538112561262125938226576593 961180306726768256007213141751957493112749470679826243697583243652066956019 1 9
```

## Set Admin for EX09
```
protostar -p devnet invoke --contract-address 0x0220023f0e6a09b79b986e385dc3173f1bcfdeb144af7aaa8af1db104e17d2f3 --function "set_exercise_or_admin" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x00d031f29334f67a48e442ee6d875836b7605fca1383e4a9051c0dfbbfc7e9e2 1 --max-fee auto --private-key-path ./.pkey_local

protostar -p devnet invoke --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "set_teacher" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x00d031f29334f67a48e442ee6d875836b7605fca1383e4a9051c0dfbbfc7e9e2 1 --max-fee auto --private-key-path ./.pkey_local
```

## Deploy EX10
```
protostar -p devnet declare ./build/ex10.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto

protostar -p devnet deploy 0x05b2984c7787b3dc3be4be58b78b73343dcecfcded247c40c455bcd9a1b99c5a --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 1182650070130573435193028845990660031073426562100538112561262125938226576593 961180306726768256007213141751957493112749470679826243697583243652066956019 1 10
```

## Deploy EX10b
```
protostar -p devnet declare ./build/ex10b.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto

protostar -p devnet deploy 0x037c0f354775165b86b1e5aa3a329f39800189a97579a63a056c6bb1a446ca78 --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 1728141856076841822517716656559132892769257647002698118798509769515037151786
```

## Set Admin for EX10
```
protostar -p devnet invoke --contract-address 0x0220023f0e6a09b79b986e385dc3173f1bcfdeb144af7aaa8af1db104e17d2f3 --function "set_exercise_or_admin" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x03d217f804a925b2931772d68cdd540b0adf6fb0d3a0d322dc8743693e94d22a 1 --max-fee auto --private-key-path ./.pkey_local

protostar -p devnet invoke --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "set_teacher" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x03d217f804a925b2931772d68cdd540b0adf6fb0d3a0d322dc8743693e94d22a 1 --max-fee auto --private-key-path ./.pkey_local
```

## Deploy EX11
```
protostar -p devnet declare ./build/ex11.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto

protostar -p devnet deploy 0x0723f1d88ccb392fe7ba2e16221c10d68b7bd7b54bb6f449ffc7f20ba6453c12 --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 1182650070130573435193028845990660031073426562100538112561262125938226576593 961180306726768256007213141751957493112749470679826243697583243652066956019 1 11
```

## Set Admin for EX11
```
protostar -p devnet invoke --contract-address 0x0220023f0e6a09b79b986e385dc3173f1bcfdeb144af7aaa8af1db104e17d2f3 --function "set_exercise_or_admin" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x067eef4ee32c3dc3aa61d23b0d1d4cd921675bfbaa68b1cf3b6e1cc3adc37e9e 1 --max-fee auto --private-key-path ./.pkey_local

protostar -p devnet invoke --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "set_teacher" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x067eef4ee32c3dc3aa61d23b0d1d4cd921675bfbaa68b1cf3b6e1cc3adc37e9e 1 --max-fee auto --private-key-path ./.pkey_local
```

## Deploy EX12
```
protostar -p devnet declare ./build/ex12.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto

protostar -p devnet deploy 0x075490bd8b63d12e9063586972c91caf26a0e8c47b57fcaf0d6de5fa447ae3a8 --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 1182650070130573435193028845990660031073426562100538112561262125938226576593 961180306726768256007213141751957493112749470679826243697583243652066956019 1 12
```

## Set Admin for EX12
```
protostar -p devnet invoke --contract-address 0x0220023f0e6a09b79b986e385dc3173f1bcfdeb144af7aaa8af1db104e17d2f3 --function "set_exercise_or_admin" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x00d014e9d7da3b9e4cc24c2640e2cc9f1ca95186b39362ab14528b6324f79b14 1 --max-fee auto --private-key-path ./.pkey_local

protostar -p devnet invoke --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "set_teacher" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x00d014e9d7da3b9e4cc24c2640e2cc9f1ca95186b39362ab14528b6324f79b14 1 --max-fee auto --private-key-path ./.pkey_local
```

## Set Random Values for EX12
```
starknet invoke --address 0x00d014e9d7da3b9e4cc24c2640e2cc9f1ca95186b39362ab14528b6324f79b14 --function set_random_values --abi ./build/ex12_abi.json  --inputs 100 5919 2682 7799 7765 9255 2249 8673 8649 9605 9669 9298 7384 8376 4535 5215 3552 4969 6803 8787 7403 7665 3286 1907 2228 5957 8153 6286 4738 7617 8216 9892 973 3389 941 663 3824 4120 9933 1237 570 3598 3360 2837 4401 2385 5226 8762 9335 6541 5965 4642 5677 8434 6027 8255 9684 487 8089 880 2532 3258 7896 416 6382 9127 6130 581 8543 5394 2321 2179 1657 464 6558 168 5035 5641 9209 1626 7485 7111 6225 9902 9584 8783 4900 4534 7004 3618 5641 7900 5585 7029 5298 2725 7107 6881 1626 9654 2022 --feeder_gateway_url http://127.0.0.1:5050  --gateway_url http://127.0.0.1:5050
```

## Deploy EX13
```
protostar -p devnet declare ./build/ex13.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto

protostar -p devnet deploy 0x058db84e6e53cf49dd607d83d61f1b6671cbcb9b3a7470a1f3b004b7baab54b5 --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 1182650070130573435193028845990660031073426562100538112561262125938226576593 961180306726768256007213141751957493112749470679826243697583243652066956019 1 13 100 5919 2682 7799 7765 9255 2249 8673 8649 9605 9669 9298 7384 8376 4535 5215 3552 4969 6803 8787 7403 7665 3286 1907 2228 5957 8153 6286 4738 7617 8216 9892 973 3389 941 663 3824 4120 9933 1237 570 3598 3360 2837 4401 2385 5226 8762 9335 6541 5965 4642 5677 8434 6027 8255 9684 487 8089 880 2532 3258 7896 416 6382 9127 6130 581 8543 5394 2321 2179 1657 464 6558 168 5035 5641 9209 1626 7485 7111 6225 9902 9584 8783 4900 4534 7004 3618 5641 7900 5585 7029 5298 2725 7107 6881 1626 9654 2022
```

## Set Admin for EX13
```
protostar -p devnet invoke --contract-address 0x0220023f0e6a09b79b986e385dc3173f1bcfdeb144af7aaa8af1db104e17d2f3 --function "set_exercise_or_admin" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x04a585f1507a6f6e3072b39952a5eb3955726bf5bd1f66b7d2be0410b434f40a 1 --max-fee auto --private-key-path ./.pkey_local

protostar -p devnet invoke --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "set_teacher" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x04a585f1507a6f6e3072b39952a5eb3955726bf5bd1f66b7d2be0410b434f40a 1 --max-fee auto --private-key-path ./.pkey_local
```

## Deploy EX14
```
protostar -p devnet declare ./build/ex14.json --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto

protostar -p devnet deploy 0x07363302a1c6373edd5f969adce9c982419b2dbb307330f491505f0136f16c7d --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --private-key-path ./.pkey_local --max-fee auto -i 1182650070130573435193028845990660031073426562100538112561262125938226576593 961180306726768256007213141751957493112749470679826243697583243652066956019 1 14
```

## Set Admin for EX14
```
protostar -p devnet invoke --contract-address 0x0220023f0e6a09b79b986e385dc3173f1bcfdeb144af7aaa8af1db104e17d2f3 --function "set_exercise_or_admin" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x07434d31238916a8f2c7fc3a779eff989d30a89ebc0e3239203fb7fc29ea5dcc 1 --max-fee auto --private-key-path ./.pkey_local

protostar -p devnet invoke --contract-address 0x029d5b312473d2eacfbc3685c3a498e0d8472f7a44a193145c799b8d9c8d3cd1 --function "set_teacher" --account-address 0x1dbcf844695857018455d7d574f25415ec90745ba51baf0a9acca93e2ed96e8 --inputs 0x07434d31238916a8f2c7fc3a779eff989d30a89ebc0e3239203fb7fc29ea5dcc 1 --max-fee auto --private-key-path ./.pkey_local
```