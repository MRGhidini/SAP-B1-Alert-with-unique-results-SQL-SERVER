--create intermediary table
IF EXISTS(SELECT * FROM sys.objects where name = '@PN_RESULT')
BEGIN
DROP TABLE [@PN_RESULT];

CREATE TABLE [@PN_RESULT] (
Code nvarchar(25) NOT NULL, 
U_datahora datetime NULL,
);
insert into [@PN_RESULT] select CardCode, createdate from ocrd;
END

ELSE 

BEGIN
CREATE TABLE [@PN_RESULT] (
Code nvarchar(25) NOT NULL, 
U_datahora datetime NULL,
);
insert into [@PN_RESULT] select CardCode, createdate from ocrd;
END