/* Tianqi Luo */
/* HW11 Submission */

/* Remember to save this template file as HW10_YourNetID.sas */
/* You'll need to switch the following portion
             "~/my_courses/dunger_sas/hw10" access=readonly
   to 
             "C:\440\hw11";
   before making your final submission. */
  

libname hw11 "C:\440\hw11";

/* Exercise 1 */

/* Exercise 1(a) */
title "Exercise 1(a)";
proc sql;
describe table
hw11.employee_roster;
quit;


/* Exercise 1(b) */
title "Exericise 1(b)";
/* Use proc sql to build the data */
proc sql;
create table top_earners_tluo4 as
select Employee_Name, Job_Title label = 'Position' , Salary format =  dollar8.0 label = 'Yearly Salary'
from hw11.employee_roster
having Salary >= 70000;
quit;

/* Exercise 1(c) */
title "Exercise 1(c)";
proc sql;
select Employee_Name, Job_Title, Salary
from top_earners_tluo4;
quit;


/* Exercise 1(d) */
title "Exercise 1(d)";
/* Use proc sql print the table */
proc sql;
select Employee_Name, Employee_Gender, Section, Salary format = dollar8.0
from hw11.employee_roster
having Employee_Gender = 'M' and Section = 'Administration' and 25000 <= Salary <= 30000;
quit;



/* Exercise 1(e) */
title "Exercise 1(e)";
/* Use proc sql to print the table */
proc sql;
select Employee_Name, Employee_ID, Org_Group
from hw11.employee_roster
having Employee_Name like 'C%' or Employee_Name like 'D%' or Employee_Name like 'E%';
quit;





/* Exercise 1(f) */
title "Exercise 1(f)";
/* Use proc sql to print the table */
proc sql;
select Employee_Gender, avg(Salary) format = dollar8.0 as Average_Salary label = "Average Salary", median(Salary) format = dollar8.0 as Median_Salary label = "Median Salary"
from hw11.employee_roster
group by Employee_Gender;
run;



/* Exercise 2 */

/* Exercise 2(a) */
title "Exericise 2(a)";
proc sql;
describe table
hw11.batting;
quit;


/* Exercise 2(b) */
title "Exercise 2(b)";
proc sql;
select PlayerID, YearID, TeamID, H
from hw11.batting
group by PlayerID, TeamID
having H >= 245;
quit;



/* Exercise 2(c) */
title "Exercise 2(c)";
/* Use proc sql to print the table */
proc sql;
select LgID, min(YearID) as First_Year label = 'First Year', max(YearID) as Last_Year label = 'Last Year'
from hw11.batting
group by LgID;
quit;



/* Exercise 2(d) */
title "Exercise 2(d)";
/* Use proc sql to print the table */
proc sql;
select PlayerID, YearID, HR
from hw11.batting
group by YearID
having HR = max(HR) and  HR >= 50;
quit;


































