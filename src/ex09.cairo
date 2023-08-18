////////////////////////////////
// Exercise 9
// Recursions - advanced
////////////////////////////////
// In this exercise, you need to:
// - Follow this contract's claim_points() function to understand how to finish the exercise
// - Send the correct array to claim_points() to claim your points
// - Your points are credited by the contract if you send the correct value
// What you'll learn
// - The relavent function of Array, such as is_empty(), len() and more
////////////////////////////////

#[contract]
mod Ex09 {
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
    // These functions become part of the set of functions of the current contract
    ////////////////////////////////
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;
    use starknet_cairo_101::utils::helper;

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
    // External functions
    // These functions are callable by other contracts or external calls such as DAPP, which are indicated with #[external] (similar to "public" in Solidity)
    ////////////////////////////////
    #[external]
    fn claim_points(array: Array::<u128>) {
        assert(!array.is_empty(), 'EMPTY_ARRAY');
        assert(array.len() >= 4_u32, 'ARRAY_LEN_LT_4');

        // Calculating the sum of the array sent by the user
        let mut sum: u128 = 0_u128;
        let total = get_sum_internal(sum, array);
        assert(total >= 50_u128, 'SUM_LT_50');

        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();

        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, 2_u128);
    }

    ////////////////////////////////
    // External functions - Administration
    // Only admins can call these. You don't need to understand them to finish the exercise.
    ////////////////////////////////
    #[external]
    fn update_class_hash(class_hash: felt252) {
        update_class_hash_by_admin(class_hash);
    }

    ////////////////////////////////
    // Internal functions
    // These functions are not accessible to external calls only callable inside the contracts or be used in other contracts using "use statement" (similar to "private" in Solidity)
    ////////////////////////////////
    fn get_sum_internal(mut sum: u128, mut values: Array::<u128>) -> u128 {
        helper::check_gas();

        if !values.is_empty() {
            sum = sum + values.pop_front().unwrap();
            return get_sum_internal(sum, values);
        }

        sum
    }
}
