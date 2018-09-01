SELECT Motherboard.Model, count(*) FROM Motherboard, CPU WHERE CPU.Socket=Motherboard.Socket GROUP BY Motherboard.Model ORDER BY count(*) ASC;
SELECT Administrator.Grade, AVG(Salary.Amount) FROM Administrator INNER JOIN Salary ON Salary.Administrator=Administrator.ID WHERE DATE_FORMAT(Salary.`Month and Year`, '%m')<=3 GROUP BY Administrator.Grade;
