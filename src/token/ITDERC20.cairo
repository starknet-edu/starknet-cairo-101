use starknet::ContractAddress;
//###################
// INTERFACE
//###################
#[abi]
trait ITDERC20 {
    fn distribute_points(to: ContractAddress, amount: u256);
    fn remove_points(to: ContractAddress, amount: u256);
    fn set_teacher(account: ContractAddress, permission: bool);
    fn is_teacher_or_exercise(account: ContractAddress) -> bool;

}
