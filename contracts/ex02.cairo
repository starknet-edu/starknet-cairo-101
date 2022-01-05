######### Ex 02
## Asserts




%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_not_zero
from contracts.utils.ex00_base import (
    tderc20_address,
    has_validated_exercice,
    distribute_points,
    validate_exercice,
    ex_initializer
)



#
# Constructor
#
@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        _tderc20_address : felt):
    ex_initializer(_tderc20_address)
    return ()
end

#
# External functions
#

@external
func claim_points{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(sender_address: felt, my_value: felt):
	# Checking that the value sent is correct
	# Using assert this way is similar to using "require" in Solidity
	assert my_value = 180618
	# Checking if the user has validated the exercice before
	validate_exercice(sender_address)
	# Sending points to the address specified as parameter
	distribute_points(sender_address, 2)
    return ()
end







