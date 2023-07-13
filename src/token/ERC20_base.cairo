////////////////////////////////
// ERC20Base
// A Base ERC20 contract to implement ERC20 standarded methods
// such as `transfer`, `transfer_from`, `mint`, 'burn', 'approve' etc.
////////////////////////////////

#[starknet::contract]
mod ERC20Base {
    // Core library Imports
    use starknet::get_caller_address;
    use zeroable::Zeroable;
    use starknet::contract_address_const;
    use starknet::ContractAddress;
    use starknet::contract_address::ContractAddressZeroable;
    use traits::Into;
    use traits::TryInto;
    use array::ArrayTrait;
    use option::OptionTrait;
    use integer::u256_from_felt252;

    use starknet_cairo_101::token::IERC20_Base::IERC20BASE;

    //
    // Declaring storage vars
    // Storage vars are by default not visible through the ABI. They are similar to "private" variables in Solidity
    //
    // This variable is a felt and is called my_secret_value_storage. It is stored in the contract's Storage struct
    // From within a smart contract, it can be read with my_secret_value_storage::read() or written to with my_secret_value_storage::write()

    #[storage]
    struct Storage {
        name: felt252,
        symbol: felt252,
        decimals: u8,
        total_supply: u256,
        balances: LegacyMap::<ContractAddress, u256>,
        allowances: LegacyMap::<(ContractAddress, ContractAddress), u256>,
    }


    impl IERC20BaseImpl of IERC20BASE<ContractState> {
        fn ERC20_name(self: @ContractState) -> felt252 {
            self.name.read()
        }

        fn ERC20_symbol(self: @ContractState) -> felt252 {
            self.symbol.read()
        }

        fn ERC20_decimals(self: @ContractState) -> u8 {
            self.decimals.read()
        }

        fn ERC20_totalSupply(self: @ContractState) -> u256 {
            self.total_supply.read()
        }

        fn ERC20_balanceOf(self: @ContractState, account: ContractAddress) -> u256 {
            self.balances.read(account)
        }

        fn ERC20_allowance(
            self: @ContractState, owner: ContractAddress, spender: ContractAddress
        ) -> u256 {
            self.allowances.read((owner, spender))
        }

        fn ERC20_initializer(
            ref self: ContractState,
            name_: felt252,
            symbol_: felt252,
            decimals_: u8,
            initial_supply: u256,
            recipient: ContractAddress
        ) {
            self.name.write(name_);
            self.symbol.write(symbol_);
            self.decimals.write(decimals_);
            IERC20BaseImpl::ERC20_mint(ref self, recipient, initial_supply);
        }

        fn ERC20_transfer(ref self: ContractState, recipient: ContractAddress, amount: u256) {
            let sender = get_caller_address();
            InternalFunctions::transfer_helper(ref self, sender, recipient, amount);
        }

        fn ERC20_transferFrom(
            ref self: ContractState,
            sender: ContractAddress,
            recipient: ContractAddress,
            amount: u256
        ) {
            let caller = get_caller_address();
            InternalFunctions::spend_allowance(ref self, sender, caller, amount);
            InternalFunctions::transfer_helper(ref self, sender, recipient, amount);
        }

        fn ERC20_approve(ref self: ContractState, spender: ContractAddress, amount: u256) {
            let caller = get_caller_address();
            InternalFunctions::approve_helper(ref self, caller, spender, amount);
        }

        fn ERC20_increaseAllowance(
            ref self: ContractState, spender: ContractAddress, added_value: u256
        ) {
            let caller = get_caller_address();
            InternalFunctions::approve_helper(
                ref self, caller, spender, self.allowances.read((caller, spender)) + added_value
            );
        }

        fn ERC20_decreaseAllowance(
            ref self: ContractState, spender: ContractAddress, subtracted_value: u256
        ) {
            let caller = get_caller_address();
            InternalFunctions::approve_helper(
                ref self,
                caller,
                spender,
                self.allowances.read((caller, spender)) - subtracted_value
            );
        }

        fn ERC20_mint(ref self: ContractState, recipient: ContractAddress, amount: u256) {
            assert(!recipient.is_zero(), 'ERC20: mint to the 0 address');
            assert(amount >= u256_from_felt252(0), 'ZERO_AMOUNT');

            let balance: u256 = self.balances.read(recipient);
            // overflow is not possible because sum is guaranteed to be less than total supply
            // which we check for overflow below
            let new_balance: u256 = balance + amount;
            self.balances.write(recipient, new_balance);

            let supply: u256 = self.total_supply.read();
            let new_supply: u256 = supply + amount;

            self.total_supply.write(new_supply);
        }

        fn ERC20_burn(ref self: ContractState, account: ContractAddress, amount: u256) {
            assert(!account.is_zero(), 'ERC20: burn to the 0 address');
            assert(amount > u256_from_felt252(0), 'ZERO_AMOUNT');

            let balance: u256 = self.balances.read(account);
            assert(balance >= amount, 'ERC20: burn amount exceeds');

            // overflow is not possible because sum is guaranteed to be less than total supply
            // which we check for overflow below
            let new_balance: u256 = balance - amount;
            self.balances.write(account, new_balance);

            let supply: u256 = self.total_supply.read();
            let new_supply: u256 = supply - amount;

            self.total_supply.write(new_supply);
        }
    }

    #[generate_trait]
    impl InternalFunctions of InternalFunctionsTrait {
        fn transfer_helper(
            ref self: ContractState,
            sender: ContractAddress,
            recipient: ContractAddress,
            amount: u256
        ) {
            assert(!sender.is_zero(), 'ERC20: transfer from 0');
            assert(!recipient.is_zero(), 'ERC20: transfer to 0');
            self.balances.write(sender, self.balances.read(sender) - amount);
            self.balances.write(recipient, self.balances.read(recipient) + amount);
        }

        fn spend_allowance(
            ref self: ContractState, owner: ContractAddress, spender: ContractAddress, amount: u256
        ) {
            let current_allowance = self.allowances.read((owner, spender));
            let ONES_MASK = 0xffffffffffffffffffffffffffffffff_u128;
            let is_unlimited_allowance = current_allowance.low == ONES_MASK
                & current_allowance.high == ONES_MASK;
            if !is_unlimited_allowance {
                InternalFunctions::approve_helper(
                    ref self, owner, spender, current_allowance - amount
                );
            }
        }

        fn approve_helper(
            ref self: ContractState, owner: ContractAddress, spender: ContractAddress, amount: u256
        ) {
            assert(!spender.is_zero(), 'ERC20: approve from 0');
            self.allowances.write((owner, spender), amount);
        }
    }
}
