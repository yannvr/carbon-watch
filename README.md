# Carbon Watch

A blockchain-based application for tracking and managing household carbon emissions on the Celo blockchain.

## Overview

Carbon Watch is a smart contract deployed on the Celo Alfajores testnet that allows users to:
- Log household electricity, water, gas, fuel usage, waste generation, and vehicle distance
- Automatically calculate carbon emissions based on usage metrics
- Track historical carbon footprint data

## Testnet Contract

The smart contract is deployed on the Celo Alfajores testnet:
- Contract Address: [0x834b79962Ef74C1c79cD43757c4Ad71Ec05331cB](https://explorer.celo.org/alfajores/address/0x834b79962Ef74C1c79cD43757c4Ad71Ec05331cB/contracts#address-tabs)

## Getting Started

### Prerequisites

- [Bun](https://bun.sh) (v1.1.12 or later)
- Node.js (v16 or later)

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/carbon-watch.git
cd carbon-watch

# Install dependencies
bun install
```

### Development

```bash
# Start the development server with hot reloading
bun run dev

# Run the application
bun run start
```

### Smart Contract Development

```bash
# Compile the smart contract
bun run compile

# Deploy to network (configured in truffle-config.js)
bun run migrate

# Run tests
bun run test
```

## Environment Variables

Create a `.env` file in the project root with the following variables:

```
MNEMONIC=your_mnemonic_phrase_here
INFURA_KEY=your_infura_key_here
```

## License

This project is licensed under the MIT License.