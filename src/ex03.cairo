// ######## Ex 03
// Using contract functions to manipulate contract variables
// In this exercise, you need to:
// - Use this contract's functions in order to manipulate an internal counter unique to your address
// - Once this counter reaches a certain value, call a specific function
// - Your points are credited by the contract

// # What you'll learn
// - How to declare mappings
// - How to read and write to mappings
// - How to use a function to manipulate storage variables

#[contract]
mod Ex03 {
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

    // Internal Imports
    use starknet_cairo_101::utils::ex00_base::Ex00Base::tderc20_address;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::has_validated_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;

    ////////////////////////////////
    // STORAGE
    ////////////////////////////////

    struct Storage {
        user_counters: LegacyMap::<felt, felt>,
    }

    ////////////////////////////////
    // Constructor
    ////////////////////////////////
    #[constructor]
    fn constructor(_tderc20_address: felt, _players_registry: felt, _workshop_id: felt, _exercise_id: felt) {
        ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    }

    ////////////////////////////////
    // VIEW FUNCTIONS
    // Declaring getters for our mappings. It takes one argument as a parameter, the account you wish to read the counter of
    ////////////////////////////////
    #[view]
    fn get_user_counters(account: felt) -> felt {
        let user_counter = user_counters::read(account);
        user_counter
    }

    ////////////////////////////////
    // EXTERNAL FUNCTIONS
    ////////////////////////////////
    #[external]
    fn claim_points() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        assert(!sender_address.is_zero(), 'sender_address is empty!');
        // Checking that user's counter is equal to 7
        let current_counter_value = user_counters::read(sender_address.into());
        assert (current_counter_value == 7, 'Counter is not equal to 7');

        // Checking if the user has validated the exercise before
        validate_exercise(sender_address.into());
        // Sending points to the address specified as parameter
        distribute_points(sender_address.into(), u256_from_felt(2));
    }

    #[external]
    fn reset_counter() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Reinitializing the user counter
        user_counters::write(sender_address.into(), 0);
    }

    #[external]
    fn increment_counter() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Reading counter from storage
        let current_counter_value = user_counters::read(sender_address.into());
        // Writing updated value to storage
        user_counters::write(sender_address.into(), current_counter_value + 2);
    }

    #[external]
    fn decrement_counter() {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();
        // Reading counter from storage
        let current_counter_value = user_counters::read(sender_address.into());
        // Writing updated value to storage
        user_counters::write(sender_address.into(), current_counter_value -1);
    }
}