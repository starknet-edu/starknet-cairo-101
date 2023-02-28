// ######## Ex 08
// # Recursions - basics
// In this exercise, you need to:
// - Use this contract's claim_points() function
// - Your points are credited by the contract

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_not_zero, assert_le
from starkware.starknet.common.syscalls import get_caller_address
from contracts.utils.ex00_base import (
    tderc20_address,
    has_validated_exercise,
    distribute_points,
    validate_exercise,
    ex_initializer,
)

//
// Declaring storage vars
// Storage vars are by default not visible through the ABI. They are similar to "private" variables in Solidity
//

@storage_var
func user_values_storage(account: felt, slot: felt) -> (user_values_storage: felt) {
}

//
// Declaring getters
// Public variables should be declared explicitly with a getter
//

@view
func user_values{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    account: felt, slot: felt
) -> (value: felt) {
    let (value) = user_values_storage.read(account, slot);
    return (value,);
}

//
// Constructor
//
@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    _tderc20_address: felt, _players_registry: felt, _workshop_id: felt, _exercise_id: felt
) {
    ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    return ();
}

//
// External functions
// Calling this function will simply credit 2 points to the address specified in parameter
//

@external
func claim_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // Reading caller address
    let (sender_address) = get_caller_address();

    // Checking the value of user_values_storage for the user, at slot 10
    let (user_value_at_slot_ten) = user_values_storage.read(sender_address, 10);

    with_attr error_message("User value should be 10 (you can set it with set_user_values)") {
        // This value should be equal to 10
        assert user_value_at_slot_ten = 10;
    }

    // Checking if the user has validated the exercise before
    validate_exercise(sender_address);
    // Sending points to the address specified as parameter
    distribute_points(sender_address, 2);
    return ();
}

// This function takes an array as a parameter
// In order to pass it, the user needs to pass both the array and its length
// This complexity is abstracted away by voyager, where you simply need to pass an array
@external
func set_user_values{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    account: felt, array_len: felt, array: felt*
) {
    set_user_values_internal(account, array_len, array);
    return ();
}

//
// Internal functions
//
//

func set_user_values_internal{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    account: felt, length: felt, array: felt*
) {
    // This function is used recursively to set all the user values
    // Recursively, we first go through the length of the array
    // Once at the end of the array (length = 0), we start summing
    if (length == 0) {
        // Start with sum=0.
        return ();
    }

    // If length is NOT zero, then the function calls itself again, moving forward one slot
    set_user_values_internal(account=account, length=length - 1, array=array + 1);

    // This part of the function is first reached when length=0.
    user_values_storage.write(account, length - 1, [array]);
    return ();
}
