CREATE TABLE Registration (
RegNo INTEGER NOT NULL,
StdNo CHAR(11) NOT NULL,
RegStatus CHAR(2),
RegDate DATE,
RegTerm CHAR(6) NOT NULL,
RegYear INTEGER NOT NULL,
CONSTRAINT RegistrationPK PRIMARY KEY (RegNo),
CONSTRAINT Student3FK FOREIGN KEY (StdNo) REFERENCES Student );

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




