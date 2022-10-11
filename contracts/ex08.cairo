// ######## Ejercicio 08
// # Recursión - Basicos
// En este ejercicio, necesitas:
// - Usar la función claim_points() de este contrato.
// - Sus puntos son acreditados por el contrato

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
// Declarando variables de estado.
// Las variables de estado no son visibles por defecto en la ABI. Estas son similares a las variables privadas en Solidity.
//

@storage_var
func user_values_storage(account: felt, slot: felt) -> (user_values_storage: felt) {
}

//
// Declarando getters.
// Las variables públicas deben de ser declaradas explícitamente con un getter.
//

@view
func user_values{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    account: felt, slot: felt
) -> (value: felt) {
    let (value) = user_values_storage.read(account, slot);
    return (value,);
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
// Funciones externas.
// Invocar esta función simplemente acreditará dos (2) puntos a la dirección especificada como parámetro.
//

@external
func claim_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // Leyendo la dirección del emisor.
    let (sender_address) = get_caller_address();

    // Comprobando el valor de user_values_storage del usuario, en la posición 10
    let (user_value_at_slot_ten) = user_values_storage.read(sender_address, 10);

    with_attr error_message("User value should be 10 (you can set it with set_user_values)") {
        // Este valor debe ser igual a 10
        assert user_value_at_slot_ten = 10;
    }

    // Comprobando si el usuario ha validado el ejercicio anteriormente.
    validate_exercise(sender_address);
    // Enviando los puntos a la dirección especificada como parámetro.
    distribute_points(sender_address, 2);
    return ();
}

// Esta función recibe un array como parámetro.
// Para lograr ejecutarla efectivamente, el usuario necesita pasar tanto el array como su longitud.
// Esta complejidad es abstraída por voyager, en donde simplemente necesitarás pasar un array.
@external
func set_user_values{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    account: felt, array_len: felt, array: felt*
) {
    set_user_values_internal(account, array_len, array);
    return ();
}

//
// Funciones internas
//
//

func set_user_values_internal{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    account: felt, length: felt, array: felt*
) {
    // Esta función es usada de forma recursiva para setear todos los valores del usuario.
    // Recursivamente, primero  pasamos por la longitud del array.
    // Una vez que llegamos al final del array (length = 0), empezamos a sumar.
    if (length == 0) {
        // Start with sum=0.
        return ();
    }

    // Si el largo NO es cero, entonces la función se llama así misma de nuevo, avanzando un espacio.
    set_user_values_internal(account=account, length=length - 1, array=array + 1);

    // Se llega a esta parte de la función por primera vez cuando length=0
    user_values_storage.write(account, length - 1, [array]);
    return ();
}
