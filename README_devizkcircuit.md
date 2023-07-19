# ZK Circuit Implementation

This project demonstrates a new zkSNARK circuit that implements some logical operations. And after that it deploys a verifier on-chain to verify proofs generated from this circuit

## Description

This project aims to create a verifiable computation system using zk-SNARKs (Zero-Knowledge Succinct Non-Interactive Arguments of Knowledge). The goal is to implement a circuit in Circom (a domain-specific language for zk-SNARK circuits), compile it to generate intermediate files, and then generate a zero-knowledge proof for a specific computation using the inputs A=0 and B=1. The first step is to design and write the correct circuit in Circom. After writing the circuit, it needs to be compiled to generate the necessary intermediaries. The compilation process will create important files required for generating proofs later on. With the compiled circuit and the specified inputs (A=0 and B=1), the project will generate a zero-knowledge proof. This proof will demonstrate that the computation was correctly performed without revealing the actual inputs or intermediate values used in the calculation. The proof is generated in a way that anyone can verify it without knowing the inputs.he next step is to deploy a Solidity smart contract as the verifier to the POLYGON Testnet.

## Getting Started

### Implementing the logic for circuit

1. Go to the circuit.circom

2. name your template and add the logic:

 
```
pragma circom 2.0.0;

/*This circuit template checks the working of the logic gates*/  

template devizkcircuit () {  

  // Declaration of signals.  

// input signals 

  signal input a;  
  signal input b; 

// gate signals

   signal x;
   signal y;

// output signal

   signal output q;  

 // AND GATE 
   x <== a * b;  

// NOT GATE
   y <== 1 + b - 2*b;

//OR GATE
   q <== x+y-x*y;
}

component main = devizkcircuit();
```

3. go to input.json file: set a=0 and b=1.   

### Executing program

#### Installing
npm i

#### Compiling
npx hardhat circom This will generate the out file with circuit intermediaries and geneate the  contract.

#### Proof and Deploying
npx hardhat run scripts/deploy.ts This script does 4 things

Deploys the contract
Generates a proof from circuit intermediaries with generateProof()
Generates calldata with generateCallData()
Calls verifyProof() on the verifier contract with calldata

### Deploying to a Testnet

1. Create a .env file to store the privatekey of the account.
2. Go to hardhat.config.ts file, add the network. Use mubmbai public rpc url and import the env file for the key.

```
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
// https://github.com/projectsophon/hardhat-circom
import "hardhat-circom";
// circuits
import circuits = require('./circuits.config.json')
import "dotenv/config";

// set env var to the root of the project
process.env.BASE_PATH = __dirname;

// tasks
import "./tasks/newcircuit.ts"

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      {
        version: "0.8.17",
      },
      {
        version: "0.6.11",
      }
    ]
  },
  networks: {
    mumbai: {
      url: `https://rpc.ankr.com/polygon_mumbai`,
      accounts: [process.env.MUMBAIPRIVATEKEY]
    }},
  circom: {
    // (optional) Base path for input files, defaults to `./circuits/`
    inputBasePath: "./circuits",
    // (required) The final ptau file, relative to inputBasePath, from a Phase 1 ceremony
    ptau: "powersOfTau28_hez_final_12.ptau",
    // (required) Each object in this array refers to a separate circuit
    circuits: JSON.parse(JSON.stringify(circuits))
  },
};

export default config;

```
3. After that type:  npx hardhat run scripts/deploy.ts --network mumbai

It pops up with successful verified address, copy that and paste it into mumbai testnet.

## Authors

Contributors names and contact info

 
 [B DEVI](devibattini@gmail.com)


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
