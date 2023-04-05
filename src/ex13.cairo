// ######## Ex 13
// Privacy
// The terminology "Zero knowldge" can be confusing. Devs tend to assume things are private on Zk Rollups.
// They are not. They can be; but they are not by default.
// In this exercise, you need to:
// - Use past data from transactions sent to the contract to find a value that is supposed to be "secret"
// you might need this endpoint https://alpha4.starknet.io/feeder_gateway/get_transaction?transactionHash=

#[contract]
mod Ex13 {
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
    use starknet_cairo_101::utils::helper;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;
    ////////////////////////////////
    // Storage
    // In Cairo 1, storage is declared in a struct
    // Storage is not visible by default through the ABI
    ////////////////////////////////
    struct Storage {
        user_slots: LegacyMap::<ContractAddress, u128>,
        values_mapped_secret: LegacyMap::<u128, u128>,
        was_initialized: bool,
        next_slot: u128,
    }

    ////////////////////////////////
    // EVENTS
    ////////////////////////////////
    #[event]
    fn Assign_User_Slot_Called(account: ContractAddress, rank: u128) {}

    ////////////////////////////////
    // Constructor
    // This function (indicated with #[constructor]) is called when the contract is deployed and is used to initialize the contract's state
    ////////////////////////////////
    #[constructor]
    fn constructor(
        _tderc20_address: ContractAddress,
        _players_registry: ContractAddress,
        _workshop_id: u128,
        _exercise_id: u128
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

    ////////////////////////////////
    // External functions
    // These functions are callable by other contracts or external calls such as DAPP, which are indicated with #[external] (similar to "public" in Solidity)
    ////////////////////////////////
    #[external]
    fn claim_points(expected_value: u128) {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Checking that the user got a slot assigned
        let user_slot = user_slots::read(sender_address);
        assert(user_slot != 0_u128, 'ASSIGN_USER_SLOT_FIRST');

        // Checking that the value provided by the user is the one we expect
        // Still sneaky.
        // Or not. Is this psyops?
        let value = values_mapped_secret::read(user_slot);
        assert(value == expected_value, 'NOT_EXPECTED_SECRET_VALUE');

        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, 2_u128);
    }

    #[external]
    fn assign_user_slot() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        let next_slot_temp = next_slot::read();
        let next_value = values_mapped_secret::read(next_slot_temp + 1_u128);
        if next_value == 0_u128 {
            user_slots::write(sender_address, 1_u128);
            next_slot::write(0_u128);
        } else {
            user_slots::write(sender_address, next_slot_temp + 1_u128);
            next_slot::write(next_slot_temp + 1_u128);
        }

        let user_slot = user_slots::read(sender_address);
        // Emit an event with secret value
        Assign_User_Slot_Called(sender_address, user_slot);
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
            values_mapped_secret::write(idx, values.pop_front().unwrap());
            idx = idx + 1_u128;
            set_a_random_value(idx, values);
        }
    }
}
