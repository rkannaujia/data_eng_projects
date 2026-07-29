--
use master
GO

--Drop and recreate the DataWarehouse database
IF EXISTS (SELECT 1 FROM sys.databases where name ='DataWarehouse')
BEGIN
	ALTER database DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP database DataWarehouse
END;
GO


--create DataWarehouse database
Create database DataWarehouse;
GO

use DataWarehouse;
GO

create schema bronze;
GO
create schema silver;
GO
create schema gold;
GO