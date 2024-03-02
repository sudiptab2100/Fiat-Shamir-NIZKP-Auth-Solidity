import json
from encode_password import encode_password


def generate_commitment(password):
    # Read the contents of public_params.json file
    with open('prover-py/files/public_params.json', 'r') as file:
        public_params = json.load(file)
    
    p = public_params['p']
    q = public_params['q']
    g = public_params['g']
    
    ep = encode_password(password)
    commitment = pow(g, ep, p)
    
    return commitment