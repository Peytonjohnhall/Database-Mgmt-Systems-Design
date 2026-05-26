-- Oracle examples from Chapter 19

-- Drop objects if already exist
DROP TABLE Property;
DROP TABLE Residential;
DROP TABLE Industrial;
DROP TYPE IndustrialType;
DROP TYPE ResidentialType;
DROP TYPE AssessType;
DROP TABLE Agent;
DROP TYPE PropertyType;
DROP TYPE ColorPoint;
DROP TYPE AgentType;
DROP TYPE AddressType;
DROP TYPE BODY Point;
DROP TYPE Point;

-- Example 19.15

CREATE TYPE Point AS OBJECT
( x FLOAT(15),
  y FLOAT(15),
 MEMBER FUNCTION Distance(P2 Point) RETURN NUMBER,
       -- Computes the distance between 2 points
 MEMBER FUNCTION Equals (P2 Point) RETURN BOOLEAN,
  -- Determines if 2 points are equivalent
 MEMBER PROCEDURE Print )
NOT FINAL 
INSTANTIABLE;
/

-- Example 19.16

CREATE TYPE BODY Point AS
  MEMBER FUNCTION Distance(P2 Point) RETURN NUMBER IS
  BEGIN
    RETURN sqrt(power(x - P2.x,2) + power(y - P2.y,2));
 -- equivalent to previous line using SELF
 -- RETURN sqrt(power(SELF.x - P2.x,2) + power(SELF.y - P2.y,2));
  END;
  MEMBER FUNCTION Equals(P2 Point) RETURN BOOLEAN IS
  BEGIN 
   -- not necessary to include SELF prefix in following line
    IF x = P2.x AND y = P2.y THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END;
  MEMBER PROCEDURE Print IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('x: ' || to_char(x) || ' - '  || 'y: ' || to_char(y)); 
  END;
 END;
/

-- Example 19.17

CREATE TABLE PointTbl of Point;

INSERT INTO PointTbl VALUES(10, 10);
INSERT INTO PointTbl VALUES(3, 4);
SELECT * FROM PointTbl;


-- Anonymous block to use point methods
SET SERVEROUTPUT ON;
DECLARE
  P1 Point;
  P2 Point;
BEGIN
  SELECT VALUE(p) INTO P1 FROM PointTbl p WHERE p.x = 10;
  P1.Print();
  SELECT VALUE(p) INTO P2 FROM PointTbl p WHERE p.x = 3;
  P2.Print();
  DBMS_OUTPUT.PUT_LINE('Distance: ' || to_char(P1.Distance(P2)));
  IF P1.Equals(P2) THEN
     DBMS_OUTPUT.PUT_LINE('Same Point');
  ELSE
     DBMS_OUTPUT.PUT_LINE('Different Point');
  END IF;   
END;
/
-- PointTbl is not used in the remainder of the examples.
DROP TABLE PointTbl;
-- The recyclebin must be purged before executing Example 19.24.
-- The PointTble not being purged causes a compilation error in the ColorPoint type.
purge recyclebin;


-- Example 19.18
CREATE TYPE ColorPoint UNDER Point
(Color INTEGER,
 MEMBER FUNCTION Brighten (Intensity INTEGER) RETURN INTEGER,
  -- Increases color intensity
 MEMBER FUNCTION Equals (CP2 ColorPoint) 
    RETURN BOOLEAN,
  -- Determines if 2 ColorPoints are equivalent
  -- Overriding is not used because the two Equals methods
  -- have different signatures.
 OVERRIDING MEMBER PROCEDURE Print )
NOT FINAL 
INSTANTIABLE;
/

-- Example 19.19
CREATE TYPE AddressType AS OBJECT
( Street  VARCHAR(50),
  City    VARCHAR(30),
  State   CHAR(2),
  Zip     CHAR(9) )
NOT FINAL;
/

CREATE TYPE AgentType AS OBJECT
(AgentNo INTEGER,
 AName   VARCHAR(30),
 Address AddressType,
 Phone   CHAR(13),
 Email   VARCHAR(50) )
 NOT FINAL;
/

CREATE TABLE Agent OF AgentType
( CONSTRAINT AgentPK PRIMARY KEY(AgentNo) )
  OBJECT IDENTIFIER IS SYSTEM GENERATED ;


-- Example 19.20
CREATE TYPE PropertyType AS OBJECT
(PropNo  INTEGER,
 Address AddressType,
 SqFt    INTEGER,
 AgentRef REF AgentType,
 Location Point )
   NOT FINAL
   INSTANTIABLE;
/

CREATE TABLE Property OF PropertyType
 ( CONSTRAINT PropertyPK PRIMARY KEY(PropNo), 
   CONSTRAINT AgentRefFK FOREIGN KEY(AgentRef) REFERENCES Agent )
  OBJECT IDENTIFIER IS SYSTEM GENERATED ;


-- Example 19.21

CREATE TYPE AssessType AS VARRAY(6) OF DECIMAL(9,2);
/

CREATE TYPE ResidentialType UNDER PropertyType 
(BedRooms  INTEGER,
 BathRooms INTEGER,
 Assessments AssessType )
   NOT FINAL
   INSTANTIABLE;
/

CREATE TABLE Residential OF ResidentialType
 (CONSTRAINT ResidentialPK PRIMARY KEY(PropNo), 
  CONSTRAINT AgentRefFK1 FOREIGN KEY(AgentRef) REFERENCES Agent )
  OBJECT IDENTIFIER IS SYSTEM GENERATED ;

