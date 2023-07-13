use starknet::ContractAddress;

//###################
// IERC20BASE INTERFACE
//###################

#[starknet::interface]
trait IERC20BASE<TContractState> {
    fn ERC20_name(self: @TContractState) -> felt252;
    fn ERC20_symbol(self: @TContractState) -> felt252;
    fn ERC20_decimals(self: @TContractState) -> u8;
    fn ERC20_totalSupply(self: @TContractState) -> u256;
    fn ERC20_balanceOf(self: @TContractState, account: ContractAddress) -> u256;
    fn ERC20_allowance(
        self: @TContractState, owner: ContractAddress, spender: ContractAddress
    ) -> u256;
    fn ERC20_initializer(
        ref self: TContractState,
        name_: felt252,
        symbol_: felt252,
        decimals_: u8,
        initial_supply: u256,
        recipient: ContractAddress
    );
    fn ERC20_transfer(ref self: TContractState, recipient: ContractAddress, amount: u256);
    fn ERC20_transferFrom(
        ref self: TContractState, sender: ContractAddress, recipient: ContractAddress, amount: u256
    );
    fn ERC20_approve(ref self: TContractState, spender: ContractAddress, amount: u256);
    fn ERC20_increaseAllowance(
        ref self: TContractState, spender: ContractAddress, added_value: u256
    );
    fn ERC20_decreaseAllowance(
        ref self: TContractState, spender: ContractAddress, subtracted_value: u256
    );
    fn ERC20_mint(ref self: TContractState, recipient: ContractAddress, amount: u256);
    fn ERC20_burn(ref self: TContractState, account: ContractAddress, amount: u256);
}
