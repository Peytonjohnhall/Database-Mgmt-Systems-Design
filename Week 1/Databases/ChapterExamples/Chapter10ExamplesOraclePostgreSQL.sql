-- Chapter 10 Oracle and PostgreSQL Examples
-- All examples execute in both Oracl and PostgreSQL unless noted

-- DROP VIEW statements are provided to allow the view to be created more than one time.

-- Section 10.1
-- 10.1
DROP VIEW IS_View;

CREATE VIEW IS_View AS
 SELECT * FROM Student
  WHERE StdMajor = 'IS';

-- 10.2
DROP VIEW MS_View;

CREATE VIEW MS_View AS
 SELECT OfferNo, Offering.CourseNo, CrsUnits, OffTerm,
        OffYear, Offering.FacNo, FacFirstName,
        FacLastName, OffTime, OffDays
  FROM Faculty, Course, Offering
  WHERE FacDept = 'MS' 
    AND Faculty.FacNo = Offering.FacNo
    AND Offering.CourseNo = Course.CourseNo;

-- 10.3a
DROP VIEW Enrollment_View;

CREATE VIEW  Enrollment_View
(OfferNo, CourseNo, Term, OffYear, Instructor, NumStudents) 
 AS
 SELECT Offering.OfferNo, CourseNo, OffTerm, OffYear,
        FacLastName, COUNT(*)
  FROM Offering, Faculty, Enrollment
  WHERE  Offering.FacNo  =  Faculty.FacNo
    AND Offering.OfferNo  =  Enrollment.OfferNo
  GROUP BY Offering.OfferNo, CourseNo, OffTerm, OffYear, 
           FacLastName;

-- 10.3b
DROP VIEW Enrollment_View1;

CREATE VIEW  Enrollment_View AS
 SELECT Offering.OfferNo, CourseNo, OffTerm, OffYear,
        FacLastName AS Instructor, COUNT(*) AS NumStudents
  FROM Offering, Faculty, Enrollment
  WHERE  Offering.FacNo  =  Faculty.FacNo
    AND Offering.OfferNo  =  Enrollment.OfferNo
  GROUP BY Offering.OfferNo, CourseNo, OffTerm, OffYear, 
           FacLastName;

-- Section 10.2
-- 10.4
SELECT OfferNo, CourseNo, FacFirstName, FacLastName,
       OffTime, OffDays
 FROM MS_View
 WHERE OffTerm = 'SPRING' AND OffYear = 2020;

-- 10.5
SELECT OfferNo, CourseNo, Instructor, NumStudents
 FROM Enrollment_View
 WHERE Term = 'SPRING' AND OffYear = 2020 
   AND CourseNo LIKE 'IS%';

-- 10.6
SELECT Instructor, AVG(NumStudents) AS AvgStdCount
 FROM Enrollment_View
 GROUP BY Instructor;

-- 10.7
SELECT OfferNo, Instructor, NumStudents, CrsUnits
 FROM Enrollment_View, Course
 WHERE Enrollment_View.CourseNo = Course.CourseNo 
   AND NumStudents < 5;

-- 10.8
SELECT OfferNo, CourseNo, FacFirstName, FacLastName,
       OffTime, OffDays
 FROM MS_View
 WHERE OffTerm = 'SPRING' AND OffYear = 2020;

-- 10.9
SELECT OfferNo, Course.CourseNo, FacFirstName,
       FacLastName, OffTime, OffDays
 FROM Faculty, Course, Offering
 WHERE FacDept = 'MS' 
   AND Faculty.FacNo = Offering.FacNo
   AND Offering.CourseNo = Course.CourseNo 
   AND OffTerm = 'SPRING' AND OffYear = 2020;

-- 10.10
SELECT OfferNo, CourseNo, FacFirstName, FacLastName,
       OffTime, OffDays
 FROM Faculty, Offering
 WHERE FacDept = 'MS' 
   AND Faculty.FacNo = Offering.FacNo
   AND OffTerm = 'SPRING' AND OffYear = 2020;

-- 10.11
CREATE VIEW Fac_View1 AS 
 SELECT FacNo, FacFirstName, FacLastName, FacRank,
        FacSalary, FacDept, FacCity, FacState, FacZipCode
  FROM Faculty
  WHERE FacDept = 'MS';

-- 10.12
CREATE VIEW Fac_View2 AS 
 SELECT FacDept, FacRank, FacSalary 
  FROM Faculty
  WHERE FacSalary > 50000;

