////////////////////////////////
// INTERFACE
////////////////////////////////
#[abi]
trait Iex10b {
    fn secret_value() -> felt252;
    fn change_secret_value(new_secret_value: felt252);
}
