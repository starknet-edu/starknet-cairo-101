import subprocess, json
from utils import str_to_felt, felt_to_str

# essential settings
account_addr = "0x33507ff2edf12c12c73d0b6d1d90de9fac12a355de1097ab305249612451919"
salt = 1
tderc20_addr = "0x"
player_registry_addr = "0x"
pkey_name = ".pkey"
network = "devnet"
exercise_contracts = {}
max_fee = "auto"

def run_command(cmd):
  out = subprocess.check_output(cmd.split(" "))
  return out.decode("utf-8")

# Build
def build():
  print("BUILD")
  run_command("protostar build")
  return

# Test
def test():
  print("Test")
  run_command("protostar test")
  return

# Deploy TDERC20
def deploy_TDERC20():
  contract = "tderc20"
  print("DECLARE " + contract)
  out = run_command(f"protostar -p {network} declare ./build/TDERC20.json --account-address {account_addr} --private-key-path ./{pkey_name} --max-fee {max_fee} --wait-for-acceptance --json")

  print("DEPLOY " + contract)
  token_name = str_to_felt("starknet-cairo-101")
  token_symbol = str_to_felt("SC101")
  class_hash = json.loads(out)['class_hash']
  out = run_command(f"protostar -p {network} deploy {class_hash} --salt {salt} --account-address {account_addr} --private-key-path ./{pkey_name} --max-fee {max_fee} -i {token_name} {token_symbol} 0 0 {account_addr} {account_addr} --wait-for-acceptance --json")

  global tderc20_addr
  tderc20_addr = json.loads(out)['contract_address']

  return

# Deploy Players Registry
def deploy_players_registry():
  contract = "players_registry"
  print("DECLARE " + contract)
  out = run_command(f"protostar -p {network} declare ./build/players_registry.json --account-address {account_addr} --private-key-path ./{pkey_name} --max-fee {max_fee} --wait-for-acceptance --json")

  print("DEPLOY " + contract)
  class_hash = json.loads(out)['class_hash']
  out = run_command(f"protostar -p {network} deploy {class_hash} --salt {salt} --account-address {account_addr} --private-key-path ./{pkey_name} --max-fee {max_fee} -i {account_addr} --wait-for-acceptance --json")

  global player_registry_addr
  player_registry_addr = json.loads(out)['contract_address']
  return

#
# Deploy EX01, EX03, EX04, EX05, EX06, EX07, EX08, EX09, EX10, EX11, EX12
#
def deploy_ex_common(contract, workshop_id, exercise_id):
  print("DECLARE " + contract)
  out = run_command(f"protostar -p {network} declare ./build/{contract}.json --account-address {account_addr} --private-key-path ./{pkey_name} --max-fee {max_fee} --wait-for-acceptance --json")

  print("DEPLOY " + contract)
  class_hash = json.loads(out)['class_hash']
  out = run_command(f"protostar -p {network} deploy {class_hash} --salt {salt} --account-address {account_addr} --private-key-path ./{pkey_name} --max-fee {max_fee} -i {tderc20_addr} {player_registry_addr} {workshop_id} {exercise_id} --wait-for-acceptance --json")

  exercise_contracts[contract] = json.loads(out)['contract_address']
  print(contract + " contract:" +  exercise_contracts[contract])
  return

# Deploy EX02
def deploy_ex02(workshop_id, exercise_id, my_secret_value):
  contract = "ex02"
  print("DECLARE " + contract)
  out = run_command(f"protostar -p {network} declare ./build/{contract}.json --account-address {account_addr} --private-key-path ./{pkey_name} --max-fee {max_fee} --wait-for-acceptance --json")
  print("DEPLOY " + contract)
  class_hash = json.loads(out)['class_hash']
  out = run_command(f"protostar -p {network} deploy {class_hash} --salt {salt} --account-address {account_addr} --private-key-path ./{pkey_name} --max-fee {max_fee} -i {tderc20_addr} {player_registry_addr} {workshop_id} {exercise_id} {my_secret_value} --wait-for-acceptance --json")
  exercise_contracts[contract] = json.loads(out)['contract_address']
  print(contract + " contract:" +  exercise_contracts[contract])
  return

