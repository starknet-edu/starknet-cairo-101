////////////////////////////////
// Exercise 10b
// Composability
////////////////////////////////
// This exercise was deployed as a complement to ex10, but you don't know where!
// Use ex10 to find its address, then voyager to read from ex10b
// Then use ex10 to claim points
////////////////////////////////

use starknet::ContractAddress;

#[starknet::interface]
trait Ex10bTrait<T> {
    fn get_ex10_address(self: @T) -> ContractAddress;
    fn get_secret_value(self: @T) -> u128;
    fn change_secret_value(ref self: T, new_secret_value: u128);
}

#[starknet::contract]
mod Ex10b {
    ////////////////////////////////
    // Core Library imports
    // These are syscalls and functionalities that allow you to write Starknet contracts
    ////////////////////////////////
    use starknet::get_caller_address;
    use starknet::get_contract_address;
    use starknet::ContractAddress;

    ////////////////////////////////
    // Storage
    // In Cairo 1, storage is declared in a struct
    // Storage is not visible by default through the ABI
    ////////////////////////////////
    #[storage]
    struct Storage {
        ex10_address: ContractAddress,
        secret_value: u128,
    }    

    ////////////////////////////////
    // Internal imports
    // These functions become part of the set of functions of the current contract
    ////////////////////////////////
    use starknet_cairo_101::utils::ex00_base::Ex00Base::distribute_points;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::validate_exercise;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::ex_initializer;
    use starknet_cairo_101::utils::ex00_base::Ex00Base::update_class_hash_by_admin;
    use starknet_cairo_101::utils::Iex10::Iex10Dispatcher;
    use starknet_cairo_101::utils::Iex10::Iex10DispatcherTrait;


    ////////////////////////////////
    // Constructor
    // This function (indicated with #[constructor]) is called when the contract is deployed and is used to initialize the contract's state
    ////////////////////////////////
    #[constructor]
    fn constructor(ref self: ContractState, ex10_addr: ContractAddress) {
        self.ex10_address.write(ex10_addr);
        let current_contract_address = get_contract_address();

        Iex10Dispatcher{contract_address: ex10_addr}.set_ex_10b_address(current_contract_address);
    }

    #[external(v0)]
    impl Ex10bImpl of super::Ex10bTrait<ContractState> {

        ////////////////////////////////
        // View Functions
        // Public variables should be declared explicitly with a getter function (indicated with #[view]) to be visible through the ABI and callable from other contracts
        ////////////////////////////////
        fn get_ex10_address(self: @ContractState) -> ContractAddress {
            return self.ex10_address.read();
        }

        fn get_secret_value(self: @ContractState) -> u128 {
            return self.secret_value.read();
        }

        ////////////////////////////////
        // External functions
        // These functions are callable by other contracts or external calls such as DAPP, which are indicated with #[external] (similar to "public" in Solidity)
        ////////////////////////////////
        fn change_secret_value(ref self: ContractState, new_secret_value: u128) {
            // Only ex10 can call this function
            self.only_ex10();
            // Changing secret value
            self.secret_value.write(new_secret_value);
            return ();
        }        
    }

    #[generate_trait]
    impl InternalFunctions of InternalFunctionsTrait {
        ////////////////////////////////
        // Internal functions - Administration
        // Only admins can call these. You don't need to understand them to finish the exercise.
        ////////////////////////////////
        fn only_ex10(self: @ContractState) {
            let caller = get_caller_address();
            let ex10_address = self.ex10_address.read();
            assert(ex10_address == caller, 'ADDRESS_NOT_MATCH');
        }
    }
}