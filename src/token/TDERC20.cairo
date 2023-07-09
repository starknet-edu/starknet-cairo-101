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
    fn transferFrom(ref self: TContractState, sender: ContractAddress, recipient: ContractAddress, amount: u256) -> bool;
    fn approve(ref self: TContractState, spender: ContractAddress, amount: u256) -> bool;
    fn increaseAllowance(ref self: TContractState, spender: ContractAddress, added_value: u256) -> bool;
    fn decreaseAllowance(ref self: TContractState, spender: ContractAddress, subtracted_value: u256) -> bool;
    fn set_teachers(ref self: TContractState, accounts: Array::<ContractAddress>, permissions: Array::<bool>);
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


#[starknet::contract]
mod TDERC20 {
    // Core library Imports
    use starknet::get_caller_address;
    use zeroable::Zeroable;
    use starknet::contract_address_const;
    use starknet::ContractAddress;
    use traits::Into;
    use traits::TryInto;
    use array::ArrayTrait;
    use option::OptionTrait;
    use starknet::ClassHash;
    use starknet::syscalls::replace_class_syscall;
    use starknet::class_hash::Felt252TryIntoClassHash;


    // Internal Imports
  //  use starknet_cairo_101::token::ERC20_base::ERC20Base;
    use starknet_cairo_101::token::ERC20_base::ERC20Base::ERC20_name;
    use starknet_cairo_101::token::ERC20_base::ERC20Base::ERC20_symbol;
    use starknet_cairo_101::token::ERC20_base::ERC20Base::ERC20_totalSupply;
    use starknet_cairo_101::token::ERC20_base::ERC20Base::ERC20_decimals;
    use starknet_cairo_101::token::ERC20_base::ERC20Base::ERC20_balanceOf;
    use starknet_cairo_101::token::ERC20_base::ERC20Base::ERC20_allowance;
    use starknet_cairo_101::token::ERC20_base::ERC20Base::ERC20_mint;
    use starknet_cairo_101::token::ERC20_base::ERC20Base::ERC20_burn;
    use starknet_cairo_101::token::ERC20_base::ERC20Base::ERC20_initializer;
    use starknet_cairo_101::token::ERC20_base::ERC20Base::ERC20_approve;
    use starknet_cairo_101::token::ERC20_base::ERC20Base::ERC20_increaseAllowance;
    use starknet_cairo_101::token::ERC20_base::ERC20Base::ERC20_decreaseAllowance;
    use starknet_cairo_101::token::ERC20_base::ERC20Base::ERC20_transfer;
    use starknet_cairo_101::token::ERC20_base::ERC20Base::ERC20_transferFrom;
    use starknet_cairo_101::utils::helper;

    #[storage]
    struct Storage {
        is_transferable_storage: bool,
        teachers_and_exercises_accounts: LegacyMap<ContractAddress, bool>,
    }