# Deploy EX10b
def deploy_ex10b():
  contract = "ex10b"
  ex10_contract = exercise_contracts["ex10"]
  print("DECLARE ex10b")
  out = run_command(f"protostar -p {network} declare ./build/{contract}.json --account-address {account_addr} --private-key-path ./{pkey_name} --max-fee {max_fee} --wait-for-acceptance --json")
  print("DEPLOY ex10b")
  class_hash = json.loads(out)['class_hash']
  out = run_command(f"protostar -p {network} deploy {class_hash} --salt {salt} --account-address {account_addr} --private-key-path ./{pkey_name} --max-fee {max_fee} -i {ex10_contract} --wait-for-acceptance --json")
  exercise_contracts[contract] = json.loads(out)['contract_address']
  print(contract + " contract:" +  exercise_contracts[contract])
  return

# Deploy EX13
def deploy_ex13(workshop_id, exercise_id, list_length, random_number_list):
  contract = "ex13"
  print("DECLARE " + contract)
  out = run_command(f"protostar -p {network} declare ./build/{contract}.json --account-address {account_addr} --private-key-path ./{pkey_name} --max-fee {max_fee} --wait-for-acceptance --json")
  print("DEPLOY " + contract)
  class_hash = json.loads(out)['class_hash']
  list_string = ' '.join(str(e) for e in random_number_list)
  out = run_command(f"protostar -p {network} deploy {class_hash} --salt {salt} --account-address {account_addr} --private-key-path ./{pkey_name} --max-fee {max_fee} -i {tderc20_addr} {player_registry_addr} {workshop_id} {exercise_id} {list_length} {list_string} --wait-for-acceptance --json")
  exercise_contracts[contract] = json.loads(out)['contract_address']
  print(contract + " contract:" +  exercise_contracts[contract])
  return

# Set Admin and Teacher
def set_admin_ex(ex_no):
  print("set admin and teacher for " + ex_no)
  ex_contract_addr = exercise_contracts[ex_no]
  run_command(f"protostar -p {network} invoke --contract-address {player_registry_addr} --function set_exercise_or_admin --account-address {account_addr} --inputs {ex_contract_addr} 1 --max-fee {max_fee} --private-key-path ./{pkey_name} --wait-for-acceptance --json")
  run_command(f"protostar -p {network} invoke --contract-address {tderc20_addr} --function set_teacher --account-address {account_addr} --inputs {ex_contract_addr} 1 --max-fee {max_fee} --private-key-path ./{pkey_name} --wait-for-acceptance --json")
  return

# Set Random Number
def set_random_number(ex_no, list_length, random_number_list):
  print("set random number for " + ex_no)
  ex_contract_addr = exercise_contracts[ex_no]
  list_string = ' '.join(str(e) for e in random_number_list)
  run_command(f"protostar -p {network} invoke --contract-address {ex_contract_addr} --function set_random_values --account-address {account_addr} --inputs {list_length} {list_string} --max-fee {max_fee} --private-key-path ./{pkey_name} --wait-for-acceptance --json")
  return

def print_all_contracts():
  print(f"Yo starknet fans, all contracts deployed successfully on {network}!")
  print("=================================================================================")
  print(f"tderc20_addr: {tderc20_addr}")
  print(f"player_registry_addr: {player_registry_addr}")
  for contract_name, contract_address in exercise_contracts.items():
    print(f"{contract_name}: {contract_address}")
  print("=================================================================================")
  return

