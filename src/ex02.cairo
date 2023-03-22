// /////// Ex 02
// // Understanding asserts
// In this exercise, you need to:
// - Use this contract's claim_points() function
// - Your points are credited by the contract if you send the correct value

// // What you'll learn
// - Using asserts
// - How to declare storage variables
// - How to read storage variables
// - How to create getter functions
// Asserts are a basic building block allowing you to verify that two values are the same.
// They are similar to require() in Solidity
// More information about basic storage https://www.cairo-by-example.com/basics/storage

// /////// General directives and imports
//
//

#[contract]
mod Ex02 {
    // Core library Imports
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use integer::u256_from_felt252;

    // Internal Imports
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;

    //
    // Declaring storage vars
    // Storage vars are by default not visible through the ABI. They are similar to "private" variables in Solidity
    //
    // This variable is a felt and is called my_secret_value_storage. It is stored in the contract's Storage struct
    // From within a smart contract, it can be read with my_secret_value_storage::read() or written to with my_secret_value_storage::write()

    struct Storage {
        my_secret_value_storage: u128,
    }

    //
    // Declaring getters
    // Public variables should be declared explicitly with a getter function (indicated with #[view]) to be visible through the ABI and callable from other contracts
    //

    #[view]
    fn my_secret_value() -> u128 {
        my_secret_value_storage::read()
    }

    // ######## Constructor
    // This function (indicated with #[constructor]) is called when the contract is deployed and is used to initialize the contract's state

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

    // ######## External functions
    // These functions are callable by other contracts and are indicated with #[external] (similar to "public" in Solidity)


    #[external]
    fn claim_points(my_value: u128) {
        // Reading caller address
        let sender_address = get_caller_address();
        // Reading stored value from storage
        let my_secret_value = my_secret_value_storage::read();
        // Checking that the value sent is correct
        // Using assert this way is similar to using "require" in Solidity
        assert(my_value == my_secret_value, 'Wrong secret value');
        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, u256_from_felt252(2));
    }

    #[external]
    fn update_class_hash(class_hash: felt252) {
        update_class_hash_by_admin(class_hash);
    }
}
