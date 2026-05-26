-- Chapter 9 Oracle and PostgreSQL Examples
-- All examples execute in both Oracl and PostgreSQL unless noted

-- Outer join examples
-- 9.1
SELECT OfferNo, CourseNo, Offering.FacNo, Faculty.FacNo, 
       FacFirstName, FacLastName
 FROM Offering LEFT JOIN Faculty 
      ON Offering.FacNo = Faculty.FacNo
 WHERE CourseNo LIKE 'IS%';

-- 9.2
SELECT OfferNo, CourseNo, Offering.FacNo, Faculty.FacNo, 
       FacFirstName, FacLastName
 FROM Faculty RIGHT JOIN Offering 
      ON Offering.FacNo = Faculty.FacNo
 WHERE CourseNo LIKE 'IS%';

-- 9.3
SELECT FacNo, FacFirstName, FacLastName, FacSalary,
       StdNo, StdFirstName, StdLastName, StdGPA
 FROM Faculty FULL JOIN Student 
      ON Student.StdNo = Faculty.FacNo;

-- 9.4
SELECT OfferNo, Offering.CourseNo, OffTerm, CrsDesc,
       Faculty.FacNo, FacFirstName, FacLastName
 FROM Faculty RIGHT JOIN Offering 
      ON Offering.FacNo = Faculty.FacNo
   INNER JOIN Course 
      ON Course.CourseNo = Offering.CourseNo
 WHERE Course.CourseNo LIKE 'IS%' AND OffYear = 2020;

-- 9.5a
SELECT DISTINCT Offering.OfferNo, Offering.CourseNo,
       OffTerm, CrsDesc, Faculty.FacNo, FacFirstName,
       FacLastName
 FROM  Faculty RIGHT JOIN Offering 
      ON Offering.FacNo = Faculty.FacNo 
	INNER JOIN Course 
      ON Course.CourseNo = Offering.CourseNo
	INNER JOIN Enrollment 
      ON Offering.OfferNo = Enrollment.OfferNo
 WHERE Offering.CourseNo LIKE 'IS%' AND OffYear = 2020;

-- 9.5b
SELECT DISTINCT Offering.OfferNo, Offering.CourseNo,
       OffTerm, CrsDesc, Faculty.FacNo, FacFirstName,
       FacLastName
FROM Course INNER JOIN Offering
       ON Course.CourseNo = Offering.CourseNo 
     INNER JOIN Enrollment 
       ON Offering.OfferNo = Enrollment.OfferNo 
     LEFT JOIN Faculty
       ON Offering.FacNo = Faculty.FacNo
WHERE Offering.CourseNo LIKE 'IS%' AND OffYear = 2020;

-- 9.6a 
SELECT Offering.OfferNo, Offering.CourseNo,
       OffTerm, CrsDesc, Faculty.FacNo, FacFirstName, FacLastName
 FROM Faculty LEFT JOIN Offering 
      ON Offering.FacNo = Faculty.FacNo 
  INNER JOIN Course ON Course.CourseNo = Offering.CourseNo;

-- 9.6b
SELECT Offering.OfferNo, Offering.CourseNo,
       OffTerm, CrsDesc, Faculty.FacNo, FacFirstName, FacLastName
 FROM Offering INNER JOIN course 
      ON course.courseno = offering.courseno  
   RIGHT JOIN faculty ON offering.facno = faculty.facno;

-- Nested query examples
-- 9.7
SELECT StdNo, StdFirstName, StdLastName, StdMajor
 FROM Student
 WHERE Student.StdNo IN
  ( SELECT StdNo FROM Enrollment 
      WHERE EnrGrade >= 3.5  );

-- 9.8
SELECT StdFirstName, StdLastName, StdCity, EnrGrade
 FROM Student INNER JOIN Enrollment 
	   ON Student.StdNo = Enrollment.StdNo
 WHERE EnrGrade >= 3.5 AND Enrollment.OfferNo IN
  ( SELECT OfferNo FROM Offering 
     WHERE OffTerm = 'FALL' AND OffYear = 2019 );

-- 9.9
SELECT StdFirstName, StdLastName, StdCity, EnrGrade
 FROM Student, Enrollment 
 WHERE Student.StdNo = Enrollment.StdNo
   AND EnrGrade >= 3.5 AND Enrollment.OfferNo IN
   ( SELECT OfferNo FROM Offering 
	   WHERE OffTerm = 'FALL' AND OffYear = 2019 
        AND FacNo IN
	     ( SELECT FacNo  FROM Faculty 
                 WHERE FacFirstName = 'LEONARD' 
                   AND FacLastName = 'VINCE' )  );

