# ######## Exercício 03
# Usando funções de contratos para manipular variáveis
# Nesse exercício você precisa:
# - Utilizar uma função do contrato para manipular um contador interno único ao seu endereço(address)
# - Quando ese contador chegar a um valor específico chame uma função específica
# - OS seus pontos serão distribuidos pelo contrato

# # O que você irá aprener
# - Como declarar mapas/mappings
# - Como ler e escrever/salvar dados em um mapa/mapping
# - Como usar uma função para manipular variáveis na memória

# ######## Código geral(General directives) e importações(imports)
#
#

%lang starknet

from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.cairo_builtins import HashBuiltin
from contracts.utils.ex00_base import (
    tderc20_address,
    has_validated_exercise,
    distribute_points,
    validate_exercise,
    ex_initializer,
)

#
# Declarando variáveis variáveis
# Variáveis em memória em geral não são visíveis pelo ABI. Eles são similares as variáveis "privadas/privates" no Solidity.
#

# Declarando mapas/mappings chamados user_counters_storage. Para cada 'account' key / chave de conta, que é um felt, nós armazenamos valores que também são felt.
@storage_var
func user_counters_storage{syscall_ptr: felt*, pederson_ptr : HashBuiltin*, range_check_ptr}(
    account : felt
    ) -> (user_counters_storage: felt):
end

#
#Declarando getters
# Variáveis públicas devem ser declaradas explicitament com "getters"
#

#Declarando um "getter" para o nosso mapa/mapping. Esse "getter" recebe um argumento como paramentro, a conta da qual você deseja ler o contador
@view
func user_counters{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    account:felt
) -> (user_counter: felt):

    let (user_counter) = user_counters_storage.read(account)
    return (user_counter)
end

#
#Construtor
#
@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    _tderc20_address: felt, _players_registry: felt, _workshop_id: felt, _exercise_id: felt
):

    ex_initializer(_terdc20_address, _players_registry, _workshop_id, _exercise_id)
    return()
end

#
#Funções Externas
#

@external
func lendoclaim_points{syscall_ptr:felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}():
    #Chamando o endereço do usuário(da conta que está chamando o contrato)
    let (sender_address) = get_caller_address()
    # Checando se o contador do usuário é igual a 7
    let (current_counter_value) = user_counters_storage.read(sender_address)
    with_attr error_message("Counter is not equal to 7"):
        assert current_counter_value = 7
    end
    # Checando se o usuário já validou o exercício antes
    validate_exercise(sender_address)
    # Enviando pontos para o endereço especificado como parâmetro
    distribute_points(sender_address,2)
    return()
end

@external
func reset_counter{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}():
    #Lendo o endereço do usuário que está chamando o contrato
    let (sender_address) = get_caller_address()
    # Reinicializando o contador do usuário
    user_counters_storage.write(sender_address,0)
    return ()
end

@external
func increment_counter{syscall_ptr: felt*, pederson_ptr: HashBuiltin*, range_check_ptr} ():
    #Lendo o endereço do usuário que está chamando o contrato
    let (sender_address) = get_caller_address()
    # Lendo da memória o contador único do usuário 
    let (current_counter_value) = user_counters_storage.read(sender_address)
    # Escrevendo e atualizando o valor do contador do usuário na memória
    user_counters_storage.write(sender_address, current_counter_value + 2)
    return()
end

@external
func decrement_counter{syscall_ptr: felt*, pederson_ptr: HashBuiltin*, range_check_ptr}():
    #Lendo o endereço do usuário que está chamando o contrato
    let (sender_address) = get_caller_address()
    # Lendo da memória o contador único do usuário
    let (current_counter_value) = user_counters_storage.read(sender_address)
    # Escrevendo e atualizando o valor do contador do usuário na memória
    user_counters_storage.write(sender_address, current_counter_value -1)
    return()
end