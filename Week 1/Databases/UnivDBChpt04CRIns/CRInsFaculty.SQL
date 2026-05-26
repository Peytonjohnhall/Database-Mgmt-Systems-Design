-- Works for both Oracle and PostgreSQL

-- Drop table if already exists
-- DROP TABLE Faculty;

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

-- PostgreSQL requires parent faculty rows to be inserted before child parent rows because COMMIT is automatic

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

