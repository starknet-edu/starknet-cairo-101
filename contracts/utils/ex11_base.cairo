



######### Ex 00
## A contract from which other contracts can import functions

%lang starknet

from contracts.token.ITDERC20 import ITDERC20
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import (
    Uint256, uint256_add, uint256_sub, uint256_le, uint256_lt, uint256_check
)
from starkware.cairo.common.math import assert_not_zero
from contracts.utils.IAccountContract import IAccountContract
from starkware.starknet.common.syscalls import (get_contract_address)

#
# Declaring storage vars
# Storage vars are by default not visible through the ABI. They are similar to "private" variables in Solidity
#

@storage_var
func tderc20_address_storage() -> (tderc20_address_storage : felt):
end

@storage_var
func has_validated_exercice_storage(account: felt) -> (has_validated_exercice_storage: felt):
end

@storage_var
func ex11_secret_value() -> (secret_value: felt):
end

#
# Declaring getters
# Public variables should be declared explicitely with a getter
#

@view
func tderc20_address{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (_tderc20_address: felt):
    let (_tderc20_address) = tderc20_address_storage.read()
    return (_tderc20_address)
end

@view
func has_validated_exercice{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(account: felt) -> (has_validated_exercice: felt):
    let (has_validated_exercice) = has_validated_exercice_storage.read(account)
    return (has_validated_exercice)
end

@view
func secret_value{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (secret_value: felt):
    let (secret_value) = ex11_secret_value.read()
    # There is a trick here
    return (secret_value + 42069)
end


#
# Internal constructor
# This function is used to initialize the contract. It can be called from the constructor
#

func ex_initializer{
        syscall_ptr : felt*, 
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(
        _tderc20_address: felt
    ):
    tderc20_address_storage.write(_tderc20_address)
    ex11_secret_value.write(_tderc20_address)
    let (current_contract_address) = get_contract_address()
    ITDERC20.set_teacher_temp(contract_address=_tderc20_address, account=current_contract_address)
    return ()
end

#
# Internal functions
# These functions can not be called directly by a transaction
# Similar to internal functions in Solidity
#

func distribute_points{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(to: felt, amount: felt):
    
    # Converting felt to uint256. We assume it's a small number 
    # We also add the required number of decimals
    let points_to_credit: Uint256 = Uint256(amount*1000000000000000000, 0)
    # Retrieving contract address from storage
    let (contract_address) = tderc20_address_storage.read()
    # Calling the ERC20 contract to distribute points
    ITDERC20.distribute_points(contract_address=contract_address, to = to, amount = points_to_credit)
    return()
end


func validate_exercice{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(to: felt):
    # Checking if the user has deployed an account contract
    let (account_contract_signer) = IAccountContract.get_signer(contract_address=to)
    # Veryfing that the account contract has a valid signer
    assert_not_zero(account_contract_signer)

    # Checking if the user already validater this exercice
    let (has_current_user_validated_exercice) = has_validated_exercice_storage.read(to)
    assert (has_current_user_validated_exercice) = 0

    # Marking the exercice as completed
    has_validated_exercice_storage.write(to, 1)

    return()
end

func validate_answers{
        syscall_ptr : felt*, 
        pedersen_ptr : HashBuiltin*,
        range_check_ptr
    }(sender_address: felt, secret_value_i_guess: felt, next_secret_value_i_chose: felt):
    # CAREFUL THERE IS A TRAP FOR PEOPLE WHO WON'T READ THE CODE
    # This exercice looks like the previous one, but actually the view secret_value returns a different value than secret_value
    # Sending the wrong execution result will remove some of your points, then validate the exercice. You won't be able to get those points back later on!
    alloc_locals
    let (secret_value) = ex11_secret_value.read()
    local diff = secret_value_i_guess - secret_value 
    # Laying our trap here
    if diff == 42069:
        # Converting felt to uint256. We assume it's a small number 
        # We also add the required number of decimals
        let points_to_remove: Uint256 = Uint256(2*1000000000000000000, 0)
        # # Retrieving contract address from storage
        let (contract_address) = tderc20_address_storage.read()
        # # Calling the ERC20 contract to distribute points
        ITDERC20.remove_points(contract_address=contract_address, to = sender_address, amount = points_to_remove)
        # This is necessary because of revoked references. Don't be scared, they won't stay around for too long...
        tempvar syscall_ptr = syscall_ptr
        tempvar pedersen_ptr = pedersen_ptr
        tempvar range_check_ptr = range_check_ptr
    else:
        # If secret value is correct, do nothing and move on
        if diff == 0:
        # If secret value is incorrect, we revert
        else:
            assert 1 = 0
        end
        # This is necessary because of revoked references. Don't be scared, they won't stay around for too long...
        tempvar syscall_ptr = syscall_ptr
        tempvar pedersen_ptr = pedersen_ptr
        tempvar range_check_ptr = range_check_ptr
    end

    return ()
end

