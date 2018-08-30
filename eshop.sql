
DROP DATABASE IF EXISTS `ESHOP` ;
CREATE DATABASE `ESHOP` DEFAULT CHARACTER SET utf8 ;
USE `ESHOP` ;

CREATE TABLE IF NOT EXISTS `CPU` (
  `Model` VARCHAR(30)  NOT NULL,
  `Supplier` ENUM('AMD', 'Intel') NOT NULL,
  `Frequency` DECIMAL(2,2) NOT NULL,
  `Cores` INT(2) NOT NULL,
  `Threads` INT(2) NOT NULL,
  `Socket` VARCHAR(10) NOT NULL,
  `Level1 Cache` ENUM('32', '64', '72', '80', '96', '128', '256', '512') NOT NULL,
  `Supply Power` INT NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
  UNIQUE(`Model`),
  PRIMARY KEY (`Model`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Motherboard` (
  `Model` VARCHAR(30) NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Socket` VARCHAR(10) NOT NULL,
  `Max Ram Frequency` DECIMAL NOT NULL DEFAULT 1.5,
  `Ram Slots` TINYINT(1) NOT NULL,
  `Ram Type` ENUM('DDR3', 'DDR4', 'DDR3 SO-DIMM', 'DDR4 SO-DIMM') NOT NULL,
  `Size` ENUM('uATX/MicroATX', 'ATX', 'ExtendedATX', 'MiniITX', 'SSI', 'Other') NOT NULL,
  `Price` DECIMAL(2) NOT NULL,
  UNIQUE(`Model`),
  PRIMARY KEY (`Model`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `RAM` (
  `Model` VARCHAR(30) UNIQUE NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Type` ENUM('DDR3', 'DDR4', 'DDR3 SO-DIMM', 'DDR4 SO-DIMM') NOT NULL,
  `Frequency` DECIMAL NOT NULL,
  `Storage` DECIMAL NOT NULL,
  `Price` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`Model`)  
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `GPU` (
  `Model` VARCHAR(30) NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Cpu Type` ENUM('AMD', 'Nvidia') NOT NULL,
  `Physical Connections` INT(2) NOT NULL,
  `Type` SET('DVI-D', 'DVI-I', 'VGA', 'Mini HDMI', 'HDMI', 'DisplayPort', 'Mini DisplayPort') NOT NULL,
  `Memory` DECIMAL NOT NULL,
  `Memory Type` ENUM('GDDR SDRAM', 'GDDR2', 'GDDR3', 'GDDR4', 'GDDR5', 'Other') NOT NULL,
  `Base Clock` DECIMAL NOT NULL,
  `Memory Clock` DECIMAL NOT NULL ,
  `Power` MEDIUMINT NOT NULL,
  `Price` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`Model`),
  UNIQUE(`Model`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `PSU` (
  `Model` VARCHAR(30) NOT NULL,
  `Suppliier` VARCHAR(45) NOT NULL,
  `Power` MEDIUMINT NOT NULL DEFAULT 125 ,
  `Price` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`Model`),
  UNIQUE(`Model`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Case` (
  `Model` VARCHAR(30) NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Size` ENUM('Midi', 'Mini', 'Full Tower', 'Ultra Tower', 'Micro') NOT NULL,
  `Motherboard Types` SET('uATX/MicroATX', 'ATX', 'ExtendedATX', 'MiniITX', 'SSI', 'Other') NOT NULL,
  `Price` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`Model`),
  UNIQUE(`Model`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `SSD` (
  `Model` VARCHAR(30) NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Storage` DECIMAL NOT NULL,
  `Size` ENUM('2.5', '3.5', 'mSata', 'other') NOT NULL,
  `Price` DECIMAL(2) NOT NULL,
  `Connection Type` VARCHAR(45) NOT NULL,
  `Write Speed` DECIMAL NOT NULL,
  `Read Speed` DECIMAL NOT NULL,
  PRIMARY KEY (`Model`),
  UNIQUE(`Model`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `HDD` (
  `Model` VARCHAR(30) NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Storage` DECIMAL NOT NULL,
  `Size` ENUM('2.5', '3.5', 'mSata', 'other') NOT NULL,
  `Price` DECIMAL(2) NOT NULL,
  `Cache` DECIMAL NOT NULL,
  `Rpm` DECIMAL NOT NULL,
  PRIMARY KEY (`Model`),
  UNIQUE(`Model`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `External HD` (
  `Model` VARCHAR(30) NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Storage` DECIMAL NOT NULL,
  `Size` ENUM('2.5', '3.5', 'mSata', 'other') NOT NULL,
  `Price` DECIMAL(2) NOT NULL,
  `Connection Type` VARCHAR(45) NOT NULL,
  `External Power Supply` ENUM('Yes', 'No', 'N/S') NOT NULL,
  PRIMARY KEY (`Model`),
  UNIQUE (`Model`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Customer` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Surname` VARCHAR(45) NOT NULL,
  `E-mail` VARCHAR(45) NOT NULL,
  `Phone Number` MEDIUMINT NOT NULL,
  `Registration Date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(`ID`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Customer Card` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Customer_id` INT NOT NULL,
  `Points Available` MEDIUMINT NOT NULL DEFAULT 0,
  `Points Used` MEDIUMINT NOT NULL DEFAULT 0,
  UNIQUE(`ID`),
  CONSTRAINT `Card_to_Customer`
  FOREIGN KEY (ID) REFERENCES `Customer`(ID)
  ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Order` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Customer` INT NOT NULL,
  `CPU` VARCHAR(30) NULL,
  `Motherboard` VARCHAR(30) NULL,
  `RAM` VARCHAR(30) NULL,
  `GPU` VARCHAR(30) NULL,
  `PSU` VARCHAR(30) NULL,
  `Case` VARCHAR(30) NULL,
  `SSD` VARCHAR(30) NULL,
  `HDD` VARCHAR(30) NULL,
  `External HD` VARCHAR(30) NULL,
  `Products Use Together` TINYINT(1) NOT NULL,
  `Sum Cost` DECIMAL(6,3) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE(`ID`),
  CONSTRAINT `Order_to_Customer`
  FOREIGN KEY (`Customer`)  REFERENCES `Customer`(`ID`)
  ON DELETE CASCADE ON UPDATE CASCADE,
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Administrator` (
  `ID` INT(9) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45),
  `Surname` VARCHAR(45),
  `E-mail` VARCHAR(45),
  `CV` VARCHAR(100),
  `Grade` ENUM('Senior', 'Junior') NOT NULL,
  `Supervisor` INT(9) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE(`ID`),
  UNIQUE(`E-mail`),
  CONSTRAINT `Administrator_Supervisor`
  FOREIGN KEY (`Supervisor`) REFERENCES `Administrator`(`ID`)
  ON DELETE SET NULL ON UPDATE CASCADE
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Salary` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Month and Year` DATE NOT NULL,
  `Amount` DECIMAL(6,2) NOT NULL,
  `Administrator` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE(`ID`),
  CONSTRAINT `Salary_Administrator` 
  FOREIGN KEY (`Administrator`) REFERENCES `Administrator`(`ID`)
  ON DELETE CASCADE ON UPDATE CASCADE 
)ENGINE = InnoDB;

SET SQL_MODE='ALLOW_INVALID_DATES';


INSERT INTO Administrator VALUES(NULL, "Giorgos", "Tsoulos", "giorgos@eshop.gr", "Test CV 0", "Senior", NULL);  
INSERT INTO Administrator VALUES(NULL, "Dimitris", "Papandreou", "dimitris@eshop.gr", "Test CV 1", "Junior", 1);
INSERT INTO Administrator VALUES(NULL, "Kwstas", "Kwstopoulos", "kwstas@eshop.gr", "Test CV 2", "Junior", 1); 
INSERT INTO Administrator VALUES(NULL, "Marios", "Mariou", "marios@eshop.gr", "Test CV 3", "Senior", NULL); 
INSERT INTO Administrator VALUES(NULL, "Andreas", "Andreou", "andreas@eshop.gr", "Test CV 4", "Junior", 4);
INSERT INTO Administrator VALUES(NULL, "Mpampis", "Mpampou", "mpampis@eshop.gr", "Test CV 5", "Junior", 4);
INSERT INTO Administrator VALUES(NULL, "Tasos", "Tasou", "tasos@eshop.gr", "Test CV 6", "Senior", NULL);
INSERT INTO Administrator VALUES(NULL, "Alekos", "Alekou", "alekos@eshop.gr", "Test CV 7", "Senior", NULL);
INSERT INTO Administrator VALUES(NULL, "Giorgos", "Giorgou", "ggiorgos@eshop.gr", "Test CV 8", "Junior", 8);
INSERT INTO Administrator VALUES(NULL, "Alexandros", "Alexandrou", "alexandros@eshop.gr", "Test CV 9", "Junior", 8); 


INSERT INTO Salary VALUES(NULL, '1997-06-00', 1670.28, 1);
INSERT INTO Salary VALUES(NULL, '1997-09-00', 1470.48, 1);
INSERT INTO Salary VALUES(NULL, '1997-05-00', 660.35, 2);
INSERT INTO Salary VALUES(NULL, '1997-09-00', 670.28, 3);
INSERT INTO Salary VALUES(NULL, '1998-10-00', 1370.28, 4);
INSERT INTO Salary VALUES(NULL, '1998-03-00', 1470.28, 7);
INSERT INTO Salary VALUES(NULL, '1998-12-00', 670.28, 10);
INSERT INTO Salary VALUES(NULL, '1998-05-00', 690.28, 9);
INSERT INTO Salary VALUES(NULL, '1998-06-00', 590.28, 5);
INSERT INTO Salary VALUES(NULL, '1998-11-00', 710.28, 6);
INSERT INTO Salary VALUES(NULL, '1998-10-00', 1900.28, 4);
INSERT INTO Salary VALUES(NULL, '1998-09-00', 2010.28, 1);
INSERT INTO Salary VALUES(NULL, '1999-08-00', 700.28, 2);
INSERT INTO Salary VALUES(NULL, '1999-04-00', 670.28, 3);


INSERT INTO Customer VALUES(NULL, "Giorgos", "Tsoulos", "giorgos@eshop.gr", 694219546 , DEFAULT);  
INSERT INTO Customer VALUES(NULL, "Dimitris", "Papandreou", "dimitris@eshop.gr", 69545611, '2001-05-20 12:15:10');
INSERT INTO Customer VALUES(NULL, "Kwstas", "Kwstopoulos", "kwstas@eshop.gr", 69543812, '2001-10-02 11:15:12'); 
INSERT INTO Customer VALUES(NULL, "Marios", "Mariou", "marios@eshop.gr", 6911643, '2002-01-18 09:32:22'); 
INSERT INTO Customer VALUES(NULL, "Andreas", "Andreou", "andreas@eshop.gr", 69165464, '2002-03-03 07:05:11');
INSERT INTO Customer VALUES(NULL, "Mpampis", "Mpampou", "mpampis@eshop.gr", 69151565, '2001-08-13 07:40:27');
INSERT INTO Customer VALUES(NULL, "Tasos", "Tasou", "tasos@eshop.gr", 6911116, DEFAULT);
INSERT INTO Customer VALUES(NULL, "Alekos", "Alekou", "alekos@eshop.gr", 69254657, '2001-12-12 19:55:23');
INSERT INTO Customer VALUES(NULL, "Giorgos", "Giorgou", "ggiorgos@eshop.gr", 696548, '2002-03-10 17:35:14');
INSERT INTO Customer VALUES(NULL, "Alexandros", "Alexandrou", "alexandros@eshop.gr", 69465319, '2003-05-08 19:45:02'); 



INSERT INTO CPU VALUES("i7-8700K", "Intel", 3.7, 6, 12, "1151", "512", 95, 359.99);
INSERT INTO CPU VALUES("i5-8400", "Intel", 2.8, 6, 6, "1151", "512", 87, 180.00);
INSERT INTO CPU VALUES("Ryzen 5 2400G", "AMD", 3.2, 4, 8, "AM4", "256", 85, 145.00);
INSERT INTO CPU VALUES("Ryzen 7 2700X", "AMD", 3.7, 8, 16, "AM4", "512", 91, 314.00);
INSERT INTO CPU VALUES("i3-7100", "Intel", 3.9, 2, 4, "1151", "72", 72, 109.99);
INSERT INTO CPU VALUES("i3-8350K", "Intel", 4.0, 4, 4, "1151", "128", 75, 168.80);
INSERT INTO CPU VALUES("i7-7700K", "Intel", 4.2, 4, 8, "1151", "512", 91, 325.00);
INSERT INTO CPU VALUES("Ryzen 7 1700X", "AMD", 3.4, 8, 16, "AM4", "96", 84, 217.95);
INSERT INTO CPU VALUES("Ryzen 7 1800X", "AMD", 3.6, 8, 16, "AM4", "80", 81, 243.85);
INSERT INTO CPU VALUES("i5-7600K", "Intel", 3.8, 4, 4, "1151", "128", 87, 230.99);




