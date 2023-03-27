use starknet::ContractAddress;
////////////////////////////////
// Iex10 INTERFACE
////////////////////////////////
#[abi]
trait Iex10 {
    fn set_ex_10b_address(ex_10b_address_: ContractAddress);
    fn has_validated_exercise(account: ContractAddress) -> bool;
}
