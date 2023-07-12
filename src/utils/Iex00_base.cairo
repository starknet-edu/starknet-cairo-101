use starknet::ContractAddress;
#[starknet::interface]
trait Iex00_base<TContractState>{
    fn tderc20_address(self: @TContractState) -> ContractAddress;
    fn players_registry(self: @TContractState) -> ContractAddress;
    fn workshop_id(self: @TContractState) -> u128;
    fn exercise_id(self:@TContractState) -> u128;
    fn has_validated_exercise(self:@TContractState, account:ContractAddress) -> bool;
    fn ex_initializer(ref self: TContractState, _tderc20_address: ContractAddress, _players_registry: ContractAddress, _workshop_id: u128, _exercise_id: u128);
    fn distribute_points(ref self: TContractState, to: ContractAddress, amount: u128 );
    fn validate_exercise(ref self: TContractState, account:ContractAddress);
    fn update_class_hash_by_admin(ref self: TContractState, class_hash_in_felt:felt252);
}