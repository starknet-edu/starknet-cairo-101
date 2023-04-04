### Solutions from command line

export TEST_ACCOUNT_NAME=test
export TEST_ACCOUNT=0x068Da31BA0Fb8602B45314d740c597411A4f9578FF8c53d23D8a644432cE17cB

```bash
## check your balance after each ex
starknet call --function balanceOf --address 0x044f65adbdb59bf1db71e8b69efb7c9d0b810db94c1730a05fa5751b02d396de --inputs $TEST_ACCOUNT
```

## Ex1 and Ex2
```bash
##ex1
starknet invoke --function claim_points --address 0x031d1866cb827c4e27bbca9ffee59fa2158b679413ffb58c3f90af56e1140e85 --account $TEST_ACCOUNT_NAME --max_fee 100000000000000000

##ex2
starknet invoke --function claim_points --address 0x0600f8fe0752e598b4e6b27839f00ad65215d129f385e12931323c487b6f9b36 --inputs 0x4b454b --account $TEST_ACCOUNT_NAME --max_fee 100000000000000000
```

## Ex3
``` bash
starknet invoke --function increment_counter --address 0x033d5fc40c0e262612528a9a652ada70be854d98241fb7548745262b5273c9d1 --account $TEST_ACCOUNT_NAME --max_fee 100000000000000000

starknet invoke --function increment_counter --address 0x033d5fc40c0e262612528a9a652ada70be854d98241fb7548745262b5273c9d1 --account $TEST_ACCOUNT_NAME --max_fee 100000000000000000

starknet invoke --function decrement_counter --address 0x033d5fc40c0e262612528a9a652ada70be854d98241fb7548745262b5273c9d1 --account $TEST_ACCOUNT_NAME --max_fee 100000000000000000

starknet invoke --function claim_points --address 0x033d5fc40c0e262612528a9a652ada70be854d98241fb7548745262b5273c9d1 --account $TEST_ACCOUNT_NAME --max_fee 100000000000000000
```

## Ex4
```bash

```

## Ex5
```bash

```

## Ex6
```bash

```

## Ex7
```bash
starknet invoke --function claim_points --address 0x006051096480f375894eebb99948bce14a84c25093636c4b4e8222cc32a67cf0 --inputs 41 0 --account $TEST_ACCOUNT_NAME --max_fee 100000000000000000
```

## Ex8
```bash
starknet invoke --function set_user_values --address 0x01ec8e981b1b6a7256a71f21790dd07cafeb15d02c18534a2bd4a6c8551860aa --inputs $TEST_ACCOUNT 11 1 2 3 4 5 6 7 8 9 10  --account $TEST_ACCOUNT_NAME --max_fee 100000000000000000

starknet call --function get_user_values --address 0x01ec8e981b1b6a7256a71f21790dd07cafeb15d02c18534a2bd4a6c8551860aa --inputs $TEST_ACCOUNT

starknet invoke --function claim_points --address 0x01ec8e981b1b6a7256a71f21790dd07cafeb15d02c18534a2bd4a6c8551860aa --inputs 123123 --account $TEST_ACCOUNT_NAME --max_fee 100000000000000000

```

## Ex9
```bash

# get sum potentail bug, need to fix.

```

## Ex10
```bash
 # seems have issues
```

## Ex10b
```bash
starknet call --function get_ex10_address --address 0x03d716daa35b7cdb5b08a630785fecb208599936ff140f67e2827f4fd36c841b
starknet call --function get_secret_value --address 0x03d716daa35b7cdb5b08a630785fecb208599936ff140f67e2827f4fd36c841b
```

## Ex11
```bash
starknet invoke --function claim_points --address 0x029a9a484d22a6353eff0d60ea56c6ffabaaac5e4889182287ef1d261578b197 --inputs 9811398123 9811398124 --account $TEST_ACCOUNT_NAME --max_fee 100000000000000000
```

## Ex12
```bash
starknet invoke --function assign_user_slot --address 0x04a221a8e3155fb03d1708881213a2ecdb05a41cf0ae6de83ddcf8f12bb04282 --account $TEST_ACCOUNT_NAME --max_fee 100000000000000000
starknet invoke --function claim_points --address 0x04a221a8e3155fb03d1708881213a2ecdb05a41cf0ae6de83ddcf8f12bb04282 --inputs 5970 --account $TEST_ACCOUNT_NAME --max_fee 100000000000000000
```

## Ex13
```bash
starknet invoke --function assign_user_slot --address 0x067ed1d23c5cc3a34fb86edd4f8415250c79a374e87bcf2e6870321261ca9b0f --account $TEST_ACCOUNT_NAME --max_fee 100000000000000000
starknet invoke --function claim_points --address 0x067ed1d23c5cc3a34fb86edd4f8415250c79a374e87bcf2e6870321261ca9b0f --inputs 5970 --account $TEST_ACCOUNT_NAME --max_fee 100000000000000000
```

## Ex14
```bash

## Need to deploy a new contract to do this.
## Need to enable token transfer.

```