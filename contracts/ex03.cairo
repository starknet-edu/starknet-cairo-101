######### Ex 03
# Using contract functions to manipulate contract variables
# In this exercice, you need to:
# - Use this contract's functions in order to manipulate an internal counter unique to your address
# - Once this counter reaches a certain value, call a specific function
# - Your points are credited by the contract

## What you'll learn
# - How to declare mappings
# - How to read and write to mappings
# - How to use a function to manipulate storage variables

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


#
# Declaring storage vars
# Storage vars are by default not visible through the ABI. They are similar to "private" variables in Solidity
#

# Declaring a mapping called user_counters_storage. For each 'account' key, which is a felt, we store a value which is a felt also.
@storage_var
func user_counters_storage(account: felt) -> (user_counters_storage: felt):
end

#
# Declaring getters
# Public variables should be declared explicitely with a getter
#

# Declaring a getter for our mappings. It takes one argument as a parameter, the account you wish to read the counter of
@view
func user_counters{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(account: felt) -> (user_counter: felt):
    let (user_counter) = user_counters_storage.read(account)
    return (user_counter)
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
#

@external
func claim_points{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(sender_address: felt):
    # Checking that user's counter is equal to 7
    let (current_counter_value) = user_counters_storage.read(sender_address)
    assert current_counter_value = 7

    # Checking if the user has validated the exercice before
    validate_exercice(sender_address)
    # Sending points to the address specified as parameter
    distribute_points(sender_address, 2)
    return ()
end

@external
func reset_counter{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(sender_address: felt):
    # Reinitializing the user counter
    user_counters_storage.write(sender_address, 0)
    return()
end

@external
func increment_counter{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(sender_address: felt, salt: felt):
    # Important: due to the way transaction hashes are calculated currently, you'll need to change salt everytime you call this function.
    # Otherwise, the transaction hash will stay the same and your transaction won't execute the following iteration
    # Reading counter from storage
    let (current_counter_value) = user_counters_storage.read(sender_address)
    # Writing updated value to storage
    user_counters_storage.write(sender_address, current_counter_value+2)
    return()
end

@external
func decrement_counter{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(sender_address: felt, salt: felt):
    # Important: due to the way transaction hashes are calculated currently, you'll need to change salt everytime you call this function.
    # Otherwise, the transaction hash will stay the same and your transaction won't execute the following iteration
    # Reading counter from storage
    let (current_counter_value) = user_counters_storage.read(sender_address)
    # Writing updated value to storage
    user_counters_storage.write(sender_address, current_counter_value-1)
    return()
end





