-- Works for both Oracle and PostgreSQL

-- INSERT statements to populate the Student table

INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState, StdMajor, StdClass, StdGPA, StdZip)
	VALUES ('123-45-6789','HOMER','WELLS','SEATTLE','WA','IS','FR',3.00,'98121-1111');

INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState, StdMajor, StdClass, StdGPA, StdZip)
	VALUES ('124-56-7890','BOB','NORBERT','BOTHELL','WA','FIN','JR',2.70,'98011-2121');

INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState, StdMajor, StdClass, StdGPA, StdZip)
	VALUES ('234-56-7890','CANDY','KENDALL','TACOMA','WA','ACCT','JR',3.50,'99042-3321');

INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState, StdMajor, StdClass, StdGPA, StdZip)
	VALUES ('345-67-8901','WALLY','KENDALL','SEATTLE','WA','IS','SR',2.80,'98123-1141');

INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState, StdMajor, StdClass, StdGPA, StdZip)
	VALUES ('456-78-9012','JOE','ESTRADA','SEATTLE','WA','FIN','SR',3.20,'98121-2333');

INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState, StdMajor, StdClass, StdGPA, StdZip)
	VALUES ('567-89-0123','MARIAH','DODGE','SEATTLE','WA','IS','JR',3.60,'98114-0021');

INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState, StdMajor, StdClass, StdGPA, StdZip)
	VALUES ('678-90-1234','TESS','DODGE','REDMOND','WA','ACCT','SO',3.30,'98116-2344');

INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState, StdMajor, StdClass, StdGPA, StdZip)
	VALUES ('789-01-2345','ROBERTO','MORALES','SEATTLE','WA','FIN','JR',2.50,'98121-2212');

INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState, StdMajor, StdClass, StdGPA, StdZip)
	VALUES ('876-54-3210','CRISTOPHER','COLAN','SEATTLE','WA','IS','SR',4.00,'98114-1332');

INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState, StdMajor, StdClass, StdGPA, StdZip)
	VALUES ('890-12-3456','LUKE','BRAZZI','SEATTLE','WA','IS','SR',2.20,'98116-0021');

INSERT INTO Student
	(StdNo, StdFirstName, StdLastName, StdCity,
	 StdState, StdMajor, StdClass, StdGPA, StdZip)
	VALUES ('901-23-4567','WILLIAM','PILGRIM','BOTHELL','WA','IS','SO',3.80,'98113-1885');

-- INSERT statements to populate the Course table
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

-- INSERT statements to populate the Faculty table
INSERT INTO Faculty
	(FacNo, FacFirstName, FacLastName, FacCity, FacState,
	 FacDept, FacRank, FacSalary, FacSupervisor, FacHireDate, FacZipCode)
	 VALUES ('543-21-0987','VICTORIA','EMMANUEL','BOTHELL','WA','MS','PROF',120000.0,NULL,'15-Apr-2008','98011-2242');

INSERT INTO Faculty
	(FacNo, FacFirstName, FacLastName, FacCity, FacState,
	 FacDept, FacRank, FacSalary, FacSupervisor, FacHireDate, FacZipCode)
	 VALUES ('765-43-2109','NICKI','MACON','BELLEVUE','WA','FIN','PROF',65000.00,NULL,'11-Apr-2009','98015-9945');

INSERT INTO Faculty
	(FacNo, FacFirstName, FacLastName, FacCity, FacState,
	 FacDept, FacRank, FacSalary, FacSupervisor, FacHireDate, FacZipCode)
	 VALUES ('654-32-1098','LEONARD','FIBON','SEATTLE','WA','MS','ASSC',70000.00,'543-21-0987','01-May-2006','98121-0094');

INSERT INTO Faculty
	(FacNo, FacFirstName, FacLastName, FacCity, FacState,
	 FacDept, FacRank, FacSalary, FacSupervisor, FacHireDate, FacZipCode)
	 VALUES ('098-76-5432','LEONARD','VINCE','SEATTLE','WA','MS','ASST',35000.00,'654-32-1098','10-Apr-2007','98111-9921');

