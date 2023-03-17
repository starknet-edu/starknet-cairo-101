// ######## Ex 06
// External vs internal functions
// In this exercise, you need to:
// - Use a function to get assigned a private variable
// - Use an internal function to duplicate this variable in a public variable
// - Use a function to show you know the correct value of the private variable
// - Your points are credited by the contract

#[contract]
mod Ex06 {
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::ContractAddressZeroable;
    use starknet::ContractAddressIntoFelt;
    use starknet::FeltTryIntoContractAddress;
    use starknet::contract_address_try_from_felt;
    use traits::Into;
    use traits::TryInto;
    use array::ArrayTrait;
    use option::OptionTrait;
    use integer::u256_from_felt;

    // Internal Imports
    use starknet_cairo_101::utils::ex00_base::Ex00Base::tderc20_address;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::has_validated_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;

    ////////////////////////////////
    // STORAGE
    ////////////////////////////////
    struct Storage {
        user_slots: LegacyMap::<ContractAddress, felt>,
        user_values_public: LegacyMap::<ContractAddress, felt>,
        values_mapped_secret: LegacyMap::<felt, felt>,
        was_initialized: bool,
        next_slot: felt,
    }

    ////////////////////////////////
    // Constructor
    ////////////////////////////////
    #[constructor]
    fn constructor(
        _tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: felt, _exercise_id: felt
    ) {
        ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    }

    ////////////////////////////////
    // View Functions
    ////////////////////////////////
    #[view]
    fn get_user_slots(account: ContractAddress) -> felt {
        return user_slots::read(account);
    }

    #[view]
    fn get_user_values(account: ContractAddress) -> felt {
        return user_values_public::read(account);
    }

    ////////////////////////////////
    // EXTERNAL FUNCTIONS
    ////////////////////////////////

    #[external]
    fn claim_points(expected_value: felt) {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        let user_slot = user_slots::read(sender_address);
        assert(user_slot != 0, 'ASSIGN_USER_SLOT_FIRST');

        // Checking that the value provided by the user is the one we expect
        // Still sneaky.
        // Or not. Is this psyops?
        let value = values_mapped_secret::read(user_slot);
        assert(value == expected_value, 'NOT_EXPECTED_SECRET_VALUE');

        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, u256_from_felt(2));
    }

    #[external]
    fn assign_user_slot() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        let next_slot_temp = next_slot::read();
        let next_value = values_mapped_secret::read(next_slot_temp + 1);
        if next_value == 0 {
            user_slots::write(sender_address, 1);
            next_slot::write(0);
        } else {
            user_slots::write(sender_address, next_slot_temp + 1);
            next_slot::write(next_slot_temp + 1);
        }
    }

    #[external]
    fn external_handler_for_internal_function(a_value: felt) {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        assert(!sender_address.is_zero(), 'ZERO_ADDRESS');
        // Calling internal function
        copy_secret_value_to_readable_mapping(sender_address);
    }


    fn copy_secret_value_to_readable_mapping(sender_address: ContractAddress) {
        let user_slot = user_slots::read(sender_address);
        assert(user_slot != 0, 'ASSIGN_USER_SLOT_FIRST');

        // Reading user secret value
        let secret_value = values_mapped_secret::read(user_slot);

        // Copying the value from non accessible values_mapped_secret_storage to
        user_values_public::write(sender_address, secret_value);
    }

    //
    // External functions - Administration
    // Only admins can call these. You don't need to understand them to finish the exercise.
    //
    #[external]
    fn set_random_values(values: Array::<felt>) {
        // Check if the random values were already initialized
        let was_initialized_read = was_initialized::read();
        assert(was_initialized_read == true, 'NOT_INITIALISED');

        let mut idx: felt = 0;
        set_a_random_value(idx, values);

        // Mark that value store was initialized
        was_initialized::write(true);
    }

    fn set_a_random_value(mut idx: felt, mut values: Array::<felt>) {
        if !values.is_empty() {
            values_mapped_secret::write(idx, values.pop_front().unwrap());
            idx = idx + 1;
            set_a_random_value(idx, values);
        }
    }
}
