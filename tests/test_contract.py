from dataclasses import dataclass
import os
import pytest
from asynctest import TestCase
from starkware.starknet.testing.starknet import Starknet
from starkware.crypto.signature.signature import private_to_stark_key


@dataclass
class Uint256:
    """Uint256 dataclass to ease the asserting process"""

    low: int  # 2**128 low bits
    high: int  # 2**128 high bits

    def __eq__(self, __o: object) -> bool:
        """__eq__ method allows to do a == b (a and b being Uints256)"""
        return self.low == __o.low and self.high == __o.high


TEACHER_ADDRESS = private_to_stark_key(1)
STUDENT = private_to_stark_key(2)
WORKSHOP_ID = 1
DECIMALS = 10**18

PLAYERS_REGISTRY = os.path.join("contracts", "utils", "players_registry.cairo")
TUTOKEN = os.path.join("contracts", "token", "TDERC20.cairo")

RANDOM_VALS = [
    10,
    *[int.from_bytes(bytes=os.urandom(31), byteorder="big") for _ in range(10)],
]

EX1 = os.path.join("contracts", "ex01.cairo")
EX2 = os.path.join("contracts", "ex02.cairo")
EX3 = os.path.join("contracts", "ex03.cairo")
EX4 = os.path.join("contracts", "ex04.cairo")
EX5 = os.path.join("contracts", "ex05.cairo")
EX6 = os.path.join("contracts", "ex06.cairo")
EX7 = os.path.join("contracts", "ex07.cairo")
EX8 = os.path.join("contracts", "ex08.cairo")
EX9 = os.path.join("contracts", "ex09.cairo")
EX10 = os.path.join("contracts", "ex10.cairo")
EX10b = os.path.join("contracts", "ex10b.cairo")
EX11 = os.path.join("contracts", "ex11.cairo")
EX12 = os.path.join("contracts", "ex12.cairo")
EX13 = os.path.join("contracts", "ex13.cairo")
EX14 = os.path.join("contracts", "ex14.cairo")


