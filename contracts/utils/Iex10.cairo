%lang starknet

####################
# INTERFACE
####################

@contract_interface
namespace Iex10:
    func set_ex_10b_address(ex_10b_address_: felt):
    end
    func has_validated_exercice(account: felt) -> (has_validated_exercice: felt):
    end
end
