// ######## Ej 02
// # Entendiendo los "Asserts"
// En este ejercicio necesitas:
// - Usar la función claim_points() de este contrato
// - Tus puntos son acreditados por el contrato

// # Lo que aprenderás
// - Usar los "asserts"
// - Cómo declarar variables de almacentamiento.
// - Cómo leer variables de almacenamiento.
// - Cómo crear funciones "getter"
// Los "Asserts" son componentes básicos que te permiten verificar que dos valores sean iguales.
// Son similares a los require() en Solidity.
// Más informacion acerca del almacenamiento básico en https://www.cairo-by-example.com/basics/storage.

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
// Declarando las variables de almacenamiento
// Las variables de almacenamiento son por defecto no visibles a través del ABI. Son similares a las variables del tipo "private" en Solidity
//
// Esta variable es un "Felt" y se llama my_secret_value_storage
// Desde un mismo contrato inteligente, puede leerse con my_secret_value_storage.read() o escribirse con my_secret_value_storage.write()

@storage_var
func my_secret_value_storage() -> (my_secret_value_storage: felt) {
}

//
// Declarando "getters"
// Las variables del tipo "Public" deben declararse explicitamente con un "getter"
//

@view
func my_secret_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    my_secret_value: felt
) {
    let (my_secret_value) = my_secret_value_storage.read();
    return (my_secret_value,);
}

// ######## Constructor
// Esta función es llamada cuando se despliega el contrato.
//
@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    _tderc20_address: felt,
    _players_registry: felt,
    _workshop_id: felt,
    _exercise_id: felt,
    my_secret_value: felt,
) {
    ex_initializer(_tderc20_address, _players_registry, _workshop_id, _exercise_id);
    my_secret_value_storage.write(my_secret_value);
    return ();
}

// ######## Funciones del tipo "External"
// Estas funciones pueden ser llamadas desde otros contratos
//

@external
func claim_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(my_value: felt) {
    // Leyendo la dirección de quien la llama
    let (sender_address) = get_caller_address();
    // Leyendo el valor almacenado de la memoria
    let (my_secret_value) = my_secret_value_storage.read();
    // Comprobando que el valor enviado es correcto
    // Usar "assert" de esta forma es parecido a usar "require" en Solidity
    with_attr error_message("Valor secreto incorrecto") {
        assert my_value = my_secret_value;
    }
    // Comprobando si el usuario ha validado el ejercicio previamente
    validate_exercise(sender_address);
    // Enviando puntos a la dirección especificada como parámetro
    distribute_points(sender_address, 2);
    return ();
}
