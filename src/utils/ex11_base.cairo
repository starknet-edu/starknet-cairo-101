// ######## Ex 11
// # A contract from which other contracts can import functions

#[contract]
mod Ex11Base {
    // Core Library Imports
    use starknet::get_caller_address;
    use integer::u256_from_felt;
    use zeroable::Zeroable;
    use starknet::ContractAddressZeroable;
    use starknet::ContractAddressIntoFelt;
    use starknet::FeltTryIntoContractAddress;
    use starknet::contract_address_to_felt;
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

    const Decimals: felt = 1000000000000000000;

    ////////////////////////////////
    // STORAGE
    ////////////////////////////////
    struct Storage {
        tderc20_address_storage: ContractAddress,
        players_registry_storage: ContractAddress,
        workshop_id_storage: felt,
        exercise_id_storage: felt,
        ex11_secret_value: felt,
    }

    ////////////////////////////////
    // View Functions
    ////////////////////////////////
    #[view]
    fn tderc20_address() -> ContractAddress {
        tderc20_address_storage::read()
    }

    #[view]
    fn players_registry() -> ContractAddress {
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
    fn secret_value() -> felt {
        let secret_value = ex11_secret_value::read();
        // There is a trick here
        return secret_value + 42069;
    }

    #[view]
    fn has_validated_exercise(account: ContractAddress) -> bool {
        // reading player registry
        let players_registry = players_registry_storage::read();
        let workshop_id = workshop_id_storage::read();
        let exercise_id = exercise_id_storage::read();

        // Checking if the user already validated this exercise
        Iplayers_registryDispatcher{contract_address: players_registry}
            .has_validated_exercise(account, workshop_id, exercise_id)
    }

    //
    // Internal constructor
    // This function is used to initialize the contract. It can be called from the constructor
    //

    fn ex_initializer(_tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: felt, _exercise_id: felt) {
        tderc20_address_storage::write(_tderc20_address);
        players_registry_storage::write(_players_registry);
        workshop_id_storage::write(_workshop_id);
        exercise_id_storage::write(_exercise_id);
        ex11_secret_value::write(contract_address_to_felt(_tderc20_address));
    }

    //
    // Internal functions
    // These functions can not be called directly by a transaction
    // Similar to internal functions in Solidity
    //

    fn distribute_points(to: ContractAddress, amount: u256) {
        // Converting felt to uint256. We assume it's a small number
        // We also add the required number of decimals
        let points_to_credit: u256 = amount * u256_from_felt(Decimals);
        // Retrieving contract address from storage
        let tderc20_address = tderc20_address_storage::read();
        // Calling the ERC20 contract to distribute points
        ITDERC20Dispatcher{contract_address: tderc20_address}
            .distribute_points(to, points_to_credit);
    }

    fn validate_exercise(account: ContractAddress) {
        // reading player registry
        let _players_registry = players_registry_storage::read();
        let _workshop_id = workshop_id_storage::read();
        let _exercise_id = exercise_id_storage::read();

        let has_validated_exercise = Iplayers_registryDispatcher{contract_address: _players_registry}
            .has_validated_exercise(account, _workshop_id, _exercise_id);

        assert(has_validated_exercise == false, 'Exercise previously validated');

        Iplayers_registryDispatcher{contract_address: _players_registry}
            .validate_exercise(account, _workshop_id, _exercise_id);
    }

    fn validate_answers(sender_address: ContractAddress, secret_value_i_guess: felt, next_secret_value_i_chose: felt) {
        // CAREFUL THERE IS A TRAP FOR PEOPLE WHO WON'T READ THE CODE
        // This exercise looks like the previous one, but actually the view secret_value returns a different value than secret_value
        // Sending the wrong execution result will remove some of your points, then validate the exercise. You won't be able to get those points back later on!
        let secret_value = ex11_secret_value::read();
        let diff = secret_value_i_guess - secret_value;
        // Laying our trap here
        if diff == 42069 {
            // Converting felt to uint256. We assume it's a small number
            // We also add the required number of decimals
            let points_to_remove: u256 = u256_from_felt(2 * Decimals);
            // # Retrieving contract address from storage
            let tderc20_address = tderc20_address_storage::read();
            // # Calling the ERC20 contract to remove points
            ITDERC20Dispatcher{contract_address: tderc20_address}
                .remove_points(sender_address, points_to_remove);
        } else {
            // If secret value is correct, set new secret value
            if diff == 0 {
                assert(next_secret_value_i_chose != 0, 'NEXT_SECRET_ZERO');
                ex11_secret_value::write(next_secret_value_i_chose);
            } else {
                let mut data = ArrayTrait::new();
                data.append('OOG');
                panic(data);
            }
        }
    }
}
