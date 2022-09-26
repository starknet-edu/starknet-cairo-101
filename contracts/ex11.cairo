// ######## Ex 11
// # Importing functions
// In this exercise, you need to:
// - Read this contract and understand how it imports functions from another contract
// - Find the relevant contract it imports from
// - Read the code and understand what is expected of you

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_not_zero, assert_le
from starkware.starknet.common.syscalls import get_caller_address

// This contract imports functions from another file than other exercises, be careful
from contracts.utils.ex11_base import (
    tderc20_address,
    has_validated_exercise,
    distribute_points,
    validate_exercise,
    ex_initializer,
    validate_answers,
    ex11_secret_value,
    secret_value
)

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
func claim_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    secret_value_i_guess: felt, next_secret_value_i_chose: felt
) {
    alloc_locals;
    // Reading caller address and setting it into a local to avoid revoked references
    let (local sender_address) = get_caller_address();
    // Check if your answer is correct
    validate_answers(sender_address, secret_value_i_guess, next_secret_value_i_chose);
    // Checking if the user has validated the exercise before
    validate_exercise(sender_address);
    // Sending points to the address specified as parameter
    distribute_points(sender_address, 2);
    return ();
}
