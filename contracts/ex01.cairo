// Ex 01
//  Using a simple public contract function
// In this exercise, you need to:
// - Use this contract's claim_points() function
// - Your points are credited by the contract

// What you'll learn
// - General smart contract syntax
// - Calling a function

// General directives and imports
//
//

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

from contracts.utils.ex00_base import (
    tderc20_address,
    has_validated_exercise,
    distribute_points,
    validate_exercise,
    ex_initializer,
)

// Constructor
// This function is called when the contract is deployed
//
@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    _tderc20_address: felt, _players_registry: felt, _workshop_id: felt, _exercise_id: felt
) {
    ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    return ();
}

// External functions
// These functions are callable by other contracts
//

// This function is called claim_points
// It takes implicit arguments (syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr). Read more about implicit arguments here https://www.cairo-lang.org/docs/how_cairo_works/builtins.html
// It defines the expression sender_address as a felt. Read more about felts here https://www.cairo-lang.org/docs/hello_cairo/intro.html#field-element
@external
func claim_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // Reading caller address
    let (sender_address) = get_caller_address();
    // Checking if the user has validated the exercise before
    validate_exercise(sender_address);
    // Sending points to the address specified as parameter
    distribute_points(sender_address, 2);
    return ();
}