-- 10.13
CREATE View Fac_View3 (FacDept, AvgSalary) AS 
 SELECT FacDept, AVG(FacSalary) 
  FROM Faculty
  WHERE FacRank = 'PROF'
  GROUP BY FacDept;

-- 10.14
INSERT INTO Fac_View1 
 (FacNo, FacFirstName, FacLastName, FacRank, FacSalary,
  FacDept, FacCity, FacState, FacZipCode)
 VALUES ('999-99-8888', 'JOE', 'SMITH', 'PROF', 80000,
         'MS', 'SEATTLE', 'WA', '98011-011');

-- 10.15
UPDATE Fac_View1 
 SET FacSalary = FacSalary * 1.1
 WHERE FacNo = '999-99-8888';

-- 10.16
DELETE FROM Fac_View1
 WHERE FacNo = '999-99-8888';

-- 10.17
INSERT INTO Fac_View1 
 (FacNo, FacFirstName, FacLastName, FacRank, FacSalary,
  FacDept, FacCity, FacState, FacZipCode)
 VALUES ('999-99-8888', 'JOE', 'SMITH', 'PROF', 80000,
         'MS', 'SEATTLE', 'WA', '98011-0011');

UPDATE Fac_View1 
 SET FacDept = 'FIN'
 WHERE FacNo = '999-99-8888';

-- 10.18
CREATE VIEW Fac_View1_Revised AS 
 SELECT FacNo, FacFirstName, FacLastName, FacRank,
        FacSalary, FacDept, FacCity, FacState, FacZipCode
  FROM Faculty
  WHERE FacDept = 'MS'
 WITH CHECK OPTION;

-- Repeat of UPDATE statement in Example 10.17
UPDATE Fac_View1_Revised 
 SET FacDept = 'FIN'
 WHERE FacNo = '999-99-8888';

-- 10.19
CREATE VIEW Course_Offering_View AS
  SELECT Course.CourseNo AS CCourseNo, CrsDesc, CrsUnits,
         OfferNo, OffTerm, OffYear, OffTime,
         Offering.CourseNo AS OCourseNo,
         OffLocation, FacNo, OffDays
	FROM Course INNER JOIN Offering 
        ON Course.CourseNo = Offering.CourseNo;

-- 10.20
INSERT INTO Course_Offering_View
         (OfferNo, OffTerm, OffYear, OffLocation, OffTime,
          FacNo, OffDays, OCourseNo )
         VALUES (9977, 'FALL', 2020, 'BLM410', '13:30:00', NULL,
         'MW', 'IS460');

UPDATE Course_Offering_View
  SET OffYear = 2021
  WHERE OfferNo = 9977;

DELETE FROM Course_Offering_View
  WHERE OfferNo = 9977;

-- Section 10.3
-- Null value effects

-- 10.21
SELECT * 
 FROM Club
 WHERE CBudget > 200;

-- 10.22
SELECT * 
 FROM Club
 WHERE CBudget > CActual;

-- 10.23
SELECT * 
 FROM Club
 WHERE CBudget <= CActual;

-- 10.24
SELECT * 
 FROM Club
 WHERE CBudget <= CActual  
    OR CActual < 200;

-- 10.25
SELECT * 
 FROM Club
 WHERE CBudget <= CActual  
   AND CActual < 500;

-- IN and NOT IN examples

-- Example 10.26
SELECT * 
 FROM Club
 WHERE CBudget IN (300,500);

-- Example 10.27
SELECT * 
 FROM Club
 WHERE CBudget NOT IN (300,500);

-- Example 10.28
SELECT FacNo
 FROM Offering
 WHERE OffTerm = 'SUMMER';

-- Example 10.29
-- List the first name, last name, and department of faculty not teaching in summer term
-- The result contains no rows because Offering.FacNo has null values in some rows.

SELECT FacFirstName, FacLastName, FacDept
 FROM Faculty
 WHERE Faculty.FacNo NOT IN
  ( SELECT FacNo 
     FROM Offering
     WHERE OffTerm = 'SUMMER' ) ;

-- Example 10.30
-- List the first name, last name, and department of faculty not teaching in summer term
-- The IS NOT NULL condition eliminates null faculty numbers in the nested query.