-- 9.10
DELETE FROM Offering
 WHERE Offering.FacNo IN 
  ( SELECT FacNo FROM Faculty 
     WHERE FacFirstName = 'LEONARD' 
       AND FacLastName = 'VINCE' );

-- 9.11
UPDATE Offering SET OffLocation = 'BLM412'
WHERE OffYear = 2020 AND FacNo IN
 ( SELECT FacNo FROM Faculty WHERE FacFirstName = 'LEONARD' AND FacLastName = 'FIBON')

-- Use ROLLBACK to remove effects of update and delete statements if auto commit is not set
ROLLBACK;

-- 9.12
SELECT StdNo, StdFirstName, StdLastName, StdMajor
 FROM Student
 WHERE EXISTS
  ( SELECT StdNo FROM Enrollment 
     WHERE Enrollment.StdNo = Student.StdNo
       AND EnrGrade >= 3.5  );

-- 9.13
SELECT T.CourseNo, T.CrsDesc, COUNT(*) AS NumOfferings, 
       Avg(T.EnrollCount) AS AvgEnroll
 FROM 
  ( SELECT Course.CourseNo, CrsDesc, 
           Offering.OfferNo, COUNT(*) AS EnrollCount
     FROM Offering, Enrollment, Course
     WHERE Offering.OfferNo = Enrollment.OfferNo
       AND Course.CourseNo = Offering.CourseNo
     GROUP BY Course.CourseNo, CrsDesc, Offering.OfferNo
      ) T    
 GROUP BY T.CourseNo, T.CrsDesc;

-- Basic difference examples

-- 9.14
SELECT CourseNo, CrsDesc, CrsUnits
 FROM Course
 WHERE CourseNo NOT IN
  ( SELECT CourseNo FROM Offering );

-- 9.15
SELECT CourseNo, CrsDesc, CrsUnits
 FROM Course
 WHERE CourseNo LIKE 'FIN%'
   AND CourseNo NOT IN
  ( SELECT CourseNo FROM Offering 
      WHERE OffTerm = 'SUMMER' AND OffYear = 2019 );

-- 9.16a
SELECT FacNo, FacFirstName, FacLastName, FacDept,
       FacSalary
 FROM Faculty
 WHERE FacNo NOT IN
  ( SELECT StdNo FROM Student );

-- 9.16b
SELECT FacNo, FacFirstName, FacLastName, FacDept,
       FacSalary
 FROM Faculty
 WHERE ( FacFirstName, FacLastName ) NOT IN
  ( SELECT StdFirstName, StdLastName FROM Student );

-- 9.17
-- List courses offered only in winter terms

SELECT DISTINCT Course.CourseNo, CrsDesc, CrsUnits
 FROM Course, Offering
 WHERE Course.CourseNo = Offering.CourseNo
   AND OffTerm = 'WINTER'
   AND Course.CourseNo NOT IN
  ( SELECT CourseNo FROM Offering 
      WHERE OffTerm <> 'WINTER' );

-- 9.18
SELECT DISTINCT Enrollment.StdNo, StdFirstName,
                StdLastName
 FROM Student, Enrollment, Offering
 WHERE Student.StdNo = Enrollment.StdNo 
   AND Enrollment.OfferNo = Offering.OfferNo 
   AND OffDays = 'TTH'
   AND Enrollment.StdNo NOT IN
   ( SELECT Enrollment.StdNo
      FROM Enrollment, Offering
      WHERE Enrollment.OfferNo = Offering.OfferNo 
        AND OffDays <> 'TTH' );

-- Alternative difference examples

-- 9.19
SELECT FacNo, FacFirstName, FacLastName, FacSalary
 FROM Faculty LEFT JOIN Student 
      ON Faculty.FacNo = Student.StdNo
 WHERE Student.StdNo IS NULL;

SELECT DISTINCT Enrollment.StdNo, StdFirstName,
                StdLastName
 FROM Student, Enrollment, Offering
 WHERE Student.StdNo = Enrollment.StdNo 
   AND Enrollment.OfferNo = Offering.OfferNo 
   AND OffTerm = 'SUMMER'
   AND Enrollment.StdNo NOT IN
   ( SELECT Enrollment.StdNo
      FROM Enrollment, Offering
      WHERE Enrollment.OfferNo = Offering.OfferNo 
        AND OffTerm <> 'SUMMER' );
   
-- 9.20a
-- PostgreSQL only
SELECT FacNo AS PerNo, FacFirstName AS FirstName, 
       FacLastName AS LastName, FacCity AS City, 
       FacState AS State 
 FROM Faculty
      EXCEPT
SELECT StdNo AS PerNo, StdFirstName AS FirstName,
       StdLastName AS LastName, StdCity AS City,
       StdState AS State 
 FROM Student;

