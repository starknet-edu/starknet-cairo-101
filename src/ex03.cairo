// Ex 03
// // Using contract functions to manipulate contract variables
// In this exercise, you need to:
// - Use this contract's functions in order to manipulate an internal counter unique to your address
// - Once this counter reaches a certain value, call a specific function
// - Your points are credited by the contract

// # What you'll learn
// - How to declare mappings
// - How to read and write to mappings
// - How to use a function to manipulate storage variables

#[contract]
mod Ex03 {
    ////////////////////////////////    
    // Starknet core library imports
    // These are syscalls and functionnalities that allow you to write starknet contracts
    ////////////////////////////////
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use integer::u256_from_felt252;

    ////////////////////////////////
    // Internal imports
    // These function become part of the set of function of the current contract.
    ////////////////////////////////    
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash;  

    ////////////////////////////////
    // Storage
    // In Cairo 1, storage is declared in a struct
    // Storage is not visible by default through the ABI
    ////////////////////////////////
    struct Storage {
        // This variable is a LegacyMap. It is equivalent to a mapping in Solidity
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
        let user_counter = user_counters::read(account);
        user_counter
    }

    ////////////////////////////////
    // External functions
    // These functions are callable by other contracts and are indicated with #[external] (similar to "public" in Solidity)
    ////////////////////////////////
    #[external]
    fn increment_counter() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Reading counter from storage
        let current_counter_value = user_counters::read(sender_address);
        // Writing updated value to storage
        user_counters::write(sender_address, current_counter_value + 2_u128);
    }

    #[external]
    fn decrement_counter() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Reading counter from storage
        let current_counter_value = user_counters::read(sender_address);
        // Writing updated value to storage
        user_counters::write(sender_address, current_counter_value - 1_u128);
    }
    
    #[external]
    fn reset_counter() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Reinitializing the user counter
        user_counters::write(sender_address, 0_u128);
    }

    
    #[external]
    fn claim_points() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Checking that user's counter is equal to 3
        let current_counter_value = user_counters::read(sender_address);
        assert(current_counter_value == 3_u128, 'Counter is not equal to 3');

        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, u256_from_felt252(2));
    }

}
