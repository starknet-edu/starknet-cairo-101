////////////////////////////////
// Exercise 10a
// Composability
////////////////////////////////
// - Use this contract to retrieve the address of contract ex10b.cairo, which holds the key to this exercise
// - Find the secret key in ex10b.cairo
// - Call claim_points() in this exercise with the secret value
// - Your points are credited by the contract
////////////////////////////////

use starknet::ContractAddress;

#[starknet::interface]
trait Ex10Trait<T> {
    fn get_ex10b_address(self: @T) -> ContractAddress;
    fn claim_points(ref self: T, secret_value_i_guess: u128, next_secret_value_i_chose: u128);
    fn update_class_hash(ref self: T, class_hash: felt252);
    fn set_ex_10b_address(ref self: T, ex10b_addr: ContractAddress);
}

#[starknet::contract]
mod Ex10 {
    ////////////////////////////////
    // Core Library imports
    // These are syscalls and functionalities that allow you to write starknet contracts
    ////////////////////////////////
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use array::ArrayTrait;
    use option::OptionTrait;

    ////////////////////////////////
    // Internal imports
    // These functions become part of the set of functions of the current contract
    ////////////////////////////////
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;
    use starknet_cairo_101::utils::Iex10b::Iex10bDispatcher;
    use starknet_cairo_101::utils::Iex10b::Iex10bDispatcherTrait;

    ////////////////////////////////
    // Storage
    // Storage is not visible by default through the ABI
    ////////////////////////////////
    #[storage]
    struct Storage {
        ex10b_address: ContractAddress,
        setup_is_finished: bool,
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
    impl Ex10Impl of super::Ex10Trait<ContractState> {
        ////////////////////////////////
        // View Functions
        // Public variables should be declared explicitly with a getter function (indicated with #[view]) to be visible through the ABI and callable from other contracts
        ////////////////////////////////
        fn get_ex10b_address(self: @ContractState) -> ContractAddress {
            return self.ex10b_address.read();
        }

        ////////////////////////////////
        // External functions
        // These functions are callable by other contracts or external calls such as DAPP, which are indicated with #[external] (similar to "public" in Solidity)
        ////////////////////////////////
        fn claim_points(ref self: ContractState, secret_value_i_guess: u128, next_secret_value_i_chose: u128) {
            // Reading caller address
            let sender_address: ContractAddress = get_caller_address();

            // Retrieve secret value by READING
            let ex10b_addr = self.ex10b_address.read();

            let secret_value = Iex10bDispatcher{contract_address: ex10b_addr}.get_secret_value();
            assert(secret_value == secret_value_i_guess, 'NOT_EXPECTED_SECRET_VALUE');

            // choosing next secret_value for contract 10b. We don't want 0, it's not funny
            assert(next_secret_value_i_chose != 0_u128, 'SECRET_VALUE_IS_ZERO');

            Iex10bDispatcher{contract_address: ex10b_addr}.change_secret_value(next_secret_value_i_chose);

            // Checking if the user has validated the exercise before
            self.validate_exercise(sender_address);
            // Sending points to the address specified as parameter
            self.distribute_points(sender_address, 2_u128);
        }

        ////////////////////////////////
        // External functions - Administration
        // Only admins can call these. You don't need to understand them to finish the exercise.
        ////////////////////////////////
        fn update_class_hash(ref self: ContractState, class_hash: felt252) {
            self.update_class_hash_by_admin(class_hash);
        }

        fn set_ex_10b_address(ref self: ContractState, ex10b_addr: ContractAddress) {
            let is_setup = self.setup_is_finished.read();
            assert(is_setup == false, 'SETUP_FINISHED');
            self.ex10b_address.write(ex10b_addr);
            self.setup_is_finished.write(true);
        }
    }
}