INSERT INTO Faculty
	(FacNo, FacFirstName, FacLastName, FacCity, FacState,
	 FacDept, FacRank, FacSalary, FacSupervisor, FacHireDate, FacZipCode)
	 VALUES ('876-54-3210','CRISTOPHER','COLAN','SEATTLE','WA','MS','ASST',40000.00,'654-32-1098','01-Mar-2011','98114-1332');

INSERT INTO Faculty
	(FacNo, FacFirstName, FacLastName, FacCity, FacState,
	 FacDept, FacRank, FacSalary, FacSupervisor, FacHireDate, FacZipCode)
	 VALUES ('987-65-4321','JULIA','MILLS','SEATTLE','WA','FIN','ASSC',75000.00,'765-43-2109','15-Mar-2012','98114-9954');

-- INSERT statements to populate the Offering table
INSERT INTO offering
	(OfferNo, CourseNo, OffTerm, OffYear, OffLocation, OffTime, FacNo, OffDays, OffLimit, OffNumEnrolled)
	VALUES (1111,'IS320','SUMMER',2020,'BLM302','10:30:00',NULL,'MW', 10, 0);
	
INSERT INTO offering
	(OfferNo, CourseNo, OffTerm, OffYear, OffLocation, OffTime, FacNo, OffDays, OffLimit, OffNumEnrolled)
	VALUES (1234,'IS320','FALL',2019,'BLM302','10:30:00','098-76-5432','MW',10,5);
	
INSERT INTO offering
	(OfferNo, CourseNo, OffTerm, OffYear, OffLocation, OffTime, FacNo, OffDays, OffLimit, OffNumEnrolled)
	VALUES (2222,'IS460','SUMMER',2019,'BLM412','13:30:00',NULL,'TTH', 30, 0);
	
INSERT INTO offering
	(OfferNo, CourseNo, OffTerm, OffYear, OffLocation, OffTime, FacNo, OffDays, OffLimit, OffNumEnrolled)
	VALUES (3333,'IS320','SPRING',2020,'BLM214','08:30:00','098-76-5432','MW',20,0);
	
INSERT INTO offering
	(OfferNo, CourseNo, OffTerm, OffYear, OffLocation, OffTime, FacNo, OffDays, OffLimit, OffNumEnrolled)
	VALUES (4321,'IS320','FALL',2019,'BLM214','15:30:00','098-76-5432','TTH', 15, 5);
	
INSERT INTO offering
	(OfferNo, CourseNo, OffTerm, OffYear, OffLocation, OffTime, FacNo, OffDays, OffLimit, OffNumEnrolled)
	VALUES (4444,'IS320','WINTER',2020,'BLM302','15:30:00','543-21-0987','TTH',10,2);
	
INSERT INTO offering
	(OfferNo, CourseNo, OffTerm, OffYear, OffLocation, OffTime, FacNo, OffDays, OffLimit, OffNumEnrolled)
	VALUES (5555,'FIN300','WINTER',2020,'BLM207','08:30:00','765-43-2109','MW',15,0);
	
INSERT INTO offering
	(OfferNo, CourseNo, OffTerm, OffYear, OffLocation, OffTime, FacNo, OffDays, OffLimit, OffNumEnrolled)
	VALUES (5678,'IS480','WINTER',2020,'BLM302','10:30:00','987-65-4321','MW',20,1);
	
INSERT INTO offering
	(OfferNo, CourseNo, OffTerm, OffYear, OffLocation, OffTime, FacNo, OffDays, OffLimit, OffNumEnrolled)
	VALUES (5679,'IS480','SPRING',2020,'BLM412','15:30:00','876-54-3210','TTH',10,9);
	
INSERT INTO offering
	(OfferNo, CourseNo, OffTerm, OffYear, OffLocation, OffTime, FacNo, OffDays, OffLimit, OffNumEnrolled)
	VALUES (6666,'FIN450','WINTER',2020,'BLM212','10:30:00','987-65-4321','TTH',20,0);
	
INSERT INTO offering
	(OfferNo, CourseNo, OffTerm, OffYear, OffLocation, OffTime, FacNo, OffDays, OffLimit, OffNumEnrolled)
	VALUES (7777,'FIN480','SPRING',2020,'BLM305','13:30:00','765-43-2109','MW',20,0);
	
