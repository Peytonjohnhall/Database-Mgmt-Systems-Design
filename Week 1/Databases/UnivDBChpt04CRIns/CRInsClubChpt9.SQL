-- Club table for chapter 9

create table Club (
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
