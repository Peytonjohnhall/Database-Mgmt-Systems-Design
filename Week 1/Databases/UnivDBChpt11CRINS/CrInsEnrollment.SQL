CREATE TABLE Enrollment (
RegNo INTEGER not null,
OfferNo INTEGER not null,
EnrGrade DECIMAL(3,2),
CONSTRAINT EnrollmentPK2 PRIMARY KEY (RegNo, OfferNo),
CONSTRAINT OfferingFK2 FOREIGN KEY (OfferNo) REFERENCES Offering 
  ON DELETE CASCADE,
CONSTRAINT RegistrationFK FOREIGN KEY (RegNo) REFERENCES Registration 
  ON DELETE CASCADE );

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

