use starknet::ContractAddress;

////////////////////////////////
// Iplayers_registry INTERFACE
////////////////////////////////
#[starknet::interface]
trait Iplayers_registry<TContractState> {
    fn has_validated_exercise(self:@TContractState, account: ContractAddress, workshop: u128, exercise: u128) -> bool;
    fn is_exercise_or_admin(self: @TContractState,account: ContractAddress) -> bool;
    fn get_next_player_rank(self:@TContractState) -> u128;
    fn get_players_registry(self:@TContractState ,rank: u128) -> ContractAddress;
    fn player_ranks(self:@TContractState, account: ContractAddress) -> u128;
    fn set_exercise_or_admin(ref self: TContractState, account: ContractAddress, permission: bool);
    fn set_exercises_or_admins(ref self:TContractState, accounts: Array::<u128>);
    fn validate_exercise(ref self: TContractState, account: ContractAddress, workshop: u128, exercise: u128);
}