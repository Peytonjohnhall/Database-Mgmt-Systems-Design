-- PostgreSQL examples from Appendix 19.B
-- PostgreSQL implementation of examples in 19.2 (standard SQL examples)

-- Drop objects if already exist
DROP TABLE Residential;
DROP TABLE Industrial;
DROP TABLE Property;
DROP TABLE Agent;
DROP TYPE PropertyType;
DROP TYPE AgentType;
DROP TYPE AddressType;
DROP TYPE PointPG;
DROP SEQUENCE AgentNoSeq;
DROP SEQUENCE PropNoSeq;

-- Example 19.B.1
-- Corresponds to Example 19.1
-- Composite type
-- PostgreSQL lacks type inheritance so ColorPoint example not shown.

CREATE TYPE PointPG AS
-- X and Y coordinates
-- PostgreSQL has a built-in Point type so change type name
( X FLOAT,   
  Y FLOAT ); 

-- PostgreSQL does not support the UNDER clause because no type inheritance
-- Syntax error with UNDER clause
-- CREATE TYPE ColorPoint UNDER PointPG AS
--  (Color INTEGER );

-- Example 19.B.2
-- Corresponds to Example 19.6

CREATE TYPE AddressType AS 
 (Street  VARCHAR(50),
  City    VARCHAR(30),
  State   CHAR(2),
  Zip     CHAR(9) );

-- CREATE TYPE cannot use SERIAL as a data type
CREATE TYPE AgentType AS 
(AgentNo INTEGER,
 AName   VARCHAR(30),
 Address AddressType,
 Phone   CHAR(13),
 Email   VARCHAR(50) );

-- PostgreSQL supports typed tables
-- Object identifiers not supported as a data type so a sequence is used for generation of PK values.

CREATE SEQUENCE AgentNoSeq
START 1 INCREMENT 1;

CREATE TABLE Agent OF AgentType
(AgentNo PRIMARY KEY DEFAULT NEXTVAL('AgentNoSeq') );

-- Another way is to remove AgentNo from AgentType
-- Add AgentNo as a column of Agent
-- Agent is not a typed table.
-- This example is not shown in Appendix 19.b.

-- CREATE TABLE Agent
-- ( AgentNo SERIAL PRIMARY KEY,
--  AgentDetails AgentType);

-- Syntax error: identity columns not supported on typed tables
-- CREATE TABLE Agent OF AgentType
-- (AgentNo PRIMARY KEY GENERATED ALWAYS AS IDENTITY );

-- Example 19.B.3
-- Corresponds to Example 19.7
-- SCOPE clause not supported in PostgreSQL
-- Use foreign key constraint in table definition

CREATE TYPE PropertyType AS
(PropNo   INTEGER,
 Address  AddressType,
 SqFt     INTEGER,
 PView    BYTEA, -- BYTEA is PostgreSQL data type for BLOB
 Location Point,
 AgentNo INTEGER );

-- REF is not in PostgreSQL syntax
-- GENERATED ALWAYS AS IDENTITY not supported for typed tables
-- Use a sequence with a DEFAULT clause

CREATE SEQUENCE PropNoSeq
START 1 INCREMENT 1;

CREATE TABLE Property OF PropertyType
( PropNo PRIMARY KEY DEFAULT NEXTVAL('PropNoSeq'), 
  AgentNo REFERENCES Agent );

-- Example 19.B.4
-- Corresponds to Example 19.8

-- PostgreSQL supports table inheritance
-- PostgreSQL does not support type inheritance

-- Array size limits can be specified but PostgreSQL does not check.
-- Include all columns in PropertyType as UNDER clause does not work with composite types.
-- Typed tables do not support INHERITS clause so no ResidentialType

CREATE TABLE Residential 
(
 BedRooms    INTEGER,
 BathRooms   INTEGER,
 Assessments DECIMAL(9,2) ARRAY[6] 
) INHERITS (Property);

