// ######## Ejercicio 03
// Usando funciones del contrato para manipular variables del contrato
// En este ejercicio, necesitarás:
// - Usar las funciones de este contrato para manipular un contador interno único para tu dirección
// - Una vez que este contador llegue a cierto valor, llama una función especifica
// - Tus puntos son acreditados por el contrato

// # Lo que aprenderás
// - Cómo declarar asignaciones
// - Cómo leer y escribir en las asignaciones
// - Cómo usar una función para manipular variables de almacenamiento

// ######## Directivas generales e importaciones
//
//

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

//
// Declarando variables en memoria
// Las variables en memoria son no visibles de forma predeterminada a través de la ABI. Son similares a las variables "private" en Solidity
//

// Declarando una asignación llamando user_counters_storage. Para cada llave "account", que es un "felt", almacenamos un valor el cual es un "felt" tambien.
@storage_var
func user_counters_storage(account: felt) -> (user_counters_storage: felt) {
}

//
// Declarando "getters"
// Las variables "public" deberían ser declaradas explicitamente con un "getter"
//

// Declarando un "getter" para nuestras asignaciones. Toma un argumento como parámetro, la cuenta de la cual deseas leer el contador
@view
func user_counters{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    account: felt
) -> (user_counter: felt) {
    let (user_counter) = user_counters_storage.read(account);
    return (user_counter,);
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
// Funciones Externas
//

@external
func claim_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // Leyendo la dirección de quien la llama
    let (sender_address) = get_caller_address();
    // Comprobando que el contador del usuario es igual a 7
    let (current_counter_value) = user_counters_storage.read(sender_address);
    with_attr error_message("Counter is not equal to 7") {
        assert current_counter_value = 7;
    }
    // Comprobando si el usuario ha validado el ejercicio previamente
    validate_exercise(sender_address);
    // Enviando puntos a la dirección especificada como parámetro
    distribute_points(sender_address, 2);
    return ();
}

@external
func reset_counter{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // Leyendo la dirección de quien la llama
    let (sender_address) = get_caller_address();
    // Reiniciando el contador del usuario
    user_counters_storage.write(sender_address, 0);
    return ();
}

@external
func increment_counter{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // Leyendo la dirección de quien la llama
    let (sender_address) = get_caller_address();
    // Leyendo el contador de la memoria
    let (current_counter_value) = user_counters_storage.read(sender_address);
    // Escribiendo un valor actualizado en la memoria
    user_counters_storage.write(sender_address, current_counter_value + 2);
    return ();
}

@external
func decrement_counter{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    // Leyendo la dirección de quien la llama
    let (sender_address) = get_caller_address();
    // Leyendo el contador de la memoria
    let (current_counter_value) = user_counters_storage.read(sender_address);
    // Escribiendo un valor actualizado en la memoria
    user_counters_storage.write(sender_address, current_counter_value - 1);
    return ();
}