////////////////////////////////
// Exercise 7
// Understanding functions to compare values
////////////////////////////////
// - Use this contract's claim_points() function
// - Your points are credited by the contract
////////////////////////////////

#[contract]
mod Ex07 {
    ////////////////////////////////
    // Core Library imports
    // These are syscalls and functionalities that allow you to write Starknet contracts
    ////////////////////////////////
    use starknet::get_caller_address;
    use starknet::ContractAddress;

    ////////////////////////////////
    // Internal imports
    // These functions become part of the set of functions of the contract
    ////////////////////////////////
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;

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
    // External functions - Administration
    // Only admins can call these. You don't need to understand them to finish the exercise.
    ////////////////////////////////
    #[external]
    fn update_class_hash(class_hash: felt252) {
        update_class_hash_by_admin(class_hash);
    }
    #[external]
    fn claim_points(value_a: u128, value_b: u128) {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Checking that value_a and value_b fit the desired properties
        assert(value_a != 0_u128, 'ZERO_VALUE');
        assert(value_b >= 0_u128, 'LESS_THAN_ZERO_VALUE');
        assert(value_a != value_b, 'EQUAL_VALUE');
        assert(value_a <= 75_u128, 'GREATER_VALUE');
        assert(value_a >= 40_u128 & value_a <= 70_u128, 'NOT_IN_BETWEEN_VALUE');
        assert(value_b < 1_u128, 'LESS_THAN_VALUE');

        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, 2_u128);
    }
}
