//###################
// INTERFACE
//###################
#[abi]
trait Iplayers_registry {
    fn has_validated_exercise(account: felt, workshop: felt, exercise: felt) -> (
        has_validated_exercise: felt
    ) {
    }
    fn is_exercise_or_admin(account: felt) -> (permission: felt) {
    }
    fn next_player_rank() -> (next_player_rank: felt) {
    }
    fn players_registry(rank: felt) -> (account: felt) {
    }
    fn player_ranks(account: felt) -> (rank: felt) {
    }
    fn set_exercise_or_admin(account: felt, permission: felt) {
    }
    fn set_exercises_or_admins(accounts_len: felt, accounts: felt*) {
    }
    fn validate_exercise(account: felt, workshop: felt, exercise: felt) {
    }
}