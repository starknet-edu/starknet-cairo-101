////////////////////////////////
// Exercise 3
// Using contract functions to manipulate contract variables
////////////////////////////////
// In this exercise, you need to:
// - Follow this contract's claim_points() function to understand how to finish the exercise
// - Use this contract's decrement and increment functions in order to manipulate an internal counter
// - Once this counter reaches a certain value, call a specific function
// - Your points are credited by the contract
// What you'll learn
// - What are external functions and how to declare them in a contract
// - How to declare mappings in storage variables
// - How to read and write to mappings
// - How to use a function to manipulate storage variables
// - How to return a value from a function
// - How to throw an error using the Cairo assert function
////////////////////////////////

#[contract]
mod Ex03 {
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
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;

    ////////////////////////////////
    // Storage
    // In Cairo 1, storage is declared in a struct
    // Storage is not visible by default through the ABI
    ////////////////////////////////
    struct Storage {
        // This variable is a LegacyMap. It is equivalent to a mapping in Solidity.
        // It is used to store a counter (of type u128) for each user address (of type ContractAddress) in the contract's storage
        // The user_counters variable is private and can only be accessed through the getter function declared below
        // To read the u128 value from a LegacyMap, use the read function (e.g. user_counters::read(sender_address))
        // To write a u128 value to a LegacyMap (mapping a u128 to a ContractAddress), use the write function (e.g. user_counters::write(sender_address, 0_u128))
        user_counters: LegacyMap::<ContractAddress, u128>,
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
    fn get_user_counters(account: ContractAddress) -> u128 {
        // We are not calling the read function without any parameter (e.g. user_counters::read()) but with a parameter (e.g. user_counters::read(sender_address))
        // because we want to read the value of the mapping for a specific key (the sender address)
        let user_counter = user_counters::read(account);
        // We return the value of the counter. We can return a value without using the return keyword, similar to Rust
        user_counter
    }

    ////////////////////////////////
    // External functions
    // These functions are callable by other contracts or external calls and are indicated with #[external] (similar to "public" in Solidity)
    ////////////////////////////////
    // You can alter the state of the contract by calling external functions such as increment_counter, decrement_counter and reset_counter
    // After you altered the state of the contract, you can read from the contract's storage using the get_user_counters function to check if the counter is equal to 3
    // Then you can call the claim_points function to check if the counter is equal to 3 and if so credit the user with points
    #[external]
    fn increment_counter() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Reading the counter from storage for the sender address (the key of the mapping) and storing it in a variable
        let current_counter_value = user_counters::read(sender_address);
        // Writing updated value to storage (incrementing the counter by 2)
        user_counters::write(sender_address, current_counter_value + 2_u128);
    }

    #[external]
    fn decrement_counter() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Reading counter from storage
        let current_counter_value = user_counters::read(sender_address);
        // Writing updated value to storage (decrementing the counter by 1)
        user_counters::write(sender_address, current_counter_value - 1_u128);
    }

    #[external]
    fn reset_counter() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Reinitializing the user counter to 0 (resetting it)
        user_counters::write(sender_address, 0_u128);
    }


    #[external]
    fn claim_points() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Checking that user's counter is equal to 3 (the value we want to reach) and throwing an error if it is not
        let current_counter_value = user_counters::read(sender_address);
        // We are using the Cairo assert function to throw an error if the condition is not met
        assert(current_counter_value == 3_u128, 'Counter is not equal to 3');

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

}
