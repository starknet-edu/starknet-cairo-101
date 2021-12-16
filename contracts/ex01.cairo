%lang starknet

from contracts.token.ITDERC20 import ITDERC20


#
# Constructor
#


#
# Getters
#

@view
func name{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }() -> (name: felt):
    let (name) = ERC20_name.read()
    return (name)
end
