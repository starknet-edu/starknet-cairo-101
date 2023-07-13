////////////////////////////////
// TDERC20
// Main ERC20 contract to utilise ERC20_base contracts
// The contract is used to distribute points etc.
////////////////////////////////

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
    use starknet_cairo_101::token::ERC20_base::ERC20Base::IERC20BaseImpl;
    use starknet_cairo_101::token::ITDERC20::ITDERC20;
    use starknet_cairo_101::token::ERC20_base::ERC20Base;
    use starknet_cairo_101::token::IERC20_Base::IERC20BASEDispatcherTrait;
    use starknet_cairo_101::token::IERC20_Base::IERC20BASELibraryDispatcher;

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
    impl TDERC20 of ITDERC20<ContractState> {
        fn is_transferable(self: @ContractState) -> bool {
            self.is_transferable_storage.read()
        }
        fn name(self: @ContractState) -> felt252 {
            IERC20BASELibraryDispatcher {
                class_hash: starknet::class_hash_const::<0x1234>()
            }.ERC20_name()
        }
        fn symbol(self: @ContractState) -> felt252 {
            IERC20BASELibraryDispatcher {
                class_hash: starknet::class_hash_const::<0x1234>()
            }.ERC20_symbol()
        }
        fn decimals(self: @ContractState) -> u8 {
            IERC20BASELibraryDispatcher {
                class_hash: starknet::class_hash_const::<0x1234>()
            }.ERC20_decimals()
        }
        fn totalSupply(self: @ContractState) -> u256 {
            IERC20BASELibraryDispatcher {
                class_hash: starknet::class_hash_const::<0x1234>()
            }.ERC20_totalSupply()
        }
        fn balanceOf(self: @ContractState, account: ContractAddress) -> u256 {
            IERC20BASELibraryDispatcher {
                class_hash: starknet::class_hash_const::<0x1234>()
            }.ERC20_balanceOf(account)
        }
        fn allowance(
            self: @ContractState, owner: ContractAddress, spender: ContractAddress
        ) -> u256 {
            IERC20BASELibraryDispatcher {
                class_hash: starknet::class_hash_const::<0x1234>()
            }.ERC20_allowance(owner, spender)
        }
        fn is_teacher_or_exercise(self: @ContractState, account: ContractAddress) -> bool {
            self.teachers_and_exercises_accounts.read(account)
        }


        fn transfer(ref self: ContractState, recipient: ContractAddress, amount: u256) -> bool {
            InternalFunctions::_is_transferable(ref self);
            IERC20BASELibraryDispatcher {
                class_hash: starknet::class_hash_const::<0x1234>()
            }.ERC20_transfer(recipient, amount);
            return true;
        }
        fn transferFrom(
            ref self: ContractState,
            sender: ContractAddress,
            recipient: ContractAddress,
            amount: u256
        ) -> bool {
            InternalFunctions::_is_transferable(ref self);
            IERC20BASELibraryDispatcher {
                class_hash: starknet::class_hash_const::<0x1234>()
            }.ERC20_transferFrom(sender, recipient, amount);
            self.emit(Transfer { from: sender, to: recipient, value: amount });
            return true;
        }
        fn approve(ref self: ContractState, spender: ContractAddress, amount: u256) -> bool {
            IERC20BASELibraryDispatcher {
                class_hash: starknet::class_hash_const::<0x1234>()
            }.ERC20_approve(spender, amount);
            let owner: ContractAddress = get_caller_address();
            self.emit(Approval { owner, spender, value: amount });
            return true;
        }
        fn increaseAllowance(
            ref self: ContractState, spender: ContractAddress, added_value: u256
        ) -> bool {
            IERC20BASELibraryDispatcher {
                class_hash: starknet::class_hash_const::<0x1234>()
            }.ERC20_increaseAllowance(spender, added_value);
            return true;
        }
        fn decreaseAllowance(
            ref self: ContractState, spender: ContractAddress, subtracted_value: u256
        ) -> bool {
            IERC20BASELibraryDispatcher {
                class_hash: starknet::class_hash_const::<0x1234>()
            }.ERC20_decreaseAllowance(spender, subtracted_value);
            return true;
        }
        fn distribute_points(ref self: ContractState, to: ContractAddress, amount: u128) {
            InternalFunctions::only_teacher_or_exercise(ref self);
            IERC20BASELibraryDispatcher {
                class_hash: starknet::class_hash_const::<0x1234>()
            }.ERC20_mint(to, u256 { low: amount, high: 0_u128 });
        }
        fn remove_points(ref self: ContractState, to: ContractAddress, amount: u128) {
            InternalFunctions::only_teacher_or_exercise(ref self);
            IERC20BASELibraryDispatcher {
                class_hash: starknet::class_hash_const::<0x1234>()
            }.ERC20_burn(to, u256 { low: amount, high: 0_u128 });
        }
        fn set_teachers(
            ref self: ContractState, accounts: Array::<ContractAddress>, permissions: Array::<bool>
        ) {
            InternalFunctions::only_teacher_or_exercise(ref self);
            InternalFunctions::set_single_teacher(ref self, accounts, permissions);
        }

        fn set_teacher(ref self: ContractState, account: ContractAddress, permission: bool) {
            InternalFunctions::only_teacher_or_exercise(ref self);
            self.teachers_and_exercises_accounts.write(account, permission);
        }
        fn set_transferable(ref self: ContractState, permission: bool) {
            InternalFunctions::only_teacher_or_exercise(ref self);
            self.is_transferable_storage.write(permission);
            return ();
        }
        fn update_class_hash_by_admin(ref self: ContractState, class_hash_in_felt: felt252) {
            InternalFunctions::only_teacher_or_exercise(ref self);
            let class_hash: ClassHash = class_hash_in_felt.try_into().unwrap();
            replace_class_syscall(class_hash);
        }
    }


    ////////////////////////////////
    // Constructor
    ////////////////////////////////
    #[constructor]
    fn constructor(
        ref self: ContractState,
        name_: felt252,
        symbol_: felt252,
        decimals_: u8,
        initial_supply: u256,
        recipient: ContractAddress,
        owner: ContractAddress
    ) {
        IERC20BASELibraryDispatcher {
            class_hash: starknet::class_hash_const::<0x1234>()
        }.ERC20_initializer(name_, symbol_, decimals_, initial_supply, recipient);
        self.teachers_and_exercises_accounts.write(owner, true);
        self
            .emit(
                Transfer {
                    from: contract_address_const::<0>(), to: recipient, value: initial_supply
                }
            );
    }


    ////////////////////////////////
    // INTERNAL FUNCTIONS
    ////////////////////////////////
    #[generate_trait]
    impl InternalFunctions of InternalFunctionsTrait {
        fn set_single_teacher(
            ref self: ContractState,
            mut accounts: Array::<ContractAddress>,
            mut permissions: Array::<bool>
        ) {
            helper::check_gas();
            if !accounts.is_empty() {
                self
                    .teachers_and_exercises_accounts
                    .write(accounts.pop_front().unwrap(), permissions.pop_front().unwrap());
                InternalFunctions::set_single_teacher(ref self, accounts, permissions);
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
}
