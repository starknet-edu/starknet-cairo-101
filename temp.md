export STARKNET_NETWORK=alpha-goerli
export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount


starknet declare --contract target/release/starknet_cairo_101_Ex00Base.json --account version_11
Sending the transaction with max_fee: 0.000000 ETH (105123114666 WEI).
Declare transaction was sent.
Contract class hash: 0x79f1ec1f451548eb27337f42841185b42acd6b9afbb28ae9d89a9527847c54
Transaction hash: 0x1abea07639dd51d7285aa6c9e0762a5d807d1945a961a4c625df07349fd12fe

starknet tx_status --hash 0x1abea07639dd51d7285aa6c9e0762a5d807d1945a961a4c625df07349fd12fe

starknet deploy --class_hash 0x79f1ec1f451548eb27337f42841185b42acd6b9afbb28ae9d89a9527847c54 --account version_11
Sending the transaction with max_fee: 0.000000 ETH (206743524373 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x0456824a3c047407fe15f98012e06ccc37efef00ed0c4340c12c287fe9adfea2
Transaction hash: 0x3a5dff38feeadd252293a15c1ba6aa939f7b12b89ea70e9c83dfbeb49230ab2

================================================================================================================================================

starknet declare --contract target/release/starknet_cairo_101_ERC20Base.json --account version_11
Sending the transaction with max_fee: 0.000031 ETH (30670745847265 WEI).
Declare transaction was sent.
Contract class hash: 0x68c7dea0af3d8a5d86675e8691af52605d6236ec0483209fdf27bdaaabaa364
Transaction hash: 0x00d850b64b4c5b2c75e29320c995a787afceb31040536e18507b58cc1168f099

starknet deploy --class_hash 0x68c7dea0af3d8a5d86675e8691af52605d6236ec0483209fdf27bdaaabaa364 --account version_11
Sending the transaction with max_fee: 0.000073 ETH (73194953676383 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x074c9d00ec80a938225e2dc39aa1566c99e9f532bf4b3323a4fc01ca8cd4c0d6
Transaction hash: 0x4f23397a152d19e0365fffeaf004bc61b545c8f11216dca7d38e0260899b355

================================================================================================================================================

starknet declare --contract target/release/starknet_cairo_101_PlayersRegistry.json --account version_11
Declare transaction was sent.
Contract class hash: 0x07a6e514bb54d60ac1cfe8c53a872fbc23ebf25137d093c23c3bf01a6ae5b1c6
Transaction hash: 0x06e3c0e562502c1d3a0a17b5875f6d083214555a4bb13d3fb00b37d20da1afb0

starknet deploy --class_hash 0x07a6e514bb54d60ac1cfe8c53a872fbc23ebf25137d093c23c3bf01a6ae5b1c6 --inputs 0x04b22f492ade0853a8586e003978976ed19e4bcbc8df133b0f98ea768c80dd10 --account version_11 --max_fee 99999999999999
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
starknet declare --contract target/release/starknet_cairo_101_Ex14.json --account version_11 --max_fee 99999999999999
Declare transaction was sent.
Contract class hash: 0x03c1872bae0e57d9a9bd087ac87eebcf8153d1b0ef66d12a9fb42075fd9c2c4e
Transaction hash: 0x025342247b18e95bb344316e72c81e1e380e78446fdccd3cedd7cf8d1b49b2c0

starknet deploy --class_hash 0x03c1872bae0e57d9a9bd087ac87eebcf8153d1b0ef66d12a9fb42075fd9c2c4e --inputs 0x008a29585f1ee19eb30e77c7332d7d31449a15187e454ea8d463801b8534aa86 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba 1 14 --account version_11 --max_fee 99999999999999
Invoke transaction for contract deployment was sent.
Contract address: 0x0228a48ec35c161a70e417f54145d9a9dc0ad274dd83750041ef5d22a677bc75
Transaction hash: 0x57007de85ea8cc61e4fc41ce9d92a9042cabe1c4d8366dbf7829cde2f63caea

"tx_failure_reason": {
        "code": "TRANSACTION_FAILED",
        "error_message": "Error at pc=0:32:\nGot an exception while executing a hint.\nCairo traceback (most recent call last):\nUnknown location (pc=0:557)\nUnknown location (pc=0:519)\nUnknown location (pc=0:625)\n\nError in the called contract (0x498a667ab7cff4bd5cefd8d1676759ddd265be5aef3b94ecf7a9dfe616b933d):\nError at pc=0:45:\nGot an exception while executing a hint.\nCairo traceback (most recent call last):\nUnknown location (pc=0:597)\nUnknown location (pc=0:568)\n\nError in the called contract (0x228a48ec35c161a70e417f54145d9a9dc0ad274dd83750041ef5d22a677bc75):\nExecution was reverted; failure reason: [0x753132385f66726f6d204f46]."
    },

Text: u128_from OF