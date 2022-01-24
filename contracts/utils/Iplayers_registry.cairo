%lang starknet

####################
# INTERFACE
####################

@contract_interface
namespace Iplayers_registry:
    func has_validated_exercice(account: felt, workshop: felt, exercise: felt) -> (has_validated_exercice: felt):
    end
    func is_exercise_or_admin(account: felt) -> (permission: felt):
    end
    func next_player_rank() -> (next_player_rank: felt):
    end
    func players_registry(rank: felt) -> (account: felt):
    end
    func player_ranks(account: felt) -> (rank: felt):
    end
    func set_exercise_or_admin(account: felt, permission: felt):
    end
    func set_exercises_or_admins(accounts_len: felt, accounts: felt*):
    end
    func validate_exercice(account: felt, workshop: felt, exercise: felt):  
    end
end


