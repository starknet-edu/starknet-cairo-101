// ######## Ex 07
// # Understanding functions to compare values
// In this exercise, you need to:
// - Use this contract's claim_points() function
// - Your points are credited by the contract

// ######## References
// Documentation is still being written. You can find answers in this file
// https://github.com/starkware-libs/cairo-lang/blob/master/src/starkware/cairo/common/math.cairo

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.math import (
    assert_not_zero,
    assert_not_equal,
    assert_nn,
    assert_le,
    assert_lt,
    assert_in_range,
)

from contracts.utils.ex00_base import (
    tderc20_address,
    has_validated_exercise,
    distribute_points,
    validate_exercise,
    ex_initializer,
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
    value_a: felt, value_b: felt
) {
    // Reading caller address
    let (sender_address) = get_caller_address();
    // Checking that the passed values are correct
    with_attr error_message("value_a shouldn't be 0") {
        assert_not_zero(value_a);
    }

    with_attr error_message("value_b shouldn't be negative") {
        assert_nn(value_b);
    }

    with_attr error_message("value_a and value_b should be different") {
        assert_not_equal(value_a, value_b);
    }

    with_attr error_message("value_a should be <= 75") {
        assert_le(value_a, 75);
    }

    with_attr error_message("value_a should be between 40 and 69") {
        assert_in_range(value_a, 40, 70);
    }

    with_attr error_message("value_b should be < 1") {
        assert_lt(value_b, 1);
    }
    // Checking if the user has validated the exercise before
    validate_exercise(sender_address);
    // Sending points to the address specified as parameter
    distribute_points(sender_address, 2);
    return ();
}
