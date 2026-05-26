create table StdClub (
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

