////////////////////////////////    
// Exercise 2
// Understanding asserts
////////////////////////////////
// In this exercise, you need to:
// - Use this contract's claim_points() function with a specific argument
// - Your points are credited by the contract if you send the correct value

// // What you'll learn
// - Using asserts
// - How to declare storage variables
// - How to read storage variables
// - How to create getter functions
// Asserts are a basic building block allowing you to verify that two values are the same.
// They are similar to require() in Solidity
////////////////////////////////


#[contract]
mod Ex02 {
    ////////////////////////////////    
    // Starknet core library imports
    // These are syscalls and functionnalities that allow you to write starknet contracts
    ////////////////////////////////
    use starknet::get_caller_address;
    use starknet::ContractAddress;

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
        // This variable is a u128, an unsigned integer stored over 128 bits
        my_secret_value_storage: u128,
    }

    ////////////////////////////////
    // View Functions
    // Public variables should be declared explicitly with a getter function (indicated with #[view]) to be visible through the ABI and callable from other contracts
    ////////////////////////////////
    #[view]
    fn my_secret_value() -> u128 {  
        // The contract read the value with ::read()
        // You may have noticed that in Cairo one, lines all finish with a semi colon
        // But this one doesn't. Why?
        // Because in that case, it is returning a value.
        my_secret_value_storage::read()
    }

    ////////////////////////////////
    // Constructor
    // This function (indicated with #[constructor]) is called when the contract is deployed and is used to initialize the contract's state
    ////////////////////////////////
    #[constructor]
    fn constructor(
        _tderc20_address: ContractAddress,
        _players_registry: ContractAddress,
        _workshop_id: u128,
        _exercise_id: u128,
        my_secret_value: u128,
    ) {
        ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
        my_secret_value_storage::write(my_secret_value);
    }

    ////////////////////////////////
    // External functions
    // These functions are callable by other contracts and are indicated with #[external] (similar to "public" in Solidity)
    ////////////////////////////////
    #[external]
    fn claim_points(my_value: u128) {
        // Reading caller address
        let sender_address = get_caller_address();
        // Reading the secret value from storage
        let my_secret_value = my_secret_value_storage::read();
        // Checking that the value sent is the same as the secret value
        // Using assert this way is similar to using "require" in Solidity
        assert(my_value == my_secret_value, 'Wrong secret value');
        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, 2_u128);
    }
}