SELECT FacFirstName, FacLastName, FacDept
 FROM Faculty
 WHERE Faculty.FacNo NOT IN
  ( SELECT FacNo 
     FROM Offering
     WHERE OffTerm = 'SUMMER'
       AND FacNo IS NOT NULL ) ;

-- 10.31
SELECT COUNT(*) AS NumRows, 
       COUNT(CBudget) AS NumBudgets 
 FROM Club;

-- 10.32
SELECT SUM(CBudget) AS SumBudget, 
       SUM(CActual) AS SumActual, 
       SUM(CBudget)-SUM(CActual) AS SumDifference,
       SUM(CBudget-CActual) AS SumOfDifferences
 FROM Club;

-- 10.33
SELECT FacNo, COUNT(*) AS NumRows 
 FROM Offering
 GROUP BY FacNo;

-- Section 10.4
-- CREATE TABLE statement and INSERT statements for queries in Section 10.4
-- Executes in both Oracle and PostgreSQL

create table Faculty2(
FacNo			char(11) not null,
FacFirstName		varchar(10) not null,
FacLastName		varchar(10) not null,
FacRank			char(4),
FacHireDate		date,
FacSalary		decimal(10,2),
FacSupervisor		char(11),
CONSTRAINT Faculty2PK PRIMARY KEY (FacNo), 
CONSTRAINT Supervisor2FK FOREIGN KEY (FacSupervisor) REFERENCES Faculty2 );

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('543-21-0987','VICTORIA','EMMANUEL','PROF',120000.0,NULL,'15-Apr-2009');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('765-43-2109','NICKI','MACON','ASSC',105000.00,NULL,'11-Apr-2010');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('654-32-1098','LEONARD','FIBON','ASSC',70000.00,'543-21-0987','01-May-2007');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('098-76-5432','LEONARD','VINCE','ASST',55000.00,'654-32-1098','10-Apr-2008');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('876-54-3210','CRISTOPHER','COLAN','ASST',90000.00,'654-32-1098','01-Mar-2012');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('987-65-4321','JULIA','MILLS','ASSC',95000.00,'765-43-2109','15-Mar-2013');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('111-22-3333','JOHN','MILLSON','PROF',110000.00,'543-21-0987','01-May-2013');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('333-22-4444','SALLY','SCOTT','ASST',90000.00,'111-22-3333','01-May-2014');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('555-66-7777','SUSAN','JONES','ASSC',125000.00,'111-22-3333','01-May-2015');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('777-11-4321','AIMEE','MANNING','ASST',85000.00,'765-43-2109','15-Mar-2014');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('888-33-1111','JAMES','BLOKE','ASST',85000.00,'987-65-4321','15-Apr-2016');

INSERT INTO faculty2
	(FacNo, FacFirstName, FacLastName, FacRank, FacSalary, FacSupervisor, FacHireDate)
	 VALUES ('789-12-3210','JAIME','SANCHEZ','PROF',107000.00,'987-65-4321','10-May-2017');

-- Example 10.34 (Oracle)
-- The basic formulation visits a row for each level on a path. For example, a leaf node on level 3 is visited 3 times.
-- LEVEL is a pseudo column which is used in a hierarchical query to identify the hierarchy level in numeric format. 
-- For each row returned by a hierarchical query, the LEVEL pseudocolumn returns 1 for a root row, 2 for a child of a root, and so on.
-- Pseudocolumns are not actual columns in a table, but they behave like columns.
-- All values are the same except the level.
-- 28 rows: 6 leaf nodes at level 3 (18 rows), 4 nodes at level 2 (8), 2 root nodes
SELECT FacNo, FacSupervisor, FacFirstName, FacLastName, FacHireDate, FacRank, FacSalary, LEVEL
FROM Faculty2
CONNECT BY PRIOR FacNo = FacSupervisor
ORDER BY FacNo, LEVEL;

-- Example 10.35 (Oracle)
-- USE START WITH to visit each row one time. Start with the root employees.
SELECT FacNo, FacSupervisor, FacFirstName, FacLastName, FacHireDate, FacRank, FacSalary, LEVEL
FROM Faculty2
START WITH FacSupervisor IS NULL
CONNECT BY PRIOR FacNo = FacSupervisor
ORDER BY LEVEL;

-- Example 10.36 (Oracle)
-- Show hierarchical organization using the LPAD (left padding) function. 
SELECT LPAD(' ',2*(Level-1)) || FacLastName AS LastName, FacHireDate, FacSalary, FacRank, LEVEL
FROM Faculty2
START WITH FacSupervisor IS NULL
CONNECT BY PRIOR FacNo = FacSupervisor
ORDER SIBLINGS by FacLastName;

