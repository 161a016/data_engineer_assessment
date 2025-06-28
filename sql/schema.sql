-- schema.sql
-- Runs on container startup to create all tables in home_db

DROP DATABASE IF EXISTS home_db;
CREATE DATABASE home_db;
USE home_db;

-- 1. Addresses
CREATE TABLE IF NOT EXISTS addresses (
  address_id INT PRIMARY KEY,
  street   VARCHAR(255),
  city     VARCHAR(100),
  state    VARCHAR(100),
  zip      VARCHAR(20),
  country  VARCHAR(100)
);

-- 2. Financials
CREATE TABLE IF NOT EXISTS financials (
  financial_id INT PRIMARY KEY,
  list_price DECIMAL(12, 2),
  taxes DECIMAL(10, 2),
  net_yield DECIMAL(5, 2),
  irr DECIMAL(5, 2)
);

-- 3. Properties
CREATE TABLE IF NOT EXISTS properties (
  property_id INT PRIMARY KEY,
  address_id INT NOT NULL,
  financial_id INT NOT NULL,
  property_title VARCHAR(255),
  purchase_date DATE,
  FOREIGN KEY (address_id) REFERENCES addresses(address_id),
  FOREIGN KEY (financial_id) REFERENCES financials(financial_id)
);

-- 4. Features
CREATE TABLE IF NOT EXISTS features (
  feature_id INT PRIMARY KEY,
  property_id INT NOT NULL,
  bedrooms INT,
  bathrooms INT,
  sqft INT,
  has_basement TINYINT(1),
  FOREIGN KEY (property_id) REFERENCES properties(property_id)
);