    ////////////////////////////////
    // Events
    ////////////////////////////////
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        Transfer: Transfer,
        Approval: Approval
    }

    #[derive(Drop, starknet::Event)]
    struct Transfer {
        from: ContractAddress,
        to: ContractAddress,
        value: u256
    }

    #[derive(Drop, starknet::Event)]
    struct Approval {
        owner: ContractAddress,
        spender: ContractAddress,
        value: u256
    }

    ////////////////////////////////
    // Views and Externals
    ////////////////////////////////
   #[external(v0)]
   impl TDERC20 of super::ITDERC20<ContractState> {
    fn is_transferable(self: @ContractState) -> bool {
        self.is_transferable_storage.read()
    }
    fn name(self: @ContractState) -> felt252 {
        ERC20_name(self)
    }
    fn symbol(self: @ContractState) -> felt252 {
        ERC20_symbol()
    }
    fn decimals(self: @ContractState) -> u8 {
        ERC20_decimals()
    }
    fn totalSupply(self: @ContractState) -> u256 {
        ERC20_totalSupply()
    }
    fn balanceOf(self: @ContractState, account: ContractAddress) -> u256 {
        ERC20_balanceOf(account)
    }
    fn allowance(self: @ContractState, owner: ContractAddress, spender: ContractAddress) -> u256 {
        ERC20_allowance(owner, spender)
    }
    fn is_teacher_or_exercise(self: @ContractState, account: ContractAddress) -> bool {
        self.teachers_and_exercises_accounts.read(account)
    }


    fn transfer(ref self: ContractState, recipient: ContractAddress, amount: u256) -> bool {
       _is_transferable(ref self);
       ERC20_transfer(recipient, amount);
       return true;
    }
    fn transferFrom(ref self: ContractState, sender: ContractAddress, recipient: ContractAddress, amount: u256) -> bool {
        _is_transferable(ref self);
        ERC20_transferFrom(sender, recipient, amount);
        self.emit(Transfer { from: sender, to: recipient, value: amount });
        return true;
    }
    fn approve(ref self: ContractState, spender: ContractAddress, amount: u256) -> bool {
        ERC20_approve(spender, amount);
        let owner: ContractAddress = get_caller_address();
        self.emit(Approval { owner, spender, value: amount });
        return true;
    }
    fn increaseAllowance(ref self: ContractState, spender: ContractAddress, added_value: u256) -> bool {
        ERC20_increaseAllowance(spender, added_value);
        return true;
    }
    fn decreaseAllowance(ref self: ContractState, spender: ContractAddress, subtracted_value: u256) -> bool {
        ERC20_decreaseAllowance(spender, subtracted_value);
        return true;
    }
    fn distribute_points(ref self: ContractState, to: ContractAddress, amount: u128) {
        only_teacher_or_exercise(ref self);
        ERC20_mint(to, u256 { low: amount, high: 0_u128 });
    }
    fn remove_points(ref self: ContractState, to: ContractAddress, amount: u128) {
        only_teacher_or_exercise(ref self);
        ERC20_burn(to, u256 { low: amount, high: 0_u128 });
    }
    fn set_teachers(ref self: ContractState, accounts: Array::<ContractAddress>, permissions: Array::<bool>) {
        only_teacher_or_exercise(ref self);
        set_single_teacher(ref self, accounts, permissions);
    }
    
    fn set_teacher(ref self: ContractState, account: ContractAddress, permission: bool) {
        only_teacher_or_exercise(ref self);
        self.teachers_and_exercises_accounts.write(account, permission);
    }
    fn set_transferable(ref self: ContractState, permission: bool) {
        only_teacher_or_exercise(ref self);
        self.is_transferable_storage.write(permission);
        return ();
    }
    fn update_class_hash_by_admin(ref self: ContractState, class_hash_in_felt: felt252) {
        only_teacher_or_exercise(ref self);
        let class_hash: ClassHash = class_hash_in_felt.try_into().unwrap();
        replace_class_syscall(class_hash);
    }
   }


    ////////////////////////////////
    // Constructor
    ////////////////////////////////
    #[constructor]
    fn constructor(
        ref self: ContractState, name_: felt252, symbol_: felt252, decimals_: u8, initial_supply: u256, recipient: ContractAddress, owner: ContractAddress
    ) {
        ERC20_initializer(name_, symbol_, decimals_, initial_supply, recipient);
        self.teachers_and_exercises_accounts.write(owner, true);
        self.emit(Transfer {from: contract_address_const::<0>(), to: recipient, value: initial_supply});
    }


    ////////////////////////////////
    // INTERNAL FUNCTIONS
    ////////////////////////////////
    fn set_single_teacher(ref self: ContractState, mut accounts: Array::<ContractAddress>,mut permissions: Array::<bool>) {
        helper::check_gas();
        if !accounts.is_empty() {
            self.teachers_and_exercises_accounts.write(accounts.pop_front().unwrap(), permissions.pop_front().unwrap());
            set_single_teacher(ref self, accounts, permissions);
        }
    }

    fn only_teacher_or_exercise(ref self: ContractState) {
        let caller = get_caller_address();
        let permission = self.teachers_and_exercises_accounts.read(caller);
        assert(permission == true, 'NO_PERMISSION');
    }

    fn _is_transferable(ref self: ContractState) {
        let permission = self.is_transferable_storage.read();
        assert(permission == true, 'NOT_TRANSFERABLE');
    }
}
