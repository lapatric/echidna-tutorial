# Echidna 

## Properties 

Echidna *properties* are Solidity functions. A property must:

- Have no argument
- Return true if it is successful
- Have its name starting with echidna

Echidna reports any transactions leading a property to return false or throw an error. Side-effects (state variable changes) are discarded after the test.

```solidity
function echidna_property() public returns (bool) { // No arguments are required

    // The following statements can trigger a failure if they revert 
    publicFunction(..);
    internalFunction(..);
    contract.function(..);

    // The following statement can trigger a failure depending on the returned value
    return ..;
} // side effects are *not* preserved

function echidna_revert_property() public returns (bool) { // No arguments is required

    // The following statements can *never* trigger a failure
    publicFunction(..);
    internalFunction(..);
    contract.function(..);

    // The following statement will *always* trigger a failure regardless of the value returned
    return ..;
} // side effects are *not* preserved
```

###Disadvantages
- Since the properties take no parameters, any additional input must be added using a state variable.
- Any revert will be interpreted as a failure, which is not always expected.
- No coverage is collected during its execution *so these properties should be used with simple code*. For anything complex (e.g. with a non-trivial amount of branches), other types of tests should be used.

### Running a property test

Echidna is launched with:
```bash

echidna-test contract.sol
```

If contract.sol contains multiple contracts, you can specify the target:

```bash
echidna-test contract.sol --contract MyContract

# Additionally, you can run Echidna with a config file
echidna-test contract.sol --config config.yaml --contract ContractName
```

## Assertions

Using the *assertion* testing mode, Echidna will report an assert violation if:

- The execution reverts during a call to assert. Technically speaking, Echidna will detect an assertion failure if it executes an assert call that fails in the first call frame of the target contract (so this excludes any internal transactions in most of the cases).
- An AssertionFailed event (with any number of parameters) is emitted by any contract. This pseudo-code summarizes how assertions work:

```solidity
function checkInvariant(..) public { // Any number of arguments is supported

    // The following statements can trigger a failure using `assert`
    assert(..); 
    publicFunction(..);
    internalFunction(..);

    // The following statement will always trigger a failure even if the execution ends with a revert
    emits AssertionFailure(..);

    // The following statement will *only* trigger a failure using `assert` if using solc 0.8.x or newer
    // To make sure it works in older versions, use the AssertionFailure(..) event
    anotherContract.function(..);
    
} // side effects are preserved
```

### Advantages
- Easy to implement, in particular, if there are any number of parameters required to compute the invariant.
- Coverage is collected during the execution of these tests, so it can help to reach new failures.
- If the code base already contains assertions for checking invariants, they can be reused.

### Running a property test

To enable the assertion failure testing in Echidna, you can use `--test-mode assertion` directly from the command line.

```bash
echidna-test assert.sol --test-mode assertion
```
