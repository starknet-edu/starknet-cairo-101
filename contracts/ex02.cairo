// ######## Ex 02
// # Understanding asserts
// In this exercise, you need to:
// - Use this contract's claim_points() function
// - Your points are credited by the contract

// # What you'll learn
// - Using asserts
// - How to declare storage variables
// - How to read storage variables
// - How to create getter functions
// Asserts are a basic building block allowing you to verify that two values are the same.
// They are similar to require() in Solidity
// More information about basic storage https://www.cairo-by-example.com/basics/storage

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
// This variable is a felt and is called my_secret_value_storage
// From within a smart contract, it can be read with my_secret_value_storage.read() or written to with my_secret_value_storage.write()

@storage_var
func my_secret_value_storage() -> (my_secret_value_storage: felt) {
}

//
// Declaring getters
// Public variables should be declared explicitly with a getter
//

@view
func my_secret_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    my_secret_value: felt
) {
    let (my_secret_value) = my_secret_value_storage.read();
    return (my_secret_value,);
}

// ######## Constructor
// This function is called when the contract is deployed
//
@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    _tderc20_address: felt,
    _players_registry: felt,
    _workshop_id: felt,
    _exercise_id: felt,
    my_secret_value: felt,
) {
    ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    my_secret_value_storage.write(my_secret_value);
    return ();
}

// ######## External functions
// These functions are callable by other contracts
//

@external
func claim_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(my_value: felt) {
    // Reading caller address
    let (sender_address) = get_caller_address();
    // Reading stored value from storage
    let (my_secret_value) = my_secret_value_storage.read();
    // Checking that the value sent is correct
    // Using assert this way is similar to using "require" in Solidity
    with_attr error_message("Wrong secret value") {
        assert my_value = my_secret_value;
    }
    // Checking if the user has validated the exercise before
    validate_exercise(sender_address);
    // Sending points to the address specified as parameter
    distribute_points(sender_address, 2);
    return ();
}
