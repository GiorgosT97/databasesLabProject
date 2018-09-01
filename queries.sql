SELECT Motherboard.Model, count(*) FROM Motherboard, CPU WHERE CPU.Socket=Motherboard.Socket GROUP BY Motherboard.Model ORDER BY count(*) ASC;

SELECT Administrator.Grade, AVG(Salary.Amount) FROM Administrator INNER JOIN Salary ON Salary.Administrator=Administrator.ID WHERE DATE_FORMAT(Salary.`Month and Year`, '%m')<=3 GROUP BY Administrator.Grade;

(SELECT Model, Storage, Price FROM SSD INNER JOIN `Order` ON `Order`.SSD=SSD.Model WHERE (`Order`.Date between '1997-04-00' AND '1997-06-00'))
UNION 
(SELECT Model, Storage, Price FROM HDD INNER JOIN `Order` ON `Order`.HDD=HDD.Model WHERE (`Order`.Date between '1997-04-00' AND '1997-06-00'))
UNION
(SELECT Model, Storage, Price FROM `External HD` INNER JOIN `Order` ON `Order`.`External HD`=`External HD`.Model WHERE (`Order`.Date between '1997-04-00' AND '1997-06-00'));

SELECT CONCAT(PSU.Model, " with ", PSU.Power , " Watts") FROM PSU INNER JOIN `Order` ON `Order`.PSU=PSU.Model WHERE PSU.Model NOT LIKE '%Plus%' GROUP BY `Order`.PSU DESC LIMIT 3; 