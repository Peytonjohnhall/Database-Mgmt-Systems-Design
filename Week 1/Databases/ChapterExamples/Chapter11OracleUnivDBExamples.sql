-- Chapter 11 Oracle Examples
-- Do not execute in PostgreSQL. Only executes in Oracle.

-- 11.11
-- Anonymous Block to Compute the Sum and the Product
-- SQL *Plus command
SET SERVEROUTPUT ON;
-- Anonymous block
DECLARE
 TmpSum     INTEGER;
 TmpProd    INTEGER;
 Idx        INTEGER;
BEGIN
-- Initialize temporary variables
 TmpSum := 0;
 TmpProd := 1;
 -- Use a loop to compute the sum and product
 FOR Idx IN 1 .. 10 LOOP 
    TmpSum := TmpSum + Idx;
    TmpProd := TmpProd * Idx;
 END LOOP;
 -- Display the results
 Dbms_Output.Put_Line('Sum is ' || To_Char(TmpSum));
 Dbms_Output.Put_Line('Product is ' || To_Char(TmpProd));
END;
/

-- 11.12
-- Anonymous Block to Compute the Sum of the Even Numbers and the Product of the Odd Numbers
SET SERVEROUTPUT ON;
DECLARE
 TmpSum     INTEGER;
 TmpProd    INTEGER;
 Idx        INTEGER;
BEGIN
-- Initialize temporary variables
 TmpSum := 0;
 TmpProd := 1;
 -- Use a loop to compute the sum and product
 -- Mod(X,Y) returns the integer remainder of X/Y.
 FOR Idx IN 1 .. 10 LOOP 
    IF Mod(Idx,2) = 0 THEN -- even number
      TmpSum := TmpSum + Idx;
    ELSE
      TmpProd := TmpProd * Idx;
    END IF;
 END LOOP;
 -- Display the results
 Dbms_Output.Put_Line('Even sum is ' || To_Char(TmpSum));
 Dbms_Output.Put_Line('Odd product is ' || To_Char(TmpProd));
END;
/

-- 11.13
CREATE OR REPLACE PROCEDURE pr_InsertRegistration
(aRegNo IN Registration.RegNo%TYPE,
 aStdNo IN Registration.StdNo%TYPE,
 aRegStatus IN Registration.RegStatus%TYPE,
 aRegDate IN Registration.RegDate%TYPE,
 aRegTerm IN Registration.RegTerm%TYPE,
 aRegYear IN Registration.RegYear%TYPE) IS
-- Insert a new registration using parameter values
BEGIN

INSERT INTO Registration 
       (RegNo, StdNo, RegStatus, RegDate, RegTerm, RegYear)
VALUES (aRegNo, aStdNo, aRegStatus, aRegDate, aRegTerm, aRegYear);

dbms_output.put_line('Added a row to the Registration table');

END;
/

-- Testing code
SET SERVEROUTPUT ON;
-- Number of rows before the procedure execution
SELECT COUNT(*) FROM Registration;

BEGIN
pr_InsertRegistration
 (1275,'901-23-4567','F',To_Date('27-Feb-2020'),'Spring',2020);
END;
/
-- Number of rows after the procedure execution
SELECT COUNT(*) FROM Registration;
-- Delete the inserted row using the ROLLBACK statement
ROLLBACK;
DROP PROCEDURE pr_InsertRegistration;

-- 11.14
CREATE OR REPLACE PROCEDURE pr_InsertRegistration
(aRegNo IN Registration.RegNo%TYPE,
 aStdNo IN Registration.StdNo%TYPE,
 aRegStatus IN Registration.RegStatus%TYPE,
 aRegDate IN Registration.RegDate%TYPE,
 aRegTerm IN Registration.RegTerm%TYPE,
 aRegYear IN Registration.RegYear%TYPE,
 aResult OUT BOOLEAN ) IS
-- Create a new registration
-- aResult is TRUE if successful, false otherwise.
BEGIN
aResult := TRUE;
INSERT INTO Registration 
       (RegNo, StdNo, RegStatus, RegDate, RegTerm, RegYear)
VALUES (aRegNo, aStdNo, aRegStatus, aRegDate, aRegTerm, aRegYear);


EXCEPTION
WHEN OTHERS THEN aResult := FALSE;
END;
/

-- Testing code
SET SERVEROUTPUT ON;
-- Number of rows before the procedure execution
SELECT COUNT(*) FROM Registration;
DECLARE
 -- Output parameter must be declared in the calling block
 Result BOOLEAN;
BEGIN
-- This test should succeed.
-- Procedure assigns value to the output parameter (Result).
pr_InsertRegistration
(1275,'901-23-4567','F',To_Date('27-Feb-2020'),'Spring',2020,Result);
IF Result THEN
    dbms_output.put_line('Added a row to the Registration table');
ELSE
    dbms_output.put_line('Row not added to the Registration table');
END IF;

-- This test should fail because of the duplicate primary key.
pr_InsertRegistration(1275,'901-23-4567','F',To_Date('27-Feb-2020'),'Spring',2020,Result);
IF Result THEN
    dbms_output.put_line('Added a row to the Registration table');
ELSE
    dbms_output.put_line('Row not added to the Registration table');
END IF;
END;
/

-- Number of rows after the procedure executions
SELECT COUNT(*) FROM Registration;
-- Delete inserted row
ROLLBACK;
DROP PROCEDURE pr_InsertRegistration;

-- 11.15
CREATE OR REPLACE FUNCTION fn_RetrieveStdName
(aStdNo IN Student.StdNo%type) RETURN VARCHAR2 IS
-- Retrieves the student name (concatenate first and last name)
-- given a student number. If the student does not exist,
-- return null.
aFirstName Student.StdFirstName%type;
aLastName Student.StdLastName%type;

BEGIN

SELECT StdFirstName, StdLastName
 INTO aFirstName, aLastName
 FROM Student
 WHERE StdNo = aStdNo;

RETURN(aLastName || ', ' || aFirstName);

EXCEPTION
-- No_Data_Found is raised if the SELECT statement returns no data.
 WHEN No_Data_Found THEN
  RETURN(NULL);

 WHEN OTHERS THEN
   raise_application_error(-20001, 'Database error');

END;
/
-- Testing code
SET SERVEROUTPUT ON;
DECLARE
aStdName VARCHAR2(50);
BEGIN
-- This call should display a student name.
aStdName := fn_RetrieveStdName('901-23-4567');
IF aStdName IS NULL THEN
	dbms_output.put_line('Student not found');
ELSE
	dbms_output.put_line('Name is ' || aStdName);
END IF;

-- This call should not display a student name.
aStdName := fn_RetrieveStdName('905-23-4567');
IF aStdName IS NULL THEN
	dbms_output.put_line('Student not found');
ELSE
	dbms_output.put_line('Name is ' || aStdName);
END IF;
END;
/
DROP FUNCTION fn_RetrieveStdName;

-- 11.16
CREATE OR REPLACE FUNCTION fn_ComputeWeightedGPA
(aStdNo IN Student.StdNo%type, aYear IN Offering.OffYear%Type) 
   RETURN NUMBER IS
