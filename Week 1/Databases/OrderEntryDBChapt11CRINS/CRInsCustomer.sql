-- Executes in both Oracle and PostgreSQL

CREATE TABLE Customer
( 	CustNo 	        CHAR(8),
        CustFirstName   VARCHAR(20) CONSTRAINT CustFirstNameRequired NOT NULL,
        CustLastName    VARCHAR(30) CONSTRAINT CustLastNameRequired NOT NULL,
	CustStreet	VARCHAR(50),
	CustCity	VARCHAR(30),
   	CustState	CHAR(2),
	CustZip		CHAR(10),
	CustBal		DECIMAL(12,2) DEFAULT 0,
 CONSTRAINT PKCustomer PRIMARY KEY (CustNo)  );

INSERT INTO customer
	(CustNo, CustFirstName, CustLastName, CustStreet, CustCity,
 	CustState, CustZip, CustBal) 
	VALUES('C0954327','Sheri','Gordon','336 Hill St.','Littleton','CO','80129-5543',230.00);


INSERT INTO customer
	(CustNo, CustFirstName, CustLastName, CustStreet, CustCity,
 	CustState, CustZip, CustBal) 
	VALUES('C1010398','Jim','Glussman','1432 E. Ravenna','Denver','CO','80111-0033',200.00);

INSERT INTO customer
	(CustNo, CustFirstName, CustLastName, CustStreet, CustCity,
 	CustState, CustZip, CustBal) 
	VALUES('C2388597','Beth','Taylor','2396 Rafter Rd','Seattle','WA','98103-1121',500.00);

INSERT INTO customer
	(CustNo, CustFirstName, CustLastName, CustStreet, CustCity,
 	CustState, CustZip, CustBal) 
	VALUES('C3340959','Betty','Wise','4334 153rd NW','Seattle','WA','98178-3311',200.00);

INSERT INTO customer
	(CustNo, CustFirstName, CustLastName, CustStreet, CustCity,
 	CustState, CustZip, CustBal) 
	VALUES('C3499503','Bob','Mann','1190 Lorraine Cir.','Monroe','WA','98013-1095',0.00);

INSERT INTO customer
	(CustNo, CustFirstName, CustLastName, CustStreet, CustCity,
 	CustState, CustZip, CustBal) 
	VALUES('C8543321','Ron','Thompson','789 122nd St.','Renton','WA','98666-1289',85.00);

INSERT INTO customer
	(CustNo, CustFirstName, CustLastName, CustStreet, CustCity,
 	CustState, CustZip, CustBal) 
	VALUES('C8574932','Wally','Jones','411 Webber Ave.','Seattle','WA','98105-1093',1500.00);

INSERT INTO customer
	(CustNo, CustFirstName, CustLastName, CustStreet, CustCity,
 	CustState, CustZip, CustBal) 
	VALUES('C8654390','Candy','Kendall','456 Pine St.','Seattle','WA','98105-3345',50.00);

INSERT INTO customer
	(CustNo, CustFirstName, CustLastName, CustStreet, CustCity,
 	CustState, CustZip, CustBal) 
	VALUES('C9128574','Jerry','Wyatt','16212 123rd Ct.','Denver','CO','80222-0022',100.00);

INSERT INTO customer
	(CustNo, CustFirstName, CustLastName, CustStreet, CustCity,
 	CustState, CustZip, CustBal) 
	VALUES('C9403348','Mike','Boren','642 Crest Ave.','Englewood','CO','80113-5431',0.00);

INSERT INTO customer
	(CustNo, CustFirstName, CustLastName, CustStreet, CustCity,
 	CustState, CustZip, CustBal) 
	VALUES('C9432910','Larry','Styles','9825 S. Crest Lane','Bellevue','WA','98104-2211',250.00);

INSERT INTO customer
	(CustNo, CustFirstName, CustLastName, CustStreet, CustCity,
 	CustState, CustZip, CustBal) 
	VALUES('C9543029','Sharon','Johnson','1223 Meyer Way','Fife','WA','98222-1123',856.00);

INSERT INTO customer
	(CustNo, CustFirstName, CustLastName, CustStreet, CustCity,
 	CustState, CustZip, CustBal) 
	VALUES('C9549302','Todd','Hayes','1400 NW 88th','Lynnwood','WA','98036-2244',0.00);

INSERT INTO customer
	(CustNo, CustFirstName, CustLastName, CustStreet, CustCity,
 	CustState, CustZip, CustBal) 
	VALUES('C9857432','Homer','Wells','123 Main St.','Seattle','WA','98105-4322',500.00);

INSERT INTO customer
	(CustNo, CustFirstName, CustLastName, CustStreet, CustCity,
 	CustState, CustZip, CustBal) 
	VALUES('C9865874','Mary','Hill','206 McCaffrey','Littleton','CO','80129-5543',150.00);

INSERT INTO customer
	(CustNo, CustFirstName, CustLastName, CustStreet, CustCity,
 	CustState, CustZip, CustBal) 
	VALUES('C9943201','Harry','Sanders','1280 S. Hill Rd.','Fife','WA','98222-2258',1000.00);
