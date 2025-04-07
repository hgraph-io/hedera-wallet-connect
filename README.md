# Overview

Hedera is a public distributed ledger that is EVM compatible. This library provides tools to
integrate Hedera using Reown's AppKit and WalletKit.

There are 2 distict paths to integrate Hedera. Hedera natively operates using a gRPC based API
for write transactions and a REST API for read transactions. To acheive EVM compatibility, there
is a software middlelayer called the Hedera JSON-RPC Relay that translates Ethereum JSON-RPC
compatible API calls into the Hedera gRPC and REST API calls.

When integrating, app developers can choose to use the Hedera native approach and send
transactions to wallets over the WalletConnect relays using the JSON-RPC spec defined for Hedera
native transactions or use Ethereum JSON-RPC calls sent to a Hedera JSON-RPC provider that is
separate from the Hedera network nodes.

In short, JSON-RPC is a type of API stucture, such as SOAP, gRPC, REST, GraphQL, etc. In the
Hedera ecosystem, there are distinct concepts regarding JSON-RPC APIs to consider:

- Ethereum JSON-RPC spec defines how to interact with Ethereum compatible networks
- Hedera JSON-RPC Relay implements the Ethereum JSON-RPC spec for Hedera
- Wallets in the Hedera ecosystem support a separate JSON-RPC spec that defines how to send
  transactions to wallets over the WalletConnect relays. This is a Hedera specific spec that is
  not compatible with the Ethereum JSON-RPC spec, rather is used to interact with the Hedera
  network without the JSON-RPC Relay.

For more information see:

- [Hedera Native: JSON-RPC spec](https://docs.reown.com/advanced/multichain/rpc-reference/hedera-rpc).
- [Hedera EVM: JSON-RPC Relay](https://docs.hedera.com/hedera/core-concepts/smart-contracts/json-rpc-relay)
- [@hashgraph/sdk](https://www.npmjs.com/package/@hashgraph/sdk)

## Getting started

The following shows instructions for React though similar steps can be followed for other
frameworks. You can also use the quickstart guide from Reown's AppKit to get started and update
the code as referenced below.

1. Install dependencies

```sh
npm install @reown/appkit @walletconnect/universal-provider @hashgraph/hedera-wallet-connect
```

2. Import this library's adapters and provider to be included in AppKit, the following uses
   react as an example.

```typescript
import { createAppKit } from '@reown/appkit/react'
import { hederaTestnet, hederaMainnet } from '@reown/appkit/networks'
import UniversalProvider from '@walletconnect/universal-provider'

import {
  HederaProvider,
  HederaAdapter,
  HederaChainDefinition,
  hederaNamespace,
} from '@hashgraph/hedera-wallet-connect'

createAppKit({
  adapters: [
    new HederaAdapter({
      projectId,
      networks: [HederaChainDefinition.Native.Mainnet, HederaChainDefinition.Native.Testnet],
      namespace: 'hedera',
    }),
    new HederaAdapter({
      projectId,
      networks: [hederaTestnet, hederaMainnet],
      namespace: 'eip155',
    }),
  ],
  //@ts-expect-error expected type error
  universalProvider: (await HederaProvider.init({
    projectId: "b56e18d47c72ab683b10814fe9495694" // this is a public projectId only to use on localhost
    metadata,
    //logger: 'debug', // optionally set log level
  })) as unknown as UniversalProvider, // avoid type mismatch error due to missing of private properties in HederaProvider
  defaultNetwork: HederaChainDefinition.Native.Mainnet,
  projectId,
  metadata,
  networks: [
    // EVM
    hederaMainnet,
    hederaTestnet,
    // Hedera Native
    HederaChainDefinition.Native.Mainnet,
    HederaChainDefinition.Native.Testnet,
  ],
})
```

## Examples and Demos

- [Example App](https://github.com/hgraph-io/hedera-app)
- [Example Wallet](https://github.com/hgraph-io/hedera-wallet)

## Migration Guide