-- Computes the weighted GPA given a student No and year.
-- Weighted GPA is the sum of units times the grade
-- divided by the total units.
-- If the student does not exist, return null.
WeightedGPA NUMBER;

BEGIN
SELECT SUM(enrgrade*CrsUnits)/SUM(CrsUnits)
 INTO WeightedGPA
 FROM Student, Registration, Enrollment, Offering, Course
 WHERE Student.StdNo = aStdNo
   AND Offering.OffYear = aYear
   AND Student.StdNo = Registration.StdNo
   AND Registration.RegNo = Enrollment.RegNo
   AND Enrollment.OfferNo = Offering.OfferNo
   AND Offering.CourseNo = Course.CourseNo;

RETURN(WeightedGPA);

EXCEPTION
 WHEN No_Data_Found THEN
  RETURN(NULL);

 WHEN OTHERS THEN
   raise_application_error(-20001, 'Database error');

END;
/
-- Testing code
SET SERVEROUTPUT ON;
DECLARE
aGPA DECIMAL(3,2);
BEGIN
-- This call should display a weighted GPA.
aGPA := fn_ComputeWeightedGPA('901-23-4567', 2020);
IF aGPA IS NULL THEN
	dbms_output.put_line('Student or enrollments not found');
ELSE
	dbms_output.put_line('Weighted GPA is ' || to_char(aGPA));
END IF;

-- This call should not display a weighted GPA.
aGPA := fn_ComputeWeightedGPA('905-23-4567', 2020);
IF aGPA IS NULL THEN
	dbms_output.put_line('Student or enrollments not found');
ELSE
	dbms_output.put_line('Weighted GPA is ' || to_char(aGPA));
END IF;
END;
/
-- Use the function in a query
SELECT StdNo, StdFirstName, StdLastName,
       fn_ComputeWeightedGPA(StdNo, 2020) AS WeightedGPA
FROM Student;
DROP FUNCTION fn_ComputeWeightedGPA;

-- 11.17
CREATE OR REPLACE FUNCTION fn_DetermineRank
(aStdNo IN Student.StdNo%TYPE, anOfferNo IN Offering.OfferNo%TYPE) 
   RETURN INTEGER IS
-- Determines the class rank for a given a student No and OfferNo.
-- Computes dense ranking with no gap in ranks for matching grades
-- Uses an implicit cursor.
-- If the student or offering do not exist, return 0.
TmpRank INTEGER :=0;
PrevEnrGrade Enrollment.EnrGrade%TYPE := 9.9;
FOUND BOOLEAN := FALSE;

BEGIN
-- Loop through implicit cursor
FOR EnrollRec IN 
 ( SELECT Student.StdNo, EnrGrade
    FROM Student, Registration, Enrollment
    WHERE Enrollment.OfferNo = anOfferNo
      AND Student.StdNo = Registration.StdNo
      AND Registration.RegNo = Enrollment.RegNo
    ORDER BY EnrGrade DESC ) LOOP

    IF EnrollRec.EnrGrade < PrevEnrGrade THEN
    -- Increment the class rank when the grade changes
       TmpRank := TmpRank + 1;
       PrevEnrGrade := EnrollRec.EnrGrade;
    END IF;
    IF EnrollRec.StdNo = aStdNo THEN
       Found := TRUE;
       EXIT;
    END IF;
END LOOP;

IF Found THEN
  RETURN(TmpRank);
ELSE
  RETURN(0);
END IF;

EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001, 'Database error');

END;
/
-- Testing code
SET SERVEROUTPUT ON;
-- Execute query to see test data
SELECT Student.StdNo, EnrGrade
 FROM Student, Registration, Enrollment
 WHERE Enrollment.OfferNo = 5679
   AND Student.StdNo = Registration.StdNo
   AND Registration.RegNo = Enrollment.RegNo
 ORDER BY EnrGrade DESC;

-- Test script
DECLARE
aRank INTEGER;
BEGIN
-- This call should return a rank of 6.
aRank := fn_DetermineRank('789-01-2345', 5679);
IF aRank > 0 THEN
	dbms_output.put_line('Rank is ' || to_char(aRank));
ELSE
	dbms_output.put_line('Student is not enrolled.');
END IF;

-- This call should return a rank of 0.
aRank := fn_DetermineRank('789-01-2005', 5679);
IF aRank > 0 THEN
	dbms_output.put_line('Rank is ' || to_char(aRank));
ELSE
	dbms_output.put_line('Student is not enrolled.');
END IF;
END;
/
DROP FUNCTION fn_DetermineRank;

-- 11.18
CREATE OR REPLACE PROCEDURE pr_DetermineRank
(aStdNo IN Student.StdNo%TYPE, anOfferNo IN Offering.OfferNo%TYPE,
 OutRank OUT INTEGER, OutGrade OUT Enrollment.EnrGrade%TYPE ) IS
-- Determines the class rank and grade for a given a student No
-- and OfferNo using an explicit cursor.
-- Computes dense ranking with no gap in ranks for matching grades
-- If the student or offering do not exist, return 0.
TmpRank INTEGER :=0;
PrevEnrGrade Enrollment.EnrGrade%TYPE := 9.9;
Found BOOLEAN := FALSE;
TmpGrade Enrollment.EnrGrade%TYPE;
TmpStdNo Student.StdNo%TYPE;
-- Explicit cursor
CURSOR EnrollCursor (tmpOfferNo Offering.OfferNo%TYPE) IS
   SELECT Student.StdNo, EnrGrade
    FROM Student, Registration, Enrollment
    WHERE Enrollment.OfferNo = anOfferNo
      AND Student.StdNo = Registration.StdNo
      AND Registration.RegNo = Enrollment.RegNo
    ORDER BY EnrGrade DESC;

BEGIN
-- Open and loop through explicit cursor
OPEN EnrollCursor(anOfferNo);
LOOP
    FETCH EnrollCursor INTO TmpStdNo, TmpGrade;
    EXIT WHEN EnrollCursor%NotFound;
    IF TmpGrade < PrevEnrGrade THEN
    -- Increment the class rank when the grade changes
       TmpRank := TmpRank + 1;
       PrevEnrGrade := TmpGrade;
    END IF;
    IF TmpStdNo = aStdNo THEN
       Found := TRUE;
       EXIT;
    END IF;
END LOOP;

CLOSE EnrollCursor;
IF Found THEN
  OutRank := TmpRank;
  OutGrade := PrevEnrGrade;
ELSE
  OutRank := 0;
  OutGrade := 0;
END IF;

EXCEPTION
WHEN OTHERS THEN
  raise_application_error(-20001, 'Database error');
END;
/
-- Testing code
SET SERVEROUTPUT ON;
-- Execute query to see test data
SELECT Student.StdNo, EnrGrade
 FROM Student, Registration, Enrollment
 WHERE Student.StdNo = Registration.StdNo
   AND Registration.RegNo = Enrollment.RegNo
   AND Enrollment.OfferNo = 5679
 ORDER BY EnrGrade DESC;

