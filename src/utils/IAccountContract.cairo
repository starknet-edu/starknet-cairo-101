////////////////////////////////
// IAccountContract INTERFACE
////////////////////////////////
#[starknet::interface]
trait IAccountContract {
    fn get_signer() -> felt252;
}
