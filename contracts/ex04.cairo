// ######## Ejercicio 04
// Leyendo un mapping.
// En este ejercicio necesitás:
// -  Usar una función para leer una variable.
// -  Usar una función para leer un valor de un mapping, donde la posición que leas es el valor de la primera llamada.
// -  Usar una función para mostrar que conoces la posición correcta del valor en el mapping.
// -  Sus puntos son acreditados por el contrato.

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.math import assert_not_zero
from contracts.utils.ex00_base import (
    tderc20_address,
    has_validated_exercise,
    distribute_points,
    validate_exercise,
    ex_initializer,
)

//
//  Declarando variables de estado.
//  Las variables de estado no son visibles por defecto en la ABI. Estas son similares a las variables privadas en Solidity.
//

@storage_var
func user_slots_storage(account: felt) -> (user_slots_storage: felt) {
}

@storage_var
func values_mapped_storage(slot: felt) -> (values_mapped_storage: felt) {
}

@storage_var
func was_initialized() -> (was_initialized: felt) {
}

@storage_var
func next_slot() -> (next_slot: felt) {
}

//
// Declarando getters.
// Las variables públicas deben de ser declaradas explícitamente con un getter.
//

@view
func user_slots{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(account: felt) -> (
    user_slot: felt
) {
    let (user_slot) = user_slots_storage.read(account);
    return (user_slot,);
}

@view
func values_mapped{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(slot: felt) -> (
    value: felt
) {
    let (value) = values_mapped_storage.read(slot);
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
//

@external
func claim_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    expected_value: felt
) {
    // Leyendo la dirección del emisor.
    let (sender_address) = get_caller_address();
    with_attr error_message("User slot not assigned. Call assign_user_slot") {
        // Comprobando que el usuario tenga una posición asignada.
        let (user_slot) = user_slots_storage.read(sender_address);
        assert_not_zero(user_slot);
    }
    // Comprobando que el valor dado por el usuario es el esperado.
    // Sí, soy astuto.
    let (value) = values_mapped_storage.read(user_slot);
    with_attr error_message("Input value is not the expected secret value") {
        assert value = expected_value + 32;
    }
    // Comprobando si el usuario ha validado el ejercicio anteriormente.
    validate_exercise(sender_address);
    // Enviando los puntos a la dirección especificada como parametro.
    distribute_points(sender_address, 2);
    return ();
}

@external
func assign_user_slot{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // Leyendo la dirección del emisor.
    let (sender_address) = get_caller_address();
    let (next_slot_temp) = next_slot.read();
    let (next_value) = values_mapped_storage.read(next_slot_temp + 1);
    if (next_value == 0) {
        user_slots_storage.write(sender_address, 1);
        next_slot.write(0);
    } else {
        user_slots_storage.write(sender_address, next_slot_temp + 1);
        next_slot.write(next_slot_temp + 1);
    }
    return ();
}

//
// Funciones externas - Administración
// Solo los administradores pueden llamar estas funciones. Usted no necesita entenderlas para finalizar el ejercicio.
//

@external
func set_random_values{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    values_len: felt, values: felt*
) {
    // Comprobando si los valores aleatorios ya fueron inicializados.
    let (was_initialized_read) = was_initialized.read();
    with_attr error_message("random values already initialized") {
        assert was_initialized_read = 0;
    }

    // Guardando los valores dados en la variable de estado.
    set_a_random_value(values_len, values);

    // Marcar que el valor guardado fue inicializado.
    was_initialized.write(1);
    return ();
}

func set_a_random_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    values_len: felt, values: felt*
) {
    if (values_len == 0) {
        // Start with sum=0.
        return ();
    }

    set_a_random_value(values_len=values_len - 1, values=values + 1);
    values_mapped_storage.write(values_len - 1, [values]);

    return ();
}