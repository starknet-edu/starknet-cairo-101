// ######## Ej 11
// # Importando funciones
// En este ejercicio necesitas:
// - Leer este contrato y entender como importa funciones de otro contrato
// - Encontrar el contrato relevante del que se importa
// - Leer el código y entender que se espera de ti

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_not_zero, assert_le
from starkware.starknet.common.syscalls import get_caller_address

// Este contrato importa funciones desde otro archivo desde otro ejercicio, Tenga cuidado
from contracts.utils.ex11_base import (
    tderc20_address,
    has_validated_exercise,
    distribute_points,
    validate_exercise,
    ex_initializer,
    validate_answers,
    ex11_secret_value,
    secret_value
)

//
// Constructor
//
@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    _tderc20_address: felt, _players_registry: felt, _workshop_id: felt, _exercise_id: felt
) {
    ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    return ();
}

//
// Funciones externas
// Llamar a esta función va a acreditar 2 puntos a la dirección especificada por paramentro
//

@external
func claim_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    secret_value_i_guess: felt, next_secret_value_i_chose: felt
) {
    alloc_locals;
    // Leyendo la dirección de quien la llama y configurando en una variable local para evitar referencias revocadas
    let (local sender_address) = get_caller_address();
    // Comprueba si su respuesta es correcta
    validate_answers(sender_address, secret_value_i_guess, next_secret_value_i_chose);
    // Comprueba si el usuario ha validado el ejercicio antes.
    validate_exercise(sender_address);
    // Envía los puntos a la dirección especificada por parametros
    distribute_points(sender_address, 2);
    return ();
}