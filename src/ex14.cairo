////////////////////////////////    
// Exercise 14
// All in one exercise -It's your time to shine.
////////////////////////////////
// TODO (omar) - improve description
// - Deploy a contract that validates various exercises in a single transaction to get 2 points
// - Do you want to agregate your points in a single account? Use this https://github.com/starknet-edu/points-migrator
////////////////////////////////



////////////////////////////////
// ABI imports
// These are the interfaces of the contracts that you will interact with.
////////////////////////////////
#[abi]
trait IAllInOneContract {
    fn validate_various_exercises();
}

#[contract]
mod Ex14 {
    ////////////////////////////////    
    // Starknet core library imports
    // These are syscalls and functionnalities that allow you to write starknet contracts
    ////////////////////////////////
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use array::ArrayTrait;
    use option::OptionTrait;
    use integer::u256_from_felt252;
    use hash::LegacyHash;

    ////////////////////////////////
    // Internal imports
    // These function become part of the set of function of the current contract.
    ////////////////////////////////  
    use starknet_cairo_101::utils::ex11_base::Ex11Base::tderc20_address;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::has_validated_exercise;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::distribute_points;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::validate_exercise;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::ex_initializer;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::validate_answers;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::ex11_secret_value;
    use starknet_cairo_101::utils::ex11_base::Ex11Base::secret_value;

    use starknet_cairo_101::token::IERC20::IERC20Dispatcher;
    use starknet_cairo_101::token::IERC20::IERC20DispatcherTrait;
    use super::IAllInOneContractDispatcher;
    use super::IAllInOneContractDispatcherTrait;

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
    // External functions
    // These functions are callable by other contracts and are indicated with #[external] (similar to "public" in Solidity)
    ////////////////////////////////
    #[external]
    fn claim_points() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Retrieving ERC20 address
        let erc20_address = tderc20_address();
        // Reading contract balance before calling
        let balance_before = IERC20Dispatcher{contract_address: erc20_address}.balanceOf(sender_address);

        // Calling caller's validate_various_exercises() function
        IAllInOneContractDispatcher{contract_address: sender_address}.validate_various_exercises();

        // Reading contract balance after calling
        let balance_after = IERC20Dispatcher{contract_address: erc20_address}.balanceOf(sender_address);

        // Verifying that caller collected some points
        assert(balance_before >= u256_from_felt252(0) & balance_after > balance_before, 'NO_POINTS_COLLECTED');

        // Read how many points were collected
        let collected_points = balance_after - balance_before;
        // Check that at least 20 points were collected
        assert(collected_points >= u256_from_felt252(20), 'NO_ENOUGH_POINTS_COLLECTED');

         // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, u256_from_felt252(2));
    }
}
