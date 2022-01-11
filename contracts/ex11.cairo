######### Ex 11
## Importing functions
# In this exercice, you need to:
# - Read this contract and understand how it imports functions from another contract
# - Find the relevant contract it imports from
# - Read the code and understand what is expected of you



%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import (assert_not_zero, assert_le)

# This contract imports functions from another file than other exercices, be careful
from contracts.utils.ex11_base import (
    tderc20_address,
    has_validated_exercice,
    distribute_points,
    validate_exercice,
    ex_initializer,
    validate_answers,
    ex11_secret_value
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
func claim_points{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(sender_address: felt, secret_value_i_guess: felt, next_secret_value_i_chose: felt):

    # Check if your answer is correct
    validate_answers(sender_address, secret_value_i_guess, next_secret_value_i_chose)
    # Checking if the user has validated the exercice before
    validate_exercice(sender_address)
    # Sending points to the address specified as parameter
    distribute_points(sender_address, 2)
    return ()
end

