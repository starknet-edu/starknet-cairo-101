////////////////////////////////
// INTERFACE
////////////////////////////////
#[abi]
trait Iplayers_registry {
    fn has_validated_exercise(account: felt, workshop: felt, exercise: felt) -> felt;
    fn is_exercise_or_admin(account: felt) -> felt;
    fn next_player_rank() -> felt;
    fn players_registry(rank: felt) -> felt;
    fn player_ranks(account: felt) -> felt;
    fn set_exercise_or_admin(account: felt, permission: felt);
    fn set_exercises_or_admins(accounts_len: felt, accounts: Array::<felt>);
    fn validate_exercise(account: felt, workshop: felt, exercise: felt);
}
