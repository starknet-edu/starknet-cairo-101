use starknet::ContractAddress;

////////////////////////////////
// Iplayers_registry INTERFACE
////////////////////////////////
#[abi]
trait Iplayers_registry {
    fn has_validated_exercise(account: ContractAddress, workshop: u128, exercise: u128) -> bool;
    fn is_exercise_or_admin(account: ContractAddress) -> bool;
    fn next_player_rank() -> u128;
    fn players_registry(rank: u128) -> ContractAddress;
    fn player_ranks(account: ContractAddress) -> u128;
    fn set_exercise_or_admin(account: ContractAddress, permission: bool);
    fn set_exercises_or_admins(accounts: Array::<u128>);
    fn validate_exercise(account: ContractAddress, workshop: u128, exercise: u128);
}
