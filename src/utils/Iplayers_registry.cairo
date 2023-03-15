use starknet::contract_address::ContractAddressSerde;

////////////////////////////////
// INTERFACE
////////////////////////////////
#[abi]
trait Iplayers_registry {
    fn has_validated_exercise(account: ContractAddress, workshop: felt, exercise: felt) -> bool;
    fn is_exercise_or_admin(account: ContractAddress) -> bool;
    fn next_player_rank() -> felt;
    fn players_registry(rank: felt) -> ContractAddress;
    fn player_ranks(account: ContractAddress) -> felt;
    fn set_exercise_or_admin(account: ContractAddress, permission: bool);
    fn set_exercises_or_admins(accounts: Array::<felt>);
    fn validate_exercise(account: ContractAddress, workshop: felt, exercise: felt);
}
