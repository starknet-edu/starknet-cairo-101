use starknet::ContractAddress;

//###################
// IERC20 INTERFACE
//###################

#[abi]
trait IERC20 {
    fn name() -> felt252;
    fn symbol() -> felt252;
    fn decimals() -> u8;
    fn totalSupply() -> u256;
    fn balanceOf(account: ContractAddress) -> u256;
    fn allowance(owner: ContractAddress, spender: ContractAddress) -> u256;
    fn transfer(recipient: ContractAddress, amount: u256);
    fn transferFrom(sender: ContractAddress, recipient: ContractAddress, amount: u256);
    fn approve(spender: ContractAddress, amount: u256);
}
