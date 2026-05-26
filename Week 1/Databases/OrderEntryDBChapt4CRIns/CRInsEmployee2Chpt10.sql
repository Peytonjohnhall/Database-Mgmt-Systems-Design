-- CREATE TABLE and INSERT statements for the Employee2 table used in the hierarchical query problems.
-- Executes in both Oracle and PostgreSQL

CREATE TABLE Employee2
( 	EmpNo 	 	CHAR(8),
  	EmpFirstName    VARCHAR(50) CONSTRAINT EmpFirstNameRequired2 NOT NULL,
	EmpLastName     VARCHAR(50) CONSTRAINT EmpLastNameRequired2 NOT NULL,
	EmpSalary       DECIMAL(10,2) DEFAULT 0,
	EmpGrade        INTEGER,
   	SupEmpNo 	CHAR(8),
        EmpCommRate	DECIMAL(5,4) DEFAULT 0,
CONSTRAINT PKEmployee2 PRIMARY KEY (EmpNo),
CONSTRAINT FKSupEmpNo2 FOREIGN KEY (SupEmpNo) REFERENCES Employee2 );

INSERT INTO employee2
	(EmpNo, EmpFirstName, EmpLastName, EmpSalary, EmpGrade,
 	SupEmpNo, EmpCommRate)
	VALUES ('E9884325','Thomas','Johnson',60000,2,NULL,0.035);

INSERT INTO employee2
	(EmpNo, EmpFirstName, EmpLastName, EmpSalary, EmpGrade,
 	SupEmpNo, EmpCommRate)
	VALUES ('E8843211','Amy','Tang',35000,3,'E9884325',0.03);

INSERT INTO employee2
	(EmpNo, EmpFirstName, EmpLastName, EmpSalary, EmpGrade,
 	SupEmpNo, EmpCommRate)
	VALUES ('E9345771','Colin','White',40000,2,'E9884325',0.04);

INSERT INTO employee2
	(EmpNo, EmpFirstName, EmpLastName, EmpSalary, EmpGrade,
 	SupEmpNo, EmpCommRate)
	VALUES ('E1329594','Landi','Santos',36000,2,'E8843211',0.05);

INSERT INTO employee2
	(EmpNo, EmpFirstName, EmpLastName, EmpSalary, EmpGrade,
 	SupEmpNo, EmpCommRate)
	VALUES ('E8544399','Joe','Jenkins',30000,4,'E8843211',0.04);

INSERT INTO employee2
	(EmpNo, EmpFirstName, EmpLastName, EmpSalary, EmpGrade,
 	SupEmpNo, EmpCommRate)
	VALUES ('E9954302','Mary','Hill',37000,3,'E8843211',0.05);

INSERT INTO employee2
	(EmpNo, EmpFirstName, EmpLastName, EmpSalary, EmpGrade,
 	SupEmpNo, EmpCommRate)
	VALUES ('E9973110','Theresa','Beck',42000,1,'E9884325', 0.033);

INSERT INTO employee2
	(EmpNo, EmpFirstName, EmpLastName, EmpSalary, EmpGrade,
 	SupEmpNo, EmpCommRate)
	VALUES ('E1234567','Claire','Adams',50000,1, NULL,0.025);

INSERT INTO employee2
	(EmpNo, EmpFirstName, EmpLastName, EmpSalary, EmpGrade,
 	SupEmpNo, EmpCommRate)
	VALUES ('E7654321','Yanjuan','Pong',40000,3,'E1234567',0.03);

INSERT INTO employee2
	(EmpNo, EmpFirstName, EmpLastName, EmpSalary, EmpGrade,
 	SupEmpNo, EmpCommRate)
	VALUES ('E4321098','Miguel','Sanchez',52000,2,'E1234567',0.033);

INSERT INTO employee2
	(EmpNo, EmpFirstName, EmpLastName, EmpSalary, EmpGrade,
 	SupEmpNo, EmpCommRate)
	VALUES ('E6543210','Bradley','Smith',35000,3,'E7654321',0.045);

INSERT INTO employee2
	(EmpNo, EmpFirstName, EmpLastName, EmpSalary, EmpGrade,
 	SupEmpNo, EmpCommRate)
	VALUES ('E5432109','Susan','Henry',41000,2,'E7654321',0.05);

INSERT INTO employee2
	(EmpNo, EmpFirstName, EmpLastName, EmpSalary, EmpGrade,
 	SupEmpNo, EmpCommRate)
	VALUES ('E9876543','Michael','Roberts',55000,2,'E4321098',0.04);

INSERT INTO employee2
	(EmpNo, EmpFirstName, EmpLastName, EmpSalary, EmpGrade,
 	SupEmpNo, EmpCommRate)
	VALUES ('E8765432','Melissa','Cole',42000,3,'E4321098',0.033);

-- commit changes if not auto commit
COMMIT;