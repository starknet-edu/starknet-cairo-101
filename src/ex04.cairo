// Ex 04
// // Reading a mapping
// In this exercise, you need to:
// - Use a function to read a variable
// - Use a function to read a value in a mapping, where the slot you read is the value from the first call
// - Use a function to show you know the correct value of the value in the mapping
// - Your points are credited by the contract


#[contract]
mod Ex04 {
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use starknet::ContractAddressZeroable;
    use traits::Into;
    use traits::TryInto;
    use array::ArrayTrait;
    use option::OptionTrait;
    use integer::u256_from_felt252;

    // Internal Imports
    use starknet_cairo_101::utils::ex00_base::Ex00Base::tderc20_address;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::has_validated_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;

    // Declaring storage
    struct Storage {
        user_slots: LegacyMap::<ContractAddress, u128>,
        values_mapped: LegacyMap::<u128, u128>,
        was_initialized: bool,
        next_slot: u128,
    }

    // Constructor
    #[constructor]
    fn constructor(
        _tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: u128, _exercise_id: u128
    ) {
        ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    }

    // View Functions
    #[view]
    fn get_user_slots(account: ContractAddress) -> u128 {
        return user_slots::read(account);
    }

    #[view]
    fn get_values_mapped(slot: u128) -> u128 {
        return values_mapped::read(slot);
    }

    // External functions
    #[external]
    fn claim_points(expected_value: u128) {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        let user_slot = user_slots::read(sender_address);
        assert(user_slot != 0_u128, 'ASSIGN_USER_SLOT_FIRST');

        // Checking that the value provided by the user is the one we expect
        // Yes, I'm sneaky
        let value = values_mapped::read(user_slot);
        assert(value == expected_value + 32_u128, 'NOT_EXPECTED_SECRET_VALUE');

        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, u256_from_felt252(2));
    }

    #[external]
    fn assign_user_slot() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        let next_slot_temp = next_slot::read();
        let next_value = values_mapped::read(next_slot_temp + 1_u128);
        if next_value == 0_u128 {
            user_slots::write(sender_address, 1_u128);
            next_slot::write(0_u128);
        } else {
            user_slots::write(sender_address, next_slot_temp + 1_u128);
            next_slot::write(next_slot_temp + 1_u128);
        }
    }

    // External functions - Administration
    // Only admins can call the below functions. You don't need to understand them to finish the exercise.
    #[external]
    fn set_random_values(values: Array::<u128>) {
        // Check if the random values were already initialized
        let was_initialized_read = was_initialized::read();
        assert(was_initialized_read == true, 'NOT_INITIALISED');

        let mut idx: u128 = 0_u128;
        set_a_random_value(idx, values);

        // Mark that value store was initialized
        was_initialized::write(true);
    }

    fn set_a_random_value(mut idx: u128, mut values: Array::<u128>) {
        if !values.is_empty() {
            values_mapped::write(idx, values.pop_front().unwrap());
            idx = idx + 1_u128;
            set_a_random_value(idx, values);
        }
    }

    #[external]
    fn update_class_hash(class_hash: felt252) {
        update_class_hash_by_admin(class_hash);
    }
}
