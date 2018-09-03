DROP TRIGGER IF EXISTS Sum_cost;
DELIMITER $
CREATE TRIGGER Sum_Cost
BEFORE INSERT ON `Order`
FOR EACH ROW 
BEGIN
    
  SET NEW.`Sum Cost`= IFNULL((SELECT `Price` FROM CPU WHERE CPU.Model=NEW.CPU),0) +
  IFNULL((SELECT `Price` FROM Motherboard WHERE Motherboard.Model=NEW.Motherboard),0) +
  IFNULL((SELECT `Price` FROM PSU WHERE PSU.Model=NEW.PSU),0) + 
  IFNULL((SELECT `Price` FROM `Case` WHERE `Case`.Model=NEW.`Case`),0) + 
  IFNULL((SELECT `Price` FROM SSD WHERE SSD.Model=NEW.SSD),0) +
  IFNULL((SELECT `Price` FROM HDD WHERE HDD.Model=NEW.HDD),0) + 
  IFNULL((SELECT `Price` FROM `External HD` WHERE `External HD`.Model=NEW.`External HD`),0) + 
  IFNULL((SELECT `Price` FROM RAM WHERE RAM.Model=NEW.RAM),0) +
  IFNULL((SELECT `Price` FROM GPU WHERE GPU.Model=NEW.GPU),0);
    
END$
DELIMITER ;