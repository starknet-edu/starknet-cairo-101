use starknet::ContractAddress;
//###################
// ITDERC20 INTERFACE
//###################
#[starknet::interface]
trait ITDERC20<T> {
    fn distribute_points(self: @T, to: ContractAddress, amount: u128);
    fn remove_points(self: @T, to: ContractAddress, amount: u128);
    fn set_teacher(self: @T, account: ContractAddress, permission: bool);
    fn is_teacher_or_exercise(self: @T, account: ContractAddress) -> bool;

}
