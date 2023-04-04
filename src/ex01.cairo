////////////////////////////////
// Exercise 1
// Using a simple public contract function
////////////////////////////////
// In this exercise, you need to:
// - Follow this contract's claim_points() function to understand how to finish the exercise
// - Your points are credited by the contract to your address when you call the claim_points() function successfully (you can call it multiple times)
// What you'll learn
// - General smart contract syntax and structure
////////////////////////////////

// Contracts are defined using the #[contract] attribute (similar to "contract" in Solidity) and are defined in a module
#[contract]
mod Ex01 {
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
    // Constructor
    // This function (indicated with #[constructor]) is called once, when the contract is deployed, and is used to initialize the contract's state
    ////////////////////////////////
    // The constructor takes 4 parameters: the address of the TDERC20 contract, the address of the PlayersRegistry contract, the workshop id and the exercise id
    // When you deploy the contract, you need to pass these parameters to the constructor function
    // For these exercises you do not need to worry about the parameters, they are automatically passed to the constructor.
    #[constructor]
    fn constructor(_tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: u128, _exercise_id: u128) {
        ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    }

    ////////////////////////////////
    // External functions
    // These functions are callable by other contracts or external calls such as DAPP, which are indicated with #[external] (similar to "public" in Solidity)
    ////////////////////////////////
    #[external]
    fn claim_points() {
        // Reading caller address
        let sender_address = get_caller_address();
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
