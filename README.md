Transperent vs UUPS proxies

remember storage is store in the proxy not the implementation

proxy -> implementation -> stores data in proxy

its like
user calls the proxy -> the function is not found in the proxy contract -> triggers fallback
-> fallback delegate call to the implementation

the above one was transperent

proxy contract never use constructor

proxy -> deploy implementation -> call some "initializer function"

y?

```
Constructors are only called during the contract deployment, proxies can't access that information as it's stored on the original contract not on the proxy, meaning, **proxies are completely oblivious to the existence of constructors**.

So, all the initialization will be lost since it was run in the context of the Logic contract and not the Proxy contract.
```

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```
