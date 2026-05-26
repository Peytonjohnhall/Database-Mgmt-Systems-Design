-- Chapter 4 Oracle Examples

-- 4.1
SELECT StdFirstName, StdLastName, StdCity, StdGPA
  FROM Student
  WHERE StdGPA >= 3.7;

-- 4.2
SELECT * FROM Faculty;

-- 4.3a
-- PostgreSQL
SELECT FacFirstName, FacLastName, FacCity, 
       FacSalary*1.1 AS IncreasedSalary, FacHireDate 
 FROM  Faculty 
 WHERE date_part('year', FacHireDate) > 2008;

-- 4.3b
-- Oracle
SELECT FacFirstName, FacLastName, FacCity, 
       FacSalary*1.1 AS IncreasedSalary, FacHireDate 
 FROM Faculty 
 WHERE to_number(to_char(FacHireDate, 'YYYY' ) ) > 2008;

-- 4.4a
-- PostgreSQL
SELECT FacFirstName, FacLastName, FacCity, FacHireDate 
 FROM  Faculty 
 WHERE date_part('year', FacHireDate) >= 
       date_part('year', Current_Date) - 10;

-- 4.4b
-- Oracle
SELECT FacFirstName, FacLastName, FacCity, FacHireDate 
 FROM  Faculty 
 WHERE to_number(to_char(FacHireDate, 'YYYY' ) ) >= 
       to_number(to_char(SYSDATE, 'YYYY' ) ) - 10

-- 4.5
SELECT StdFirstName, StdLastName, StdCity, StdGPA 
 FROM  Student 
 WHERE StdGPA < 3.7 AND StdGPA * 1.1 >= 3.7;

-- 4.6
SELECT * 
 FROM Course 
 WHERE CourseNo = 'IS480';

-- 4.7
SELECT * 
 FROM Course 
 WHERE UPPER(CourseNo) = 'IS480';

-- 4.8
SELECT * 
 FROM Course 
 WHERE CourseNo LIKE 'IS4%';

-- 4.9
SELECT * 
 FROM Course 
 WHERE CrsDesc LIKE '%DATA%';

-- 4.10
SELECT *
 FROM Course 
 WHERE CrsDesc LIKE '%MENT';

-- 4.11
SELECT *
 FROM Course 
 WHERE LOWER(CourseNo) LIKE 'fin%';

-- 4.12
SELECT FacFirstName, FacLastName, FacRank
 FROM Faculty 
 WHERE FacLastName LIKE '____N';

-- 4.13
SELECT FacFirstName, FacLastName, FacHireDate 
 FROM Faculty 
 WHERE FacHireDate BETWEEN '1-Jan-2011' AND '31-Dec-2012';

-- 4.14a
-- PostgreSQL
SELECT FacFirstName, FacLastName, FacHireDate 
 FROM  Faculty 
 WHERE date_part('month', FacHireDate) = 4;

-- 4.14b
- Oracle
SELECT FacFirstName, FacLastName, FacHireDate 
 FROM  Faculty 
 WHERE to_number(to_char(FacHireDate, 'MM' ) ) = 4

-- 4.15
SELECT OfferNo, CourseNo 
 FROM Offering 
 WHERE FacNo IS NULL 
   AND OffTerm = 'SUMMER' 
   AND OffYear = 2020;

-- 4.16
SELECT OfferNo, CourseNo, FacNo, OffTerm, OffYear
 FROM Offering 
 WHERE (OffTerm = 'FALL' AND OffYear = 2019) 
    OR (OffTerm = 'WINTER' AND OffYear = 2020);

-- 4.17
SELECT OfferNo, Offering.CourseNo, OffDays, OffTime 
 FROM Offering, Course 
 WHERE OffTerm = 'SPRING' AND OffYear = 2020
   AND (CrsDesc LIKE '%DATABASE%' 
    OR CrsDesc LIKE '%PROGRAMMING%') 
   AND Course.CourseNo = Offering.CourseNo;

-- 4.18
SELECT OfferNo, CourseNo, FacFirstName, FacLastName 
 FROM Offering, Faculty 
 WHERE OffTerm = 'FALL' AND OffYear = 2019 
   AND FacRank = 'ASST' AND CourseNo LIKE 'IS%'
   AND Faculty.FacNo = Offering.FacNo;

