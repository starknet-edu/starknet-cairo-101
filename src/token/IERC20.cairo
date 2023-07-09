use starknet::ContractAddress;

//###################
// IERC20 INTERFACE
//###################

#[starknet::interface]
trait IERC20<TContractState> {
    fn name(self: @TContractState) -> felt252;
    fn symbol(self: @TContractState) -> felt252;
    fn decimals(self: @TContractState) -> u8;
    fn totalSupply(self: @TContractState) -> u256;
    fn balanceOf(self: @TContractState, account: ContractAddress) -> u256;
    fn allowance(self: @TContractState, owner: ContractAddress, spender: ContractAddress) -> u256;
    fn transfer(self: @TContractState, recipient: ContractAddress, amount: u256);
    fn transferFrom(self: @TContractState, sender: ContractAddress, recipient: ContractAddress, amount: u256);
    fn approve(self: @TContractState, spender: ContractAddress, amount: u256);
}
