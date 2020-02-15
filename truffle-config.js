require('babel-register');
require('babel-polyfill');
const dotenv = require("dotenv");
dotenv.config();
const HDWalletProvider = require("@truffle/hdwallet-provider");
module.exports = {
    compilers: {
        solc: {
            version: "^0.6.0",
        },
    },
    networks: {
        mainnet: {
            provider: function() {
                return new HDWalletProvider(process.env.KEY_MAIN, "https://mainnet.infura.io/v3/" + process.env.INFURA_KEY)
            },
            network_id: 1
        },
        ropsten: {
            provider: function() {
                return new HDWalletProvider(process.env.KEY_TEST, "https://ropsten.infura.io/v3/" + process.env.INFURA_KEY)
            },
            network_id: 3
        }
    }
};
