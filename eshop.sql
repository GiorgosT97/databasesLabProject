
DROP DATABASE IF EXISTS `ESHOP` ;
CREATE DATABASE `ESHOP` DEFAULT CHARACTER SET utf8 ;
USE `ESHOP` ;

CREATE TABLE IF NOT EXISTS `CPU` (
  `Model` VARCHAR(30)  NOT NULL,
  `Supplier` ENUM('AMD', 'Intel') NOT NULL,
  `Frequency` DECIMAL(2,2) NOT NULL,
  `Cores` INT(2) NOT NULL,
  `Threads` INT(2) NOT NULL,
  `Socket` VARCHAR(20) NOT NULL,
  `Level1 Cache` ENUM('32', '64', '72', '80', '96', '128', '256', '512') NOT NULL,
  `Supply Power` INT NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
  UNIQUE(`Model`),
  PRIMARY KEY (`Model`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Motherboard` (
  `Model` VARCHAR(30) NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Socket` VARCHAR(20) NOT NULL,
  `Max Ram Frequency` SMALLINT NOT NULL,
  `Ram Slots` TINYINT(1) NOT NULL,
  `Ram Type` ENUM('DDR3', 'DDR4', 'DDR3 SO-DIMM', 'DDR4 SO-DIMM') NOT NULL,
  `Size` ENUM('uATX/MicroATX', 'ATX', 'ExtendedATX', 'MiniITX', 'SSI', 'Other') NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
  UNIQUE(`Model`),
  PRIMARY KEY (`Model`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `RAM` (
  `Model` VARCHAR(30) UNIQUE NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Type` ENUM('DDR3', 'DDR4', 'DDR3 SO-DIMM', 'DDR4 SO-DIMM') NOT NULL,
  `Frequency` SMALLINT NOT NULL,
  `Storage` SMALLINT NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`Model`)  
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `GPU` (
  `Model` VARCHAR(30) NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Cpu Type` ENUM('AMD', 'Nvidia') NOT NULL,
  `Physical Connections` SET('DVI-D', 'DVI-I', 'VGA', 'Mini HDMI', 'HDMI', 'DisplayPort', 'Mini DisplayPort') NOT NULL,
  `Memory` TINYINT NOT NULL,
  `Memory Type` ENUM('GDDR SDRAM', 'GDDR2', 'GDDR3', 'GDDR4', 'GDDR5', 'Other') NOT NULL,
  `Base Clock` SMALLINT NOT NULL,
  `Memory Clock` SMALLINT NOT NULL ,
  `Power` SMALLINT NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`Model`),
  UNIQUE(`Model`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `PSU` (
  `Model` VARCHAR(30) NOT NULL,
  `Suppliier` VARCHAR(45) NOT NULL,
  `Power` SMALLINT NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`Model`),
  UNIQUE(`Model`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Case` (
  `Model` VARCHAR(30) NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Size` ENUM('Midi', 'Mini', 'Full Tower', 'Ultra Tower', 'Micro') NOT NULL,
  `Motherboard Types` SET('uATX/MicroATX', 'ATX', 'ExtendedATX', 'MiniITX', 'SSI', 'Other') NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`Model`),
  UNIQUE(`Model`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `SSD` (
  `Model` VARCHAR(30) NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Storage` SMALLINT NOT NULL,
  `Size` ENUM('2.5', '3.5', 'mSata', 'M.2', 'other') NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
  `Connection Type` VARCHAR(45) NOT NULL,
  `Write Speed` SMALLINT NOT NULL,
  `Read Speed` SMALLINT NOT NULL,
  PRIMARY KEY (`Model`),
  UNIQUE(`Model`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `HDD` (
  `Model` VARCHAR(30) NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Storage` SMALLINT NOT NULL,
  `Size` ENUM('2.5', '3.5', 'mSata', 'other') NOT NULL,.
  `Connection Type` VARCHAR(45) NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
  `Cache` SMALLINT NOT NULL,
  `Rpm` SMALLINT NOT NULL,
  PRIMARY KEY (`Model`),
  UNIQUE(`Model`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `External HD` (
  `Model` VARCHAR(30) NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Storage` SMALLINT NOT NULL,
  `Size` ENUM('2.5', '3.5', 'mSata', 'other') NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
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
  FOREIGN KEY (Customer_id) REFERENCES `Customer`(ID)
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
  `Date` Date NOT NULL,
  `Products Use Together` TINYINT(1) NOT NULL,
  `Sum Cost` DECIMAL(10,2) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE(`ID`),
  CONSTRAINT `Order_to_Customer`
  FOREIGN KEY (`Customer`)  REFERENCES `Customer`(`ID`)
  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Order_to_CPU`
  FOREIGN KEY (`CPU`)  REFERENCES `CPU`(`Model`)
  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Order_to_Motherboard`
  FOREIGN KEY (`Motherboard`)  REFERENCES `Motherboard`(`Model`)
  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Order_to_RAM`
  FOREIGN KEY (`RAM`)  REFERENCES `RAM`(`Model`)
  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Order_to_GPU`
  FOREIGN KEY (`GPU`)  REFERENCES `GPU`(`Model`)
  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Order_to_PSU`
  FOREIGN KEY (`PSU`)  REFERENCES `PSU`(`Model`)
  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Order_to_Case`
  FOREIGN KEY (`Case`)  REFERENCES `Case`(`Model`)
  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Order_to_SSD`
  FOREIGN KEY (`SSD`)  REFERENCES `SSD`(`Model`)
  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Order_to_HDD`
  FOREIGN KEY (`HDD`)  REFERENCES `HDD`(`Model`)
  ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Order_to_External HD`
  FOREIGN KEY (`External HD`)  REFERENCES `External HD`(`Model`)
  ON DELETE CASCADE ON UPDATE CASCADE
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


CREATE TABLE IF NOT EXISTS `ModelsCompability`(
  `Motherboard` VARCHAR(30),
  `CPU` VARCHAR(30),
  PRIMARY KEY (Motherboard,CPU)
)ENGINE = InnoDB;


SET SQL_MODE='ALLOW_INVALID_DATES';

DROP TRIGGER IF EXISTS Sum_cost;
DELIMITER $
CREATE TRIGGER Sum_Cost
BEFORE INSERT ON `Order`
FOR EACH ROW 
BEGIN
  DECLARE sum_c DECIMAL(10,2);
  DECLARE new_points SMALLINT; 
  SET sum_c = IFNULL((SELECT `Price` FROM CPU WHERE CPU.Model=NEW.CPU),0) +
  IFNULL((SELECT `Price` FROM Motherboard WHERE Motherboard.Model=NEW.Motherboard),0) +
  IFNULL((SELECT `Price` FROM PSU WHERE PSU.Model=NEW.PSU),0) + 
  IFNULL((SELECT `Price` FROM `Case` WHERE `Case`.Model=NEW.`Case`),0) + 
  IFNULL((SELECT `Price` FROM SSD WHERE SSD.Model=NEW.SSD),0) +
  IFNULL((SELECT `Price` FROM HDD WHERE HDD.Model=NEW.HDD),0) + 
  IFNULL((SELECT `Price` FROM `External HD` WHERE `External HD`.Model=NEW.`External HD`),0) + 
  IFNULL((SELECT `Price` FROM RAM WHERE RAM.Model=NEW.RAM),0) +
  IFNULL((SELECT `Price` FROM GPU WHERE GPU.Model=NEW.GPU),0);
  IF (100< ANY(SELECT `Points Available` FROM `Customer Card`, Customer WHERE `Customer Card`.Customer_id=Customer.ID AND Customer.ID=NEW.Customer) )
    THEN
      BEGIN 
      SET new_points = FLOOR(sum_c * 0.1);
      SET sum_c = sum_c - (0.1 * sum_c);
      UPDATE `Customer Card`, Customer SET `Customer Card`.`Points Available`=(`Customer Card`.`Points Available`-100 + new_points) WHERE (`Customer Card`.Customer_id=Customer.ID AND Customer.ID=NEW.Customer);
      UPDATE `Customer Card`, Customer SET `Customer Card`.`Points Used`=(`Customer Card`.`Points Used`+ 100) WHERE (`Customer Card`.Customer_id=Customer.ID AND Customer.ID=NEW.Customer);
      END;
  END IF;
  SET NEW.`Sum Cost`=sum_c;
END$
DELIMITER ;

DELIMITER $
CREATE PROCEDURE check_compability(IN M_model VARCHAR(30))
BEGIN
  INSERT INTO ModelsCompability 
  VALUES(M_model, 
  (SELECT CPU.Model FROM CPU INNER JOIN Motherboard ON Motherboard.Socket=CPU.Socket
  WHERE Motherboard.Model=M_model LIMIT 1));
  END $
DELIMITER ;


CREATE TRIGGER call_check_proc
BEFORE INSERT ON Motherboard
FOR EACH ROW 
CALL check_compability(NEW.Model);


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


INSERT INTO Motherboard VALUES("Rog Strix B350-F", "AASUS", "AM4", 3200, 4, "DDR4", "ATX", 118.19);
INSERT INTO Motherboard VALUES("B250M-DS3H", "GIGABYTE", "1151", 2400, 4, "DDR4", "uATX/MicroATX", 65.52);
INSERT INTO Motherboard VALUES("PRIME Z370-A", "ASUS", "1151", 4000, 4, "DDR4", "ATX", 170.24);
INSERT INTO Motherboard VALUES("Z370P D3", "GIGABYTE", "1151", 4000, 4, "DDR4", "ATX", 96.37);
INSERT INTO Motherboard VALUES("X370 Gaming Pro Carbon", "MSI", "AM4", 3200, 4, "DDR4", "ATX", 113.94);
INSERT INTO Motherboard VALUES("Z370-A Pro", "MSI", "1151", 4000, 4, "DDR4", "ATX", 98.84);
INSERT INTO Motherboard VALUES("Z370 Sli Plus", "MSI", "1151", 4000, 4, "DDR4", "ATX", 143.96);
INSERT INTO Motherboard VALUES("PRIME B350 Plus", "ASUS", "AM4", 3200, 4, "DDR4", "ATX", 95.74);
INSERT INTO Motherboard VALUES("B250-HD3P", "GIGABYTE", "1151", 2400, 4, "DDR4", "ATX", 73.22);
INSERT INTO Motherboard VALUES("B250M Pro-VD", "MSI", "1151", 2400, 2, "DDR4", "uATX/MicroATX", 48.50);


INSERT INTO RAM VALUES("RipjawsV", "G.SKILL", "DDR4", 3200, 16, 151.47);
INSERT INTO RAM VALUES("TridentZ", "G.SKILL", "DDR4", 3200, 16, 177.82);
INSERT INTO RAM VALUES("Aegis", "G.SKILL", "DDR4", 3000, 8, 70.26);
INSERT INTO RAM VALUES("Vegeance LPX", "Corsair", "DDR4", 3000, 8, 72.64);
INSERT INTO RAM VALUES("Fury", "HYPERX", "DDR4", 2400, 4, 41.47);
INSERT INTO RAM VALUES("ValueRAM", "KINGSTON", "DDR3", 1600, 4, 30.04);
INSERT INTO RAM VALUES("Fury Blue", "HYPERX", "DDR3", 1600, 4, 34.86);
INSERT INTO RAM VALUES("Fury Black", "HYPERX", "DDR3", 1600, 4, 31.81);
INSERT INTO RAM VALUES("Ballistix Sport LT", "CRUCIAL", "DDR4", 2400, 8, 79.03);
INSERT INTO RAM VALUES("Value Select", "Corsair", "DDR4", 2666, 4, 41.91);


INSERT INTO PSU VALUES("Smart RGB 700", "THERMALTAKE", 700, 52.78);
INSERT INTO PSU VALUES("CX Series CX550M", "CORSAIR", 550, 64.30);
INSERT INTO PSU VALUES("CX Series CX650M", "CORSAIR", 650, 74.88);
INSERT INTO PSU VALUES("VS Series VS450", "CORSAIR", 450, 35.84);
INSERT INTO PSU VALUES("CX Series CX550", "CORSAIR", 650, 51.98);
INSERT INTO PSU VALUES("CX Series CX450", "CORSAIR", 450, 48.83);
INSERT INTO PSU VALUES("RMi Series RM750i", "CORSAIR", 750, 132.98);
INSERT INTO PSU VALUES("TX-M Series TX650M", "CORSAIR", 650, 89.98);
INSERT INTO PSU VALUES("Smart RGB 600", "THERMALTAKE", 600, 47.38);
INSERT INTO PSU VALUES("FOCUS PLUS 750", "SEASONIC", 750, 123.69);


INSERT INTO GPU VALUES("GeForce GTX1060", "MSI", "Nvidia", "DVI-D,DisplayPort,HDMI", 6, "GDDR5", 1569, 8000, 400, 315.70);
INSERT INTO GPU VALUES("GeForce GTX1050", "GIGABYTE", "Nvidia", "DVI-D,DisplayPort,HDMI", 4, "GDDR5", 1354, 7008, 300, 188.81);
INSERT INTO GPU VALUES("GeForce GTX1050 Ti", "MSI", "Nvidia", "DVI-D,DisplayPort,HDMI", 4, "GDDR5", 1290, 7008, 300, 188.48);
INSERT INTO GPU VALUES("GeForce GTX1070 Ti", "GIGABYTE", "Nvidia", "DVI-D,DisplayPort,HDMI", 8, "GDDR5", 1721, 8008, 500, 459.20);
INSERT INTO GPU VALUES("GeForce GT 1030", "ASUS", "Nvidia", "DVI-D,HDMI", 2, "GDDR5", 1252, 6008, 200, 82.02);
INSERT INTO GPU VALUES("Radeon RX 580", "GIGABYTE", "AMD", "DVI-D,DisplayPort,HDMI", 8, "GDDR5", 1340, 8000, 500, 303.26);
INSERT INTO GPU VALUES("Radeon RX 570", "SAPPHIRE", "AMD", "DVI-D,DisplayPort,HDMI", 8, "GDDR5", 1340, 7000, 500, 292.20);
INSERT INTO GPU VALUES("GeForce GT710", "PNY", "Nvidia", "DVI-D,BGA,HDMI", 1, "GDDR3", 954, 1600, 50, 41.85);
INSERT INTO GPU VALUES("Radeon R7 240", "GIGABYTE", "AMD", "DVI-D,VGA,HDMI", 4, "GDDR3", 770, 1800, 50, 92.00);
INSERT INTO GPU VALUES("GeForce GT730", "GAINWARD", "Nvidia", "DVI-D,HDMI", 2, "GDDR3", 902, 800, 300, 54.90);


INSERT INTO `Case` VALUES("Source S340", "NZXT", "Midi", "ATX,MiniITX,uATX/MicroATX", 70.93);
INSERT INTO `Case` VALUES("MX330-X", "COUGAR", "Midi", "ATX,MiniITX,uATX/MicroATX", 28.03);
INSERT INTO `Case` VALUES("Masterbox Lite 3.1", "COOLERMASTER", "Midi", "MiniITX,uATX/MicroATX", 39.00);
INSERT INTO `Case` VALUES("Source S350", "NZXT", "Midi", "ATX,MiniITX,uATX/MicroATX", 75.22);
INSERT INTO `Case` VALUES("Cosmos C700P", "COOLERMASTER", "Full Tower", "MiniITX,uATX/MicroATX,ATX,ExtendedATX", 309.48);
INSERT INTO `Case` VALUES("Panzer Max", "COUGAR", "Full Tower", "MiniITX,uATX/MicroATX,ATX,ExtendedATX,Other", 200.52);
INSERT INTO `Case` VALUES("Core V21", "Thermaltake", "Micro", "MiniITX,uATX/MicroATX", 57.15);
INSERT INTO `Case` VALUES("Enthoo Evolv", "Phanteks", "Micro", "MiniITX,uATX/MicroATX", 128.64);
INSERT INTO `Case` VALUES("Manta Matte", "NZXT", "Mini", "MiniITX", 87.75);
INSERT INTO `Case` VALUES("Cosmos II", "COOLERMASTER", "Ultra Tower", "uATX/MicroATX,ATX,ExtendedATX", 338.97);


INSERT INTO SSD VALUES("860 Evo 250", "SAMSUNG", 250, '2.5', 62.55, "SATA III", 520, 550);
INSERT INTO SSD VALUES("860 Evo 500", "SAMSUNG", 500, '2.5', 99.92, "SATA III", 520, 550);
INSERT INTO SSD VALUES("A400 120", "KINGSTON", 120, '2.5', 23.50, "SATA III", 320, 500);
INSERT INTO SSD VALUES("960 Evo NVME 500", "SAMSUNG", 500, 'M.2', 161.12, "PCI Express", 1800, 3200);
INSERT INTO SSD VALUES("970 Evo NVME 250", "SAMSUNG", 250, 'M.2', 87.91, "PCI Express", 1500, 3400);
INSERT INTO SSD VALUES("MX500", "CRUSIAL", 250, '2.5', 54.89, "SATA III", 510, 560);
INSERT INTO SSD VALUES("SSD PLUS 240", "SANDISK", 240, '2.5', 42.66, "SATA III", 440, 530);
INSERT INTO SSD VALUES("860 Evo 1", "SAMSUNG", 1, '2.5', 197.36, "SATA III", 520, 550);
INSERT INTO SSD VALUES("TR200", "TOSHIBA", 240, '2.5', 44.99, "SATA III", 540, 555);
INSERT INTO SSD VALUES("High Performance 120", "INTENSO", 120, '2.5', 24.01, "SATA III", 500, 520);


INSERT INTO HDD VALUES("Blue 1", "WESTERN DIGITAL", 1, "3.5", "SATA III", 38.58, 64, 7200);
INSERT INTO HDD VALUES("Barracuda 2", "SEAGATE", 2, "3.5", "SATA III", 58.22, 64, 7200);
INSERT INTO HDD VALUES("Purple HDD 1", "WESTERN DIGITAL", 1, "3.5", "SATA III", 38.58, 64, 5400);
INSERT INTO HDD VALUES("Barracuda 1", "SEAGATE", 1, "3.5", "SATA III", 38.02, 64, 7200);
INSERT INTO HDD VALUES("DT01ACA100", "TOSHIBA", 1, "3.5", "SATA III", 35.38, 32, 7200);
INSERT INTO HDD VALUES("Red NAS 4", "WESTERN DIGITAL", 4, "3.5", "SATA III", 113.43, 64, 5400);
INSERT INTO HDD VALUES("Blue 3", "WESTERN DIGITAL", 3, "3.5", "SATA III", 82.70, 64, 5700);
INSERT INTO HDD VALUES("Blue 4", "WESTERN DIGITAL", 4, "3.5", "SATA III", 96.21, 64, 5400);
INSERT INTO HDD VALUES("Black 1", "WESTERN DIGITAL", 1, "3.5", "SATA III", 71.69, 64, 7200);
INSERT INTO HDD VALUES("Red NAS 3", "WESTERN DIGITAL", 3, "3.5", "SATA III", 113.43, 64, 5400);


INSERT INTO `External HD` VALUES("My Passport 4", "WESTERN DIGITAL", 4, "2.5", 119.60, "USB 3.0", "No");
INSERT INTO `External HD` VALUES("M3 Portable 2", "Maxtor", 2, "2.5", 62.99, "USB 3.0", "No");
INSERT INTO `External HD` VALUES("M3 Portable 1", "Maxtor", 1, "2.5", 44.26, "USB 3.0", "No");
INSERT INTO `External HD` VALUES("My Passport 1", "WESTERN DIGITAL", 1, "2.5", 52.90, "USB 3.0", "No");
INSERT INTO `External HD` VALUES("Canvio Basics 1", "TOSHIBA", 1, "2.5", 44.60, "USB 3.0", "No");
INSERT INTO `External HD` VALUES("Expansion Portable", "SEAGATE", 1, "2.5", 46.51, "USB 3.0", "No");
INSERT INTO `External HD` VALUES("Backup Plus Hub 6", "SEAGATE", 6, "3.5", 133.88, "USB 3.0", "No");
INSERT INTO `External HD` VALUES("Backup Plus Hub 8", "SEAGATE", 8, "3.5", 178.10, "USB 3.0", "No");
INSERT INTO `External HD` VALUES("Elements Portable 3", "WESTERN DIGITAL", 3, "2.5", 102.76, "USB 3.0", "No");
INSERT INTO `External HD` VALUES("M3 Portable 4", "Maxtor", 4, "2.5", 62.99, "USB 3.0", "No");
INSERT INTO `External HD` VALUES("Expansion Desktop 3", "SEAGATE", 3, "3.5", 81.09, "USB 3.0", "No");


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
INSERT INTO Salary VALUES(NULL, '1997-01-00', 660.35, 2);
INSERT INTO Salary VALUES(NULL, '1997-09-00', 670.28, 3);
INSERT INTO Salary VALUES(NULL, '1998-10-00', 1370.28, 4);
INSERT INTO Salary VALUES(NULL, '1998-03-00', 1470.28, 7);
INSERT INTO Salary VALUES(NULL, '1998-12-00', 670.28, 10);
INSERT INTO Salary VALUES(NULL, '1998-05-00', 690.28, 9);
INSERT INTO Salary VALUES(NULL, '1998-02-00', 540.28, 9);
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


INSERT INTO `Customer Card` VALUES(NULL, 1, 150, 100);
INSERT INTO `Customer Card` VALUES(NULL, 1, 160, 200);
INSERT INTO `Customer Card` VALUES(NULL, 2, 285, 900);
INSERT INTO `Customer Card` VALUES(NULL, 3, 196, 200);
INSERT INTO `Customer Card` VALUES(NULL, 4, 15, 500);
INSERT INTO `Customer Card` VALUES(NULL, 5, 175, 400);
INSERT INTO `Customer Card` VALUES(NULL, 6, 125, 300);
INSERT INTO `Customer Card` VALUES(NULL, 6, 145, 300);
INSERT INTO `Customer Card` VALUES(NULL, 7, 197, 200);
INSERT INTO `Customer Card` VALUES(NULL, 8, 253, 400);
INSERT INTO `Customer Card` VALUES(NULL, 9, 180, 700);
INSERT INTO `Customer Card` VALUES(NULL, 10, 19, 900);
INSERT INTO `Customer Card` VALUES(NULL, 10, 13, 200);

                                                                                                                
INSERT INTO `Order` VALUES(NULL, 1, "i7-8700K", "B250M-DS3H", "RipjawsV", "GeForce GTX1060",  "CX Series CX550", "Cosmos C700P", NULL, NULL, "M3 Portable 1", '1997-06-25', 1, 0);
INSERT INTO `Order` VALUES(NULL, 10, "i3-8350K", "Z370P D3", NULL, NULL,  "RMi Series RM750i", NULL,"860 Evo 500",  "Blue 1", NULL, '1996-12-13', 1, NULL);
INSERT INTO `Order` VALUES(NULL, 2, NULL, NULL, "Aegis", NULL,  "RMi Series RM750i", "Source S340", "MX500", NULL, NULL, '1997-02-05', 0, NULL);
INSERT INTO `Order` VALUES(NULL, 3, "i5-8400", NULL, "Ballistix Sport LT", NULL, "Smart RGB 700", "Cosmos C700P", NULL, "Barracuda 1", NULL, '1997-01-03', 1, NULL);
INSERT INTO `Order` VALUES(NULL, 3, NULL, NULL, NULL, "Radeon RX 570", NULL, "Enthoo Evolv","860 Evo 1", "DT01ACA100", "Backup Plus Hub 6", '1997-04-11',0, NULL);
INSERT INTO `Order` VALUES(NULL, 5, NULL, "PRIME B350 Plus", "TridentZ", NULL,  "CX Series CX650M", NULL, "A400 120", NULL, NULL, '1997-05-18', 0, NULL);
INSERT INTO `Order` VALUES(NULL, 6, "Ryzen 5 2400G", "X370 Gaming Pro Carbon", NULL, "Radeon RX 580",  "CX Series CX550", "Cosmos II", "High Performance 120", "Blue 3", NULL, '1992-04-07', 1, NULL);
INSERT INTO `Order` VALUES(NULL, 7, "Ryzen 7 2700X", NULL, NULL, NULL,  "Smart RGB 700", "MX330-X", NULL, NULL, "Elements Portable 3", '1997-05-23', 0, NULL);
INSERT INTO `Order` VALUES(NULL, 8, NULL, "B250M Pro-VD", "Vegeance LPX", NULL,  "CX Series CX550", NULL, "960 Evo NVME 500", "Black 1",  "Expansion Desktop 3", '1997-04-18', 0, NULL);
INSERT INTO `Order` VALUES(NULL, 8, NULL, "Z370-A Pro", "Fury Black", "Radeon R7 240",  "TX-M Series TX650M", NULL, NULL, "DT01ACA100", "Expansion Desktop 3", '1997-09-22', 0, NULL);