-- Test script
DECLARE
aRank INTEGER;
aGrade Enrollment.EnrGrade%TYPE;
BEGIN
-- This call should produce a rank of 6.
pr_DetermineRank('789-01-2345', 5679, aRank, aGrade);
IF aRank > 0 THEN
	dbms_output.put_line('Rank is ' || to_char(aRank) || '.');
	dbms_output.put_line('Grade is ' || to_char(aGrade) || '.');
ELSE
	dbms_output.put_line('Student is not enrolled.');
END IF;

-- This call should produce a rank of 0.
pr_DetermineRank('789-01-2005', 5679, aRank, aGrade);
IF aRank > 0 THEN
	dbms_output.put_line('Rank is ' || to_char(aRank) || '.');
	dbms_output.put_line('Grade is ' || to_char(aGrade) || '.');
ELSE
	dbms_output.put_line('Student is not enrolled.');
END IF;
END;
/
DROP PROCEDURE pr_DetermineRank;

-- 11.19
CREATE OR REPLACE PACKAGE pck_University IS
PROCEDURE pr_DetermineRank
 (aStdNo IN Student.StdNo%TYPE, anOfferNo IN Offering.OfferNo%TYPE,
   OutRank OUT INTEGER, OutGrade OUT Enrollment.EnrGrade%TYPE );
FUNCTION fn_ComputeWeightedGPA
(aStdNo IN Student.StdNo%type, aYear IN Offering.OffYear%Type) 
   RETURN NUMBER;
END pck_University;
/

-- 11.20
CREATE OR REPLACE PACKAGE BODY pck_University IS
PROCEDURE pr_DetermineRank
 (aStdNo IN Student.StdNo%TYPE, anOfferNo IN Offering.OfferNo%TYPE,
   OutRank OUT INTEGER, OutGrade OUT Enrollment.EnrGrade%TYPE ) IS
-- Determines the class rank and grade for a given a student No
-- and OfferNo using an explicit cursor.
-- If the student or offering do not exist, return 0.
TmpRank INTEGER :=0;
PrevEnrGrade Enrollment.EnrGrade%TYPE := 9.9;
Found BOOLEAN := FALSE;
TmpGrade Enrollment.EnrGrade%TYPE;
TmpStdNo Student.StdNo%TYPE;
-- Explicit cursor
CURSOR EnrollCursor (tmpOfferNo Offering.OfferNo%TYPE) IS
   SELECT Student.StdNo, EnrGrade
    FROM Student, Registration, Enrollment
    WHERE Enrollment.OfferNo = anOfferNo
      AND Student.StdNo = Registration.StdNo
      AND Registration.RegNo = Enrollment.RegNo
    ORDER BY EnrGrade DESC;

BEGIN
-- Open and loop through explicit cursor
OPEN EnrollCursor(anOfferNo);
LOOP
    FETCH EnrollCursor INTO TmpStdNo, TmpGrade;
    EXIT WHEN EnrollCursor%NotFound;
    IF TmpGrade < PrevEnrGrade THEN
    -- Increment the class rank when the grade changes
       TmpRank := TmpRank + 1;
       PrevEnrGrade := TmpGrade;
    END IF;
    IF TmpStdNo = aStdNo THEN
       Found := TRUE;
       EXIT;
    END IF;
END LOOP;

CLOSE EnrollCursor;
IF Found THEN
  OutRank := TmpRank;
  OutGrade := PrevEnrGrade;
ELSE
  OutRank := 0;
  OutGrade := 0;
END IF;

EXCEPTION
WHEN OTHERS THEN
  raise_application_error(-20001, 'Database error');
END pr_DetermineRank;

FUNCTION fn_ComputeWeightedGPA
(aStdNo IN Student.StdNo%type, aYear IN Offering.OffYear%Type) 
   RETURN NUMBER IS
-- Computes the weighted GPA given a student No and year.
-- Weighted GPA is the sum of units times the grade
-- divided by the total units.
-- If the student does not exist, return null.
WeightedGPA NUMBER;

BEGIN

SELECT SUM(enrgrade*CrsUnits)/SUM(CrsUnits)
 INTO WeightedGPA
 FROM Student, Registration, Enrollment, Offering, Course
 WHERE Student.StdNo = aStdNo
   AND Offering.OffYear = aYear
   AND Student.StdNo = Registration.StdNo
   AND Registration.RegNo = Enrollment.RegNo
   AND Enrollment.OfferNo = Offering.OfferNo
   AND Offering.CourseNo = Course.CourseNo;

RETURN(WeightedGPA);

EXCEPTION
 WHEN no_data_found THEN
  RETURN(NULL);

 WHEN OTHERS THEN
   raise_application_error(-20001, 'Database error');

END fn_ComputeWeightedGPA;

END pck_University;
/

-- 11.21
SET SERVEROUTPUT ON;
DECLARE
aRank INTEGER;
aGrade Enrollment.EnrGrade%TYPE;
aGPA NUMBER;
BEGIN
-- This call should produce a rank of 6.
pck_University.pr_DetermineRank('789-01-2345', 5679, aRank, aGrade);
IF aRank > 0 THEN
	dbms_output.put_line('Rank is ' || to_char(aRank) || '.');
	dbms_output.put_line('Grade is ' || to_char(aGrade) || '.');
ELSE
	dbms_output.put_line('Student is not enrolled.');
END IF;
-- This call should display a weighted GPA.
aGPA := pck_University.fn_ComputeWeightedGPA('901-23-4567', 2020);
IF aGPA IS NULL THEN
	dbms_output.put_line('Student or enrollments not found');
ELSE
	dbms_output.put_line('Weighted GPA is ' || to_char(aGPA));
END IF;
END;
/
DROP PACKAGE pck_University;

-- 11.22
CREATE OR REPLACE TRIGGER tr_Course_IA
AFTER INSERT
ON Course
FOR EACH ROW
BEGIN
    -- No references to OLD row because only NEW exists for INSERT
    dbms_output.put_line('Inserted Row');
    dbms_output.put_line('CourseNo: ' || :NEW.CourseNo);
    dbms_output.put_line('Course Description: ' || :NEW.CrsDesc);
    dbms_output.put_line('Course Units: ' || To_Char(:NEW.CrsUnits));
END;
/
-- Testing statements
SET SERVEROUTPUT ON;
INSERT INTO Course (CourseNo, CrsDesc, CrsUnits)
VALUES ('IS485','Advanced Database Management',4);

ROLLBACK;
DROP TRIGGER tr_Course_IA;

-- 11.23
CREATE OR REPLACE TRIGGER tr_Course_UA
AFTER UPDATE
ON Course
FOR EACH ROW
BEGIN
    dbms_output.put_line('New Row Values');
    dbms_output.put_line('CourseNo: ' || :NEW.CourseNo);
    dbms_output.put_line('Course Description: ' || :NEW.CrsDesc);
    dbms_output.put_line('Course Units: ' || To_Char(:NEW.CrsUnits));

    dbms_output.put_line('Old Row Values');
    dbms_output.put_line('CourseNo: ' || :OLD.CourseNo);
    dbms_output.put_line('Course Description: ' || :OLD.CrsDesc);
    dbms_output.put_line('Course Units: ' || To_Char(:OLD.CrsUnits));
