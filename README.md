Data Engineering Assessment Solution

Database Design

The raw CSV data followed a denormalized structure with all property information in a single flat file. I designed a normalized relational schema consisting of four key tables:

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

Automatic retries for transient failures

This solution provides a maintainable, production-ready pipeline that successfully transforms the flat CSV into a properly normalized database schema while preserving data integrity.

New chat
