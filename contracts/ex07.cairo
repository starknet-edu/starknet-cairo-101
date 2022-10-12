// ######## Ejercicio 07
// # Entendiendo funciones para comparar valores
// En este ejercicio, necesitas:
// - Usar la función claim_points() de este contrato.
// - Sus puntos serán acreditados por el contrato

// ######## Referencias.
// La documentación aún está siendo escrita. Puedes encontrar respuestas en este archivo:
// https://github.com/starkware-libs/cairo-lang/blob/master/src/starkware/cairo/common/math.cairo

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.math import (
    assert_not_zero,
    assert_not_equal,
    assert_nn,
    assert_le,
    assert_lt,
    assert_in_range,
)

from contracts.utils.ex00_base import (
    tderc20_address,
    has_validated_exercise,
    distribute_points,
    validate_exercise,
    ex_initializer,
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
// Invocar esta función simplemente acreditará dos (2) puntos a la dirección especificada como parámetro
//

@external
func claim_points{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    value_a: felt, value_b: felt
) {
    // Leyendo dirección del emisor. 
    let (sender_address) = get_caller_address();
    // Comprobando que los valores dados son correctos
    with_attr error_message("value_a shouldn't be 0") {
        assert_not_zero(value_a);
    }

    with_attr error_message("value_b shouldn't be negative") {
        assert_nn(value_b);
    }

    with_attr error_message("value_a and value_b should be different") {
        assert_not_equal(value_a, value_b);
    }

    with_attr error_message("value_a should be <= 75") {
        assert_le(value_a, 75);
    }

    with_attr error_message("value_a should be between 40 and 69") {
        assert_in_range(value_a, 40, 70);
    }

    with_attr error_message("value_b should be < 1") {
        assert_lt(value_b, 1);
    }
    // Comprobando si el usuario ha validado el ejercicio anteriormente.
    validate_exercise(sender_address);
    // Enviando los puntos a la dirección especificada como parámetro.
    distribute_points(sender_address, 2);
    return ();
}