-- Example 10.37 (Oracle)
-- Show hierarchical organization using the SYS_CONNECT_BY_PATH function. The second parameter specifies the separator between nodes on a path.
-- Returns the path of a column value from root to node, with column values separated by char for each row returned by CONNECT BY condition

SELECT SYS_CONNECT_BY_PATH(FacLastName,'/') AS Path, FacHireDate, FacSalary, FacRank, LEVEL
FROM Faculty2
START WITH FacSupervisor IS NULL
CONNECT BY PRIOR FacNo = FacSupervisor
ORDER SIBLINGS by FacLastName;

-- Example 10.38 (Oracle)
-- Show root and leaf status using the CONNECT_BY_ROOT function and the CONNECT_BY_ISLEAF function.
SELECT SYS_CONNECT_BY_PATH(FacLastName,'/') AS Path, CONNECT_BY_ROOT FacLastName AS Root, CONNECT_BY_ISLEAF AS IsLeaf, LEVEL, FacHireDate, FacSalary, FacRank 
FROM Faculty2
START WITH FacSupervisor IS NULL
CONNECT BY PRIOR FacNo = FacSupervisor
ORDER SIBLINGS by FacLastName;

-- Example 10.39 (Oracle)
-- Compute total compensation for each employee and subordinate employees
-- A nested query in the FROM clause is necessary because CONNECT_BY_ROOT cannot be used as a grouping column.
-- This statement generates one row per faculty member.
SELECT Root, COUNT(*)-1 AS NumSubordinates, SUM(FacSalary) AS FacSalarySum
FROM
 ( SELECT CONNECT_BY_ROOT FacLastName AS Root, FacSalary
    FROM Faculty2 
    CONNECT BY PRIOR FacNo = FacSupervisor )
GROUP BY Root
ORDER BY COUNT(*) DESC;

-- Example 10.40 (Oracle)
-- Generate the transitive closure using a hierarchical subquery and WHERE condition to eliminate rows not part of the closure.
SELECT *
FROM 
( SELECT FacNo, PRIOR FacNo AS PriorFacNo, CONNECT_BY_ROOT FacNo AS FacSupNo, FacFirstName, FacLastName, LEVEL AS PathLevel, FacSalary, FacRank, 
         SYS_CONNECT_BY_PATH(FacLastName,'/') AS Path
   FROM Faculty2
   CONNECT BY PRIOR FacNo = FacSupervisor )
WHERE FacSupNo <> FacNo
ORDER BY FacLastName, PathLevel;

-- Example 10.41 (Oracle)
-- Supervisors earning less than subordinates
SELECT F1.FacNo, Root AS FacSupNo, F1.FacLastname, F2.FacLastName AS FacSupLastName, F1.FacSalary, F2.FacSalary AS FacSupSalary, Path
FROM 
( SELECT FacNo, FacSupervisor, CONNECT_BY_ROOT FacNo AS Root, SYS_CONNECT_BY_PATH(FacLastName,'/') AS Path, FacLastName, FacSalary
   FROM Faculty2
   CONNECT BY PRIOR FacNo = FacSupervisor ) F1 INNER JOIN Faculty2 F2 ON Root = F2.FacNo
WHERE Root <> F1.FacNo AND F1.FacSalary > F2.FacSalary;

SELECT *
FROM 
( SELECT FacNo, CONNECT_BY_ROOT FacNo AS FacSupNo, FacLastName, CONNECT_BY_ROOT FacLastName AS FacSupLastLastName, 
                FacSalary, CONNECT_BY_ROOT FacSalary AS FacSupSalary
   FROM Faculty2
   CONNECT BY PRIOR FacNo = FacSupervisor )
WHERE FacSupNo <> FacNo AND FacSalary > FacSupSalary;

-- Example 10.42 (Oracle)
-- Supervisors with lower rank than subordinates
-- Ranking order: PROF > ASSC > ASST
SELECT F1.FacNo, Root AS FacSupNo, F1.FacLastname, F2.FacLastName AS FacSupLastName, F1.FacRank, F2.FacRank AS FacSupRank, Path
FROM 
( SELECT FacNo, FacSupervisor, CONNECT_BY_ROOT FacNo AS Root, SYS_CONNECT_BY_PATH(FacLastName,'/') AS Path, FacLastName, FacRank
   FROM Faculty2
   CONNECT BY PRIOR FacNo = FacSupervisor ) F1 INNER JOIN Faculty2 F2 ON Root = F2.FacNo
