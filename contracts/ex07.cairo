######### Ex 07
## Understanding functions to compare values
# In this exercice, you need to:
# - Use this contract's claim_points() function 
# - Your points are credited by the contract

######### References
# Documentation is still being written. You can find answers in this file
# https://github.com/starkware-libs/cairo-lang/blob/master/src/starkware/cairo/common/math.cairo

%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import (
        assert_not_zero,
        assert_not_equal,
        assert_nn,
        assert_le,
        assert_lt,
        assert_in_range        
)

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
# Calling this function will simply credit 2 points to the address specified in parameter
#

@external
func claim_points{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(sender_address: felt, value_a: felt, value_b: felt):
    # Checking that the passed values are correct
    assert_not_zero(value_a)
    assert_nn(value_b)
    assert_not_equal(value_a, value_b)
    assert_le(value_a, 75)
    assert_in_range(value_a, 40, 70)
    assert_lt(value_b, 1)
    # Checking if the user has validated the exercice before
    validate_exercice(sender_address)
    # Sending points to the address specified as parameter
    distribute_points(sender_address, 2)
    return ()
end



