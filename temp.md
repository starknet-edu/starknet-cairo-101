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

starknet deploy --class_hash 0x07a6e514bb54d60ac1cfe8c53a872fbc23ebf25137d093c23c3bf01a6ae5b1c6 --inputs 0x04b22f492ade0853a8586e003978976ed19e4bcbc8df133b0f98ea768c80dd10 --account version_11
Sending the transaction with max_fee: 0.000000 ETH (318891749831 WEI).
Invoke transaction for contract deployment was sent.
Contract address: 0x06b2c700fba286cd43a29dc99d6f106442968ee1e3aa219c0cde6c521c9874ba
Transaction hash: 0x347c6d3227214ae1894d9b1dc1193a0c07e812a407b91e1ab1000ea094a01e7

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

