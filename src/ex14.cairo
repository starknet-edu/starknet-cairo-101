// ######## Ex 14
// All in one exercise
// It's your time to shine.
// Deploy a contract that validates various exercises in a single transaction to get 2 points
// Do you want to agregate your points in a single account? Use this https://github.com/starknet-edu/points-migrator

#[abi]
trait IAllInOneContract {
    fn validate_various_exercises();
}

#[contract]
mod Ex14 {
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::ContractAddressZeroable;
    use starknet::ContractAddressIntoFelt;
    use starknet::FeltTryIntoContractAddress;
    use starknet::contract_address_try_from_felt;
    use traits::Into;
    use traits::TryInto;
    use array::ArrayTrait;
    use option::OptionTrait;
    use integer::u256_from_felt;
    use hash::LegacyHash;
    use integer::u32_to_felt;

    // Internal Imports
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
    ////////////////////////////////
    #[constructor]
    fn constructor(
        _tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: felt, _exercise_id: felt
    ) {
        ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    }

    ////////////////////////////////
    // EXTERNAL FUNCTIONS
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
        assert(balance_before >= u256_from_felt(0) & balance_after > balance_before, 'NO_POINTS_COLLECTED');

        // Read how many points were collected
        let collected_points = balance_after - balance_before;
        // Check that at least 20 points were collected
        assert(collected_points >= u256_from_felt(20), 'NO_ENOUGH_POINTS_COLLECTED');

         // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, u256_from_felt(2));

    }
}
