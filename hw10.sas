/* Tianqi Luo */
/* HW10 Submission */

/* Remember to save this template file as HW10_YourNetID.sas */
/* You'll need to switch the following portion
             "~/my_courses/dunger_sas/hw10" access=readonly
   to 
             "C:\440\hw10";
   before making your final submission. */
  

libname hw10 "C:\440\hw10";

/* Exercise 1 */

/* Exercise 1(a) */
title "Exercise 1(a)";

/* Read the data using datalines */
/* Do a double do loop with i and j */
data mostmoney_tluo4 (drop = i j);
input option $ yearly_deposit: dollar8. annual_interest_rate: percent8.2 compound_frequency: $10. times_per_year;
infile datalines delimiter = ',';
total_25_years_later = 0;
do i = 1 to 25; /* Increment i with each year */
total_25_years_later +yearly_deposit;
do j = 1 to times_per_year; /* Increment j with compound frequency of each year */
total_25_years_later + (total_25_years_later * annual_interest_rate/times_per_year);
end;
end;
format total_25_years_later dollar20.3
       yearly_deposit dollar6.
       annual_interest_rate percent8.2;
       
label option = 'Option'
      yearly_deposit = 'Yearly Deposit'
      annual_interest_rate = 'Annual Interest Rate'
      compound_frequency = 'Compound Frequency'
      times_per_year = 'Times per Year'
      total_25_years_later = 'Total after 25 years';
datalines; /* Write the datalines */
A, $1000, 8.00%, Yearly, 1
B, $1700, 4.00%, Quarterly, 4
C, $1900, 3.00%, Quarterly, 4
D, $2300, 2.50%, Monthly, 12
E, $2500, 1.25%, Monthly, 12
F, $2700, 1.00%, Weekly, 52
;
run;



/* Exercise 1(b) */
title "Exercise 1(b)";
proc print data = mostmoney_tluo4 label;
run;



/* Exercise 1(c) */
title "Exercise 1(c)";
/* Do a double do loops with i and j */
data save30k_tluo4 (drop = i j);
input option $ yearly_deposit: dollar8. annual_interest_rate: percent8.2 compound_frequency: $10. times_per_year;
infile datalines delimiter = ',';
total_amount = 0;
years_left = 0;
do i = 1 to 25 until (total_amount > = 30000); /* Increment i with all the year until total_amount surpasses 30000 */
total_amount +yearly_deposit;
years_left + 1; 
do j = 1 to times_per_year; /* Increment j with the compounded times each year */
total_amount + (total_amount * annual_interest_rate/times_per_year);
end;
end;
format total_amount dollar20.3;
drop yearly_deposit annual_interest_rate compound_frequency times_per_year;
label total_amount = "Amount"
      option = "Option"
      years_left = "Years until $30K";
datalines; /* Write the datalines */
A, $1000, 8.00%, Yearly, 1
B, $1700, 4.00%, Quarterly, 4
C, $1900, 3.00%, Quarterly, 4
D, $2300, 2.50%, Monthly, 12
E, $2500, 1.25%, Monthly, 12
F, $2700, 1.00%, Weekly, 52
;
run;


/* Exercise 1(d) */
title "Exercise 1(d)";
proc print data = save30k_tluo4 label;
run;

/* Exercise 2 */ 

/* Exercise 2(a) */
title "Exercise 2(a)";
data chicago;
infile 'C:\440\hw10\chicago_avg_temps 12-16.txt';
input Temp @@; /* Use @@ to keep reading the data until it finishes the entire row */
run;

/* Use a do loop to set up all the dates */
data date(drop=i date0 date1 y);
date0 = '1JAN2012'd;  /* Set date0 as the first date */
do y = 0;  /* Set y = 0 to increment the dates, with one date per row */
date1 = intnx("YEAR",date0,y,'s');
do i = 0 to 1735; /* Set the do loop with the i from 0 to 1735 to increment the date from date0 to the 1756th date */
Weekday = intnx("DAY", date0, i);
Date = intnx("DAY",date1,i);
output;
end;
end;
format Date worddate.;
format Weekday weekdate9.;  /* Set the formats for Date and Weekday for the desired outputs */
run;

/* Merge the two data */
data chicago_tluo4;
merge chicago date;
run;



/* Exercise 2(b) */
title "Exercise 2(b)";
proc print data = chicago_tluo4;
where '1APR2016'd <= Date <= '30APR2016'd; /* Use where statement to select the April portion */
run;



/* Exercise 2(c) */
title "Exercise 2(c)";
data hotdays_tluo4;
infile 'C:\440\hw10\hourly_temps.txt';
/* Use a do loop to set up a loop for day and hour, with day ranging from 1 to 2 and Hour from 1 to 24 */
do Day = 1 to 2;
do Hour = 1 to 24;
input Temp @@; /*Use @@ to keep reading the lines */
output;
end;
end;
run;



/* Exercise 2(d) */
/* Use proc means to print out the data, only print out noobs, median, mean, standard deviation */
/* Set it to 3 decimals */
title "Exercise 2(d)";
proc means data = hotdays_tluo4 n median mean std maxdec = 3; 
class Day;
var Temp;
run;
















