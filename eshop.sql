
DROP DATABASE IF EXISTS `ESHOP`
CREATE DATABASE `ESHOP` DEFAULT CHARACTER SET utf8 ;
USE `ESHOP` ;


CREATE TABLE IF NOT EXISTS `RAM` (
  `Model` VARCHAR(30) UNIQUE NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Type` ENUM('DDR3', 'DDR4', 'DDR3 SO-DIMM', 'DDR4 SO-DIMM') NOT NULL,
  `Frequency` DECIMAL NOT NULL DEFAULT 1.5,
  `Storage` DECIMAL NOT NULL DEFAULT 1.5,
  `Price` DECIMAL(2) NOT NULL,
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



CREATE TABLE IF NOT EXISTS `CPU` (
  `Model` VARCHAR(30)  NOT NULL,
  `Supplier` ENUM('AMD', 'Intel') NOT NULL,
  `Frequency` DECIMAL NOT NULL DEFAULT 1.5 ,
  `Cores` INT(2) NOT NULL,
  `Threads` INT(2) NOT NULL,
  `Socket` VARCHAR(10) NOT NULL,
  `Level1 Cache` ENUM('32', '64', '72', '80', '96', '128', '256', '512') NOT NULL,
  `Supply Power` INT NOT NULL,
  `Price` DECIMAL(2) NOT NULL,
  UNIQUE(`Model`),
  PRIMARY KEY (`Model`)
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

CREATE TABLE IF NOT EXISTS `GPU` (
  `Model` VARCHAR(30) NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Cpu Type` ENUM('AMD', 'Nvidia') NOT NULL,
  `Physical Connections` INT(5) NOT NULL,
  `Type` ENUM('DVI-D', 'DVI-I', 'VGA', 'Mini HDMI', 'HDMI', 'DisplayPort', 'Mini DisplayPort') NOT NULL,
  `Memory` DECIMAL NOT NULL DEFAULT 1.5 ,
  `Memory Type` ENUM('GDDR3', 'GDDR4') NOT NULL,
  `Base Clock` DECIMAL NOT NULL DEFAULT 1.5 ,
  `Memory Clock` DECIMAL NOT NULL DEFAULT 1.5 ,
  `Power` MEDIUMINT NOT NULL DEFAULT 125 ,
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


CREATE TABLE IF NOT EXISTS `Hard Drive` (
  `Model` VARCHAR(30) NOT NULL,
  `Supplier` VARCHAR(45) NOT NULL,
  `Storage` DECIMAL NOT NULL DEFAULT 1.5 ,
  `Size` ENUM('2.5', '3.5', 'mSata', 'other') NOT NULL,
  `Price` DECIMAL(2) NOT NULL,
  `TYPE` ENUM('SSD', 'HDD', 'EXTERNAL') NOT NULL,
  PRIMARY KEY (`Model`),
  UNIQUE(`Model`)
)ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `SSD` (
  `Model` VARCHAR(30) NOT NULL,
  `Connection Type` VARCHAR(45) NOT NULL,
  `Write Speed` DECIMAL NOT NULL ,
  `Read Speed` DECIMAL NOT NULL ,
  PRIMARY KEY (`Model`),
  UNIQUE(`Model`),
  CONSTRAINT `SSD_HArd_Drive`
  FOREIGN KEY (`Model`) REFERENCES `Hard Drive`(`Model`)
  ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `HDD` (
  `Model` VARCHAR(30) NOT NULL,
  `Cache` DECIMAL NULL ,
  `Rpm` DECIMAL NULL ,
  PRIMARY KEY (`Model`),
  UNIQUE(`Model`),
  CONSTRAINT `HDD_Hard_Drive`
  FOREIGN KEY (`Model`) REFERENCES `Hard Drive`(`Model`)
  ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `External HD` (
  `Model` VARCHAR(30) NOT NULL,
  `Connection Type` VARCHAR(45) NOT NULL,
  `External Power Supply` ENUM('Yes', 'No', 'N/S') NOT NULL,
  PRIMARY KEY (`Model`),
  UNIQUE (`Model`),
  CONSTRAINT `External_Hard_Drive`
  FOREIGN KEY (`Model`) REFERENCES `Hard Drive`(`Model`)
  ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `Customer` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Surname` VARCHAR(45) NOT NULL,
  `E-mail` VARCHAR(45) NOT NULL,
  `Phone Number` MEDIUMINT NOT NULL,
  `Registration Date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Customer Cards` SMALLINT NOT NULL,
  PRIMARY KEY(`ID`)
)ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `Customer Card` (
  `ID` INT NOT NULL,
  `Points Available` MEDIUMINT NOT NULL DEFAULT 0,
  `Points Used` MEDIUMINT NOT NULL DEFAULT 0,
  UNIQUE(`ID`)
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Order` (
  `Customer` INT NOT NULL,
  `ID` INT NOT NULL,
  `Products Use Together` TINYINT NOT NULL ,
  `Sum Cost` DECIMAL NOT NULL,
  UNIQUE(`Customer`),
  PRIMARY KEY (`ID`),
  UNIQUE(`ID`),
  CONSTRAINT `Order_Customer`
  FOREIGN KEY (`Customer`)  REFERENCES `Customer`(`ID`)
  ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Administrator` (
  `ID` INT NOT NULL,
  `Name` VARCHAR(45),
  `Surname` VARCHAR(45),
  `E-mail` VARCHAR(45),
  `CV` VARCHAR(60),
  `Grade` ENUM('Senior', 'Junior') NOT NULL,
  `Supervisor` INT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE(`ID`),
  CONSTRAINT `Administrator_Supervisor`
  FOREIGN KEY (`Supervisor`) REFERENCES `Administrator`(`ID`)
  ON DELETE SET NULL ON UPDATE CASCADE
)ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Salary` (
  `ID` INT NOT NULL,
  `Month` VARCHAR(45) NOT NULL,
  `Amount` DECIMAL(2) NOT NULL,
  `Administrator` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE(`ID`),
  UNIQUE(`Administrator`),
  CONSTRAINT `Salary_Administrator`
  FOREIGN KEY (`Administrator`) REFERENCES `Administrator`(`ID`)
  ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE = InnoDB;


INSERT INTO `Administrator` VALUES(3211, 'hre', 'hwe','hwehweh', 'hwehwe', 'Senior', NULL);

