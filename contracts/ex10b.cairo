// ######## Ex 10b
// # Composability
// This exercise was deployed as a complement to ex10, but you don't know where!
// Use ex10 to find its address, then voyager to read from ex10b
// Then use ex10 to claim points

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_not_zero, assert_le
from starkware.starknet.common.syscalls import get_contract_address, get_caller_address
from contracts.utils.Iex10 import Iex10

//
// Declaring storage vars
// Storage vars are by default not visible through the ABI. They are similar to "private" variables in Solidity
//

@storage_var
func ex10_address_storage() -> (ex10_address_storage: felt) {
}

@storage_var
func secret_value_storage() -> (secret_value_storage: felt) {
}

//
// View functions
//
@view
func ex10_address{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    ex10_address: felt
) {
    let (ex10_address) = ex10_address_storage.read();
    return (ex10_address,);
}

@view
func secret_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    secret_value: felt
) {
    let (secret_value) = secret_value_storage.read();
    return (secret_value,);
}

//
// Constructor
//
@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    ex10_address: felt
) {
    ex10_address_storage.write(ex10_address);
    let (current_contract_address) = get_contract_address();
    Iex10.set_ex_10b_address(
        contract_address=ex10_address, ex_10b_address_=current_contract_address
    );
    return ();
}

//
// External functions
// Calling this function will simply credit 2 points to the address specified in parameter
//

@external
func change_secret_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    new_secret_value: felt
) {
    // Only ex10 can call this function
    only_ex10();
    // Changing secret value
    secret_value_storage.write(new_secret_value);
    return ();
}

//
// Internal functions
//
//
func only_ex10{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    let (caller) = get_caller_address();
    let (ex10_address) = ex10_address_storage.read();
    with_attr error_message("Only ex10 contract can call this function") {
        assert ex10_address = caller;
    }
    return ();
}
