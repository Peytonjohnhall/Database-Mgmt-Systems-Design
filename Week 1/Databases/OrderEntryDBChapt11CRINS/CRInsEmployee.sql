CREATE TABLE Employee
( 	EmpNo 	 	CHAR(8),
  	EmpFirstName    VARCHAR(20) CONSTRAINT EmpFirstNameRequired NOT NULL,
	EmpLastName     VARCHAR(30) CONSTRAINT EmpLastNameRequired NOT NULL,
	EmpPhone        CHAR(15),
	EmpEMail        VARCHAR(50) CONSTRAINT EmpEMailRequired NOT NULL,
   	SupEmpNo 	CHAR(8),
        EmpCommRate	DECIMAL(3,3),
CONSTRAINT PKEmployee PRIMARY KEY (EmpNo),
CONSTRAINT UniqueEMail UNIQUE(EmpEMail),
CONSTRAINT FKSupEmpNo FOREIGN KEY (SupEmpNo) REFERENCES Employee );

INSERT INTO employee
	(EmpNo, EmpFirstName, EmpLastName, EmpPhone, EmpEMail,
 	SupEmpNo, EmpCommRate)
	VALUES ('E9884325','Thomas','Johnson','(303) 556-9987','TJohnson@bigco.com',NULL,0.05);

INSERT INTO employee
	(EmpNo, EmpFirstName, EmpLastName, EmpPhone, EmpEMail,
 	SupEmpNo, EmpCommRate)
	VALUES ('E8843211','Amy','Tang','(303) 556-4321','ATang@bigco.com','E9884325',0.04);

INSERT INTO employee
	(EmpNo, EmpFirstName, EmpLastName, EmpPhone, EmpEMail,
 	SupEmpNo, EmpCommRate)
	VALUES ('E9345771','Colin','White','(303) 221-4453','CWhite@bigco.com','E9884325',0.04);

INSERT INTO employee
	(EmpNo, EmpFirstName, EmpLastName, EmpPhone, EmpEMail,
 	SupEmpNo, EmpCommRate)
	VALUES ('E1329594','Landi','Santos','(303) 789-1234','LSantos@bigco.com','E8843211',0.02);

INSERT INTO employee
	(EmpNo, EmpFirstName, EmpLastName, EmpPhone, EmpEMail,
 	SupEmpNo, EmpCommRate)
	VALUES ('E8544399','Joe','Jenkins','(303) 221-9875','JJenkins@bigco.com','E8843211',0.02);

INSERT INTO employee
	(EmpNo, EmpFirstName, EmpLastName, EmpPhone, EmpEMail,
 	SupEmpNo, EmpCommRate)
	VALUES ('E9954302','Mary','Hill','(303) 556-9871','MHill@bigco.com','E8843211',0.02);

INSERT INTO employee
	(EmpNo, EmpFirstName, EmpLastName, EmpPhone, EmpEMail,
 	SupEmpNo)
	VALUES ('E9973110','Theresa','Beck','(720) 320-2234','TBeck@bigco.com','E9884325');
