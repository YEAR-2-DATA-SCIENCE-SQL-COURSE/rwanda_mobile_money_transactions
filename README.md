# Rwanda Mobile Money Transaction Management System

## 1. Introduction

The **Rwanda Mobile Money Transaction Management System** is a PostgreSQL database project designed to manage and monitor mobile money transactions in Rwanda.

The system focuses on managing agents, customers, wallets, money transfers, and transaction history. It provides a structured way to store financial records, track transactions, and monitor wallet balances.

The project uses PostgreSQL to demonstrate relational database concepts, including table creation, primary keys, foreign keys, constraints, relationships, and SQL queries.

## 2. Problem Statement

Mobile money services have become an important part of financial transactions in Rwanda. People use these services to send and receive money, deposit funds, and withdraw cash.

However, managing large amounts of transaction data requires proper database organization to ensure data accuracy, consistency, and easy access to information.

This project addresses the following challenges:

- Difficulty organizing customer and agent information.
- Poor tracking of money transfers and transaction history.
- Difficulty monitoring wallet balances.
- Challenges in identifying successful, pending, and failed transactions.
- Difficulty generating transaction reports and financial summaries.

Therefore, a structured PostgreSQL database is needed to manage mobile money transaction records efficiently.

## 3. Objectives

### 3.1 General Objective

To design and implement a relational database system using PostgreSQL for managing mobile money transactions in Rwanda.

### 3.2 Specific Objectives

1. To create and manage mobile money agent records.
2. To store customer information.
3. To manage customer wallets and their balances.
4. To record money transfers between customers.
5. To maintain transaction history.
6. To manage deposits and withdrawals performed by agents.
7. To retrieve transaction information using SQL queries.
8. To generate reports about transactions and wallet balances.
9. To apply database constraints and relationships to maintain data integrity.

## 4. Research and Key Concepts

This project is based on relational database management concepts.

The following concepts were studied and applied:

| Concept | Description |
|---|---|
| Database | An organized collection of information. |
| PostgreSQL | An open-source relational database management system. |
| Primary Key | Uniquely identifies each record in a table. |
| Foreign Key | Establishes relationships between tables. |
| UNIQUE | Prevents duplicate values in a column. |
| NOT NULL | Ensures that a column cannot contain NULL values. |
| CHECK | Ensures that values satisfy specified conditions. |
| JOIN | Combines records from multiple tables. |
| GROUP BY | Groups records based on common values. |
| Aggregate Functions | Perform calculations such as SUM, AVG, COUNT, MIN and MAX. |
| Indexes | Improve database query performance by allowing PostgreSQL to find records faster without scanning the entire table. |
| Transactions | Ensure database operations are completed consistently. |

## 5. Technical Approach

The project was implemented using PostgreSQL as the primary database management system.

### 5.1 Technologies Used

- **PostgreSQL:** Database management system.
- **SQL:** Language used to create, manage, and retrieve database records.
- **pgAdmin / PostgreSQL Query Tool / VS Code:** Used to execute SQL commands and manage the database.
- **GitHub:** Used for project storage, collaboration, and version control.
- **Draw.io:** Used to design the Entity Relationship Diagram (ERD).
- **PowerBI:** Used for data visualization

### 5.2 Implementation Steps

1. Identify the system requirements.
2. Identify the main entities and their attributes.
3. Design the database structure.
4. Create the database and tables.
5. Define primary keys and foreign keys.
6. Insert sample data.
7. Execute SQL queries.
8. Test relationships and constraints.
9. Generate results and reports.

## 6. Database Design and Diagrams

The database consists of six main tables:

| Table Name | Description |
|---|---|
| AGENTS | Stores information about mobile money agents. |
| CUSTOMERS | Stores registered customer information. |
| WALLETS | Stores customer wallet information and balances. |
| TRANSFERS | Records money transfers between customers. |
| TRANSACTION_HISTORY | Maintains records of wallet transactions. |
| AGENT_TRANSACTIONS | Records deposits and withdrawals performed by agents. |

### 6.1 Entity Relationship Diagram (ERD)

The Entity Relationship Diagram illustrates the structure of the database and the relationships between the six main tables.

