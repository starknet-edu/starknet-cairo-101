// ######## Ex 02
// # Understanding asserts
// In this exercise, you need to:
// - Use this contract's claim_points() function
// - Your points are credited by the contract

// # What you'll learn
// - Using asserts
// - How to declare storage variables
// - How to read storage variables
// - How to create getter functions
// Asserts are a basic building block allowing you to verify that two values are the same.
// They are similar to require() in Solidity
// More information about basic storage https://www.cairo-by-example.com/basics/storage

// ######## General directives and imports
//
//

#[contract]
mod Ex02 {
    // Core library Imports
    use starknet::get_caller_address;
    use starknet::contract_address_to_felt;
    use integer::u256_from_felt;

    // Internal Imports
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;

    //
    // Declaring storage vars
    // Storage vars are by default not visible through the ABI. They are similar to "private" variables in Solidity
    //
    // This variable is a felt and is called my_secret_value_storage
    // From within a smart contract, it can be read with my_secret_value_storage.read() or written to with my_secret_value_storage.write()

    struct Storage {
        my_secret_value_storage: felt, 
    }

    //
    // Declaring getters
    // Public variables should be declared explicitly with a getter
    //

    #[view]
    fn my_secret_value() -> felt {
        my_secret_value_storage::read()
    }

    // ######## Constructor
    // This function is called when the contract is deployed
    //
    #[constructor]
    fn constructor(
        _tderc20_address: felt,
        _players_registry: felt,
        _workshop_id: felt,
        _exercise_id: felt,
        my_secret_value: felt,
    ) {
        ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
        my_secret_value_storage::write(my_secret_value);
    }

    // ######## External functions
    // These functions are callable by other contracts
    //

    #[external]
    fn claim_points(my_value: felt) {
        // Reading caller address
        let sender_address = contract_address_to_felt(get_caller_address());
        // Reading stored value from storage
        let my_secret_value = my_secret_value_storage::read();
        // Checking that the value sent is correct
        // Using assert this way is similar to using "require" in Solidity
        assert(my_value == my_secret_value, 'Wrong secret value');
        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, u256_from_felt(2));
    }
}
