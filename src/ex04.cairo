////////////////////////////////
// Exercise 4
// Reading a mapping
////////////////////////////////
// In this exercise, you need to:
// - Follow this contract's claim_points() function to understand how to finish the exercise
// - Use a function to show you know the correct value of the value in the mapping
// - Use this contract's claim_points() function with a specific argument
// - Your points are credited by the contract if you send the correct value
// What you will learn:
// - How to use a function to read a value in a mapping where the slot you read is the value from the first call
////////////////////////////////


#[contract]
mod Ex04 {
    ////////////////////////////////
    // Core Library imports
    // These are syscalls and functionalities that allow you to write Starknet contracts
    ////////////////////////////////
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use array::ArrayTrait;
    use option::OptionTrait;

    ////////////////////////////////
    // Internal imports
    // These functions become part of the set of functions of the contract
    ////////////////////////////////
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;
    use starknet_cairo_101::utils::helper;

    ////////////////////////////////
    // Storage
    // In Cairo 1, storage is declared in a struct
    // Storage is not visible by default through the ABI
    ////////////////////////////////
    struct Storage {
        user_slots: LegacyMap::<ContractAddress, u128>,
        values_mapped: LegacyMap::<u128, u128>,
        was_initialized: bool,
        next_slot: u128,
    }

    ////////////////////////////////
    // Constructor
    // This function (indicated with #[constructor]) is called when the contract is deployed and is used to initialize the contract's state
    ////////////////////////////////
    #[constructor]
    fn constructor(
        _tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: u128, _exercise_id: u128
    ) {
        ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    }

    ////////////////////////////////
    // View Functions
    // Public variables should be declared explicitly with a getter function (indicated with #[view]) to be visible through the ABI and callable from other contracts
    ////////////////////////////////
    #[view]
    fn get_user_slots(account: ContractAddress) -> u128 {
        return user_slots::read(account);
    }

    #[view]
    fn get_values_mapped(slot: u128) -> u128 {
        return values_mapped::read(slot);
    }

    ////////////////////////////////
    // External functions
    // These functions are callable by other contracts or external calls such as DAPP, which are indicated with #[external] (similar to "public" in Solidity)
    ////////////////////////////////
    #[external]
    fn claim_points(expected_value: u128) {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Reading the slot assigned to the caller address in the mapping user_slots.
        // The value was assigned when assign_user_slot() was called by the user (see below) and is stored in the mapping user_slots
        let user_slot = user_slots::read(sender_address);
        // Checking that the user has a slot assigned to they (i.e. that he called assign_user_slot() before)
        assert(user_slot != 0_u128, 'ASSIGN_USER_SLOT_FIRST');

        // Checking that the value provided by the caller is the one we expect
        // Yes, I'm sneaky
        let value = values_mapped::read(user_slot);
        assert(value == expected_value + 32_u128, 'NOT_EXPECTED_SECRET_VALUE');

        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, 2_u128);
    }

    // This function is used to assign a slot to a user and to update the next slot
    #[external]
    fn assign_user_slot() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Its value can change during the course of the function call
        let next_value = values_mapped::read(next_slot::read() + 1_u128);
        // Checking if next random value is 0
        if next_value == 0_u128 {
            next_slot::write(0_u128);
        }
        user_slots::write(sender_address, next_slot::read() + 1_u128);
        next_slot::write(next_slot::read() + 1_u128);
    }

    ////////////////////////////////
    // External functions - Administration
    // Only admins can call these. You don't need to understand them to finish the exercise.
    ////////////////////////////////
    #[external]
    fn update_class_hash(class_hash: felt252) {
        update_class_hash_by_admin(class_hash);
    }
    #[external]
    fn set_random_values(values: Array::<u128>) {
        // Check if the random values were already initialized
        let was_initialized_read = was_initialized::read();
        assert(was_initialized_read != true, 'NOT_INITIALISED');

        let mut idx: u128 = 0_u128;
        set_a_random_value(idx, values);

        // Mark that value store was initialized
        was_initialized::write(true);
    }

    fn set_a_random_value(mut idx: u128, mut values: Array::<u128>) {
        helper::check_gas();
        if !values.is_empty() {
            values_mapped::write(idx, values.pop_front().unwrap());
            idx = idx + 1_u128;
            set_a_random_value(idx, values);
        }
    }
}
