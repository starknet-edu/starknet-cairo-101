######### Ex 09
## Recursions - advanced
# In this exercice, you need to:
# - Use this contract's claim_points() function
# - Your points are credited by the contract



%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import (assert_not_zero, assert_le)

from contracts.utils.ex00_base import (
    tderc20_address,
    has_validated_exercice,
    distribute_points,
    validate_exercice,
    ex_initializer
)

#
# View functions
#
@view
func get_sum{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(array_len: felt, array: felt*) -> (array_sum: felt):
    let (array_sum) = get_sum_internal(array_len, array)
    return (array_sum)
end

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
func claim_points{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(sender_address: felt, array_len: felt, array: felt*):
    # Checking that the array is at least of length 4
    assert_le(4, array_len)

    # Calculating the sum of the array sent by the user
    let (array_sum) = get_sum_internal(array_len, array)

    # The sum should be higher than 50
    assert_le ( 50, array_sum)

    # Checking if the user has validated the exercice before
    validate_exercice(sender_address)
    # Sending points to the address specified as parameter
    distribute_points(sender_address, 2)
    return ()
end

#
# Internal functions
#
#

func get_sum_internal{ range_check_ptr}(length : felt, array : felt*) -> (sum : felt):
    # This function is used recursively to calculate the sum of all the values in an array
    # Recursively, we first go through the length of the array
    # Once at the end of the array (length = 0), we start summing
    if length == 0:
        # Start with sum=0.
        return (sum=0)
    end

    # If length is NOT zero, then the function calls itself again, by moving forward one slot
    let (current_sum) = get_sum_internal(length=length - 1, array=array + 1)

    # This part of the function is first reached when length=0.
    # Checking that the first value in the array ([array]) is not 0
    assert_not_zero([array])
    # The sum begins
    let sum = [array] + current_sum

    assert_le(current_sum * 2, sum)
    # The return function targets the body of this function
    return (sum)
end


