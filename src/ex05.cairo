// Ex 05
// Public/private variables
// In this exercise, you need to:
// - Use a function to get assigned a private variable
// - Use a function to duplicate this variable in a public variable
// - Use a function to show you know the correct value of the private variable
// - Your points are credited by the contract

#[contract]
mod Ex05 {
    // Starknet core Library imports
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use array::ArrayTrait;
    use option::OptionTrait;
    use integer::u256_from_felt252;

    // Internal Imports
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash;

    // Declaring storage
    struct Storage {
        user_slots: LegacyMap::<ContractAddress, u128>,
        user_values_public: LegacyMap::<ContractAddress, u128>,
        values_mapped_secret: LegacyMap::<u128, u128>,
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
        user_slots::read(account)
    }

    #[view]
    fn get_user_values(account: ContractAddress) -> u128 {
        user_values_public::read(account)
    }

    // External functions
    #[external]
    fn claim_points(expected_value: u128) {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Reading user slot and verifying it's not zero
        let user_slot = user_slots::read(sender_address);
        assert(user_slot != 0_u128, 'ASSIGN_USER_SLOT_FIRST');

        // Checking that the value provided by the user is the one we expect
        // Yes, I'm sneaky
        let value = values_mapped_secret::read(user_slot);
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
        // Assigning a slot to a user
        let next_slot_temp = next_slot::read();
        // Checking if next random value is 0
        // next_value is a "mutable" variable. Its value can change during the course of the function call
        let mut next_value = values_mapped_secret::read(next_slot::read() + 1_u128);
        if next_value == 0_u128 {
            next_slot::write(0_u128);
            next_value = values_mapped_secret::read(next_slot::read() + 1_u128);
        } 
        user_slots::write(sender_address, next_slot::read() + 1_u128);
        next_slot::write(next_slot::read() + 1_u128);
    }

    #[external]
    fn copy_secret_value_to_readable_mapping() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Reading user's assigned slot and verifying it's not zero
        let user_slot = user_slots::read(sender_address);
        assert(user_slot != 0_u128, 'ASSIGN_USER_SLOT_FIRST');

        // Reading user secret value
        let secret_value = values_mapped_secret::read(user_slot);

        // Copying the value from non accessible values_mapped_secret_storage to publicly accessible user_values_public
        user_values_public::write(sender_address, secret_value - 23_u128);
    }

    //
    // External functions - Administration
    // Only admins can call these. You don't need to understand them to finish the exercise.
    //
    #[external]
    fn set_random_values(values: Array::<u128>) {
        // Check if the random values were already initialized
        let was_initialized_read = was_initialized::read();
        assert(was_initialized_read == true, 'NOT_INITIALISED');

        let mut idx = 0_u128;
        set_a_random_value(idx, values);

        // Mark that value store was initialized
        was_initialized::write(true);
    }

    fn set_a_random_value(mut idx: u128, mut values: Array::<u128>) {
        if !values.is_empty() {
            values_mapped_secret::write(idx, values.pop_front().unwrap());
            idx = idx + 1_u128;
            set_a_random_value(idx, values);
        }
    }
}