END;
/
-- Testing statements
SET SERVEROUTPUT ON;
-- Add row so it can be updated
INSERT INTO Course (CourseNo, CrsDesc, CrsUnits)
VALUES ('IS485','Advanced Database Management',4);

UPDATE Course
 SET CrsUnits = 3
 WHERE CourseNo = 'IS485';

ROLLBACK;
DROP TRIGGER tr_Course_UA;


-- 11.24
CREATE OR REPLACE TRIGGER tr_Course_DA
AFTER DELETE
ON Course
FOR EACH ROW
BEGIN
    -- No references to NEW row because only OLD exists for DELETE
    dbms_output.put_line('Deleted Row');
    dbms_output.put_line('CourseNo: ' || :OLD.CourseNo);
    dbms_output.put_line('Course Description: ' || :OLD.CrsDesc);
    dbms_output.put_line('Course Units: ' || To_Char(:OLD.CrsUnits));
END;
/
-- Testing statements
SET SERVEROUTPUT ON;
-- Insert row so that it can be deleted
INSERT INTO Course (CourseNo, CrsDesc, CrsUnits)
VALUES ('IS485','Advanced Database Management',4);

DELETE FROM Course
WHERE CourseNo = 'IS485';

ROLLBACK;
DROP TRIGGER tr_Course_DA;

-- 11.25
CREATE OR REPLACE TRIGGER tr_Course_DIUA
AFTER INSERT OR UPDATE OR DELETE
ON Course
FOR EACH ROW
BEGIN
    dbms_output.put_line('Inserted Table');
    dbms_output.put_line('CourseNo: ' || :NEW.CourseNo);
    dbms_output.put_line('Course Description: ' || :NEW.CrsDesc);
    dbms_output.put_line('Course Units: ' || To_Char(:NEW.CrsUnits));

    dbms_output.put_line('Deleted Table');
    dbms_output.put_line('CourseNo: ' || :OLD.CourseNo);
    dbms_output.put_line('Course Description: ' || :OLD.CrsDesc);
    dbms_output.put_line('Course Units: ' || To_Char(:OLD.CrsUnits));
END;
/
-- Testing statements
SET SERVEROUTPUT ON;
INSERT INTO Course (CourseNo, CrsDesc, CrsUnits)
VALUES ('IS485','Advanced Database Management',4);

UPDATE Course
SET CrsUnits = 3
WHERE CourseNo = 'IS485';

DELETE FROM Course
WHERE CourseNo = 'IS485';

ROLLBACK;
DROP TRIGGER tr_Course_DIUA;

-- 11.26
CREATE OR REPLACE TRIGGER tr_Enrollment_IB
-- This trigger ensures that the number of enrolled
-- students is less than the offering limit.
BEFORE INSERT
ON Enrollment
FOR EACH ROW
DECLARE 
   anOffLimit Offering.OffLimit%TYPE;
   anOffNumEnrolled Offering.OffNumEnrolled%TYPE;
   -- user defined exception declaration
   NoSeats EXCEPTION;
   ExMessage VARCHAR(200);
BEGIN
   SELECT OffLimit, OffNumEnrolled
     INTO anOffLimit, anOffNumEnrolled
     FROM Offering
     WHERE Offering.OfferNo = :NEW.OfferNo;

   IF anOffLimit <= anOffNumEnrolled THEN
      RAISE NoSeats;
   END IF;
EXCEPTION
  WHEN NoSeats THEN
   -- error number between -20000 and -20999
     ExMessage := 'No seats remaining in offering ' || 
                   to_char(:NEW.OfferNo) || '.';
     ExMessage := ExMessage || 'Number enrolled: ' || 
              to_char(anOffNumEnrolled) || '. ';
     ExMessage := ExMessage || 'Offering limit: ' || 
              to_char(anOffLimit);
     Raise_Application_Error(-20001, ExMessage);
END;
/
-- Testing statements
SET SERVEROUTPUT ON;
-- See offering limit and number enrolled
SELECT OffLimit, OffNumEnrolled
 FROM Offering
 WHERE Offering.OfferNo = 5679;
-- Insert the last student
INSERT INTO Enrollment (RegNo, OfferNo, EnrGrade)
VALUES (1234,5679,0);

-- update the number of enrolled students
UPDATE Offering
 SET OffNumEnrolled = OffNumEnrolled + 1
 WHERE OfferNo = 5679;

-- See offering limit and number enrolled
SELECT OffLimit, OffNumEnrolled
 FROM Offering
 WHERE Offering.OfferNo = 5679;
-- Insert a student beyond the limit
INSERT INTO Enrollment (RegNo, OfferNo, EnrGrade)
VALUES (1236,5679,0);

ROLLBACK;
DROP TRIGGER tr_Enrollment_IB;

-- 11.27
CREATE OR REPLACE TRIGGER tr_Enrollment_IA
-- This trigger updates the number of enrolled
-- students in the related Offering row.
AFTER INSERT
ON Enrollment
FOR EACH ROW
BEGIN
   UPDATE Offering
    SET OffNumEnrolled = OffNumEnrolled + 1
    WHERE OfferNo = :NEW.OfferNo;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_Application_Error(-20001, 'Database error');
END;
/
-- Testing statements
SET SERVEROUTPUT ON;
-- See the offering limit and number enrolled
SELECT OffLimit, OffNumEnrolled
 FROM Offering
 WHERE Offering.OfferNo = 5679;
-- Insert the last student
INSERT INTO Enrollment (RegNo, OfferNo, EnrGrade)
VALUES (1234,5679,0);

-- See the offering limit and number enrolled
SELECT OffLimit, OffNumEnrolled
 FROM Offering
 WHERE Offering.OfferNo = 5679;

ROLLBACK;
DROP TRIGGER tr_Enrollment_IA;

-- 11.28
-- Drop the previous trigger to avoid interactions
DROP TRIGGER tr_Enrollment_IB;
CREATE OR REPLACE TRIGGER tr_Enrollment_IUB
-- This trigger ensures that the number of enrolled
-- students is less than the offering limit.
BEFORE INSERT OR UPDATE OF OfferNo
ON Enrollment
FOR EACH ROW
DECLARE 
    anOffLimit Offering.OffLimit%TYPE;
    anOffNumEnrolled Offering.OffNumEnrolled%TYPE;
	NoSeats EXCEPTION;
	ExMessage VARCHAR(200);
BEGIN
   SELECT OffLimit, OffNumEnrolled
     INTO anOffLimit, anOffNumEnrolled
     FROM Offering
     WHERE Offering.OfferNo = :NEW.OfferNo;

   IF anOffLimit <= anOffNumEnrolled THEN
      RAISE NoSeats;
   END IF;
EXCEPTION
  WHEN NoSeats THEN
   -- error number between -20000 and -20999
     ExMessage := 'No seats remaining in offering ' || 
                   to_char(:NEW.OfferNo) || '.';
     ExMessage := ExMessage || 'Number enrolled: ' || 
              to_char(anOffNumEnrolled) || '. ';
     ExMessage := ExMessage || 'Offering limit: ' || 
              to_char(anOffLimit);
     raise_application_error(-20001, ExMessage);
END;
/

