use starknet::ContractAddress;
//###################
// ITDERC20 INTERFACE
//###################
#[starknet::interface]
trait ITDERC20 <TContractState>{
    fn distribute_points(ref self:TContractState, to: ContractAddress, amount: u128);
    fn remove_points(ref self:TContractState , to: ContractAddress, amount: u128);
    fn set_teacher(ref self: TContractState, account: ContractAddress, permission: bool);
    fn is_teacher_or_exercise(self:@TContractState, account: ContractAddress) -> bool;
}
