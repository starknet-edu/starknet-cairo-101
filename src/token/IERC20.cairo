use starknet::ContractAddress;

//###################
// IERC20 INTERFACE
//###################

#[starknet::interface]
trait IERC20<T> {
    fn name(self: @T) -> felt252;
    fn symbol(self: @T) -> felt252;
    fn decimals(self: @T) -> u8;
    fn totalSupply(self: @T) -> u256;
    fn balanceOf(self: @T, account: ContractAddress) -> u256;
    fn allowance(self: @T, owner: ContractAddress, spender: ContractAddress) -> u256;
    fn transfer(self: @T, recipient: ContractAddress, amount: u256);
    fn transferFrom(self: @T, sender: ContractAddress, recipient: ContractAddress, amount: u256);
    fn approve(self: @T, spender: ContractAddress, amount: u256);
}