CREATE TABLE Industrial 
(  Zoning        VARCHAR(20),
   AccessDesc    VARCHAR(20),
   RailAvailable BOOLEAN,
   Parking       VARCHAR(10) 
) INHERITS (Property);

-- Example 19.B.5
-- Extends Example 19.9
-- Adds details from Example 19.11
-- Insert rows for Agent, Residential, and Industrial consecutively
-- Generated PK value by default clause in CREATE TABLE statement

INSERT INTO Agent
(AName, Address, Email, Phone)
VALUES ('Sue Smith', 
        ROW('123 Any Street', 'Denver', 'CO', '80217'),
        'sue.smith@anyisp.com', '13031234567');

INSERT INTO Residential
(Address, SqFt, AgentNo, BedRooms, BathRooms, Assessments)
VALUES( ROW('123 Any Street', 'Denver', 'CO', '80217'), 
       2000, CurrVal('AgentNoSeq'), 3, 2, ARRAY[190000, 200000] );

INSERT INTO Industrial
(Address, SqFt, AgentNo, Zoning, AccessDesc, RailAvailable, Parking)
VALUES( ROW('123 Big Street', 'Parker', 'CO', '80234'), 
       4000, CurrVal('AgentNoSeq'), 'A1', 'Street', FALSE, 'Large lot' );

-- Example 19.B.6
-- Extends Example 19.10
-- Adds details from Example 19.11
-- Insert rows for Agent, Residential, and Industrial consecutively
INSERT INTO Agent
(AName, Address, Email, Phone)
VALUES ('John Smith', 
        ROW('123 Big Street', 'Boulder', 'CO', '80217'),
         'john.smith@bigisp.com', '13034567123');

INSERT INTO Residential
(Address, SqFt, AgentNo, BedRooms, BathRooms, Assessments)
VALUES( ROW('123 Big Street', 'Denver', 'CO', '80203'), 
       2000, CurrVal('AgentNoSeq'), 2, 3, ARRAY[200000, 190000] );

INSERT INTO Industrial
(Address, SqFt, AgentNo, Zoning, AccessDesc, RailAvailable, Parking)
VALUES( ROW('123 Any Road', 'Parker', 'CO', '80238'), 
  3000, CurrVal('AgentNoSeq'), 'A2', 'Strip mall', TRUE, 'Small lot' );

-- AddressType does not work

-- Example 19.11
-- Insert rows for Agent and Residential consecutively
-- NextVal function must have been used in the current session before CurrVal can be used.
-- INSERT INTO Agent
-- (AName, Address, Email, Phone)
-- VALUES ('John Smith', 
--        AddressType('123 Big Street', 'Boulder', 'CO', '80217'),
--         'john.smith@anyisp.com', '13034567123');

-- Example 19.B.7
-- Extends Example 19.12
-- Update AgentNo in the last Residential row to the first Agent row.
-- Subtract 1 from current value of each sequence because current value 
-- of property no sequence is an industrial row

UPDATE Residential
  SET AgentNo = CurrVal('AgentNoSeq') - 1
  WHERE PropNo = CurrVal('PropNoSeq') - 1;

-- Example 19.B.8
-- Check extents
SELECT * FROM Property;
SELECT * FROM Residential;
SELECT * FROM Industrial;

-- Example 19.B.9
-- Extends Example 19.13
-- No DEREF function because OIDs and REF columns not supported
-- Need parentheses to reference components of composite types

SELECT PropNo, (P.Address).City AS PropertyCity, (A.Address).City AS AgentCity
 FROM Property P, Agent A
 WHERE A.AName = 'John Smith'
   AND P.AgentNo = A.AgentNo;

-- Example 19.B.10
-- Corresponds to Example 19.14

SELECT PropNo, Address, Location, AgentNo
 FROM ONLY (Residential)
 WHERE Sqft > 1500;

