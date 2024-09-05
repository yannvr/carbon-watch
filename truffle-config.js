const HDWalletProvider = require("@truffle/hdwallet-provider");
const { CeloProvider } = require("@celo/contractkit");

require('dotenv').config();  // To store your private keys securely in a .env file

const mnemonic = process.env.MNEMONIC;  // Store your mnemonic in a .env file
// const infuraKey = process.env.INFURA_KEY;  // If needed, for fallback to Infura

module.exports = {
  networks: {
    alfajores: {
      provider: () =>
        new HDWalletProvider(
          mnemonic,
          "https://alfajores-forno.celo-testnet.org"
        ),
      network_id: 44787, // Celo Alfajores testnet ID
      gas: 20000000,
      gasPrice: 50000000000, // Set gas price to 50 Gwei
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true,
    },
    // Celo Mainnet Configuration
    celo: {
      provider: () =>
        new HDWalletProvider({
          mnemonic: {
            phrase: mnemonic,
          },
          providerOrUrl: "https://forno.celo.org",
        }),
      network_id: 42220, // Celo mainnet network id
      gas: 20000000, // Gas limit
      gasPrice: 500000000, // Gas price
      timeoutBlocks: 200,
      skipDryRun: true,
    },
  },
  compilers: {
    solc: {
      version: "0.8.0", // Fetch exact version from solc-bin (default: truffle's version)
    },
  },
};
