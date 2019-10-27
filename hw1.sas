/* Tianqi Luo */
/* HW01 Submission */

/* Remember to save this template file as HW1_YourNetID.sas */
/* You'll need to switch the following portion
             "~/my_courses/dunger_sas/hw01" access=readonly
   to 
             "C:\440\hw01";
   before making your final submission. */


libname hw01 "C:\440\hw01";


/*Exercise 1*/

/*Exercise 1(a)*/
title 'Exercise 1(a)';
proc contents data=sashelp.pricedata;
run;



/*Exercise 1(b)*/
title 'Exercise 1(b)';
data pricing_tluo4;
set sashelp.pricedata;
format date mmddyy10.;
format price cost DOLLAR9.2;
format discount percentn.;
label sale='Units Sold';
where sale>300 and price-cost<40;
keep date sale price discount cost productName;
run;


/*Exercise 1(c)*/
title 'Exercise 1(c)';
proc contents data=pricing_tluo4;
run;

/*Exercise 1(d)*/
title 'Exercise 1(d)';
proc print data=pricing_tluo4;
run;


/*Exercise 2*/

/*Exercise 2(a)*/
title 'Exercise 2(a)';
proc contents data=hw01.employee_roster;
run;


/*Exercise 2(b)*/
title 'Exercise 2(b)';
data top_earners_tluo4;
set hw01.employee_roster;
label Job_Title='Position' Salary='Yearly Salary';
where Salary >70000;
run;

/*Exercise 2(c)*/
title 'Exercise 2(c)';
proc print data=top_earners_tluo4;
var Employee_Name Job_Title Salary;
run;

/*Exercise 2(d)*/
title 'Exercise 2(d)';
proc print data=hw01.employee_roster;
var Employee_Name Employee_Gender Section Salary;
where Employee_Gender='M' and 25000<=Salary<=30000;
run;

/*Exercise 2(e)*/
title 'Exercise 2(e)';
proc print data=hw01.employee_roster;
var Employee_Name Employee_ID Org_Group;
where Employee_Name like 'C%' or Employee_Name like 'D%' or Employee_Name like 'E%';
run;






















