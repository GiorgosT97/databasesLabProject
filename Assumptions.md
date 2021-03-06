# Here are listed all the assumptions made during database creation.

### <div style="background-color: Purple;color:black;"> General for all tables </div>
* Every attribute has to be specified for all tables. Exceptions are:
  * Supervisor for Administrator Tabke
  * All products in Order Table
* Suppliers are writen UPPERCASE.
---
### <div style="background-color: Purple;color:black;"> Graphics Card Table </div>
* The types of GPU memories are only the following: 
  * GDDR SDRAM
  * GDDR2
  * GDDR3
  * GDDR4
  * GDDR5
  * Other
---
### <div style="background-color: Purple;color:black;"> External HD Table </div>
* Whether the disk needs external supply is represented by an enum, containg values:
  * Yes
  * No
  * N/S
---
### <div style="background-color: Purple;color:black;"> Salary Table </div>
* Year and month of the salary are stored in a date type column. Days are set to 00 as MySQL manual suggests:
  * >[Ranges for the month and day specifiers begin with zero due to the fact that MySQL permits the storing of incomplete dates such as '2014-00-00'.](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format).
---
### <div style="background-color: Purple;color:black;"> Administrator Table </div>
* E-mail field must be unique. 
---
### <div style="background-color: Purple;color:black;"> Order Table </div>
* Products use together will have values 0 or 1 (False or True) __only__, in database. 
