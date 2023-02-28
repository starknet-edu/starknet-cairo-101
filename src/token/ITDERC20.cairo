//###################
// INTERFACE
//###################
#[abi]
trait ITDERC20 {
    fn distribute_points(to: felt, amount: u256);
    fn remove_points(to: felt, amount: u256);
    fn set_teacher(account: felt, permission: felt);
    fn is_teacher_or_exercise(account: felt) -> felt;
    fn set_teachers_temp(accounts_len: u8, accounts: Array::<felt>);
    fn set_teacher_temp(account: felt);
}