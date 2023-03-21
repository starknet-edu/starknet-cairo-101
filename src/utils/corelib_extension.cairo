use starknet::ContractAddress;
use starknet::contract_address_to_felt252;
use hash::LegacyHash;

// This is supported in alpha6 :-)
// impl FeltTriplet of LegacyHash::<(ContractAddress, felt252, felt252)> {
//     fn hash(state: felt252, triplet: (ContractAddress, felt252, felt252)) -> felt252 {
//         let (first, second, third) = triplet;
//         let state = LegacyHash::hash(state, contract_address_to_felt252(first));
//         let state = LegacyHash::hash(state, second);
//         LegacyHash::hash(state, third)
//     }
// }

// impl FeltDoublet of LegacyHash::<(ContractAddress, felt252)> {
//     fn hash(state: felt252, doublet: (ContractAddress, felt252)) -> felt252 {
//         let (first, second) = doublet;
//         let state = LegacyHash::hash(state, contract_address_to_felt252(first));
//         LegacyHash::hash(state, second)
//     }
// }
