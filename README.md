
# STX-HiveStore

**Decentralized Encrypted Cloud Storage with Provider Reputation and Incentive Model**

---

##  Overview

**STX-HiveStore** is a decentralized cloud storage smart contract built on the Stacks blockchain. It allows users to securely store encrypted file metadata while incentivizing storage providers with a transparent and reputation-based rewards system.

Key features include:

* Encrypted file metadata tracking
* Storage provider registration with stake requirements
* Reputation scoring and incentive model
* File replication support with verification
* Withdrawals based on trust and contribution
* Strict input validation and error handling

---

## 🚀 Features

### 🔐 Secure Metadata Storage

Users can store file metadata (size, encrypted key, timestamp, and providers) using a unique `file-id`. File metadata is only accessible by its owner.

### 👨‍🔧 Storage Provider Registration

Storage providers must stake a minimum amount (≥ 1000 STX) to register. This ensures commitment and filters out low-quality participants.

### 📈 Reputation Scoring System

Providers are rewarded or penalized based on performance:

* **+10** points for a successful storage operation
* **−5** points for a failed operation
  Scores are capped between **0 and 1000**.

### 🧪 File Validation & Limits

* Max file size: **1GB**
* Each file must have between **3 to 10 replicas**
* Strong validations for file ID and encryption key length

### 💰 Conditional Stake Withdrawal

Providers with **≥ 500 reputation** may withdraw their stake—up to their contributed total—after successful participation.

### 📊 Contract Statistics & Utility Functions

* Get storage provider details
* Fetch file metadata (if owner)
* Verify provider registration and reputation

---

## 🛠 Contract Architecture

### 📂 Data Structures

* `storage-files`: stores file metadata keyed by `(file-id, owner)`
* `storage-providers`: stores provider's storage contribution, performance metrics, and reputation

### 🧾 Constants

```clojure
MIN-STORAGE-FEE       ;; u500
MAX-STORAGE-FEE       ;; u5000
storage-fee-per-mb    ;; u10
initial-reputation     ;; u100
max-reputation         ;; u1000
reward-increment       ;; u10
penalty-decrement      ;; u5
```

### 📕 Errors

| Constant                      | Description                        |
| ----------------------------- | ---------------------------------- |
| `ERR-UNAUTHORIZED`            | Caller not allowed                 |
| `ERR-FILE-TOO-LARGE`          | File exceeds max size              |
| `ERR-INSUFFICIENT-FEE`        | Payment does not meet requirements |
| `ERR-FILE-EXISTS`             | Duplicate file detected            |
| `ERR-INVALID-INPUT`           | Input format/length is invalid     |
| `ERR-FILE-NOT-FOUND`          | No such file                       |
| `ERR-PROVIDER-NOT-REGISTERED` | Not registered as a provider       |
| `ERR-INSUFFICIENT-REPUTATION` | Reputation too low                 |
| `ERR-REPLICA-LIMIT-REACHED`   | Too many replicas added            |

---

## 📘 Key Functions

### 📤 `register-storage-provider(initial-stake)`

Registers a new provider if they stake ≥ 1000 STX.

### 🔁 `update-provider-reputation(provider, file-id, was-successful)`

Adjusts provider stats and reputation based on operation success/failure.

### 🔍 `get-file-metadata(file-id)`

Returns file metadata only to the file owner.

### 💸 `withdraw-provider-stake(amount)`

Allows provider to withdraw a portion of their stake if their reputation is ≥ 500.

### 📊 `get-provider-full-stats(provider)`

Returns a provider’s full performance and storage metrics.

---

## ✅ Deployment Considerations

* Deploy only on networks with robust block finality (e.g., Stacks mainnet or testnet).
* Use off-chain oracles/dapps to validate provider operations before calling `update-provider-reputation`.

---

## 🔐 Security Considerations

* File content is **not stored on-chain**, only metadata.
* Ensure proper encryption before interacting with the contract.
* Reputation-based withdrawals discourage malicious providers.

---

## 🧪 Testing Recommendations

* Test provider registration and file upload flow.
* Simulate successful/failed operations to observe reputation change.
* Attempt stake withdrawals at different reputation thresholds.

---

## 🧠 Future Enhancements

* Integration with decentralized file networks (e.g., IPFS, Arweave)
* Auto-replication coordination via off-chain agents
* Governance for adjusting fee structures and penalties

---

## 🧭 License

MIT License

---
