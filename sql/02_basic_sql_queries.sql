-- =====================================================
-- 10. BASIC SQL QUERIES
-- =====================================================

-- TASK 1: Display all agents.

SELECT * FROM agents;

-- TASK 2: Display all customers.

SELECT * FROM customers;

-- TASK 3: Display all wallets.

SELECT * FROM wallets;

-- TASK 4: Display customers with wallet balances.

SELECT
    c.first_name,
    c.last_name,
    w.balance
FROM customers c
INNER JOIN wallets w
ON c.customer_id = w.customer_id;

-- TASK 5: Find wallets with balances greater than 50000.

SELECT *
FROM wallets
WHERE balance > 50000;

-- TASK 6: Display successful transfers.

SELECT *
FROM transfers
WHERE status = 'Successful';


-- TASK 7: Display failed transfers.

SELECT *
FROM transfers
WHERE status = 'Failed';

-- TASK 8: Order transfers from newest to oldest.

SELECT *
FROM transfers
ORDER BY transfer_date DESC;

-- TASK 9: Find a customer using their phone number.

SELECT *
FROM customers
WHERE phone_number = '0788234501';


-- TASK 10: Display agents working in Kigali.

SELECT *
FROM agents
WHERE location = 'Kigali';


-- =====================================================
-- 11. INTERMEDIATE SQL QUERIES
-- =====================================================

-- TASK 11: Calculate total successful transfers.

SELECT
    SUM(amount) AS total_successful_transfers
FROM transfers
WHERE status = 'Successful';


-- TASK 12: Calculate average transaction amount.

SELECT
    AVG(amount) AS average_transaction_amount
FROM transfers
WHERE status = 'Successful';


-- TASK 13: Find the highest transfer amount.

SELECT
    MAX(amount) AS highest_transfer
FROM transfers;


-- TASK 14: Find the lowest transfer amount.

SELECT
    MIN(amount) AS lowest_transfer
FROM transfers;


-- TASK 15: Count all transfers.

SELECT
    COUNT(*) AS total_transfers
FROM transfers;


-- TASK 16: Count agents in each location.

SELECT
    location,
    COUNT(*) AS total_agents
FROM agents
GROUP BY location;


-- TASK 17: Calculate total wallet balance.

SELECT
    SUM(balance) AS total_wallet_balance
FROM wallets;


-- TASK 18: Find the five customers with the highest balances.

SELECT
    c.first_name,
    c.last_name,
    w.balance
FROM customers c
INNER JOIN wallets w
ON c.customer_id = w.customer_id
ORDER BY w.balance DESC
LIMIT 5;


-- TASK 19: Count transfers according to status.

SELECT
    status,
    COUNT(*) AS total_transactions
FROM transfers
GROUP BY status;


-- TASK 20: Find customers with balances below 50000.

SELECT
    c.first_name,
    c.last_name,
    w.balance
FROM customers c
INNER JOIN wallets w
ON c.customer_id = w.customer_id
WHERE w.balance < 50000;


-- =====================================================
-- 12. ADVANCED SQL QUERIES
-- =====================================================

-- TASK 21: Find the customer who sent the highest total amount.

SELECT
    c.first_name,
    c.last_name,
    SUM(t.amount) AS total_sent
FROM customers c
INNER JOIN wallets w
ON c.customer_id = w.customer_id
INNER JOIN transfers t
ON w.wallet_id = t.sender_wallet_id
WHERE t.status = 'Successful'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_sent DESC
LIMIT 1;


-- TASK 22: Find customers who never made a successful transfer.

SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM wallets w
    INNER JOIN transfers t
    ON w.wallet_id = t.sender_wallet_id
    WHERE w.customer_id = c.customer_id
    AND t.status = 'Successful'
);


-- TASK 23: Calculate total successful transaction fees.

SELECT
    SUM(transaction_fee) AS total_transaction_fees
FROM transfers
WHERE status = 'Successful';


-- TASK 24: Find the top 10 customers by transaction volume.

SELECT
    c.first_name,
    c.last_name,
    COUNT(t.transfer_id) AS total_transactions,
    SUM(t.amount) AS total_amount
FROM customers c
INNER JOIN wallets w
ON c.customer_id = w.customer_id
INNER JOIN transfers t
ON w.wallet_id = t.sender_wallet_id
WHERE t.status = 'Successful'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_amount DESC
LIMIT 10;


-- TASK 25: Count transactions performed by each agent.

SELECT
    a.agent_id,
    a.first_name,
    a.last_name,
    COUNT(at.agent_transaction_id) AS total_transactions
FROM agents a
LEFT JOIN agent_transactions at
ON a.agent_id = at.agent_id
GROUP BY a.agent_id, a.first_name, a.last_name
ORDER BY total_transactions DESC;


-- TASK 26: Calculate total deposits.

SELECT
    SUM(amount) AS total_deposits
FROM agent_transactions
WHERE transaction_type = 'Deposit';


-- TASK 27: Calculate total withdrawals.

SELECT
    SUM(amount) AS total_withdrawals
FROM agent_transactions
WHERE transaction_type = 'Withdrawal';


-- TASK 28: Find the most active agent.

SELECT
    a.agent_id,
    a.first_name,
    a.last_name,
    COUNT(at.agent_transaction_id) AS total_transactions
