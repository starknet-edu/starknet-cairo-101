// ######## Ex 12
// Events
// In this exercise, you need to:
// - Use a function to get assigned a private variable
// - Use a function to emit event with the value of the private variable
// - Your points are credited by the contract

#[contract]
mod Ex12 {
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

    ////////////////////////////////
    // STORAGE
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
    fn Assign_User_Slot_Called(account: ContractAddress, secret_value: u128) {}

    ////////////////////////////////
    // Constructor
    ////////////////////////////////
    #[constructor]
    fn constructor(
        _tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: u128, _exercise_id: u128
    ) {
        ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    }

    ////////////////////////////////
    // View Functions
    ////////////////////////////////
    #[view]
    fn get_user_slots(account: ContractAddress) -> u128 {
        return user_slots::read(account);
    }

    ////////////////////////////////
    // EXTERNAL FUNCTIONS
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
        distribute_points(sender_address, u256_from_felt252(2));
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
        let secret_value = values_mapped_secret::read(user_slot);
        // Emit an event with secret value
        Assign_User_Slot_Called(sender_address, secret_value + 32_u128);
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

        let mut idx: u128 = 0_u128;
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

    #[external]
    fn update_class_hash(class_hash: felt252) {
        update_class_hash_by_admin(class_hash);
    }
}