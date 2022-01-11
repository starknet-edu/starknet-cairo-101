######### Ex 01
## Using a simple public contract function
# In this exercice, you need to:
# - Use this contract's claim_points() function
# - Your points are credited by the contract

## What you'll learn
# - General smart contract syntax
# - Calling a function

######### General directives and imports
#
#

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


######### Constructor
# This function is called when the contract is deployed
#
@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        _tderc20_address : felt):
    ex_initializer(_tderc20_address)
    return ()
end

######### External functions
# These functions are callable by other contracts
#

# This function is called claim_points
# It takes one argument as a parameter (sender_address), which is a felt. Read more about felts here TODO
# It also has implicit arguments (syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr). Read more about implicit arguments here TODO
@external
func claim_points{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(sender_address: felt):
    # Checking if the user has validated the exercice before
    validate_exercice(sender_address)
    # Sending points to the address specified as parameter
    distribute_points(sender_address, 2)
    return ()
end



