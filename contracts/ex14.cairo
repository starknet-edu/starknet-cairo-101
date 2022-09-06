// ######## Ex 13
// All in one exercise
// It's your time to shine.
// Deploy a contract that validates various exercises in a single transaction to get 2 points
// Do you want to agregate your points in a single account? Use this https://github.com/starknet-edu/points-migrator

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.uint256 import Uint256, uint256_sub, uint256_le, uint256_lt
from contracts.token.IERC20 import IERC20
from contracts.utils.ex00_base import (
    tderc20_address,
    distribute_points,
    validate_exercise,
    ex_initializer,
)

@contract_interface
namespace IAllInOneContract {
    func validate_various_exercises() {
    }
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
    alloc_locals;
    // Reading caller address
    let (sender_address) = get_caller_address();
    // Retrieving ERC20 address
    let (erc20_address) = tderc20_address();
    // Reading contract balance before calling
    let (balance_pre_call) = IERC20.balanceOf(
        contract_address=erc20_address, account=sender_address
    );

    // Calling caller's validate_various_exercises() function
    IAllInOneContract.validate_various_exercises(contract_address=sender_address);

    // Reading contract balance before calling
    let (balance_post_call) = IERC20.balanceOf(
        contract_address=erc20_address, account=sender_address
    );
    // Verifying that caller collected some points
    let (has_caller_collected_points) = uint256_lt(balance_pre_call, balance_post_call);
    with_attr error_message("You did not collect any points") {
        assert has_caller_collected_points = 1;
    }
    // Read how many points were collected
    let collected_points: Uint256 = uint256_sub(balance_post_call, balance_pre_call);
    // Check that at least 20 points were collected
    let points_objective: Uint256 = Uint256(20, 0);
    let (has_caller_collected_enough_points) = uint256_le(points_objective, collected_points);

    with_attr error_message("You did not collect enough points") {
        assert has_caller_collected_enough_points = 1;
    }

    // Checking if the user has validated the exercise before
    validate_exercise(sender_address);
    // Sending points to the address specified as parameter
    distribute_points(sender_address, 2);
    return ();
}
