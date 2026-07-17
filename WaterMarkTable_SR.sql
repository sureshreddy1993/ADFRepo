create login etl_login with password='Datavisa$2026'
create user etl_user for login etl_login

use AzureSQLDatabaseOLTP

create user etl_user for login etl_login

ALTER role DB_DATAREADER ADD MEMBER etl_user

------------------

CREATE TABLE data_source_table
(
  PersonID INT PRIMARY KEY,
  Name VARCHAR(50),
  LastModifytime DATETIME
);

Insert Into data_source_table Values (1, 'aaaa', '2017-09-01 00:56:00.000')
Insert Into data_source_table Values(2, 'bbbb', '2017-09-02 05:23:00.000')
Insert Into data_source_table Values(3, 'cccc', '2017-09-03 02:36:00.000')
Insert Into data_source_table Values(4, 'dddd', '2017-09-04 03:21:00.000')
Insert Into data_source_table Values(5, 'eeee', '2017-09-05 08:06:00.000')
Insert Into data_source_table Values(6, 'ffffff', '2017-09-06 02:23:00.000')


create table watermarktable
(
WatermarkValue datetime,
);
INSERT INTO watermarktable VALUES ('1/1/2010 12:00:00 AM')


CREATE PROCEDURE update_watermark @LastModifiedtime datetime
AS
BEGIN
  UPDATE watermarktable
  SET [WatermarkValue] = @LastModifiedtime
END
--------

ALTER ROLE DB_DATAWRITER ADD MEMBER etl_user
ALTER ROLE DB_DDLADMIN ADD MEMBER etl_user

ALTER ROLE DB_OWNER ADD MEMBER etl_user