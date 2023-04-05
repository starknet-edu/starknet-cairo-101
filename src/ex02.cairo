////////////////////////////////
// Exercise 2
// Understanding asserts
////////////////////////////////
// In this exercise, you need to:
// - Follow this contract's claim_points() function to understand how to finish the exercise (Tip: See the my_secret_value() function to get the secret value)
// - Send the correct value to claim_points() to claim your points
// - Your points are credited by the contract if you send the correct value
// What you'll learn
// - Using asserts
// - How to declare storage variables
// - How to read storage variables
// - How to create getter functions (indicated with #[view]) to read variables
// - How to use asserts; they are similar to require() in Solidity
////////////////////////////////


#[contract]
mod Ex02 {
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
        // This variable is a u128, an unsigned integer (only positive values) stored over 128 bits
        // You can use any of the following types: u8, u16, u32, u64, u128, bool, felt252, ContractAddress
        // You can also use arrays of any of these types.
        // For example:  Array::<ContractAddress> for an array of addresses or Array::<u8> for an array of 8 bytes
        // You can read and write to storage variables using the ::write() and ::read() functions, for example: my_secret_value_storage::write(42)
        my_secret_value_storage: u128,
    }

    ////////////////////////////////
    // View Functions
    // Public variables should be declared explicitly with a getter function (indicated with #[view]) to be visible through the ABI and callable from other contracts
    ////////////////////////////////
    #[view]
    fn my_secret_value() -> u128 {
        // The contract read the value with ::read()
        // You may have noticed that in Cairo 1 all lines end with a semicolon.
        // But this one doesn't. Why?
        // Because, in this case, the return value is the result of the function call. The semicolon is not needed.
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
    // These functions are callable by other contracts or external calls such as DAPP, which are indicated with #[external] (similar to "public" in Solidity)
    ////////////////////////////////
    #[external]
    fn claim_points(my_value: u128) {
        // Reading caller address using the Starknet core library function get_caller_address() (similar to msg.sender in Solidity)
        // and storing it in a variable called sender_address.
        let sender_address = get_caller_address();
        // Reading the secret value from storage using the read function from the storage variable my_secret_value_storage
        let my_secret_value = my_secret_value_storage::read();
        // Checking that the value sent is the same as the secret value stored in storage using the assert function
        // Using assert this way is similar to using "require" in Solidity
        assert(my_value == my_secret_value, 'Wrong secret value');
        // Checking if the user has validated the exercise before sending points using the validate_exercise function from the Ex00Base contract
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter using the distribute_points function from the Ex00Base contract
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
