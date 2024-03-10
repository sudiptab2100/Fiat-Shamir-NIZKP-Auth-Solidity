# zkAuth: ZK based Authentication System for Ethereum

- Used Fiat-Shamir heuristic to convert a 3-round interactive protocol to a non-interactive zero-knowledge proof.
- Implemented a ZK based authentication system using the above technique.
- Used Foundry to build, test and deploy the smart contract.

## Prover-Py

- Commitment & Proof Generator is implemented in Python.
- Smart Contract interaction through Web3.py.

### Setup

```shell
python3 -m venv env
source env/bin/activate
pip install -r prover-py/requirements.txt
```

### Set Commitment

Set commitment for a user.

```shell
python prover-py/set_commitment.py
```

### Authenticate

Authenticate a user.

```shell
python prover-py/authenticate.py
```

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
forge create --private-key <PRIVATE_KEY> --rpc-url https://eth-sepolia.g.alchemy.com/v2/<API_KEY> --verify --etherscan-api-key <ETHERSCAN_API_KEY> <CONTRACT_NAME>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

## Smart Contract Details

### Get Public Params

```getP(), getQ(), getG()```: get P, Q, G

### Get Authentication Count

```get_k(address user)```: get valid authentication count (k) of a user

### Set Commitment

```set_commitment(uint256 y)```: set commitment for message.sender

### Get Commitment

```get_commitment(address user)```: get commitment of a user

### Check Authenticity

```isAuthentic(uint256 y, uint256 k, uint256 t, uint256 r)```: check if the proof is authentic or not. k is a counter used in generating challenge (c).

### Authenicate

```authenticate(address user, uint256 t, uint256 r)```: authenticate user with proof {t, r}. This will increment the authentication count (k) so that proof can't be reused.
