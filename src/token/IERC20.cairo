//###################
// INTERFACE
//###################

#[abi]
trait IERC20 {
    fn name() -> felt;
    fn symbol() -> felt;
    fn decimals() -> felt;
    fn totalSupply() -> u256;
    fn balanceOf(account: ContractAddress) -> u256;
    fn allowance(owner: ContractAddress, spender: ContractAddress) -> u256;
    fn transfer(recipient: ContractAddress, amount: u256);
    fn transferFrom(sender: ContractAddress, recipient: ContractAddress, amount: u256);
    fn approve(spender: ContractAddress, amount: u256);
}
