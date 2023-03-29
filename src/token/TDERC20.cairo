////////////////////////////////
// TDERC20
// Main ERC20 contract to utilise ERC20_base contracts
// The contract is used to distribute points etc.
////////////////////////////////

#[contract]
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

    struct Storage {
        is_transferable_storage: bool,
        teachers_and_exercises_accounts: LegacyMap<ContractAddress, bool>,
    }

    ////////////////////////////////
    // Events
    ////////////////////////////////
    #[event]
    fn Transfer(from: ContractAddress, to: ContractAddress, value: u256) {}

    #[event]
    fn Approval(owner: ContractAddress, spender: ContractAddress, value: u256) {}

    ////////////////////////////////
    // View FUNCTIONS
    ////////////////////////////////
    #[view]
    fn is_transferable() -> bool {
        is_transferable_storage::read()
    }

    #[view]
    fn name() -> felt252 {
        ERC20_name()
    }

    #[view]
    fn symbol() -> felt252 {
        ERC20_symbol()
    }

    #[view]
    fn decimals() -> u8 {
        ERC20_decimals()
    }

    #[view]
    fn totalSupply() -> u256 {
        ERC20_totalSupply()
    }

    #[view]
    fn balanceOf(account: ContractAddress) -> u256 {
        ERC20_balanceOf(account)
    }

    #[view]
    fn allowance(owner: ContractAddress, spender: ContractAddress) -> u256 {
        ERC20_allowance(owner, spender)
    }

    #[view]
    fn is_teacher_or_exercise(account: ContractAddress) -> bool {
        teachers_and_exercises_accounts::read(account)
    }

    ////////////////////////////////
    // Constructor
    ////////////////////////////////
    #[constructor]
    fn constructor(
        name_: felt252, symbol_: felt252, decimals_: u8, initial_supply: u256, recipient: ContractAddress, owner: ContractAddress
    ) {
        ERC20_initializer(name_, symbol_, decimals_, initial_supply, recipient);
        teachers_and_exercises_accounts::write(owner, true);
        Transfer(contract_address_const::<0>(), recipient, initial_supply);
    }


    ////////////////////////////////
    // EXTERNAL FUNCTIONS
    ////////////////////////////////
    #[external]
    fn transfer(recipient: ContractAddress, amount: u256) -> bool {
       _is_transferable();
       ERC20_transfer(recipient, amount);
       return true;
    }

    #[external]
    fn transferFrom(sender: ContractAddress, recipient: ContractAddress, amount: u256) -> bool {
        _is_transferable();
        ERC20_transferFrom(sender, recipient, amount);
        Transfer(sender, recipient, amount);
        return true;
    }

    #[external]
    fn approve(spender: ContractAddress, amount: u256) -> bool {
        ERC20_approve(spender, amount);
        let owner: ContractAddress = get_caller_address();
        Approval(owner, spender, amount);
        return true;
    }

    #[external]
    fn increaseAllowance(spender: ContractAddress, added_value: u256) -> bool {
        ERC20_increaseAllowance(spender, added_value);
        return true;
    }

    #[external]
    fn decreaseAllowance(spender: ContractAddress, subtracted_value: u256) -> bool {
        ERC20_decreaseAllowance(spender, subtracted_value);
        return true;
    }

    #[external]
    fn distribute_points(to: ContractAddress, amount: u128) {
        only_teacher_or_exercise();
        ERC20_mint(to, u256 { low: amount, high: 0_u128 });
    }

    #[external]
    fn remove_points(to: ContractAddress, amount: u128) {
        only_teacher_or_exercise();
        ERC20_burn(to, u256 { low: amount, high: 0_u128 });
    }

    #[external]
    fn set_teachers(accounts: Array::<ContractAddress>, permissions: Array::<bool>) {
        only_teacher_or_exercise();
        set_single_teacher(accounts, permissions);
    }
    
    fn set_single_teacher(mut accounts: Array::<ContractAddress>,mut permissions: Array::<bool>) {
        helper::check_gas();
        if !accounts.is_empty() {
            teachers_and_exercises_accounts::write(accounts.pop_front().unwrap(), permissions.pop_front().unwrap());
            set_single_teacher(accounts, permissions);
        }
    }

    #[external]
    fn set_teacher(account: ContractAddress, permission: bool) {
        only_teacher_or_exercise();
        teachers_and_exercises_accounts::write(account, permission);
    }

    #[external]
    fn set_transferable(permission: bool) {
        only_teacher_or_exercise();
        is_transferable_storage::write(permission);
        return ();
    }

    ////////////////////////////////
    // INTERNAL FUNCTIONS
    ////////////////////////////////
    fn only_teacher_or_exercise() {
        let caller = get_caller_address();
        let permission = teachers_and_exercises_accounts::read(caller);
        assert(permission == true, 'NO_PERMISSION');
    }

    fn _is_transferable() {
        let permission = is_transferable_storage::read();
        assert(permission == true, 'NOT_TRANSFERABLE');
    }
    #[external]
    fn update_class_hash_by_admin(class_hash_in_felt: felt252) {
        only_teacher_or_exercise();
        let class_hash: ClassHash = class_hash_in_felt.try_into().unwrap();
        replace_class_syscall(class_hash);
    }
}