WHERE Root <> F1.FacNo 
  AND ( ( F1.FacRank = 'PROF' AND F2.FacRank = 'ASSC' )  OR ( F1.FacRank = 'PROF' AND F2.FacRank = 'ASST' ) 
   OR ( F1.FacRank = 'ASSC' AND F2.FacRank = 'ASST' ) );

-- Example 10.43
-- Recursive CTE equivalent to Example 10.35

-- Oracle uses WITH keyword
WITH Faculty2CTE ( FacNo, FacSupervisor, FacFirstName, 
  FacLastName, FacHireDate, FacRank, FacSalary, LevelNo )
AS
( SELECT FacNo, FacSupervisor, FacFirstName, FacLastName, 
         FacHireDate, FacRank, FacSalary, 1
  FROM Faculty2
  WHERE FacSupervisor IS NULL
-- AM referencing Faculty2, the hierarchical table.
UNION ALL
  SELECT F2.FacNo, F2.FacSupervisor, F2.FacFirstName, 
         F2.FacLastName, F2.FacHireDate, F2.FacRank, 
         F2.FacSalary, F2CTE.LevelNo + 1
  FROM Faculty2 F2 INNER JOIN Faculty2CTE F2CTE
    ON F2.FacSupervisor = F2CTE.FacNo
)
-- Statement using the CTE
SELECT * FROM Faculty2CTE
ORDER BY LevelNo, FacNo;

-- PostgreSQL uses WITH RECURSIVE keywords
WITH RECURSIVE Faculty2CTE ( FacNo, FacSupervisor, FacFirstName, 
  FacLastName, FacHireDate, FacRank, FacSalary, LevelNo )
AS
( SELECT FacNo, FacSupervisor, FacFirstName, FacLastName, 
         FacHireDate, FacRank, FacSalary, 1
  FROM Faculty2
  WHERE FacSupervisor IS NULL
-- AM referencing Faculty2, the hierarchical table.
UNION ALL
  SELECT F2.FacNo, F2.FacSupervisor, F2.FacFirstName, 
         F2.FacLastName, F2.FacHireDate, F2.FacRank, 
         F2.FacSalary, F2CTE.LevelNo + 1
  FROM Faculty2 F2 INNER JOIN Faculty2CTE F2CTE
    ON F2.FacSupervisor = F2CTE.FacNo
)
-- Statement using the CTE
SELECT * FROM Faculty2CTE
ORDER BY LevelNo, FacNo;

-- Recursive CTE to generate the transitive closure (all reachable pairs; direct and indirect subordinates)
WITH Faculty2CTE ( FacNo, FacFirstName, FacLastName, 
                   FacSupervisor, LevelNo )
AS
( SELECT FacNo, FacFirstName, FacLastName, FacSupervisor, 0
  FROM Faculty2
-- AM referencing Faculty2, the hierarchical table.
UNION ALL
  SELECT F2.FacNo, F2.FacFirstName, F2.FacLastName, 
         F2CTE.FacSupervisor, F2CTE.LevelNo + 1
  FROM Faculty2 F2 INNER JOIN Faculty2CTE F2CTE
    ON F2.FacSupervisor = F2CTE.FacNo
)
-- Statement using the CTE
SELECT * FROM Faculty2CTE
WHERE LevelNo = 0 OR FacSupervisor IS NOT NULL ;

-- Example 10.44 equivalent to Example 10.41
-- Path exception queries: show monotonicity exceptions on a path (ancestor has less value than descendant)
-- Can only be performed with recursive CTE because PRIOR shows only parent not ancestor data

-- Supervisors earning less than subordinates
-- Oracle statement using WITH keyword

