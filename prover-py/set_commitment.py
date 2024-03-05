from web3 import Web3
import json
import os
from generate_commitment import generate_commitment


with open("prover-py/files/abi.json") as f, open("prover-py/files/contract.json") as g:
    contract_abi = json.load(f)
    contract_details = json.load(g)

contract_address = contract_details["address"]
rpc_url = contract_details["api"]
chain_id = contract_details["chainId"]

w3 = Web3(Web3.HTTPProvider(rpc_url))
contract = w3.eth.contract(address=contract_address, abi=contract_abi)

private_key = os.getenv("ETH_PRIVATE_KEY")
sender_address = w3.eth.account.from_key(private_key).address

password = "pAs$word987654321p"
commitment = generate_commitment(password)
print(f"Commitment: {commitment}")
set_commitment_tx = contract.functions.set_commitment(commitment).build_transaction(
    {
        "nonce": w3.eth.get_transaction_count(sender_address),
        "gasPrice": w3.eth.gas_price,
        "gas": 300000,  # Adjust gas limit accordingly
        "chainId": chain_id,
    }
)


signed_tx = w3.eth.account.sign_transaction(set_commitment_tx, private_key)
tx_hash = w3.eth.send_raw_transaction(signed_tx.rawTransaction)
print(f"Transaction hash: {tx_hash.hex()}")