![Rwanda Mobile Money ERD](https://github.com/user-attachments/assets/ba97627c-4909-44a7-9bd1-44d90dd873f8)

### 6.2 Database Relationships

The database contains the following relationships:

- One customer can have one wallet.
- One wallet can send multiple transfers.
- One wallet can receive multiple transfers.
- One wallet can have multiple transaction history records.
- One agent can perform multiple agent transactions.
- One wallet can be involved in multiple agent transactions.

## 7. SQL Implementation

All SQL scripts used in this project are organized in the `sql/` directory.

### 7.1 Project Directory Structure

```text
Rwanda-Mobile-Money/
│
├── README.md
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_basic_sql_queries.sql
│   └── 03_indexing.sql
│
├── diagrams/
│   └── mobile_money_erd.png
│
└── presentation/
    └── Rwanda_mobile_money_transaction.pptx
    └── Screenshots

```

### 7.2 SQL Operations Implemented

The project demonstrates the following SQL operations:

- CREATE DATABASE
- CREATE TABLE
- INSERT INTO
- SELECT
- UPDATE
- DELETE
- ALTER TABLE
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- Indexing

## 8. Practical Demonstration and Results

The database was tested using sample data representing mobile money operations in Rwanda.

The practical demonstration includes:

1. Registering agents and customers.
2. Creating customer wallets.
3. Recording money transfers.
4. Recording deposits and withdrawals.
5. Displaying customer wallet balances.
6. Identifying successful and failed transactions.
7. Calculating total transaction amounts.
8. Generating reports using SQL queries.

### 8.1 Expected Results

The system allows users to:

- Retrieve customer and agent information.
- Monitor wallet balances.
- Track transaction records.
- Calculate total money transferred.
- Identify the most active agents.
- Generate transaction summaries.

### 8.2 Screenshots

The screenshots below demonstrate the execution of SQL queries and the results obtained during the practical implementation.

**See the screenshots folder/files in this repository for practical demonstrations.**

## 9. Real-World Applications

This database project demonstrates concepts that can be applied in real mobile money environments.

Possible applications include:

- Mobile money transaction management.
- Customer account management.
- Agent performance monitoring.
- Financial transaction reporting.
- Wallet balance monitoring.
- Transaction auditing.
- Financial data analysis.

The database structure can serve as a learning prototype for systems similar to mobile money services offered by MTN Rwanda and Airtel Rwanda.

## 10. Challenges and Recommendations

### 10.1 Challenges

During the development of this project, the group encountered or considered challenges such as:

1. Understanding database relationships.
2. Defining appropriate primary and foreign keys.
3. Maintaining data consistency.
4. Handling duplicate records.
5. Writing complex SQL queries.
6. Managing transaction records correctly.
7. Collaborating through GitHub.

### 10.2 Recommendations

To improve the system, we recommend:

- Using appropriate database constraints.
- Maintaining accurate transaction records.
- Applying database normalization.
- Using PostgreSQL transactions to protect financial operations.
- Performing regular database backups.
- Implementing proper access control.

### 10.3 Future Improvements

In the future, the system can be improved by introducing:

1. **User Authentication:** Secure login for agents and administrators.
2. **Fraud Detection:** Identify suspicious transaction patterns.
3. **Data Visualization:** Create dashboards showing transaction statistics.
4. **Web Application:** Develop a user-friendly interface.
5. **Mobile Application:** Allow customers to interact with their wallets.
6. **Transaction Notifications:** Send notifications after successful transactions.
7. **Advanced Reporting:** Generate daily, weekly, and monthly financial reports.
8. **Data Science Integration:** Use transaction data to analyze customer behaviour and financial trends.

## 11. References

The following resources were consulted during the development of this project:

1. [PostgreSQL Official Documentation](https://www.postgresql.org/docs/)
2. [PostgreSQL Tutorial](https://www.postgresqltutorial.com/)
3. [W3Schools SQL Tutorial](https://www.w3schools.com/sql/)
4. [Draw.io](https://www.drawio.com/)

## 12. Group Contributions

The following table describes the responsibilities assigned to each group member.

| Group Member ID | Contribution |
|---|---|
| 202520363 | Database design, table creation, and SQL implementation. |
| 202520770 | Research and project introduction. |
| 202520534 | Database relationships and ERD design. |
| 202512173 | Data insertion and SQL query implementation. |
| 202412174 | Testing, documentation, and presentation preparation. |
| 202520487 | Testing, documentation, and presentation preparation. |

## 13. Conclusion

The Rwanda Mobile Money Transaction Management System demonstrates how PostgreSQL can be used to design and manage a relational database for mobile money operations.

Through this project, the group applies practical SQL skills, database design principles, relational concepts, and data management techniques.

The project also provides a foundation for future development in financial technology, database administration, and Data Science.

---

**Project:** Rwanda Mobile Money Transaction Management System

**Database Management System:** PostgreSQL

**Project Type:** Group Database Project
