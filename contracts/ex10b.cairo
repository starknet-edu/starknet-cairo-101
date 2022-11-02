// ######## Ejercicio 10b
// # Componibilidad
// Este ejercicio fue desplegado como complemento para el ejercicio 10, ¡pero no sabes donde!
// Usa el ejercicio 10 para conseguir la dirección de este contrato, despues voyager para leer desde ex10b
// Despues, usa el ejercicio 10 para reclamar los puntos

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_not_zero, assert_le
from starkware.starknet.common.syscalls import get_contract_address, get_caller_address
from contracts.utils.Iex10 import Iex10

//
// Declarando variables de estado
// Las variables de estado no son visibles por defecto en la ABI. Estas son similares a las variables privadas en Solidity
//

@storage_var
func ex10_address_storage() -> (ex10_address_storage: felt) {
}

@storage_var
func secret_value_storage() -> (secret_value_storage: felt) {
}

//
// Funciones de lectura
//
@view
func ex10_address{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    ex10_address: felt
) {
    let (ex10_address) = ex10_address_storage.read();
    return (ex10_address,);
}

@view
func secret_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    secret_value: felt
) {
    let (secret_value) = secret_value_storage.read();
    return (secret_value,);
}

//
// Constructor
//
@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    ex10_address: felt
) {
    ex10_address_storage.write(ex10_address);
    let (current_contract_address) = get_contract_address();
    Iex10.set_ex_10b_address(
        contract_address=ex10_address, ex_10b_address_=current_contract_address
    );
    return ();
}

//
// Funciones externas 
// Invocar esta función simplemente acreditará dos (2) puntos a la dirección especificada como parámetro.
//

@external
func change_secret_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    new_secret_value: felt
) {
    // Solo el ejercicio 10 puede invocar esta función.
    only_ex10();
    // Cambiando el valor secretto. 
    secret_value_storage.write(new_secret_value);
    return ();
}

//
// Funciones internas 
//
//
func only_ex10{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    let (caller) = get_caller_address();
    let (ex10_address) = ex10_address_storage.read();
    with_attr error_message("Only ex10 contract can call this function") {
        assert ex10_address = caller;
    }
    return ();
}