-- 4.19
SELECT OfferNo, CourseNo, FacFirstName, FacLastName  
 FROM Offering INNER JOIN Faculty 
   ON Faculty.FacNo = Offering.FacNo
 WHERE OffTerm = 'FALL' AND OffYear = 2019 
   AND FacRank = 'ASST' AND CourseNo LIKE 'IS%';

-- 4.20
SELECT StdMajor, AVG(StdGPA) AS AvgGPA
 FROM Student 
 GROUP BY StdMajor;

-- 4.21
SELECT OffYear, COUNT(*) AS NumOfferings, 
       COUNT(DISTINCT CourseNo) AS NumCourses
 FROM Offering
 GROUP BY OffYear;

-- 4.22
SELECT StdMajor, AVG(StdGPA) AS AvgGpa 
 FROM Student 
 WHERE StdClass = 'JR' OR StdClass = 'SR'
 GROUP BY StdMajor;

-- 4.23
SELECT StdMajor, AVG(StdGPA) AS AvgGpa 
 FROM Student 
 WHERE StdClass IN ('JR', 'SR')
 GROUP BY StdMajor 
 HAVING AVG(StdGPA) > 3.1;

-- 4.24
SELECT COUNT(*) AS StdCnt, AVG(StdGPA) AS AvgGPA 
 FROM Student 
 WHERE StdClass IN ('JR','SR');

-- 4.25
SELECT StdMajor, StdClass, MIN(StdGPA) AS MinGPA, 
       MAX(StdGPA) AS MaxGPA, COUNT(*) AS CountRows
 FROM Student 
 GROUP BY StdMajor, StdClass;

-- 4.26
SELECT CrsDesc, COUNT(*) AS OfferCount 
 FROM Course, Offering  
 WHERE Course.CourseNo = Offering.CourseNo 
   AND Course.CourseNo LIKE 'IS%'  
 GROUP BY CrsDesc;

-- 4.27
SELECT StdGPA, StdFirstName, StdLastName, StdCity,
       StdState 
 FROM Student 
 WHERE StdClass = 'JR'
 ORDER BY StdGPA;

-- 4.28
SELECT FacRank, FacSalary, FacFirstName, FacLastName,
       FacDept 
 FROM Faculty 
 ORDER BY FacRank, FacSalary DESC;

-- 4.29
SELECT FacCity, FacState 
  FROM Faculty;

-- 4.30
SELECT DISTINCT FacCity, FacState 
 FROM Faculty;

-- 4.31
SELECT CourseNo, Enrollment.OfferNo, 
       AVG(EnrGrade) AS AvgGrade
 FROM Enrollment, Offering
 WHERE CourseNo LIKE 'IS%' AND OffYear = 2019 
   AND OffTerm = 'FALL' 
   AND Enrollment.OfferNo = Offering.OfferNo
 GROUP BY CourseNo, Enrollment.OfferNo
 HAVING  COUNT(*) > 1
 ORDER BY CourseNo, 3 DESC;

-- 4.31a
SELECT CourseNo, Offering.OfferNo, StdNo, EnrGrade
 FROM Enrollment, Offering
 WHERE Enrollment.OfferNo = Offering.OfferNo
   AND CourseNo LIKE 'IS%' 
   AND OffYear = 2019 
   AND OffTerm = 'FALL' 
   AND Enrollment.OfferNo = Offering.OfferNo
 ORDER BY CourseNo, OfferNo ;

-- 4.31b
SELECT CourseNo, Offering.OfferNo, 
       AVG(EnrGrade) AS AvgGrade
 FROM Enrollment, Offering
 WHERE CourseNo LIKE 'IS%' AND OffYear = 2019 
   AND OffTerm = 'FALL' 
   AND Enrollment.OfferNo = Offering.OfferNo
 GROUP BY CourseNo, Offering.OfferNo;

-- 4.32
SELECT StdFirstName, StdLastName, OfferNo, EnrGrade 
 FROM Student, Enrollment 
 WHERE Student.StdNo = Enrollment.StdNo
   AND EnrGrade >= 3.5;

-- 4.33
SELECT StdFirstName, StdLastName 
 FROM Student, Enrollment 
 WHERE EnrGrade >= 3.5 
   AND Student.StdNo = Enrollment.StdNo;

-- 4.34
SELECT DISTINCT StdFirstName, StdLastName 
 FROM Student, Enrollment 
 WHERE EnrGrade >= 3.5 
   AND Student.StdNo = Enrollment.StdNo;

