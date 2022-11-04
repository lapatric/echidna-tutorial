## Echidna properties 

Echidna *properties* are Solidity functions. A property must:

- Have no argument
- Return true if it is successful
- Have its name starting with echidna

Echidna reports any transactions leading a property to return false or throw an error. Side-effects (state variable changes) are discarded after the test.

```solidity
contract TestToken is Token {
    function echidna_balance_under_1000() public view returns(bool) {
        return balances[msg.sender] <= 1000;
    }
}
```

## Running an Echidna test

Echidna is launched with:
```bash

echidna-test contract.sol
```

If contract.sol contains multiple contracts, you can specify the target:

```bash
echidna-test contract.sol --contract MyContract
```