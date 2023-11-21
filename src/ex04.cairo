////////////////////////////////
// Exercise 4
// Reading a mapping
////////////////////////////////
// In this exercise, you need to:
// - Follow this contract's claim_points() function to understand how to finish the exercise
// - Use a function to show you know the correct value of the value in the mapping
// - Use this contract's claim_points() function with a specific argument
// - Your points are credited by the contract if you send the correct value
// What you will learn:
// - How to use a function to read a value in a mapping where the slot you read is the value from the first call
////////////////////////////////

use starknet::ContractAddress;

#[starknet::interface]
trait Ex04Trait<TContractState> {
    fn get_user_slots(self: @TContractState, account: ContractAddress) -> u128;
    fn get_values_mapped(self: @TContractState, slot: u128) -> u128;

    fn claim_points(ref self: TContractState, expected_value: u128);
    fn assign_user_slot(ref self: TContractState);
    fn update_class_hash(ref self: TContractState, class_hash: felt252);
    fn set_random_values(ref self: TContractState, values: Array::<u128>);
}

#[starknet::contract]
mod Ex04 {
    ////////////////////////////////
    // Core Library imports
    // These are syscalls and functionalities that allow you to write Starknet contracts
    ////////////////////////////////
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use array::ArrayTrait;
    use option::OptionTrait;

    ////////////////////////////////
    // Internal imports
    // These functions become part of the set of functions of the contract
    ////////////////////////////////
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;
    use starknet_cairo_101::utils::helper;

    ////////////////////////////////
    // Storage
    // In Cairo 1, storage is declared in a struct
    // Storage is not visible by default through the ABI
    ////////////////////////////////
    #[storage]
    struct Storage {
        user_slots: LegacyMap::<ContractAddress, u128>,
        values_mapped: LegacyMap::<u128, u128>,
        was_initialized: bool,
        next_slot: u128,
    }

    ////////////////////////////////
    // Constructor
    // This function (indicated with #[constructor]) is called when the contract is deployed and is used to initialize the contract's state
    ////////////////////////////////
    #[constructor]
    fn constructor(
        ref self: ContractState, _tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: u128, _exercise_id: u128
    ) {
        self.ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    }

    #[external(v0)]
    impl Ex04Impl of super::Ex04Trait<ContractState> {
        ////////////////////////////////
        // View Functions
        // Public variables should be declared explicitly with a getter function (indicated with #[view]) to be visible through the ABI and callable from other contracts
        ////////////////////////////////
        fn get_user_slots(self: @ContractState, account: ContractAddress) -> u128 {
            return self.user_slots.read(account);
        }

        fn get_values_mapped(self: @ContractState, slot: u128) -> u128 {
            return self.values_mapped.read(slot);
        }

        ////////////////////////////////
        // External functions
        // These functions are callable by other contracts or external calls such as DAPP, which are indicated with #[external] (similar to "public" in Solidity)
        ////////////////////////////////
        fn claim_points(ref self: ContractState, expected_value: u128) {
            // Reading caller address
            let sender_address: ContractAddress = get_caller_address();
            // Reading the slot assigned to the caller address in the mapping user_slots.
            // The value was assigned when assign_user_slot() was called by the user (see below) and is stored in the mapping user_slots
            let user_slot = self.user_slots.read(sender_address);
            // Checking that the user has a slot assigned to they (i.e. that he called assign_user_slot() before)
            assert(user_slot != 0_u128, 'ASSIGN_USER_SLOT_FIRST');

            // Checking that the value provided by the caller is the one we expect
            // Yes, I'm sneaky
            let value = self.values_mapped.read(user_slot);
            assert(value == expected_value + 32_u128, 'NOT_EXPECTED_SECRET_VALUE');

            // Checking if the user has validated the exercise before
            self.validate_exercise(sender_address);
            // Sending points to the address specified as parameter
            self.distribute_points(sender_address, 2_u128);
        }

        // This function is used to assign a slot to a user and to update the next slot
        fn assign_user_slot(ref self: ContractState) {
            // Reading caller address
            let sender_address: ContractAddress = get_caller_address();
            // Its value can change during the course of the function call
            let next_value = self.values_mapped.read(self.next_slot.read() + 1_u128);
            // Checking if next random value is 0
            if next_value == 0_u128 {
                self.next_slot.write(0_u128);
            }
            self.user_slots.write(sender_address, self.next_slot.read() + 1_u128);
            self.next_slot.write(self.next_slot.read() + 1_u128);
        }

        ////////////////////////////////
        // External functions - Administration
        // Only admins can call these. You don't need to understand them to finish the exercise.
        ////////////////////////////////
        fn update_class_hash(ref self: ContractState, class_hash: felt252) {
            self.update_class_hash_by_admin(class_hash);
        }

        fn set_random_values(ref self: ContractState, values: Array::<u128>) {
            // Check if the random values were already initialized
            let was_initialized_read = self.was_initialized.read();
            assert(was_initialized_read != true, 'NOT_INITIALISED');

            let mut idx: u128 = 0_u128;
            self.set_a_random_value(idx, values);

            // Mark that value store was initialized
            self.was_initialized.write(true);
        }
    }

    #[generate_trait]
    impl InternalImpl<ContractState> of InternalTrait<ContractState> {
        fn set_a_random_value(ref self: ContractState, mut idx: u128, mut values: Array::<u128>) {
            helper::check_gas();

            if !values.is_empty() {
                self.values_mapped.write(idx, values.pop_front().unwrap());
                idx = idx + 1_u128;
                self.set_a_random_value(idx, values);
            }
        }
    }

}
