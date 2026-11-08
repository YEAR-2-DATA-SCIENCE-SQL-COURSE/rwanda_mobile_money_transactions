DROP TABLE IF EXISTS agent_transactions CASCADE;
DROP TABLE IF EXISTS transaction_history CASCADE;
DROP TABLE IF EXISTS transfers CASCADE;
DROP TABLE IF EXISTS wallets CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS agents CASCADE;

-- TABLE 1: AGENTS

CREATE TABLE agents (
    agent_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) UNIQUE,
    locations VARCHAR(100),
    registration_date DATE
);
-- TABLE 2: CUSTOMERS

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) UNIQUE,
    national_id VARCHAR(20) UNIQUE,
    registration_date DATE
);
-- TABLE 3: WALLETS

CREATE TABLE wallets (
    wallet_id INTEGER PRIMARY KEY,
    customer_id INTEGER UNIQUE REFERENCES customers(customer_id),
    balance NUMERIC(15,2) DEFAULT 0 CHECK (balance >= 0),
    currency VARCHAR(5) DEFAULT 'RWF',
    status VARCHAR(20) DEFAULT 'Active'
        CHECK (status IN ('Active', 'Suspended', 'Closed'))
);
-- TABLE 4: TRANSFERS

CREATE TABLE transfers (
    transfer_id INTEGER PRIMARY KEY,
    sender_wallet_id INTEGER REFERENCES wallets(wallet_id),
    receiver_wallet_id INTEGER REFERENCES wallets(wallet_id),
    amount NUMERIC(15,2) NOT NULL CHECK (amount > 0),
    transaction_fee NUMERIC(10,2) DEFAULT 0
        CHECK (transaction_fee >= 0),
    transfer_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20)
        CHECK (status IN ('Successful', 'Failed', 'Pending')),
    CHECK (sender_wallet_id <> receiver_wallet_id)
);
-- TABLE 5: TRANSACTION_HISTORY

CREATE TABLE transaction_history (
    history_id INTEGER PRIMARY KEY,
    wallet_id INTEGER REFERENCES wallets(wallet_id),
    transaction_type VARCHAR(30),
    amount NUMERIC(15,2) CHECK (amount > 0),
    previous_balance NUMERIC(15,2),
    new_balance NUMERIC(15,2),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- TABLE 6: AGENT_TRANSACTIONS

CREATE TABLE agent_transactions (
    agent_transaction_id INTEGER PRIMARY KEY,
    agent_id INTEGER REFERENCES agents(agent_id),
    wallet_id INTEGER REFERENCES wallets(wallet_id),
    transaction_type VARCHAR(20)
        CHECK (transaction_type IN ('Deposit', 'Withdrawal')),
    amount NUMERIC(15,2) CHECK (amount > 0),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
