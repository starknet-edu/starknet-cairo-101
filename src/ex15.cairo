////////////////////////////////
// Exercise 15
// Structs and native types
////////////////////////////////
// In this exercise, you need to:
// - Get the information of the previous user (address, lucky value, short string and was happy value)
// - Create a struct called "User" with the information of the previous user
// - Use the create_struct_with_your_info() function to create a new User struct with your info so the next user can continue playing
// - Your points are credited by the contract when you call the claim_points function with the correct struct
// What you will learn:
// - How to interact with structs and native types
////////////////////////////////

use starknet::StorageAccess;
use starknet::SyscallResult;
use starknet::ContractAddress;
use starknet::StorageBaseAddress;
use traits::TryInto;
use option::OptionTrait;
use traits::Into;

struct User {
    player_address: ContractAddress, // User address with the type ContractAddress
    player_lucky_value: u8, // User lucky value with the type u8
    player_short_string: felt252, // User short string with the type felt252
    player_was_happy: bool, // User happiness value with the type bool
}

impl StorageAccessUser of StorageAccess<User> {
    fn read(address_domain: u32, base: StorageBaseAddress) -> SyscallResult<User> {
        Result::Ok(
            StorageAccess::<felt252>::read(
                address_domain, base
            )?.try_into().expect('StorageAccessUser - non User')
        )
    }
    #[inline(always)]
    fn write(address_domain: u32, base: StorageBaseAddress, value: User) -> SyscallResult<()> {
        StorageAccess::<felt252>::write(address_domain, base, value.into())
    }
}


#[contract]
mod Ex15 {
    ////////////////////////////////
    // Core Library imports
    // These are syscalls and functionalities that allow you to write Starknet contracts
    ////////////////////////////////
    use starknet::get_caller_address;
    use starknet::ContractAddress;

    ////////////////////////////////
    // Internal imports
    // These functions become part of the set of functions of the contract
    ////////////////////////////////
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;

    ////////////////////////////////
    // Storage
    // In Cairo 1, storage is declared in a struct
    // Storage is not visible by default through the ABI
    ////////////////////////////////
    struct Storage {
        current_slot: u128,
        // Map between slot and user
        players: LegacyMap<u128, super::super::User>,
        // The info you chose for the previous user
        chosen_previous_user_info: LegacyMap<ContractAddress, super::super::User>,
    }

    // struct User {
    //     player_address: ContractAddress, // User address with the type ContractAddress
    //     player_lucky_value: u8, // User lucky value with the type u8
    //     player_short_string: felt252, // User short string with the type felt252
    //     player_was_happy: bool, // User happiness value with the type bool
    // }

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
    // Public variables should be declared explicitly with a getter function (indicated with #[view]) to be visible through the ABI and callable from other contracts or DAPP
    ////////////////////////////////

    // This function returns the slot of the previous player
    #[view]
    fn get_previous_user_slot() -> u128 {
        current_slot::read() - 1_u128
    }

    // Return the address, lucky value, short string and was happy value of the user in the previous slot
    #[view]
    fn get_previous_user_info_by_slot (previous_user_slot: u128) -> (ContractAddress, u8, felt252, bool) {
        let previous_user : super::User = players::read(previous_user_slot);
        (previous_user.player_address, previous_user.player_lucky_value, previous_user.player_short_string, previous_user.player_was_happy)
    }

    ////////////////////////////////
    // External functions
    // These functions are callable by other contracts or external calls such as DAPP, which are indicated with #[external] (similar to "public" in Solidity)
    ////////////////////////////////

    #[external]
    fn create_struct_with_the_previous_user_info(contract_address: ContractAddress, lucky_value: u8, short_string: felt252, you_happy: bool) {
        // Creating a new user struct
        let new_user = super::User {
            player_address: contract_address, // Previous user address
            player_lucky_value: lucky_value, // Previous user lucky value
            player_short_string: short_string, // Previous user short string
            player_was_happy: you_happy, // previous user was happy value, should be "true" or "false"
        };

        // Get caller address
        let sender_address: ContractAddress = get_caller_address();

        // Write your selection of values for the previous user to the chosen_previous_user_info mapping
        chosen_previous_user_info::write(sender_address, new_user);
    }

    // This function creates a new user struct and writes it to the players mapping
    #[external]
    fn create_struct_with_your_info(lucky_value_from_1_to_10: u8, short_string: felt252, you_happy: bool) {
        // Reading caller address
        let sender_address: ContractAddress = get_caller_address();

        // Creating a new user struct
        let new_user = super::User {
            player_address: sender_address, // User address of type ContractAddress
            player_lucky_value: lucky_value_from_1_to_10, // Answer should be a number between 1 and 10
            player_short_string: short_string, // Answer should be a string of 10 characters or less
            player_was_happy: you_happy, // Answer should be "true" or "false", are you happy?
        };

        // Writing the new user struct to the players mapping
        players::write(current_slot::read(), new_user);
    }

    #[external]
    fn claim_points(expected_value: u128) {
        // Reading caller address
        let sender_address = get_caller_address();
        // Reading the guessed previous user info from storage
        let chosen_previous_player_info = chosen_previous_user_info::read(sender_address);
        // Reading the actual previous user info from storage
        let previous_player_slot = get_previous_user_slot();
        let (previous_player_address, previous_player_lucky_value, previous_player_short_string, previous_player_was_happy) = get_previous_user_info_by_slot(previous_player_slot);
        // Checking that the user has guessed the previous user info correctly using the assert function
        assert(chosen_previous_player_info.player_address == previous_player_address, 'Wrong address');
        assert(chosen_previous_player_info.player_lucky_value == previous_player_lucky_value, 'Wrong lucky value');
        assert(chosen_previous_player_info.player_short_string == previous_player_short_string, 'Wrong short string');
        assert(chosen_previous_player_info.player_was_happy == previous_player_was_happy, 'Wrong hapiness value');
        // Making sure has created a new user struct with his own values using the create_struct_with_your_info function 
        assert(players::read(current_slot::read()).player_address == sender_address, 'No new User struct created');
        // Update the slot to the next one. By this point, the user has validated the exercise and can claim points 
        current_slot::write(current_slot::read() + 1_u128);
        // Checking if the user has validated the exercise before sending points using the validate_exercise function from the Ex00Base contract
        validate_exercise(sender_address);
        // Sending points to the address specified as parameter using the distribute_points function from the Ex00Base contract
        distribute_points(sender_address, 2_u128);
    }

    ////////////////////////////////
    // External functions - Administration
    // Only admins can call these. You don't need to understand them to finish the exercise.
    ////////////////////////////////
    #[external]
    fn update_class_hash(class_hash: felt252) {
        update_class_hash_by_admin(class_hash);
    }
}
