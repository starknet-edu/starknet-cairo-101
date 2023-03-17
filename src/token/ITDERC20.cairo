use starknet::contract_address::ContractAddressSerde;
//###################
// INTERFACE
//###################
#[abi]
trait ITDERC20 {
    fn distribute_points(to: ContractAddress, amount: u256);
    fn remove_points(to: ContractAddress, amount: u256);
    fn set_teacher(account: ContractAddress, permission: bool);
    fn is_teacher_or_exercise(account: ContractAddress) -> bool;
    
    // These functions are not in the TDERC20 contract
    // fn set_teachers_temp(accounts: Array::<ContractAddress>);
    // fn set_teacher_temp(account: ContractAddress);
}
