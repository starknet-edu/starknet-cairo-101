// Ex 01
// Using a simple public contract function
// In this exercise, you need to:
// - Use this contract's claim_points() function to claim your points
// - Your points are credited by the contract to your address if you send the correct value

// What you'll learn
// - General smart contract syntax and structure
// - Calling a function of a smart contract

#[contract]
mod Ex01 {
    
    // Starknet core Library imports
    use starknet::get_caller_address;
    use integer::u256_from_felt252;
    use starknet::ContractAddress;

    // Importing functions from another contract. 
    // These function become part of the set of function of the current contract.
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash;  

    // Constructor
    // This function (indicated with #[constructor]) is called when the contract is deployed and is used to initialize the contract's state
    //
    #[constructor]
    fn constructor(
        _tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: u128, _exercise_id: u128
    ) {
        ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    }

    // External functions
    // These functions are callable by other contracts and are indicated with #[external] (similar to "public" in Solidity)
    #[external]
    fn claim_points() {
        // Reading caller address
        let sender_address = get_caller_address();
        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, u256_from_felt252(2));
    }

}
