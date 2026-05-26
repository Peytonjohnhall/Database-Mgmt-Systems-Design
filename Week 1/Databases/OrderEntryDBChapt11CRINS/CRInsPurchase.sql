CREATE TABLE Purchase
( 	PurchNo 	CHAR(8),
  	PurchDate	DATE CONSTRAINT PurchDateRequired NOT NULL,
	SuppNo		CHAR(8) CONSTRAINT SuppNo2Required NOT NULL,
	PurchPayMethod	CHAR(6) DEFAULT 'PO', 
 	PurchDelDate	DATE,
 CONSTRAINT PKPurchase PRIMARY KEY (PurchNo),
 CONSTRAINT SuppNoFK2 FOREIGN KEY (SuppNo) REFERENCES Supplier );
 
INSERT INTO purchase
	(PurchNo,PurchDate,SuppNo,PurchPayMethod,PurchDelDate)
	VALUES('P2224040','3-Feb-2020','S2029929','Credit','8-Feb-2020');
	
INSERT INTO purchase
	(PurchNo,PurchDate,SuppNo,PurchPayMethod,PurchDelDate)
	VALUES('P2345877','3-Feb-2020','S5095332','PO','11-Feb-2020');

INSERT INTO purchase
	(PurchNo,PurchDate,SuppNo,PurchPayMethod,PurchDelDate)
	VALUES('P3249952','4-Feb-2020','S3399214','PO','9-Feb-2020');

INSERT INTO purchase
	(PurchNo,PurchDate,SuppNo,PurchPayMethod,PurchDelDate)
	VALUES('P3854432','3-Feb-2020','S4290202','PO','8-Feb-2020');

INSERT INTO purchase
	(PurchNo,PurchDate,SuppNo,PurchPayMethod,PurchDelDate)
	VALUES('P9855443','7-Feb-2020','S4420948','PO','15-Feb-2020');


