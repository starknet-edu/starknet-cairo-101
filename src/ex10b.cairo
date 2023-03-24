// ######## Ex 10b
// # Composability
// This exercise was deployed as a complement to ex10, but you don't know where!
// Use ex10 to find its address, then voyager to read from ex10b
// Then use ex10 to claim points

#[contract]
mod Ex10 {
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::get_contract_address;
    use starknet::ContractAddress;
    use starknet::ContractAddressZeroable;
    use traits::Into;
    use traits::TryInto;
    use array::ArrayTrait;
    use option::OptionTrait;
    use hash::LegacyHash;

    // Internal Imports
    use starknet_cairo_101::utils::ex00_base::Ex00Base::tderc20_address;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::has_validated_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;

    use starknet_cairo_101::utils::Iex10::Iex10Dispatcher;
    use starknet_cairo_101::utils::Iex10::Iex10DispatcherTrait;

    ////////////////////////////////
    // STORAGE
    ////////////////////////////////
    struct Storage {
        ex10_address: ContractAddress,
        secret_value: u128,
    }

    ////////////////////////////////
    // Constructor
    ////////////////////////////////
    #[constructor]
    fn constructor(ex10_addr: ContractAddress) {
        ex10_address::write(ex10_addr);
        let current_contract_address = get_contract_address();

        Iex10Dispatcher{contract_address: ex10_addr}.set_ex_10b_address(current_contract_address);
    }

    ////////////////////////////////
    // View Functions
    ////////////////////////////////
    #[view]
    fn get_ex10_address() -> ContractAddress {
        return ex10_address::read();
    }

    #[view]
    fn get_secret_value() -> u128 {
        return secret_value::read();
    }

    ////////////////////////////////
    // EXTERNAL FUNCTIONS
    ////////////////////////////////
    #[external]
    fn change_secret_value(new_secret_value: u128) {
        // Only ex10 can call this function
        only_ex10();
        // Changing secret value
        secret_value::write(new_secret_value);
        return ();
    }

    #[external]
    fn update_class_hash(class_hash: felt252) {
        update_class_hash_by_admin(class_hash);
    }


    //
    // Internal functions
    //
    //
    fn only_ex10() {
        let caller = get_caller_address();
        let ex10_address = ex10_address::read();
        assert(ex10_address == caller, 'ADDRESS_NOT_MATCH');
    }
}