INSERT INTO offering
	(OfferNo, CourseNo, OffTerm, OffYear, OffLocation, OffTime, FacNo, OffDays, OffLimit, OffNumEnrolled)
	VALUES (8888,'IS320','SUMMER',2020,'BLM405','13:30:00','654-32-1098','MW',20,0);
	
INSERT INTO offering
	(OfferNo, CourseNo, OffTerm, OffYear, OffLocation, OffTime, FacNo, OffDays, OffLimit, OffNumEnrolled)
	VALUES (9876,'IS460','SPRING',2020,'BLM307','13:30:00','654-32-1098','TTH',10,6);

-- INSERT statements to populate the Registration table
INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1234,'123-45-6789','P','29-Mar-2019','Fall',2019);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1236,'234-56-7890','P','29-Mar-2019','Fall',2019);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1238,'345-67-8901','P','29-Mar-2019','Fall',2019);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1240,'678-90-1234','P','29-Oct-2019','Winter',2020);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1242,'567-89-0123','P','29-Mar-2019','Fall',2019);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1244,'678-90-1234','P','29-Mar-2019','Fall',2019);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1246,'124-56-7890','P','29-Oct-2019','Winter',2020);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1248,'789-01-2345','P','29-Mar-2019','Fall',2019);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1250,'876-54-3210','P','29-Mar-2019','Fall',2019);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1252,'890-12-3456','P','29-Mar-2019','Fall',2019);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1254,'901-23-4567','P','29-Mar-2019','Fall',2019);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1256,'123-45-6789','F','2-Nov-2019','Winter',2020);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1258,'234-56-7890','F','27-Feb-2020','Spring',2020);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1260,'345-67-8901','F','27-Feb-2020','Spring',2020);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1262,'456-78-9012','F','27-Feb-2020','Spring',2020);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1264,'567-89-0123','F','27-Feb-2020','Spring',2020);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1266,'124-56-7890','F','27-Feb-2020','Spring',2020);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1268,'678-90-1234','F','26-Feb-2020','Spring',2020);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1270,'789-01-2345','P','28-Feb-2020','Spring',2020);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1272,'890-12-3456','P','28-Feb-2020','Spring',2020);

INSERT INTO registration
	(RegNo,StdNo,RegStatus,RegDate,RegTerm,RegYear)
	VALUES (1274,'901-23-4567','F','27-Feb-2020','Spring',2020);

-- INSERT statements to populate the Enrollment table
INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES ( 1234,1234,3.20 );

INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES (1236,1234,3.60 );
	
 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES (1238,1234,3.20);
	
 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES ( 1240,4444,2.50);
	
 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES ( 1242,1234,3.80);
 
 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES ( 1244,4321,3.10);
 
 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES ( 1246,4444,2.90);
 
 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES (1248,4321,3.80);
 
 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES (1250,4321,3.20 );
 
 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES (1252,4321,3.40 );
 
 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES (1254,4321,3.10 );

 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES ( 1256,4444,3.30);

 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES (1256,5678,3.40 );

 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES ( 1258,5679,0);

 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES ( 1258,9876,0);

 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES ( 1260,5679,3.10);

 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES ( 1260,9876,3.30);

 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES ( 1262,5679,3.10);

 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES ( 1262,9876,3.50);

 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES ( 1264,5679,3.20);

 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES ( 1264,9876,2.90);
 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES (1266,5679,3.50);

 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES (1268,5679,3.50);

 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES (1268,9876,3.60);

 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES (1270,5679,3.00);

 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES (1272,5679,3.30);

 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES (1274,5679,3.40);

 INSERT INTO enrollment
	(RegNo, OfferNo, EnrGrade)
	VALUES (1274,9876,2.80);

COMMIT;

SELECT COUNT(*) FROM Student;
-- Should be 11

SELECT COUNT(*) FROM Course;
-- Should be 7

SELECT COUNT(*) FROM Faculty;
-- Should be 6

SELECT COUNT(*) FROM Offering;
-- Should be 13

SELECT COUNT(*) FROM Registration;
-- Should be 21

SELECT COUNT(*) FROM Enrollment;
-- Should be 28
