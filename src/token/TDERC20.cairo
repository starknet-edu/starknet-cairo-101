%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256
from starkware.starknet.common.syscalls import get_caller_address

from contracts.token.ERC20_base import (
    ERC20_name,
    ERC20_symbol,
    ERC20_totalSupply,
    ERC20_decimals,
    ERC20_balanceOf,
    ERC20_allowance,
    ERC20_mint,
    ERC20_burn,
    ERC20_initializer,
    ERC20_approve,
    ERC20_increaseAllowance,
    ERC20_decreaseAllowance,
    ERC20_transfer,
    ERC20_transferFrom,
)

@storage_var
func teachers_and_exercises_accounts(account: felt) -> (balance: felt) {
}

@storage_var
func is_transferable_storage() -> (is_transferable_storage: felt) {
}

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    name: felt, symbol: felt, initial_supply: Uint256, recipient: felt, owner: felt
) {
    ERC20_initializer(name, symbol, initial_supply, recipient);
    teachers_and_exercises_accounts.write(owner, 1);
    return ();
}

//
// Getters
//

@view
func is_transferable{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    is_transferable: felt
) {
    let (is_transferable) = is_transferable_storage.read();
    return (is_transferable,);
}

@view
func name{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (name: felt) {
    let (name) = ERC20_name();
    return (name,);
}

@view
func symbol{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (symbol: felt) {
    let (symbol) = ERC20_symbol();
    return (symbol,);
}

@view
func totalSupply{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    totalSupply: Uint256
) {
    let (totalSupply: Uint256) = ERC20_totalSupply();
    return (totalSupply,);
}

@view
func decimals{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    decimals: felt
) {
    let (decimals) = ERC20_decimals();
    return (decimals,);
}

@view
func balanceOf{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(account: felt) -> (
    balance: Uint256
) {
    let (balance: Uint256) = ERC20_balanceOf(account);
    return (balance,);
}

@view
func allowance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    owner: felt, spender: felt
) -> (remaining: Uint256) {
    let (remaining: Uint256) = ERC20_allowance(owner, spender);
    return (remaining,);
}

//
// Externals
//

@external
func transfer{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    recipient: felt, amount: Uint256
) -> (success: felt) {
    _is_transferable();
    ERC20_transfer(recipient, amount);
    // Cairo equivalent to 'return (true)'
    return (1,);
}

@external
func transferFrom{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    sender: felt, recipient: felt, amount: Uint256
) -> (success: felt) {
    _is_transferable();
    ERC20_transferFrom(sender, recipient, amount);
    // Cairo equivalent to 'return (true)'
    return (1,);
}

@external
func approve{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    spender: felt, amount: Uint256
) -> (success: felt) {
    ERC20_approve(spender, amount);
    // Cairo equivalent to 'return (true)'
    return (1,);
}

@external
func increaseAllowance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    spender: felt, added_value: Uint256
) -> (success: felt) {
    ERC20_increaseAllowance(spender, added_value);
    // Cairo equivalent to 'return (true)'
    return (1,);
}

@external
func decreaseAllowance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    spender: felt, subtracted_value: Uint256
) -> (success: felt) {
    ERC20_decreaseAllowance(spender, subtracted_value);
    // Cairo equivalent to 'return (true)'
    return (1,);
}

@external
func distribute_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    to: felt, amount: Uint256
) {
    only_teacher_or_exercise();
    ERC20_mint(to, amount);
    return ();
}

@external
func remove_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    to: felt, amount: Uint256
) {
    only_teacher_or_exercise();
    ERC20_burn(to, amount);
    return ();
}

@external
func set_teacher{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    account: felt, permission: felt
) {
    only_teacher_or_exercise();
    teachers_and_exercises_accounts.write(account, permission);

    return ();
}

@external
func set_teachers{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    accounts_len: felt, accounts: felt*
) {
    only_teacher_or_exercise();
    _set_teacher(accounts_len, accounts);
    return ();
}

@external
func set_transferable{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    permission: felt
) {
    only_teacher_or_exercise();
    _set_transferable(permission);
    return ();
}

@view
func is_teacher_or_exercise{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    account: felt
) -> (permission: felt) {
    let (permission: felt) = teachers_and_exercises_accounts.read(account);
    return (permission,);
}

func _set_teacher{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    accounts_len: felt, accounts: felt*
) {
    if (accounts_len == 0) {
        // Start with sum=0.
        return ();
    }

    // If length is NOT zero, then the function calls itself again, by moving forward one slot
    _set_teacher(accounts_len=accounts_len - 1, accounts=accounts + 1);

    // This part of the function is first reached when length=0.
    teachers_and_exercises_accounts.write([accounts], 1);
    return ();
}

func only_teacher_or_exercise{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    let (caller) = get_caller_address();
    let (permission) = teachers_and_exercises_accounts.read(account=caller);
    assert permission = 1;
    return ();
}

func _is_transferable{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    let (permission) = is_transferable_storage.read();
    assert permission = 1;
    return ();
}

func _set_transferable{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    permission: felt
) {
    is_transferable_storage.write(permission);
    return ();
}
