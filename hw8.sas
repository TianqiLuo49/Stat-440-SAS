/* Tianqi Luo */
/* HW08 Submission */
/* Remember to save this template file as HW8_YourNetID.sas */
/* You'll need to switch the following portion
"~/my_courses/dunger_sas/hw07" access=readonly
to
"C:\440\hw8";
before making your final submission. */
libname hw08 "C:\440\hw8";

/* Exercise 1 */
/* Exercise 1(a) */
title "Exercise 1(a)";
/* Output the initial data by the parameters */
data discount_ret_ini discount_cat_ini discount_int_ini;
	set hw08.orders;
	TotSales=Total_Retail_Price * Quantity;
	format TotSales dollar8.2;

	if Order_Type=1 and TotSales >=400 then
		output discount_ret_ini;

	if Order_Type=2 and TotSales >=70 then
		output discount_cat_ini;

	if Order_Type=3 and TotSales >=400 then
		output discount_int_ini;
run;

/* Keep the desired variables and add labels */
data discount_ret;
	set discount_ret_ini;
	keep Customer_ID Customer_Name TotSales;
	label Customer_ID="Customer ID" Customer_Name="Customer Name" 
		TotSales="Total Sales";
run;

data discount_cat;
	set discount_cat_ini;
	keep Customer_ID Customer_Name Customer_Gender TotSales;
	label Customer_ID="Customer ID" Customer_Name="Customer Name" 
		Customer_Gender="Customer Gender" TotSales="Total Sales";
run;

data discount_int;
	set discount_int_ini;
	keep Customer_ID Customer_Name Customer_BirthDate TotSales;
	format Customer_BirthDate mmddyy10.;
	label Customer_ID="Customer ID" Customer_Name="Customer Name" 
		Customer_Birthdate="Customer Birth Date" TotSales="Total Sales";
run;

/* Exercise 1(b) */
title "Exercise 1(b) : discount_ret table ";
proc print data=discount_ret label;
run;
title "Exercise 1(b) : discount_cat table ";
proc print data=discount_cat label;
run;
title "Exercise 1(b) : discount_int table ";
proc print data=discount_int label;
run;

/* Exercise 1(c) */
title "Exercise 1(c)";

data discount_ret_ini discount_cat_ini discount_int_ini top_buyers_tluo4_ini;
	set hw08.orders;
	TotSales=Total_Retail_Price * Quantity;
	format TotSales dollar8.2;

	if Order_Type=1 and TotSales >=400 then
		output discount_ret_ini;

	if Order_Type=2 and TotSales >=70 then
		output discount_cat_ini;

	if Order_Type=3 and TotSales >=400 then
		output discount_int_ini;

	if Totsales > 500 then
		output top_buyers_tluo4_ini;
run;

data discount_ret;
	set discount_ret_ini;
	keep Customer_ID Customer_Name TotSales;
	label Customer_ID="Customer ID" Customer_Name="Customer Name" 
		TotSales="Total Sales";
run;

data discount_cat;
	set discount_cat_ini;
	keep Customer_ID Customer_Name Customer_Gender TotSales;
	label Customer_ID="Customer ID" Customer_Name="Customer Name" 
		Customer_Gender="Customer Gender" TotSales="Total Sales";
run;

data discount_int;
	set discount_int_ini;
	keep Customer_ID Customer_Name Customer_BirthDate TotSales;
	format Customer_BirthDate mmddyy10.;
	label Customer_ID="Customer ID" Customer_Name="Customer Name" 
		Customer_Birthdate="Customer Birth Date" TotSales="Total Sales";
run;

data top_buyers_tluo4;
	set top_buyers_tluo4_ini;
	keep Customer_ID Customer_Name TotSales;
	label Customer_ID="Customer ID" Customer_Name="Customer Name" 
		TotSales="Total Sales";
run;

/* Exercise 1(d) */
title "Execise 1(d): top_buyers_tluo4 table";

proc print data=top_buyers_tluo4 label;
run;

title "Execise 1(d) : discount_int table";
proc print data=discount_int label;
run;

/* Exercise 2 */

/* Exercise 2(a) */
/* Set the dlm to be '09'x since the data is tab-delimited */

data trade_tluo4;
infile "C:\440\hw8\importexport87-15.dat" dlm='09'x;
input Date: $9. Exports Imports @@;   /* Use @@ to open the line until it reads through all the data */
Balance = Exports - Imports;    /* Set the variable Balance equal to Exports - Imports */
format Exports Imports Balance dollar10.1;     /* Set the format to be dollar10.1 */
run;

