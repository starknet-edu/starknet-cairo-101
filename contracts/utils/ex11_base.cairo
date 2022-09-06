// ######## Ex 00
// # A contract from which other contracts can import functions

%lang starknet

from contracts.token.ITDERC20 import ITDERC20
from contracts.utils.Iplayers_registry import Iplayers_registry
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import (
    Uint256,
    uint256_add,
    uint256_sub,
    uint256_le,
    uint256_lt,
    uint256_check,
)
from starkware.cairo.common.math import assert_not_zero
from starkware.starknet.common.syscalls import get_contract_address

//
// Declaring storage vars
// Storage vars are by default not visible through the ABI. They are similar to "private" variables in Solidity
//

@storage_var
func tderc20_address_storage() -> (tderc20_address_storage: felt) {
}

@storage_var
func players_registry_storage() -> (tderc20_address_storage: felt) {
}

@storage_var
func workshop_id_storage() -> (workshop_id_storage: felt) {
}

@storage_var
func exercise_id_storage() -> (exercise_id_storage: felt) {
}
//
@storage_var
func ex11_secret_value() -> (secret_value: felt) {
}

//
// Declaring getters
// Public variables should be declared explicitly with a getter
//

@view
func tderc20_address{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    _tderc20_address: felt
) {
    let (_tderc20_address) = tderc20_address_storage.read();
    return (_tderc20_address,);
}

@view
func players_registry{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    _players_registry: felt
) {
    let (_players_registry) = players_registry_storage.read();
    return (_players_registry,);
}

@view
func workshop_id{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    _workshop_id: felt
) {
    let (_workshop_id) = workshop_id_storage.read();
    return (_workshop_id,);
}

@view
func exercise_id{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    _exercise_id: felt
) {
    let (_exercise_id) = exercise_id_storage.read();
    return (_exercise_id,);
}

@view
func has_validated_exercise{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    account: felt
) -> (has_validated_exercise: felt) {
    // reading player registry
    let (_players_registry) = players_registry_storage.read();
    let (_workshop_id) = workshop_id_storage.read();
    let (_exercise_id) = exercise_id_storage.read();
    // Checking if the user already validated this exercise
    let (has_current_user_validated_exercise) = Iplayers_registry.has_validated_exercise(
        contract_address=_players_registry,
        account=account,
        workshop=_workshop_id,
        exercise=_exercise_id,
    );
    return (has_current_user_validated_exercise,);
}

@view
func secret_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    secret_value: felt
) {
    let (secret_value) = ex11_secret_value.read();
    // There is a trick here
    return (secret_value + 42069,);
}

//
// Internal constructor
// This function is used to initialize the contract. It can be called from the constructor
//

func ex_initializer{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    _tderc20_address: felt, _players_registry: felt, _workshop_id: felt, _exercise_id: felt
) {
    tderc20_address_storage.write(_tderc20_address);
    players_registry_storage.write(_players_registry);
    workshop_id_storage.write(_workshop_id);
    exercise_id_storage.write(_exercise_id);
    ex11_secret_value.write(_tderc20_address);
    return ();
}

//
// Internal functions
// These functions can not be called directly by a transaction
// Similar to internal functions in Solidity
//

func distribute_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    to: felt, amount: felt
) {
    // Converting felt to uint256. We assume it's a small number
    // We also add the required number of decimals
    let points_to_credit: Uint256 = Uint256(amount * 1000000000000000000, 0);
    // Retrieving contract address from storage
    let (contract_address) = tderc20_address_storage.read();
    // Calling the ERC20 contract to distribute points
    ITDERC20.distribute_points(contract_address=contract_address, to=to, amount=points_to_credit);
    return ();
}

func validate_exercise{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    account: felt
) {
    // reading player registry
    let (_players_registry) = players_registry_storage.read();
    let (_workshop_id) = workshop_id_storage.read();
    let (_exercise_id) = exercise_id_storage.read();
    // Checking if the user already validated this exercise
    let (has_current_user_validated_exercise) = Iplayers_registry.has_validated_exercise(
        contract_address=_players_registry,
        account=account,
        workshop=_workshop_id,
        exercise=_exercise_id,
    );
    assert (has_current_user_validated_exercise) = 0;

    // Marking the exercise as completed
    Iplayers_registry.validate_exercise(
        contract_address=_players_registry,
        account=account,
        workshop=_workshop_id,
        exercise=_exercise_id,
    );

    return ();
}

func validate_answers{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    sender_address: felt, secret_value_i_guess: felt, next_secret_value_i_chose: felt
) {
    // CAREFUL THERE IS A TRAP FOR PEOPLE WHO WON'T READ THE CODE
    // This exercise looks like the previous one, but actually the view secret_value returns a different value than secret_value
    // Sending the wrong execution result will remove some of your points, then validate the exercise. You won't be able to get those points back later on!
    alloc_locals;
    let (secret_value) = ex11_secret_value.read();
    local diff = secret_value_i_guess - secret_value;
    // Laying our trap here
    if (diff == 42069) {
        // Converting felt to uint256. We assume it's a small number
        // We also add the required number of decimals
        let points_to_remove: Uint256 = Uint256(2 * 1000000000000000000, 0);
        // # Retrieving contract address from storage
        let (contract_address) = tderc20_address_storage.read();
        // # Calling the ERC20 contract to distribute points
        ITDERC20.remove_points(
            contract_address=contract_address, to=sender_address, amount=points_to_remove
        );
        // This is necessary because of revoked references. Don't be scared, they won't stay around for too long...
        return ();
    } else {
        // If secret value is correct, set new secret value
        if (diff == 0) {
            with_attr error_message("Chosen value can't be 0") {
                assert_not_zero(next_secret_value_i_chose);
            }
            ex11_secret_value.write(next_secret_value_i_chose);
            // This is necessary because of revoked references. Don't be scared, they won't stay around for too long...
            return ();
        } else {
            assert 1 = 0;
            return ();
        }
    }
}