-- 11.29
-- Drop the previous trigger to avoid interactions
DROP TRIGGER tr_Enrollment_IA;
CREATE OR REPLACE TRIGGER tr_Enrollment_DIUA
-- This trigger updates the number of enrolled
-- students the related offering row.
AFTER INSERT OR DELETE OR UPDATE of OfferNo
ON Enrollment
FOR EACH ROW
BEGIN
 -- Increment the number of enrolled students for insert, update
 IF INSERTING OR UPDATING THEN   
    UPDATE Offering
      SET OffNumEnrolled = OffNumEnrolled + 1
      WHERE OfferNo = :NEW.OfferNo;
 END IF;
-- Decrease the number of enrolled students for delete, update
IF UPDATING OR DELETING THEN
    UPDATE Offering
      SET OffNumEnrolled = OffNumEnrolled - 1
      WHERE OfferNo = :OLD.OfferNo;
END IF;

EXCEPTION
  WHEN OTHERS THEN
    raise_application_error(-20001, 'Database error');
END;
/

-- 11.30
-- Test case 1
-- See the offering limit and number enrolled
SELECT OffLimit, OffNumEnrolled
 FROM Offering
 WHERE Offering.OfferNo = 5679;
-- Insert the last student
INSERT INTO Enrollment (RegNo, OfferNo, EnrGrade)
VALUES (1234,5679,0);
-- See the offering limit and the number enrolled
SELECT OffLimit, OffNumEnrolled
 FROM Offering
 WHERE Offering.OfferNo = 5679;

-- Test case 2
-- Insert a student beyond the limit: exception raised
INSERT INTO Enrollment (RegNo, OfferNo, EnrGrade)
VALUES (1236,5679,0);
-- Transfer a student to offer 5679: exception raised
UPDATE Enrollment
 SET OfferNo = 5679
 WHERE RegNo = 1234 AND OfferNo = 1234;

-- Test case 3
-- See the offering limit and the number enrolled before update
SELECT OffLimit, OffNumEnrolled
 FROM Offering
 WHERE Offering.OfferNo = 4444;
-- Update a student to a non full offering
UPDATE Enrollment
 SET OfferNo = 4444
 WHERE RegNo = 1234 AND OfferNo = 1234;
-- See the offering limit and the number enrolled after update
SELECT OffLimit, OffNumEnrolled
 FROM Offering
 WHERE Offering.OfferNo = 4444;

-- Test case 4
-- See the offering limit and the number enrolled before delete
SELECT OffLimit, OffNumEnrolled
 FROM Offering
 WHERE Offering.OfferNo = 1234;
-- Delete an enrollment
DELETE Enrollment
 WHERE OfferNo = 1234;
-- See the offering limit and the number enrolled
SELECT OffLimit, OffNumEnrolled
 FROM Offering
 WHERE Offering.OfferNo = 1234;

-- Erase all changes
ROLLBACK;
DROP TRIGGER tr_Enrollment_DIUA;
DROP TRIGGER tr_Enrollment_IUB;

-- 11.31
CREATE OR REPLACE TRIGGER tr_FacultySalary_UB
-- This trigger ensures that a salary increase does not exceed
-- 10%.
BEFORE UPDATE OF FacSalary
ON Faculty
FOR EACH ROW
WHEN (NEW.FacSalary > 1.1 * OLD.FacSalary)
DECLARE 
	SalaryIncreaseTooHigh EXCEPTION;
	ExMessage VARCHAR(200);
BEGIN
    RAISE SalaryIncreaseTooHigh;
EXCEPTION
  WHEN SalaryIncreaseTooHigh THEN
   -- error number between -20000 and -20999
     ExMessage := 'Salary increase exceeds 10%. '; 
     ExMessage := ExMessage || 'Current salary: ' || 
              to_char(:OLD.FacSalary) || '. ';
     ExMessage := ExMessage || 'New salary: ' || 
              to_char(:NEW.FacSalary) || '.';
     Raise_Application_Error(-20001, ExMessage);
END;
/
SET SERVEROUTPUT ON;
-- Test case 1: salary increase of 5%
UPDATE Faculty
 SET FacSalary = FacSalary * 1.05
 WHERE FacNo = '543-21-0987';
SELECT FacSalary FROM Faculty WHERE FacNo = '543-21-0987';
-- Test case 2: salary increase of 20% should generate an exception.
UPDATE Faculty
 SET FacSalary = FacSalary * 1.20
 WHERE FacNo = '543-21-0987';
ROLLBACK;
DROP TRIGGER tr_FacultySalary_UB;

-- 11.32
-- This trigger changes the case of FacFirstName and FacLastName.
CREATE OR REPLACE TRIGGER tr_FacultyName_IUB
BEFORE INSERT OR UPDATE OF FacFirstName, FacLastName
ON Faculty
FOR EACH ROW
BEGIN
   :NEW.FacFirstName := Upper(:NEW.FacFirstName);
   :NEW.FacLastName := Upper(:NEW.FacLastName);
END;
/

-- Testing statements
UPDATE Faculty
 SET FacFirstName = 'Joe', FacLastName = 'Smith'
 WHERE FacNo = '543-21-0987';
-- Display the changed faculty name.
SELECT FacFirstName, FacLastName
 FROM Faculty
 WHERE FacNo = '543-21-0987';
ROLLBACK;
DROP TRIGGER tr_FacultyName_IUB;

-- 11.33
-- Create exception table and sequence
CREATE TABLE LogTable
(ExcNo		INTEGER 	 PRIMARY KEY,
 ExcTrigger	VARCHAR2(25) NOT NULL,
 ExcTable		VARCHAR2(25) NOT NULL,
 ExcKeyValue	VARCHAR2(15) NOT NULL,
 ExcDate		DATE DEFAULT SYSDATE NOT NULL,
 ExcText		VARCHAR2(255) NOT NULL );

CREATE SEQUENCE LogSeq INCREMENT BY 1;

CREATE OR REPLACE TRIGGER tr_FacultySalary_UA
-- This trigger inserts a row into LogTable when
-- when a raise exceeds 10%.
AFTER UPDATE OF FacSalary
ON Faculty
FOR EACH ROW
WHEN (NEW.FacSalary > 1.1 * OLD.FacSalary)
DECLARE 
	SalaryIncreaseTooHigh EXCEPTION;
	ExMessage VARCHAR(200);
BEGIN
    RAISE SalaryIncreaseTooHigh;
EXCEPTION
  WHEN SalaryIncreaseTooHigh THEN
	INSERT INTO LogTable
	 (ExcNo, ExcTrigger, ExcTable, ExcKeyValue, ExcDate, ExcText)
	  VALUES (LogSeq.NextVal, 'TR_ FacultySalary_UA', 'Faculty',
              to_char(:New.FacNo), SYSDATE, 
		     'Salary raise greater than 10%');
END;
/
SET SERVEROUTPUT ON;
-- Test case 1: salary increase of 5%
UPDATE Faculty
 SET FacSalary = FacSalary * 1.05
 WHERE FacNo = '543-21-0987';
SELECT FacSalary FROM Faculty WHERE FacNo = '543-21-0987';
SELECT * FROM LogTable;

