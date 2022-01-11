######### Ex 02
## Understanding asserts
# In this exercice, you need to:
# - Use this contract's claim_points() function
# - Your points are credited by the contract

## What you'll learn
# - Using asserts
# - How to declare storage variables
# - How to read storage variables
# - How to create getter functions
# Asserts are a basic building bloc allowing you to verify that two values are the same. 
# They are similar to require() in Solidity
# More information about basic storage https://www.cairo-by-example.com/basics/storage

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
# This variable is a felt and is called my_secret_value_storage
# It can be read wtht my_secret_value_storage.read() or written to with my_secret_value_storage.write()

@storage_var
func my_secret_value_storage() -> (my_secret_value_storage: felt):
end

#
# Declaring getters
# Public variables should be declared explicitely with a getter
#


@view
func my_secret_value{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (my_secret_value: felt):
    let (my_secret_value) = my_secret_value_storage.read()
    return (my_secret_value)
end

######### Constructor
# This function is called when the contract is deployed
#
@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        _tderc20_address : felt, my_secret_value: felt):
    ex_initializer(_tderc20_address)
    my_secret_value_storage.write(my_secret_value)
    return ()
end

######### External functions
# These functions are callable by other contracts
#

@external
func claim_points{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(sender_address: felt, my_value: felt):
    # Reading stored value from storage
    let (my_secret_value) = my_secret_value_storage.read()
    # Checking that the value sent is correct
    # Using assert this way is similar to using "require" in Solidity
    assert my_value = my_secret_value
    # Checking if the user has validated the exercice before
    validate_exercice(sender_address)
    # Sending points to the address specified as parameter
    distribute_points(sender_address, 2)
    return ()
end







