DROP TRIGGER IF EXISTS Sum_cost;
DELIMITER $
CREATE TRIGGER Sum_Cost
BEFORE INSERT ON `Order`
FOR EACH ROW 
BEGIN
  DECLARE sum_c DECIMAL(10,2);
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
      SET sum_c = sum_c - (0.1 * sum_c);
      UPDATE `Customer Card`, Customer SET `Customer Card`.`Points Available`=(`Customer Card`.`Points Available`-100) WHERE (`Customer Card`.Customer_id=Customer.ID AND Customer.ID=NEW.Customer);
      UPDATE `Customer Card`, Customer SET `Customer Card`.`Points Used`=(`Customer Card`.`Points Used`+ 100) WHERE (`Customer Card`.Customer_id=Customer.ID AND Customer.ID=NEW.Customer);
      END;
  END IF;
  SET NEW.`Sum Cost`=sum_c;
END$
DELIMITER ;