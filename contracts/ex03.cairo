// ######## Ex 03
// Using contract functions to manipulate contract variables
// In this exercise, you need to:
// - Use this contract's functions in order to manipulate an internal counter unique to your address
// - Once this counter reaches a certain value, call a specific function
// - Your points are credited by the contract

// # What you'll learn
// - How to declare mappings
// - How to read and write to mappings
// - How to use a function to manipulate storage variables

// ######## General directives and imports
//
//

%lang starknet

from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.cairo_builtins import HashBuiltin
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

// Declaring a mapping called user_counters_storage. For each 'account' key, which is a felt, we store a value which is a felt also.
@storage_var
func user_counters_storage(account: felt) -> (user_counters_storage: felt) {
}

//
// Declaring getters
// Public variables should be declared explicitly with a getter
//

// Declaring a getter for our mappings. It takes one argument as a parameter, the account you wish to read the counter of
@view
func user_counters{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    account: felt
) -> (user_counter: felt) {
    let (user_counter) = user_counters_storage.read(account);
    return (user_counter,);
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
//

@external
func claim_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // Reading caller address
    let (sender_address) = get_caller_address();
    // Checking that user's counter is equal to 7
    let (current_counter_value) = user_counters_storage.read(sender_address);
    with_attr error_message("Counter is not equal to 7") {
        assert current_counter_value = 7;
    }
    // Checking if the user has validated the exercise before
    validate_exercise(sender_address);
    // Sending points to the address specified as parameter
    distribute_points(sender_address, 2);
    return ();
}

@external
func reset_counter{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // Reading caller address
    let (sender_address) = get_caller_address();
    // Reinitializing the user counter
    user_counters_storage.write(sender_address, 0);
    return ();
}

@external
func increment_counter{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // Reading caller address
    let (sender_address) = get_caller_address();
    // Reading counter from storage
    let (current_counter_value) = user_counters_storage.read(sender_address);
    // Writing updated value to storage
    user_counters_storage.write(sender_address, current_counter_value + 2);
    return ();
}

@external
func decrement_counter{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // Reading caller address
    let (sender_address) = get_caller_address();
    // Reading counter from storage
    let (current_counter_value) = user_counters_storage.read(sender_address);
    // Writing updated value to storage
    user_counters_storage.write(sender_address, current_counter_value - 1);
    return ();
}
