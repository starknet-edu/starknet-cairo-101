import subprocess, json
from utils import str_to_felt, felt_to_str

# essential settings
account_addr = "0x33507ff2edf12c12c73d0b6d1d90de9fac12a355de1097ab305249612451919"
salt = 1234
tderc20_addr = "0x"
player_registry_addr = "0x"
exercise_contracts = {}

def run_command(cmd):
  out = subprocess.check_output(cmd.split(" "))
  return out.decode("utf-8")

# Build
def build():
  print("BUILDing...")
  run_command("protostar build")
  return

# Test
def test():
  print("Testing...")
  run_command("protostar test")
  return

# Deploy TDERC20
def deploy_TDERC20():
  contract = "tderc20"
  print("DECLARE " + contract)
  out = run_command(f"protostar -p devnet declare ./build/TDERC20.json --account-address {account_addr} --private-key-path ./.pkey_local --max-fee auto --json")

  print("DEPLOY " + contract)
  token_name = str_to_felt("starknet-cairo-101")
  token_symbol = str_to_felt("SC101")
  class_hash = json.loads(out)['class_hash']
  out = run_command(f"protostar -p devnet deploy {class_hash} --salt {salt} --account-address {account_addr} --private-key-path ./.pkey_local --max-fee auto -i {token_name} {token_symbol} 0 0 {account_addr} {account_addr} --json")

  print("CALL " + contract)
  global tderc20_addr
  tderc20_addr = json.loads(out)['contract_address']
  out = run_command(f"protostar -p devnet call --contract-address {tderc20_addr} --function name --json")
  print("Deployed TDERC20 Name: " + felt_to_str(json.loads(out)['transformed_output']['name']))
  print(contract + " Deployment DONE")

  return

# Deploy Players Registry
def deploy_players_registry():
  contract = "players_registry"
  print("DECLARE " + contract)
  out = run_command(f"protostar -p devnet declare ./build/players_registry.json --account-address {account_addr} --private-key-path ./.pkey_local --max-fee auto --json")

  print("DEPLOY " + contract)
  class_hash = json.loads(out)['class_hash']
  out = run_command(f"protostar -p devnet deploy {class_hash} --salt {salt} --account-address {account_addr} --private-key-path ./.pkey_local --max-fee auto -i {account_addr} --json")

  global player_registry_addr
  player_registry_addr = json.loads(out)['contract_address']
  print("player_registry_addr: " + player_registry_addr)
  return

# Deploy EX01
def deploy_ex01(workshop_id, exercise_id):
  contract = "ex01"
  print("DECLARE " + contract)
  out = run_command(f"protostar -p devnet declare ./build/ex01.json --account-address {account_addr} --private-key-path ./.pkey_local --max-fee auto --json")

  print("DEPLOY " + contract)
  class_hash = json.loads(out)['class_hash']
  out = run_command(f"protostar -p devnet deploy {class_hash} --salt {salt} --account-address {account_addr} --private-key-path ./.pkey_local --max-fee auto -i {tderc20_addr} {player_registry_addr} {workshop_id} {exercise_id} --json")

  exercise_contracts[contract] = json.loads(out)['contract_address']
  return

# Deploy EX01
def set_admin_ex(ex_no):
  print("set admin and teacher for " + ex_no)
  ex_contract_addr = exercise_contracts[ex_no]
  out = run_command(f"protostar -p devnet invoke --contract-address {player_registry_addr} --function set_exercise_or_admin --account-address {account_addr} --inputs {ex_contract_addr} 1 --max-fee auto --private-key-path ./.pkey_local --json")

  out = run_command(f"protostar -p devnet invoke --contract-address {tderc20_addr} --function set_teacher --account-address {account_addr} --inputs {ex_contract_addr} 1 --max-fee auto --private-key-path ./.pkey_local --json")

  return

# Deploy EX02
def deploy_ex02():
  return

# Deploy EX03
def deploy_ex03():
  return

# Deploy EX04
def deploy_ex04():
  return

#
# Deploy EX05
#
def deploy_ex05():
  return

# Deploy EX06
def deploy_ex06():
  return

#
# Deploy EX07
#
def deploy_ex07():
  return

# Deploy EX08
def deploy_ex08():
  return

# Deploy EX09
def deploy_ex09():
  return

# Deploy EX10
def deploy_ex10():
  return

# Deploy EX10b
def deploy_ex10b():
  return

# Deploy EX11
def deploy_ex11():
  return

# Deploy EX12
def deploy_ex12():
  return

def deploy_all():
  # build()
  # test()
  deploy_TDERC20()
  deploy_players_registry()
  deploy_ex01(1, 1)
  set_admin_ex("ex01")

  print("tderc20_addr: ", tderc20_addr)
  print("player_registry_addr: ", tderc20_addr)
  print("exercise_contracts: ", exercise_contracts)



deploy_all()