CREATE TYPE IndustrialType UNDER PropertyType 
(Zoning  VARCHAR(20),
 AccessDesc VARCHAR(20),
 RailAvailable CHAR(1),
 Parking VARCHAR(10) )
   NOT FINAL
   INSTANTIABLE;
/

CREATE TABLE Industrial OF IndustrialType
(CONSTRAINT IndustrialPK PRIMARY KEY(PropNo), 
 CONSTRAINT AgentRefFK2 FOREIGN KEY(AgentRef) REFERENCES Agent )
 OBJECT IDENTIFIER IS SYSTEM GENERATED ;


-- Example 19.22
INSERT INTO Agent
(AgentNo, AName, Address, Email, Phone)
VALUES (999999, 'Sue Smith', 
        AddressType('123 Any Street', 'Denver', 'CO', '80217'),
         'sue.smith@anyisp.com', '13031234567');

INSERT INTO Agent
(AgentNo, AName, Address, Email, Phone)
VALUES (999998, 'John Smith', 
        AddressType('123 Big Street', 'Boulder', 'CO', '80217'),
         'john.smith@anyisp.com', '13034567123');


-- Example 19.23
INSERT INTO Residential
(PropNo, Address, SqFt, AgentRef, BedRooms, BathRooms, Assessments)
SELECT 999999, AddressType('123 Any Street', 'Denver', 'CO', '80217'), 
       2000, REF(A), 3, 2, AssessType(190000, 200000)
FROM Agent A
WHERE AgentNo = 999999;

-- This INSERT statement maintains set inclusion between the Property
-- and the Residential tables.
INSERT INTO Property
(PropNo, Address, SqFt, AgentRef)
SELECT 999999, AddressType('123 Any Street', 'Denver', 'CO', '80217'), 
       2000, REF(A)
FROM Agent A
WHERE AgentNo = 999999;


-- Example 19.24
UPDATE Residential
  SET AgentRef = 
   ( SELECT REF(A) FROM Agent A WHERE AgentNo = 999998 )
  WHERE PropNo = 999999;

-- This UPDATE statement maintains consistency between the Property
-- and the Residential tables.
UPDATE Property
  SET AgentRef = 
   ( SELECT REF(A) FROM Agent A WHERE AgentNo = 999998 )
  WHERE PropNo = 999999;


-- Example 19.25
SELECT PropNo, P.Address.City, DEREF(AgentRef).Address.City
 FROM Property P
 WHERE DEREF(AgentRef).AName = 'John Smith';


-- Example 19.26
SELECT PropNo, P.Address.City, P.AgentRef.Address.City
 FROM Property P
 WHERE P.AgentRef.AName = 'John Smith';

-- Example 19.27
-- This example does not produce the same result as Example 19.20 due to syntax errors with type substitution
-- in INSERT statements.
SELECT PropNo, Address, Location
 FROM Property P
 WHERE Sqft > 1500 AND DEREF(REF(P)) IS OF (ResidentialType);


-- Example 19.28
SELECT VALUE(A) FROM Agent A;

-- Example 19.29: Creating a Table with an XMLType Column
CREATE TABLE AccountXML1 (
 AcctId       INTEGER   PRIMARY KEY,
 AcctDetails  XMLType,
 AcctBal      NUMBER(9,2) );

-- Example 19.30: Creating a Table of XMLType
CREATE TABLE AccountXML2 OF XMLType;

-- Example 19.31: Inserting a row into a Table with an XMLType Column
 INSERT INTO AccountXML1 VALUES (1,
     '<Account>
       <AcctFName>John</AcctFName>
       <AcctLName>Smith</AcctLName>
       <AcctStreet>1234567 Quebec St.</AcctStreet>
       <AcctCity>Denver</AcctCity>
       <AcctState>CO</AcctState>
       <AcctZip>80237</AcctZip>
     </Account>',
    1000);

-- Example 19.32: Inserting a row into a Table of XMLType
INSERT INTO AccountXML2 VALUES (
    '<Account>
       <AcctFName>John</AcctFName>
       <AcctLName>Smith</AcctLName>
       <AcctStreet>1234567 Quebec St.</AcctStreet>
       <AcctCity>Denver</AcctCity>
       <AcctState>CO</AcctState>
       <AcctZip>80237</AcctZip>
    </Account>' );

-- Example 19.33: Selecting a row using the existsNode() function.
   SELECT  COUNT(*)
     FROM  AccountXML1
     WHERE existsNode(AcctDetails, '/Account/AcctFName') = 1;

-- Example 19.34: Selecting a row using the existsNode() function.
SELECT  extractValue(AcctDetails, '/Account/AcctStreet') "Street"
 FROM  AccountXML1
 WHERE extractValue(AcctDetails, '/Account/AcctStreet') LIKE '%St%';

-- Example 19.35: Selecting a row using the existsNode() and extractValue() functions
SELECT  extractValue(AcctDetails, '/Account/AcctCity')
 FROM  AccountXML1
 WHERE existsNode(AcctDetails, '/Account[AcctZip="80237"]') = 1;

-- Example 19.36: Retrieving rows from an XMLType table
-- First adjust length of result string using an SQL*Plus command
SET LONG 1000

SELECT a.getClobVal() FROM AccountXML2 a;

-- Identical result as using the * operator
SELECT * FROM AccountXML2;

-- Example 19.37: Retrieving rows using FLWOR
SELECT AcctId, XMLQuery(
'for $i in /Account
 where $i /AcctCity = "Denver"
 order by $i/AcctFName
 return $i/AcctFName'
passing by value AcctDetails
RETURNING CONTENT) XMLData
FROM AccountXML1;

