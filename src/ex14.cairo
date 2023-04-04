////////////////////////////////
// Exercise 14
// All in one exercise -It's your time to shine.
////////////////////////////////
// TODO (omar) - improve description
// - This exercise is a bit different from the others. It is a bit more open-ended and you will have to use your creativity to solve it.
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
    // Core Library imports
    // These are syscalls and functionalities that allow you to write Starknet contracts
    ////////////////////////////////
    use starknet::get_caller_address;
    use starknet::ContractAddress;

    ////////////////////////////////
    // Internal imports
    // These functions become part of the set of functions of the contract
    ////////////////////////////////
    use starknet_cairo_101::utils::helper::get_token_in_decimals;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::tderc20_address;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;
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
    // These functions are callable by other contracts or external calls such as DAPP, which are indicated with #[external] (similar to "public" in Solidity)
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
        assert(balance_before >= u256 { low: 0_u128, high: 0_u128 } & balance_after > balance_before, 'NO_POINTS_COLLECTED');

        // Read how many points were collected
        let collected_points = balance_after - balance_before;

        // Check that at least 20 points were collected
        let decimals = IERC20Dispatcher{contract_address: erc20_address}.decimals();
        let token_decimals = get_token_in_decimals(decimals);
        let token_amount = 20_u128 * token_decimals;
        assert(collected_points >= u256 { low: token_amount, high: 0_u128 }, 'NO_ENOUGH_POINTS_COLLECTED');

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