-- 4.35
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo =  Enrollment.OfferNo 
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- 4.36
SELECT OfferNo, Offering.CourseNo, CrsUnits, OffDays,
       OffLocation, OffTime
 FROM Faculty, Course, Offering 
 WHERE Faculty.FacNo = Offering.FacNo
   AND Offering.CourseNo = Course.CourseNo 
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND FacFirstName = 'LEONARD' 
   AND FacLastName = 'VINCE';

-- 4.37
SELECT Offering.OfferNo, Offering.CourseNo, OffDays,
       OffLocation, OffTime, FacFirstName, FacLastName
 FROM Faculty, Offering, Enrollment, Student 
 WHERE Offering.OfferNo = Enrollment.OfferNo
   AND Student.StdNo = Enrollment.StdNo 
   AND Faculty.FacNo = Offering.FacNo 
   AND OffYear = 2020 AND OffTerm = 'SPRING' 
   AND StdFirstName = 'BOB' 
   AND StdLastName = 'NORBERT';

-- 4.38
SELECT Offering.OfferNo, Offering.CourseNo, OffDays,
       OffLocation, OffTime, CrsUnits, FacFirstName,
       FacLastName
 FROM Faculty, Offering, Enrollment, Student, Course
 WHERE Faculty.FacNo = Offering.FacNo 
   AND Offering.OfferNo = Enrollment.OfferNo
   AND Student.StdNo = Enrollment.StdNo
   AND Offering.CourseNo = Course.CourseNo
   AND OffYear = 2020 AND OffTerm = 'SPRING' 
   AND StdFirstName = 'BOB'
   AND StdLastName = 'NORBERT';

-- 4.39
SELECT StdFirstName, StdLastName, StdCity, EnrGrade
 FROM Student INNER JOIN Enrollment 
   ON Student.StdNo = Enrollment.StdNo
 WHERE EnrGrade >= 3.5;

-- 4.40
SELECT StdFirstName, StdLastName, StdCity, EnrGrade
 FROM  Student INNER JOIN Enrollment 
     ON Student.StdNo = Enrollment.StdNo 
  INNER JOIN Offering
    ON Offering.OfferNo = Enrollment.OfferNo
 WHERE EnrGrade >= 3.5 AND OffTerm = 'FALL' 
   AND OffYear = 2019;

-- 4.41
SELECT StdFirstName, StdLastName, StdCity, EnrGrade
 FROM Student INNER JOIN Enrollment 
       ON Student.StdNo = Enrollment.StdNo 
  INNER JOIN Offering 
     ON Offering.OfferNo = Enrollment.OfferNo 
  INNER JOIN Faculty ON Faculty.FacNo = Offering.FacNo
 WHERE EnrGrade >= 3.5 AND OffTerm = 'FALL' 
   AND OffYear = 2019 AND FacFirstName = 'LEONARD'
   AND FacLastName = 'VINCE';

-- 4.42
SELECT StdFirstName, StdLastName, StdCity, EnrGrade, CrsUnits
 FROM Student INNER JOIN Enrollment 
       ON Student.StdNo = Enrollment.StdNo 
  INNER JOIN Offering 
     ON Offering.OfferNo = Enrollment.OfferNo 
  INNER JOIN Faculty ON Faculty.FacNo = Offering.FacNo
  INNER JOIN Course ON Offering.CourseNo = Course.CourseNo
 WHERE EnrGrade >= 3.5 AND OffTerm = 'FALL' 
   AND OffYear = 2019 AND FacFirstName = 'LEONARD'
   AND FacLastName = 'VINCE';

-- 4.43
SELECT Student.* 
 FROM Student, Faculty 
 WHERE StdNo = FacNo;

-- 4.44
SELECT Subr.FacNo, Subr.FacLastName, Subr.FacSalary, 
       Supr.FacNo, Supr.FacLastName, Supr.FacSalary
 FROM Faculty Subr, Faculty Supr
 WHERE Subr.FacSupervisor = Supr.FacNo 
   AND Subr.FacSalary > Supr.FacSalary;

-- 4.45
SELECT FacFirstName AS SubFacFirstName, 
       FacLastName AS SubFacLastName, O1.CourseNo
FROM Faculty, Offering O1, Offering O2
 WHERE Faculty.FacNo = O1.FacNo 
   AND Faculty.FacSupervisor = O2.FacNo 
   AND O1.CourseNo = O2.CourseNo
   AND O1.OffYear = 2020 AND O2.OffYear = 2020;

