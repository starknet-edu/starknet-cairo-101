// ######## Ex 00
// # A contract from which other contracts can import functions

// TODO(Omar): import interfaces ITDERC20 and Iplayers_registry 

#[contract]
mod Ex00Base {
    // use starknet::ContractAddress;
    use starknet::contract_address_try_from_felt;

    struct Storage {
        tderc20_address_storage: felt,
        players_registry_storage: felt,
        workshop_id_storage: felt,
        exercise_id_storage: felt,
    }

    #[view]
    fn tderc20_address() -> felt {
        tderc20_address_storage::read()
    }

    #[view]
    fn players_registry() -> felt {
        players_registry_storage::read()
    }

    #[view]
    fn workshop_id() -> felt {
        workshop_id_storage::read()
    }

    #[view]
    fn exercise_id() -> felt {
        exercise_id_storage::read()
    }

    #[view]
    fn has_validated_exercise(account: felt) -> felt {
        // reading player registry
        let _players_registry = players_registry_storage::read();
        let _workshop_id = workshop_id_storage::read();
        let _exercise_id = exercise_id_storage::read();
        // Checking if the user already validated this exercise
        let address = match contract_address_try_from_felt(_players_registry) {
            Option::Some(address) => address,
            Option::None(()) => {
                // TODO (Omar): add adequate error message
                return 1;
            },
        };
        super::Iplayers_registryDispatcher::has_validated_exercise(
            address,
            account,
            _workshop_id,
            _exercise_id
        )   
    }

    //
    // Internal constructor
    // This function is used to initialize the contract. It can be called from the constructor
    //

    #[constructor]
    fn ex_initializer(
        _tderc20_address: felt, _players_registry: felt, _workshop_id: felt, _exercise_id: felt
    ) {
        tderc20_address_storage::write(_tderc20_address);
        players_registry_storage::write(_players_registry);
        workshop_id_storage::write(_workshop_id);
        exercise_id_storage::write(_exercise_id);
    }

    //
    // Internal functions
    // These functions can not be called directly by a transaction
    // Similar to internal functions in Solidity
    //

    fn distribute_points(
        to: felt, amount: u256
    ) {
        // Retrieving contract address from storage
        let _contract_address = tderc20_address_storage::read();
        // Calling the ERC20 contract to distribute points
        let address = match contract_address_try_from_felt(_contract_address) {
            Option::Some(address) => address,
            Option::None(()) => {
                // TODO (Omar): add adequate error message
                return ();
            },
        };
        super::ITDERC20Dispatcher::distribute_points(address, to, amount);
    }

    fn validate_exercise(
        account: felt
    ) {
        // reading player registry
        let _players_registry = players_registry_storage::read();
        let _workshop_id = workshop_id_storage::read();
        let _exercise_id = exercise_id_storage::read();
        // Checking if the user already validated this exercise
        let address = match contract_address_try_from_felt(_players_registry) {
            Option::Some(address) => address,
            Option::None(()) => {
                // TODO (Omar): add adequate error message
                return ();
            },
        };
        let has_current_user_validated_exercise = super::Iplayers_registryDispatcher::has_validated_exercise(
            address,
            account,
            _workshop_id,
            _exercise_id,
        );
        assert(has_current_user_validated_exercise == 0, 'Ex00Base: User validated the exercise previously');
        super::Iplayers_registryDispatcher::validate_exercise(
            address,
            account,
            _workshop_id,
            _exercise_id,
        );
    }
}
