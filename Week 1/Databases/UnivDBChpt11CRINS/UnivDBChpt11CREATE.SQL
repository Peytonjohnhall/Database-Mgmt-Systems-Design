-- Works for both Oracle and PostgreSQL

-- Drop tables if exist
-- DROP TABLE Enrollment;
-- DROP TABLE Registration;
-- DROP TABLE Offering;
-- DROP TABLE Faculty;
-- DROP TABLE Course;
-- DROP TABLE Student;

CREATE TABLE Student
( StdNo 	CHAR(11)    CONSTRAINT StdNoRequired NOT NULL,
  StdFirstName  VARCHAR(50) CONSTRAINT StdFirstNameRequired NOT NULL,
  StdLastName   VARCHAR(50) CONSTRAINT StdLastNameRequired NOT NULL,
  StdCity	VARCHAR(50) CONSTRAINT StdCityRequired NOT NULL,
  StdState	CHAR(2)	    CONSTRAINT StdStateRequired NOT NULL,
  StdZip	CHAR(10)    CONSTRAINT StdZipRequired NOT NULL,
  StdMajor	CHAR(6),
  StdClass	CHAR(6),
  StdGPA	DECIMAL(3,2) DEFAULT 0,	
  CONSTRAINT PKStudent PRIMARY KEY (StdNo),	
  CONSTRAINT ValidGPA CHECK ( StdGPA BETWEEN 0 AND 4 ),
  CONSTRAINT ValidStdClass CHECK (StdClass IN ('FR','SO', 'JR','SR')),
  CONSTRAINT MajorDeclared CHECK 
               ( StdClass IN ('FR','SO') OR StdMajor IS NOT NULL ) );

CREATE TABLE Course (
CourseNo	CHAR(6),
CrsDesc		VARCHAR(50) CONSTRAINT CrsDescRequired NOT NULL,
CrsUnits	INTEGER,
CONSTRAINT CoursePK PRIMARY KEY (CourseNo), 
CONSTRAINT UniqueCrsDesc UNIQUE (CrsDesc)  );
CREATE TABLE Faculty (
FacNo		CHAR(11),
FacFirstName	VARCHAR(30) CONSTRAINT FacFirstNameRequired NOT NULL,
FacLastName	VARCHAR(30) CONSTRAINT FacLastNameRequired NOT NULL,
FacCity		VARCHAR(30) CONSTRAINT FacCityRequired NOT NULL,
FacState	CHAR(2) CONSTRAINT FacStateRequired NOT NULL,
FacZipCode	CHAR(10) CONSTRAINT FacZipRequired NOT NULL,
FacRank		CHAR(4),
FacHireDate	DATE,
FacSalary	DECIMAL(10,2),
FacSupervisor	CHAR(11),
FacDept		CHAR(6),
CONSTRAINT FacultyPK PRIMARY KEY (FacNo), 
CONSTRAINT SupervisorFK FOREIGN KEY (FacSupervisor) REFERENCES Faculty );

CREATE TABLE Offering (
OfferNo INTEGER,
CourseNo CHAR(6) CONSTRAINT OffCourseNoRequired NOT NULL,
OffTerm CHAR(6) CONSTRAINT OffTermRequired NOT NULL,
OffYear INTEGER DEFAULT 2022 CONSTRAINT OffYearRequired NOT NULL,
OffLocation VARCHAR(30),
OffTime VARCHAR(10),
FacNo CHAR(11),
OffDays CHAR(6) DEFAULT 'MW',
OffLimit INTEGER,
OffNumEnrolled INTEGER,
CONSTRAINT OfferingPK PRIMARY KEY (OfferNo),
CONSTRAINT CourseFK FOREIGN KEY (CourseNo) REFERENCES Course,
CONSTRAINT FacultyFK FOREIGN KEY (FacNo) REFERENCES Faculty );

CREATE TABLE Registration (
RegNo INTEGER NOT NULL,
StdNo CHAR(11) NOT NULL,
RegStatus CHAR(2),
RegDate DATE,
RegTerm CHAR(6) NOT NULL,
RegYear INTEGER NOT NULL,
CONSTRAINT RegistrationPK PRIMARY KEY (RegNo),
CONSTRAINT Student3FK FOREIGN KEY (StdNo) REFERENCES Student );

CREATE TABLE Enrollment (
RegNo INTEGER not null,
OfferNo INTEGER not null,
EnrGrade DECIMAL(3,2),
CONSTRAINT EnrollmentPK2 PRIMARY KEY (RegNo, OfferNo),
CONSTRAINT OfferingFK2 FOREIGN KEY (OfferNo) REFERENCES Offering 
  ON DELETE CASCADE,
CONSTRAINT RegistrationFK FOREIGN KEY (RegNo) REFERENCES Registration 
  ON DELETE CASCADE );


