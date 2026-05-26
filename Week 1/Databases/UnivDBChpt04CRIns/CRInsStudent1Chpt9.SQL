create table Student1 (
StdNo		char(6) not null,
SName		varchar(10) not null,
SCity		varchar(10) not null,
CONSTRAINT Student1Pk PRIMARY KEY (StdNo) );

INSERT INTO student1
	(StdNo, SName, SCity )
	VALUES('S1','JOE','SEATTLE');

INSERT INTO student1
	(StdNo, SName, SCity )
	VALUES('S2','SALLY','SEATTLE');

INSERT INTO student1
	(StdNo, SName, SCity )
	VALUES('S3','SUE','PORTLAND');

