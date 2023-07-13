use starknet::ContractAddress;

//###################
// ITDERC20 INTERFACE
//###################

#[starknet::interface]
trait ITDERC20<TContractState> {
    fn distribute_points(ref self: TContractState, to: ContractAddress, amount: u128);
    fn remove_points(ref self: TContractState, to: ContractAddress, amount: u128);
    fn set_teacher(ref self: TContractState, account: ContractAddress, permission: bool);
    fn transfer(ref self: TContractState, recipient: ContractAddress, amount: u256) -> bool;
    fn transferFrom(
        ref self: TContractState, sender: ContractAddress, recipient: ContractAddress, amount: u256
    ) -> bool;
    fn approve(ref self: TContractState, spender: ContractAddress, amount: u256) -> bool;
    fn increaseAllowance(
        ref self: TContractState, spender: ContractAddress, added_value: u256
    ) -> bool;
    fn decreaseAllowance(
        ref self: TContractState, spender: ContractAddress, subtracted_value: u256
    ) -> bool;
    fn set_teachers(
        ref self: TContractState, accounts: Array::<ContractAddress>, permissions: Array::<bool>
    );
    fn set_transferable(ref self: TContractState, permission: bool);
    fn update_class_hash_by_admin(ref self: TContractState, class_hash_in_felt: felt252);

    fn is_teacher_or_exercise(self: @TContractState, account: ContractAddress) -> bool;
    fn is_transferable(self: @TContractState) -> bool;
    fn name(self: @TContractState) -> felt252;
    fn symbol(self: @TContractState) -> felt252;
    fn decimals(self: @TContractState) -> u8;
    fn totalSupply(self: @TContractState) -> u256;
    fn balanceOf(self: @TContractState, account: ContractAddress) -> u256;
    fn allowance(self: @TContractState, owner: ContractAddress, spender: ContractAddress) -> u256;
}
