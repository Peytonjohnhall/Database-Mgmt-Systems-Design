CREATE TABLE OrderTbl
( 	OrdNo 	   CHAR(8),
  	OrdDate	   DATE    CONSTRAINT OrdDateRequired NOT NULL,
	CustNo	   CHAR(8) CONSTRAINT CustNoRequired NOT NULL,
        EmpNo	   CHAR(8),
        OrdName    VARCHAR(50),
        OrdStreet  VARCHAR(50),
        OrdCity    VARCHAR(30),
        OrdState   CHAR(2),
        OrdZip     CHAR(10),
CONSTRAINT PKOrderTbl PRIMARY KEY (OrdNo),
CONSTRAINT FKCustNo FOREIGN KEY (CustNo) REFERENCES Customer,
CONSTRAINT FKEmpNo FOREIGN KEY (EmpNo) REFERENCES Employee  );

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O1116324','23-Jan-2020','C0954327','E8544399','Sheri Gordon','336 Hill St.','Littleton','CO','80129-5543');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O1231231','23-Jan-2020','C9432910','E9954302','Larry Styles','9825 S. Crest Lane','Bellevue','WA','98104-2211');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O1241518','10-Feb-2020','C9549302',NULL,'Todd Hayes','1400 NW 88th','Lynnwood','WA','98036-2244');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O1455122','9-Jan-2020','C8574932','E9345771','Wally Jones','411 Webber Ave.','Seattle','WA','98105-1093');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O1579999','5-Jan-2020','C9543029','E8544399','Tom Johnson','1632 Ocean Dr.','Des Moines','WA','98222-1123');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O1615141','23-Jan-2020','C8654390','E8544399','Candy Kendall','456 Pine St.','Seattle','WA','98105-3345');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O1656777','11-Feb-2020','C8543321',NULL,'Ron Thompson','789 122nd St.','Renton','WA','98666-1289');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O2233457','12-Jan-2020','C2388597','E9884325','Beth Taylor','2396 Rafter Rd','Seattle','WA','98103-1121');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O2334661','14-Jan-2020','C0954327','E1329594','Mrs. Ruth Gordon','233 S. 166th','Seattle','WA','98011');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O3252629','23-Jan-2020','C9403348','E9954302','Mike Boren','642 Crest Ave.','Englewood','CO','80113-5431');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O3331222','13-Jan-2020','C1010398',NULL,'Jim Glussman','1432 E. Ravenna','Denver','CO','80111-0033');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O3377543','15-Jan-2020','C9128574','E8843211','Jerry Wyatt','16212 123rd Ct.','Denver','CO','80222-0022');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O4714645','11-Jan-2020','C2388597','E1329594','Beth Taylor','2396 Rafter Rd','Seattle','WA','98103-1121');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O5511365','22-Jan-2020','C3340959','E9884325','Betty White','4334 153rd NW','Seattle','WA','98178-3311');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O6565656','20-Jan-2020','C9865874','E8843211','Mr. Jack Sibley','166 E. 344th','Renton','WA','98006-5543');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O7847172','23-Jan-2020','C9943201',NULL,'Harry Sanders','1280 S. Hill Rd.','Fife','WA','98222-2258');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O7959898','19-Feb-2020','C8543321','E8544399','Ron Thompson','789 122nd St.','Renton','WA','98666-1289');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O7989497','16-Jan-2020','C3499503','E9345771','Bob Mann','1190 Lorraine Cir.','Monroe','WA','98013-1095');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O8979495','23-Jan-2020','C9865874',NULL,'HelenSibley','206 McCaffrey','Renton','WA','98006-5543');

INSERT INTO ordertbl
	(OrdNo, OrdDate, CustNo, EmpNo, OrdName, OrdStreet, OrdCity,
 	OrdState, OrdZip)
	VALUES ('O9919699','11-Feb-2020','C9857432','E9954302','Homer Wells','123 Main St.','Seattle','WA','98105-4322');
