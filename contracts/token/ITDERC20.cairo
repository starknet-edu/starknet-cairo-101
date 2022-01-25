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
    func is_teacher_or_exercise(account: felt) -> (permission: felt):
    end
    func set_teachers_temp(accounts_len: felt, accounts: felt*):
    end
    func set_teacher_temp(account: felt):
    end
end
