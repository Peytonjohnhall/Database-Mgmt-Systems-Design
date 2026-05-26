-- Executes for both Oracle and PostgreSQL

-- Drop table if exists
-- DROP TABLE Product;

CREATE TABLE Product
( 	ProdNo 	         CHAR(8),
  	ProdName	 VARCHAR(50) CONSTRAINT ProdNameRequired NOT NULL,
	ProdMfg	         VARCHAR(20) CONSTRAINT ProdMfgRequired NOT NULL,
	ProdQOH	         INTEGER,
	ProdPrice        DECIMAL(12,2),
        ProdNextShipDate DATE,
 CONSTRAINT PKProduct PRIMARY KEY (ProdNo)  );

-- INSERT statements to populate table

INSERT INTO product
	(ProdNo, ProdName, ProdMfg, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P0036566','17 inch Color Monitor','ColorMeg, Inc.',12,'20-Feb-2021',169.00);

INSERT INTO product
	(ProdNo, ProdName, ProdMfg, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P0036577','19 inch Color Monitor','ColorMeg, Inc.',10,'20-Feb-2021',319.00);

INSERT INTO product
	(ProdNo, ProdName, ProdMfg, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P1114590','R3000 Color Laser Printer','Connex',5,'22-Jan-2021',699.00);

INSERT INTO product
	(ProdNo, ProdName, ProdMfg, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P1412138','10 Foot Printer Cable','Ethlite',100,NULL,12.00);

INSERT INTO product
	(ProdNo, ProdName, ProdMfg, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P1445671','8-Outlet Surge Protector','Intersafe',33,NULL,14.99);

INSERT INTO product
	(ProdNo, ProdName, ProdMfg, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P1556678','CVP Ink Jet Color Printer','Connex',8, '22-Jan-2021',99.00);

INSERT INTO product
	(ProdNo, ProdName, ProdMfg, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P3455443','Color Ink Jet Cartridge','Connex',24,'22-Jan-2021',38.00);

INSERT INTO product
	(ProdNo, ProdName, ProdMfg, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P4200344','36-Bit Color Scanner','UV Components',16,'29-Jan-2021',199.99);

INSERT INTO product
	(ProdNo, ProdName, ProdMfg, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P6677900','Black Ink Jet Cartridge','Connex',44,NULL,25.69);

INSERT INTO product
	(ProdNo, ProdName, ProdMfg, ProdQOH, ProdNextShipDate, ProdPrice)
	VALUES ('P9995676','Battery Back-up System','Cybercx',12,'1-Feb-2021',89.00);

