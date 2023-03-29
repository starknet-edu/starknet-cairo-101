////////////////////////////////
// Exercise 10b
// Composability
////////////////////////////////
// This exercise was deployed as a complement to ex10, but you don't know where!
// Use ex10 to find its address, then voyager to read from ex10b
// Then use ex10 to claim points
////////////////////////////////

#[contract]
mod Ex10b {
    ////////////////////////////////
    // Core Library imports
    // These are syscalls and functionalities that allow you to write Starknet contracts
    ////////////////////////////////
    use starknet::get_caller_address;
    use starknet::get_contract_address;
    use starknet::ContractAddress;

    ////////////////////////////////
    // Internal imports
    // These function become part of the set of function of the current contract
    ////////////////////////////////
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;
    use starknet_cairo_101::utils::Iex10::Iex10Dispatcher;
    use starknet_cairo_101::utils::Iex10::Iex10DispatcherTrait;

    ////////////////////////////////
    // Storage
    // In Cairo 1, storage is declared in a struct
    // Storage is not visible by default through the ABI
    ////////////////////////////////
    struct Storage {
        ex10_address: ContractAddress,
        secret_value: u128,
    }

    ////////////////////////////////
    // Constructor
    // This function (indicated with #[constructor]) is called when the contract is deployed and is used to initialize the contract's state
    ////////////////////////////////
    #[constructor]
    fn constructor(ex10_addr: ContractAddress) {
        ex10_address::write(ex10_addr);
        let current_contract_address = get_contract_address();

        Iex10Dispatcher{contract_address: ex10_addr}.set_ex_10b_address(current_contract_address);
    }

    ////////////////////////////////
    // View Functions
    // Public variables should be declared explicitly with a getter function (indicated with #[view]) to be visible through the ABI and callable from other contracts
    ////////////////////////////////
    #[view]
    fn get_ex10_address() -> ContractAddress {
        return ex10_address::read();
    }

    #[view]
    fn get_secret_value() -> u128 {
        return secret_value::read();
    }

    ////////////////////////////////
    // External functions
    // These functions are callable by other contracts or external calls such as DAPP, which are indicated with #[external] (similar to "public" in Solidity)
    ////////////////////////////////
    #[external]
    fn change_secret_value(new_secret_value: u128) {
        // Only ex10 can call this function
        only_ex10();
        // Changing secret value
        secret_value::write(new_secret_value);
        return ();
    }

    ////////////////////////////////
    // Internal functions - Administration
    // Only admins can call these. You don't need to understand them to finish the exercise.
    ////////////////////////////////
    fn only_ex10() {
        let caller = get_caller_address();
        let ex10_address = ex10_address::read();
        assert(ex10_address == caller, 'ADDRESS_NOT_MATCH');
    }
}
