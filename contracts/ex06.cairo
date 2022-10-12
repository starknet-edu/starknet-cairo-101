// ######## Ej 06
// Funciones del tipo "External" contra las funciones del tipo "internal"
// En este ejercicio necesitas:
// - Usar una funcion para que te asigne una variable privada
// - Usar una función interna para copiar esta variable en una variable pública
// - Usar una función para mostrar que conoces el valor correcto de la variable privada
// - Tus puntos serán acreditados por el contrato

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_not_zero
from starkware.starknet.common.syscalls import get_caller_address

from contracts.utils.ex00_base import (
    tderc20_address,
    has_validated_exercise,
    distribute_points,
    validate_exercise,
    ex_initializer,
)

//
// Declarando variables de almacenamiento
// Las variables de almacenamiento son por defecto no visibles a través del ABI. Son similares a las variables del tipo "private" en Solidity
//

@storage_var
func user_slots_storage(account: felt) -> (user_slots_storage: felt) {
}

@storage_var
func user_values_public_storage(account: felt) -> (user_values_public_storage: felt) {
}

@storage_var
func values_mapped_secret_storage(slot: felt) -> (values_mapped_secret_storage: felt) {
}

@storage_var
func was_initialized() -> (was_initialized: felt) {
}

@storage_var
func next_slot() -> (next_slot: felt) {
}

//
// Declarando los "getters"
// Las variables publicas deberían ser declaradas explicitamente con un "getter"
//

@view
func user_slots{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(account: felt) -> (
    user_slot: felt
) {
    let (user_slot) = user_slots_storage.read(account);
    return (user_slot,);
}

@view
func user_values{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    account: felt
) -> (user_value: felt) {
    let (value) = user_values_public_storage.read(account);
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
// Funciones del tipo "External"
//

@external
func claim_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    expected_value: felt
) {
    // Leyendo la dirección de quien la llama
    let (sender_address) = get_caller_address();
    // Comprobando de que el usuario tiene un espacio asignado
    let (user_slot) = user_slots_storage.read(sender_address);
    with_attr error_message("Espacio de usuario no asignado. Llamar a assign_user_slot") {
        assert_not_zero(user_slot);
    }

    // Comprobando que el valor proporcionado por el usuario es el que esperamos
    // Todavía sigiloso.
    // o no. Es esto una operación psicológica?
    let (value) = values_mapped_secret_storage.read(user_slot);
    with_attr error_message("los valores aleatorios ya fueron inicializados") {
        assert value = expected_value;
    }

    // Comprobando si el usuario ha validado el ejercicio previamente
    validate_exercise(sender_address);
    // Mandando los puntos a la dirección especificada como parametro
    distribute_points(sender_address, 2);
    return ();
}

@external
func assign_user_slot{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // Leyendo la dirección de quien lo llama
    let (sender_address) = get_caller_address();
    let (next_slot_temp) = next_slot.read();
    let (next_value) = values_mapped_secret_storage.read(next_slot_temp + 1);
    if (next_value == 0) {
        user_slots_storage.write(sender_address, 1);
        next_slot.write(0);
    } else {
        user_slots_storage.write(sender_address, next_slot_temp + 1);
        next_slot.write(next_slot_temp + 1);
    }
    return ();
}

@external
func external_handler_for_internal_function{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}(a_value: felt) {
    // Leyendo la dirección de quien la llama
    let (sender_address) = get_caller_address();
    with_attr error_message("El valor proporcionado no es 0") {
        // Solo por diversión
        assert a_value = 0;
    }
    // Llamando una función del tipo "internal"
    copy_secret_value_to_readable_mapping(sender_address);
    return ();
}

//
// Funciones del tipo "internal"
// Estas funciones solo pueden ser llamadas por funciones dentro del mismo contrato.
// Quizá ¿Algunas funciones del tipo "external" te permitan llamar a estas?
//

func copy_secret_value_to_readable_mapping{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr
}(sender_address: felt) {
    with_attr error_message("Espacio de usuario no asignado. Llamar a assign_user_slot") {
        // Comprobando que el usuario tenga un espacio asignado
        let (user_slot) = user_slots_storage.read(sender_address);
        assert_not_zero(user_slot);
    }

    // Leyendo el valor secreto del usuario
    let (secret_value) = values_mapped_secret_storage.read(user_slot);

    // Copiando el valor de "values_mapped_secret_storage" el cual no está accesible hacia
    user_values_public_storage.write(sender_address, secret_value);
    return ();
}

//
// Funciones del tipo "External" - Administración
// Solo los administradores pueden llamar a estas. No necesitas entenderlas para terminar el ejercicio.
//

@external
func set_random_values{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    values_len: felt, values: felt*
) {
    with_attr error_message("Valores aleatorios ya inicializados") {
        // Comprobando si los valores aleatorios ya fueron inicializados
        let (was_initialized_read) = was_initialized.read();
        assert was_initialized_read = 0;
    }

    // Almacenando los valores proporcionados en el "storage"
    set_a_random_value(values_len, values);

    // Marca que el valor almacenado fue inicializado
    was_initialized.write(1);
    return ();
}

func set_a_random_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    values_len: felt, values: felt*
) {
    if (values_len == 0) {
        // Empieza con suma=0.
        return ();
    }

    set_a_random_value(values_len=values_len - 1, values=values + 1);
    values_mapped_secret_storage.write(values_len - 1, [values]);

    return ();
}