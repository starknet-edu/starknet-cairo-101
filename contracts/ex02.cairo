######### Ex 02
## Asserts




%lang starknet
%builtins pedersen range_check

from contracts.token.ITDERC20 import ITDERC20
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import (
    Uint256, uint256_add, uint256_sub, uint256_le, uint256_lt, uint256_check
)
from starkware.cairo.common.math import assert_not_zero
from contracts.utils.IAccountContract import IAccountContract


#
# Declaring storage vars
# Storage vars are by default not visible through the ABI. They are similar to "private" variables in Solidity
#

@storage_var
func tderc20_address_storage() -> (tderc20_address_storage : felt):
end

@storage_var
func has_validated_exercice(account: felt) -> (has_validated_exercice: felt):
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

#
# Constructor
#
@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        _tderc20_address : felt):
    tderc20_address_storage.write(_tderc20_address)
    return ()
end

#
# External functions
# Calling this function will simply credit 2 points to the address specified in parameter
#

@external
func claim_points{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(sender_address: felt, my_value: felt):
	# Checking that the value sent is correct
	# Using assert this way is similar to using "require" in Solidity
	assert my_value = 180618
	# Checking if the user has validated the exercice before
	validate_exercice(sender_address)
	# Sending points to the address specified as parameter
	distribute_points(sender_address, 2)
    return ()
end

#
# Internal functions
# These functions can not be called directly by a transaction
# Similar to internal functions in Solidity
#

func distribute_points{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(to: felt, amount: felt):
	
	# Converting felt to uint256. We assume it's a small number 
	let points_to_credit: Uint256 = Uint256(0,amount)

	# Calling the ERC20 contract to distribute points
	ITDERC20.distribute_points(contract_address=tderc20_address, to = to, amount = points_to_credit)
	return()
end


func validate_exercice{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(to: felt):
	# Checking if the user has deployed an account contract
	let (account_contract_signer) = IAccountContract.get_signer(contract_address=to)
	assert_not_zero(account_contract_signer)

	# Checking if the user already validater this exercice
	let (has_current_user_validated_exercice) = has_validated_exercice.read(to)
	assert (has_current_user_validated_exercice) = 0

	# Marking the exercice as completed
	has_validated_exercice.write(to, 1)

	return()
end










