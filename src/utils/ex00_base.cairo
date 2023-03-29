////////////////////////////////
// Ex11Base
// A Base contract from which other contracts can import major functions
// such as `validate_exercise`, `distribute_points`
////////////////////////////////


#[contract]
mod Ex00Base {
    // Core Library Imports
    use starknet::get_caller_address;
    use zeroable::Zeroable;
    use starknet::ContractAddress;
    use starknet::ContractAddressZeroable;
    use starknet::syscalls::replace_class_syscall;
    use starknet::ClassHash;
    use starknet::class_hash::Felt252TryIntoClassHash;
    use integer::u256_from_felt252;
    use traits::Into;
    use traits::TryInto;
    use array::ArrayTrait;
    use option::OptionTrait;

    // Internal Imports
    use starknet_cairo_101::utils::Iplayers_registry::Iplayers_registryDispatcherTrait;
    use starknet_cairo_101::utils::Iplayers_registry::Iplayers_registryDispatcher;
    use starknet_cairo_101::token::ITDERC20::ITDERC20DispatcherTrait;
    use starknet_cairo_101::token::ITDERC20::ITDERC20Dispatcher;

    const Decimals: u128 = 1000000000000000000_u128;


    ////////////////////////////////
    // STORAGE
    ////////////////////////////////
    struct Storage {
        tderc20_address_storage: ContractAddress,
        players_registry_storage: ContractAddress,
        workshop_id_storage: u128,
        exercise_id_storage: u128,
    }

    ////////////////////////////////
    // View Functions
    ////////////////////////////////
    #[view]
    fn tderc20_address() -> ContractAddress {
        tderc20_address_storage::read()
    }

    #[view]
    fn players_registry() -> ContractAddress {
        players_registry_storage::read()
    }

    #[view]
    fn workshop_id() -> u128 {
        workshop_id_storage::read()
    }

    #[view]
    fn exercise_id() -> u128 {
        exercise_id_storage::read()
    }

    #[view]
    fn has_validated_exercise(account: ContractAddress) -> bool {
        // reading player registry
        let players_registry = players_registry_storage::read();
        let workshop_id = workshop_id_storage::read();
        let exercise_id = exercise_id_storage::read();

        Iplayers_registryDispatcher{contract_address: players_registry}
            .has_validated_exercise(account, workshop_id, exercise_id)
    }

    ////////////////////////////////
    // Internal Constructor
    ////////////////////////////////
    fn ex_initializer(
        _tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: u128, _exercise_id: u128
    ) {
        tderc20_address_storage::write(_tderc20_address);
        players_registry_storage::write(_players_registry);
        workshop_id_storage::write(_workshop_id);
        exercise_id_storage::write(_exercise_id);
    }

    ////////////////////////////////
    // Internal Functions
    ////////////////////////////////
    fn distribute_points(to: ContractAddress, amount: u128) {
        // Retrieving contract address from storage
        let tderc20_address = tderc20_address_storage::read();
        let points_to_credit: u128 = amount * Decimals;

        ITDERC20Dispatcher{contract_address: tderc20_address}
            .distribute_points(to, points_to_credit);
    }

    fn validate_exercise(account: ContractAddress) {
        // reading player registry
        let players_registry = players_registry_storage::read();
        let workshop_id = workshop_id_storage::read();
        let exercise_id = exercise_id_storage::read();

        let has_current_user_validated_exercise =
            Iplayers_registryDispatcher{contract_address: players_registry}
            .has_validated_exercise(account, workshop_id, exercise_id);

        assert(has_current_user_validated_exercise == false, 'Exercise previously validated');
        Iplayers_registryDispatcher{contract_address: players_registry}
            .validate_exercise(account, workshop_id, exercise_id);
    }

    fn update_class_hash_by_admin(class_hash_in_felt: felt252) {
        let players_registry = players_registry_storage::read();
        let sender_address = get_caller_address();

        let is_admin = Iplayers_registryDispatcher{contract_address: players_registry}
            .is_exercise_or_admin(sender_address);

        assert (is_admin == true, 'CALLER_NO_ADMIN_RIGHTS');
        let class_hash: ClassHash = class_hash_in_felt.try_into().unwrap();
        replace_class_syscall(class_hash);
    }
}
