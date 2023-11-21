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


#[starknet::contract]
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
    #[storage]
    struct Storage {
        // This variable is a u128, an unsigned integer (only positive values) stored over 128 bits
        // You can use any of the following types: u8, u16, u32, u64, u128, bool, felt252, ContractAddress
        // You can also use arrays of any of these types.
        // For example:  Array::<ContractAddress> for an array of addresses or Array::<u8> for an array of 8 bytes
        // To access state variables, you need to reference the contract state
        // If you intend to modify state, you will need to use `ref self: ContractState` which is a mutable reference to the contract state
        // But if you do not intend to modify state, you can use `self: @ContractState` which is a snapshot of the contract state
        // You can read and write to storage variables using the `.write()` and `.read()` functions, for example: self.my_secret_value_storage.write(42)
        my_secret_value_storage: u128,
    }


    ////////////////////////////////
    // Constructor
    // This function (indicated with #[constructor]) is called when the contract is deployed and is used to initialize the contract's state
    ////////////////////////////////
    #[constructor]
    fn constructor(
        ref self: ContractState,
        _tderc20_address: ContractAddress,
        _players_registry: ContractAddress,
        _workshop_id: u128,
        _exercise_id: u128,
        my_secret_value: u128,
    ) {
        // The constructor takes a mutable reference to the contract state to enable it modify the state and instantiate state variables
        self.ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
        self.my_secret_value_storage.write(my_secret_value);
    }



    //////////////////////////////////////
    // Ex02 trait implementation of Ex02Trait
    ///////////////////////////////////////

    ////////////////////////////////
    // External functions
    // The functions in the  Ex02TraitImpl block are callable by other contracts or external calls and are indicated with #[external(v0)] to make them availiable in the ABI
    // The generate_trait attribute is used to automatically generate a trait for the impl block
    ///////////////////////////////////

    #[external(v0)]
    #[generate_trait]
    impl Ex02TraitImpl of Ex02Trait{

        ////////////////////////////////
        // View Functions
        // Public variables should be declared explicitly with a getter function to be visible through the ABI and callable from other contracts
        // By taking a snapshot of the ContractState, we ensure that this function can not modify the Contract State and hence can be seen as a view function 
        ////////////////////////////////
        fn my_secret_value(self: @ContractState) -> u128 {
            // The contract read the value with .read()
            // You may have noticed that in Cairo 1 all lines end with a semicolon.
            // But this one doesn't. Why?
            // Because, in this case, the return value is the result of the function call. The semicolon is not needed.
            // Since self is a snapshot of the contract state, it cannot be modified.
            self.my_secret_value_storage.read()
        }


        ////////////////////////////////
        // Mutable functions
        // These functions are callable by other contracts or external calls such as DAPP,
        // By taking a reference to the ContractState, this function can modify the Contract State (this is similar to an external or public function in solidity )
        ////////////////////////////////
        fn claim_points(ref self: ContractState, my_value: u128) {
            // Reading caller address using the Starknet core library function get_caller_address() (similar to msg.sender in Solidity)
            // and storing it in a variable called sender_address.
            let sender_address = get_caller_address();
            // Reading the secret value from storage using the read function from the storage variable my_secret_value_storage
            let my_secret_value = self.my_secret_value_storage.read();
            // Checking that the value sent is the same as the secret value stored in storage using the assert function
            // Using assert this way is similar to using "require" in Solidity
            assert(my_value == my_secret_value, 'Wrong secret value');
            // Checking if the user has validated the exercise before sending points using the validate_exercise function from the Ex00Base contract
            self.validate_exercise(sender_address);
            // Sending points to the address specified as parameter using the distribute_points function from the Ex00Base contract
            self.distribute_points(sender_address, 2_u128);
        }


        ////////////////////////////////
        // External functions - Administration
        // Only admins can call these. You don't need to understand them to finish the exercise.
        ////////////////////////////////
        fn update_class_hash(ref self: ContractState, class_hash: felt252) {
            self.update_class_hash_by_admin(class_hash);
        }

    }


}