class CairoContractTest(TestCase):
    @pytest.mark.asyncio
    async def test_tutorial(self):
        starknet = await Starknet.empty()
        players = await starknet.deploy(
            source=PLAYERS_REGISTRY, constructor_calldata=[TEACHER_ADDRESS]
        )
        tutoken = await starknet.deploy(
            source=TUTOKEN,
            constructor_calldata=[
                10057515165931654559836545801321088512241713,
                357609582641,
                0,
                0,
                TEACHER_ADDRESS,
                TEACHER_ADDRESS,
            ],
        )

        INIT_CALLDATA = [
            tutoken.contract_address,
            players.contract_address,
            WORKSHOP_ID,
        ]
        ex1 = await starknet.deploy(
            source=EX1, constructor_calldata=[*INIT_CALLDATA, 1]
        )
        ex2 = await starknet.deploy(
            source=EX2,
            constructor_calldata=[
                *INIT_CALLDATA,
                2,
                int.from_bytes(bytes=os.urandom(31), byteorder="big"),
            ],
        )
        ex3 = await starknet.deploy(
            source=EX3, constructor_calldata=[*INIT_CALLDATA, 3]
        )
        ex4 = await starknet.deploy(
            source=EX4, constructor_calldata=[*INIT_CALLDATA, 4]
        )
        ex5 = await starknet.deploy(
            source=EX5,
            constructor_calldata=[*INIT_CALLDATA, 5],
        )
        await ex5.set_random_values(values=RANDOM_VALS).invoke(
            caller_address=TEACHER_ADDRESS
        )
        ex6 = await starknet.deploy(
            source=EX6, constructor_calldata=[*INIT_CALLDATA, 6]
        )
        await ex6.set_random_values(values=RANDOM_VALS).invoke(
            caller_address=TEACHER_ADDRESS
        )
        ex7 = await starknet.deploy(
            source=EX7, constructor_calldata=[*INIT_CALLDATA, 7]
        )
        ex8 = await starknet.deploy(
            source=EX8, constructor_calldata=[*INIT_CALLDATA, 8]
        )
        ex9 = await starknet.deploy(
            source=EX9, constructor_calldata=[*INIT_CALLDATA, 9]
        )
        ex10 = await starknet.deploy(
            source=EX10, constructor_calldata=[*INIT_CALLDATA, 10]
        )
        ex11 = await starknet.deploy(
            source=EX11, constructor_calldata=[*INIT_CALLDATA, 11]
        )
        ex12 = await starknet.deploy(
            source=EX12, constructor_calldata=[*INIT_CALLDATA, 12]
        )
        await ex12.set_random_values(values=RANDOM_VALS).invoke(
            caller_address=TEACHER_ADDRESS
        )
        ex13 = await starknet.deploy(
            source=EX13, constructor_calldata=[*INIT_CALLDATA, 13, *RANDOM_VALS]
        )
        ex14 = await starknet.deploy(
            source=EX14, constructor_calldata=[*INIT_CALLDATA, 14]
        )
        ex10b = await starknet.deploy(
            source=EX10b, constructor_calldata=[ex10.contract_address]
        )

        await players.set_exercises_or_admins(
            [
                ex1.contract_address,
                ex2.contract_address,
                ex3.contract_address,
                ex4.contract_address,
                ex5.contract_address,
                ex6.contract_address,
                ex7.contract_address,
                ex8.contract_address,
                ex9.contract_address,
                ex10.contract_address,
                ex10b.contract_address,
                ex11.contract_address,
                ex12.contract_address,
                ex13.contract_address,
                ex14.contract_address,
            ]
        ).invoke(caller_address=TEACHER_ADDRESS)
        await tutoken.set_teachers(
            [
                ex1.contract_address,
                ex2.contract_address,
                ex3.contract_address,
                ex4.contract_address,
                ex5.contract_address,
                ex6.contract_address,
                ex7.contract_address,
                ex8.contract_address,
                ex9.contract_address,
                ex10.contract_address,
                ex10b.contract_address,
                ex11.contract_address,
                ex12.contract_address,
                ex13.contract_address,
                ex14.contract_address,
            ]
        ).invoke(caller_address=TEACHER_ADDRESS)

        async def test_ex01():
            await ex1.claim_points().invoke(caller_address=STUDENT)
            balance = await tutoken.balanceOf(account=STUDENT).call()
            self.assertEqual(Uint256(2 * DECIMALS, 0), balance.result.balance)

        async def test_ex02():
            secret_val = await ex2.my_secret_value().call()
            await ex2.claim_points(my_value=secret_val.result.my_secret_value).invoke(
                caller_address=STUDENT
            )
            balance = await tutoken.balanceOf(account=STUDENT).call()
            self.assertEqual(Uint256(4 * DECIMALS, 0), balance.result.balance)

        async def test_ex03():
            await ex3.increment_counter().invoke(caller_address=STUDENT)
            await ex3.increment_counter().invoke(caller_address=STUDENT)
            await ex3.increment_counter().invoke(caller_address=STUDENT)
            await ex3.increment_counter().invoke(caller_address=STUDENT)
            await ex3.decrement_counter().invoke(caller_address=STUDENT)
            await ex3.claim_points().invoke(caller_address=STUDENT)
            balance = await tutoken.balanceOf(account=STUDENT).call()
            self.assertEqual(Uint256(6 * DECIMALS, 0), balance.result.balance)

        async def test_ex04():
            await ex4.assign_user_slot().invoke(caller_address=STUDENT)
            slot = await ex4.user_slots(account=STUDENT).call()
            val = await ex4.values_mapped(slot=slot.result.user_slot).call()
            await ex4.claim_points(expected_value=val.result.value - 32).invoke(
                caller_address=STUDENT
            )
            balance = await tutoken.balanceOf(account=STUDENT).call()
            self.assertEqual(Uint256(8 * DECIMALS, 0), balance.result.balance)

        async def test_ex05():
            await ex5.assign_user_slot().invoke(caller_address=STUDENT)
            await ex5.copy_secret_value_to_readable_mapping().invoke(
                caller_address=STUDENT
            )
            val = await ex5.user_values(account=STUDENT).call()
            await ex5.claim_points(expected_value=val.result.user_value).invoke(
                caller_address=STUDENT
            )
            balance = await tutoken.balanceOf(account=STUDENT).call()
            self.assertEqual(Uint256(10 * DECIMALS, 0), balance.result.balance)

        async def test_ex06():
            await ex6.assign_user_slot().invoke(caller_address=STUDENT)
            await ex6.external_handler_for_internal_function(a_value=0).invoke(
                caller_address=STUDENT
            )
            val = await ex6.user_values(account=STUDENT).call()
            await ex6.claim_points(expected_value=val.result.user_value).invoke(
                caller_address=STUDENT
            )
            balance = await tutoken.balanceOf(account=STUDENT).call()
            self.assertEqual(Uint256(12 * DECIMALS, 0), balance.result.balance)

        async def test_ex07():
            await ex7.claim_points(value_a=50, value_b=0).invoke(caller_address=STUDENT)
            balance = await tutoken.balanceOf(account=STUDENT).call()
            self.assertEqual(Uint256(14 * DECIMALS, 0), balance.result.balance)

        async def test_ex08():
            await ex8.set_user_values(account=STUDENT, array=[10] * 11).invoke(
                caller_address=STUDENT
            )
            await ex8.claim_points().invoke(caller_address=STUDENT)
            balance = await tutoken.balanceOf(account=STUDENT).call()
            self.assertEqual(Uint256(16 * DECIMALS, 0), balance.result.balance)

        async def test_ex09():
            await ex9.claim_points(array=[10**i for i in range(5, 1, -1)]).invoke(
                caller_address=STUDENT
            )
            balance = await tutoken.balanceOf(account=STUDENT).call()
            self.assertEqual(Uint256(18 * DECIMALS, 0), balance.result.balance)

        async def test_ex10():
            secret_val = await ex10b.secret_value().call()
            await ex10.claim_points(
                secret_value_i_guess=secret_val.result.secret_value,
                next_secret_value_i_chose=69,
            ).invoke(caller_address=STUDENT)
            balance = await tutoken.balanceOf(account=STUDENT).call()
            self.assertEqual(Uint256(20 * DECIMALS, 0), balance.result.balance)

        async def test_ex11():
            secret_val = await ex11.secret_value().call()
            await ex11.claim_points(
                secret_value_i_guess=secret_val.result.secret_value - 42069,
                next_secret_value_i_chose=69,
            ).invoke(caller_address=STUDENT)
            balance = await tutoken.balanceOf(account=STUDENT).call()
            self.assertEqual(Uint256(22 * DECIMALS, 0), balance.result.balance)

        async def test_ex12():
            res = await ex12.assign_user_slot().invoke(caller_address=STUDENT)
            await ex12.claim_points(
                expected_value=res.call_info.events[0].data[1] - 32
            ).invoke(caller_address=STUDENT)
            balance = await tutoken.balanceOf(account=STUDENT).call()
            self.assertEqual(Uint256(24 * DECIMALS, 0), balance.result.balance)

        async def test_ex13():
            await ex13.assign_user_slot().invoke(caller_address=STUDENT)
            slot = await ex13.user_slots(account=STUDENT).call()
            await ex13.claim_points(
                expected_value=ex13.deploy_execution_info.call_info.calldata[
                    -1 - slot.result.user_slot
                ]
            ).invoke(caller_address=STUDENT)
            balance = await tutoken.balanceOf(account=STUDENT).call()
            self.assertEqual(Uint256(26 * DECIMALS, 0), balance.result.balance)

        await test_ex01()
        await test_ex02()
        await test_ex03()
        await test_ex04()
        await test_ex05()
        await test_ex06()
        await test_ex07()
        await test_ex08()
        await test_ex09()
        await test_ex10()
        await test_ex11()
        await test_ex12()
        await test_ex13()
