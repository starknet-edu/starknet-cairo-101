////////////////////////////////
// Ex11Base
// A contract from which other contracts can import functions
// such as `validate_exercise`, `distribute_points`
////////////////////////////////

#[contract]
mod Ex11Base {
    // Core Library Imports
    use starknet::get_caller_address;
    use integer::u128_from_felt252;
    use zeroable::Zeroable;
    use starknet::ContractAddress;
    use starknet::ContractAddressZeroable;
    use starknet::contract_address_to_felt252;
    use traits::Into;
    use traits::TryInto;
    use array::ArrayTrait;
    use option::OptionTrait;

    // Internal Imports
    use starknet_cairo_101::utils::Iplayers_registry::Iplayers_registryDispatcherTrait;
    use starknet_cairo_101::utils::Iplayers_registry::Iplayers_registryDispatcher;
    use starknet_cairo_101::token::ITDERC20::ITDERC20DispatcherTrait;
    use starknet_cairo_101::token::ITDERC20::ITDERC20Dispatcher;

    const Decimals: u128 = 1000000000000000000_u128;

    ////////////////////////////////
    // STORAGE
    ////////////////////////////////
    struct Storage {
        tderc20_address_storage: ContractAddress,
        players_registry_storage: ContractAddress,
        workshop_id_storage: u128,
        exercise_id_storage: u128,
        ex11_secret_value: u128,
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
    fn workshop_id() -> u128 {
        workshop_id_storage::read()
    }

    #[view]
    fn exercise_id() -> u128 {
        exercise_id_storage::read()
    }

    fn secret_value_internal() -> u128 {
        let secret_value = ex11_secret_value::read();
        // There is a trick here
        if (secret_value > 340282366920938463463374607431768211455_u128 - 42069_u128)
        {return secret_value - 42069_u128;}
        else
        {return secret_value + 42069_u128;}
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

    fn ex_initializer(_tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: u128, _exercise_id: u128) {
        tderc20_address_storage::write(_tderc20_address);
        players_registry_storage::write(_players_registry);
        workshop_id_storage::write(_workshop_id);
        exercise_id_storage::write(_exercise_id);
        ex11_secret_value::write(9811398123_u128); // wont be able to use contract address cause its cause u128_from OverFlow
    }

    //
    // Internal functions
    // These functions can not be called directly by a transaction
    // Similar to internal functions in Solidity
    //

    fn distribute_points(to: ContractAddress, amount: u128) {
        // We also add the required number of decimals
        let points_to_credit: u128 = amount * Decimals;
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

    fn validate_answers(sender_address: ContractAddress, secret_value_i_guess: u128, next_secret_value_i_chose: u128) {
        // CAREFUL THERE IS A TRAP FOR PEOPLE WHO WON'T READ THE CODE
        // This exercise looks like the previous one, but actually the view secret_value returns a different value than secret_value
        // Sending the wrong execution result will remove some of your points, then validate the exercise. You won't be able to get those points back later on!
        
        let fake_secret_value = secret_value_internal();
        // Laying our trap here
        if secret_value_i_guess == fake_secret_value {
            // We add the required number of decimals
            let points_to_remove: u128 = 2_u128 * Decimals;
            // # Retrieving contract address from storage
            let tderc20_address = tderc20_address_storage::read();
            // # Calling the ERC20 contract to remove points
            ITDERC20Dispatcher{contract_address: tderc20_address}
                .remove_points(sender_address, points_to_remove);
        } else {
            let secret_value = ex11_secret_value::read();
            if secret_value_i_guess == secret_value {
                assert(next_secret_value_i_chose != 0_u128, 'NEXT_SECRET_ZERO');
                ex11_secret_value::write(next_secret_value_i_chose);
            } else {
                let mut data = ArrayTrait::new();
                data.append('OOG');
                panic(data);
            }
        }
    }
}
