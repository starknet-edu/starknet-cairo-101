#[contract]
mod Ex01 {
    // /////// Ex 01
    // // Using a simple public contract function
    // In this exercise, you need to:
    // - Use this contract's claim_points() function to claim your points
    // - Your points are credited by the contract to your address if you send the correct value

    // What you'll learn
    // - General smart contract syntax and structure
    // - Calling a function from a smart contract

    // General directives and imports
    //
    //

    // Core Library Imports
    use starknet::get_caller_address;
    use starknet::contract_address_to_felt;
    use integer::u256_from_felt;
    use zeroable::Zeroable;
    use starknet::ContractAddressZeroable;
    use starknet::ContractAddressIntoFelt;
    use starknet::FeltTryIntoContractAddress;
    use starknet::contract_address_try_from_felt;
    use traits::Into;
    use traits::TryInto;
    use array::ArrayTrait;
    use option::OptionTrait;


    // Internal Imports
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;


    // Constructor
    // This function is called when the contract is deployed
    //
    #[constructor]
    fn constructor(
        _tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: felt, _exercise_id: felt
    ) {
        ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    }

    // External functions
    // These functions are callable by other contracts
    //

    // This function is called claim_points
    // It defines the expression sender_address as a felt. Read more about felts here https://www.cairo-lang.org/docs/hello_cairo/intro.html#field-element
    #[external]
    fn claim_points() {
        // Reading caller address
        let sender_address = get_caller_address();
        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, u256_from_felt(2));
    }
}