-- 4.46
SELECT F1.FacFirstName AS SubFacFirstName, 
       F1.FacLastName AS SubFacLastName, 
       F2.FacFirstName AS SupFacFirstName, 
       F2.FacLastName AS SupFacLastName, O1.CourseNo
FROM Faculty F1, Faculty F2, Offering O1, Offering O2
 WHERE F1.FacNo = O1.FacNo 
   AND F1.FacSupervisor = O2.FacNo 
   AND F1.FacSupervisor = F2.FacNo
   AND O1.CourseNo = O2.CourseNo
   AND O1.OffYear = 2020 AND O2.OffYear = 2020;

-- 4.47
SELECT CourseNo, Enrollment.OfferNo, 
       Count(*) AS NumStudents
 FROM Offering, Enrollment
 WHERE Offering.OfferNo = Enrollment.OfferNo
   AND OffYear = 2020 AND OffTerm = 'SPRING' 
 GROUP BY Enrollment.OfferNo, CourseNo;

-- 4.48
SELECT CourseNo, Enrollment.OfferNo, Avg(StdGPA) AS AvgGPA
 FROM Student, Offering, Enrollment
 WHERE Offering.OfferNo = Enrollment.OfferNo
   AND Enrollment.StdNo = Student.StdNo 
   AND OffYear = 2019 AND OffTerm = 'FALL' 
 GROUP BY CourseNo, Enrollment.OfferNo 
 HAVING Avg(StdGPA) > 3.0;

-- 4.49a (PostgreSQL)
SELECT date_part('year',FacHireDate) AS FacHireYear, OffYear, 
       COUNT(*) as NumCourses
 FROM Offering, Faculty
 WHERE Offering.FacNo = Faculty.FacNo 
   AND date_part('year',FacHireDate) > 2006
 GROUP BY date_part('year',FacHireDate), OffYear;

-- 4.49b (Oracle)
SELECT to_number(to_char(FacHireDate, 'YYYY') ) AS FacHireYear, OffYear, 
       COUNT(*) as NumCourses
 FROM Offering, Faculty
 WHERE Offering.FacNo = Faculty.FacNo 
   AND to_number(to_char(FacHireDate, 'YYYY') ) > 2006
 GROUP BY to_number(to_char(FacHireDate, 'YYYY' ) ), OffYear;

-- 4.50
SELECT FacFirstName, FacLastName, Offering.OfferNo, Course.CourseNo,
       AVG(StdGPA) AS AvgGPA, COUNT(*) AS EnrollCnt
 FROM Faculty, Student, Offering, Course, Enrollment
 WHERE Faculty.FacNo = Offering.FacNo
   AND Offering.OfferNo = Enrollment.OfferNo
   AND Course.CourseNo = Offering.CourseNo
   AND Enrollment.StdNo = Student.StdNo
   AND Offering.OffYear = 2020
   AND Offering.OffTerm = 'SPRING'
 GROUP BY FacFirstName, FacLastName, Offering.OfferNo, Course.CourseNo
 HAVING COUNT(*) > 2
 ORDER BY AVG(StdGPA) DESC;

-- 4.51
SELECT FacNo AS PerNo, FacFirstName AS FirstName,
       FacLastName AS LastName, FacCity AS City, 
       FacState AS State 
 FROM Faculty
	UNION 
SELECT StdNo AS PerNo, StdFirstName AS FirstName,
       StdLastName AS LastName, StdCity AS City, 
       StdState AS State 
 FROM Student;

-- 4.52
SELECT FacNo AS PerNo, FacFirstName AS FirstName, 
       FacLastName AS LastName, FacCity AS City, 
       FacState AS State 
 FROM Faculty
   INTERSECT
SELECT StdNo AS PerNo, StdFirstName AS FirstName, 
       StdLastName AS LastName, StdCity AS City, 
       StdState AS State 
 FROM Student;

-- 4.53 (Oracle)
SELECT FacNo AS PerNo, FacFirstName AS FirstName, 
       FacLastName AS LastName, FacCity AS City, 
       FacState AS State 
 FROM Faculty
     MINUS
SELECT StdNo AS PerNo, StdFirstName AS FirstName, 
       StdLastName AS LastName, StdCity AS City, 
       StdState AS State 
 FROM Student;

