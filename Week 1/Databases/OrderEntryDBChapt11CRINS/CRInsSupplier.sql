CREATE TABLE Supplier
( 	SuppNo 		CHAR(8),
  	SuppName	VARCHAR(30) CONSTRAINT SuppNameRequired NOT NULL,
	SuppEMail	VARCHAR(50),
	SuppPhone	CHAR(14),
	SuppURL		VARCHAR(100), 
 	SuppDiscount	DECIMAL(3,3),
 CONSTRAINT PKSupplier PRIMARY KEY (SuppNo) );
 
 INSERT INTO supplier
	(SuppNo,SuppName,SuppEmail,SuppPhone,SuppURL,SuppDiscount)
	VALUES('S2029929','ColorMeg, Inc.','custrel@colormeg.com','(720)444-1231','www.colormeg.com',0.10);

 INSERT INTO supplier
	(SuppNo,SuppName,SuppEmail,SuppPhone,SuppURL,SuppDiscount)
	VALUES('S3399214','Connex','help@connex.com','(206)432-1142','www.connex.com',0.12);

 INSERT INTO supplier
	(SuppNo,SuppName,SuppEmail,SuppPhone,SuppURL,SuppDiscount)
	VALUES('S4290202','Ethlite','ordering@ethlite.com','(303)213-2234','www.ethlite.com',0.05);

 INSERT INTO supplier
	(SuppNo,SuppName,SuppEmail,SuppPhone,SuppURL,SuppDiscount)
	VALUES('S4298800','Intersafe','orderdesk@intersafe.com','(512)443-2215','www.intersafe.com',0.10);

 INSERT INTO supplier
	(SuppNo,SuppName,SuppEmail,SuppPhone,SuppURL,SuppDiscount)
	VALUES('S4420948','UV Components','custserv@uvcomponents.com','(303)321-0432','www.uvcomponents.com',0.08);

 INSERT INTO supplier
	(SuppNo,SuppName,SuppEmail,SuppPhone,SuppURL,SuppDiscount)
	VALUES('S5095332','Cybercx','orderhelp@cybercx.com','(212)324-5683','www.cybercx.com',0.00);