def deploy_all():
  build()
  # test()
  deploy_TDERC20()
  deploy_players_registry()
  print("tderc20_addr: ", tderc20_addr)
  print("player_registry_addr: ", player_registry_addr)
  deploy_ex_common("ex01", 1, 1)
  set_admin_ex("ex01")
  deploy_ex02(1, 2, 31020)
  set_admin_ex("ex02")
  deploy_ex_common("ex03",1, 3)
  set_admin_ex("ex03")
  deploy_ex_common("ex04",1, 4)
  set_admin_ex("ex04")
  set_random_number("ex04", 100, [8003,5046,4552,1465,683,1178,8813,3285,8477,7562,9182,5595,1091,7930,8572,9931,1370,2021,3736,4921,4359,6054,6777,122,8886,6327,3601,5967,6498,8063,6299,1803,3916,6167,7056,6125,4158,631,3104,1649,7215,8433,4444,4906,8256,3958,126,1105,4471,3828,1280,6794,3270,1513,7649,3356,3309,4153,7750,8136,3346,4585,3075,501,3377,7077,2615,8131,69,4464,5283,5319,2313,6254,1939,9484,7907,4817,3339,5026,5567,1115,2029,5418,9037,8074,6215,3154,9159,3327,7672,3258,2039,9777,768,1170,5934,6529,8160,1275])
  deploy_ex_common("ex05",1, 5)
  set_admin_ex("ex05")
  set_random_number("ex05", 100, [9680,3502,1249,9711,4841,185,9222,6477,9849,4935,3552,9346,9668,9375,7223,8620,9654,9427,897,5185,3016,7306,6530,9854,3861,8992,9167,6993,9986,2327,8183,1762,1306,6779,8732,2920,8075,8862,287,1147,5577,9929,9250,7796,5380,9556,2088,6483,9422,6333,7178,4634,2654,6972,4553,4375,489,2367,2992,3747,2874,2791,906,4452,4858,155,4160,1327,6462,8720,6159,3506,1037,7361,5500,2205,548,3512,3050,1475,532,3750,9655,7143,148,7806,9750,1314,9764,1051,9410,2215,8653,3582,8078,1167,8309,7600,8476,5976])
  deploy_ex_common("ex06",1, 6)
  set_admin_ex("ex06")
  set_random_number("ex06", 100, [5096,5996,6373,9285,8973,3013,2108,7300,9387,165,4148,5651,5860,2415,3115,2378,162,8791,112,1420,3967,640,5048,4119,6191,1545,186,5704,2897,4394,3630,6475,5996,1339,7756,223,167,9274,4643,4017,8229,3457,1036,9401,489,5931,1970,446,6681,6733,3980,9457,9432,2972,1363,2637,4369,4859,3345,4394,6653,3710,5850,9677,1137,25,4427,5105,4128,7722,6329,745,2918,8689,3239,7571,7443,9725,5734,1181,6792,9518,1292,3985,7084,3956,2230,6128,164,8310,4320,171,7756,4853,2331,8397,5910,2311,5941,8786])
  deploy_ex_common("ex07",1, 7)
  set_admin_ex("ex07")
  deploy_ex_common("ex08",1, 8)
  set_admin_ex("ex08")
  deploy_ex_common("ex09",1, 9)
  set_admin_ex("ex09")
  deploy_ex_common("ex10",1, 10)
  deploy_ex10b()
  set_admin_ex("ex10")
  deploy_ex_common("ex11",1, 11)
  set_admin_ex("ex11")
  deploy_ex_common("ex12",1, 12)
  set_admin_ex("ex12")
  set_random_number("ex12", 100, [5919,2682,7799,7765,9255,2249,8673,8649,9605,9669,9298,7384,8376,4535,5215,3552,4969,6803,8787,7403,7665,3286,1907,2228,5957,8153,6286,4738,7617,8216,9892,973,3389,941,663,3824,4120,9933,1237,570,3598,3360,2837,4401,2385,5226,8762,9335,6541,5965,4642,5677,8434,6027,8255,9684,487,8089,880,2532,3258,7896,416,6382,9127,6130,581,8543,5394,2321,2179,1657,464,6558,168,5035,5641,9209,1626,7485,7111,6225,9902,9584,8783,4900,4534,7004,3618,5641,7900,5585,7029,5298,2725,7107,6881,1626,9654,2022])
  deploy_ex13(1, 13, 100, [5919,2682,7799,7765,9255,2249,8673,8649,9605,9669,9298,7384,8376,4535,5215,3552,4969,6803,8787,7403,7665,3286,1907,2228,5957,8153,6286,4738,7617,8216,9892,973,3389,941,663,3824,4120,9933,1237,570,3598,3360,2837,4401,2385,5226,8762,9335,6541,5965,4642,5677,8434,6027,8255,9684,487,8089,880,2532,3258,7896,416,6382,9127,6130,581,8543,5394,2321,2179,1657,464,6558,168,5035,5641,9209,1626,7485,7111,6225,9902,9584,8783,4900,4534,7004,3618,5641,7900,5585,7029,5298,2725,7107,6881,1626,9654,2022])
  deploy_ex_common("ex14",1, 14)
  set_admin_ex("ex14")
  print_all_contracts()

deploy_all()