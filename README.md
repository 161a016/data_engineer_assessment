
## 📚 How This Document Works

Each section is structured with:

- **Problem:** Background and context for the task
- **Task:** What you are required to do (including any bonus “extra” tasks)
- **Solution:** Where you must document your approach, decisions, and provide instructions for reviewers

> **Tech Stack:**  
> Please use only Python (for ETL/data processing) and SQL/MySQL (for database).  
> Only use extra libraries if they do not replace core logic, and clearly explain your choices in your solution.

  
Tables
addresses
Stores location details (street, city, state, zip, country)

Primary key: address_id

financials

Contains monetary metrics (list price, taxes, net yield, IRR)
Primary key: financial_id

properties

Core property records with purchase dates and titles
Foreign keys: address_id, financial_id
Primary key: property_id

features
Physical characteristics (bedrooms, bathrooms, sqft, basement)
Foreign key: property_id
Primary key: feature_id

Schema Rationale
Implemented proper referential integrity through foreign key constraints

Used appropriate data types (DECIMAL for financials, INT for counts)

Added indexes on frequently queried fields
Normalized to 3NF to minimize redundancy

ETL Pipeline Implementation
Transformation Logic
Data Extraction

Reads CSV using pandas for efficient chunk processing
Parses Excel config for field mappings
Data Cleaning

Handles missing values (NULL for optional fields)

Standardizes formats (consistent date parsing)

Validates financial calculations

Data Loading

Batched INSERTs for performance

Transaction management for data consistency

Error logging for failed records

Execution Instructions
Initialize Database

# Start MySQL container
docker-compose up -d

# Load schema
docker exec -i homellc-mysql mysql -u root -p6equj5_root < sql/schema.sql
Run ETL Process

# Install dependencies
pip install -r requirements.txt

# Execute pipeline
python scripts/etl.py \
  --csv sql/fake_data.csv \
  --config sql/"Field Config.xlsx" \
  --log-level INFO
Verification


-- Check record counts
SELECT 
  (SELECT COUNT(*) FROM properties) AS property_count,
  (SELECT COUNT(*) FROM features) AS feature_count;
Technical Decisions
Python Libraries

pandas: Efficient data manipulation

mysql-connector: Native MySQL Python driver
openpyxl: Excel config parsing
Performance Optimizations
Batch inserts (1000 records/transaction)
Connection pooling
Parallel processing for CPU-intensive tasks

Error Handling
Detailed logging to etl.log
Data validation at each stage


