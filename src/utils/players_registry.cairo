// ######## Ex 00
// # A contract from which other contracts can import functions

#[contract]
mod PlayersRegistry {
    // Core Library Imports
    use starknet::get_caller_address;
    use starknet::contract_address_to_felt;
    use integer::u256_from_felt;
    use zeroable::Zeroable;
    use starknet::ContractAddressZeroable;
    use starknet::ContractAddressIntoFelt;
    use starknet::FeltTryIntoContractAddress;
    use starknet::contract_address_try_from_felt;
    use traits::Into;
    use traits::TryInto;
    use array::ArrayTrait;
    use option::OptionTrait;

    // Internal Imports
    use starknet_cairo_101::utils::Iplayers_registry::Iplayers_registryDispatcherTrait;
    use starknet_cairo_101::utils::Iplayers_registry::Iplayers_registryDispatcher;
    use starknet_cairo_101::token::ITDERC20::ITDERC20DispatcherTrait;
    use starknet_cairo_101::token::ITDERC20::ITDERC20Dispatcher;
    use starknet_cairo_101::utils::corelib_extension::FeltTriplet;

    ////////////////////////////////
    // STORAGE
    ////////////////////////////////
    struct Storage {
        has_validated_exercise_storage: LegacyMap::<(ContractAddress, felt, felt), bool>,
        exercises_and_admins_accounts: LegacyMap::<ContractAddress, bool>,
        next_player_rank: felt,
        players_registry: LegacyMap::<felt, ContractAddress>,
        players_ranks_storage: LegacyMap::<ContractAddress, felt>,
    }

    ////////////////////////////////
    // View Functions
    ////////////////////////////////
    #[view]
    fn has_validated_exercise(account: ContractAddress, workshop: felt, exercise: felt) -> bool {
        has_validated_exercise_storage::read((account, workshop, exercise))
    }

    #[view]
    fn is_exercise_or_admin(account: ContractAddress) -> bool {
        exercises_and_admins_accounts::read(account)
    }

    #[view]
    fn get_next_player_rank() -> felt {
        next_player_rank::read()
    }

    #[view]
    fn get_players_registry(rank: felt) -> ContractAddress {
        players_registry::read(rank)
    }

    #[view]
    fn players_ranks(account: ContractAddress) -> felt {
        players_ranks_storage::read(account)
    }

    ////////////////////////////////
    // Events
    ////////////////////////////////
    #[event]
    fn Modificate_Exercise_Or_Admin(account: ContractAddress, permission: bool) {}

    #[event]
    fn New_Player(account: ContractAddress, rank: felt) {}

    #[event]
    fn New_Validation(account: ContractAddress, workshop: felt, exercise: felt) {}

    ////////////////////////////////
    // Constructor
    ////////////////////////////////
    #[constructor]
    fn constructor(first_admin: ContractAddress) {
        exercises_and_admins_accounts::write(first_admin, true);
        Modificate_Exercise_Or_Admin(first_admin, true);
        next_player_rank::write(1);
    }

    ////////////////////////////////
    // External Functions
    ////////////////////////////////
    #[external]
    fn set_exercise_or_admin(account: ContractAddress, permission: bool) {
        only_exercise_or_admin();
        exercises_and_admins_accounts::write(account, permission);
        Modificate_Exercise_Or_Admin(account, permission);
    }

    #[external]
    fn validate_exercise(account: ContractAddress, workshop: felt, exercise: felt) {
        only_exercise_or_admin();
        // Checking if the user already validated this exercise
        let is_validated = has_validated_exercise_storage::read(
            (account, workshop, exercise)
        );

        assert(is_validated == false, 'USER_VALIDATED');

        // Marking the exercise as completed
        has_validated_exercise_storage::write((account, workshop, exercise), true);
        New_Validation(account, workshop, exercise);

        // Recording player if he is not yet recorded
        let player_rank: felt = players_ranks_storage::read(account);

        if player_rank == 0 {
            // Player is not yet record, let's record
            let next_player_rank: felt = next_player_rank::read();
            players_registry::write(next_player_rank, account);
            players_ranks_storage::write(account, next_player_rank);

            let next_player_rank_plus_one = next_player_rank + 1;
            next_player_rank::write(next_player_rank_plus_one);

            New_Player(account, next_player_rank);
        }
    }

    ////////////////////////////////
    // Internal Functions
    ////////////////////////////////
    fn only_exercise_or_admin() {
        let caller: ContractAddress = get_caller_address();
        let permission: bool = exercises_and_admins_accounts::read(caller);
        assert (permission == true, 'You dont have permission.');
    }

}