-- 4.53 (PostgreSQL)
SELECT FacNo AS PerNo, FacFirstName AS FirstName, 
       FacLastName AS LastName, FacCity AS City, 
       FacState AS State 
 FROM Faculty
     EXCEPT
SELECT StdNo AS PerNo, StdFirstName AS FirstName, 
       StdLastName AS LastName, StdCity AS City, 
       StdState AS State 
 FROM Student;

-- 4.54
INSERT INTO Student 
 (StdNo, StdFirstName, StdLastName, 
  StdCity, StdState, StdZip, StdClass, StdMajor, StdGPA) 
 VALUES ('999999999', 'JOE', 'STUDENT', 'SEATAC', 
         'WA', '98042-1121', 'FR', 'IS', 0.0);

CREATE TABLE ISStudent
( StdNo 	    CHAR(11)    CONSTRAINT StdNoRequiredISStd NOT NULL,
  StdFirstName  VARCHAR(50) CONSTRAINT StdFirstNameRequiredISStd NOT NULL,
  StdLastName   VARCHAR(50) CONSTRAINT StdLastNameRequiredISStd NOT NULL,
  StdCity	    VARCHAR(50) CONSTRAINT StdCityRequiredISStd NOT NULL,
  StdState	    CHAR(2)	    CONSTRAINT StdStateRequiredISStd NOT NULL,
  StdZip	    CHAR(10)    CONSTRAINT StdZipRequiredISStd NOT NULL,
  StdMajor	    CHAR(6),
  StdClass	    CHAR(6),
  StdGPA	    DECIMAL(3,2) DEFAULT 0,	
  CONSTRAINT PKISStudent PRIMARY KEY (StdNo),	
  CONSTRAINT ValidGPAISStd CHECK ( StdGPA BETWEEN 0 AND 4 ),
  CONSTRAINT ValidStdClassISStd CHECK (StdClass IN ('FR','SO', 'JR','SR')),
  CONSTRAINT MajorDeclaredISStd CHECK 
               ( StdClass IN ('FR','SO') OR StdMajor IS NOT NULL ) );

-- 4.55
-- This query assumes that you have created a new table (ISStudent) with the same columns as Student.
INSERT INTO ISStudent 
 SELECT * FROM Student WHERE StdMajor = 'IS';

-- 4.56
UPDATE Faculty 
 SET FacSalary = FacSalary * 1.1 
 WHERE FacDept = 'MS';

-- 4.57
UPDATE Student 
 SET StdMajor = 'ACCT', StdClass = 'SO' 
 WHERE StdFirstName = 'HOMER' 
   AND StdLastName = 'WELLS';

-- 4.58
DELETE FROM Student 
 WHERE StdMajor = 'IS' AND StdClass = 'SR';

-- 4.59
-- This query assumes that you have created a new table (ISStudent) with the same columns as Student.

DELETE FROM ISStudent;

-- 4.60
-- Original statement with syntax errors
SELECT OfferNo, CourseNo, FacNo 
 FROMM Offering 
 WHERRE OffTerm = 'FALL' 
    AND OffYear = 2019;

-- Corrected statement without syntax errors
SELECT OfferNo, CourseNo, FacNo 
 FROM Offering 
 WHERE OffTerm = 'FALL' 
   AND OffYear = 2019;

-- 4.61
-- Original statement with syntax errors
SELECT StdFirstName, StdLastName, OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo 
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- Corrected statement without syntax errors
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo 
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- 4.62
-- Original statement with syntax errors
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo 
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- Corrected statement without syntax errors
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Offering, Enrollment
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo 
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- 4.63
-- Original statement with syntax errors
SELECT CourseNo, Enrollment.OfferNo, 
       Avg(StdGPA) AS AvgGPA
 FROM Student, Offering, Enrollment
 WHERE Offering.OfferNo = Enrollment.OfferNo
   AND Enrollment.StdNo = Student.StdNo 
   AND OffTerm = 'FALL' 
 GROUP BY CourseNo, Enrollment.OfferNo 
 HAVING Avg(StdGPA) > 3.0 AND OffYear = 2019;

-- Corrected statement without syntax errors
SELECT CourseNo, Enrollment.OfferNo, 
       Avg(StdGPA) AS AvgGPA
 FROM Student, Offering, Enrollment
 WHERE Offering.OfferNo = Enrollment.OfferNo
   AND Enrollment.StdNo = Student.StdNo 
   AND OffTerm = 'FALL' AND OffYear = 2019
 GROUP BY CourseNo, Enrollment.OfferNo 
 HAVING Avg(StdGPA) > 3.0;

