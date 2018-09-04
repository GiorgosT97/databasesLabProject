/* ERWTIMA 1 */
DROP TRIGGER IF EXISTS Sum_cost;
DELIMITER $
CREATE TRIGGER Sum_Cost
BEFORE INSERT ON `Order`
FOR EACH ROW 
BEGIN
  DECLARE sum_c DECIMAL(10,2);
  DECLARE new_points SMALLINT;
  DECLARE can_be_used VARCHAR(30); 
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
  IF NEW.`Products Use Together`=1 THEN
    CALL check_use_together(NEW.Motherboard, NEW.`Case`, NEW.CPU, NEW.RAM, NEW.GPU, NEW.PSU, can_be_used);
  END IF;
  SET NEW.`Sum Cost`=sum_c;
END$
DELIMITER ;

/* ERWTIMA 2 */
DELIMITER $
CREATE PROCEDURE check_compability(IN M_model VARCHAR(30))
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE cpu_model VARCHAR(30);
  DECLARE cpu_socket VARCHAR(20);
  DECLARE curs CURSOR FOR SELECT Model, Socket FROM CPU;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN curs;
  read_loop: LOOP
    FETCH curs INTO cpu_model, cpu_socket;
    IF done THEN 
      LEAVE read_loop;
    END IF;
   
    IF cpu_socket=(SELECT Motherboard.Socket FROM Motherboard WHERE Motherboard.Model=M_model) THEN
      INSERT INTO ModelsCompability VALUES(M_model, cpu_model);
    END IF;
  END LOOP;
  CLOSE curs;
END $
DELIMITER ;

DELIMITER $
CREATE TRIGGER call_check_proc
AFTER INSERT ON Motherboard
FOR EACH ROW 
BEGIN
  CALL check_compability(NEW.Model);
END $
DELIMITER ;

/* ERWTIMA 3 */
DELIMITER $
CREATE PROCEDURE check_use_together(IN mother_model VARCHAR(30), IN case_model VARCHAR(30), IN cpu_model VARCHAR(30), IN ram_model VARCHAR(30), IN gpu_model VARCHAR(30), IN psu_model VARCHAR(30), OUT can_be_used VARCHAR(30))
BEGIN
  DECLARE can_use INT DEFAULT 0;
  IF FIND_IN_SET((SELECT Motherboard.Size FROM Motherboard WHERE Motherboard.Model=mother_model),(SELECT `Case`.`Motherboard Types` FROM `Case` WHERE `Case`.Model=case_model))>0 THEN
    SET can_use=can_use+1;
  END IF;
  IF (SELECT Motherboard.Socket FROM Motherboard WHERE Motherboard.Model=mother_model)=(SELECT CPU.Socket FROM CPU WHERE CPU.Model=cpu_model) THEN
    SET can_use=can_use+1;
  END IF;
  IF (SELECT Motherboard.`Ram Type` FROM Motherboard WHERE Motherboard.Model=mother_model)=(SELECT RAM.Type FROM RAM WHERE RAM.Model=ram_model) THEN
    SET can_use=can_use+1;
  END IF;
  IF GREATEST((SELECT CPU.`Supply Power` FROM CPU WHERE CPU.Model=cpu_model), (SELECT GPU.`Power` FROM GPU WHERE GPU.Model=gpu_model)) < (SELECT PSU.`Power` FROM PSU WHERE PSU.Model=psu_model) THEN
    SET can_use=can_use+1;
  END IF;
  IF can_use=4 THEN
    SET can_be_used="compatibility success";
  ELSE
    SET can_be_used="compatibility failure";
  END IF;
END $
DELIMITER ;