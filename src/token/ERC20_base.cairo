////////////////////////////////
// ERC20Base
// A Base ERC20 contract to implement ERC20 standarded methods
// such as `transfer`, `transfer_from`, `mint`, 'burn', 'approve' etc.
////////////////////////////////

#[contract]
mod ERC20Base {
    // Core library Imports
    use starknet::get_caller_address;
    use zeroable::Zeroable;
    use starknet::contract_address_const;
    use starknet::ContractAddress;
    use starknet::ContractAddressZeroable;
    use traits::Into;
    use traits::TryInto;
    use array::ArrayTrait;
    use option::OptionTrait;
    use integer::u256_from_felt252;

    //
    // Declaring storage vars
    // Storage vars are by default not visible through the ABI. They are similar to "private" variables in Solidity
    //
    // This variable is a felt and is called my_secret_value_storage. It is stored in the contract's Storage struct
    // From within a smart contract, it can be read with my_secret_value_storage::read() or written to with my_secret_value_storage::write()

    struct Storage {
        name: felt252,
        symbol: felt252,
        decimals: u8,
        total_supply: u256,
        balances: LegacyMap::<ContractAddress, u256>,
        allowances: LegacyMap::<(ContractAddress, ContractAddress), u256>,
    }

    fn ERC20_name() -> felt252 {
        name::read()
    }

    fn ERC20_symbol() -> felt252 {
        symbol::read()
    }

    fn ERC20_decimals() -> u8 {
        decimals::read()
    }

    fn ERC20_totalSupply() -> u256 {
        total_supply::read()
    }

    fn ERC20_balanceOf(account: ContractAddress) -> u256 {
        balances::read(account)
    }

    fn ERC20_allowance(owner: ContractAddress, spender: ContractAddress) -> u256 {
        allowances::read((owner, spender))
    }

    ////////////////////////////////
    // Internal Constructor
    ////////////////////////////////
    fn ERC20_initializer(
        name_: felt252, symbol_: felt252, decimals_: u8, initial_supply: u256, recipient: ContractAddress
    ) {
        name::write(name_);
        symbol::write(symbol_);
        decimals::write(decimals_);
        ERC20_mint(recipient, initial_supply);
    }


    ////////////////////////////////
    // Internal FUNCTIONS
    ////////////////////////////////
    fn ERC20_transfer(recipient: ContractAddress, amount: u256) {
        let sender = get_caller_address();
        transfer_helper(sender, recipient, amount);
    }

    fn ERC20_transferFrom(sender: ContractAddress, recipient: ContractAddress, amount: u256) {
        let caller = get_caller_address();
        spend_allowance(sender, caller, amount);
        transfer_helper(sender, recipient, amount);
    }

    fn ERC20_approve(spender: ContractAddress, amount: u256) {
        let caller = get_caller_address();
        approve_helper(caller, spender, amount);
    }

    fn ERC20_increaseAllowance(spender: ContractAddress, added_value: u256) {
        let caller = get_caller_address();
        approve_helper(caller, spender, allowances::read((caller, spender)) + added_value);
    }

    fn ERC20_decreaseAllowance(spender: ContractAddress, subtracted_value: u256) {
        let caller = get_caller_address();
        approve_helper(caller, spender, allowances::read((caller, spender)) - subtracted_value);
    }

    fn ERC20_mint(recipient: ContractAddress, amount: u256) {
        assert(!recipient.is_zero(), 'ERC20: mint to the 0 address');
        assert(amount >= u256_from_felt252(0), 'ZERO_AMOUNT');

        let balance: u256 = balances::read(recipient);
        // overflow is not possible because sum is guaranteed to be less than total supply
        // which we check for overflow below
        let new_balance: u256 = balance + amount;
        balances::write(recipient, new_balance);

        let supply: u256 = total_supply::read();
        let new_supply: u256 = supply + amount;

        total_supply::write(new_supply);
    }

    fn ERC20_burn(account: ContractAddress, amount: u256) {
        assert(!account.is_zero(), 'ERC20: burn to the 0 address');
        assert(amount > u256_from_felt252(0), 'ZERO_AMOUNT');

        let balance: u256 = balances::read(account);
        assert(balance >= amount, 'ERC20: burn amount exceeds');

        // overflow is not possible because sum is guaranteed to be less than total supply
        // which we check for overflow below
        let new_balance: u256 = balance - amount;
        balances::write(account, new_balance);

        let supply: u256 = total_supply::read();
        let new_supply: u256 = supply - amount;

        total_supply::write(new_supply);
    }

    fn transfer_helper(sender: ContractAddress, recipient: ContractAddress, amount: u256) {
        assert(!sender.is_zero(), 'ERC20: transfer from 0');
        assert(!recipient.is_zero(), 'ERC20: transfer to 0');
        balances::write(sender, balances::read(sender) - amount);
        balances::write(recipient, balances::read(recipient) + amount);
    }

    fn spend_allowance(owner: ContractAddress, spender: ContractAddress, amount: u256) {
        let current_allowance = allowances::read((owner, spender));
        let ONES_MASK = 0xffffffffffffffffffffffffffffffff_u128;
        let is_unlimited_allowance =
            current_allowance.low == ONES_MASK & current_allowance.high == ONES_MASK;
        if !is_unlimited_allowance {
            approve_helper(owner, spender, current_allowance - amount);
        }
    }

    fn approve_helper(owner: ContractAddress, spender: ContractAddress, amount: u256) {
        assert(!spender.is_zero(), 'ERC20: approve from 0');
        allowances::write((owner, spender), amount);
    }
}
