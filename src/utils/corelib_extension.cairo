use starknet::FeltTryIntoContractAddress;
use starknet::ContractAddressIntoFelt;
use starknet::contract_address_to_felt;
use starknet::StorageAccess;
use starknet::StorageBaseAddress;
use starknet::SyscallResult;
use traits::Into;
use traits::TryInto;
use option::OptionTrait;
use hash::LegacyHash;

impl FeltTriplet of LegacyHash::<(ContractAddress, felt, felt)> {
    fn hash(state: felt, triplet: (ContractAddress, felt, felt)) -> felt {
        let (first, second, third) = triplet;
        let state = LegacyHash::hash(state, contract_address_to_felt(first));
        let state = LegacyHash::hash(state, second);
        LegacyHash::hash(state, third)
    }
}
