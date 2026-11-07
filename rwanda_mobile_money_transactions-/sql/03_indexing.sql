-- =====================================================
-- 03_INDEXING.SQL
-- Run after tables and sample data are loaded.
-- Requires the agents column to be named "location".
-- =====================================================

-- An index is a sorted lookup structure that lets PostgreSQL jump to rows
-- instead of reading the whole table.
-- Our tables have only 20 rows, so PostgreSQL normally scans them anyway.
-- To see an index being used, each example turns Seq Scan off temporarily.


-- Remove the old indexes from Tasks 33-36 (redundant or low value).
DROP INDEX IF EXISTS idx_customer_phone;   -- phone_number is UNIQUE: already indexed
DROP INDEX IF EXISTS idx_wallet_balance;
DROP INDEX IF EXISTS idx_transfer_date;
DROP INDEX IF EXISTS idx_transfer_status;  -- only 3 values, never used


-- 1. Sender of a transfer (used in joins, Tasks 21, 24, 31, 32)
CREATE INDEX IF NOT EXISTS idx_transfers_sender
ON transfers(sender_wallet_id);

-- 2. Receiver of a transfer (Task 32)
CREATE INDEX IF NOT EXISTS idx_transfers_receiver
ON transfers(receiver_wallet_id);

-- Example: transfers received by wallet 1 (finds transfer 20 only)
SET enable_seqscan = off;
EXPLAIN ANALYZE
SELECT * FROM transfers WHERE receiver_wallet_id = 1;
RESET enable_seqscan;


-- 3. Transfer date: sorting newest first (Task 8)
CREATE INDEX IF NOT EXISTS idx_transfers_date
ON transfers(transfer_date);

-- Example: 5 newest transfers (reads 5 index entries: transfers 20 to 16)
SET enable_seqscan = off;
EXPLAIN ANALYZE
SELECT * FROM transfers ORDER BY transfer_date DESC LIMIT 5;
RESET enable_seqscan;


-- 4. Successful transfers only (Tasks 11, 12, 23, 29, 30)
-- A partial index stores only matching rows: 16 of our 20 transfers.
CREATE INDEX IF NOT EXISTS idx_transfers_successful_date
ON transfers(transfer_date)
WHERE status = 'Successful';

-- Example: used only because the query repeats status = 'Successful'
SET enable_seqscan = off;
EXPLAIN ANALYZE
SELECT * FROM transfers
WHERE status = 'Successful'
ORDER BY transfer_date;
RESET enable_seqscan;


-- 5. Wallet balance: top balances (Task 18)
CREATE INDEX IF NOT EXISTS idx_wallets_balance
ON wallets(balance);

-- Example: top 5 balances (wallets 10, 3, 18, 14, 7)
SET enable_seqscan = off;
EXPLAIN ANALYZE
SELECT * FROM wallets ORDER BY balance DESC LIMIT 5;
RESET enable_seqscan;


-- 6. Customer history: filter by wallet, newest first (Task 44)
CREATE INDEX IF NOT EXISTS idx_history_wallet_date
ON transaction_history(wallet_id, transaction_date DESC);

-- Example: history of wallet 1 (customer 1), already sorted, no extra sort step
SET enable_seqscan = off;
EXPLAIN ANALYZE
SELECT * FROM transaction_history
WHERE wallet_id = 1
ORDER BY transaction_date DESC;
RESET enable_seqscan;


-- 7. Agent transactions by agent (Tasks 25, 28)
CREATE INDEX IF NOT EXISTS idx_agent_tx_agent
ON agent_transactions(agent_id);

-- Example: transactions of agent 1 (one deposit of 20,000)
SET enable_seqscan = off;
EXPLAIN ANALYZE
SELECT * FROM agent_transactions WHERE agent_id = 1;
RESET enable_seqscan;


-- 8. Agent location (Tasks 10, 16)
CREATE INDEX IF NOT EXISTS idx_agents_location
ON agents(locations);

-- Example: Kigali agents (1, 8, 11, 16, 20)
SET enable_seqscan = off;
EXPLAIN ANALYZE
SELECT * FROM agents WHERE locations = 'Kigali';
RESET enable_seqscan;


-- Update statistics so PostgreSQL plans with the new indexes
ANALYZE;


-- Show all indexes in the database
SELECT tablename, indexname
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;