FROM agents a
INNER JOIN agent_transactions at
ON a.agent_id = at.agent_id
GROUP BY a.agent_id, a.first_name, a.last_name
ORDER BY total_transactions DESC
LIMIT 1;


-- TASK 29: Display daily transaction volumes.

SELECT
    DATE(transfer_date) AS transaction_day,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM transfers
WHERE status = 'Successful'
GROUP BY DATE(transfer_date)
ORDER BY transaction_day;


-- TASK 30: Display monthly transaction volumes.

SELECT
    DATE_TRUNC('month', transfer_date) AS transaction_month,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM transfers
WHERE status = 'Successful'
GROUP BY DATE_TRUNC('month', transfer_date)
ORDER BY transaction_month;


-- TASK 31: Find wallets with more than five successful transfers.

SELECT
    w.wallet_id,
    c.first_name,
    c.last_name,
    COUNT(t.transfer_id) AS total_transactions
FROM wallets w
INNER JOIN customers c
ON w.customer_id = c.customer_id
INNER JOIN transfers t
ON w.wallet_id = t.sender_wallet_id
WHERE t.status = 'Successful'
GROUP BY w.wallet_id, c.first_name, c.last_name
HAVING COUNT(t.transfer_id) > 5;


-- TASK 32: Display sender and receiver information.

SELECT
    t.transfer_id,
    sender.first_name AS sender_first_name,
    sender.last_name AS sender_last_name,
    receiver.first_name AS receiver_first_name,
    receiver.last_name AS receiver_last_name,
    t.amount,
    t.transaction_fee,
    t.status,
    t.transfer_date
FROM transfers t
INNER JOIN wallets sw
ON t.sender_wallet_id = sw.wallet_id
INNER JOIN customers sender
ON sw.customer_id = sender.customer_id
INNER JOIN wallets rw
ON t.receiver_wallet_id = rw.wallet_id
INNER JOIN customers receiver
ON rw.customer_id = receiver.customer_id;


-- =====================================================
-- 13. INDEXES
-- =====================================================

-- TASK 33: Create index on customer phone numbers.

CREATE INDEX idx_customer_phone
ON customers(phone_number);


-- TASK 34: Create index on wallet balances.

CREATE INDEX idx_wallet_balance
ON wallets(balance);


-- TASK 35: Create index on transfer dates.

CREATE INDEX idx_transfer_date
ON transfers(transfer_date);


-- TASK 36: Create index on transfer status.

CREATE INDEX idx_transfer_status
ON transfers(status);


-- TASK 37: Check query execution performance.

EXPLAIN ANALYZE
SELECT *
FROM transfers
WHERE status = 'Successful';


-- =====================================================
-- 14. UPDATE AND ALTER TABLE OPERATIONS
-- =====================================================

-- TASK 38: Update a customer's wallet balance.

UPDATE wallets
SET balance = 200000
WHERE wallet_id = 1;


-- TASK 39: Change an agent's location.

UPDATE agents
SET location = 'Kigali'
WHERE agent_id = 2;


-- TASK 40: Suspend a customer's wallet.

UPDATE wallets
SET status = 'Suspended'
WHERE wallet_id = 5;


-- TASK 41: Add an email column to customers.

ALTER TABLE customers
ADD COLUMN email VARCHAR(100);


-- TASK 42: Count all registered customers.

SELECT
    COUNT(*) AS total_customers
FROM customers;


-- TASK 43: Find the customer with the highest wallet balance.

SELECT
    c.first_name,
    c.last_name,
    w.balance
FROM customers c
INNER JOIN wallets w
ON c.customer_id = w.customer_id
WHERE w.balance = (
    SELECT MAX(balance)
    FROM wallets
);


-- TASK 44: Display transaction history for a customer.

SELECT
    c.first_name,
    c.last_name,
    th.transaction_type,
    th.amount,
    th.previous_balance,
    th.new_balance,
    th.transaction_date
FROM customers c
INNER JOIN wallets w
ON c.customer_id = w.customer_id
INNER JOIN transaction_history th
ON w.wallet_id = th.wallet_id
WHERE c.customer_id = 1
ORDER BY th.transaction_date DESC;


-- TASK 45: Find customers with suspended wallets.

SELECT
    c.first_name,
    c.last_name,
    w.balance,
    w.status
FROM customers c
INNER JOIN wallets w
ON c.customer_id = w.customer_id
WHERE w.status = 'Suspended';


-- =====================================================
-- 15. ADDITIONAL DATABASE CHECKS
-- =====================================================

-- Display the total number of records in each table.

SELECT 'AGENTS' AS table_name, COUNT(*) AS total_records
FROM agents

UNION ALL

SELECT 'CUSTOMERS', COUNT(*)
FROM customers

UNION ALL

SELECT 'WALLETS', COUNT(*)
FROM wallets

UNION ALL

SELECT 'TRANSFERS', COUNT(*)
FROM transfers

UNION ALL

SELECT 'TRANSACTION_HISTORY', COUNT(*)
FROM transaction_history

UNION ALL

SELECT 'AGENT_TRANSACTIONS', COUNT(*)
FROM agent_transactions;


-- Display all indexes created in the current database.

SELECT
    tablename,
    indexname,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename;


-- =====================================================
-- END OF PROJECT SQL SCRIPT
-- =====================================================