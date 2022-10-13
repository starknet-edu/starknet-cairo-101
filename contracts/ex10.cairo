// ######## Ejercicio 10 
// # Componibilidad
// En este ejercicio, necesitas:
// - Usar este contrato para recuperar la dirección del contrato ex10b.cairo, el cual tiene la llave para este ejercicio. 
// - Encuentra la llave secreta en ex10b.cairo.
// - Invoca la función claim_points() en este ejercicio con el valor secreto. 
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

from contracts.utils.Iex10b import Iex10b

//
// Declarando variables de estado.
// Las variables de estado no son visibles por defecto en la ABI. Estas son similares a las variables privadas en Solidity.
//

@storage_var
func ex10b_address_storage() -> (ex10b_address_storage: felt) {
}

//
// Funciones de lectura. 
//
@view
func ex10b_address{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    ex10b_address: felt
) {
    let (ex10b_address) = ex10b_address_storage.read();
    return (ex10b_address,);
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
// Invocar esta función simplemente acreditará dos (2) puntos a la dirección especificada como parámetro.

//

@external
func claim_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    secret_value_i_guess: felt, next_secret_value_i_chose: felt
) {
    // Leyendo la dirección del emisor
    let (sender_address) = get_caller_address();

    // Recuperando el valor secreto por medio de leerlo
    let (ex10b_address) = ex10b_address_storage.read();
    let (secret_value) = Iex10b.secret_value(contract_address=ex10b_address);
    with_attr error_message("Input value is not the expected secret value") {
        assert secret_value = secret_value_i_guess;
    }

    // Eligiendo el siguiente secret_value para el contrato 10b. No queremos que sea 0, así no es divertido.
    with_attr error_message("Next secret value shouldn't be 0") {
        assert_not_zero(next_secret_value_i_chose);
    }

    with_attr error_message("Contract 10b error") {
        Iex10b.change_secret_value(
            contract_address=ex10b_address, new_secret_value=next_secret_value_i_chose
        );
    }

    // Comprobando si el usuario ha validado el ejercicio anteriormente.
    validate_exercise(sender_address);
    // Enviando los puntos a la dirección especificada como parámetro. 
    distribute_points(sender_address, 2);
    return ();
}

//#
// # Funciones temporales. Una vez que las cuentas contrato estén en la red y sean usables con Nile estas funciones serán removidas.
//#
//#
@storage_var
func setup_is_finished() -> (setup_is_finished: felt) {
}

@external
func set_ex_10b_address{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    ex10b_address: felt
) {
    let (permission) = setup_is_finished.read();
    assert permission = 0;
    ex10b_address_storage.write(ex10b_address);
    setup_is_finished.write(1);
    return ();
}
