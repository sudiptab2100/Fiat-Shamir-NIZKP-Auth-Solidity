import json
import random
from encode_password import encode_password
from generate_commitment import generate_commitment
from hashlib import sha256
from eth_abi.packed import encode_packed


def generate_proof(password, k):
    # Read the public parameters from public_params.json file
    with open('prover-py/files/public_params.json', 'r') as file:
        public_params = json.load(file)
    
    p = public_params['p']
    q = public_params['q']
    g = public_params['g']
    
    x = encode_password(password)
    v = random.randint(1, q)
    t = pow(g, v, p)
    commitment = generate_commitment(password)
    hash_message = encode_packed(['uint256', 'uint256', 'uint256', 'uint256'], [g, commitment, t, k])
    c = int(sha256(hash_message).hexdigest(), 16)
    r = (v - c * x) % q
    
    proof = {
        't': t,
        'r': r
    }
    
    return proof
