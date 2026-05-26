CREATE TABLE OrdLine
( 	OrdNo 	CHAR(8),
  	ProdNo	CHAR(8),
	Qty	INTEGER DEFAULT 1,
CONSTRAINT PKOrdLine PRIMARY KEY (OrdNo, ProdNo), 
CONSTRAINT FKOrdNo FOREIGN KEY (OrdNo) REFERENCES OrderTbl
  ON DELETE CASCADE, 
CONSTRAINT FKProdNo FOREIGN KEY (ProdNo) REFERENCES Product  );

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O1116324','P1445671',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O1231231','P0036566',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O1231231','P1445671',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O1241518','P0036577',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O1455122','P4200344',1);


INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O1579999','P1556678',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O1579999','P6677900',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O1579999','P9995676',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O1615141','P0036566',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O1615141','P1445671',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O1615141','P4200344',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O1656777','P1445671',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O1656777','P1556678',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O2233457','P0036577',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O2233457','P1445671',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O2334661','P0036566',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O2334661','P1412138',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O2334661','P1556678',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O3252629','P4200344',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O3252629','P9995676',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O3331222','P1412138',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O3331222','P1556678',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O3331222','P3455443',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O3377543','P1445671',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O3377543','P9995676',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O4714645','P0036566',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O4714645','P9995676',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O5511365','P1412138',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O5511365','P1445671',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O5511365','P1556678',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O5511365','P3455443',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O5511365','P6677900',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O6565656','P0036566',10);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O7847172','P1556678',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O7847172','P6677900',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O7959898','P1412138',5);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O7959898','P1556678',5);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O7959898','P3455443',5);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O7959898','P6677900',5);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O7989497','P1114590',2);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O7989497','P1412138',2);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O7989497','P1445671',3);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O8979495','P1114590',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O8979495','P1412138',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O8979495','P1445671',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O9919699','P0036577',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O9919699','P1114590',1);

INSERT INTO ordline
	(OrdNo, ProdNo, Qty)
	VALUES('O9919699','P4200344',1);