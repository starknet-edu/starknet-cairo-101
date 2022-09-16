// Ejercicio 01
// Usando una función de contrato público simple
// En este ejercicio, necesita:
// - Usar la función claim_points() de este contrato
// - Sus puntos son acreditados por el contrato

// Lo que aprenderás
// - Sintaxis general del contrato inteligente
// - Llamar a una función

// -----
// GENERAL DIRECTIVES AND IMPORTS
// -----

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

from contracts.utils.ex00_base import (
    tderc20_address,
    has_validated_exercise,
    distribute_points,
    validate_exercise,
    ex_initializer,
)

// -----
// CONSTRUCTOR
// -----
// Esta función se llama cuando se implementa el contrato
//
@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    _tderc20_address: felt, _players_registry: felt, _workshop_id: felt, _exercise_id: felt
) {
    ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    return ();
}

// -----
// EXTERNAL FUNCTIONS
// -----
// Estas funciones pueden ser llamadas por otros contratos.
//

// Esta función se llama claim_points
// Guarda en (sender_address) un felt. Lea más sobre felts aquí https://www.cairo-lang.org/docs/hello_cairo/intro.htmlfield-element
// Tiene argumentos implícitos (syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr). Lea más sobre argumentos implícitos aquí https://www.cairo-lang.org/docs/how_cairo_works/builtins.html
@external
func claim_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // Reading caller address
    let (sender_address) = get_caller_address();
    // Checking if the user has validated the exercise before
    validate_exercise(sender_address);
    // Sending points to the address specified as parameter
    distribute_points(sender_address, 2);
    return ();
}
