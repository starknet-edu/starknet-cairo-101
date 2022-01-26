import requests
import json

address = 	"0x00e51aba7c075e73fb8c62d02e6bd084ecc5162b70316707b6bc4fbd7de84d26"
tx_list = []
for i in range(0,5):
	print(i)
	url = "https://goerli.voyager.online/api/txns?to=" + address + "&ps=100&p=" + str(i)
	r = requests.get(url)
	print(url)
	response = r.json()
	local_tx_list = [item["hash"] for item in response["items"]]
	print(local_tx_list)
	for tx in local_tx_list:
		if not tx in tx_list:
			tx_list.append(tx)
print(tx_list)

addresses_list = []
for tx in tx_list:
	if tx == "0x37736cf68a276f84e19b760e07c120d2205cd807cb25210951987125b63a320":
		continue
	url = "https://goerli.voyager.online/api/txn/" + tx
	r = requests.get(url)
	# print(url)
	# print(r.status_code)
	user_address = 0
	if r.status_code != 200:
		#print("Error here")
		url = "https://alpha4.starknet.io/feeder_gateway/get_transaction?transactionHash=" + tx
		r = requests.get(url)
		#print(url)
		if r.status_code != 200:
			print("Error again")
			print(url)
			continue
		response = r.json()
		user_address = int(response["transaction"]["calldata"][0])
	else:
		response = r.json()
		user_address = int(response["calldata"][0])
	if user_address not in addresses_list:
		addresses_list.append(user_address)

print(addresses_list)
print("%d unique addresses" % len(addresses_list))