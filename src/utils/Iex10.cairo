////////////////////////////////
// INTERFACE
////////////////////////////////
#[abi]
trait Iex10 {
    fn set_ex_10b_address(ex_10b_address_: felt);
    fn has_validated_exercise(account: felt) -> felt;
}