-- Test case 2: salary increase of 20% should generate an exception.
UPDATE Faculty
 SET FacSalary = FacSalary * 1.20
 WHERE FacNo = '543-21-0987';
SELECT FacSalary FROM Faculty WHERE FacNo = '543-21-0987';
SELECT * FROM LogTable;
ROLLBACK;
DROP TRIGGER tr_FacultySalary_UA;
DROP TABLE LogTable;
DROP SEQUENCE LogSeq;

-- 11.34
-- Table definitions for INSTEAD OF trigger problems
CREATE TABLE Student2(
 StdNo char(11),
 StdFirstName varchar(20) not null,
 StdLastName varchar(30) not null,
 StdGPA decimal(3,2),
 CONSTRAINT Student2Pk PRIMARY KEY (StdNo) );

CREATE TABLE UndStudent2(
 StdNo char(11),
 UStdMajor char(6),
 UStdMinor char(6),
 UStdClass char(2),
 CONSTRAINT UndStudent2Pk PRIMARY KEY (StdNo), 
 CONSTRAINT UndStudent2FK FOREIGN KEY(StdNo) REFERENCES Student2 ON DELETE CASCADE );

CREATE TABLE GradStudent2(
 StdNo char(11),
 GStdAdvisor varchar(20),
 GStdThesisOpt CHAR(10) DEFAULT 'NONTHESIS', -- NONTHESIS or THESIS
 GStdAsstStatus char(6) DEFAULT 'NONE', -- NONE, TA, RA
 CONSTRAINT GradStudent2Pk PRIMARY KEY (StdNo), 
 CONSTRAINT GradStudent2FK FOREIGN KEY(StdNo) REFERENCES Student2 ON DELETE CASCADE );

-- 11.35
-- View definitions for INSTEAD OF trigger problems
CREATE VIEW AllUndStudent AS
  SELECT Student2.StdNo, StdFirstName, StdLastName, StdGPA,
         UStdMajor, UStdMinor, UStdClass
    FROM Student2, UndStudent2
    WHERE Student2.StdNo = UndStudent2.Stdno;

CREATE VIEW AllGradStudent AS
  SELECT Student2.StdNo, StdFirstName, StdLastName, StdGPA,
         GStdAdvisor, GStdThesisOpt, GStdAsstStatus
    FROM Student2, GradStudent2
    WHERE Student2.StdNo = GradStudent2.Stdno;

-- 11.36
-- Insert trigger for undergraduate students
CREATE OR REPLACE TRIGGER tr_AllUndStudent_II
INSTEAD OF INSERT ON AllUndStudent
FOR EACH ROW
BEGIN
-- Insert into parent (Student2)
  INSERT INTO Student2 (StdNo, StdFirstName, StdLastName,StdGPA) 
	VALUES (:New.StdNo, :New.StdFirstName, :New.StdLastName, :New.StdGPA);
-- Insert into child (UndStudent2)
  INSERT INTO UndStudent2 (StdNo, UStdMajor, UStdMinor, UStdClass) 
	VALUES (:New.StdNo, :New.UStdMajor, :New.UStdMinor, :New.UStdClass);
EXCEPTION
  WHEN OTHERS THEN
    raise_application_error(-20001, 'Database error in tr_UndStudent_II');
END;
/

-- Insert trigger for graduate students
CREATE OR REPLACE TRIGGER tr_AllGradStudent_II
INSTEAD OF INSERT ON AllGradStudent
FOR EACH ROW
BEGIN
-- Insert into parent (Student2)
  INSERT INTO Student2 (StdNo, StdFirstName, StdLastName,StdGPA) 
	VALUES (:New.StdNo, :New.StdFirstName, :New.StdLastName, :New.StdGPA);
-- Insert into child (UndStudent2)
  INSERT INTO GradStudent2 (StdNo, GStdAdvisor, GStdThesisOpt, GStdAsstStatus) 
	VALUES (:New.StdNo, :New.GStdAdvisor, :New.GStdThesisOpt, :New.GStdAsstStatus);
EXCEPTION
  WHEN OTHERS THEN
    raise_application_error(-20001, 'Database error in tr_GradStudent_II');
END;
/

-- 11.37
-- Trigger testing statements
-- Test cases for tr_UndStudent_II
INSERT INTO AllUndStudent
	(StdNo, stdFirstName, stdLastName, stdGPA, UStdMajor, UStdMinor, UStdClass)
	VALUES ('123-45-6789','HOMER','WELLS',3.00,'IS','ACCT','FR');

INSERT INTO AllUndStudent
	(StdNo, stdFirstName, stdLastName, stdGPA, UStdMajor, UStdMinor, UStdClass)
	VALUES ('234-56-7890','CANDY','KENDALL',2.70,'FIN','IS','JR');

-- SELECT statements to verify insertions
SELECT * FROM AllUndStudent;
SELECT * FROM Student2;
SELECT * FROM UndStudent2;

-- Test cases for tr_GradStudent_II
INSERT INTO AllGradStudent
	(StdNo, StdFirstName, StdLastName, StdGPA, GStdAdvisor, GStdThesisOpt, GStdAsstStatus)
	VALUES ('345-67-8901','WALLY','KENDALL', 2.80,'Jones','NONTHESIS','NONE');

INSERT INTO AllGradStudent
	(StdNo, StdFirstName, StdLastName, StdGPA, GStdAdvisor, GStdThesisOpt, GStdAsstStatus)
	VALUES ('456-78-9012','JOE','ESTRADA', 3.20,'Jones','THESIS','RA');

-- SELECT statements to verify insertions
SELECT * FROM AllGradStudent;
SELECT * FROM Student2;
SELECT * FROM GradStudent2;

ROLLBACK;

-- 11.38
-- Extended INSTEAD OF trigger for enforcing disjointness constraint
CREATE OR REPLACE TRIGGER tr_AllUndStudent_II
INSTEAD OF INSERT ON AllUndStudent
FOR EACH ROW
DECLARE 
	GradStdExists EXCEPTION;
	ExMessage VARCHAR(200);
        GrdStdCnt INTEGER;
BEGIN
  SELECT COUNT(*) INTO GrdStdCnt FROM GradStudent2
    WHERE GradStudent2.StdNo = :New.StdNo;

   IF GrdStdCnt > 0 THEN
      RAISE GradStdExists;
   END IF;

-- Insert into parent (Student2)
  INSERT INTO Student2 (StdNo, StdFirstName, StdLastName,StdGPA) 
	VALUES (:New.StdNo, :New.StdFirstName, :New.StdLastName, :New.StdGPA);
-- Insert into child (UndStudent2)
  INSERT INTO UndStudent2 (StdNo, UStdMajor, UStdMinor, UStdClass) 
	VALUES (:New.StdNo, :New.UStdMajor, :New.UStdMinor, :New.UStdClass);
EXCEPTION
  WHEN GradStdExists THEN
   -- error number between -20000 and -20999
     ExMessage := 'Graduate student already exists. '; 
     ExMessage := ExMessage || 'StdNo: ' || :New.StdNo;
     Raise_Application_Error(-20001, ExMessage);
  WHEN OTHERS THEN
    raise_application_error(-20001, 'Database error in tr_UndStudent_II');
