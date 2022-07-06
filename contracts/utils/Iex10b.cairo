%lang starknet

####################
# INTERFACE
####################

@contract_interface
namespace Iex10b:
    func secret_value() -> (secret_value : felt):
    end
    func change_secret_value(new_secret_value : felt):
    end
end
