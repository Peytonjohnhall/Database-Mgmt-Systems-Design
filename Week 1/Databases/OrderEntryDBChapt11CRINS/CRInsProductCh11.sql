CREATE TABLE Product
( 	ProdNo 	         CHAR(8),
  	ProdName         VARCHAR(50) CONSTRAINT ProdNameRequired NOT NULL,
	ProdQOH	         INTEGER,
	ProdPrice        DECIMAL(12,2),
        SuppNo 	         CHAR(8) CONSTRAINT SuppNo1Required NOT NULL,
        ProdNextShipDate DATE,
 CONSTRAINT PKProduct PRIMARY KEY (ProdNo),  
 CONSTRAINT SuppNoFK1 FOREIGN KEY (SuppNo) REFERENCES Supplier
    ON DELETE CASCADE );

INSERT INTO product
	(ProdNo, ProdName, SuppNo, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P0036566','17 inch Color Monitor','S2029929',12,'20-Feb-2020',169.00);

INSERT INTO product
	(ProdNo, ProdName, SuppNo,  ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P0036577','19 inch Color Monitor','S2029929',10,'20-Feb-2020',319.00);

INSERT INTO product
	(ProdNo, ProdName, SuppNo, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P1114590','R3000 Color Laser Printer','S3399214',5,'22-Jan-2020',699.00);

INSERT INTO product
	(ProdNo, ProdName, SuppNo, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P1412138','10 Foot Printer Cable','S4290202',100,NULL,12.00);

INSERT INTO product
	(ProdNo, ProdName, SuppNo, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P1445671','8-Outlet Surge Protector','S4298800',33,NULL,14.99);

INSERT INTO product
	(ProdNo, ProdName, SuppNo, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P1556678','CVP Ink Jet Color Printer','S3399214',8,'22-Jan-2020',99.00);

INSERT INTO product
	(ProdNo, ProdName, SuppNo, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P3455443','Color Ink Jet Cartridge','S3399214',24,'22-Jan-2020',38.00);

INSERT INTO product
	(ProdNo, ProdName, SuppNo,  ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P4200344','36-Bit Color Scanner','S4420948',16,'29-Jan-2020',199.99);

INSERT INTO product
	(ProdNo, ProdName, SuppNo, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P6677900','Black Ink Jet Cartridge','S3399214',44,NULL,25.69);

INSERT INTO product
	(ProdNo, ProdName, SuppNo, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P9995676','Battery Back-up System','S5095332',12,'1-Feb-2020',89.00);

