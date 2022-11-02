// ######## Ejercicio 09
// # Recursión - Avanzado
// En este ejercicio, necesitas:
// - Usar la función claim_points() de este contrato.
// - Sus puntos son acreditados por el contrato. 

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_not_zero, assert_le
from starkware.starknet.common.syscalls import get_caller_address
from contracts.utils.ex00_base import (
    tderc20_address,
    has_validated_exercise,
    distribute_points,
    validate_exercise,
    ex_initializer,
)

//
// Funciones de lectura
//
@view
func get_sum{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    array_len: felt, array: felt*
) -> (array_sum: felt) {
    let (array_sum) = get_sum_internal(array_len, array);
    return (array_sum,);
}

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
// Invocar esta función simplemente acreditará dos (2) puntos a la dirección dada como parámetro. 
//

@external
func claim_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    array_len: felt, array: felt*
) {
    // Comprobando que el array tiene al menos una longitud de 4
    with_attr error_message("Expected an array of at least 4 elements but got {array_len}") {
        assert_le(4, array_len);
    }
    // Calculando la suma del array dado por el usuario. 
    let (array_sum) = get_sum_internal(array_len, array);

    with_attr error_message("Expected the sum of the array to be at least 50") {
        // La suma debe de ser mayor que 50.
        assert_le(50, array_sum);
    }
    // Leyendo la dirección del emisor.
    let (sender_address) = get_caller_address();
    // Comprobando si el usuario ha validado el ejercicio anteriormente. 
    validate_exercise(sender_address);
    // Enviando los puntos a la dirección especificada como parámetro.
    distribute_points(sender_address, 2);
    return ();
}

//
// Funciones internas
//
//

func get_sum_internal{range_check_ptr}(length: felt, array: felt*) -> (sum: felt) {
    // Esta función es usada de forma recursiva para calcular la suma de todos los valores en un array
    // Recursivamente, primero pasamos por todos las posiciones del array.
    // Una vez que llegamos al final del array (length = 0), empezamos a sumar
    if (length == 0) {
        // Start with sum=0.
        return (sum=0);
    }

    // Si el largo NO es cero, entonces la función se llama así misma de nuevo, avanzando un espacio.
    let (current_sum) = get_sum_internal(length=length - 1, array=array + 1);

    //  Se llega a esta parte de la función por primera vez cuando length=0.
    // Comprobando que el primer valor en el array ([array]) no es 0.
    with_attr error_message("First value of the array should not be 0") {
        assert_not_zero([array]);
    }
    // La suma empieza. 
    let sum = [array] + current_sum;

    with_attr error_message(
            "value at index i should be at least the sum of values of index strictly higher than i") {
        assert_le(current_sum * 2, sum);
    }
    // La función de retorno apunta al cuerpo de esta función.
    return (sum,);
}
