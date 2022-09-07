# ######## Ex 02
# # Aprendendo o que são asserts
# Neste exercício você precisara:
# - Utilizar a função claim_points() deste contrato
# -  E os seus pontos sera creditado pelo contrato

# # O que você ira aprender?
# - Utilizar asserts
# - Como declarar e armazenar variáveis em memória
# - Como ler variáveis previamente salvas em memória
# - Como criar funções getter
# Asserts são é uma função de nível fundamental que permite você verificar se dois valores são iguais.
# Eles são similares ao require() no Solidity
# Para mais informações sobre memória/armazenamento básico, acesse https:#www.cairo-by-example.com/basics/storage

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
# Declarando variáveis em memória (storage vars)
# Variáveis em memória(storage vars) por definição não são visíveis pelo ABI. Eles são similares a variáveis "privadas" do Solidity
#
# Essa variável é um felt e é chamada de my_secret_value_storage
# De dentro do contrato inteligente, ele pode ser lido com o código my_secret_value_storage.read() ou alterada/escrita com my_secret_value_storage.write()

@storage_var
func my_secret_value_storage() -> (my_secret_value_storage: felt){}

#
# Declarando getters (pegadores? kk)
# Variáveis públicas devem ser declaradas explicitamente com o getter
#

@view
func my_secret_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_cehck_ptr}() -> (
    my_secret_value: felt
) {
    let (my_secret_value) = my_secret_value_storage.read();
    return (my_secret_value,);    
}

# ######## Constructor
func constructor{syscall_ptr:felt*, pedersen_ptr:HashBuiltin*, range_check_ptr}(
    _tderc20_address: felt,
    _players_registry: felt,
    _workshop_id: felt,
    _exercise_id: felt,
    my_secret_value: felt,
){
    ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    my_secret_value_storage.write(my_secret_value);
    return()
}

# ##### Funções externas
# Essas funções são chamáveis por outros contratos
#

@external
func claim_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr} (my_value:felt) {
    //Lendo o endereço do usuário
    let (sender_address) = get_caller_address();
    //Lendo o valor salvo na memória
    let (my_secret_value) = my_secret_value_storage.read();
    //Checando que o valor enviado está correto
    //Utilizando a função assert dessa forma é similar ao require no Solidity
    with_attr error_message("Wrong secret value") {
        assert my_value = my_secret_value;
    }
    //Checando se o usuário já validou o exercício antes
    validate_exercise(sender_address);
    // Enviando os pontos para o endereço especificado como parametro
    distribute_points(sender_address,2);
    return()
}