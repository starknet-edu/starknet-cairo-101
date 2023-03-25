////////////////////////////////    
// Exercise 9
// Recursions - advanced
////////////////////////////////
// TODO (omar): Add a description of the exercise
// - Use this contract's claim_points() function
// - Your points are credited by the contract
////////////////////////////////

#[contract]
mod Ex09 {
    ////////////////////////////////    
    // Starknet core library imports
    // These are syscalls and functionnalities that allow you to write starknet contracts
    ////////////////////////////////
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use array::ArrayTrait;
    use option::OptionTrait;
    use integer::u256_from_felt252;
    use integer::u32_from_felt252;
    use hash::LegacyHash;

    ////////////////////////////////
    // Internal imports
    // These function become part of the set of function of the current contract
    ////////////////////////////////  
    use starknet_cairo_101::utils::ex00_base::Ex00Base::has_validated_exercise;
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
    // External functions
    // These functions are callable by other contracts and are indicated with #[external] (similar to "public" in Solidity)
    ////////////////////////////////
    #[external]
    fn claim_points(array: Array::<u128>) {
        assert(!array.is_empty(), 'EMPTY_ARRAY');
        assert(array.len() >= u32_from_felt252(4), 'ARRAY_LEN_LT_4');

        // Calculating the sum of the array sent by the user
        let mut sum: u128 = 0_u128;
        sum = get_sum_internal(sum, array);
        assert(sum >= 50_u128, 'SUM_LT_50');

        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();

        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, u256_from_felt252(2));
    }

    ////////////////////////////////
    // Internal functions
    // These functions are not callable by other contracts (similar to "private" in Solidity)
    ////////////////////////////////
    fn get_sum_internal(mut sum: u128, mut values: Array::<u128>) -> u128 {
        if !values.is_empty() {
            sum = sum + values.pop_front().unwrap();
            get_sum_internal(sum, values);
        }

        sum
    }

    ////////////////////////////////
    // External functions - Administration
    // Only admins can call these. You don't need to understand them to finish the exercise.
    ////////////////////////////////
    #[external]
    fn update_class_hash(class_hash: felt252) {
        update_class_hash_by_admin(class_hash);
    }
}
