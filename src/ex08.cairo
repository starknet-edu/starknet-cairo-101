////////////////////////////////    
// Exercise 8
// Recursions - basics
////////////////////////////////
// TODO (omar): Add a description of the exercise
// - Use this contract's claim_points() function
// - Your points are credited by the contract
////////////////////////////////


#[contract]
mod Ex08 {
    ////////////////////////////////    
    // Starknet core library imports
    // These are syscalls and functionnalities that allow you to write starknet contracts
    ////////////////////////////////
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use traits::Into;
    use traits::TryInto;
    use array::ArrayTrait;
    use option::OptionTrait;
    use integer::u256_from_felt252;
    use hash::LegacyHash;

    ////////////////////////////////
    // Internal imports
    // These function become part of the set of function of the current contract
    ////////////////////////////////  
    use starknet_cairo_101::utils::ex00_base::Ex00Base::has_validated_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;

    use core::hash::TupleSize2LegacyHash;

    ////////////////////////////////
    // Storage
    // In Cairo 1, storage is declared in a struct
    // Storage is not visible by default through the ABI
    ////////////////////////////////
    struct Storage {
        user_values: LegacyMap::<(ContractAddress, u128), u128>
    }

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
    // View Functions
    // Public variables should be declared explicitly with a getter function (indicated with #[view]) to be visible through the ABI and callable from other contracts
    ////////////////////////////////
    #[view]
    fn get_user_values(account: ContractAddress, slot: u128) -> u128 {
        return user_values::read((account, slot));
    }

    ////////////////////////////////
    // External functions
    // These functions are callable by other contracts and are indicated with #[external] (similar to "public" in Solidity)
    ////////////////////////////////
    #[external]
    fn claim_points() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        let user_value_at_slot_ten = user_values::read((sender_address, 10_u128));
        assert(user_value_at_slot_ten == 10_u128, 'USER_VALUE_NOT_10');

        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, u256_from_felt252(2));
    }

    ////////////////////////////////
    // Internal functions
    // These functions are not callable by other contracts (similar to "private" in Solidity)
    ////////////////////////////////
    fn set_user_values_internal(account: ContractAddress, mut idx: u128, mut values: Array::<u128>) {
        if !values.is_empty() {
            user_values::write((account, idx), values.pop_front().unwrap());
            idx = idx + 1_u128;
            set_user_values_internal(account, idx, values);
        }
    }

    ////////////////////////////////
    // External functions - Administration
    // Only admins can call these. You don't need to understand them to finish the exercise.
    ////////////////////////////////

    // This function takes an array as a parameter
    // In order to pass it, the user needs to pass both the array and its length
    // This complexity is abstracted away by voyager, where you simply need to pass an array
    #[external]
    fn set_user_values(account: ContractAddress, values: Array::<u128>) {
        let mut idx = 0_u128;
        set_user_values_internal(account, idx, values);
    }

    #[external]
    fn update_class_hash(class_hash: felt252) {
        update_class_hash_by_admin(class_hash);
    }
}
