// ######## Ex 10
// # Composability
// In this exercise, you need to:
// - Use this contract to retrieve the address of contract ex10b.cairo, which holds the key to this exercise
// - Find the secret key in ex10b.cairo
// - Call claim_points() in this exercise with the secret value
// - Your points are credited by the contract

#[contract]
mod Ex10 {
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
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;

    use starknet_cairo_101::utils::Iex10b::Iex10bDispatcher;
    use starknet_cairo_101::utils::Iex10b::Iex10bDispatcherTrait;

    ////////////////////////////////
    // STORAGE
    ////////////////////////////////
    struct Storage {
        ex10b_address: ContractAddress,
        setup_is_finished: bool,
    }

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
    // View Functions
    ////////////////////////////////
    #[view]
    fn get_ex10b_address() -> ContractAddress {
        return ex10b_address::read();
    }

    ////////////////////////////////
    // EXTERNAL FUNCTIONS
    ////////////////////////////////

    #[external]
    fn claim_points(secret_value_i_guess: u128, next_secret_value_i_chose: u128) {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();

        // Retrieve secret value by READING
        let ex10b_addr = ex10b_address::read();

        let secret_value = Iex10bDispatcher{contract_address: ex10b_addr}.secret_value();
        assert(secret_value == secret_value_i_guess, 'NOT_EXPECTED_SECRET_VALUE');

        // choosing next secret_value for contract 10b. We don't want 0, it's not funny
        assert(next_secret_value_i_chose != 0_u128, 'SECRET_VALUE_IS_ZERO');

        Iex10bDispatcher{contract_address: ex10b_addr}.change_secret_value(next_secret_value_i_chose);

        // Checking if the user has validated the exercise before
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter
        distribute_points(sender_address, u256_from_felt252(2));
    }

    #[external]
    fn set_ex_10b_address(ex10b_addr: ContractAddress) {
        let is_setup = setup_is_finished::read();
        assert(is_setup == false, 'SETUP_FINISHED');
        ex10b_address::write(ex10b_addr);
        setup_is_finished::write(true);
    }

    #[external]
    fn update_class_hash(class_hash: felt252) {
        update_class_hash_by_admin(class_hash);
    }
}
