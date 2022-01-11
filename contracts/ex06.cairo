######### Ex 06
# External vs internal functions
# In this exercice, you need to:
# - Use a function to get assigned a private variable
# - Use an internal function to duplicate this variable in a public variable
# - Use a function to show you know the correct value of the private variable
# - Your points are credited by the contract


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

@storage_var
func user_slots_storage(account: felt) -> (user_slot_storage: felt):
end

@storage_var
func user_values_public_storage(account: felt) -> (user_values_public_storage: felt):
end

@storage_var
func values_mapped_secret_storage(slot: felt) -> (value_mapped_storage: felt):
end

@storage_var
func was_initialized() -> (was_initialized: felt):
end

@storage_var
func next_slot() -> (was_initialized: felt):
end


#
# Declaring getters
# Public variables should be declared explicitely with a getter
#

@view
func user_slots{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(account: felt) -> (user_slot: felt):
    let (user_slot) = user_slots_storage.read(account)
    return (user_slot)
end

@view
func user_values{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(account: felt) -> (user_value: felt):
    let (value) = user_values_public_storage.read(account)
    return (value)
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
func claim_points{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(sender_address: felt, expected_value: felt):
    # Checking that the user got a slot assigned
    let (user_slot) = user_slots_storage.read(sender_address)
    assert_not_zero(user_slot)

    # Checking that the value provided by the user is the one we expect
    # Still sneaky.
    let (value) = values_mapped_secret_storage.read(user_slot)
    assert value = expected_value

    # Checking if the user has validated the exercice before
    validate_exercice(sender_address)
    # Sending points to the address specified as parameter
    distribute_points(sender_address, 2)
    return ()
end

@external
func assign_user_slot{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(sender_address: felt):
    # user_counters_storage.write(sender_address, 0)
    let (next_slot_temp) = next_slot.read()
    let (next_value) = values_mapped_secret_storage.read(next_slot_temp + 1)
    if next_value == 0:
        user_slots_storage.write(sender_address, 0)
        next_slot.write(0)
    else:
        user_slots_storage.write(sender_address, next_slot_temp + 1)
        next_slot.write(next_slot_temp + 1)
    end
    return()
end

@external
func external_handler_for_internal_function{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(sender_address: felt, a_value: felt):
    # Just for fun
    assert a_value = 0
    # Calling internal function
    copy_secret_value_to_readable_mapping(sender_address)
    return()
end

#
# Internal functions
# These functions can only be called by functions inside the same contract
# Maybe some external functions allow you to call these?
#

func copy_secret_value_to_readable_mapping{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(sender_address: felt):
    # Checking that the user got a slot assigned
    let (user_slot) = user_slots_storage.read(sender_address)
    assert_not_zero(user_slot)

    # Reading user secret value
    let (secret_value) = values_mapped_secret_storage.read(user_slot)

    # Copying the value from non accessible values_mapped_secret_storage to 
    user_values_public_storage.write(sender_address, secret_value)
    return()
end


#
# External functions - Administration
# Only admins can call these. You don't need to understand them to finish the exercice.
#

@external
func set_random_values{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(values_len: felt, values: felt*):

    # Check if the random values were already initialized
    let (was_initialized_read) = was_initialized.read()
    assert was_initialized_read = 0
    
    # Storing passed values in the store
    set_a_random_value(values_len, values)

    # Mark that value store was initialized
    was_initialized.write(1)
    # user_counters_storage.write(sender_address, 0)
    return()
end

func set_a_random_value{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(values_len: felt, values: felt*):
    if values_len == 0:
        # Start with sum=0.
        return ()
    end


    set_a_random_value(values_len=values_len - 1, values=values + 1 )
    values_mapped_secret_storage.write(values_len-1, [values])

    return ()
end



