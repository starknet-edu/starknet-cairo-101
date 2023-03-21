// ######## Ex 08
// # Recursions - basics
// In this exercise, you need to:
// - Use this contract's claim_points() function
// - Your points are credited by the contract

#[contract]
mod Ex08 {
    use zeroable::Zeroable;
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use starknet::ContractAddressZeroable;
    use traits::Into;
    use traits::TryInto;
    use array::ArrayTrait;
    use option::OptionTrait;
    use integer::u256_from_felt252;
    use hash::LegacyHash;

    // Internal Imports
    use starknet_cairo_101::utils::ex00_base::Ex00Base::tderc20_address;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::has_validated_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;

    use core::hash::TupleSize2LegacyHash;

    type felt = felt252;

    ////////////////////////////////
    // STORAGE
    ////////////////////////////////
    struct Storage {
        user_values: LegacyMap::<(ContractAddress, felt), felt>
    }

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
    // View Functions
    ////////////////////////////////
    #[view]
    fn get_user_values(account: ContractAddress, slot: felt) -> felt {
        return user_values::read((account, slot));
    }

    ////////////////////////////////
    // EXTERNAL FUNCTIONS
    ////////////////////////////////

    #[external]
    fn claim_points() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        let user_value_at_slot_ten = user_values::read((sender_address, 10));
        assert(user_value_at_slot_ten == 10, 'USER_VALUE_NOT_10');

        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, u256_from_felt252(2));
    }

    // This function takes an array as a parameter
    // In order to pass it, the user needs to pass both the array and its length
    // This complexity is abstracted away by voyager, where you simply need to pass an array
    #[external]
    fn set_user_values(account: ContractAddress, values: Array::<felt>) {
        let mut idx: felt = 0;
        set_user_values_internal(account, idx, values);
    }

    //
    // Internal functions
    //
    fn set_user_values_internal(account: ContractAddress, mut idx: felt, mut values: Array::<felt>) {
        if !values.is_empty() {
            user_values::write((account, idx), values.pop_front().unwrap());
            idx = idx + 1;
            set_user_values_internal(account, idx, values);
        }
    }
}
