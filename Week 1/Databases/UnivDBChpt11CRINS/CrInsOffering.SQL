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
	