WITH Faculty2CTE ( FacNo, FacSupNo, FacLastName, FacSupLastName, FacSalary, FacSupSalary )             
AS
( SELECT F1.FacNo, F1.FacSupervisor, F1.FacLastName,  F1Sup.FacLastName, F1.FacSalary, F1Sup.FacSalary
  FROM Faculty2 F1 INNER JOIN Faculty2 F1Sup ON F1.FacSupervisor = F1Sup.FacNo
-- AM referencing Faculty2, the hierarchical table.
UNION ALL
  SELECT F2.FacNo, F2CTE.FacSupNo, F2.FacLastName, F2CTE.FacSupLastName, F2.FacSalary, F2CTE.FacSupSalary       
  FROM Faculty2 F2 INNER JOIN Faculty2CTE F2CTE
    ON F2.FacSupervisor = F2CTE.FacNo
)
-- Statement using the CTE
SELECT * FROM Faculty2CTE
WHERE FacSupNo <> FacNo AND FacSalary > FacSupSalary;

-- PostgreSQL uses WITH RECURSIVE keywords

WITH RECURSIVE Faculty2CTE ( FacNo, FacSupNo, FacLastName, FacSupLastName, FacSalary, FacSupSalary )             
AS
( SELECT F1.FacNo, F1.FacSupervisor, F1.FacLastName,  F1Sup.FacLastName, F1.FacSalary, F1Sup.FacSalary
  FROM Faculty2 F1 INNER JOIN Faculty2 F1Sup ON F1.FacSupervisor = F1Sup.FacNo
-- AM referencing Faculty2, the hierarchical table.
UNION ALL
  SELECT F2.FacNo, F2CTE.FacSupNo, F2.FacLastName, F2CTE.FacSupLastName, F2.FacSalary, F2CTE.FacSupSalary       
  FROM Faculty2 F2 INNER JOIN Faculty2CTE F2CTE
    ON F2.FacSupervisor = F2CTE.FacNo
)
-- Statement using the CTE
SELECT * FROM Faculty2CTE
WHERE FacSupNo <> FacNo AND FacSalary > FacSupSalary;

-- Example 10.45 equivalent to Example 10.42
-- Oracle statement using WITH keyword
-- Supervisors with lower rank than subordinates
-- Ranking order: PROF > ASSC > ASST
WITH Faculty2CTE ( FacNo, FacSupNo, FacLastName, FacSupLastName, FacRank, FacSupRank )                
AS
( SELECT F1.FacNo, F1.FacSupervisor, F1.FacLastName,  F1Sup.FacLastName, F1.FacRank, F1Sup.FacRank
  FROM Faculty2 F1 INNER JOIN Faculty2 F1Sup ON F1.FacSupervisor = F1Sup.FacNo
-- AM referencing Faculty2, the hierarchical table.
UNION ALL
  SELECT F2.FacNo, F2CTE.FacSupNo, F2.FacLastName, F2CTE.FacSupLastName, F2.FacRank, F2CTE.FacSupRank
  FROM Faculty2 F2 INNER JOIN Faculty2CTE F2CTE
    ON F2.FacSupervisor = F2CTE.FacNo
)
-- Statement using the CTE
SELECT * FROM Faculty2CTE
WHERE FacSupNo <> FacNo 
  AND ( ( FacRank = 'PROF' AND FacSupRank = 'ASSC' )  
   OR ( FacRank = 'PROF' AND FacSupRank = 'ASST' ) 
   OR ( FacRank = 'ASSC' AND FacSupRank = 'ASST' ) );

-- PostgreSQL uses the WITH RECURSIVE keywords

WITH RECURSIVE Faculty2CTE ( FacNo, FacSupNo, FacLastName, FacSupLastName, FacRank, FacSupRank )                
AS
( SELECT F1.FacNo, F1.FacSupervisor, F1.FacLastName,  F1Sup.FacLastName, F1.FacRank, F1Sup.FacRank
  FROM Faculty2 F1 INNER JOIN Faculty2 F1Sup ON F1.FacSupervisor = F1Sup.FacNo
-- AM referencing Faculty2, the hierarchical table.
UNION ALL
  SELECT F2.FacNo, F2CTE.FacSupNo, F2.FacLastName, F2CTE.FacSupLastName, F2.FacRank, F2CTE.FacSupRank
  FROM Faculty2 F2 INNER JOIN Faculty2CTE F2CTE
    ON F2.FacSupervisor = F2CTE.FacNo
)
-- Statement using the CTE
SELECT * FROM Faculty2CTE
WHERE FacSupNo <> FacNo 
  AND ( ( FacRank = 'PROF' AND FacSupRank = 'ASSC' )  
   OR ( FacRank = 'PROF' AND FacSupRank = 'ASST' ) 
   OR ( FacRank = 'ASSC' AND FacSupRank = 'ASST' ) );





