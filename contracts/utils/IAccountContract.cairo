%lang starknet

####################
# INTERFACE
####################

@contract_interface
namespace IAccountContract:
    func get_signer() -> (signer : felt):
    end
end
