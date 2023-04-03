////////////////////////////////
// Exercise: Enums
////////////////////////////////
// In this exercise, you need to:
// - Follow this contract's claim_points() function to understand how to finish the exercise
// - Use a function to get assigned a random color (represented by an enum so the set of possible colors is limited)
// - Use a function to submit your guess for the assigned color
// - If your guess is correct, the contract will credit you with points
// What you will learn:
// - How to interact with enums in Cairo
////////////////////////////////

#[contract]
mod Ex16 {
    // Core Library imports
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use array::ArrayTrait;
    use option::OptionTrait;

    // Internal imports
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;
    use starknet_cairo_101::utils::helper;

    // Enums
    enum Color {
        Red: u8,
        Green: u8,
        Blue: u8,
        Yellow: u8,
    }

    // Storage
    struct Storage {
        user_colors: LegacyMap::<ContractAddress, Color>,
        user_guesses: LegacyMap::<ContractAddress, Color>,
        was_initialized: bool,
    }

    // Constructor
    #[constructor]
    fn constructor(
        _tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: u128, _exercise_id: u128
    ) {
        ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    }

    // View Functions
    #[view]
    fn get_user_colors(account: ContractAddress) -> Color {
        user_colors::read(account)
    }

    #[view]
    fn get_user_guesses(account: ContractAddress) -> Color {
        user_guesses::read(account)
    }

    // External functions
    #[external]
    fn assign_random_color() {
        let sender_address: ContractAddress = get_caller_address();
        let random_color = helper::get_random_color();
        user_colors::write(sender_address, random_color);
    }

    #[external]
    fn submit_color_guess(guess: Color) {
        let sender_address: ContractAddress = get_caller_address();
        user_guesses::write(sender_address, guess);
    }

    #[external]
    fn claim_color() {
        let sender_address: ContractAddress = get_caller_address();
        let assigned_color = user_colors::read(sender_address);
        let guessed_color = user_guesses::read(sender_address);

        assert(assigned_color == guessed_color, 'WRONG_COLOR_GUESS');

        validate_exercise(sender_address);
        distribute_points(sender_address, 2_u128);
    }

    // External functions - Administration
    #[external]
    fn update_class_hash(class_hash: felt252) {
        update_class_hash_by_admin(class_hash);
    }
}
