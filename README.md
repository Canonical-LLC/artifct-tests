This repo contains integration tests for the `artifct-lubc-sc` repo's smart contract.

This repo should live locally in the same parent directory as the `artifct-lubc-sc`.

## Init (only done once)

First create the wallets and get the protocol parameters.

```
$ ./scripts/wallets/make-all-wallets.sh
$ ./scripts/query-protocol-parameters.sh
```


## Creating the Script Address

After compiling the smart contract, it is necessary to make a script address.

First source either the testnet or mainnet environment variables.

For testnet

```
$ source scripts/envars/testnet-env.envvars
```

For mainnet

```
$ source scripts/envars/mainnet-env.envvars
```

The environment variable files set `CARDANO_NODE_SOCKET_PATH` to the path of the appropriate Daedalus socket file (either Testnet Daedalus or the regular mainnet Daedalus). It you run a `cardano-node` on your own you should set this environment variable to your socket file location after sourcing the environment variable file.

Next, run:

```bash
scripts/compile.sh
```

This will make the files `testnet/artifct-lbuc.addr` or `mainnet/artifct-lbuc.addr`.

# Running the tests

To run the tests that are passing run `scripts/tests/all.sh`. If the scripts finish successfully the tests have passed.

To run the problematic tests cases run `scripts/tests/issues.sh`. They currently will not pass.
