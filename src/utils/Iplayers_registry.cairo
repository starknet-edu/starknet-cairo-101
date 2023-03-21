use starknet::ContractAddress;

////////////////////////////////
// INTERFACE
////////////////////////////////
#[abi]
trait Iplayers_registry {
    fn has_validated_exercise(account: ContractAddress, workshop: felt252, exercise: felt252) -> bool;
    fn is_exercise_or_admin(account: ContractAddress) -> bool;
    fn next_player_rank() -> felt252;
    fn players_registry(rank: felt252) -> ContractAddress;
    fn player_ranks(account: ContractAddress) -> felt252;
    fn set_exercise_or_admin(account: ContractAddress, permission: bool);
    fn set_exercises_or_admins(accounts: Array::<felt252>);
    fn validate_exercise(account: ContractAddress, workshop: felt252, exercise: felt252);
}
