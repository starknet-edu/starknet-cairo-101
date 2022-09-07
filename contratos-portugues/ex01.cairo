# ######## Ex 01
# # Usando uma simples função de um contrato público
# Nesse exercício você precisar:
# - Usar a função claim_points() do contrato
# - E os seus pontos sera creditado pelo contrato

# # O que você ira aprender
# - Sintaxe geral dos contratos inteligentes
# - Chamando/Interagindo com uma função

# ######## Código geral(General directives) e imports
#
#

%lang startknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

from contracts.utils.ex00_base import (
    tderc20_address,
    has_validated_exercise,
    distribute_points,
    validate_exercise,
    ex_initializer,
)

# Constructor
# Essa função é chamada quando o contrato é "deployed" (deployado?)
#

@constructor

func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuilin*, range_check_ptr}(
    _tderc20_address: felt, _platers_registry: felt, _workshop_id: felt, _exercise_id: felt
) {
    ex_initializer(_terc20_address, _players_registry, _workshop_id, _exercise_id);
    return();
}

# Funções externas
# Essas funções são chamaveis(callable) por outros contratos
#

# Essa função é chamada de claim_points
# A função recebe um argumento como parametro (sender_address), que é um felt. Leia mais sobre felts aqui https://www.cairo-lang.org/docs/hello_cairo/intro.htmlfield-element
# A função também recebe argumentos implícitos (syscall_ptr: felt*, pedersen_ptr : HashBuiltin*, range_check_ptr) Leia mais sobre argumentos implícitos aqui https://www.cairo-lang.org/docs/how_cairo_works/builtins.html

@external
func claim_points{syscall_ptr: felt*, pedersen_ptr:HashBuiltin*, range_check_ptr}(){
    //Lendo o endereço de quem/o contrato que está chamando essa função
    let (sender_address) = get_caller_address()
    //Checando se o usuário já validou o exercício antes
    validate_exercise(sender_address);
    // Enviando pontos para o endereço especificado como parametro
    distribute_points(sender_address, 2);
    return();
}

