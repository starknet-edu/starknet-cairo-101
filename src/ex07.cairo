// ######## Ex 07
// # Understanding functions to compare values
// In this exercise, you need to:
// - Use this contract's claim_points() function
// - Your points are credited by the contract

// ######## References
// Documentation is still being written. You can find answers in this file
// https://github.com/starkware-libs/cairo-lang/blob/master/src/starkware/cairo/common/math.cairo

#[contract]
mod Ex07 {
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use starknet::ContractAddressZeroable;

    use traits::Into;
    use traits::TryInto;
    use array::ArrayTrait;
    use option::OptionTrait;
    use integer::u256_from_felt252;
    use integer::u8_from_felt252;

    // Internal Imports
    use starknet_cairo_101::utils::ex00_base::Ex00Base::tderc20_address;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::has_validated_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;

    ////////////////////////////////
    // Constructor
    ////////////////////////////////
    #[constructor]
    fn constructor(
        _tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: u128, _exercise_id: u128
    ) {
        ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    }

    ////////////////////////////////
    // EXTERNAL FUNCTIONS
    ////////////////////////////////
    #[external]
    fn claim_points(value_a: u128, value_b: u128) {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();

        let test = 75_u128;

        assert(value_a != 0_u128, 'ZERO_VALUE');
        assert(value_b >= 0_u128, 'LESS_THAN_ZERO_VALUE');
        assert(value_a != value_b, 'EQUAL_VALUE');
        assert(value_a <= 75_u128, 'GREATER_VALUE');
        assert(value_a >= 40_u128 & value_a <= 70_u128, 'NOT_IN_BETWEEN_VALUE');
        assert(value_b < 1_u128, 'LESS_THAN_VALUE');

        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, u256_from_felt252(2));
    }

    #[external]
    fn update_class_hash(class_hash: felt252) {
        update_class_hash_by_admin(class_hash);
    }
}
