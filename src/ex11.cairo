////////////////////////////////
// Exercise 11
// Importing functions
////////////////////////////////
// - TODO (Omar): Add a description of the exercise
// - Read this contract and understand how it imports functions from another contract
// - Find the relevant contract it imports from
// - Read the code and understand what is expected of you
////////////////////////////////

#[starknet::interface]
trait Ex11Trait<T> {
     fn secret_value(self: @T) -> u128;
     fn claim_points(ref self: T, secret_value_i_guess: u128, next_secret_value_i_chose: u128);
     fn update_class_hash(ref self: T, class_hash: felt252);
}

#[starknet::contract]
mod Ex11 {
    ////////////////////////////////
    // Core Library imports
    // These are syscalls and functionalities that allow you to write Starknet contracts
    ////////////////////////////////
    use starknet::get_caller_address;
    use starknet::ContractAddress;    

    ////////////////////////////////
    // Internal imports
    // These functions become part of the set of functions of the current contract
    ////////////////////////////////
    use starknet_cairo_101::utils::ex11_base::Ex11Base::distribute_points;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::validate_exercise;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::ex_initializer;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::validate_answers;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::secret_value_internal;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;


    ////////////////////////////////
    // Storage
    // This is a struct that holds the contract state #[storage])
    ////////////////////////////////
    #[storage]
    struct Storage {}    

    ////////////////////////////////
    // Constructor
    // This function (indicated with #[constructor]) is called when the contract is deployed and is used to initialize the contract's state
    ////////////////////////////////
    #[constructor]
    fn constructor(
        ref self: ContractState, _tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: u128, _exercise_id: u128
    ) {
        ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    }

    #[external(v0)]
    impl Ex11Impl of super::Ex11Trait<ContractState> {
        ////////////////////////////////
        // View Functions
        // Public variables should be declared explicitly with a getter function (indicated with #[view]) to be visible through the ABI and callable from other contracts
        ////////////////////////////////
        fn secret_value(self: @ContractState) -> u128 {
            return secret_value_internal();
        }        

        ////////////////////////////////
        // External functions
        // These functions are callable by other contracts or external calls such as DAPP, which are indicated with #[external] (similar to "public" in Solidity)
        ////////////////////////////////
        fn claim_points(ref self: ContractState, secret_value_i_guess: u128, next_secret_value_i_chose: u128) {
            // Reading caller address
            let sender_address: ContractAddress = get_caller_address();
            // Check if your answer is correct
            validate_answers(sender_address, secret_value_i_guess, next_secret_value_i_chose);
            // Checking if the user has validated the exercise before
            validate_exercise(sender_address);
            // Sending points to the address specified as parameter
            distribute_points(sender_address, 2_u128);
        }        

        ////////////////////////////////
        // External functions - Administration
        // Only admins can call these. You don't need to understand them to finish the exercise.
        ////////////////////////////////
        fn update_class_hash(ref self: ContractState, class_hash: felt252) {
            update_class_hash_by_admin(class_hash);
        }        
    }
}