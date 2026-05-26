CREATE TABLE PurchLine
( 	PurchNo 		CHAR(8),
  	ProdNo			CHAR(8),
	PurchQty		INTEGER DEFAULT 1 CONSTRAINT PurchQtyRequired NOT NULL,
 	PurchUnitCost		DECIMAL(12,2),
CONSTRAINT PKPurchLine PRIMARY KEY (PurchNo, ProdNo), 
CONSTRAINT FKPurchNo FOREIGN KEY (PurchNo) REFERENCES Purchase 
    ON DELETE CASCADE, 
CONSTRAINT FKProdNo2 FOREIGN KEY (ProdNo) REFERENCES Product );

INSERT INTO purchline
	(PurchNo, ProdNo, PurchQty, PurchUnitCost)
	VALUES('P2224040','P0036566',10,100.00);
	
INSERT INTO purchline
	(PurchNo, ProdNo, PurchQty, PurchUnitCost)
	VALUES('P2224040','P0036577',10,200.00);

INSERT INTO purchline
	(PurchNo, ProdNo, PurchQty, PurchUnitCost)
	VALUES('P2345877','P9995676',10,45.00);

INSERT INTO purchline
	(PurchNo, ProdNo, PurchQty, PurchUnitCost)
	VALUES('P3249952','P1114590',15,450.00);

INSERT INTO purchline
	(PurchNo, ProdNo, PurchQty, PurchUnitCost)
	VALUES('P3249952','P1556678',10,50.00);

INSERT INTO purchline
	(PurchNo, ProdNo, PurchQty, PurchUnitCost)
	VALUES('P3249952','P3455443',25,21.95);

INSERT INTO purchline
	(PurchNo, ProdNo, PurchQty, PurchUnitCost)
	VALUES('P3249952','P6677900',25,12.50);

INSERT INTO purchline
	(PurchNo, ProdNo, PurchQty, PurchUnitCost)
	VALUES('P3854432','P1412138',50,6.50);

INSERT INTO purchline
	(PurchNo, ProdNo, PurchQty, PurchUnitCost)
	VALUES('P9855443','P4200344',15,99.00);

