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

    ////////////////////////////////
    // Constructor
    ////////////////////////////////
    #[constructor]
    fn constructor(
        _tderc20_address: felt, _players_registry: felt, _workshop_id: felt, _exercise_id: felt
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
        //
        let erc20_address = tderc20_address();

        // Check if your answer is correct
        validate_answers(sender_address.into(), secret_value_i_guess, next_secret_value_i_chose);
        // Checking if the user has validated the exercise before
        validate_exercise(sender_address.into());
        // Sending points to the address specified as parameter
        distribute_points(sender_address.into(), u256_from_felt(2));
    }
}
