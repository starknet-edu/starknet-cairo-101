%lang starknet

//###################
// INTERFACE
//###################

@contract_interface
namespace Iex10 {
    func set_ex_10b_address(ex_10b_address_: felt) {
    }
    func has_validated_exercise(account: felt) -> (has_validated_exercise: felt) {
    }
}
