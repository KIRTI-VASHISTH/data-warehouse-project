-- Create the Data Warehouse database
CREATE DATABASE DataWarehouse;
GO

-- Use the Data Warehouse database
USE DataWarehouse;
GO

-- Create schemas for the Medallion Architecture
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