/* Exercise 2(b) */
title "Exercise 2(b)";
proc print data = trade_tluo4  (obs = 24) noobs;
run;

/* Exercise 2(c) */
data data_by_year;
infile "C:\440\hw8\importexport87-15.dat" dlm='09'x;
input Date mmddyy12. Exports Imports @@; /* Input date as the numeric string mmddyy12.*/
Balance = Exports - Imports;
format Exports Imports Balance dollar10.;
format Date mmddyy10.;
/* Set the Year variable based on the comparison of the Date variable */
if '01JAN1987'd <= Date <= '31DEC1987'D then Year=1987;
else if '01JAN1988'd <= Date <= '31DEC1988'D then Year=1988;
else if '01JAN1989'd <= Date <= '31DEC1989'D then Year=1989;
else if '01JAN1990'd <= Date <= '31DEC1990'D then Year=1990;
else if '01JAN1991'd <= Date <= '31DEC1991'D then Year=1991;
else if '01JAN1992'd <= Date <= '31DEC1992'D then Year=1992;
else if '01JAN1993'd <= Date <= '31DEC1993'D then Year=1993;
else if '01JAN1994'd <= Date <= '31DEC1994'D then Year=1994;
else if '01JAN1995'd <= Date <= '31DEC1995'D then Year=1995;
else if '01JAN1996'd <= Date <= '31DEC1996'D then Year=1996;
else if '01JAN1997'd <= Date <= '31DEC1997'D then Year=1997;
else if '01JAN1998'd <= Date <= '31DEC1998'D then Year=1998;
else if '01JAN1999'd <= Date <= '31DEC1999'D then Year=1999;
else if '01JAN2000'd <= Date <= '31DEC2000'D then Year=2000;
else if '01JAN2001'd <= Date <= '31DEC2001'D then Year=2001;
else if '01JAN2002'd <= Date <= '31DEC2002'D then Year=2002;
else if '01JAN2003'd <= Date <= '31DEC2003'D then Year=2003;
else if '01JAN2004'd <= Date <= '31DEC2004'D then Year=2004;
else if '01JAN2005'd <= Date <= '31DEC2005'D then Year=2005;
else if '01JAN2006'd <= Date <= '31DEC2006'D then Year=2006;
else if '01JAN2007'd <= Date <= '31DEC2007'D then Year=2007;
else if '01JAN2008'd <= Date <= '31DEC2008'D then Year=2008;
else if '01JAN2009'd <= Date <= '31DEC2009'D then Year=2009;
else if '01JAN2010'd <= Date <= '31DEC2010'D then Year=2010;
else if '01JAN2011'd <= Date <= '31DEC2011'D then Year=2011;
else if '01JAN2012'd <= Date <= '31DEC2012'D then Year=2012;
else if '01JAN2013'd <= Date <= '31DEC2013'D then Year=2013;
else if '01JAN2014'd <= Date <= '31DEC2014'D then Year=2014;
else if '01JAN2015'd <= Date <= '31DEC2015'D then Year=2015;

/* Set the decade variable based on the comparisons by the Year variable */
if 1980 <= Year <= 1989 then Decade = "1980s";
else if 1990 <= Year <= 1999 then Decade = "1990s";
else if 2000 <= Year <= 2009 then Decade = "2000s";
else if 2010 <= Year <= 2019 then Decade = "2010s";
run;



/* Exercise 2(c) */

/* Use proc sql to group the data by Year, and calculate the Sum and Avg of each year */
proc sql;
create table yearlyimports_tluo4 as
select Year,  sum(Imports) format = dollar10.1 as YearTotal, avg(Imports) format = dollar10.1 as YearAvg
from data_by_year
group by Year;
quit;

/* Exercise 2(d) */
title "Exercise 2(d)";
proc contents data = yearlyimports_tluo4;
run;

/* Exercise 2(e) */
title "Exercise 2(e)";
proc print data = yearlyimports_tluo4;
run;

/* Exercise 2(f) */
title "Exercise 2(f)";

/* Use proc sql to build a new data with YearTotal, this time with Decade variable */
proc sql;
create table yearlyimports_with_decade as
select Year, Decade, sum(Imports) format = dollar10.1 as YearTotal
from data_by_year
group by Year;
quit;

/* Use proc sql to build a new data with the average of YearTotals and group them by decade */
proc sql;
create table decadeaverage as
select Decade , avg(YearTotal) format = dollar14.1 as DecadeAvg
from yearlyimports_with_decade
group by Decade;
quit;


/* Exercise 2(f) */
proc print data = decadeaverage;
run;






