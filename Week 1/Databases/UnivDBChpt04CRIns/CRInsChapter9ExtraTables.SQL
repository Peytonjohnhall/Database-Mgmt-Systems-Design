-- Extra tables for division problems in Chapter 9

-- Drop tables if existing
DROP TABLE StdClub;
DROP TABLE Student1;
DROP TABLE Club;

-- Club table
CREATE TABLE Club (
ClubNo		char(6) not null,
CName		varchar(10) not null,
CPurpose	varchar(10) not null,
CBudget		DECIMAL(10,2),
CActual		DECIMAL(10,2),
CONSTRAINT ClubPk PRIMARY KEY (ClubNo) );

INSERT INTO club
	(ClubNo, CName, CPurpose, CBudget, CActual )
	VALUES('C1','DELTA','SOCIAL',1000.00,1200.00);

INSERT INTO club
	(ClubNo, CName, CPurpose, CBudget, CActual )
	VALUES('C2','BITS','ACADEMIC',500.00,350.00);

INSERT INTO club
	(ClubNo, CName, CPurpose, CBudget, CActual )
	VALUES('C3','HELPS','SERVICE',300.00,330.00);

INSERT INTO club
	(ClubNo, CName, CPurpose, CBudget, CActual )
	VALUES('C4','SIGMA','SOCIAL',NULL,150.00);

-- Student1 table
-- Simplified Student table for division problems

CREATE Table Student1 (
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

-- StdClub table
-- Associative table for a M-N relationship between Student1 and Club

CREATE TABLE StdClub (
ClubNo		char(6) not null,
StdNo		char(6) not null,
CONSTRAINT StdClubPk PRIMARY KEY (ClubNo,StdNo),
CONSTRAINT ClubFK FOREIGN KEY (ClubNo) REFERENCES Club,
CONSTRAINT Student2FK FOREIGN KEY (StdNo) REFERENCES Student1 );

INSERT INTO stdclub
	(StdNo, ClubNo )
	VALUES('S1','C1');

INSERT INTO stdclub
	(StdNo, ClubNo )
	VALUES('S1','C2');

INSERT INTO stdclub
	(StdNo, ClubNo )
	VALUES('S1','C3');

INSERT INTO stdclub
	(StdNo, ClubNo )
	VALUES('S1','C4');

INSERT INTO stdclub
	(StdNo, ClubNo )
	VALUES('S2','C1');

INSERT INTO stdclub
	(StdNo, ClubNo )
	VALUES('S2','C4');

INSERT INTO stdclub
	(StdNo, ClubNo )
	VALUES('S3','C3');