END;
/
-- Trigger testing statements
-- Test cases for tr_UndStudent_II: should succeed
INSERT INTO AllUndStudent
	(StdNo, stdFirstName, stdLastName, stdGPA, UStdMajor, UStdMinor, UStdClass)
	VALUES ('123-45-6789','HOMER','WELLS',3.00,'IS','ACCT','FR');

INSERT INTO AllUndStudent
	(StdNo, stdFirstName, stdLastName, stdGPA, UStdMajor, UStdMinor, UStdClass)
	VALUES ('234-56-7890','CANDY','KENDALL',2.70,'FIN','IS','JR');

-- SELECT statements to verify insertions
SELECT * FROM AllUndStudent;
SELECT * FROM Student2;
SELECT * FROM UndStudent2;

-- Test cases for tr_GradStudent_IA: should succeed
INSERT INTO AllGradStudent
	(StdNo, StdFirstName, StdLastName, StdGPA, GStdAdvisor, GStdThesisOpt, GStdAsstStatus)
	VALUES ('345-67-8901','WALLY','KENDALL', 2.80,'Jones','NONTHESIS','NONE');

INSERT INTO AllGradStudent
	(StdNo, StdFirstName, StdLastName, StdGPA, GStdAdvisor, GStdThesisOpt, GStdAsstStatus)
	VALUES ('456-78-9012','JOE','ESTRADA', 3.20,'Jones','THESIS','RA');

-- SELECT statements to verify insertions
SELECT * FROM AllGradStudent;
SELECT * FROM Student2;
SELECT * FROM GradStudent2;

-- Test cases for tr_UndStudent_IA: should fail because grad student exists
INSERT INTO AllUndStudent
	(StdNo, stdFirstName, stdLastName, stdGPA, UStdMajor, UStdMinor, UStdClass)
	VALUES ('345-67-8901','WALLY','KENDALL', 3.00,'IS','ACCT','FR');

ROLLBACK;

-- 11.39
-- Update trigger for UndStudent
-- Cannot specify column list for INSTEAD of UPDATE triggers
CREATE OR REPLACE TRIGGER tr_AllUndStudent_UI
INSTEAD OF UPDATE ON AllUndStudent
FOR EACH ROW
BEGIN
-- Update UndStudent2
  IF UPDATING('UStdMajor') THEN
    UPDATE UndStudent2 
    SET UStdMajor = :NEW.UStdMajor
    WHERE StdNo = :OLD.StdNo;
  END IF;

  IF UPDATING('UStdMinor') THEN
    UPDATE UndStudent2 
    SET UStdMinor = :NEW.UStdMinor
    WHERE StdNo = :OLD.StdNo;
  END IF;

  IF UPDATING('UStdClass') THEN
    UPDATE UndStudent2 
    SET UStdClass = :NEW.UStdClass
    WHERE StdNo = :OLD.StdNo;
  END IF;

-- Update Student2
  IF UPDATING('StdGPA') THEN
    UPDATE Student2 
    SET StdGPA = :NEW.StdGPA
    WHERE StdNo = :OLD.StdNo;
  END IF;

  IF UPDATING('StdFirstName') THEN
    UPDATE Student2 
    SET StdFirstName = :NEW.StdFirstName
    WHERE StdNo = :OLD.StdNo;
  END IF;

  IF UPDATING('StdLastName') THEN
    UPDATE Student2 
    SET StdLastName = :NEW.StdLastName
    WHERE StdNo = :OLD.StdNo;
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    raise_application_error(-20001, 'Database error in tr_UStdMajor_UI');
END;
/
-- Trigger testing statements
-- Insert data: depends on tr_UndStudent_II
INSERT INTO AllUndStudent
	(StdNo, stdFirstName, stdLastName, stdGPA, UStdMajor, UStdMinor, UStdClass)
	VALUES ('123-45-6789','HOMER','WELLS',3.00,'IS','ACCT','FR');

INSERT INTO AllUndStudent
	(StdNo, stdFirstName, stdLastName, stdGPA, UStdMajor, UStdMinor, UStdClass)
	VALUES ('234-56-7890','CANDY','KENDALL',2.70,'FIN','IS','JR');

-- Update statements
UPDATE AllUndStudent
 SET UStdMajor = 'MGMT'
 WHERE StdNo = '123-45-6789';

UPDATE AllUndStudent
 SET StdGPA = 3.1
 WHERE StdNo = '234-56-7890';

-- View results
SELECT * FROM AllUndStudent;
SELECT * FROM Student2;
SELECT * FROM UndStudent2;

ROLLBACK;

-- DROP statements
DROP Trigger tr_AllGradStudent_II;
DROP Trigger tr_AllUndStudent_II;
DROP Trigger tr_AllUndStudent_UI;
DROP VIEW AllUndStudent;
DROP VIEW AllGradStudent;
DROP TABLE UndStudent2;
DROP TABLE GradStudent2;
DROP TABLE Student2;

-- 11.40

CREATE VIEW CourseOfferingView AS
  SELECT Course.CourseNo, CrsDesc, CrsUnits,
         OfferNo, OffTerm, OffYear,
         OffLocation, OffTime, FacNo, OffDays,
         OffLimit, OffNumEnrolled
	FROM Course INNER JOIN Offering 
        ON Course.CourseNo = Offering.CourseNo;

-- 11.41
CREATE OR REPLACE TRIGGER tr_CourseOfferingView_II
INSTEAD OF INSERT ON CourseOfferingView
FOR EACH ROW
DECLARE
  CourseCnt INTEGER;
BEGIN
SELECT COUNT(*) INTO CourseCnt FROM Course 
  WHERE CourseNo = :NEW.CourseNo; 
IF CourseCnt = 0 THEN
    -- INSERT into Course table
    INSERT INTO Course (CourseNo, CrsDesc, CrsUnits) 
    VALUES(:NEW.CourseNo, :NEW.CrsDesc, :NEW.CrsUnits);
END IF;
-- INSERT into Offering table
INSERT INTO Offering 	(OfferNo, CourseNo, OffTerm, OffYear, 
            OffLocation, OffTime, FacNo, OffDays, OffLimit, 
            OffNumEnrolled)
VALUES(:NEW.OfferNo, :NEW.CourseNo, :NEW.OffTerm, :NEW.OffYear,
       :NEW.OffLocation, :NEW.OffTime, :NEW.FacNo, :NEW.OffDays,
       :NEW.OffLimit, :NEW.OffNumEnrolled);
EXCEPTION
  WHEN OTHERS THEN
   raise_application_error(-20001, 
      'DB error in tr_CourseOfferingView_II');
END;
/
-- Trigger testing statements
-- Insert only an Offering as Course exists
INSERT INTO CourseOfferingView
 (OfferNo, CourseNo, OffTerm, OffYear, OffLocation, OffTime,
  FacNo, OffDays, OffLimit, OffNumEnrolled)
 VALUES (9999,'IS320','SUMMER',2020,'BLM402','9:00:00', NULL,'MW', 
         10, 0);
