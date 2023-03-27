starknet declare --contract starknet_cairo_101_Ex00Base.json --account version_11
Sending the transaction with max_fee: 0.000017 ETH (16582254383796 WEI).
Declare transaction was sent.
Contract class hash: 0x2791bbb1aa135f7903e457357b36cebe5123e8e6657a2e0674e9bb3172c345
Transaction hash: 0x398b7cd9c9cae5df800b366851e8f09e276f6685a25250b2bd09e043a356eae


starknet deploy --class_hash 0x2791bbb1aa135f7903e457357b36cebe5123e8e6657a2e0674e9bb3172c345 --account version_11
Sending the transaction with max_fee: 0.000066 ETH (66119956453359 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x03f509705a95b01d01058deca944e7931f7cf81c93d20da4325db01301f5c69b
Transaction hash: 0x31496e42adc70ee7b69d1021261538df8985d59b3b06825fc9a6b26e6b92263

================================================================================================================================================

starknet declare --contract starknet_cairo_101_ERC20Base.json --account version_11
Sending the transaction with max_fee: 0.000031 ETH (30670745847265 WEI).
Declare transaction was sent.
Contract class hash: 0x68c7dea0af3d8a5d86675e8691af52605d6236ec0483209fdf27bdaaabaa364
Transaction hash: 0xd850b64b4c5b2c75e29320c995a787afceb31040536e18507b58cc1168f099


starknet deploy --class_hash 0x68c7dea0af3d8a5d86675e8691af52605d6236ec0483209fdf27bdaaabaa364 --account version_11
Sending the transaction with max_fee: 0.000073 ETH (73194953676383 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x074c9d00ec80a938225e2dc39aa1566c99e9f532bf4b3323a4fc01ca8cd4c0d6
Transaction hash: 0x4f23397a152d19e0365fffeaf004bc61b545c8f11216dca7d38e0260899b355

================================================================================================================================================

starknet declare --contract target/release/starknet_cairo_101_PlayersRegistry.json --account version_11
Declare transaction was sent.
Contract class hash: 0x033049995b12eca958ef2b07ea8ee2365e809738336339cb2eccb0175898270d
Transaction hash: 0x01f985b0bc5ff83328aa4a103352dd6a47ec7583e3421f2cf1346370e56d5535

starknet deploy --class_hash 0x033049995b12eca958ef2b07ea8ee2365e809738336339cb2eccb0175898270d --inputs 0x04b22f492ade0853a8586e003978976ed19e4bcbc8df133b0f98ea768c80dd10 --account version_11

FEE_TRANSFER_FAILURE
Actual fee exceeded max fee.
187150376646254 > 174987888270947

================================================================================================================================================

starknet declare --contract target/release/starknet_cairo_101_TDERC20.json --account version_11
Sending the transaction with max_fee: 0.000135 ETH (135294361343034 WEI).
Declare transaction was sent.
Contract class hash: 0x7e3b8a92370500247689e929b6e13653811932f3b95ba0a75b4dfe5562b2ad7
Transaction hash: 0x6f18d14b2e84915b04c41c4283f5e5e65ee8c6d21c85196f8bec077840dc495

starknet deploy --class_hash 0x7e3b8a92370500247689e929b6e13653811932f3b95ba0a75b4dfe5562b2ad7 --inputs 10057515165931654559836545801321088512241713 357609582641 18 1000000000000000000 0 0x04b22f492ade0853a8586e003978976ed19e4bcbc8df133b0f98ea768c80dd10 0x04b22f492ade0853a8586e003978976ed19e4bcbc8df133b0f98ea768c80dd10 --account version_11
Sending the transaction with max_fee: 0.001418 ETH (1418498095571542 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x00b29d3a0ddb75f4d5200b6b72e56f6511ddbbf16dff72be4831d86302107120
Transaction hash: 0x7141a748083a105d37a0563d87605a945961250d4e5ca5bcf289c0a8f590b58

