//###################
// INTERFACE
//###################
#[abi]
trait ITDERC20 {
    fn distribute_points(to: ContractAddress, amount: u256) {
    }
    fn remove_points(to: ContractAddress, amount: u256) {
    }
    fn set_teacher(account: ContractAddress, permission: felt) {
    }
    fn is_teacher_or_exercise(account: ContractAddress) -> (permission: felt) {
    }
    fn set_teachers_temp(accounts_len: u8, accounts: Array::<ContractAddress>) {
    }
    fn set_teacher_temp(account: ContractAddress) {
    } 
}