-- 4.64
-- Original statement with syntax errors
SELECT CourseNo, Enrollment.OfferNo, 
       Avg(StdGPA) AS AvgGPA
 FROM Student, Offering, Enrollment
 WHERE Offering.OfferNo = Enrollment.OfferNo
   AND Enrollment.StdNo = Student.StdNo 
   AND OffTerm = 'FALL' AND OffYear = 2019
 GROUP BY CourseNo
 HAVING Avg(StdGPA) > 3.0;

-- Corrected statement without syntax errors
SELECT CourseNo, Enrollment.OfferNo, 
       Avg(StdGPA) AS AvgGPA
 FROM Student, Offering, Enrollment
 WHERE Offering.OfferNo = Enrollment.OfferNo
   AND Enrollment.StdNo = Student.StdNo 
   AND OffTerm = 'FALL' AND OffYear = 2019
 GROUP BY CourseNo, Enrollment.OfferNo
 HAVING Avg(StdGPA) > 3.0;

-- 4.65
-- Original statement with redundancy error (extra table)
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering, Course
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo
   AND Course.CourseNo = Offering.CourseNo
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- Corrected statement with Course table removed
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- 4.66
-- Original statement with redundancy error (unnecessary GROUP BY clause)
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo 
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7
GROUP BY StdFirstName, StdLastName, Enrollment.OfferNo;

-- Corrected statement without unnecessary GROUP BY clause
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo 
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- 4.67
-- Original statement with semantic error (missing parentheses)
SELECT OfferNo, CourseNo, FacNo, OffYear, OffTerm 
 FROM Offering 
 WHERE OffTerm = 'SPRING' OR OffTerm = 'SUMMER'
   AND OffYear = 2019;

-- Corrected statement with parentheses added
SELECT OfferNo, CourseNo, FacNo, OffYear, OffTerm 
 FROM Offering 
 WHERE ( OffTerm = 'SPRING' OR OffTerm = 'SUMMER' )
   AND OffYear = 2019;

-- 4.68
-- Original statement with semantic error (missing join condition)
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND OffYear = 2019 AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- Corrected statement with join condition added
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Enrollment.OfferNo = Offering.OfferNo
   AND OffYear = 2019 AND OffTerm = 'FALL' 
   AND EnrGrade >= 3.7;

-- 4.69
--Original statement with semantic error (missing condition)
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo 
   AND OffTerm = 'FALL'  
   AND EnrGrade >= 3.7;

-- Corrected statement with condition added
SELECT StdFirstName, StdLastName, Enrollment.OfferNo 
 FROM Student, Enrollment, Offering 
 WHERE Student.StdNo = Enrollment.StdNo
   AND Offering.OfferNo = Enrollment.OfferNo 
   AND OffTerm = 'FALL' AND OffYear = 2019
   AND EnrGrade >= 3.7;

-- 4.70
-- Original statement with poor coding practices
 SELECT Offering.OfferNo, Offering.CourseNo, OffDays,
       OffLocation, OffTime, CrsUnits, FacFirstName,
    FacLastName FROM Faculty, Offering, Enrollment, Student, Course WHERE Faculty.FacNo = Offering.FacNo AND
Offering.OfferNo
  = Enrollment.OfferNo
AND Offering.CourseNo = Course.CourseNo
          AND OffYear = '2020' AND OffTerm = 'SPRING'   
  AND Student.StdNo = Enrollment.StdNo
 AND StdFirstName LIKE 'BOB' AND StdLastName = 'NORBERT';

-- Corrected statement with good coding practices
SELECT Offering.OfferNo, Offering.CourseNo, OffDays,
       OffLocation, OffTime, CrsUnits, FacFirstName,
       FacLastName
 FROM Faculty, Offering, Enrollment, Student, Course
 WHERE Faculty.FacNo = Offering.FacNo 
   AND Offering.OfferNo = Enrollment.OfferNo
   AND Student.StdNo = Enrollment.StdNo
   AND Offering.CourseNo = Course.CourseNo
   AND OffYear = 2020 AND OffTerm = 'SPRING' 
   AND StdFirstName = 'BOB'
   AND StdLastName = 'NORBERT';
