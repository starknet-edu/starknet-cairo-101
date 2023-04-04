use array::ArrayTrait;
use option::OptionTrait;
use traits::TryInto;
use traits::Into;
use gas::get_builtin_costs;

const DECIMALS_18: u128 = 1000000000000000000_u128;
const DECIMALS_12: u128 = 1000000000000_u128;
const DECIMALS_6: u128 = 1000000_u128;

// Fake macro to compute gas left
// TODO: Remove when automatically handled by compiler.
#[inline(always)]
fn check_gas() {
    match gas::withdraw_gas_all(get_builtin_costs()) {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = ArrayTrait::new();
            data.append('Out of gas');
            panic(data);
        }
    }
}

// TODO: Use Math.pow() once cairo supports the function
// For the simplicity, We dont want to include a third party lib to do pow()
#[inline(always)]
fn get_token_in_decimals(decimals: u8) -> u128 {
  if decimals == 18_u8 {
    DECIMALS_18
  } else if decimals == 12_u8 {
    DECIMALS_12
  } else {
    DECIMALS_6
  }
}
