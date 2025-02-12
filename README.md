## Debugging

## Getting Started

To get started with this repository, follow the steps below:

### 1. Clone the repository

```bash
git clone git@github.com:dutterbutter/min-example-factory.git
```

Navigate into the project directory:

```bash
cd min-example-factory
```

Update `.env` file to own PK. 

### 2. Install Dependencies

Install the necessary dependencies using `forge`:

```bash
forge install
```

### 3. Build the Project for ZKsync

To build the project for ZKsync, run:

```bash
forge build --zksync
```

You may encounter a compilation error due to a placeholder value in the system contracts library.

### 4. Fix the Compilation Error

To fix the compilation error, navigate to the `Constants.sol` file in the `era-contracts` library and replace the placeholder value with the actual system contract offset value:

- File: `lib/era-contracts/system-contracts/contracts/Constants.sol:20:44`
  
- Change:

```solidity
uint160 constant SYSTEM_CONTRACTS_OFFSET = {{SYSTEM_CONTRACTS_OFFSET}}; // 2^15
```

- To:

```solidity
uint160 constant SYSTEM_CONTRACTS_OFFSET = 0x8000; // 2^15
```

### 5. Run script

`forge script script/DeployChild.s.sol --rpc-url zksync-sepolia --skip-simulation -vvvv --zksync --broadcast`
