// ######## Ex 11
// # A contract from which other contracts can import functions

#[contract]
mod Ex11Base {
    // Core Library Imports
    use starknet::contract_address_try_from_felt;
    use integer::u256_from_felt;
    use array::ArrayTrait;
    use option::OptionTrait;

    // Internal Imports
    use starknet_cairo_101::utils::Iplayers_registry::Iplayers_registryDispatcher;
    use starknet_cairo_101::token::ITDERC20::ITDERC20Dispatcher;


    struct Storage {
        tderc20_address_storage: felt,
        players_registry_storage: felt,
        workshop_id_storage: felt,
        exercise_id_storage: felt,
        ex11_secret_value: felt,
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
    fn secret_value() -> felt {
        let secret_value = ex11_secret_value::read();
        // There is a trick here
        return secret_value + 42069;
    }

    #[view]
    fn has_validated_exercise(account: felt) -> felt {
        // reading player registry
        let _players_registry = players_registry_storage::read();
        let _workshop_id = workshop_id_storage::read();
        let _exercise_id = exercise_id_storage::read();

        // Checking if the user already validated this exercise
        Iplayers_registryDispatcher::has_validated_exercise(
            address, account, _workshop_id, _exercise_id
        )
    }

    //
    // Internal constructor
    // This function is used to initialize the contract. It can be called from the constructor
    //

    fn ex_initializer(
        _tderc20_address: felt, _players_registry: felt, _workshop_id: felt, _exercise_id: felt
    ) {
        tderc20_address_storage::write(_tderc20_address);
        players_registry_storage::write(_players_registry);
        workshop_id_storage::write(_workshop_id);
        exercise_id_storage::write(_exercise_id);
        ex11_secret_value::write(_tderc20_address);
    }

    //
    // Internal functions
    // These functions can not be called directly by a transaction
    // Similar to internal functions in Solidity
    //

    fn distribute_points(to: felt, amount: u256) {
        // Converting felt to uint256. We assume it's a small number
        // We also add the required number of decimals
        let points_to_credit: u256 = amount * u256_from_felt(1000000000000000000);
        // Retrieving contract address from storage
        let contract_address = tderc20_address_storage::read();

        let address = match contract_address_try_from_felt(contract_address) {
            Option::Some(address) => address,
            Option::None(()) => {
                // TODO (Omar): add adequate error message
                return ();
            },
        };

        // Calling the ERC20 contract to distribute points
        ITDERC20Dispatcher::distribute_points(address, to, points_to_credit);
    }

    fn validate_exercise(account: felt) {
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
        let has_current_user_validated_exercise =
            Iplayers_registryDispatcher::has_validated_exercise(
            address, account, _workshop_id, _exercise_id,
        );
        assert(has_current_user_validated_exercise == 0, 'Exercise previously validated');
        Iplayers_registryDispatcher::validate_exercise(
            address, account, _workshop_id, _exercise_id,
        );
    }

    fn validate_answers(sender_address: felt, secret_value_i_guess: felt, next_secret_value_i_chose: felt){
        // CAREFUL THERE IS A TRAP FOR PEOPLE WHO WON'T READ THE CODE
        // This exercise looks like the previous one, but actually the view secret_value returns a different value than secret_value
        // Sending the wrong execution result will remove some of your points, then validate the exercise. You won't be able to get those points back later on!
        let secret_value = ex11_secret_value::read();
        let diff = secret_value_i_guess - secret_value;
        // Laying our trap here
        if diff == 42069 {
            // Converting felt to uint256. We assume it's a small number
            // We also add the required number of decimals
            let points_to_remove: u256 = u256_from_felt(2 * 1000000000000000000);
            // # Retrieving contract address from storage
            let contract_address = tderc20_address_storage::read();
            let address = match contract_address_try_from_felt(contract_address) {
                Option::Some(address) => address,
                Option::None(()) => {
                    // TODO (Omar): add adequate error message
                    return ();
                },
            };

            // # Calling the ERC20 contract to remove points
            ITDERC20Dispatcher::remove_points(address, sender_address, points_to_remove);
        } else {
            // If secret value is correct, set new secret value
            if (diff == 0) {
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