-- Ensure that a row has been added to the Offering table
SELECT * FROM Offering WHERE OfferNo = 9999;
-- Insert into both Offering and Course as Course does not exist
INSERT INTO CourseOfferingView
 (CourseNo, CrsDesc, CrsUnits, OfferNo, OffTerm, OffYear, 
  OffLocation, OffTime, FacNo, OffDays, OffLimit, OffNumEnrolled)
 VALUES ('IS321', 'IT Security', 3, 9009, 'SUMMER', 2020, 
         'BLM412','9:00:00', NULL,'TTH', 10, 0);
-- Ensure that a row has been added to both tables
SELECT * FROM Course WHERE CourseNo = 'IS321';
SELECT * FROM Offering WHERE OfferNo = 9009;
ROLLBACK;
-- Drop trigger
DROP TRIGGER tr_CourseOfferingView_II;

-- 11.42
-- Update trigger for CourseOfferingView
-- Does not support updates to the primary keys of the tables
CREATE OR REPLACE TRIGGER tr_CourseOfferingView_UI
INSTEAD OF UPDATE ON CourseOfferingView
FOR EACH ROW
BEGIN
-- Update Course columns
  IF UPDATING('CrsDesc') THEN
    UPDATE Course 
    SET CrsDesc = :NEW.CrsDesc
    WHERE CourseNo = :OLD.CourseNo;
  END IF;
  IF UPDATING('CrsUnits') THEN
    UPDATE Course 
    SET CrsUnits = :NEW.CrsUnits
    WHERE CourseNo = :OLD.CourseNo;
  END IF;
-- Update Offering columns
  IF UPDATING('OffTerm') THEN
    UPDATE Offering 
    SET OffTerm = :NEW.OffTerm
    WHERE OfferNo = :OLD.OfferNo;
  END IF;
  IF UPDATING('OffYear') THEN
    UPDATE Offering 
    SET OffYear = :NEW.OffYear
    WHERE OfferNo = :OLD.OfferNo;
  END IF;
  IF UPDATING('OffLocation') THEN
    UPDATE Offering 
    SET OffLocation = :NEW.OffLocation
    WHERE OfferNo = :OLD.OfferNo;
  END IF;
  IF UPDATING('OffDays') THEN
    UPDATE Offering 
    SET OffDays = :NEW.OffDays
    WHERE OfferNo = :OLD.OfferNo;
  END IF;
  IF UPDATING('OffTime') THEN
    UPDATE Offering 
    SET OffTime = :NEW.OffTime
    WHERE OfferNo = :OLD.OfferNo;
  END IF;
  IF UPDATING('FacNo') THEN
    UPDATE Offering 
    SET FacNo = :NEW.FacNo
    WHERE OfferNo = :OLD.OfferNo;
  END IF;
  IF UPDATING('OffLimit') THEN
    UPDATE Offering 
    SET OffLimit = :NEW.OffLimit
    WHERE OfferNo = :OLD.OfferNo;
  END IF;
  IF UPDATING('OffNumEnrolled') THEN
    UPDATE Offering 
    SET OffNumEnrolled = :NEW.OffNumEnrolled
    WHERE OfferNo = :OLD.OfferNo;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    raise_application_error(-20001, 
      'DB error in tr_CourseOfferingView_UI');
END;
/
-- Trigger testing statements
-- Insert rows for test
INSERT INTO Course
 (CourseNo, CrsDesc, CrsUnits)
 VALUES ('IS321', 'IT Security', 3);
INSERT INTO Offering
 (OfferNo, CourseNo, OffTerm, OffYear, 
  OffLocation, OffTime, FacNo, OffDays, OffLimit, OffNumEnrolled)
 VALUES (9009, 'IS321', 'SUMMER', 2020, 
         'BLM412','9:00:00', NULL,'TTH', 10, 0);
-- Update statements
-- Course columns
UPDATE CourseOfferingView
 SET CrsDesc = 'IT Security II'
 WHERE CourseNo = 'IS321';
UPDATE CourseOfferingView
 SET CrsUnits = 4
 WHERE CourseNo = 'IS321';
-- Offering columns
UPDATE CourseOfferingView
 SET OffTerm = 'Fall'
 WHERE OfferNo = 9009;
UPDATE CourseOfferingView
 SET OffYear = 2021
 WHERE OfferNo = 9009;
UPDATE CourseOfferingView
 SET OffDays = 'MW'
 WHERE OfferNo = 9009;
UPDATE CourseOfferingView
 SET OffLocation = 'BLM305'
 WHERE OfferNo = 9009;
UPDATE CourseOfferingView
 SET OffTime = '10:30:00'
 WHERE OfferNo = 9009;
UPDATE CourseOfferingView
 SET OffLimit = OffLimit +1
 WHERE OfferNo = 9009;
UPDATE CourseOfferingView
 SET OffNumEnrolled = OffNumEnrolled +1
 WHERE OfferNo = 9009;
-- View results
SELECT * FROM Course WHERE CourseNo = 'IS321';
SELECT * FROM Offering WHERE OfferNo = 9009;
ROLLBACK;
-- drop trigger and view
DROP TRIGGER tr_CourseOfferingView_UI;
DROP VIEW CourseOfferingView;

-- 11.43

CREATE OR REPLACE FUNCTION fn_RegExists
(aStdNo IN Student.StdNo%TYPE, aRegTerm IN Registration.RegTerm%TYPE,  
 aRegYear IN Registration.RegYear%TYPE) 
RETURN BOOLEAN IS
-- Returns true if a Registration row exists with aStdNo,
-- aRegTerm, and aRegYear. Returns false otherwise.
RegCount INTEGER;
BEGIN
SELECT COUNT(*)
 INTO RegCount
 FROM Registration
 WHERE StdNo = aStdNo AND RegTerm = aRegTerm AND RegYear = aRegYear;

IF RegCount = 0 THEN
  RETURN(FALSE);
ELSE
  RETURN(TRUE);
END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_Registration_IB
-- This trigger raises an error if the student is already registered
-- by determining if a row with the same StdNo, RegTerm, and RegYear
-- exists in the Registration table.
BEFORE INSERT
ON Registration
FOR EACH ROW
DECLARE
   ExMessage VARCHAR(256);
BEGIN
   ExMessage := 'Registration exists: Error in tr_Registration_IB';
   IF fn_RegExists(:NEW.StdNo, :NEW.RegTerm, :NEW.RegYear) THEN
     raise_application_error(-20001, ExMessage);
   END IF;   
END;
/

-- Testing statements
-- Insert a new student
INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState, StdMajor, StdClass, StdGPA, StdZip)
	VALUES ('999-99-9999', 'JOE', 'JONES', 'DENVER','CO', 'IS', 
            'SO',3.00,'80217-3364');
-- Insert a registration for the new student without a failure.
INSERT INTO Registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1301,'999-99-9999','F','27-Feb-2020','Spring',2020);
-- Insert another registration in a different term without a failure.
INSERT INTO Registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1302,'999-99-9999','F','27-Apr-2020','Fall',2020);
-- Insert a third registration in the same term with a failure.
INSERT INTO Registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1303,'999-99-9999','F','27-Apr-2020','Fall',2020);
ROLLBACK;

DROP TRIGGER tr_Registration_IB;
DROP FUNCTION fn_RegExists;
