-- Executes in both Oracle and PostgreSQL
-- Drop table if it exists
-- DROP TABLE Course;

CREATE TABLE Course (
CourseNo	CHAR(6),
CrsDesc		VARCHAR(50) CONSTRAINT CrsDescRequired NOT NULL,
CrsUnits	INTEGER,
CONSTRAINT CoursePK PRIMARY KEY (CourseNo), 
CONSTRAINT UniqueCrsDesc UNIQUE (CrsDesc)  );

-- INSERT statements to populate table
INSERT INTO course
	(CourseNo, CrsDesc, CrsUnits)
	VALUES ( 'FIN300','FUNDAMENTALS OF FINANCE',4);

INSERT INTO course
	(CourseNo, CrsDesc, CrsUnits)
	VALUES ( 'FIN450','PRINCIPLES OF INVESTMENTS',4);
	
INSERT INTO course
	(CourseNo, CrsDesc, CrsUnits)
	VALUES ( 'FIN480','CORPORATE FINANCE',4);
	
INSERT INTO course
	(CourseNo, CrsDesc, CrsUnits)
	VALUES ('IS320','FUNDAMENTALS OF BUSINESS PROGRAMMING',4 );

INSERT INTO course
	(CourseNo, CrsDesc, CrsUnits)
	VALUES ( 'IS460','SYSTEMS ANALYSIS',4);
	
INSERT INTO course
	(CourseNo, CrsDesc, CrsUnits)
	VALUES ( 'IS470','BUSINESS DATA COMMUNICATIONS',4);

INSERT INTO course
	(CourseNo, CrsDesc, CrsUnits)
	VALUES ('IS480','FUNDAMENTALS OF DATABASE MANAGEMENT',4 );

		