-- 9.20b
-- Oracle only
SELECT FacNo AS PerNo, FacFirstName AS FirstName, 
       FacLastName AS LastName, FacCity AS City, 
       FacState AS State 
 FROM Faculty
      MINUS
SELECT StdNo AS PerNo, StdFirstName AS FirstName,
       StdLastName AS LastName, StdCity AS City,
       StdState AS State 
 FROM Student;

-- 9.21
SELECT FacNo, FacFirstName, FacLastName, FacDept,
       FacSalary
 FROM Faculty
 WHERE NOT EXISTS
  ( SELECT * FROM Student
	  WHERE Student.StdNo = Faculty.FacNo );

-- 9.22
SELECT FacNo, FacFirstName, FacLastName, FacDept,
       FacSalary
 FROM Faculty
 WHERE 0 = 
  ( SELECT COUNT(*) FROM Student
	  WHERE Student.StdNo = Faculty.FacNo );

-- Basic division examples and tables used in examples in Section 9.4

-- CREATE TABLE and INSERT statements for examples 9.23 to 9.26 in Section 9.4

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

CREATE TABLE Student1 (
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

-- Commit statement if not auto commit
COMMIT;

-- 9.23
SELECT StdNo 
 FROM StdClub
 GROUP BY StdNo
 HAVING COUNT(*) = ( SELECT COUNT(*) FROM Club );

-- 9.24
SELECT StdNo 
 FROM StdClub, Club 
 WHERE StdClub.ClubNo = Club.ClubNo 
   AND CPurpose = 'SOCIAL'
 GROUP BY StdNo
 HAVING COUNT(*) = 
  ( SELECT COUNT(*) FROM Club 
    WHERE CPurpose = 'SOCIAL' );

-- 9.25
SELECT Student1.StdNo, SName 
 FROM StdClub, Club, Student1
 WHERE StdClub.ClubNo = Club.ClubNo 
   AND Student1.StdNo = StdClub.StdNo
   AND CPurpose = 'SOCIAL'
 GROUP BY Student1.StdNo, SName
 HAVING COUNT(*) = 
  ( SELECT COUNT(*) FROM Club 
     WHERE CPurpose = 'SOCIAL' );

-- 9.26
SELECT ClubNo 
 FROM StdClub, Student1
 WHERE Student1.StdNo = StdClub.StdNo 
   AND SCity = 'SEATTLE'
 GROUP BY ClubNo
 HAVING COUNT(*) = 
  ( SELECT COUNT(*) FROM Student1 
     WHERE SCity = 'SEATTLE' );

-- Advanced division problems
-- 9.27
SELECT Faculty.FacNo, FacFirstName, FacLastName 
 FROM Faculty, Offering
 WHERE Faculty.FacNo = Offering.FacNo
   AND OffTerm = 'FALL' 
   AND CourseNo LIKE 'IS%'
   AND OffYear = 2019
 GROUP BY Faculty.FacNo, FacFirstName, FacLastName
 HAVING COUNT(*) =
  ( SELECT COUNT(*) FROM Offering
    WHERE OffTerm = 'FALL' 
      AND OffYear = 2019 
      AND CourseNo LIKE 'IS%' );

-- 9.28
SELECT Faculty.FacNo, FacFirstName, FacLastName 
 FROM Faculty, Offering
 WHERE Faculty.FacNo = Offering.FacNo 
   AND OffTerm = 'FALL' 
   AND CourseNo LIKE 'IS%'
   AND OffYear = 2019
 GROUP BY Faculty.FacNo, FacFirstName, FacLastName
 HAVING COUNT(DISTINCT CourseNo) =
  ( SELECT COUNT(DISTINCT CourseNo) FROM Offering
     WHERE OffTerm = 'FALL' 
       AND OffYear = 2019 
       AND CourseNo LIKE 'IS%' );

-- 9.29
SELECT Faculty.FacNo, FacFirstName, FacLastName 
 FROM Faculty, Offering, Enrollment, Student
 WHERE Faculty.FacNo = Offering.FacNo 
   AND Offering.OfferNo = Enrollment.OfferNo
   AND Student.StdNo = Enrollment.StdNo
   AND OffTerm = 'FALL' 
   AND CourseNo LIKE 'IS%'
   AND OffYear = 2019 
   AND StdClass = 'SR'
 GROUP BY Faculty.FacNo, FacFirstName, FacLastName
 HAVING COUNT(DISTINCT Student.StdNo) =
  ( SELECT COUNT(*) FROM Student 
     WHERE StdClass = 'SR' );

-- Drop new tables if desired
DROP TABLE StdClub;
DROP TABLE Student1;
DROP TABLE Club;