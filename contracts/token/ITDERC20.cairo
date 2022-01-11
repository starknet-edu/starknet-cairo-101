%lang starknet
from starkware.cairo.common.uint256 import (
    Uint256, uint256_add, uint256_sub, uint256_le, uint256_lt, uint256_check
)
@contract_interface
namespace ITDERC20:
    func distribute_points(to: felt, amount: Uint256):
    end
    func remove_points(to: felt, amount: Uint256):
    end
    func set_teacher(account: felt, permission: felt):
    end
    func isTeacher(account: felt) -> (permission: felt):
    end
    func set_teachers_temp(accounts_len: felt, accounts: felt*):
    end
    func set_teacher_temp(account: felt):
    end
    # func transfer(recipient: felt, amount: Uint256) -> (success: felt):
    # end
    # func transferFrom(
    #         sender: felt, 
    #         recipient: felt, 
    #         amount: Uint256
    #     ) -> (success: felt):
    # end
    # func approve(spender: felt, amount: Uint256) -> (success: felt):
    # end
end
# @external
# func increaseAllowance{
#         syscall_ptr : felt*, 
#         pedersen_ptr : HashBuiltin*,
#         range_check_ptr
#     }(spender: felt, added_value: Uint256) -> (success: felt):
#     alloc_locals
#     uint256_check(added_value)
#     let (local caller) = get_caller_address()
#     let (local current_allowance: Uint256) = ERC20_allowances.read(caller, spender)

#     # add allowance
#     let (local new_allowance: Uint256, is_overflow) = uint256_add(current_allowance, added_value)
#     assert (is_overflow) = 0

#     ERC20_approve(caller, spender, new_allowance)

#     # Cairo equivalent to 'return (true)'
#     return (1)
# end

# @external
# func decreaseAllowance{
#         syscall_ptr : felt*, 
#         pedersen_ptr : HashBuiltin*,
#         range_check_ptr
#     }(spender: felt, subtracted_value: Uint256) -> (success: felt):
#     alloc_locals
#     uint256_check(subtracted_value)
#     let (local caller) = get_caller_address()
#     let (local current_allowance: Uint256) = ERC20_allowances.read(owner=caller, spender=spender)
#     let (local new_allowance: Uint256) = uint256_sub(current_allowance, subtracted_value)

#     # validates new_allowance < current_allowance and returns 1 if true   
#     let (enough_allowance) = uint256_lt(new_allowance, current_allowance)
#     assert_not_zero(enough_allowance)

#     ERC20_approve(caller, spender, new_allowance)

#     # Cairo equivalent to 'return (true)'
#     return (1)
# end

# func only_teacher_or_exercice{
#         syscall_ptr : felt*, 
#         pedersen_ptr : HashBuiltin*,
#         range_check_ptr
#     }():
#     let (caller) = get_caller_address()
#     let (permission) = Teacher_accounts.read(account=caller)
#     assert permission = 1
#     return ()
# end


# @external
# func distribute_points{
#         syscall_ptr: felt*,
#         pedersen_ptr: HashBuiltin*,
#         range_check_ptr
#     }(to: felt, amount: Uint256):
#     only_teacher_or_exercice()
#     ERC20_mint(to, amount)
#     return ()
# end

# @external
# func set_teacher{
#         syscall_ptr: felt*,
#         pedersen_ptr: HashBuiltin*,
#         range_check_ptr
#     }(account: felt, permission: felt):
#     only_teacher_or_exercice()
#     Teacher_accounts.write(account, permission)

#     return ()
# end

# @view
# func isTeacher{
#         syscall_ptr : felt*, 
#         pedersen_ptr : HashBuiltin*,
#         range_check_ptr
#     }(account: felt) -> (permission: felt):
#     let (permission: felt) = Teacher_accounts.read(account)
#     return (permission)
# end