////////////////////////////////
// Iex10b INTERFACE
////////////////////////////////
#[abi]
trait Iex10b {
    fn get_secret_value() -> u128;
    fn change_secret_value(new_secret_value: u128);
}
